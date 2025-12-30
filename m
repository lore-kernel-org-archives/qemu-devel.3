Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ED3EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyQ-0007qJ-1Y; Tue, 30 Dec 2025 16:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyL-0007D9-GO
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyK-0002Lr-3W
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso33770325e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128977; x=1767733777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ATjngnnV3ksOsOxX3aLV+GZq9KCpLPtZIU5jqLOQRSk=;
 b=OTLKwpjr97unswQrQ2PN6ywYi4ausOhtdFEtaVsetAAU7uijC9ioUIz4/fyhz1ablt
 dUhGT7ON0q5GlsC3fjYZp/1OtvVLVE/TMk5NEdfbCVZQqskPy2N5g/n3dJGojtVrDsqA
 lsdGHIbFvjH1vXn0KSL2cRD40aGKhgv5LPV8isV2SFwwfrrJyrR7id889doXiefHCJPp
 JM9D+wHzAM3bsDeuG2XRFtjCPRh0X8xZu/ZMIViMaafDfR5MhYjEy04a6UFNLpQcogVe
 metbS6lm+lXI6SXDSTI/HLTGvaiMe2rAp6hqiZfIycUX7djYyri5/aBMXUFsG8o4cQZz
 9n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128977; x=1767733777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ATjngnnV3ksOsOxX3aLV+GZq9KCpLPtZIU5jqLOQRSk=;
 b=ot9nSGzl70akdAkmiAp8x4mB0NMOmggaeZKtB85znQ/1ZjyJ/5RWlKwinFlan6SbUA
 lXXhIXy7fGTn8nF1SHNhFNUhvgZzNk7FO0SaqAzp0/c8OxcMCJEdI7OSHJ0Bw0t5UyU9
 vZfvvxn1devHiIR6K7/sp3HuVZ4Hj8q511N65ZTNhH2HWIfIKSmlthN1QBLJXuTZw7pR
 aR7reqml5jWO1UWm1PpLF3fg4YkBImsTzJ523plfFUfCBnvKGFK6uYodli9lI8ajfi+g
 54bHWQ/k4zJyOqPxHa1WFNTSV8flHGudZzLM+X9N3G4BVKSKXKFEttDRkiZLd7zydYLM
 Qz6Q==
X-Gm-Message-State: AOJu0YzlAtvUkDYX6EF61AwMrndA4j7U7aWnrMbgVGJbzB+g5dtL5Hpr
 CRhO9a0398NDlN14vIIYfvcpDLrK2LzWsPNfqk73It8D5IjoLLqf1AitONAPVl9eAMlEZqjs8tO
 b0xwoJ1M=
X-Gm-Gg: AY/fxX6LfgqryzPD5uUXZs3jHnwBe32iOtjzx1QiBujRnfoxpCi5jxJbNuHB5YbJIdc
 /z5I8Im8tiqxTTP8yQomdAfjsb36Uy0ACIYleybYOl4+1CFI3BgJjlSRzxZwx3wtLreUa595LUc
 nebIDeIK8GpcEyKNx5XWbxM9xAxqfoTeOHu2M1M2JCcGbvrVXP55umLL+cST2D1/GvJejy0k9Q2
 vkp6shYnl4kJWLKST5H6TyIJuFlDZrwBNt0GmU7wVE8IVJS+mHBc7WUNQZQM9tYribaF/XPZxCy
 KNUF3NtFcsMdeIXDFXIiBm1atgeuFvggPF1Hzr8jhPzKj7VWqZX+82GcGgKguEIi/RarG0Nj2vF
 ihSZfv5mAHYN0ZVcEwxeV/78mfF7MJGuhr6oCDaX5+T6HRrVAQwZm91gDUsEy51CTIqB8aHNhcl
 8Mcz83zG2jVSKCEyN4swnHcWN2E304qbeBMj2HVKTxlVnUVl/zwCqmjkZ1BwOcRh+lYPv58ow=
X-Google-Smtp-Source: AGHT+IHEGqnnYp1VrkiQl5isS5xjERQmK97xWcNN/IMuWGHSHxOZyDAruxVCa8w7lppInvGHpO4WYg==
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d1958a755mr443284425e9.21.1767128977368; 
 Tue, 30 Dec 2025 13:09:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm673737575e9.13.2025.12.30.13.09.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/34] hw/misc/pvpanic: Expose MMIO interface as little-endian
Date: Tue, 30 Dec 2025 22:07:37 +0100
Message-ID: <20251230210757.13803-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Make the PVPanic MMIO interface behave like the ISA and PCI
variants: access it using little endianness.

Fixes: a89607c4d0e ("hw/misc/pvpanic: Add MMIO interface")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251224134644.85582-5-philmd@linaro.org>
---
 hw/misc/pvpanic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index bbd06d9accd..f711ea10fd7 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -62,6 +62,7 @@ static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
 }
 
 static const MemoryRegionOps pvpanic_ops = {
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .read = pvpanic_read,
     .write = pvpanic_write,
     .impl = {
-- 
2.52.0


