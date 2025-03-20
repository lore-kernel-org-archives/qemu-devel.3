Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D776C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHLx-0005Vk-GF; Thu, 20 Mar 2025 10:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvHLr-0005VT-3K
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:58:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvHLp-00020D-DB
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:58:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224191d92e4so17546945ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742482705; x=1743087505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ryaQB3/HiKSJqoH6U97dmRBk23y3Z++N7PETR7mKUEE=;
 b=kGdU88wjiZZwPztPx4AusVtt4A1jtll06D5P/2Py91d3J0E8/kvUX3hewip3MDoEPe
 4wiBLVbxnubUqkqyT9F+OYaUbgIa4qFKURS3k4mmqg7m+awoX1tGWk8nyV5jV07VYvrK
 40T5POGO1jOMKgBHXOyWuOpo5pCPZBZLXKO3zmFyK4L6aVIe1MT6JWdwkmBdO+JrluMb
 f3ISWCy5T3sZcE5Z2IBkTUIUvo7brvLcFhIAmcS8vV0RMYws5RADHfDGAz4mTfrKVHxs
 pWrPogv4QH85rFy7IQpDWlxQpjK07TtO5KEF0ufzH4raWweZiIBbKXTAzBWoXPNBHv+D
 OOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742482705; x=1743087505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ryaQB3/HiKSJqoH6U97dmRBk23y3Z++N7PETR7mKUEE=;
 b=cD06+lT9oG9iKRp4tclLlL3j6C8B4eOZqj0d6H9RnhCO2rSy7wWU5NYCyxiSQws8sz
 T4H9NsmT3rQHltI1AQNnHgVEh9aIQ1NCckcSTczRPln4waU9alUn6SxrqbRrQjKI8rmP
 ucRRiJ3CDRIPE4+yWC4v9Vh1I1CzDK0ImjDwHfpAogyB6SgmnGNh2VwirqQalSr3x+uN
 0fasx84IKqaYtANoc1nshFx9NMsiwCHjcWgeiKsN9bKWqOuorAIdkKEgqrA9+MP4oRFT
 H4SeEYjMOFMnDvzmBlsriMF/lLsfghFvbuIKrWi39I6Gs9o5jhFV/c/dNVqd2/qXDKmL
 adzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0oTi3oN/LvhyWXeDYwtBSe047vFtUc3RxkAB/QA4+kZu2h0xOieQDKQaFJaFEedYRONlVLAkGBNgA@nongnu.org
X-Gm-Message-State: AOJu0Yy4AzSVz98Mlr3sNwoWQSYWGNpNz6H+ce1f5+MTDswjWHCtAUD7
 lg7ZYX1NX84gwp41SJfGPqrgBmr2EGxXnegFAP9KUwy7BZlDQ9vxAtpOaK9gYFQ=
X-Gm-Gg: ASbGncuq1rFyg1ykKfoZZ7mkEVm1QugjIBt/BltbS1dtBWvXZLdnGa0H++OhSlPSOwr
 ZrMHbrM4j/GF8UQBzq8Jm8el/P7kuol5qYQboQ1C2xFuZO4L6U8uR9HYPN9+K+aqb3EbHDE6mS8
 7brjMQCR/WpjxUnUp4aj+rXDw9F0mn2cj1JlNDwFv9IhZHbrMoEsChm1gbmN2OhWwxVEkfSSJ6O
 2CDdsxUR4tDzzVy2VcAvCrrucIvn4FOvwnHfbF1paA1MsZUywjHZD8yBowa7Wm7xQuGbGN+bpy1
 BajHHUf5oldzZC32UMSamTKWupmVR6xTCaKyewjWdFnt0c4Mdob5ooh/SD8c2SJr
X-Google-Smtp-Source: AGHT+IGkh+EOGmDd/FVM9hhQCB8RN0z4mFPkf46T2MK09UkXRcj8weHKVLXk3m7TiHjQWVezjHZFBQ==
X-Received: by 2002:a05:6a00:1885:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-7376d70bb8cmr11560587b3a.20.1742482705373; 
 Thu, 20 Mar 2025 07:58:25 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ca2ccsm11038708a12.14.2025.03.20.07.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 07:58:24 -0700 (PDT)
Message-ID: <9843f1ba-de69-47a1-9fc1-5dec97329469@linaro.org>
Date: Thu, 20 Mar 2025 07:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
 <c76d7019-7087-4522-9b49-bc99fa71436f@linaro.org>
 <b039499c-4c0a-4eb1-ae74-ce1fe5386f20@linaro.org>
 <5dd0a559-388a-46b8-9479-5fdd5a1e8f81@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5dd0a559-388a-46b8-9479-5fdd5a1e8f81@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/19/25 10:16, Pierrick Bouvier wrote:
> If I understand correctly, this is simply an (arbitrary) choice related to each target 
> architecture implemented in QEMU, and it does not match any property of a *real* cpu. Is 
> that correct?

Correct.

> In other words, it could have been implemented in a way that MMU_USER_IDX is the same for 
> all arch, but it hasn't been done this way. Is that correct?
> 
> I'm not looking for modifying anything related to this, just want to make sure I get it 
> right.

With minor effort, perhaps.

Take loongarch64 for example.  The system register field CRMD.PVL contains the priv level, 
where 0 is most priv and 3 is least.  Simply extracting the field is the easiest 
implementation, so MMU_USER_IDX == 3.

If there were some requirement that MMU_USER_IDX be 0, then obviously we could rearrange, 
but so far there is not.


r~

