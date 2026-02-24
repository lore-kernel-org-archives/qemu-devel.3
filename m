Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC5F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbM-0000xn-6K; Tue, 24 Feb 2026 09:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutav-0000MC-Kw
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:02 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutas-0001Ig-RR
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:00 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d19bfe1190so4783670a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944056; x=1772548856;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q5yEpB3N0ZOm8g2gFovCCvNwar1x4Vm84sgikfcwrfU=;
 b=zvc2wawAersD7mut/jFqmQjO6Ux0NxMpzc+l0l1zLFNLZ76xV3eZ4/O/clBUe4SiN7
 Qmx4WxDCfLNz7HcN0pGGbhteqxa0FF9Sc7YiMIkVkDETq3lInYvqsbOCE4DMY2fMvyOU
 tBiBQAVJCt8TMPuATJC01/AohEJ4/lJMsNrlBi0UxFRThajOgqWcxhieUJrw8fnzSLDv
 Km+3p3oDnuOinFitV6ImCdd03vC7zHD7l8E0jFFRfjHWxqmNDEWURZ257g1lbBSXtnCR
 7RAlBKWVNeANfuKnHrp9iX+SdTmcOr1NnCUEtK99TdXJ8qSGSlNN53a0fsb8q2s5V6so
 ddcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944056; x=1772548856;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q5yEpB3N0ZOm8g2gFovCCvNwar1x4Vm84sgikfcwrfU=;
 b=IJUVeOZ20GoX3KILHYQiSzteU61JyVmKf/G/xzvPYaYRYbe+VxfvdN5hUZ1/e8NqPw
 S8ox4GSvwDtIc2PY9Nwb9rM4X68jkKE6fP0YA2MHMzZCXvqO+tYxNOK/Pd/6avXrFKMv
 xey7RWjGCQK/D3cCeMwZl3JEKhgdlc08KNDDUWwkldoWqAHo8MDpmNhZm5Ma6MDGr6Zq
 cC7iWLXbbQCvW41vfO5WXYZAkv140v95qc6lNC84HGmYM9WKJmZN5rM4OPlHXnwsjAgU
 pdRtkUbvbWWJVnkAIVeT6K7Dz6cmTpqxWnnHhVLaJLS82+FPpNDIupu+iEceJ89WLxyh
 iJDQ==
X-Gm-Message-State: AOJu0Yxg04o5qxX511AdphPCFhkt/SMjEmDot83lUaSIjep+ttAME1LO
 fditon0i3Xm7wp2YdEisQelgSHbkisDt3vQ2mApMYtSfEWVWnFDdOBzWfOVhojbUgnAzL2OiC5o
 z/ERcgzk=
X-Gm-Gg: AZuq6aI1QvfOj7+JfXRUhxR5cV6c/8EuH8NeE241dv2600OXmStxHWbsnLhGIEJkv9c
 lTquvXlkB4AwjuZvc0r/l2fnx7nl8vNNTyQaeLb2ue4HK2+G1XasHRGJFLJSlPlfmrG4VONiSX1
 TFw8Etui5x6g/bRtkbgTWdV7fEb1d7K+tuemWbxAZ0dyNvZJYDIqFZEIze9Us/uXL8NjL1K+DnF
 cWpRdxYDJaFVYhFJ3EyOeI9z+R0+t2YYALhEL/3YaERJfXYurUvohdwuKI/XEUwhAMmBNgO8Tmc
 GZ368XDd/2O7Kf/qmOO1l78wZFs/mwme/HJViB/KMRbfA2CxUnvnp68+L+00lWfadSIpBBBHDik
 XDx1GKTmkaGM2QnY4/I2iyuBUxntAqmafDrU3SMmCMJkGVwy+ZR0YlWB4JliDnT4VviMDrVpqEx
 z2TIsyhqA2Ng==
X-Received: by 2002:a05:6830:650c:b0:7bc:6cc3:a624 with SMTP id
 46e09a7af769-7d52bf532b3mr6993050a34.32.1771944056303; 
 Tue, 24 Feb 2026 06:40:56 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:55 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:36 -0700
Subject: [PATCH v4 12/24] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-12-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gpFtwDCGHbSz2mhNk7LCOdK198vPiqLD6qg22mYpWf4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnmAdqHvYP3AYvsmTLp6auiWI0vgmY5Yfi2
 9xTuQeb3PyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 AHnjD/4y5jtiZ2Ix6X+BqW74T2XmhcEVXtWixjawNdJYezUfTYvygTSFFwey2kuR1jZDnrPELR8
 zB5+tIz6M9HZLyxctcMwwrcumRFSS7yn5aOcyCmjlT0wrqXoHjiG1CX3m3WNChKQSknuIW0rIQg
 GWIt8X4dqrJAeI/XNva0THHp1BK4VKVkRRnolHnp3uxS3WEO77q1yQCmX33phe1JhZbX4n7ClX/
 LrI3iNylwWTBB08B/jvz5kZiFcYqvJin2uZ325CS4gqBenTtdxJ7/mA1MUve7IAFqSS5SBcWZpS
 H9U8kanm4F6Ri/RHubyfx8Zmd2WtDG4ZPQ2DKmau3CKoDg6jubDF2nBxeDBVhJLtigrQ4f5MImt
 8sN2mQ5lArQdpnk+SEP7DQvcrPCFDU3dLMmTqmOh7RmevgBXz6YCkfD+b9RJWy2xQX7fqgkEc3W
 UwTzuUODDUYsHb9v33Wj07PZNV0XHI0pCat/dKrnP2LLncTG+Ejv6h9m1mUaJmlIqB6qqNR0E6X
 y0aW4Fn6WNMwhkykOWQvbdjEmZkFD2U3Xn0QaVjqIzVDb7g7bRKAsRtuui7C+NekKFr2+fR2wbP
 qiBJv/MKbplQgBjjAux4aCoFPem2rIPR+g1Z5m+/zI4RzvkmAm2wVv7UXxhNFY70RPrwiO/kCdh
 zMoj0lZMMN5Q8JA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
format for msgctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 5e5a590227..3e1968718f 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -163,3 +163,30 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
 
     return 0;
 }
+
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(target_md, 0, sizeof(struct target_msqid_ds));
+    host_to_target_ipc_perm__locked(&target_md->msg_perm,
+                                    &host_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __put_user(target_md->msg_cbytes, &host_md->msg_cbytes);
+    __put_user(target_md->msg_qnum, &host_md->msg_qnum);
+    __put_user(target_md->msg_qbytes, &host_md->msg_qbytes);
+    __put_user(target_md->msg_lspid, &host_md->msg_lspid);
+    __put_user(target_md->msg_lrpid, &host_md->msg_lrpid);
+    __put_user(target_md->msg_stime, &host_md->msg_stime);
+    __put_user(target_md->msg_rtime, &host_md->msg_rtime);
+    __put_user(target_md->msg_ctime, &host_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


