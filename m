Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BBEE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTjFZ-0008Ib-PL; Fri, 03 Jan 2025 10:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTjFW-0008IJ-Vp
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:06:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTjFU-0005xQ-UE
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:06:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso84396395e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735916762; x=1736521562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vWyUslIfzchH/Qqlm6hFSoY1eYQiE88dMF3dsmhROmc=;
 b=sRmiIV0onMVlrMOoi1WugPFa811o65wuPC0UMS+QZ1ypWkT51NZoPHGi3nc9bfk9MM
 8wmIvQRdJi+2Ydtr0W24D7M8A7Ul0QSpA6C4GhBSYNcLRyiWRkrWbaLICn82o6bbAnEj
 EA4+ttnpr0JybGhAYNw2u/9PJ7f0aBfmb9LfrbBtJ0491gr/gSoJX/ylrwSf6a0IToJ3
 1VVlNIIlZM+3Ih3s+6MzbK6H7JJE0tc6NpdTsQi1fAC7kcAaoWd6l91Q5ZxSfMC6BjE2
 S0Di//coIwNGseGcO47JXP9EKlN0hXg5Z41o0pR43hKSKeQkansnxniUwY30szzaKnpo
 6gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735916762; x=1736521562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vWyUslIfzchH/Qqlm6hFSoY1eYQiE88dMF3dsmhROmc=;
 b=WwGP98baYeIFioDvibcOZCCtRouYn00KPQiPFh1cq0+r+RbWqoPiT5PspxPMpPJ1tN
 Sk5PlyDtSJS0kBD1ziYncYi4TR4d4kb/2e/zGkec+TqxBdeOtzqEdx9Ru/HzhRQ4Hzod
 D1ZnxE1S2d+WCNmfhwVueTJ7wn5FbUU8vVzgrNbcYUspyvbOmZNJILCV3HGRgQCT9B3G
 Luvav+x1N3Nx2U7oQXkastuaFujc+/XZcOANRaqNHKxLokyATq1s8l+Ov5C/4KlGjPAZ
 mlme2zkcu594vmzwtyOJU26xcX1O43EuAxosAfJNmxOe/CPp0OSwhBM6t3Ipxk/VtVj3
 Hp4A==
X-Gm-Message-State: AOJu0Yz6u3eQ3dfkloNohHCi/KeToBJw0AP+2QhbCl9eL946RDUgzVen
 LQHtuYHwNHzWNeCS3sZXvBuTpPNrUgRYYh12ZpqttLg3vziQbwFQKASrl/vPT9J7VlDDcC7vEux
 cccc=
X-Gm-Gg: ASbGnctCFGpCkWDVVgEg0w2pI05v2vB2vZA3ZSQB12JuXRqIDaVjA4rd2za/AVGnNT5
 He5afbnGHeKbzjPXXYvwyKOleSgmjidHri6W84NRPwU+yWtEqdFCfIgFVV3LG8a00etXAUirdtV
 BwO6tmZikL34H35733W3fggb4vtza42qF8w2a3my/D+s1gibPlz3k67nkYQKDsTMEzhUvcZ1UXm
 hbqpQqSqwb/jex4mH56GB7wvdOWkrtHQotFC0Qy5ymy9wQexlmHxQlw5tMMq6NTg0uPbNujrFR/
 BedR9iUW4K880vNamC0IrH1Hz2QRfb8=
X-Google-Smtp-Source: AGHT+IGHalqycdJaWgujgfZPDARfttyRrFKXwCky2vmmZfqoxOZU8aeMTk1UDEAHEhHdnaeEsZFj2A==
X-Received: by 2002:a05:600c:4f86:b0:434:a802:e99a with SMTP id
 5b1f17b1804b1-436685484bamr422640835e9.4.1735916760732; 
 Fri, 03 Jan 2025 07:06:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612899f0sm485988345e9.38.2025.01.03.07.05.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 07:06:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] system: Try hardware accelerators (KVM,
 HVF) before software one (TCG)
Date: Fri,  3 Jan 2025 16:05:58 +0100
Message-ID: <20250103150558.1473-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

As Daniel suggested [*]:

> We should consider to rank HVF above TCG, on the basis
> that HW acceleration is faster and should provide a
> host<->guest security boundary that we don't claim for TCG

[*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0843b7ab49b..e20391281f8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2379,7 +2379,6 @@ static void configure_accelerators(const char *progname)
             /* Select the default accelerator */
             bool have_tcg = accel_find("tcg");
             bool have_kvm = accel_find("kvm");
-            bool have_hvf = accel_find("hvf");
 
             if (have_tcg && have_kvm) {
                 if (g_str_has_suffix(progname, "kvm")) {
@@ -2390,10 +2389,10 @@ static void configure_accelerators(const char *progname)
                 }
             } else if (have_kvm) {
                 accelerators = "kvm";
+            } else if (accel_find("hvf")) {
+                accelerators = "hvf";
             } else if (have_tcg) {
                 accelerators = "tcg";
-            } else if (have_hvf) {
-                accelerators = "hvf";
             } else {
                 error_report("No accelerator selected and"
                              " no default accelerator available");
-- 
2.47.1


