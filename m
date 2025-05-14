Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041C6C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFKI6-0001rk-1M; Wed, 14 May 2025 18:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFKI4-0001oz-7n
 for qemu-devel@nongnu.org; Wed, 14 May 2025 18:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFKI2-0001o7-Ee
 for qemu-devel@nongnu.org; Wed, 14 May 2025 18:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747260565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7kewLgeOc4r/UNXZtcdTrRla51mHw8civBNuL47kL00=;
 b=bFurbidhDVxAhUSdFICKPLOQWA8DmmvLUXoJwxY8sxZXYQdQp8/XThTiMNCMa1aT/vigrZ
 UWCzql52RhbUYA8/1C15zCGwxvKsLZdF7BThNqtJULq2agj3BDEdY+awZG/hobRYyP4kG0
 Eu2iky/I65/bsJsht60IQ3pCHmAaHO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-CU4CWMcAPJypVF81RT6Gdg-1; Wed,
 14 May 2025 18:09:22 -0400
X-MC-Unique: CU4CWMcAPJypVF81RT6Gdg-1
X-Mimecast-MFC-AGG-ID: CU4CWMcAPJypVF81RT6Gdg_1747260561
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3FC81800446; Wed, 14 May 2025 22:09:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.66])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 906ED19560B4; Wed, 14 May 2025 22:09:17 +0000 (UTC)
Date: Wed, 14 May 2025 17:09:14 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com, 
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 09/13] mirror: Drop redundant zero_target parameter
Message-ID: <2xpsd2wwy5zxictj3lty67xx4l36qpn7mhfg3jcmvmhmv7q2jb@vrjlivmanxwm>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-24-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 09, 2025 at 03:40:26PM -0500, Eric Blake wrote:
> The two callers to a mirror job (drive-mirror and blockdev-mirror) set
> zero_target precisely when sync mode == FULL, with the one exception
> that drive-mirror skips zeroing the target if it was newly created and
> reads as zero.  But given the previous patch, that exception is
> equally captured by target_is_zero.  And since we recently updated
> things to pass the sync mode all the way through to
> mirror_dirty_init(), we can now reconstruct the same conditionals
> without the redundant parameter.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> v4: new patch

I was about to send the pull request, and noticed that this patch
reliably makes iotest 185 fail:

 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "mirror", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
---- Writing data to the virtio-blk device ---
...
-*** done
+Timeout waiting for event BLOCK_JOB_READY on handle 5
Failures: 185


Investigating now...


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


