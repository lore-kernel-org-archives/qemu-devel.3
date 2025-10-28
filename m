Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D32BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjGW-0004dF-OX; Tue, 28 Oct 2025 08:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bblank@thinkmo.de>) id 1vDicq-0000fa-9x
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:16:36 -0400
Received: from s3.thinkmo.de ([162.55.237.202] helo=mail.thinkmo.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bblank@thinkmo.de>) id 1vDici-0002OL-RN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:16:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.thinkmo.de (Postfix) with ESMTP id 4cwq9B2dl5zyX0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thinkmo.de; h=
 content-disposition:content-type:content-type:mime-version
 :message-id:subject:subject:from:from:date:date:received
 :received; s=mail202312; t=1761653774; bh=cNJwD7Q9h8FYeMZC097VuU
 VFJXrHsHW8/hH972sR1qo=; b=h1yAIZbumnm1TG7p14FzBdbQIS9BjOyc3zo16v
 XG1reTbWNpU1g2re/NJLNed1cFphnWHh/Vdigtwm3JImwr1u0F0HyNq22FFF/BoV
 t/MerMJmhbrSwzeyMrFnc6fsfRXqbSu54rqtkT9Ubv+uC3DntaOuUGVQyRIhFGsz
 IuHx1DcVuK+WWU+EYkx7CPjCOCKg9v+ZXUBQjO8EWMfxt32PZzkg/dmmAeHM73jo
 OAxc91ag/XNHVo2851Z4ToTAsuuIB9M4ZbqHgUCBdmioK4nc9UJDJUCLLW8YEnBD
 G5V+Xs982v1JbL5Oxt51GqR43WNFwvJwslMJVOS9JrhGVzqw==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cglhLUPdbEKz for <qemu-devel@nongnu.org>;
 Tue, 28 Oct 2025 12:16:14 +0000 (UTC)
Received: from steamhammer.waldi.eu.org (unknown
 [IPv6:2a02:8071:5af1:6518:893d:4418:d27e:21b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (No client certificate requested)
 by mail.thinkmo.de (Postfix) with ESMTPSA id 4cwq9B1cYYzyV1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 12:16:14 +0000 (UTC)
Date: Tue, 28 Oct 2025 13:16:12 +0100
From: Bastian Blank <bblank@thinkmo.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: Use correct type for FIBMAP and FIGETBSZ
 emulation
Message-ID: <l6slswtmabktu6g23so3sldafschilwbp3kqolny3lppjezosi@hn6ptmklek4q>
Mail-Followup-To: Bastian Blank <bblank@thinkmo.de>, qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=162.55.237.202; envelope-from=bblank@thinkmo.de;
 helo=mail.thinkmo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Oct 2025 08:57:30 -0400
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

Both the FIBMAP and FIGETBSZ ioctl get "int *" (pointer to 32bit
integer) as argument, not "long *" as specified in qemu.  Using the
correct type makes the emulation work in cross endian context.

Both ioctl does not seem to be documented. However the kernel
implementation has always used "int *".

Signed-off-by: Bastian Blank <waldi@debian.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
---
 linux-user/ioctls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3b41128..2f62fd2 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -130,7 +130,7 @@
      IOCTL(FDTWADDLE, 0, TYPE_NULL)
      IOCTL(FDEJECT, 0, TYPE_NULL)
 
-     IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
+     IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_INT))
 #ifdef FICLONE
      IOCTL(FICLONE, IOC_W, TYPE_INT)
      IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
@@ -145,7 +145,7 @@
      IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))
 #endif
 
-     IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
+     IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_INT))
 #ifdef CONFIG_FIEMAP
      IOCTL_SPECIAL(FS_IOC_FIEMAP, IOC_W | IOC_R, do_ioctl_fs_ioc_fiemap,
                    MK_PTR(MK_STRUCT(STRUCT_fiemap)))
-- 
2.51.0

