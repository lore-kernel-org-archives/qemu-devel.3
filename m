Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345AFC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBL-0006op-HQ; Tue, 01 Jul 2025 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcB7-0006ch-P9
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcB2-0006ui-RA
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so2550635f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380896; x=1751985696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SH0pS4fp8TlecYwMv/fmZPdym5FUucioNm4YGwf2IM=;
 b=XLXsuA+N2FLb6iLSc2za1W2VbJrQDndgfOAs0C2D7LstNFPM1fW02qJ33zq5a2mHTb
 cIxTg3biw5aW4xHDafk6b73hyIZ3eDmYknZ6Q8eKZ3K+Lm/L7hHtu85064Axv64Du0SV
 YaIRJnloalnS97MTop2m5WQds8eyHmqXaV45TWDieKbTbjoP3VMC3qyzXj9X+XFg6Y0T
 oiecIiS3wzeARP5HO9/7oPPufd1D88yEFEm02wXAS5v9i+6poQaQ84K5pgnAlGuc+y3R
 GX0I6MPNo6DTPZbhT39YYquzzFCcDdj7wovK9Jwj7YYbWxi6+DHBcZakM6AJU5BQs0uK
 ygoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380896; x=1751985696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SH0pS4fp8TlecYwMv/fmZPdym5FUucioNm4YGwf2IM=;
 b=ktI1ZmSu7oIaRaUXlj1wvY6krsyRXPgiOve2VVNeOufpYOOORZNYoQbvG0SlAvpv/T
 lw9M4xlvUA6Jf2DbGj63Y27KeyJOWdxvdnLCW8bBmGjK1mRw3TP0IX1reYZUOE482EjS
 eDGT4NfQGUIodMCF3cWOaN0FdkXYuu5UAm+OLXzihTb/uWSwSOZUKcTpNW6+1vV5CoUb
 7YdmjCAhIoCgdeV1abi7u8bDkKaU0mnkmCiWIUBzLyVAT4uhBAx2s4yTF/4ptTKoCxrv
 GXm8CARscsdgXXCTa1tkMm/o0e46mKeXln4Tfgjm5bL1hIhtCoicmoPSjUu6M3+wRo23
 S/NA==
X-Gm-Message-State: AOJu0YyIvLNLQYvmEk93btJ/YbE4t5bMBjd5fhaqA9GWftf82yGwFuzM
 jfo4YTowlN7zCHMUh6GtGiaufP1dEaTmwjnc/SE2Y2ZuBYG8JhNJtPjGYjLdPpdlJiC2YgAiWCZ
 fPklP
X-Gm-Gg: ASbGnctAFHS1y7xRbCNwZaIHT9fyWJMZNz7xu3+InHGZbB6bV9tZB8gEVLazdUAmLgk
 0+gfPeNdAmC80ddSdmzYMC/t2Ijvro0E2EjOflzPLxossPzOIXMvt9er+S0uBu6ucIVO+grq6md
 2niAuLUUu7M7TgKKBkaESDqNHSD9XmTnq4P7TDQeXUrcLChmV7xMMaq8Pkfb6s7no3+K7AmleIK
 fJYdPq8RYYZX1zmDbi+7EzdeyJTNklHE5Wf6CpD43YI96//lnyR3m5sVAdjc/zEFJ3vaSsICNih
 vwdeT+Evr48ld3E6FOo00JNGpqDo8C14APBYUYGDY5MAdR7TbLGkjVsRJdUFsPCZEdCSkjIREap
 lJm2AoK4Q/luXolwa016zpOWvKut2jzgoGAjC
X-Google-Smtp-Source: AGHT+IG9fO00aPWeVJ/Ubkv0fNQcI0Y/F3N9DaHy+sCH6YBXVaEPOEiMGUbR/CnVXrueG/BFm5Dzxw==
X-Received: by 2002:a05:6000:1786:b0:3a4:dc93:1e87 with SMTP id
 ffacd0b85a97d-3a8f577fdf7mr16322538f8f.1.1751380896114; 
 Tue, 01 Jul 2025 07:41:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595c6sm13791537f8f.66.2025.07.01.07.41.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/68] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
Date: Tue,  1 Jul 2025 16:39:22 +0200
Message-ID: <20250701144017.43487-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d56ac2a058f..d5917c0a344 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2470,13 +2470,10 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
-static int do_kvm_create_vm(MachineState *ms, int type)
+static int do_kvm_create_vm(KVMState *s, int type)
 {
-    KVMState *s;
     int ret;
 
-    s = KVM_STATE(ms->accelerator);
-
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
@@ -2646,7 +2643,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         goto err;
     }
 
-    ret = do_kvm_create_vm(ms, type);
+    ret = do_kvm_create_vm(s, type);
     if (ret < 0) {
         goto err;
     }
-- 
2.49.0


