Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321CCDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwq-0006Yw-7W; Thu, 19 Sep 2024 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwW-0005SV-KX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwU-00015l-R9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so6862945e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751488; x=1727356288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZCeS0QeY0z/qj60fli0tjdGpJJ8vGB++h8x42DCkDKw=;
 b=RRrmAJ2hgoueDiAevHZyFMfdISEjO3HiCcgodakdtBQrsDVHipslRfJmf2lzTELByM
 Row2wxc1yE818Hw2lfCsB6nde08gwe4lZHxzBXqV52KQA+BvkEI0lswbnpGV+5LrBQZo
 dTzIysPq5XiKUVJ7kTshb3Tv6m90SbCRFjMJNNkr49fdHnDxbkfG/5rybVHXqXl7jDdv
 vFt3THjsu42PUCfwRFoqlzoUSpyhWHdUV1jL251zX5zQh4rgDbZI73xCQs1OGl6C3YnP
 RwXQoc9xyg7rnCOa0VHRNR3UYwcthnULIaQ/yc1uAQw+9kZ7hf8VUUBVFz/yuT4bJESS
 8f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751488; x=1727356288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCeS0QeY0z/qj60fli0tjdGpJJ8vGB++h8x42DCkDKw=;
 b=ge6RcSTSu3yGTCCh7vl+7kRKjbq9evd4oQZrHqEbLB/CsRrsYIRmVuJvuaYCqoZJpe
 IstzS+cTxJtRPvKu8vVQPyXCjhg4cn8Uk/rKCbILlFSPrjoOhw23QVXvwDuykvFv4E0Q
 mAZbBMcY/EycjJ6FrqCncAq9ea6mlBpK+0d25Yf7nwEnTJZEPt7bvu88u9d0Put/w030
 jjfvJjn6J6NBeiodY+2+NWVnmViDFAdHawY1Y/LoadFeUIYZn5X3FCtAX0HE5PZ0Ebfh
 cPN4CvSDQnONuIWbsIEhpXE6wMEv6hxF4veuhvrdtvUocjG2vC4aQu0KZeD3Swor2oyc
 Yk6Q==
X-Gm-Message-State: AOJu0Yxd1hj6enBuHTlPBzNAWmSZTCMkvg9xSaopr7QTfQ5CECot6N3K
 LAL4CPVVZVg38WcrnSujQURM+yQccciP4NrGO+rPZWa+nNcOyIrFNYQOm+AbhuOfKtm+teJdPVk
 d
X-Google-Smtp-Source: AGHT+IGjrzYPeme1g9GeC/M5P7545KXsQyQETUXPnobCw8MjFr3du2AaPKusu84bmUfnOAdB45D9Mw==
X-Received: by 2002:a05:600c:4709:b0:42c:ac9f:b505 with SMTP id
 5b1f17b1804b1-42cdb58e130mr171475045e9.31.1726751488540; 
 Thu, 19 Sep 2024 06:11:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/38] kvm: Make 'mmap_size' be 'int' in kvm_init_vcpu(),
 do_kvm_destroy_vcpu()
Date: Thu, 19 Sep 2024 14:11:03 +0100
Message-Id: <20240919131106.3362543-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In kvm_init_vcpu()and do_kvm_destroy_vcpu(), the return value from
  kvm_ioctl(..., KVM_GET_VCPU_MMAP_SIZE, ...)
is an 'int', but we put it into a 'long' logal variable mmap_size.
Coverity then complains that there might be a truncation when we copy
that value into the 'int ret' which we use for returning a value in
an error-exit codepath. This can't ever actually overflow because
the value was in an 'int' to start with, but it makes more sense
to use 'int' for mmap_size so we don't do the widen-then-narrow
sequence in the first place.

Resolves: Coverity CID 1547515
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240815131206.3231819-2-peter.maydell@linaro.org
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index beb1988d12c..6c4cb263ba3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -414,7 +414,7 @@ int kvm_create_and_park_vcpu(CPUState *cpu)
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
-    long mmap_size;
+    int mmap_size;
     int ret = 0;
 
     trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
@@ -459,7 +459,7 @@ void kvm_destroy_vcpu(CPUState *cpu)
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     KVMState *s = kvm_state;
-    long mmap_size;
+    int mmap_size;
     int ret;
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
-- 
2.34.1


