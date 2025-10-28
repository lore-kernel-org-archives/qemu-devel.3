Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7C8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhtD-000333-2y; Tue, 28 Oct 2025 07:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waldi@debian.org>) id 1vDht5-0002xD-Oo
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:29:16 -0400
Received: from s3.thinkmo.de ([162.55.237.202] helo=mail.thinkmo.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waldi@debian.org>) id 1vDht2-0003kl-40
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:29:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.thinkmo.de (Postfix) with ESMTP id 4cwp6l20xXzyX0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; h=
 content-disposition:content-type:content-type:mime-version
 :message-id:subject:subject:from:from:date:date:received
 :received; s=mail202007.waldi.user; t=1761650943; bh=ppjlAbF6kUU
 TQLURZt0fQAHILM89q/Q852oo15FeeDQ=; b=kcq+XPRLdre7fwKDMYBxpC2fcmX
 A+vpi86h04zMOg6MOGHp6d3o3fe5VdVo6DCWndI3C0mnZNJ6TAV27IhZJ5ctFYfC
 F5KEg3IyqbLyzWpAhw0TOAxR2CXMFpEyAdT5yqCl0ESbfrpyGKlQxtMBzjkijzn1
 DQtxs4jaIJz7IqZSFVitdIpsErQisT0X0Mhj628xhzn3nPi9O9L1X1gxw1QdvXCb
 govZ/Wbbo0TwacEPLVTW8n7ZUi/T4yPfRKl1j24hbgKS/FV7bUEuqXMtnNR7fIrO
 xjsrtl81HYo6nkqXKOGlMjzTf9mtU0HyHg6jEsHV3baGHeWR5gSBVU4WAQw==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ycl5Yc8jGqQ1 for <qemu-devel@nongnu.org>;
 Tue, 28 Oct 2025 11:29:03 +0000 (UTC)
Received: from steamhammer.waldi.eu.org (unknown
 [IPv6:2a02:8071:5af1:6518:893d:4418:d27e:21b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (No client certificate requested)
 by mail.thinkmo.de (Postfix) with ESMTPSA id 4cwp6l0tKSzyVH
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:29:03 +0000 (UTC)
Date: Tue, 28 Oct 2025 12:29:01 +0100
From: Bastian Blank <waldi@debian.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Use correct type for ioctl(FIGETBSZ) emulation
Message-ID: <s7ingr72rgtvch2poxlwyc25lkxp7hh5c273ubvmz4tdskjttz@7dzfvylkgwsh>
Mail-Followup-To: Bastian Blank <waldi@debian.org>, qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: none client-ip=162.55.237.202; envelope-from=waldi@debian.org;
 helo=mail.thinkmo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The FIGETBSZ ioctl get's "int *" (pointer to 32bit integer) as argument,
not "long *" as specified in qemu.  Using the correct type makes the
emulation work.

Signed-off-by: Bastian Blank <waldi@debian.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3b41128..c87ce61 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
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

