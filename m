Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4146FC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85zt-0003B6-Gn; Thu, 24 Apr 2025 19:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zm-0003An-FR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zk-000862-JJ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1551392b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537318; x=1746142118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nqXAQYhS4Bh1OmBDa4EVDlQtZQFbRV2hzcZntGGtKyg=;
 b=v1YrOMRWHLG/mrOpHda5n0ZrBWbBpoZwlCy8CUXafj1Ahquz1ocJ2pkMdGGG4wL4Zl
 v5EBYuZBePdD2J9y6RGcfPa6KcL8CySHzqiNxuO3UCgcYWMdnqagWsRw9kIxI7ndYek3
 tfDBE2ULz/PSE9C+qiR9mx89MdOje7bSjN4pMY7LweDH3yzktOJyP6pi156iVHPif6PH
 t/rf9kKvBjiex6byvIW92opgxPb3aTeswEl7ncIDmXs3zOvPi4FE1IO6Nj91nZMaYyZy
 l8YNamlwPrl7S+Fb8Hu4R99+IohLX1UBdRiv1IIL+QAE4RCwDRwlCILSSf+idHrcC9Hk
 VyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537318; x=1746142118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nqXAQYhS4Bh1OmBDa4EVDlQtZQFbRV2hzcZntGGtKyg=;
 b=I5XCZ9p9WhSxqDMfhLwL2AgfIiHT7jARpKIs/+6d7tJYlsM6UTnljGnsHRzLrFs5tu
 06hPYL+EDCBbpu5X1HWCHHSk9Bv0b/ofwu3gmw5R/w5GN1a7/oenc6woOqZJTzGvbz7D
 FaOBAayz60JOkOnBw8oi8ra0rssKU7jsHAc39un52eNjAS90JaxgozzR5NcYg0FYFyFD
 HwaeMfeRUhwiIMptIBeOt7ZQyOZtCqI9QUBJWGRvvLiUsMrg8IvDf/Q40nz8J1kncH+7
 XCIRqp1orUn2gtEXNFXkrCfVhTxmk+jNKftPasjANfpyups02P+9FUDzjuEHSvr605Uf
 pdzA==
X-Gm-Message-State: AOJu0YzKXrF9fYOymf0431H9bO5YXHHHEwhq19Jh0/GAdKSkhBRAtP3N
 HqiKYWnUwIOXLSM1AGto+CKceynfnUyVCq5hCWZ6uFtVtmoTbCIoKk0DrqyY89BF0C99DNM4o19
 86kQ=
X-Gm-Gg: ASbGncsvHlgxwtY/ian4i94QVMlqV55yspnZ7EqpuZNOMk0J15Abr4MYYtEZjPjnu/T
 hLul6SA/lUOTJDzASG91Ud5sG5QGbEpkDn68MAF5MxgP7FZHRZ0uOJQDA7/VJHE9f46HcxE0vFI
 zObAh1OcKgEWK4z5DPu2K1g+RXrasktKaRfNO1MeZj5HVNlO8WZziB66F9Ufg1hqxWqOPipULEm
 GliEIbZZKsBfqkK+3wfISdUqC8El9sw7Y3kYyevEwLvdv1VWsWBwlQxSfAArSt95aMBDbcjvgTN
 TNEsCemwnTLgaSceudCQT/MTdhGhxbO2iD89YdyK
X-Google-Smtp-Source: AGHT+IGynrVcsb8j8FQzQLDggyJv0ZmmjAksc6U5KRwr1rOsEqff65QrOsoQY0/q0tsIBrLI4H1Hnw==
X-Received: by 2002:a05:6a00:1902:b0:736:51ab:7aed with SMTP id
 d2e1a72fcca58-73fd876de49mr111744b3a.16.1745537318401; 
 Thu, 24 Apr 2025 16:28:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 0/8] hw/hyperv: remove duplication compilation units
Date: Thu, 24 Apr 2025 16:28:21 -0700
Message-Id: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Work towards having a single binary, by removing duplicated object files.

v2
- remove osdep from header
- use hardcoded buffer size for syndbg, assuming page size is always 4Kb.

v3
- fix assert for page size.

v4
- use KiB unit

v5
- rebase on top of system memory common series
- make hw/hyperv/hyperv common

v6
- rebase on top of master (now contains all changes needed for memory access)
- finish making hw/hyperv/hyperv common (hw/hyperv/hyperv.c)

Pierrick Bouvier (8):
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit
  include/system: make functions accessible from common code
  hw/hyperv/hyperv: common compilation unit

 include/hw/hyperv/hyperv.h |  3 ++-
 include/system/kvm.h       |  8 ++++----
 hw/hyperv/hyperv.c         |  3 ++-
 hw/hyperv/syndbg.c         |  9 ++++++---
 hw/hyperv/vmbus.c          |  2 +-
 hw/hyperv/meson.build      | 11 ++++++-----
 6 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.39.5


