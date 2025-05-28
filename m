Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B59C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFk3-00060o-15; Wed, 28 May 2025 08:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKFjk-0005y3-7f
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKFji-0004GW-3U
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748434700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qj9KEmirnuj+sZ6UtqJaXfrOYpemcFw1pKx7/jaLFSc=;
 b=DGSIu5xv8hGvTEkGATthhEGmdAr3+YaHtLTyPEGQooww2Ijo4dVtfk/nGbdO+WOTiznzxd
 jUjdjthrJwDg/13OYhNoeVjzlYkws7iJwPjo8YEmqtnDLtlXcrq8uVXQSs4uE6/nMr+UbK
 u32JBb0wvGC3k+AGWM08+KR5QLcDGyg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-GD3w6yFxP9Wsl1r1GurI3g-1; Wed,
 28 May 2025 08:18:19 -0400
X-MC-Unique: GD3w6yFxP9Wsl1r1GurI3g-1
X-Mimecast-MFC-AGG-ID: GD3w6yFxP9Wsl1r1GurI3g_1748434698
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9249F194510D; Wed, 28 May 2025 12:18:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A37230001B0; Wed, 28 May 2025 12:18:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F92421E675E; Wed, 28 May 2025 13:39:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
In-Reply-To: <20250515022904.575509-29-eblake@redhat.com> (Eric Blake's
 message of "Wed, 14 May 2025 21:28:56 -0500")
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
Date: Wed, 28 May 2025 13:39:25 +0200
Message-ID: <874ix5ezgy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

Eric Blake <eblake@redhat.com> writes:

> Prove that blockdev-mirror can now result in sparse raw destination
> files, regardless of whether the source is raw or qcow2.  By making
> this a separate test, it was possible to test effects of individual
> patches for the various pieces that all have to work together for a
> sparse mirror to be successful.
>
> Note that ./check -file produces different job lengths than ./check
> -qcow2 (the test uses a filter to normalize); that's because when
> deciding how much of the image to be mirrored, the code looks at how
> much of the source image was allocated (for qcow2, this is only the
> written clusters; for raw, it is the entire file).  But the important
> part is that the destination file ends up smaller than 3M, rather than
> the 20M it used to be before this patch series.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-ID: <20250509204341.3553601-28-eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Fails for me:

    TAP version 13
    # QEMU          -- "/work/armbru/qemu/bld/qemu-system-x86_64" -nodefaults -display none -accel qtest
    # QEMU_IMG      -- "/work/armbru/qemu/bld/qemu-img" 
    # QEMU_IO       -- "/work/armbru/qemu/bld/qemu-io" --cache writeback --aio threads -f qcow2
    # QEMU_NBD      -- "/work/armbru/qemu/bld/qemu-nbd" 
    # IMGFMT        -- qcow2
    # IMGPROTO      -- file
    # PLATFORM      -- Linux/x86_64 dusky 6.12.7-200.fc41.x86_64
    # TEST_DIR      -- /work/armbru/qemu/bld-x86/scratch
    # SOCK_DIR      -- /tmp/qemu-iotests-nqettsyq
    # GDB_OPTIONS   -- 
    # VALGRIND_QEMU -- 
    # PRINT_QEMU_OUTPUT -- 
    # 
    1..1
    # running qcow2 mirror-sparse
    not ok qcow2 mirror-sparse
    --- /work/armbru/qemu/tests/qemu-iotests/tests/mirror-sparse.out
    +++ /work/armbru/qemu/bld-x86/scratch/qcow2-file-mirror-sparse/mirror-sparse.out.bad
    @@ -140,7 +140,7 @@
     {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
     {"return": {}}
     Images are identical.
    -Destination is sparse; expected sparse
    +Destination is unknown; expected sparse

     === Testing creation=off discard=unmap zeroes=off ===

    @@ -184,7 +184,7 @@
     {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
     {"return": {}}
     Images are identical.
    -Destination is sparse; expected sparse
    +Destination is unknown; expected sparse

     === Testing creation=off discard=unmap zeroes=unmap ===


