Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F3CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 06:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKVSm-0001fM-P3; Wed, 06 May 2026 02:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKVSl-0001db-2i
 for qemu-devel@nongnu.org; Wed, 06 May 2026 02:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKVSi-00085x-Cn
 for qemu-devel@nongnu.org; Wed, 06 May 2026 02:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778047822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPAQKg3vLviuOPJzBae8eTiC8sPPcl1KUgt7wPaiqh4=;
 b=hzvq5Y25mA8DstYwpGElj/BG36AXQhN880z3ttOZ0XtHDgL9AAocqW/JwnKdyNGAJSH9b8
 UbhSKs+c2e9MJLl+rqLcHbJh6qpjYNE95YHDy+pBxFvNWTax12bYZJiVhPHKGKulPuQLyc
 FtGH/eOWKNpvt4GTc21QHAgnXzDkpt8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-OhAB2KUxPxy0gQzKsHINOg-1; Wed,
 06 May 2026 02:10:20 -0400
X-MC-Unique: OhAB2KUxPxy0gQzKsHINOg-1
X-Mimecast-MFC-AGG-ID: OhAB2KUxPxy0gQzKsHINOg_1778047819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB8B2195606F; Wed,  6 May 2026 06:10:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D038180034E; Wed,  6 May 2026 06:10:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78C0D21E6A01; Wed, 06 May 2026 08:10:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mr-083 <matthieu@minio.io>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  its@irrelevant.dk,  kbusch@kernel.org,
 berrange@redhat.com,  mr-083 <matthieu@min.io>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH] block: add blockdev-attach QMP command
In-Reply-To: <20260423162927.GA529033@fedora> (Stefan Hajnoczi's message of
 "Thu, 23 Apr 2026 12:29:27 -0400")
References: <20260415173905.71224-1-matthieu@min.io>
 <20260423162927.GA529033@fedora>
Date: Wed, 06 May 2026 08:10:15 +0200
Message-ID: <877bphf4qg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Apr 15, 2026 at 07:39:05PM +0200, mr-083 wrote:
>> Add a blockdev-attach QMP command that attaches a block driver state
>> tree to a device's block backend.  Unlike blockdev-insert-medium, this
>> works for non-removable devices such as NVMe namespaces.
>> 
>> After drive_del removes a device's backing store, the BlockBackend
>> remains attached to the guest device but has no BlockDriverState.
>> blockdev-attach reconnects a block node (previously created with
>> blockdev-add) to the device's BlockBackend via blk_insert_bs().
>> 
>> This separates the two concerns as recommended: blockdev-add creates
>> the block node, blockdev-attach associates it with the device.
>> 
>> Example usage with NVMe namespace hot-swap:
>>   drive_del drv0
>>   blockdev-add node-name=node0 driver=qcow2 file.driver=file \
>>                file.filename=disk.qcow2
>>   blockdev-attach id=ns0 node-name=node0
>
> Hi Matthieu,
> I came across a quirk here:
>
>   $ qemu-system-x86_64 \
>       --blockdev file,filename=my-lun.img,node-name=drive1 \
>       --device nvme,serial=nvme0 \
>       --device nvme-ns,id=nvme-ns0,drive=drive1
>   (qemu) drive_del drive1
>   Error: drive drive1 is in use

I see "Error: Node drive1 is in use".

It's from qmp_blockdev_del():

    bs = bdrv_find_node(node_name);
    if (!bs) {
        error_setg(errp, "Failed to find node with node-name='%s'", node_name);
        return;
    }
    if (bdrv_has_blk(bs)) {
        error_setg(errp, "Node %s is in use", node_name);
        return;
    }

Called from hmp_drive_del():

    bs = bdrv_find_node(id);
    if (bs) {
        qmp_blockdev_del(id, &err);
        goto unlock;
    }

> But when I change --blockdev to --drive, it succeeds. I think this
> second scenario is the one that you have been testing.

I *guess* you changed it to something like

    -drive if=none,file=test.img,id=drive1

hmp_drive_del()'s call of bdrv_find_node() then fails, and we take a
completely different path, which succeeds:

    (qemu) info block
    drive1 (#block195): test.img (raw)
        Attached to:      nvme-ns0
        Cache mode:       writeback
    (qemu) drive_del drive1
    (qemu) info block
    nvme-ns0: [not inserted]
        Attached to:      nvme-ns0

This rips nvme-ns0's drive right off.  Feels *unsafe*: the frontend
(here: nvme-ns) may reasonably assume that a non-removable medium stays
put, use it without checking it's still there, and crash.

> I also tried the QMP blockdev-del command together with --blockdev, and
> it fails:
>
>   $ qemu-system-x86_64 ... \
>       -qmp unix:/tmp/qmp.sock,server=on,wait=off
>   $ qmp-shell /tmp/qmp.sock
>   (QEMU) blockdev-del node-name=drive1
>   {"error": {"class": "GenericError", "desc": "Node drive1 is in use"}}
>
> It seems logical that a disk image that's in use by NVMe emulation
> cannot be removed. So now I'm wondering if there is a bug or a
> historical reason why drive_del allows drives to the removed at runtime
> even when media change is not supported.
>
> CCing Kevin Wolf and Markus Amrbruster as they may know the answer.

I suspect this is simply a bug, and likely a regression.  Can you find
out?

> Depending on the answer this may influence the test workflow in this
> patch. It's unclear to me what is being tested here since this does not
> simulate a real error that a physical NVMe drive could raise?
>
> I think the intention is to fail I/O so a test can simulate a period
> where the drive is down. QEMU has the blkdebug driver which could be
> inserted into the block graph to fail I/O requests - maybe that is
> appropriate for your test and may not require new monitor commands (see
> blkdebug examples in tests/)?
>
> Stefan
>
>> 
>> An HMP wrapper is included for convenience.
>> 
>> Signed-off-by: Matthieu <matthieu@min.io>


