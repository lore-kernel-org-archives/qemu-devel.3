Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F53E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 06:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKxA-0007xV-Hj; Wed, 25 Dec 2024 01:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tQKx7-0007xL-A2
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 01:33:05 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tQKx4-0001e0-MK
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 01:33:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216728b1836so52908175ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 22:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735108374; x=1735713174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QaMiC30VmqlZbSiZ83tDmP82ETrUFLlEEsLx4hsV6c=;
 b=HT11mgFTlZSsS7t1A4KWIzrdqsFprCZuzJZitVOpMCBH7n4E+62duhCiYireNFXSha
 v2EwnSLqOmysxDepRduaE+grOEyvixJXw5DVIVHoz0gsVHqEgqM0futt7CwbPpr86Qxq
 vQpwgoD5dErp+LcmGGPuHgapkCL/5jThmfEDspZz4w7a0mSMl6oJCtM0odOHSnMRhpfH
 ozV8ufYfeIeNlrufj9mSxV1pRv8OYKk0HjjTOu+mZDGMX8Eo3sbANCYLS91LmUvcYP7k
 pqmD+7T/L7jpvOVrK1LoLEvXwjsKTpEB6sFtFfiGIFRaiUQLxcd9lkdhDEwWnySEOlCL
 jk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735108374; x=1735713174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QaMiC30VmqlZbSiZ83tDmP82ETrUFLlEEsLx4hsV6c=;
 b=G6zpD0M3an3wiYRcbEoqTIHvKdwfseKb2BT/gabw7iQE0tKIVGIPC0C5ztfmR+9kc/
 s1uArdeS7nN+Hb+hyru2X1QgvyrNEbrMZQQEfzBp1tn+vSvg6KARPjj/fW0maApwZ1Ke
 IoksjKYSfZcH0GC9UcxbL8TRIONH8SAH9c8wVuB5h/JOjfBMDM/gU0h4b5XI7QgyfFmP
 PYRrMtNVsmq1Was/bSILcS0wyxdP5IaAjiI3MD/JGMTdynvcdrtYDu+3qZ4wMG1qHROK
 RXHwe05V6luZbtlD8gdGjGvgSTGWV7njVTJF3SWPi7w4LBe4y2Fl212IwP7PZEdT4Aa7
 5hEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMOBxedZG1u8vtXELhgah67RjurdbbunQjoWPrzrP8VynllbxZRQcD8GbA+JVCPKlzxeT4CcpSUMgE@nongnu.org
X-Gm-Message-State: AOJu0YxZQCp6yRcof5g8bvav3WOQ/Bxo3XxI0WrgOJ4jnoBCBtxwb57o
 VXqUZcL1yLrVt8iW6P5WTeNCL9iPdfEcFNsKLVcmy/fxyVEhTCL8BAXKDHwg6Ig=
X-Gm-Gg: ASbGncujhRVEtj6noMXqV4bYCDE4gvhbq5RrELRUPlC+tFdari09h1xPxxSo+fEqLrL
 A4OpYB/xUpBcTu5f2UtSXHHWt875mogX79oCmV/FotDy700D9m+lN+1xRdx7x1U0nZQeqwytLd8
 NazjTVGYNEA6u75GaGWHmii18b8Uk2tdt0Z16tN7o/5lbAbpTKFsW0xYXFQ35Va7Yczu524XdUZ
 5tIXCwbZHiPGnUhx0DJ1W6fS7S8q0zwn7SwDdHyMNr2OqGJr4tzIvOWiLXVRhs=
X-Google-Smtp-Source: AGHT+IHq+3EZjJgpbwlS/B5VsuVawHXXGS2jtRPE56ZPLllIkZSi4fL4QuGRwyMUggG/tROUhnc9ng==
X-Received: by 2002:a17:902:f64d:b0:215:94e0:17 with SMTP id
 d9443c01a7336-219e6ebb6admr298794585ad.23.1735108374172; 
 Tue, 24 Dec 2024 22:32:54 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cdde7sm99306205ad.149.2024.12.24.22.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 22:32:53 -0800 (PST)
Message-ID: <ffdc6141-6754-43cb-bed9-13e377b12880@bytedance.com>
Date: Wed, 25 Dec 2024 14:32:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 Lei He <helei.sig11@bytedance.com>
References: <DM8PR13MB5078933D25141B3F23ECA782B3022@DM8PR13MB5078.namprd13.prod.outlook.com>
 <98696813-b2fe-45aa-a759-25764435b7c7@linaro.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <98696813-b2fe-45aa-a759-25764435b7c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x633.google.com
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



On 12/24/24 16:59, Philippe Mathieu-Daudé wrote:
> Hi Gabriel,
> 
> On 24/12/24 00:46, Gabriel Barrantes wrote:
>>  From c808fa797942b9bd32221594b7eef690a7558b14 Mon Sep 17 00:00:00 2001
>> From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
>> Date: Mon, 23 Dec 2024 14:58:12 -0600
>> Subject: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
>>
>> Do not propagate error to the upper, directly output the error to
>> avoid leaks.
>>
>> Closes: #2714
> 
> Better to use the full issue url to ease downstream backports
> where this commit is cherry-picked:
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714
> 
> Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>
>> Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
>> ---
>> backends/cryptodev-vhost-user.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev- 
>> vhost- user.c
>> index 43efdf9747..09bfbddb47 100644
>> --- a/backends/cryptodev-vhost-user.c
>> +++ b/backends/cryptodev-vhost-user.c
>> @@ -281,8 +281,8 @@ static int cryptodev_vhost_user_create_session(
>>          break;
>>
>>      default:
>> -        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
>> -                   sess_info->op_code);
>> +        error_report("Unsupported opcode :%" PRIu32 "",
>> +                     sess_info->op_code);
>>          return -VIRTIO_CRYPTO_NOTSUPP;
>>      }
> 
> Arei, Pi, Having CryptoDevBackendClass::create_session() take an errp
> argument would simplify the call chain, reporting the error once in
> cryptodev_backend_create_session().
> 

Good idea, I'll do it later.

>>
>> -- 
>> 2.43.0
>>
>>
> 


