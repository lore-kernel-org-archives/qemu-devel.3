Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E20C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClfv-0005bg-BG; Thu, 30 May 2024 15:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfu-0005bR-Hg
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:42:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfs-0006HH-2n
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:42:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42120fc8d1dso13738105e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717098171; x=1717702971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=65gU5Nwavd2bAlOw69K09QPcTa07oz7htXi9Z4Z1lS8=;
 b=kZ2wpcUYLW56K9PnAbqjplmDl/2DOX0/vfKZg9jsbva4+QdKeGmQYpGfW9hmymmHh7
 7p7HlGUzsW/fW06QvxPSu1OO+SPw0WqXGyzOjKL3toUuOF//Nkm491PPrgnX3yDddbF8
 S4K71CbAgaAqWFTs5KXbXfEpIPMdnk+j0dQVA+7J5hOO/99/GEEsr+cgfpWofabkFrB+
 Ng4qZWBTWT6DgPHSzVVfQEsb/GetyYj4s3Ma5u+MGhogS6y7d3PY1tVYM/J7v8jPcYWO
 sMDxWXytuaH51XKbsA0k65lQZJFG5mQoQgIsE8tDTs7plHwcjKTnHIggwvvUSdKKF6nD
 DWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717098171; x=1717702971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65gU5Nwavd2bAlOw69K09QPcTa07oz7htXi9Z4Z1lS8=;
 b=A3LUAoXCHkoxF8d44Cpxgsv6QLH1FpVf/aCH7n0cZrPaXCgYj5wY8YYAZExDnhQl+7
 4FkWXXsD1SdlfYcfUbEboITBFG+creRFnAVcwK7HgK2vCwdyfF6bnH8vTCQAvk5efmhy
 lMGL2H4n45/CntSq8q+SRoVH2yUwpa6eBCpmBlEAt0fWo7z7awDhUncAMEUXcMkONldL
 z59Xynn1zUBMxIymdQbB1tOlkqUce6DT5rNpcg/gJbp0qVhlBdke9DMhZ/O5PcPmYDYO
 OJOXzbn8lkVWPC66Uf9x1Cm/hb04A+xDikLDrYSEpW4R0P0E9RHQUyawroR2Lq9SQ5cN
 AcGQ==
X-Gm-Message-State: AOJu0YxQiMc8Hf0eNFe3lvKbfCIgIGuEVMat+1SBxT9v0cn2uXL34huK
 iWuHYHASZ6ZkSD+J4TEuG62GDuKZbh+oLCn/9ZeQfuvrr/iYQeUSZ37jEnMMEWg=
X-Google-Smtp-Source: AGHT+IGnhu+Xh1JjChr4iKUj2Ca55eLgAratzb7EDCz14TwRVJ/zNB6z8fllVZMm/qeVhs4rR5CTgQ==
X-Received: by 2002:a05:600c:470a:b0:41a:e995:b915 with SMTP id
 5b1f17b1804b1-421278130cbmr28854985e9.1.1717098171508; 
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb8253sm146492a12.29.2024.05.30.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D54E5F8CB;
 Thu, 30 May 2024 20:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 0/5] cpus: a few tweaks to CPU realization
Date: Thu, 30 May 2024 20:42:45 +0100
Message-Id: <20240530194250.1801701-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

The recent IPS plugin exposed a race condition between vcpu_init
callbacks and the other vcpu state callbacks. I originally thought
there was some wider re-factoring to be done to clean this up but it
turns out things are broadly where they should be. However some of the
stuff allocated in the vCPU threads can clearly be done earlier so
I've moved enough from cpu_common_realizefn to cpu_common_initfn to
allow plugins to queue work before the threads start solving the race.

Please review.

Alex Bennée (5):
  hw/core: expand on the alignment of CPUState
  cpu: move Qemu[Thread|Cond] setup into common code
  cpu-target: don't set cpu->thread_id to bogus value
  plugins: remove special casing for cpu->realized
  core/cpu-common: initialise plugin state before thread creation

 include/hw/core/cpu.h             | 18 ++++++++++++++----
 accel/dummy-cpus.c                |  3 ---
 accel/hvf/hvf-accel-ops.c         |  4 ----
 accel/kvm/kvm-accel-ops.c         |  3 ---
 accel/tcg/tcg-accel-ops-mttcg.c   |  4 ----
 accel/tcg/tcg-accel-ops-rr.c      | 14 +++++++-------
 cpu-target.c                      |  1 -
 hw/core/cpu-common.c              | 25 +++++++++++++++++--------
 plugins/core.c                    |  6 +-----
 target/i386/nvmm/nvmm-accel-ops.c |  3 ---
 target/i386/whpx/whpx-accel-ops.c |  3 ---
 11 files changed, 39 insertions(+), 45 deletions(-)

-- 
2.39.2


