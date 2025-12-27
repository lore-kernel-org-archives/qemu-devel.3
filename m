Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6133CE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQw0-00007c-FP; Sat, 27 Dec 2025 04:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvy-0008Sv-4r
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvw-00076c-MQ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMX6XGLgAoHmFfL2qR77G3yc1UxcsxwMbqixV2REwfU=;
 b=bgvqBUOHFp/VaEUfLUXiV0tw4eKWRivvlUyLh4UXm1kgqNfXHt1fznzGl+xoq4kctfuCZA
 e6rLQgS8iIQyzQmAorz6UHQLeypWb+kNG7gB/AmmgCQuTYXJvMG09bRoi1+mTQQ6NCtyCd
 ddQkXP70X0RrD+6PI6Vj5uZtzWntwJs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-_ZxInSJhOQeIzvKPudWkBg-1; Sat, 27 Dec 2025 04:49:59 -0500
X-MC-Unique: _ZxInSJhOQeIzvKPudWkBg-1
X-Mimecast-MFC-AGG-ID: _ZxInSJhOQeIzvKPudWkBg_1766828998
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso2502834f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828996; x=1767433796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMX6XGLgAoHmFfL2qR77G3yc1UxcsxwMbqixV2REwfU=;
 b=FgNAFFd8KIJhVShNTIrjXJ9DZnnEYjkXmHDtChYPGIaaXO8Y3hGCMWVNz27SG5VYiT
 Ny2RB0pc2feyw1VOxFsEN3w0a8YAdUyFIKDaLVqzXnYWt6Oy5pfO7IOTCyAc8RS0VZws
 9hJQjxwTY4dZTwX6c8OFqR/rAZ2MAXW35s83m/BnaNOGj1wuWFpc1sO1VT/S8k2Cbt4u
 /fbOZDOqweJxfJw6Qy6S3nj4QqowjniKVEMUFVyeZfVJDP7XL+HFC1RFcZ6p5gFV6C/i
 e2GDu0uRMM+3s/hHOJkHIo9vMDFwu5XUixnt9axh4bTsLEh8Urm9wQ/liiqTZQo1vlyz
 i7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828996; x=1767433796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMX6XGLgAoHmFfL2qR77G3yc1UxcsxwMbqixV2REwfU=;
 b=OOFBsegW2JeMhnA3p0h4uIecACH+JoID+NDVqltcv3jlmoYuCXMKNrlkBAf3Wpp9Y3
 Dr8ncNuWCzDuOILa24jJNdfRSr0mRGb6TD/wbJqw2XFAGuRpTpBur7TfVOgQyGYhEObQ
 dqnckbb/bA+QLMfOtn6JPuEehL2F3M3DC2qHzY/zFxHnbAq3Ty92Vl6WLjb6fvIpOMAv
 pQhkgnj653XFe8DGFRJupf1M8ZDPHtC4Vt6Mayvhj5u23v83NtJeKuC1Ta3+UeDggjNx
 EJTad9g5Y1jdbZc4Pfj6KJOwy8nlTb/Vbiij0/o9T4kKxk6c1hEDbDeyxtEwPI6YNgP4
 Mj9w==
X-Gm-Message-State: AOJu0Yw1QmcyJS1RVAl0xlHavFe6r7abjm3LFnkfyGk10Mti7WHAnfmE
 fkyQ5Lz/0MhdbP5WmmHHDn8lwNZNB6LB8qh3onOSMd8PPJPKjfk6KmXk2Q7FFEAuB+9B8oRUgSO
 mGUL7CK879UC+/vvr5CohjXtHc4OmryY+DMAIzLYag4ng5fBAljlv3VfmAQmnsBzOYuPUQ4mlEq
 joqL6co5z8Tg1Vs8+ohW47PKbuQrpQ8DEG7B2NhWyY
X-Gm-Gg: AY/fxX44vReRQKo0+o6pAN2H68Z4UcTh4a8McQ6XAzvWrBKIRs1aY5gdOvUA3jobzLc
 fvZPFDXMfNVvU7oq/rxSPsDOi7JJjhzIVYt0u+NeOZWRvDD5lvErP5NkOYcUNR2CMmoXUfOw+X3
 DfxHnlGl4UqBSDPzTNVofgM9vnXPjQ/KmZKieaTaVPQ5obV3iJ/D6KTwb/TKVVYaBPP56cJ+10r
 ZLbhLi+Xm92j2bh8xmjzh/uQMmndDgmGyuptl5DHop/99FH1EGcsYIc1H2tOXCvQo6Wtw/RUedQ
 SGK6JWHu19QBJFcv3LkjWfJyHSd549Ypeoq3Af5/Nh+MwL+mGYZ0aubGuopaoTOBX0ObtX42uYg
 6G24AxgyZm4kQoaaOkLAKvs2D3s6g1abGut5V4Vi5DXbh97GfOA9rzGAH5k5bP+k/I+BObEJcRR
 VonmbPQ9/LVwQhXKM=
X-Received: by 2002:a05:6000:2301:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-4324e50c2ccmr30009753f8f.53.1766828996390; 
 Sat, 27 Dec 2025 01:49:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpQEWs0Nss3GVFySYRyf72A6ZT6AvrIt/x7fCJ6PP7FfQ8xxT0YsYqY2tF4t+/dbq5veA6IA==
X-Received: by 2002:a05:6000:2301:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-4324e50c2ccmr30009726f8f.53.1766828995912; 
 Sat, 27 Dec 2025 01:49:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2ebfsm49665631f8f.40.2025.12.27.01.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 118/153] target/i386/tcg: mark more instructions that are
 invalid in 64-bit mode
Date: Sat, 27 Dec 2025 10:47:23 +0100
Message-ID: <20251227094759.35658-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index dfaffec599e..8a1fb2855d5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1698,9 +1698,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xD1] = X86_OP_GROUP1(group2, E,v),
     [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
     [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
-    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b),
-    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b),
-    [0xD6] = X86_OP_ENTRYw(SALC, 0,b),
+    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
+    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
+    [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
     [0xD7] = X86_OP_ENTRY1(XLAT, 0,b, zextT0), /* AL read/written */
 
     [0xE0] = X86_OP_ENTRYr(LOOPNE, J,b), /* implicit: CX with aflag size */
@@ -1834,7 +1834,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xCB] = X86_OP_ENTRY0(RETF),
     [0xCC] = X86_OP_ENTRY0(INT3),
     [0xCD] = X86_OP_ENTRYr(INT, I,b,  chk(vm86_iopl)),
-    [0xCE] = X86_OP_ENTRY0(INTO),
+    [0xCE] = X86_OP_ENTRY0(INTO, chk(i64)),
     [0xCF] = X86_OP_ENTRY0(IRET,      chk(vm86_iopl) svm(IRET)),
 
     /*
-- 
2.52.0


