Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9159CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPWm-0008SY-U7; Wed, 27 Aug 2025 19:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWh-0008JT-0n
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:26:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWa-0005BX-5y
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-248cb0b37dfso3286675ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756337150; x=1756941950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haA2NtyjzC37WFb40NMVWFRJEWFIj1glU6vfYtJmd2g=;
 b=TW5CTJFSZgqEX7jYmZor8/ILq5VMaEFbdGpshR8MrVN/zQBUygsG5FIeIfK3/V+DLD
 Yld991x6T+RDlKN6RKk0pzKVsb3YVw44G6KG8w0YMO6Tnq2VVPhIRHKzbpsuXmQJ3t4e
 xHp9y4S+eimcPf07ASA0gtON/vNabCeQU7rC+jhj4CmZqvqxPPKwwvxExxsA4fIyDkUp
 2qMbOVgVvQAy1xqXHfeRBJq8Y/c3Paa64k9YuT7XPQixhaomlj3sZZBZGzFLizSNpfcU
 5BMMoKNkA3FthEkuoXBMyMMOPGYpMIZcfSvPU5x2h/cOMZcEIhlgxY9elrx6AUg5jsB5
 XcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756337150; x=1756941950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haA2NtyjzC37WFb40NMVWFRJEWFIj1glU6vfYtJmd2g=;
 b=azVkMyrPPP6qoYpUk+CSV1ZM7vLZXH8IX5PAjspuVyj0zN7TmO/IspbaNeoezzBPvN
 KBFftb1z9LQs1DDj0xoKohp6LJiRRECpuZSmBM0+zGuT/Er1Yy2h4r3mOCxymuc3Dr4f
 tukBmWFeqiqaw7E3AYWMFEbsLqeRR8BUXSK63ytaRRVedJWhu8qQ3gQHdT6sdWoXVxZu
 NEl3QnUaqwP3KDNtPsBoIW2SSHfnTFjIsXuPilYp6N3Jq3L6dex55Mz6uNtHIUarR72A
 vxpRVYpFQInBmcOxCSfPTxNSnf0RvfEKfLmzbVgE9c+no9Ik7k41x5gu2EXoyiOOxCx0
 5Vng==
X-Gm-Message-State: AOJu0YxvKv4Aa0iatbHoB6cyFTYy43Ev3XnuksqeVQ6sRe9ezcsUtBER
 hOm7Huo54cbNEre893A7szPh6SyU+2uG9BpHyrXTvF6hHnqRiVxi4lyezOK5QlKE51R76U2qNPw
 vbMBV35k=
X-Gm-Gg: ASbGncsAQdGIC854TMfLfNSnIGndHk+hZKNWWkiNn0q5zIc3xVIV4rFCGpWyjKbN3XC
 OTX/oPYTYZ9ZdEZrBRwStP7UEHVx/EvBsOuHv3UQtfQ5wINoxPC/E9hFBQN9iahZ4N6jcmgYfZx
 q/T2zdpNQvcb7NGr0FqiTfsRspZ040mxGLblkhlT64FVYbymZCsbhjdKKF7qQtjWYkKggg7xaIF
 LQ4RigLCcYr++tS9iE0S52LDinVet3YxZz2usNG4Y9N+fvrYg82kzvlOnOp5s40Aqv8Gr2g0eA3
 njJKQP54n3rUpBxl1kJGw0RiafpPn5vv2otlmZIaSeC6QF/we6QYnur7Wwu3Si1VwHjfFqIyld4
 daCWB0qpQZAIyGWADvlBK8pqkoRfffGf6AP2d
X-Google-Smtp-Source: AGHT+IFtR7ouaDwumS40uehw9I3SFpCeqZGyCMaxDTku8bGG9OQ9Dp1/gCvfzek1NV/UbSqS/fE18A==
X-Received: by 2002:a17:902:e78b:b0:248:98a6:fb55 with SMTP id
 d9443c01a7336-24898a6fc9dmr55281535ad.16.1756337150510; 
 Wed, 27 Aug 2025 16:25:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248cd627e40sm7282025ad.94.2025.08.27.16.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:25:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>
Subject: [PULL 45/46] linux-user: Add strace for rseq
Date: Thu, 28 Aug 2025 09:20:22 +1000
Message-ID: <20250827232023.50398-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Joel Stanley <joel@jms.id.au>

 build/qemu-riscv64 -cpu rv64,v=on -d strace  build/tests/tcg/riscv64-linux-user/test-vstart-overflow
 1118081 riscv_hwprobe(0xffffbc038200,1,0,0,0,0) = 0
 1118081 brk(NULL) = 0x0000000000085000
 1118081 brk(0x0000000000085b00) = 0x0000000000085b00
 1118081 set_tid_address(0x850f0) = 1118081
 1118081 set_robust_list(0x85100,24) = -1 errno=38 (Function not implemented)
 1118081 rseq(0x857c0,32,0,0xf1401073) = -1 errno=38 (Function not implemented)

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250826060341.1118670-1-joel@jms.id.au>
---
 linux-user/strace.list | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index ab818352a9..51b5ead969 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1719,3 +1719,6 @@
 #ifdef TARGET_NR_riscv_hwprobe
 { TARGET_NR_riscv_hwprobe, "riscv_hwprobe" , "%s(%p,%d,%d,%d,%d,%d)", NULL, NULL },
 #endif
+#ifdef TARGET_NR_rseq
+{ TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
+#endif
-- 
2.43.0


