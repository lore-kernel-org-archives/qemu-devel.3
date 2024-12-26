Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313DBE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwlu-0006rh-7b; Thu, 26 Dec 2024 17:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwls-0006rF-Qk
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:56:00 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwlr-0005d6-8K
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:56:00 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso7942606a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253758; x=1735858558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x32kWxMma690Uq+kbpx987xzi7TC1UEivuZD0gxrIZ0=;
 b=Jmunfk6xdW2CP0bfgu18q/toFx9OdPBk7Su1Aow2mNQCGUjZ7X5nXdolAXTDmUXhiy
 5cJcpoCkjdGjsDsxZ8hr6y/ISl1CrUxakV/USiObGXRGMkXa2399eykBnHlYGPjOxP7A
 bsCPfdUqYomdzr+vPJEBH/zk6TZORLWPGwq13O6B7vT9UhvMjpUzutv/zQHkEiDP45eM
 6X0K+a7NLLbee9qwqqlDGIO0lYbfYVplZR6EiidSpm9Pt0GM3S7CK1DbVqcaH8CysNGp
 MpVaKIsqdBpOAQnOFogrLGqpUD/xBcjVD6jIkB6j0x92wRJ7TU3xafVHw2RA6d6vwtz1
 PgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253758; x=1735858558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x32kWxMma690Uq+kbpx987xzi7TC1UEivuZD0gxrIZ0=;
 b=dh4n5ym2ND2MDD3EQqN460WU58WqFSGhR3DuN7/0osSy0H0YYcWG8B/TBALXctxYWT
 f8r8rLs92avaiC7vXgaYNwHJ3Evz7sbqV+SeUcsnYOpOXFwwYyfng5uyWdd28N8BJaba
 xFhuL64KAlph1kE57sGXXzS9FrFzb2ExoyxgMiAust5PNsO1Y2LKzkTw4GFW4rlkQyWo
 uAMh3ikdFXnBDzA9dBAOUo3y8emwfraoI/x3rQfrRUZi7n3o3t9Fjk0uCDhhrtZw2nvL
 MbUkXk3c5bigiJe7aI2mL72SBzp0PQ8KH+cNSzt4Je1lV8zMzPAq1NVXztRluZub5oli
 diSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMk8XSnfha3s13AkXXBdB1G5OSsrjsBvqBxzXbFacit6zQboDTriwTgkFRxSuvfFIyugv7koHs3Kr4@nongnu.org
X-Gm-Message-State: AOJu0Yz/q8pe+1wFcqvoCwPsHNC94r04D6hAeLMzwDu0ECoF6/uFIQOz
 6Gtwcc+8T5Po0vvttZgcv6L7zy6c6B/NUuAxjOGWkLGspRA7e5ZN6XdBkSUJZzU=
X-Gm-Gg: ASbGnctXHZdT2c8CoWwNP6k4t3ijofZW2z9oci2bZBWrwhvhtGLo/v8RPj2COeFeWMR
 d1L1VREpDINxiuiRxajGiXYC1IK52TARuRUrvOyIo2Rn3Eb32XgRXLtYD6aICiwctY1sAvStUez
 a20G10chbD9SL2cp91ZwCtUEolQpMdUpY4rGaHKTeZAA+3n3xN+b/V6AOZmYih/HiC6vKZ/DOgF
 vXIV2/L/a5BIJrO3m9ibOPD+xG2wwE8pZjIMiC8Hw0homCpYyrxSbInlNn0+l1W1Lg7H7zSzRX/
 3dwAetFaCO291jL3rvMFB9+Louk5XA==
X-Google-Smtp-Source: AGHT+IEY4Tb/XwzfEAoVSUR62U9Uyb2fA7YRc4Q3EdElEg9Z2WvmV9/U83bmmRZkTP+lmouB8eiAOg==
X-Received: by 2002:a05:6a00:301a:b0:72a:a7a4:9c6d with SMTP id
 d2e1a72fcca58-72abdeb6fc1mr40596493b3a.24.1735253757695; 
 Thu, 26 Dec 2024 14:55:57 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb941sm13413548b3a.160.2024.12.26.14.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:55:57 -0800 (PST)
Message-ID: <490e3bc8-ef3b-4bec-b9c1-55706c1b3a77@linaro.org>
Date: Thu, 26 Dec 2024 23:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/23] target/loongarch: Introduce max32 CPU type
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-19-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-19-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102d.google.com
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

On 26/12/24 22:19, Jiaxun Yang wrote:
> Introduce max32 CPU type as it's necessary to demonstrate all
> features we have in LA32.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/cpu.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 92 insertions(+)


>   #ifdef TARGET_LOONGARCH64
>   static void loongarch_la464_initfn(Object *obj)
>   {
> @@ -923,6 +1014,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
>       },
>   #endif
>       DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
> +    DEFINE_LOONGARCH_CPU_TYPE(32, "max32", loongarch_max32_initfn),

What about "la32max"?

>   #ifdef TARGET_LOONGARCH64
>       DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
>       DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
> 


