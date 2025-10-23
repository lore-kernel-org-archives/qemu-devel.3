Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DF1CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv1e-0001Nv-NT; Thu, 23 Oct 2025 09:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1b-0001MT-D7
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1X-0006Gw-SK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:39 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4285169c005so358647f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224793; x=1761829593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt1tGyvXAe3pncZc7T8tBRzYECxTVkwBPwQzr5iNL9s=;
 b=I4JmDjmTSp41sDFVobrdSriiz7mN39yH2C4Uza2xqBdn9uhce0SiJOM4DcSa38mJd2
 QG0HmWWue3uJIlED5AAf93AZ3FgSO8S6uQIdS/CbBdOn5MTobtmXgcDlPWGhVjfwRb1K
 z3SMHqQCTLpE9M+I1ZLQkaicXn1qkA3iz9+cliu8Z7t8cIcLTZYJP4Us4Z7QExdbYk+j
 4pyuuP4wg1sXcrocXdD4vjALlbdd0yuDsGUoyms13bH+XgUlGC1NvvvCi/IjQ0JeRzB7
 bSxisShTJ1bBOE+w60cJjwo17tg9tJ5kphObHCzyiRHslvuKxuMgW7ogcl3KxeMtzqTj
 oP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224793; x=1761829593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lt1tGyvXAe3pncZc7T8tBRzYECxTVkwBPwQzr5iNL9s=;
 b=EsVa0WlwW+zmf9uomWnDoKjzFt2SwOWmeXg+/BuBPAxLrX8WmgN2Wuwc6KO4Esr4HC
 rj7TcOZQQT7udJVCa5C9h45NY3oLYmjwEOWlzfhiX/ICpjWHi+JR/bgXy4ZBWeQUwYOB
 4NmpmPY1z8XumSDPe7x4oUxI5RC8T1rP1JWrtK7s6aKRX/qw/3vyotCor+XB23i5NHmo
 bhgUdtqd09Js3MY+7NsXIWngBm/ZK++c2EYkhDnCA55xEvCX0ERSDxjRatr5/lzPqSOD
 IoOU0go4neKK+wmUsEeWZnJzDN6s0vUOtahnC2pSiK4fAd5hq2pbeR2oXZ0/aoov3Xo3
 xpyw==
X-Gm-Message-State: AOJu0YxToAD43IpGBLXCeD2qkXDNKFGXTNV6xsE59IF+bsHosjcK+Ksn
 CTkxZBVIIZWrh0eU/RQDC4cQaZYhFjnVw+5AIIg4RhNCU9EnRa1v/oGn55DrVreWQ8W5IWzNaSS
 P+E1H5B0=
X-Gm-Gg: ASbGncur89zbc2CNjsaOO2k5gcN62Z3SzqpuDnQwSks7jp7HjPkz/RHe7u3/4/XMMbg
 t4s3trBuCkGnYkr2sL0FD1lZq69tN3d17gzdJKDxFc/hcyeqIdNMQ80Ic+hykdWA5KHqmPW3KXK
 Hr2jlqroXUjM3mn1ZbFBgnoUPN/ntvhtT2RyCwK8acsZcgIgaCBa7NjgWhGlFu52ZUXL7seyTYV
 DSQ/NAHGF5+tKc70Ukzoi/ZXPRwnvYStJtxZP/sheh1Ijjhs6yuDA+rEA3HChxW2GkG6ybv4imq
 LMZByGYiyGn0tgRFmx1+PDqefTm9EKL58YX3ay8MEd89G0BIKYestJ97UlZUpVnx+8rfkPoEKVP
 zMxAiPwyb7zaw3RZ+fO82Nv/OjEVCT/+9enh0ux/X01JkkRtrAnmR0nU+y5p2X6ozK04X6XOAhO
 mvaIUlD8C3yHPIEQWpXMDqORNE09vyrD8/kmAaDXZcRPh9ww4G3w==
X-Google-Smtp-Source: AGHT+IG3SGLmBIRYdpStkHWWKWGd0dlDvTjaELIhLgLfqXb7SQvfHuwh7YKKUfOy8oJupSVu5zl+ow==
X-Received: by 2002:a5d:5c89:0:b0:3ed:a43d:8eba with SMTP id
 ffacd0b85a97d-42704dab119mr16849419f8f.52.1761224792922; 
 Thu, 23 Oct 2025 06:06:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f5696sm4158517f8f.14.2025.10.23.06.06.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:06:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 43/58] accel/hvf: Enforce host alignment when calling
 hv_vm_protect()
Date: Thu, 23 Oct 2025 15:06:19 +0200
Message-ID: <20251023130625.9157-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index c767e13c212..7e54cf202f0 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -54,6 +54,8 @@ static void do_hv_vm_protect(hwaddr start, size_t size,
 {
     hv_return_t ret;
 
+    start &= qemu_real_host_page_mask();
+    size = REAL_HOST_PAGE_ALIGN(size);
     trace_hvf_vm_protect(start, size, flags,
                          flags & HV_MEMORY_READ  ? 'R' : '-',
                          flags & HV_MEMORY_WRITE ? 'W' : '-',
-- 
2.51.0


