Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D067AECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 09:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snb6U-0006gh-Bg; Mon, 09 Sep 2024 05:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1snb6P-0006fx-R6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:54:33 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1snb6O-00077s-7a
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:54:33 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5e1b50feb9bso1686443eaf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725875670; x=1726480470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVueUaiJVzxXIXpj6rQm4YL2iva1Aj88TVHcWiCn4Ns=;
 b=lpD/Ymf5VrMiiLWk3evc69TbDwT1h2beDvS/0dKIt6p/0ZvV09kwBOOTJ3Dn9ZdFR0
 ZRF4LeqTD+h6sLuBOJSqygRG+WSvQsB9f7Q1a8/iVIoCPed17rb815OKwT2x2XvLR7kP
 ksh9dYxUgnmNEov6nkdUZdkGVMgs+9aoAnedka9Yk2b0p/oYoEjKOmqAL84ko5Cg/AS3
 ekinamFyKOGePQQy76bd16JdUFbn43yT49uzyqE9XCV6fLGE6x0GjqYKooZ7zuSe2zfR
 ii6vdGF8C14cavLYSFIt0ymdPNrXCfcbYxZQnJxz/CctOu+gAlnBR9E8iaAC24LybwTm
 CJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725875670; x=1726480470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVueUaiJVzxXIXpj6rQm4YL2iva1Aj88TVHcWiCn4Ns=;
 b=tQMpU4SOyu1A3LZtktz4HkON5AJeOhHXjqX0UvMiAsGNCLwHRUEWK/RjqobS937jq5
 KKrkuvhBYQTF1/ZjFTjEeVMHZkwFOOQ13aiVjggDjtukDODHQcA/W7ntoOvGYi0Ogkul
 MiJ/ElQNOdkJayNY5Mmv2Lsm5aMeJf5Z5pRJZhRNopyBG4mZawYviENxfs9mPl0oUqWH
 yLycSLybv/egBMlvODygdjiorwhg6mgCHi5WwKNc9uHko++sNL2tkb1Kru1RpC+0NbLb
 YUj2wb89QsLtmTYaJtm5eTtMIuCxL2jVrjJOsSh+GiEapeDSfmnjxsGh6Lhkbj7Q3PUC
 fD+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvFsTkM2awqEqjhf8eIDw9StPFMHj3uBWq3BK+0dkvpcOkDbc98daZk40JU4Qyb1Uz0TPjcsI64NoX@nongnu.org
X-Gm-Message-State: AOJu0YwDI2CP4b5XqGXNIIiji+PBFV0TvXgfu7vCWiPa70ZEtJCIhEXZ
 D7ZBww4qANn587nFIetOs3zLpcvV7CYlbBDd38Bqw6pHGA0OxryUnQfKbYvJ4C0=
X-Google-Smtp-Source: AGHT+IHy0jgWEozp2HsJSfjv/aidjDA+GkZUF3AREseSpsr91gcUsighAR+6GXkQebPLsJUCM1k+8g==
X-Received: by 2002:a05:6870:211:b0:261:1046:66fc with SMTP id
 586e51a60fabf-27b9d689499mr3194691fac.4.1725875670647; 
 Mon, 09 Sep 2024 02:54:30 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58ca745sm3185412b3a.88.2024.09.09.02.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 02:54:30 -0700 (PDT)
Message-ID: <e93d6ed4-8fe2-434b-9d84-997bae44847f@ventanamicro.com>
Date: Mon, 9 Sep 2024 06:54:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove unnecessary code in the interface
 accel_system_init_ops_interfaces
To: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, philmd@linaro.org,
 alistair.francis@wdc.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
References: <20240909031736.1881-1-andrew.yuan@jaguarmicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240909031736.1881-1-andrew.yuan@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
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



On 9/9/24 12:17 AM, Andrew.Yuan wrote:
> The code 'ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));' is unnecessary;
> 
> And, the following code :
> 1.has the same functionality;
> 2.includes error checking;
> 
> Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
> ---
>   accel/accel-system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947dd82..5d502c8fd8 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -73,7 +73,7 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
>       g_assert(ac_name != NULL);
>   
>       ops_name = g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
> -    ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
> +

The code you're changing was added by 5141e9a23f ("accel: abort if we fail to
load the accelerator plugin") and I think this repetition is intended. If I have
to guess (first time looking at this code), ACCEL_OPS_CLASS() is creating the class
type QOM functions that the the second module_object_class_by_name() relies on to
catch the module load error the commit is trying to address.

I'm CCing Claudio to get a better idea of the intention here. At the very least we
should add a code comment explaining the reasoning behind initing 'ops' two times
in a row and so on.


Thanks,

Daniel

>       oc = module_object_class_by_name(ops_name);
>       if (!oc) {
>           error_report("fatal: could not load module for type '%s'", ops_name);

