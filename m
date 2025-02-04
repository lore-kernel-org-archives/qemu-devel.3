Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E08C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQs6-0001ak-1n; Tue, 04 Feb 2025 16:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrv-0001YY-Mo
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:07 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrt-0008Tz-Rw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:07 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f9dbd7d80dso635212a91.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706044; x=1739310844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlDbZXrgGBhVV0MB00OdW/jeiXnekdaairr3vgBziX4=;
 b=Z5GeLEU5gr6dCNPWxRJaLR8/aqsASWA/UWFdJJyeZeehXTHjnK7Y1S3TXQm/Ngoja6
 yolAm5jZjDUluN5TjKS+GKSafh81HloHZuTcA85TRRtFRWyx/xQH00Hwg5QThAdN8MBN
 2aBpNgk6c16TYy5ewYAVtDC0aFSOcyna7MZs4i2QtWTfz0pxHAirmYCr8Jq+ue5gCfnP
 FfFSScIfN2u5WMJMapQFvrOzcGgfao8XmQ5KRD7mIYUIUn+4MpCbJDGv3T7PL8b7xGTZ
 8k8qs+cJh/RVjrQS7AKsB14ggUWcQT04F3ZnbLE6TBxSJNDzuCvXpigmy2GhTindY1h3
 CzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706044; x=1739310844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlDbZXrgGBhVV0MB00OdW/jeiXnekdaairr3vgBziX4=;
 b=Js1z+MJeGJFcUy7CfhFHJ8DHLbko2/BJp+XuxMBWo/LvAfBkAlZXGnKGxeKerae/ev
 BidZBq/+4pC9lGOSFCDgqenxNJImNGh+ZQHRA5vEVmsZzcSD5xtmNa5ipa0h/3E5M/SP
 Bqpc5cFQs7FSVLtnjDRyuYFOUC0OsqEO5uRrzJVEfxbepND2nOOzjGZZdrAe7PDVSDc+
 bcqBk+bUqgdWpaNRlvrSPmer26y47lMtN6AslRCfZSz26rUzrTSbrMzXcyXdGozJ3Thv
 +XHuTVEP6TiawrikwzQG3MIP9iOVXel675r22jYMx8MKLDG0e2mFZx6fiLjcpPl1BNTA
 Fqkw==
X-Gm-Message-State: AOJu0YyRef36dSUXJHsvC8ozElaQYHZlneXPJMgEnIVW2Ejhosp+sjhq
 /ftW7fXucoGYVN5RcIWzuasV2XWYzLdakvkTPCm6M5aoCo2gL7RigKNIuCwRqNjhDwZwrNvEQBK
 r
X-Gm-Gg: ASbGncsnZIcn5SOP1lx+8/pq6udifN364Ox8fTx4YRoqhE/gk0jxDEGIdiQxcRwhSPF
 ReVmt5C6XrlPoRQuycD6Nz4WGwgpFIg/ifWaswrE/4P/ptSRqIXIAJ6+k8tfijY4AYlI6/URCyb
 5DYRm/n4hA4d4RRh25LUNi842s++je/jEvQ0N8IxSWcx/bKpIDU/rGHPORHUC/DejOSI4tMvlrf
 NcKUaGgTpLZ+2Zf5P6B/BEC1qAe7JptMOrdCZfetUN24G2ynKy2ak3dTg+C7m7pN/noG5nmW8uc
 lI9EM2JTUWlR2gBPyKANmksYzKe/56xAXslOwLhANlfo6wI=
X-Google-Smtp-Source: AGHT+IF75beQFWt1GCcRx6ERc9XvzWN67x41Zp1oqELMjVgU4y+rAWaSk1aawRCCxGpmGSlGS6vlMQ==
X-Received: by 2002:a17:90b:3756:b0:2ee:6736:8512 with SMTP id
 98e67ed59e1d1-2f9e075e2bamr721141a91.12.1738706044406; 
 Tue, 04 Feb 2025 13:54:04 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v3 05/12] meson: Disallow 64-bit on 32-bit Xen emulation
Date: Tue,  4 Feb 2025 13:53:52 -0800
Message-ID: <20250204215359.1238808-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 5a40a2a629..0ca83135e2 100644
--- a/meson.build
+++ b/meson.build
@@ -304,9 +304,14 @@ else
 endif
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
-if cpu in ['x86', 'x86_64']
+if cpu == 'x86'
+  xen_targets = ['i386-softmmu']
+elif cpu == 'x86_64'
   xen_targets = ['i386-softmmu', 'x86_64-softmmu']
-elif cpu in ['arm', 'aarch64']
+elif cpu == 'arm'
+  # i386 emulator provides xenpv machine type for multiple architectures
+  xen_targets = ['i386-softmmu']
+elif cpu == 'aarch64'
   # i386 emulator provides xenpv machine type for multiple architectures
   xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
 else
-- 
2.43.0


