Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B557ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3s-0003Dt-Hm; Sun, 28 Sep 2025 15:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2x3p-0003Cp-NQ
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2x3d-0004DE-1k
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77e87003967so1877677b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759087653; x=1759692453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VlD+WdcA+JLTreAT/pG66awwZMoZ/4YZ72FaKfp9294=;
 b=L+NAU70UHW0AthoBMpfdMEKqyGLNg+SXeSsuEZqzhB5hHYWlDyKduRdkirNuNfOI6K
 ghSW6yU4/e+1+AXAR6ZU86uUTNudegSeX9iSYQN+xkBievwbT0aqy6H8ClQ8BYwpDDBN
 AHrbc4AVqHPtczHu6ipyn/TwOiKJHKFxOV5f/I7WvhLOpjvJfhpkLZRDfqUMtKChW1Ub
 FPOIDIF3a4QUjKrymPgKqwJnZLcfQqPw+hV1ZybSa5RersNGDqChBi/LRjt3B4O+Ygmi
 VXs1Xoc8HzwikUUKH2jE7B440uuQamMoQbaLgFgHR67tQTboBpeqEWG+1U4ngllhDHeA
 A2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759087653; x=1759692453;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VlD+WdcA+JLTreAT/pG66awwZMoZ/4YZ72FaKfp9294=;
 b=Igu4MslEye0r4S0SaCUf+7WMpbPcO7K6xBs5mCRxnSKI01a6C8IakHVHfsRmD1o5jB
 W+HwVtBQr81b4908NKep5RmEJq12p93c/ksytk+HWTKH9lSf+34mXKKtf7IM+QYBZqnJ
 1S12QiYqYyYaizM2jOqCiP8/M1GEG8dYccvaOkNlj8za/CIzIkMfyh+HS2Vu4LDmwkIM
 MGI+XRQJSJ8f6jxuaX44CfTVaUP0AUk2Wv4ktjf1l6MUsEU29irMHL447Zvk2+9CEYz9
 2fBOolGnQSb3TKKC5xdrdpfxBrNo5pMD+/+GUQ9l8jsrMqO7q5jIqzN3cktph1mSO1S2
 Klhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0n/mv2xbLVA0TTeA5X0W3onzczCB+C4IplGzqO2wKeTMpIb1NrTL+eTyrG1U0q/cBMm67dIEcvm0u@nongnu.org
X-Gm-Message-State: AOJu0YxmXkRvbEY48GwcTswYIW8WoffpIz8VuifvEC5fRw7TqWVNJuPy
 8eAJb4hi8lfusbu3QDNs2/ap7EQNA4W4pZo01Ka2k/6eH3oc6URRiAT9O+13GVgw7jA=
X-Gm-Gg: ASbGnctCmdaTOJy9BabLutcDo/KbPnAODqSj0ohn+ofeTojgum3oYURIBKPfybMx2Lv
 zkjOAs9F9FNmFvzrDsDRy/ColbKs/z0nmnD8qqKG0sY0zc2sJRSI5f6gTX+3B6dDtWxdPZkzhoE
 6wVF3afm1CdEE8uYlZxzfHO5XeEjVdSgKJd3NFv22nXdAbQrJubxETJp4XRLrFn7HqQDrAgHial
 /P7+QoZa+yu3JNI02+Xur/Ghz4HB3wHB05oN3FtKgYjRDhtyMeC66lyZdUm0aW1iNCoWGCg0lih
 HB+r9IsXoq59cmS0gn5mg18X8ojNTk2GcfXUFp2BAar/XN0Uwelyi2TKjQ8yksByd2tb6Yf7oyz
 YCCoQcqNLLYkvyiupHIY+BdHZmNDwgnHBADh0wtNu6VwnALk=
X-Google-Smtp-Source: AGHT+IFE9VLXf4WNHo5LbX31fhQSnzU8VbJmfSQtw0F5SJxp1vYF+R6lj7rQtrg6gsMrVfMKcZc0gw==
X-Received: by 2002:a05:6a20:158d:b0:2bd:2798:7ae7 with SMTP id
 adf61e73a8af0-2e7cdda05e1mr16988677637.31.1759087652913; 
 Sun, 28 Sep 2025 12:27:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238ca6dsm9115937b3a.8.2025.09.28.12.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 12:27:32 -0700 (PDT)
Message-ID: <50d8690f-d5a9-4cc4-9111-8f2d4e5bfd5f@linaro.org>
Date: Sun, 28 Sep 2025 12:27:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] hw/ppc: Support for an IBM PPE42 CPU decrementer
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, thuth@redhat.com, 
 rathc@linux.ibm.com
References: <20250925201758.652077-1-milesg@linux.ibm.com>
 <20250925201758.652077-8-milesg@linux.ibm.com>
 <f023d7c8-1556-448b-8cf6-1ee1cc2f7b50@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f023d7c8-1556-448b-8cf6-1ee1cc2f7b50@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/28/25 10:51, Harsh Prateek Bora wrote:
> 
> 
> On 9/26/25 01:47, Glenn Miles wrote:
>> The IBM PPE42 processors support a 32-bit decrementer
>> that can raise an external interrupt when DEC[0]
>> transitions from a 0 to a 1 (a non-negative value to a
> 
> I guess it was meant to be 0 to -1 (0xffffffff)?
> No need to re-spin just for that though.

No, Glenn is talking about bit DEC[0], so 0 or 1 only.


r~

