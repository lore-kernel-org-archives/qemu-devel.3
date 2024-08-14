Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E80AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEEp-0007kO-4S; Wed, 14 Aug 2024 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEk-0007QX-Ls
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:40:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEi-0004fU-Gx
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:40:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36bcc168cdaso4498152f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723642823; x=1724247623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmqvLXpHsMm1BHP4snAIAmxsuND6y2HmjOEmCpPOzSI=;
 b=tddrXg450q937Wo+qbCfEsSWctKgwVA0LDrjH1FQV0Ph9/VOQwVAc1dhWc5GttZNe1
 XPeugubb7bNfhA3NhmhGXDKlZf8mpYGxWngDWIt9bZ3XNMdmF04AWwgCzIGFvz4ZBewp
 OfN59YfjAONwTdYLrGSwNwhsc8KPS+3mIICXxhUrmw8LkRPw7Axm0ruLYJauKaLDFrPa
 p8nCZ3epwXk7aJoJNjO4NdSEcCodcb+So/WiAU3ohz+ky1RM8svEJelTM3G9wsobFmIc
 2IwMvh28pXn71+yoq3STGDCchKaSCR00fnhhFCmp/dXp0Qt2zkZu5YuDjodC6ECJtJKo
 5nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723642823; x=1724247623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmqvLXpHsMm1BHP4snAIAmxsuND6y2HmjOEmCpPOzSI=;
 b=b/OShccNOjzkaentqMQ+EtzlsQADfs499xz0nbZQVbXtJikV50ImVEY0spzX7HDntZ
 Wtf6G0mzqbGhsb+Hlp+YJGsTC6xzrHxp165LvF4HLswYBr7ZiLNU36T4T1YHnxgwYMLe
 lKUAGddLkxsGt0ZByzVD7PkPxJ8Li0I5wWu0Ciyzv7/hjaMEwjBd2+t2/mipu4CJcBfL
 B9xAZiuyVNZFC9FCJsI3wQB2FtDElPNXsZ4IyLh6nU86yZZgCgKG06UcIztOrfzorCN1
 1spOhw1/1IQw2poGLXGtgc6p8l96LP9Tc9bLr8BY0z/KajZaqmGWgWnruTtF9q1bwFXH
 HzoQ==
X-Gm-Message-State: AOJu0YwrhG5Vt+fLP5nLtk6XHoz76LBzcSjM1sj91b+m/1I0Minm0Pha
 iMPFw8RyljZukFZerIfry0tss2cDRzh1O39yMgqTBD2KLdRXXRV+e4Xc6PgTFI/aj/h1YrAFsyZ
 Gf80=
X-Google-Smtp-Source: AGHT+IFvhODmAfAuwVZxgCpoYf8NdEklFCc4gWVOb35d4limDWjg0Cf675n3PiH0H7fDqyUPChE1Vw==
X-Received: by 2002:a5d:5e0f:0:b0:371:8283:94c1 with SMTP id
 ffacd0b85a97d-371828395eamr379163f8f.0.1723642822653; 
 Wed, 14 Aug 2024 06:40:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b5fsm12803551f8f.31.2024.08.14.06.40.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 06:40:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 YunQiang Su <syq@debian.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1? 4/4] linux-user/mips: Select Loongson CPU for
 Loongson binaries
Date: Wed, 14 Aug 2024 15:39:28 +0200
Message-ID: <20240814133928.6746-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814133928.6746-1-philmd@linaro.org>
References: <20240814133928.6746-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 linux-user/mips64/target_elf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index a3a8b2e385..502af9d278 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -14,6 +14,12 @@ static inline const char *cpu_get_model(uint32_t eflags)
     case EF_MIPS_MACH_OCTEON2:
     case EF_MIPS_MACH_OCTEON3:
         return "Octeon68XX";
+    case EF_MIPS_MACH_LS2E:
+        return "Loongson-2E";
+    case EF_MIPS_MACH_LS2F:
+        return "Loongson-2F";
+    case EF_MIPS_MACH_LS3A:
+        return "Loongson-3A1000";
     default:
         break;
     }
-- 
2.45.2


