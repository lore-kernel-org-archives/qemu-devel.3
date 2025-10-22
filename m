Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AB4CCD193
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 00:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC5qC-0003E5-LL; Thu, 23 Oct 2025 20:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vC4nz-0001iC-4h; Thu, 23 Oct 2025 19:33:15 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vC4nt-000218-K6; Thu, 23 Oct 2025 19:33:13 -0400
DKIM-Signature: a=rsa-sha256; bh=AcXEnY0YmRHED/7Z4bIgl6aD2DbyZU0eJ0H0wjefJZ8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1761262385; v=1;
 b=IxMU7sEHwRbCQTn+nNeT4dIOdwbm1eBsPe4vponz8hrZELCzC1Fgay9zdgh+Q+IY8AbHwwlr
 jtibdKPPTJ2vf3QYN4j4snhwnHrAK7AomqslTCzCwa99FXj7aSPeqffcyJ7P43pcKxwuQx/pF8N
 D5A9QoeWqn21uYfwmgSQvdPgw5D82Zj8jLTrGVyETkCU1IcaZcd1+l0aDaR+rtdejtFQ6BdlubF
 zjWVoH/W4GrKykCHEggF+t+xg/m9kDk62g5HuQ6EeFYXX0KN6WEluPuE6nL7kPN+vsLVvrroD/z
 6ppPxNVz3aTQEfdCvwt4SkcPOPBBjkqEPdjSJCvoW0w3g==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 3CDAF23DD6;
 Thu, 23 Oct 2025 23:33:05 +0000 (UTC)
From: ~abombo <abombo@git.sr.ht>
Date: Wed, 22 Oct 2025 10:55:01 -0500
Subject: [PATCH qemu 1/1] block: Don't regress when prep_writev2 isn't present
MIME-Version: 1.0
Message-ID: <176126238504.17752.8775213803155377166-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <176126238504.17752.8775213803155377166-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, Julia Suvorova <jusual@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano =?utf-8?q?Fid=C3=AAncio?= <fabiano@fidencio.org>,
 abombo@microsoft.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 20:39:31 -0400
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
Reply-To: ~abombo <abombox@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aur=C3=A9lien Bombo <abombo@microsoft.com>

984a32f17e8d introduced support for prep_writev2 as released in liburing 2.2
and libaio 0.3.111. However, it also broke users of older versions of these
libraries (without prep_writev2) who relied on flags being no-op, so we remove
the check on flags.

Fixes: 984a32f17e8d

Signed-off-by: Aur=C3=A9lien Bombo <abombo@microsoft.com>
---
 block/io_uring.c  | 1 -
 block/linux-aio.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index dd4f304910..b44edcd7a4 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -349,7 +349,6 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb=
, LuringState *s,
                               luringcb->qiov->niov, offset, luring_flags);
     }
 #else
-        assert(flags =3D=3D 0);
         io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
                              luringcb->qiov->niov, offset);
 #endif
diff --git a/block/linux-aio.c b/block/linux-aio.c
index c200e7ad20..1aa65cf09b 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -383,7 +383,6 @@ static int laio_do_submit(int fd, struct qemu_laiocb *lai=
ocb, off_t offset,
         io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flag=
s);
     }
 #else
-        assert(flags =3D=3D 0);
         io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
 #endif
         break;
--=20
2.49.1

