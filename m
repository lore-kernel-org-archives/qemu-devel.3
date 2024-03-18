Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346C0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBSc-0005sQ-8k; Mon, 18 Mar 2024 07:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBSY-0005ru-Sb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBSW-0001V4-3A
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710762434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Y5+sUh8mt96EMkWt5D5MUpETfKazlsNBxkcDUAndLk=;
 b=Yo8px8VsC5LDNNEzdZ8SzKeXePnwcfilJnVnY80//yPU/yincB5M4bY02G0GsIk7sPxe+b
 exk7ISdsLpRNkQ9xdY/QcIoqYICaDux++gT3s8Fy+ovWA0SXANQqifQHtISmxrfgvozF5o
 29rbpX/ceKa+Vgm8/qLFH/4DgkAchVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-s_lpF8udOayE5Q4DNcllEw-1; Mon, 18 Mar 2024 07:47:11 -0400
X-MC-Unique: s_lpF8udOayE5Q4DNcllEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBB921875044;
 Mon, 18 Mar 2024 11:47:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7124200B3BD;
 Mon, 18 Mar 2024 11:47:09 +0000 (UTC)
Date: Mon, 18 Mar 2024 12:47:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] blockdev: Fix blockdev-snapshot-sync error reporting for
 no medium
Message-ID: <ZfgpuMp7K-mGpZ_B@redhat.com>
References: <20240306142831.2514431-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306142831.2514431-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 06.03.2024 um 15:28 hat Markus Armbruster geschrieben:
> When external_snapshot_abort() rejects a BlockDriverState without a
> medium, it creates an error like this:
> 
>         error_setg(errp, "Device '%s' has no medium", device);
> 
> Trouble is @device can be null.  My system formats null as "(null)",
> but other systems might crash.  Reproducer:
> 
> 1. Create a block device without a medium
> 
>     -> {"execute": "blockdev-add", "arguments": {"driver": "host_cdrom", "node-name": "blk0", "filename": "/dev/sr0"}}
>     <- {"return": {}}
> 
> 3. Attempt to snapshot it
> 
>     -> {"execute":"blockdev-snapshot-sync", "arguments": { "node-name": "blk0", "snapshot-file":"/tmp/foo.qcow2","format":"qcow2"}}
>     <- {"error": {"class": "GenericError", "desc": "Device '(null)' has no medium"}}
> 
> Broken when commit 0901f67ecdb made @device optional.
> 
> Use bdrv_get_device_or_node_name() instead.  Now it fails as it
> should:
> 
>     <- {"error": {"class": "GenericError", "desc": "Device 'blk0' has no medium"}}
> 
> Fixes: 0901f67ecdb7 (qmp: Allow to take external snapshots on bs graphs node.)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks, applied to the block branch.

Kevin


