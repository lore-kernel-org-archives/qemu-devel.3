Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E8C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJZb-0006ta-Vs; Wed, 28 May 2025 12:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKJZZ-0006t0-JJ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKJZW-0004uO-QR
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748449444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PqbnN0Q3vSeoPQSqwZIDRn5l52MArqNC2zFxu7GI4Ac=;
 b=R9pBmkh/P5+rflmO0hR5+/XSrTuQ3QA43/pTbO56FCunvcPdT1rWOffb9pgyMMqCBBO3gX
 ow42Dr8S3/Qefh2rForGd69ONIDXvgk49fmpBK3KeO+yXL9cpfpKyA9QOi+6iQPm7V/Oc5
 I/+N/ToLvNXrqqYbQJ4UAr73iGjWPzE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-fxM9oZTmOAiLQUvrefIK6Q-1; Wed,
 28 May 2025 12:24:02 -0400
X-MC-Unique: fxM9oZTmOAiLQUvrefIK6Q-1
X-Mimecast-MFC-AGG-ID: fxM9oZTmOAiLQUvrefIK6Q_1748449442
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6B4B1800873; Wed, 28 May 2025 16:24:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 705F51956095; Wed, 28 May 2025 16:24:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B215A21E6757; Wed, 28 May 2025 18:23:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  "open
 list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
In-Reply-To: <5o7qspgmmjktoah6yoq5zp4uemhyultohiswqwvib7dqbh53ez@2ctslprvuxxx>
 (Eric Blake's message of "Wed, 28 May 2025 10:40:07 -0500")
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <874ix5ezgy.fsf@pond.sub.org>
 <5o7qspgmmjktoah6yoq5zp4uemhyultohiswqwvib7dqbh53ez@2ctslprvuxxx>
Date: Wed, 28 May 2025 18:23:58 +0200
Message-ID: <87plfsya8x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On Wed, May 28, 2025 at 01:39:25PM +0200, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>> > Prove that blockdev-mirror can now result in sparse raw destination
>> > files, regardless of whether the source is raw or qcow2.  By making
>> > this a separate test, it was possible to test effects of individual
>> > patches for the various pieces that all have to work together for a
>> > sparse mirror to be successful.
>> >
>
>> Fails for me:
>> 
>>     TAP version 13
>>     # QEMU          -- "/work/armbru/qemu/bld/qemu-system-x86_64" -nodefaults -display none -accel qtest
>>     # QEMU_IMG      -- "/work/armbru/qemu/bld/qemu-img" 
>>     # QEMU_IO       -- "/work/armbru/qemu/bld/qemu-io" --cache writeback --aio threads -f qcow2
>>     # QEMU_NBD      -- "/work/armbru/qemu/bld/qemu-nbd" 
>>     # IMGFMT        -- qcow2
>>     # IMGPROTO      -- file
>>     # PLATFORM      -- Linux/x86_64 dusky 6.12.7-200.fc41.x86_64
>>     # TEST_DIR      -- /work/armbru/qemu/bld-x86/scratch
>
> Which filesystem is TEST_DIR on?

$ findmnt --target /work/armbru/qemu/bld-x86/scratch
TARGET SOURCE                                     FSTYPE OPTIONS
/work  /dev/mapper/luks-898519e7-f64e-4a69-8cf9-8532063d8bb9
                                                  xfs    rw,relatime,seclabel,at

[...]


