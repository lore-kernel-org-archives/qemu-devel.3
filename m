Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 00:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC5q7-0003DZ-Hh; Thu, 23 Oct 2025 20:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vC4nz-0001iD-4e; Thu, 23 Oct 2025 19:33:15 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vC4nt-000217-KV; Thu, 23 Oct 2025 19:33:13 -0400
DKIM-Signature: a=rsa-sha256; bh=V1NUnK1H0T/1fP7HD3pdPt8Oji8eYJQ12LiDYAXj95Q=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1761262385; v=1;
 b=qWW3JiNuUFoUkxKKF0fRA27Bg/CUdV+cup6LdzowpKjD4H7Er3sTEAgXUVWfNcvAQ/zxYrlF
 yr8ux7okIGWYSB/mNOA1S/ATvrv+KhtM3EFASVev+Vl+yIkJnihgkgJsObsgSqfLFsh/ihOixXS
 7Uv+KAfJRZAD3HTGweOCQnuRNDp+8ATE8ta6CL9AeJE+TXs2V8+DNfyEKM3b3txq2/5Ypm5XSax
 fMpN7DKJ/Ke2QCS4ZjKHq6OEcCpK1rwVIp3+8pAyhNJGvnGN7JXbiPzq88WQKfWL8pl/osgLsmF
 q2GGbq8wiPINl6ldl048kN4dOD6pBG6S4KsS1EMwi/Daw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 1CE0523DD4;
 Thu, 23 Oct 2025 23:33:05 +0000 (UTC)
From: ~abombo <abombo@git.sr.ht>
Date: Thu, 23 Oct 2025 23:33:05 +0000
MIME-Version: 1.0
Subject: [PATCH qemu 0/1] block: Fix regression introduced with prep_writev2
 support
Message-ID: <176126238504.17752.8775213803155377166-0@git.sr.ht>
X-Mailer: git.sr.ht
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
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 20:39:30 -0400
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

Hi folks,

This is my first contribution to QEMU so please bear with me. :-)

I'm raising this because Kata Containers recently upgraded from QEMU 9
to 10 and it turns out this broke virtio-blk for the project [1].

The issue is that when QEMU introduced support for prep_writev2, it also
started enforcing flags be unset when using prep_write.  However, this
breaks on systems where prep_writev2 isn't present and the prep_write
branch is taken (e.g. Ubuntu 22.04 with liburing 2.1 in Kata), as the
flags aren't necessarily empty there, and the assertion is violated.

We patched Kata by upgrading liburing [2] but I thought others might
benefit from patching QEMU.

[1] https://github.com/kata-containers/kata-containers/issues/11686
[2] https://github.com/kata-containers/kata-containers/pull/11918

Aur=C3=A9lien Bombo (1):
  block: Don't regress when prep_writev2 isn't present

 block/io_uring.c  | 1 -
 block/linux-aio.c | 1 -
 2 files changed, 2 deletions(-)

--=20
2.49.1

