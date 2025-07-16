Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CE2C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucAVS-0007Ee-9X; Wed, 16 Jul 2025 18:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1ucA8O-000858-Td; Wed, 16 Jul 2025 17:57:53 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1ucA8M-0002ER-5v; Wed, 16 Jul 2025 17:57:52 -0400
DKIM-Signature: a=rsa-sha256; bh=Dao29EJjjBOlo4oHPBJ6YArZt4cbue4HuSvnNUCfFU8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1752703065; v=1;
 b=cVKINOKpYYorzpualq6vKP5YmASd3ehlavdDwx0Kd/GBhsdx+kmT/iV1yzE+ci0AgjcvMX9l
 ehgTmAPTCAMFlWNN3PFVHBTNSkQ8c8R0pGGBp++yKlwoy6iobQiWTAHZj7vw9cVpQPh8+95jes2
 pi+qfGPSE53VVjgiujZGveNLsEEwU7Yon8gOnlz3Xm8brDP1pjmr9wggxNHBmB7q5e/pq973OiO
 qd0LkilUcIbKgIm2GyZ/FuRfwTAQ718T7J5BW1zorjhG1DZyEdVQUh2o4iOztrSrGHEhyjlIZrr
 v6z8wixdDTqyAcpeirPR9ZFduGDDjD/ML9YMjTYSkzeDA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 1C53B22641;
 Wed, 16 Jul 2025 21:57:45 +0000 (UTC)
From: ~wojtekka <wojtekka@git.sr.ht>
Date: Wed, 16 Jul 2025 21:57:45 +0000
Subject: [PATCH qemu 0/2] Add support for flat m68k binaries
MIME-Version: 1.0
Message-ID: <175270306503.19369.144677794735042916-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Jul 2025 18:20:18 -0400
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
Reply-To: ~wojtekka <wojtekka@toxygen.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Flat m68k binaries apparently don't work out of the box and those two
tiny patches fixed that for me. On top of that they didn't break
support for ARM flat binaries (tested with test_arm_bflt.py) nor m68k
ELF binaries (tested static busybox from Debian). Unfortunately
I wasn't able to find any root filesystem for m68k uClinux so I didn't
prepare any test similar to test_arm_bflt.py.

Wojtek Kaniewski (2):
  Don't reverse bFLT endianess when not needed
  Fill out m68k PIC register

 linux-user/elfload.c  | 1 +
 linux-user/flatload.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.45.3

