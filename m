Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29B4C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvaq-0007HJ-TD; Fri, 02 May 2025 14:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaH-0005xO-7J
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:16 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaF-0005ai-2a
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so3549542a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212280; x=1746817080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym7wSrcTG0iPDZDcZJp5AGoZOnw5NMHUmUvpm+lkeJQ=;
 b=jqKnH5p6jrCCTxHr+PtCwz0R2xWUSSrSXO5d8xst2UsO0rDejyt/M4kLx60nYBhbC8
 sXh5WBd73eZK6xcvY3wRwI7EEJ2Hef2RBATDOnhHscS+8HC6nshVTpcuTMmpFYr6tNhe
 o6SVwQ+lrTYiATwtXJKQzUk1w6t2OKPzraaMafaH7Cwd77JnbN0Th6PgrIUrxld2OW3o
 DlOzQ7zR12ynDaQRyA6I/1RR1B0uoXOwWD9MPxfzfzFkko9JN6N4+qzpb2dD3FATxYQG
 gaCp51GBkzuisuCvEqilqLfDWxCI26XqfvJAPx2wZxzu6cHJvFxxrfJ2aEA6rVY4tBvv
 5Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212280; x=1746817080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym7wSrcTG0iPDZDcZJp5AGoZOnw5NMHUmUvpm+lkeJQ=;
 b=WFv2p83VoNYXBg/M6JkMEdFDyNrc8L5TVosOW2TIR8spaPc98GHxbvAfi6y1axS3/I
 xCSmAESb9Ck6p9OCoN7clDTmF/JlBoNpmjMIsihlcylemb9rlzaO8n8Y91Xw9LFnqq3d
 fC0HFZESfuff+fNnyz9HRLv3SwwEEWuE4EP9iZiGqHnn2lnGnmiecI87pOVLnQLxQb/Z
 beX8VUfO/lmUkICAESbFDzS1xa0E/buDNl1Q9iKBDfPHNQJwxR36RbjpnafswZcvMAQY
 d2jvUUnW+7g7HQugTnu88qAXPN4l8lYf3j1cnnnkSjAMJGfAmYbbfB7eI6WNDVkqYw5h
 Ffzw==
X-Gm-Message-State: AOJu0YxSjMj4avRDjhOZSqEtnvUD2Ae5RdR7vZ5S183hg8QScS92koHE
 PNu8xjRZpMAfWQT3U8e9rVRB4CUpxJ5jpdec7nBv2N/yy5nU5qulIs/BLmTWfbcC2CLEu3KrnH5
 J
X-Gm-Gg: ASbGncsOFnLAKTMEz3tFPojUNImA9uD6chqHsdHqglMUkPUqH83gW7mnceDCKdFqCYV
 2yAaoHkfAbnPpQw9Fn7jVHQSGVhSsvwdH3EAmY4YFYlc//tTTtuIETpqYK5vpEdvG/KawgfJ0Yn
 jUPZICdYv/t6G6fmYNmI8+cL2tcwxqhFCZiW3zZKbOwrP8pssOck2v97AdG2ej9tdArFdLY3P4/
 8xu63yg+PhjSjDse0tRDnmxHyb8vyRFqdccACd5IjjZRtta7TAFIEk27kbV2MJ4ns62EB139aAT
 GQ5uekAh3CbQcEuoBA6ZccfCKhyowsKnSDMU/PP+8/o4ICgW74S3qXzr9xp4RCyD6lnhpMt3GN3
 IgKxgMre/TfnsucYRcMcU
X-Google-Smtp-Source: AGHT+IGK3jqXfFmIbWdZNHBfy2BgmiLJlUD0XPLVsGZaFrMIzOr+dU+YjT/+E9MyCAzXbtNJmk8QnA==
X-Received: by 2002:a50:c8c2:0:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-5fa788ed11dmr2890471a12.22.1746212280005; 
 Fri, 02 May 2025 11:58:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c74acsm1637679a12.23.2025.05.02.11.57.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 11/19] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
Date: Fri,  2 May 2025 20:56:43 +0200
Message-ID: <20250502185652.67370-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c |  9 ---------
 hw/i386/pc_q35.c  | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 98a118fd4a0..98bd8d0e67b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -755,15 +755,6 @@ static void pc_i440fx_machine_2_8_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 8);
 
-static void pc_i440fx_machine_2_7_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_8_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 7);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7ffb5f1216..a1f46cd8f03 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -648,13 +648,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 8);
-
-static void pc_q35_machine_2_7_options(MachineClass *m)
-{
-    pc_q35_machine_2_8_options(m);
-    m->max_cpus = 255;
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_Q35_MACHINE(2, 7);
-- 
2.47.1


