Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F26FCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxVm-0006ep-SZ; Wed, 30 Sep 2026 12:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVQ-0006Mn-Mu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:09 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVO-0003V3-1Z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:08 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so31675755e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787005; x=1791391805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=02pJqpidZlyztGLDO4CVTQG7JLwu5zrLatcXjsrC0zQ=;
 b=dOA++NWcMhhSy46omblgXhP4XGLNAcfVoRDKvupiiJuU4DXTaYlVu9/zSdfBMWEw18
 gJrIDvXPsvKqsA0+9jjuF0vtkgEwdLrLehOHnrCmrWLl69o7iXdwLKRR63caXVNFJOR5
 8psEJ/FNQcRxmsj4myx+em+RDM2T/Ey0zuQHO/WCl2re6cf6tkqkjiXWdyP9l7QPuV9b
 YfS+hsx67P5W+SXZF0Y7sYoRD8RNZvGRlyXoiK8BQk0/Pjg8UWDTAUSVY1PmgnnaU7sK
 qNmL+LXE8IR5LPelgl0u2nZ8mM/b4sV6WqrRQTdVSG3Lw9IVjs2pWFSXIv0fQ9a7FGv3
 mZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787005; x=1791391805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=02pJqpidZlyztGLDO4CVTQG7JLwu5zrLatcXjsrC0zQ=;
 b=pgskBuAPHvZa/sd4Pa9hwzdOXLGBV4IUNc9KouzlSX1fDfUbPkwLGH/Wei9oYExOXW
 +SkVEU0aPJBPLaHxhkALeOxWoQW8k0p/mpuwy92sZoAdv9L/h8NSaPNMkUknxpCc0QJf
 fL5Yfrj9l177TlHjz7Ty9U3BF98UC3UktNpjq83DsiBer0pghn5ahUf+3ih7fdngE4bm
 1n4omG3j2eOT+gwRMAqUfECBsV/VqKrf/vvAAQD3PTRxH5NTQJoOabh+JD116oiX50wQ
 bvj8nBRl6JgSfN/eNNza95Cgh5GcKhz3lZQrnEKiliwfoVGFstlhbc1O6AM0NtIyzkIb
 3m6A==
X-Gm-Message-State: AFuF++n9Pg7XXzv9KhxQ/34ZGB1rvlt2dAhL23oFPKvo1aQkOBQZMdBt
 hdbMiptcZHVl0PU9hgR5GzAxI5LYTk+XY3KbySzdFuKtORMuVkKpPNSsYrYpv6nUH7pkMVqSXJU
 +Dg78
X-Gm-Gg: AYBFou3puGSaeEp0XaJpty/nBKmvaJlBk+nIvAoVPOqKYBewCo8B3K4cxgC+1HGrzU9
 S1hvsLjY+tUxZt6q/GpsGI3cOgxNJ6nNiTFJ3Z28j1y5RJIp+64m0/+SolB+oEVSXR+CfxsKnKZ
 bR+NqrbKg9tgyN7/SISSS1t3nHixWyolCeTpoypSqeQ1U3lK6OFVO9AE74lG1+mRr1GXr6/FMK5
 TDD+NBzAiIr968BE3zBsgA4DmhDlqB9RnJSUSnfkZbVePjBc6WyPOtDf/x53+zQqFA8ey4lZclP
 /KDZf6twk7/upM/zUt0oAA8wij2idrAGXmHwBdRDHrXP+nEuBrGTbxZUShkHnaINBNyLitZS+vr
 v3EK0lBSoiAoX4ZBKXX5u+IMIooFudrzGDzQMIDm74nZKUStEaMypLf5NMZtxpa0df7jsP34ceY
 UbeJRbrta1KPKQEz9LOdVFxBQWzW54EaSFkbWNenxdVDjLg0u6t3uiFucKEYn2dWRcPfk=
X-Received: by 2002:a05:600c:8b88:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4a01b12b389mr33017365e9.30.1790787004646; 
 Wed, 30 Sep 2026 09:50:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 01/13] block/file-posix: drop the XFS workaround for post-EOF
 fallocate
Date: Wed, 30 Sep 2026 18:49:47 +0200
Message-ID: <20260930165000.303236-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

292d06b925b extended the tracked request of a post-EOF write zeroes to
infinity and made it serialising, to work around an XFS bug where AIO
writes past EOF were discarded by a concurrently extending fallocate().

The kernel bug was fixed by 249bd9087a52 ("xfs: properly serialise
fallocate against AIO+DIO"), which moves inode_dio_wait() up under
IOLOCK_EXCL so fallocate cannot run alongside in-flight AIO. That
landed in v5.5, three days before the workaround was committed here,
and predates every stable series still maintained.

The workaround runs on every filesystem and on every write zeroes past
EOF, which for the preallocate filter is every preallocation. It widens
the request to the end of the address space and makes it serialising,
so it excludes every other request above its offset, and it does that
after bdrv_co_write_req_prepare() has honoured BDRV_REQ_NO_WAIT, so the
flag no longer holds for the rest of the request.

Drop it. The only series that never took the kernel fix is 4.19.y,
which is end of life.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: qemu-stable@nongnu.org
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/file-posix.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9aad156aad..529e302041 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3658,40 +3658,6 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     RawPosixAIOData acb;
     ThreadPoolFunc *handler;
 
-#ifdef CONFIG_FALLOCATE
-    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
-        BdrvTrackedRequest *req;
-
-        /*
-         * This is a workaround for a bug in the Linux XFS driver,
-         * where writes submitted through the AIO interface will be
-         * discarded if they happen beyond a concurrently running
-         * fallocate() that increases the file length (i.e., both the
-         * write and the fallocate() happen beyond the EOF).
-         *
-         * To work around it, we extend the tracked request for this
-         * zero write until INT64_MAX (effectively infinity), and mark
-         * it as serializing.
-         *
-         * We have to enable this workaround for all filesystems and
-         * AIO modes (not just XFS with aio=native), because for
-         * remote filesystems we do not know the host configuration.
-         */
-
-        req = bdrv_co_get_self_request(bs);
-        assert(req);
-        assert(req->type == BDRV_TRACKED_WRITE);
-        assert(req->offset <= offset);
-        assert(req->offset + req->bytes >= offset + bytes);
-
-        req->bytes = BDRV_MAX_LENGTH - req->offset;
-
-        bdrv_check_request(req->offset, req->bytes, &error_abort);
-
-        bdrv_make_request_serialising(req, bs->bl.request_alignment);
-    }
-#endif
-
     acb = (RawPosixAIOData) {
         .bs             = bs,
         .aio_fildes     = s->fd,
-- 
2.53.0


