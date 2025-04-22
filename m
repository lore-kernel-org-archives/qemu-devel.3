Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B309C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ku5-00012S-CA; Tue, 22 Apr 2025 17:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktu-0000zK-4z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktr-0000PE-FZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223fb0f619dso65671565ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356285; x=1745961085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RKX6f7o7iwkxpMpurnfc+cvXo1EkE6Wi16DBwDav3qw=;
 b=WKMHvnQOLjKw2bw6tR6aC8FHgfjD8FremBPDk8fibvyfT6Q8XRRnqX/UMCSJZosjtX
 s88PqYkqH/kG2LZaosLR0iCx5Q+A3kGdGP0vBwAJCyy9vnsXE1Xo6Rr+OeW23lx+Es64
 R2cVEAQNlSP1qHhZZgHaje6B65xZK+Wp5dnNet1VmkpqiAmxjJ2AYk6iUB+J3+pqAz0q
 rtodXCf2A5pdVSwCjiX3Ila5AvEO+SWj1h1sRQAygU68Uf43cxXN2VnxsaYRv2xIjFrp
 bvbL2DNWSpU//qx08F1qej2GshNwSzKvwGo/boLhM9ZbdXwum9VlryTu0U+xNSBREIxI
 PXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356285; x=1745961085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RKX6f7o7iwkxpMpurnfc+cvXo1EkE6Wi16DBwDav3qw=;
 b=R0MF96uZZJ+1OKKwhekmgGRy2u0y8xqKiNLBDW28xMvvCuXPBnY+U9YXRdfOf5xPOE
 TMQe4wxaC1pXpHTs93mM4jyYh8r5iJEFHSMk3YDKtnmeO1SaBBCXH/hWQq/Ad7Z4XJaG
 OrGJv4ngiBUuX8zrNCflQBwsqhmd2opRf+EyalY2ib/fShEubim5i2/g91JlfYD5IuM/
 t3wsoXDBs1qXjxL1oJ8rewnRgh2TJWzxgoVcTjBiOGw9VkcIcSBzd5tvx2P73mvj4eLx
 0BXmPARkoQ1G39ZEJyJ89EstKKued/Z/K4cJJvq8ntjJ09dh69jc6pk2Hh/DFnkchS3f
 ottg==
X-Gm-Message-State: AOJu0Yz0Zelkep/T5kcUqcqIb9egbiQu46xlGujT4nTM/+sm9ZysGsKM
 1y+c57JvhXAjgPbakIgCNNmNor72k65tPKQQW2C4EsLKbbAB4wDn+tSS6ZIi3+XbO1g0lEbc8ss
 k
X-Gm-Gg: ASbGncuhwg4oFrSWxdF50skpVO+Stoa6qSP4fvQ9qhXtcvNfPtl7A4ml8qrmtAqdcSh
 tT0eWsfzdl20p9k/u5ure1p4BN7xc1S5K8rjTesq7tO2sWxt0kWJl6Bh6RRtVzr/U1TB2eRS+PM
 qWcv2lnE37WiPNUB4UoLBALdwXqGy6gjKNGDyOH5dovKa3sboo796OmAcZytB8PZbSnzXLX/CGd
 k2fw11Icdq0lOInW8YXWUuBzoEWzJi93wjSWVY6/iIsZ/mdQ5wwWHlTIUW/sY3TGjJEzYM/SYGV
 KY4+cQki9RYVGRUWfpcTZ6Ed9wIzR1ZAg0EhYaO0zGrX7X04CKOkBO7kqKHTz/Mr+gHKFxUPrkU
 =
X-Google-Smtp-Source: AGHT+IFVE/0kAyglYb+fPrdUSq76qIHT3tzVKJT6fBNf7CuWVLKhxKc57d2E9X8VNj0zNJBRKuSJBQ==
X-Received: by 2002:a17:902:f70b:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-22c53625f2bmr260565435ad.43.1745356285408; 
 Tue, 22 Apr 2025 14:11:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target/avr: Increase TARGET_PAGE_BITS to 10
Date: Tue, 22 Apr 2025 14:11:15 -0700
Message-ID: <20250422211124.305724-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 1da8f3a3c53b604edfe0d55e475102640490549e:

  Open 10.1 development tree (2025-04-22 15:09:23 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-avr-20250422

for you to fetch changes up to eba24b60a72115e21e850977b3019aaf037c66c9:

  target/avr: Increase TARGET_PAGE_BITS to 10 (2025-04-22 14:07:12 -0700)

----------------------------------------------------------------
target/avr: Fix buffer read in avr_print_insn
target/avr: Improve decode of LDS, STS
target/avr: Move cpu register accesses into system memory
target/avr: Increase TARGET_PAGE_BITS to 10

----------------------------------------------------------------
Richard Henderson (9):
      target/avr: Improve decode of LDS, STS
      target/avr: Remove OFFSET_CPU_REGISTERS
      target/avr: Add defines for i/o port registers
      target/avr: Move cpu register accesses into system memory
      target/avr: Remove NUMBER_OF_IO_REGISTERS
      target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
      target/avr: Use do_stb in avr_cpu_do_interrupt
      hw/avr: Prepare for TARGET_PAGE_SIZE > 256
      target/avr: Increase TARGET_PAGE_BITS to 10

 hw/avr/atmega.h        |   1 +
 target/avr/cpu-param.h |   8 +-
 target/avr/cpu.h       |  21 +++-
 target/avr/helper.h    |   3 -
 hw/avr/atmega.c        |  39 ++++++--
 target/avr/cpu.c       |  16 +++
 target/avr/helper.c    | 262 +++++++++++++++++++++----------------------------
 target/avr/translate.c |  44 +++++----
 target/avr/insn.decode |   7 +-
 9 files changed, 205 insertions(+), 196 deletions(-)

