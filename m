Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE4CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIV7-00038e-VG; Wed, 14 May 2025 16:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFIV4-00033A-OE
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFIV3-000561-0l
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747253682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B25hWwQ2FXe+prr5lhzW0+AT3Id9bjRPakKuEOIPuhw=;
 b=Jz8UYYurejNmFV9xku+9RSbZR6EqQtUvgQcxjDBSivjWfEZjYYTz1GDqK3xMQuo6qF34fN
 NDAoJwK8uFAgNiN0mKuI2YhGAuq0f0UWWW4QLUWTT+Ki1umS1HAtx1qwFNUFgBnxNdlfsh
 vfZ0OC9seP5i2tOekRTH63R1KFa0mtw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-nXApX167O0yg7_OoOZeYGA-1; Wed,
 14 May 2025 16:14:41 -0400
X-MC-Unique: nXApX167O0yg7_OoOZeYGA-1
X-Mimecast-MFC-AGG-ID: nXApX167O0yg7_OoOZeYGA_1747253680
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B418180035E; Wed, 14 May 2025 20:14:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E12519560A7; Wed, 14 May 2025 20:14:35 +0000 (UTC)
Date: Wed, 14 May 2025 22:14:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 11/11] iotests/graph-changes-while-io: add test case with
 removal of lower snapshot
Message-ID: <aCT5qBpapIJUHQ9K@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-12-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-12-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> This case is catching potential deadlock which takes place when job-dismiss
> is issued when I/O requests are processed in a separate iothread.
> 
> See https://mail.gnu.org/archive/html/qemu-devel/2025-04/msg04421.html
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Keeping Andrey in From: is fine, but it does need your S-o-b if you
submit the patch.

> diff --git a/tests/qemu-iotests/tests/graph-changes-while-io b/tests/qemu-iotests/tests/graph-changes-while-io
> index 194fda500e..e30f823da4 100755
> --- a/tests/qemu-iotests/tests/graph-changes-while-io
> +++ b/tests/qemu-iotests/tests/graph-changes-while-io
> @@ -27,6 +27,8 @@ from iotests import imgfmt, qemu_img, qemu_img_create, qemu_io, \
>  
>  
>  top = os.path.join(iotests.test_dir, 'top.img')
> +snap1 = os.path.join(iotests.test_dir, 'snap1.img')
> +snap2 = os.path.join(iotests.test_dir, 'snap2.img')
>  nbd_sock = os.path.join(iotests.sock_dir, 'nbd.sock')

top could be reused for snap2, it serves the same purpose in the
existing tests. Maybe mid for snap1 would make more sense then.

The only other problem I can see is that the test forgets to remove the
overlay image files (preexisting for top).

It did reproduce the problem on the first attempt, though, so:
Tested-by: Kevin Wolf <kwolf@redhat.com>


