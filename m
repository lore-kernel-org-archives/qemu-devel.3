Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D1CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzVw-0001ri-9I; Mon, 20 Oct 2025 19:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzVj-0001i0-NU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:41:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzVh-0001sx-Ug
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:41:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2907948c1d2so52952795ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003712; x=1761608512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdQZq4kbQ0fPEy6jcqD9rXM+3x+ssDMgabR3mWB5pUw=;
 b=AjlqsEX/5SQYqTYuYUYhVp+f76CsIfTywyPC/3AIvLxdkSFHLRg8gIT6iViujAoNcH
 lRFJ+/Q9fTi0jzPRBd5052hP7WPy7axPGNKk6yiSsLhuZSsBjqEJb9bEbVHmpSQgRN+T
 r8/1v16lQB/SWzNYKBPA2R1UBINPZmew1SeSKRNCxmQIs7LPXZ1tLsSSfhpBnGTaysWu
 PgPyVMHHshQpkCMBioMZxrWF9Lk07So4UWa1bcUYumx9mDiqnINpYkj17EKBejXnoimD
 r1vXHwJLiBYDrLHfwfAJNJ+DZQpRMqA7hPOdzspN+RrIRsU6ktIXoPMXOxAEtRRBdBqS
 z3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003712; x=1761608512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LdQZq4kbQ0fPEy6jcqD9rXM+3x+ssDMgabR3mWB5pUw=;
 b=puA8ChRF+03+UTDptWKrS3N+bK5OUbaA4MnFQu22scmtC2bPaL4IVdrVvkFI1VtwGw
 J6VhfiKNRu7AP3iXgmSaQXmKbT1bb1lA2zoYlRypF6JDUgDaqJNIo58U7F7mzQSno6aJ
 E0oDER3oskpp/F9OPlDrEBQ429fNiGRjgLULEAlafssh8tdsjym4TyT3EHNSHUiQFFYV
 ip8eI4VL9SXd/d9Kr562PodP1OPRmwkIJO08kn7qkeIAI1lS9sM4+jmUU6ZKXzxN+OiC
 e9o+WASQPKgKaCF96nneVJfTrD4AdxERG7085OGeYip4kcPiJBHibAu1amYwm0NyBR/l
 WICw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj69NzmuJb38TJ93z2yKzCm8uwOtFD4vOgfeY0CpRwOXtDU/0Y6OP80UkExngLBTtg2/o2FuSrtuOt@nongnu.org
X-Gm-Message-State: AOJu0Yz4Y0frcR3HBDTEnzYTmauNzuaGWXrEHtBCEN7qLTYnae40XIil
 QWbxw3AcDBZJZNC5Xmvg27i+v4Nj24JPI8CCZtNLUlGOpQTlnlxwe6zf2yd3xT/D20I=
X-Gm-Gg: ASbGncuS/GcWTtFXL8JTOktATimpijnul9v0yazXpjVER5ue68m8CwFaiJhMcXT3pxa
 c3FzOTZX1zi6MPsmOWZhd7LenmTPD6k7lF1qFzvoHbXojlKQC+Ku+sO9CDG5NSBA88FdSLXyPEs
 TuZpylroN6bS95odCPlRfiEfjXL+vZt3qGKz+B91jlVIVWdWOZf7s0N6xvJpwLcQ+dud7F4eST9
 oEQJlJhmPgM6mbVRAsE9se38RU64ZYn7ssjvf69mvtbx2/hmXRUJuDpIXgbaPwWCYi4e850DkVE
 4u6++FhIZmLnXjgpAXsKYOvpr8bf4xM0ddY4EH3SXZZE8Og2Ee+Lrg2P7LdcsCc0LJJHMGQL+hr
 NDwZdfdwBEEbAiSmQiET4vofo5kJoXq8h42xQ/E8+fZqOKEdvLyelo0UGxbgsCUlJsLd2O2fuRP
 nOV/aw68SzEVjf4w==
X-Google-Smtp-Source: AGHT+IGZGR0bHRtv7vCXJvmrv5OpNGgPdIs3FwT3O2ts+BBZ34bBRE1KENEJ9B49m+pJ+cz70VyZgg==
X-Received: by 2002:a17:902:f70f:b0:290:c3ad:8432 with SMTP id
 d9443c01a7336-290cb65b628mr179489775ad.46.1761003712249; 
 Mon, 20 Oct 2025 16:41:52 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d5965sm92034535ad.75.2025.10.20.16.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:41:51 -0700 (PDT)
Message-ID: <5ef4c485-2067-44fa-b6d8-f6796970af46@linaro.org>
Date: Mon, 20 Oct 2025 16:41:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/30] hw/arm/meson: Remove now unused arm_ss[] source
 set
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020222010.68708-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020222010.68708-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 2025-10-20 15:20, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/meson.build | 2 --
>   1 file changed, 2 deletions(-)
> 

Good job!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


