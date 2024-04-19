Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20551C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxiB5-0007ZZ-By; Fri, 19 Apr 2024 02:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxiB3-0007Z7-P1
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:56:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxiB2-0003Ur-6k
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:56:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so1495811f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 23:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713509810; x=1714114610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6f8OSAiuyCNABaAdO0mDDnj+jnF0jLHO/WdUxKAv88=;
 b=XvCct+jHjEJKvjcijBinVqSXEIHQ6cbC+/JdEWyqqCeaBUPo6QI6F1Aqk1FAdD3gD3
 u/oF+zQBH0sc2KpGJn38rQn5HrAHqsINNs7NfBGmOgpWCLyPBcg/eqRT4xEJLqd1T9sA
 LGK2flFeeDWt7ej8+nKArmkhnE7SBsICwezLg7glyyi2QYVCgQ3nmvaWPu/7Vj6t4nNF
 pR0If0zbuIhza9/L828yoM5EtLJVwgOk7dte0bOOjtevgcrXpaW6dM4DcakWHxcdQ4NS
 RYuyewgrpDkzeWGng1f0aK5tMTk/uCqvUTaOYu5aIqCSSc2yujK+REfNypMb9e0qJVii
 I1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713509810; x=1714114610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6f8OSAiuyCNABaAdO0mDDnj+jnF0jLHO/WdUxKAv88=;
 b=S5yzmDupHxIGesYSCeemvWDixGt0gqGfr1+s+ZS8I3dRR8pPrjHxCo/V+h9xVvW43f
 AFPUQNS3GnPXh3b8dfLVGxh2RQbd/rPTyuQomP3E/WV/HZ9sbxgviNtG6nDEVTOLl6bZ
 V6U3/UzrEcV9sIS5rNrmFONFCwuC41Eg2H3Jvx4LTgaUI9+OB/ES6Oq7u85vFAN0qDc7
 O59OYxuDZvxzQy1KitRYOC0fG3H6aesl9RLOWZoXHcVCZatNz36wFDyybAkHxpq5J2Rh
 j4x70p/1Uz/gOHlM3UpqUxR2mC/0rIVi6bnBXsAwTU23TzzvPlbSqZ9Qb/NcO4Ksi83X
 xLYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSUt27aT+vGtRm9Zkv2GbaQ8eBiu6dmNCppXwCE5CkWfA0TKMVAA7d+3cL4RE8KPfhKSh497t9t+1WUVGeLm8PyPTCMV8=
X-Gm-Message-State: AOJu0YwwV4BHzoA+5PEVtPZvimLCUD5qsLMUTfYAQoBXle7u79bGgv3s
 tfkBSAOP0gLyi88MSYMfip8kGOWuHms2WoY8MDhL5kWvNx//UOIflqbxkwjiaqU=
X-Google-Smtp-Source: AGHT+IH9WcmdUz8BR/2yyswhWMB/4jBzzA5bhTqBZYIQcehH46tW0T/Dg1qNEvlgKjaHEoea7AUt3g==
X-Received: by 2002:a05:6000:1d82:b0:349:c40c:393 with SMTP id
 bk2-20020a0560001d8200b00349c40c0393mr772561wrb.3.1713509810525; 
 Thu, 18 Apr 2024 23:56:50 -0700 (PDT)
Received: from [192.168.235.175] (149.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.149]) by smtp.gmail.com with ESMTPSA id
 d2-20020a5d6442000000b003479bec98cesm3619363wrw.115.2024.04.18.23.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 23:56:50 -0700 (PDT)
Message-ID: <4111ddfd-ce72-4935-99cd-08ed8c43a605@linaro.org>
Date: Fri, 19 Apr 2024 08:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] s390x/cpu_models: Misc cleanup on returned error code
 and local @err variables
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/4/24 08:57, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>


> ---
> Zhao Liu (6):
>    target/s390x/cpu_model: Make check_compatibility() return boolean
>    target/s390x/cpu_model: Drop local @err in s390_realize_cpu_model()
>    target/s390x/cpu_models: Make kvm_s390_get_host_cpu_model() return
>      boolean
>    target/s390x/cpu_models: Drop local @err in get_max_cpu_model()
>    target/s390x/cpu_models: Make kvm_s390_apply_cpu_model() return
>      boolean
>    target/s390x/cpu_models_sysemu: Drop local @err in apply_cpu_model()

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


