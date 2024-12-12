Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2728E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLnVE-00017f-Rf; Thu, 12 Dec 2024 13:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLnVB-00017M-VH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:01:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLnVA-0000pq-CX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:01:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so9900525e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734026484; x=1734631284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DNCVz9q9qurO1cSKC2aWcAO2shfPJ39BVTV+dyoFkA=;
 b=UjsKhjCMXN2MnfF1q+PVgEx0W/lkIn9vT83HVwSzTcF/1ugQfnY01Q5NE/1aYuoUnF
 CCs1RjKRlQMkSpAXPVEC76Grh/F6XoeUMuozPWmNQH6EchxCrqQOlIXSWs+HeHdduxQw
 4UeC5KxVP2n8c+VjP26YHnEjFrC+5djmJt9+5FoSDVPZo4KysHM2pBqrk2BaF5r25r4e
 0sxaAWRbnKzPyCdNTWhM89Ebx2Df7gCPap+lLlynVXF5S1L4D7tDIZ1wFRh2NXjGdbTS
 XraQs1C6q9NQYwpMgdWPUmJL7rNhF2HJg23C55+60COo3kiJCSNpRjY8NX/7C7LeS3tk
 pqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734026484; x=1734631284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7DNCVz9q9qurO1cSKC2aWcAO2shfPJ39BVTV+dyoFkA=;
 b=GYWJToAl9RguuDLYwXWWnx6u5QHb2Tj8GHvtlbTSeXvVdEqQCHggdN6r0pc53FoCVu
 USz3gCRggiIJTdqpcs1/mKe1YGeQDY7B9sZQeaA5OSzYl741Df5hTzHKI0lXxu6U318f
 DMred9/FFWrikPstZb81IeWVQKQJisuRRbSWv+JYpW4hzLorOm8XYMTmnZV3vhOyTuec
 Vn5JCIVnILe9xdd5dQhzW1c+t4nYZpamrJf9j46VPIhlayb1ZmM5LmvOBvrlBYJLFCNa
 oKAiGPVCjN51740WhmNlVpQplDqUrTKbOkAdjeP7EGnqMfWDop7MtBshjfnb/9WVMpNx
 rMyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ihwFDQs9ho2VWxFAUvPFlO3WbEo5ThGwJq8qDF3cQcmDEDyswYQtrBhxU8YFW2O/FTyp8IBB3VGr@nongnu.org
X-Gm-Message-State: AOJu0YzoCn+nmrTk95IPQxzvG/6cAHFH2pFBL6FzEfqw0naffzkNE23R
 5KAM3/7iRu5au8W0jhKjGkB9c7Az+/VEXAJIvj/noPqRZ1sWhvGK/Xm5G4Hq2Iann2ywKp9u7WX
 j
X-Gm-Gg: ASbGncvJ1hqB5W4UyNggGWgiIJXrLbjmYDQSuZ39mD6CxlqPK8xIRTQQCeN0B87A4/I
 S5f5Nq/2CtTVqcrGVzANAimCFhjnQPoEnOAiGGUQe/tOlOW/ZtFBB6uxGLlGAfWaEPT54/rZ5T+
 eQ5mcIV6nYJGiRqQE/YIlHoke4TAdQdl8t7foB2pcRJSQGMBWvD5PFKAVv+YCIyNwvRzx3ZnWWs
 ie47M3Qrd7F0maY9HPKcn8X/S/OQxwrdEavKEKSu3VOgu81dpQba5ZAUrvS3ko/ysLaufGdYFJh
 agSmBjtrJNNuY2cdRJn3hAm9
X-Google-Smtp-Source: AGHT+IEVe3DJg8pquGXPT/MNga0gIsUC/ybCBQKCWZ1q9nGtBgN5DkdzhaNG1YE+HF+TAC/90sMoDw==
X-Received: by 2002:a05:600c:3109:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-43622883cbfmr44790865e9.30.1734026483856; 
 Thu, 12 Dec 2024 10:01:23 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ec08sm23719505e9.22.2024.12.12.10.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 10:01:23 -0800 (PST)
Message-ID: <747e6611-ca81-4d5a-af3b-fddf51e4409b@linaro.org>
Date: Thu, 12 Dec 2024 19:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: consistently return 0/-errno from kvm_convert_memory
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com, binbin.wu@linux.intel.com
References: <20241212155719.524637-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212155719.524637-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/12/24 16:57, Paolo Bonzini wrote:
> In case of incorrect parameters, kvm_convert_memory() was returning
> -1 instead of -EINVAL.  The guest won't notice because it will move
> anyway to RUN_STATE_INTERNAL_ERROR, but fix this for consistency and
> clarity.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Please include a brief docstring:

-- >8 --
diff --git a/include/system/kvm.h b/include/system/kvm.h
index c3a60b28909..923bb07d73d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -576,6 +576,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t 
flags, Error **errp);
  int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
  int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);

+/**
+ * kvm_convert_memory:
+ *
+ * Returns: 0 on success, or a negative errno on failure.
+ */
  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);

  #endif
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


