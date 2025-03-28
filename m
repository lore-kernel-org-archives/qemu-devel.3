Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BCBC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGic-00069q-Bj; Fri, 28 Mar 2025 16:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGiZ-00069J-D9
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:54:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGiX-0005om-EC
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:54:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227914acd20so58766675ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743195255; x=1743800055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzXDVlHz+CqgdRhxXJluD+mzWebhzxOJniT3TOye1l4=;
 b=UgBnVQeBboPCZ97983GHvEvvS6qeJtd+JbYmJ3QKAtR6M52RoxhVirSDDh4GFMWl40
 13Pmk+cMBnodw7eqd/2ClORSoTvmp9JCxPr1sRIeturAASy7Xbshd5viGdoHn4H2zd2W
 iKqxfOChst//Dvm0+rjdEZA8YVLp7QNlfO8mF/WXFAFtlvRU/nHOGT0eHFfZm4rKVrgx
 8b7iAKJgsjmF/zqRqgkbsmZgm9tj1ykt8MuO+vTQXSUf6l5MQ1aXe0kPXqvMX3MkAFbd
 ErU9HOGpNtqiS9jdYLyHXI07V96os0iOUc3lzeYRxGc9eNMHk+lWx7gAFFJMVojIsdTU
 FefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743195255; x=1743800055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzXDVlHz+CqgdRhxXJluD+mzWebhzxOJniT3TOye1l4=;
 b=CLx2ng6PeljqclTV/jgfjAB2NHHEBvMOAIUtIlVAb/5TtrMw5Q9gyXdDylkAPG+it1
 N7eeX/joUnbPtg/AlOqJ512Vb5u0IX5q7LFvdlmsVC7aIbfgveInCTBPK+2GrJx3h00y
 tSCpYpmnQVRDBNU5KVE2LKE2gbmB4UUFoTLozwND77MsSpt1/dixNL4jJ41/BrekbQuE
 b3/zaO4+tdKpg5zz4CtkYBOFYVRhE0EariAonCCkklXRm586Qf2HcdWrEmWMd9Pg7doE
 fbunXdZMb+4qdCEWqL+OTC8QfwRMdCgrPf9M6Gh9mEiJk5Pffb89tqgGSvclqHe6RfNR
 xvgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1VmQ0NLq0d6UVcS6MSCJmyIBxMwdoZeOJT/Lzp/6dMSXHPY/2KI9UlYWTZ24+4r+lhu/OjcgYo78@nongnu.org
X-Gm-Message-State: AOJu0YwRhzIvvxziPZWSkBtRCHvmNay5yyAUtrx8NkpkfCVgK7iCekhk
 YoUzQCPxR7nNM21lDBdWLPli2KneMv5iVEGXw8isn5XBDVBfNAkS2EJlYXF8ypeVfTXb9NfPLza
 oabQ=
X-Gm-Gg: ASbGncsrYelIwO0SbV/z/fhtvlu53g1+oHLAVG2gWxY+C0TTj13HKuKJ2lD0aBZhCTm
 zX9INOpckuQwQS3NfrqyoE/YOhDI8xejGtoNtOqovRTtbnktXU9PZqAa97gNRSFhPIUdcdfA/3B
 ODmQUPFkwra96VYOK/wShy3+q8dBTPeLk30McJqud4T9J59X0qDwnN8Wk0o/MN8Rx3DseVJJ2Oc
 NosZcOSZaF8q90pusr+za2MYQ9ILGS2x80H6rnyuWCf13DNH+dfG6QUHh2/Z6bK/oAagl8G0bCs
 2woh6c1hmfX0wadLnd7HJqGW6cWHBmw7NKj+CHWZyDCrq2iip+sG7eUb0Q==
X-Google-Smtp-Source: AGHT+IFE+Scskz/hikVpB5j3RFeLpQj1REFpWbw0W0tTIKFsG6dAAZQfNLhzHx9/lh7lz21H5noBoQ==
X-Received: by 2002:a05:6a00:1151:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-7397f369169mr1847327b3a.5.1743195255369; 
 Fri, 28 Mar 2025 13:54:15 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e51a4asm2275958b3a.81.2025.03.28.13.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:54:14 -0700 (PDT)
Message-ID: <97cfd98c-4351-42df-be07-929f25268f31@linaro.org>
Date: Fri, 28 Mar 2025 13:54:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] single-binary: Restrict scope of TARGET_PAGE_BITS_MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> With this, TARGET_PAGE_BITS_MIN no longer exists outside of
> page-vary-target.c, as that's the only place that needs the
> information.
> 
> Based-on: 20250318213209.2579218-1-richard.henderson@linaro.org
> ("[PATCH v2 00/42] accel/tcg, codebase: Build once patches")
> Based-on: 20250325224403.4011975-1-richard.henderson@linaro.org
> ("[PATCH v2 00/11] target/avr: Increase page size")
> Based-on: 20250328175526.368121-1-richard.henderson@linaro.org
> ("[PATCH 0/3] target/mips: Revert TARGET_PAGE_BITS_VARY and bug fixes")
> 
> Which is a lot, so for avoidance of doubt:
> https://gitlab.com/rth7680/qemu/-/commit/c8b593f1a907794b5767274cb3f5c70985638397
> 

I'll rebase my hw/arm single binary series 'single-binary: start make 
hw/arm/ common' on top of this series, so we can continue to expand the 
house of cards for this topic.

Feel free to pick the cpu-all cleanup part if it's interesting and ready 
for you.

Regards,
Pierrick

