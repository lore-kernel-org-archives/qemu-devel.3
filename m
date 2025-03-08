Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32578C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 12:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqtIo-0006Sw-LD; Sat, 08 Mar 2025 07:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIQ-0006S5-3i
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:28:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIN-0002AS-VG
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:28:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bdf0cbb6bso15437565e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 04:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741436925; x=1742041725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rKLToL0HljXE9F3451qYydYtIjuMR0OHniJhWjbYo0U=;
 b=WDxh1mImZiHNJmH73viD09gTCJ8IJixoVW1ylYznSG2+o+C2zsBC3EG/wOhp6fV9ET
 VU85JMq8QgF/iN9CDOeK1Znx6l8o5N6TlMGLyc5vlF4UoNXcfFDdWvZYLPvAW/486QMd
 jhhcQJ2xRyQ7ZMPqzaEQJqz2aKx5NV0IVGjxcwfEhqzh997MLVTRvKTADmUsWIJ64gJo
 4JePH6ZJ6SnFGaHLS/5eG0yha+PMlSK35BxMknLte+Z3eMYG/MfOAzk3hfzwhHmQEvKE
 Cek+pT/LLLFtGmUKa2q+4oTs/7PMppzPTxKtsdInf33OXehW/RMBQPhQRzuK5rYUT75e
 lVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741436925; x=1742041725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rKLToL0HljXE9F3451qYydYtIjuMR0OHniJhWjbYo0U=;
 b=r7s6f1VfSxk6pQX+gMUoNNWeS4CCyV8neK+OCLaOz3MMbyVgXI9oaC4qyUSVbRCn7v
 scBw1TLWt7/9EFA0ZpXBTAYaPx2t8bzq6Ghf87jDVcqC8BgiS7aLtFMTADU47IbhWFq6
 jnHeqEgslkqfYs9F3fG+CCAIZ40//IHrFBwIqQmEJaYwLAvkSIsN7nZjyBwBuenmGeVX
 +TnRncqhnNr3MjQl6H0eFWRfbk7uNQMRhjzCNtLnX5Jxea0j1mx+FJj4Ka1KgRw15lGm
 5FbOMGzkS2rjXeCvL0ulHl0XcLplX5Xx3Okk/u2Bom+ZfwQP9wInofB2Y8ZLSYuMLm3U
 9KhQ==
X-Gm-Message-State: AOJu0Ywmqsgnlkp2s7OB1HgUWMNeXOyjTswke9BeMKmtl0bm4yOlzGDU
 +0wWYLl7Jy2pTkwsi2ZhuAuzKFDb46eQHkxYn1vGaX9TomvD/QJcYniqlTiVWcoY78SuQjOlbKB
 F9Rg=
X-Gm-Gg: ASbGnct4VEMFNX7ygytQ/2fM8b2EoPZfS05Qf0bOTqM9oKGIu8xVoNfIB0Mei3JSKZf
 F5pw2KIsIMqIeUnWTc+GaUkrcXfeacZ8RA/JExQ1wD/K/4O+kQTrFO/HDfwcVbz7T2CvLLkGJ2N
 TDD1OK7OHIsjRtdZWMF3uwCTFMuIsq6f8jq/Cz7MQF7/xrWjNKqoNNh+jBM621e1JOWEudLXW+5
 FEasMFMQuo9Pe3LP0mbV1gbxTSzXasjISboCI7K/UyzX7wgKByDAiTBpigc9/BZgLEXDAp/NvpJ
 Vdey+blX+ynDlmwEyjepq60P+zVgB/5PJ3/IAWgSZiZk7PwdAmgtLd5HwCBqK0BttQhkCNbRF0z
 mLfgIZfjOk8sQndEm/QjD5B8GqpIesQ==
X-Google-Smtp-Source: AGHT+IHW6+sLlUn55dYuqRyZmJ1uGwiIoapjlWpj3JEXuL0v4EIJ1qIy+CvoT+qsauxiEwz1tD3hnQ==
X-Received: by 2002:a05:600c:3b1a:b0:43b:cc87:374a with SMTP id
 5b1f17b1804b1-43c601e1294mr48380895e9.18.1741436925080; 
 Sat, 08 Mar 2025 04:28:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da097sm84523915e9.17.2025.03.08.04.28.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 04:28:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/3] user: Extract common MMAP API to 'user/mmap.h'
Date: Sat,  8 Mar 2025 13:28:39 +0100
Message-ID: <20250308122842.76377-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since v2:
- Addressed rth's comments

Since v1:
- Propagate alignment argument to BSD's mmap_find_vma()

Philippe Mathieu-Daudé (3):
  bsd-user: Always use mmap_find_vma_aligned() in target_mmap()
  bsd-user: Propagate alignment argument to mmap_find_vma()
  user: Extract common MMAP API to 'user/mmap.h'

 bsd-user/bsd-mem.h     |  4 +++-
 bsd-user/qemu.h        | 12 +-----------
 include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
 linux-user/user-mmap.h | 19 ++-----------------
 bsd-user/mmap.c        | 17 +++++------------
 5 files changed, 43 insertions(+), 41 deletions(-)
 create mode 100644 include/user/mmap.h

-- 
2.47.1


