Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E123C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZ5-0007Ys-Ju; Fri, 07 Feb 2025 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ1-0007Jl-PF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ0-00023E-8u
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:03 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso62649495ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962421; x=1739567221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83rDUEYq9wOvP0NwfgWL2G1APFDj5PaKxVull0vQqa0=;
 b=Pr21zwnQUdSVo1NOM96+8vzsdmTieym6OJwyCUsYPBWf9bz4bpu2xhyG7M0sbQGPRg
 7WKKTYuEAmWE/iwRI/YrCxSDXVxsTNm9ZtHa6Kj7acGxyzB/N0SYnfAFLEPJc5cLXiej
 TkaQnPSNLKUvXp5CMXWHFw0t0bTVu/30lo4aKP/2mc7Lb0f7xCfWMU/Eqjp71VkhhOmk
 fyRAHFH4020MxaQkYvvGqk+cMinNNdUaJvMEzleKpx3YGPiDZA/dCVXIWmD3V2vRnAVG
 kOFRVHneSXLtf+KWFBzKU1Xl9ckaBQlERTl7Jb2xmrgW8NhQmHcNKAb31HsLCUNmdm5M
 rvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962421; x=1739567221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83rDUEYq9wOvP0NwfgWL2G1APFDj5PaKxVull0vQqa0=;
 b=VSOlhW4qw7idWP0tXqGLgJ7fadtyYPRpaCqIKHgYut3xDEA3YYadJby3GZ7zrWZ7l3
 opyfblCr+GKh+G5xAX1y4wUW7YGYanEHQ362CcbepBtF/47QyRpKhtoIoyXKjotYv4iM
 9NDHAiRSfmgM9f03WUp3nA6eJ19ys4ZKnyrHzG6SGUA1k/DGzPHxaoPgFJu5aupkkNP6
 JrCPb8eAP3W1+Zm7xX2JKQYuwtMYUFxXGHOyWBQW41wTszwDmQ3PYKoSxWYFZtQmgPMT
 boWEXHp0gjL+/FQteiuxJSnUddeUFGwflNozbcGOK5yxHbGLJN2TTn1jYmyMY0CXoj2I
 /T8g==
X-Gm-Message-State: AOJu0Yy3dJZ1WxtloUuZCGylMgo2/RlUxPH4wYArF8aON56ExQ5QsAgw
 /jmjGnRIcWF9TCe9TPM463rLsVyDNr9kM2J+Faoaa5MR7vxZpiEG4sHgXSpPSzvUvg1YrEOa5r/
 l
X-Gm-Gg: ASbGncu25VjPbW11JQzloB0qO2Bh3WS/tsHdTNK+j0RPahAMpUEgiiyh3I8JKNNSgeV
 OZcdacAO83YmorAjfBng0xHQ1tGBtEVieKbRNoLja3Mfx2plD29MRCHKZCMt5r+Gp0ZzwYStK2S
 oxK/eh8igaB9UoQsLvs8sTqywIXW6/hWL0nBVIPBWWWyX7drHh84sC7ee9mCUPTqi9IkeyzB4CI
 3exq378NC6ks9n7tMZs1MzkrhFnFGoBdT0PXl/pOR9Mumc4ctzjD7GTBkHZVPD/LwE8MQu4HqdY
 zcBBAnqtdnWByV1TjKxi793bvdJcaTQa9Tk9vn/6tnSC+5U=
X-Google-Smtp-Source: AGHT+IF4bu0UvG19okFVE0caRgxYPpmtLhkdcKRxGH13BPd0GhZq2gfGByba8qhsjqu+SFrXoPhksQ==
X-Received: by 2002:a05:6a20:6f8b:b0:1e0:de01:4407 with SMTP id
 adf61e73a8af0-1ee03b70c02mr9157991637.37.1738962420742; 
 Fri, 07 Feb 2025 13:07:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:07:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v4 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
Date: Fri,  7 Feb 2025 13:06:49 -0800
Message-ID: <20250207210655.16717-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 1af8aeb194..911955cfa8 100644
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


