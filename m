Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD5CC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmTo-0007nZ-0X; Tue, 28 Jan 2025 09:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTl-0007mP-I2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTj-0002KR-TK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so58378195e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074130; x=1738678930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cztkPvSxh9km+ESKvRBcfElc50oeVn4euS866OSUDwg=;
 b=g/hrKUbDRZ7AVGBmJVLbpPOwjUuHc3ttkacePEjqXPWvPziZUc8zZdekcZrmhR4mZw
 dNCTNGOpBAg0JEMuhDXn3M8mNNnAtdnc9tiSD5ud5KwPFArKD7HjWXcjkQHyOHC5jUR3
 oPCBYZb27Xmqy3829TYn0gH3Paw4hpsGMovdoZW1h/qzPfSDhb/pUQvDo/Sk88Qx7yT1
 Y0eHJtf3jSHo1L3Si2sBa0tK+8k6k4pX1ing+GZNVwi9pCKfK/BxkIdJoh3txTVHu0+W
 1lEeEJJdaGEYyLartzDQftwlrfCFE7CBs7lSSeWOkc0J7/p3JPvzdIlZfEYODlHqI2Jl
 9svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074130; x=1738678930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cztkPvSxh9km+ESKvRBcfElc50oeVn4euS866OSUDwg=;
 b=t/BA7hFqbYNiUwA4bJog8IskAS1v5r19fFKcKQ2uj6O2bcbRC3mzV60pMFirLMqRDE
 94xNLKB2NswT/k59y0Bi4/iQ+n0ZXKg3pzOrEGW5AZaqDRD5wYMfZHVLdlQXNo4Z/yrh
 7Yvq5noKZRN61OFCsTXEMEbHJIeN2Itd0j3XOctLZKvrIDu9v2yS33FVz7DjYdiBrJhD
 qyOt0eXj6oXIw4kjl4HiJKDYBzt3W7XPJyv2wctSnp1HV+hq5gjk/OEA2efHJXrWiQlk
 elA6GL/ScmJcbAMhXMzHPCxcNx2ugSNF3G/kM4K42DJ/UTKfvjJNbnOeIfsdc6cDImvJ
 1gpQ==
X-Gm-Message-State: AOJu0Yyw/UDRjSXc8hXo1J+PFLa3ODGAR1CpLEXzEsbdxUy6FjrLxwXb
 ITgNACQ/nCSVLYifiapn9b8KcxN8tBDpbpgqfiden9s+SDRCJHPNqcl5t0weanevZLmpkh/nb6x
 UrdA=
X-Gm-Gg: ASbGnctDOkH2a898Q77CasXZEnc9FtJisBVXWCHVSU5aLt4qMS7yf+iuuq8i1d2bOoG
 udGfHiWEcAXE2j40cgVaXPxN6l6m5Jqv3TuPDzZ1tdwbSfLqHYMK3iAzSxZjQ46KVOooHWFDLOQ
 Vq3ZMX3TUKSZVRs0w9k8+VKcB+rrNk/05jzpSGvlnq9OxHzPtqQkkGWEir9lgqcVpoNWr/RqNtQ
 1oDWsF3ApEOjMLwQ57CRgETdMqNS8O+WSVwpdMQp1nImZrM184hBfLitVNUz5ALSdOL91NkW1sD
 yPsJb1EM87leZ1EYC+ArMe0THOjDI3F3Lgc6xm9inujmwgyu/pG2cunCr/wg/w46sQ==
X-Google-Smtp-Source: AGHT+IHoy1cVhuk2i3/eWFOT57s+jua+XxxBspEQhqzWsAL+PWt7YkjOAw9jQh7HykZ8ESVDxkMIkQ==
X-Received: by 2002:a05:600c:4589:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-4389144fbd4mr437166445e9.29.1738074130042; 
 Tue, 28 Jan 2025 06:22:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa57csm178828725e9.4.2025.01.28.06.22.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 3/9] cpus: Remove cpu from global queue after UNREALIZE
 completed
Date: Tue, 28 Jan 2025 15:21:46 +0100
Message-ID: <20250128142152.9889-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Previous commit removed the restriction on completing the full QDev
UNREALIZE step before removing vCPUs from global queue, it is now
safe to call cpu_list_remove() after accel_cpu_common_unrealize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 667688332c9..11592e2583f 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -172,12 +172,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     }
 #endif
 
-    cpu_list_remove(cpu);
-    /*
-     * Now that the vCPU has been removed from the RCU list, we can call
-     * accel_cpu_common_unrealize, which may free fields using call_rcu.
-     */
     accel_cpu_common_unrealize(cpu);
+
+    cpu_list_remove(cpu);
 }
 
 /*
-- 
2.47.1


