Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064BEC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0qk-0005dn-OV; Sat, 09 Mar 2024 12:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj0qi-0005d6-Re
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:08 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj0qh-0004tG-15
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so24095805ad.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710006665; x=1710611465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e0zeSC9WXVrqvIpbDPDV2Su3028qgzSpAZtssVGmENo=;
 b=im7q4+cF6Nd1DGUYpN0vJOPpDfoAuufLaWgEMBQYIw+Kq1OjeJSE4Eepz3VEmsMG3C
 MmzEUC0gWlwrLfN0+m688m6l5f5jNWyhjpvlWGZXUxnvIPBPXm4OP9F5oEu3nqYEvWt3
 AiMffpS03dxjCUQtz4lDjy7CtHFtyF1FTHbrh2NBPqljsAVuZy4R9wfc9Sfu2Oncozfu
 QQxZuKIPCXaJ3rPGxPhLIsZ35SBjo/bL0Jrs/QzelJUN4zZtfivNMK9Q43stBHgKVcPx
 fBkaPeegMftEp5WF/59R59iP2ky51cs9hIZmnMfdFUDcNaaUsaGxnj2ZVKUh3oJpG7Jh
 izKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006665; x=1710611465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0zeSC9WXVrqvIpbDPDV2Su3028qgzSpAZtssVGmENo=;
 b=ov5LKkPXUVC8PEsKaRW8i3BVqvxGe70ECZrqHxmO/o2xRinnvw3QIXJRsRUFFHqbjC
 MDJq/JqHQDNH+5EGxx5tu/BU7PLOpZeW+m8s/sAul9MLwfcHW9v+hzy8MNuBP91QfJiF
 3H7jlsKLbWj09rCZd41zJ9NNurjXcIRq9Fu9H1ZCcuDSat7if6BLDPEFZYbqgwH+yCY6
 ESb7MZb8OOVQsBqe9MB8yM6vkzPUvK5UYUud0qoZFsB0e2R0l1LTcR0k7OQoN+niroJT
 qqp9cFaOqx8zz/8w/9wGLKQyZ7FsQDUmuWeCd47hCqSRZdcgLycjTV/BZXjcT5SUBave
 SHjQ==
X-Gm-Message-State: AOJu0YxyNrwPq9FKwyLONudXQAyEdR+YmKz+Xc/HtNaaLHB3iPWUWgK5
 oGvdDwdFkPBP/8YYXcQhU2i5BkSsZxf6d1STEipblv3jwXk9auGm3zdhQjvw8gZM6uBSSh+6rvP
 C
X-Google-Smtp-Source: AGHT+IHEINiToxP7EfraC24K84I9xyhd3SvqVIlyEf8N2WmIAzIdm4QwKU0MRbu1DYLUqfHVjJRVMw==
X-Received: by 2002:a17:902:d315:b0:1dc:db57:d6e2 with SMTP id
 b21-20020a170902d31500b001dcdb57d6e2mr1840092plc.69.1710006664904; 
 Sat, 09 Mar 2024 09:51:04 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b001dcfbbb1ddesm1578556plg.7.2024.03.09.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:51:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH 0/2] tcg/aarch64: Fixes for test comparisons
Date: Sat,  9 Mar 2024 07:51:00 -1000
Message-Id: <20240309175102.726332-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Oopsies exposed by Paolo's target/i386 changes.

r~

Richard Henderson (2):
  tcg/aarch64: Fix tcg_out_cmp for test comparisons
  tcg/aarch64: Fix tcg_out_brcond for test comparisons

 tcg/aarch64/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


