Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D4ACD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VF-0000Kw-R8; Mon, 18 May 2026 17:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VE-0000KL-Ae
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:56 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VC-0000Pi-3I
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:56 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e4de538f83so1675786a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139672; x=1779744472;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CenKEzTcPoLDRcBcEsTcXvijDJrJ/9k/bqUajU10YlI=;
 b=fxdVL/DC4xWDOg45mtc2tAztM5RW5duU8YbOjkJ4o+KMuErdIM72d4Tk1JPos8POVE
 Vkk0jdxVL7doHk2VsytN6a/7p9gqpkYU1ihvXjq87jNojPAJQSSnbb/8Y/yd7abQ7t2P
 kaCErEIk2V1H5ql7o4ts1fyuWurBsPDarsLi43W7ZXhvCXr4zq0ccZTYEAKKkN6B2c5X
 wFmUh6d87J7JKyaRkKeVBl9Sr52AAsl2XSX0KI6iNFYttD4Qc/mPVnzpyXJvGlfDtY/E
 5hTR9CwxX2ry45Y+eSLT5uygj+JC2L1zHnR1xY/+fP1ALrMAa4OIcjXez1SRIcoWylHI
 SbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139672; x=1779744472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CenKEzTcPoLDRcBcEsTcXvijDJrJ/9k/bqUajU10YlI=;
 b=lpbc9iM2+p/31qskvztDSwH2JVyxPTgvLOLQ2/Wc6C+4iNfzR4uupRLurYKaG18c+B
 bj+uLPeDky/6nONLgQ9urKud7hKJ3/70c+wOuNDxJ67NqooODSINQ7lD+snutf0A+UWQ
 dF3UtI6kye42UiiL134SK0jDFQpFfdnqVVtWdhWLqCCmtmx48FeQiMbvHwf1aB2MmhDI
 mClBnLqXJnIVaN+yCp/KUgDsilc6FaLTRa9xS9nHYtd2K6bWd2r6e+GBi6DwzODEMvSC
 hlg/hiUh8VeV3OBdU0QAjEcsXjVkxup2TjpYuHl3BRRHIh/Z+BNV0YfVhZ0UQsJiS7VN
 lHrQ==
X-Gm-Message-State: AOJu0Yw2S3FvH43R5Q42B0ldYYsaVDsMUBThdr4JosRA+Er5/AWQ+a2J
 GITJ1FLN7f8e1wiaoBRAzwm4TzfgDEXuftnSLK5RegwLn3VFALxO3HwrohPEIkbC3JdCrL3m9gE
 BqnFrvXk=
X-Gm-Gg: Acq92OHQ2uCjVPWA8RS3NXDjmqgCloNcxKknh7IwryQUaJfE73NqQsv4JRQ5jpJ46Xh
 SjlJMuGrzbAv9s+R/uffnwHJztDhrOl7MfvLpPOl3d3EIaNcKQAKUOynCHOhl/HhEKg6iofB6sd
 1N7TXFGnPlBj3QVH6BU93UvzghTZ81iVsvCtuMNBhfOQihNGP7yon2XH+MmewqT1fRBiJoHjRy8
 LfarEfrSSGAOI4AVj8aeni5R0DF/RTXrNdWbRhj0dZsDshguPZU2IGuVIIWPFUom15zMdmdLPLv
 J9PKSi4oJtMUS2SBlVV4xTkDg7o+fbPWk/uTv7qs9pQH+quhhejrCOHDBEWodVDAOtMAKspb8MQ
 iKeHeJdjtMWagjcRxv9ftMTPC1NxOepZdX8j5uSawZo8IXntoKPMrzvfIVyaJNuvHlUgkpwhmj3
 PrCItMvukPXw==
X-Received: by 2002:a05:6830:6312:b0:7dc:e6e8:62b with SMTP id
 46e09a7af769-7e4f2b416bemr11453676a34.13.1779139672426; 
 Mon, 18 May 2026 14:27:52 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:19 -0600
Subject: [PATCH v2 01/37] bsd-user: catchup to locking / mapping routines
 in bsd-misc.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-1-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=pDBL7W85bLOqj4gx3AV175aLRI3QACypNGsgVG8xCQ4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RFmz7WMtNKf+AQ5+jDdG+T9ly1ToUZU/Q6a
 RCgZzC/76eJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERQAKCRBsHNEofbAR
 AEFEEADadISO28kkSdi3DQWi8v/ketUx1Uwrz1b/LJE7BOlmvC6Svv4xTuWp3UdMqrqnaIt6aTt
 kZtHyPQczOQ/6In3NzuiRCIedluFuK3pIwHn3jVvZ6mZopWFPLrg0kzuvSgtVvEyzYdagYuOUSc
 zB0qpoPbzhWupGXMYKpeOsakuRrcvkolIxFWTncRW4nXhzUdbpH7JO0pkpkiQaxvDA0CygqIOED
 UXb6pJ114Sfvh2IPIVmIR2Uk52DBdA04c5W/5XEkt0Hjsy6JMcoWloLdfogwJ6t20ehOwYyBRe7
 2RMmC5CNDnhSdTPc8pqcPWDEpoiYEoH4WsmsrEUSqgKgTiRP1/qY508E4VIvB2dvLK0sUL5eli5
 TEzJS4zEkKNszNHCM7hnLchOWXLvyoqyXC8S85LlxJFToKAMoj0eDTbpd7iNcnCWyTMPkma+CxV
 W4EeuenEoQF/6FuA06snOteKUBJ9zLlINy2iXbTWLbGCLQipxguloG/L6BtkSinUe2UCfxsA4PS
 J8bjVfcjG4F0L11wjqN5ZD4AvCwTy1YSWB/2uJOt2J6EebADVdGIhvtcMb9soRfG6e4dz+Q2fiv
 DzjNc5whWh8mkS9Td63kv/eu+8KP7ZctwcQjMIHcvr0+N19pywwKfpGGA9jlNAUqxZqUxrRzAhh
 pRgJ2Iquiq+VgbA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

These were added to bsd-misc.c in a prior series. The declarations
logically belong here, but aren't strictly needed with the current
structure of the code due to include contamination.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 756425d18e..f7c8338213 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -32,6 +32,24 @@ int host_to_target_waitstatus(int status);
 void h2g_rusage(const struct rusage *rusage,
         struct target_freebsd_rusage *target_rusage);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 /* bsd-mem.c */
 void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
         struct target_ipc_perm *target_ip);

-- 
2.52.0


