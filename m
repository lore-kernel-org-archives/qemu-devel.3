Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464DBEDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE6k-00087a-9D; Tue, 10 Sep 2024 23:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE6i-00080e-G4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:33:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE6g-0001TE-VJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:33:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-717914d6c95so4101453b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025605; x=1726630405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SweJhYd1LgdpzyAeKaPgx3vpRfXEC5rkyZegJBYKB3w=;
 b=DrsnIkToK/82jMWsmZkpNmYTYSK/wPoshIVQn+K8ihGiB9hNqAqHFV8v5Qg95nOZqq
 USUVjC84waXoTTJra0dfb0lg4X9vHiU3JsjDCpK0zGpDE8fqvNi9Qhva9KaX+x1OgAD5
 NBvyxIcgITSwBw3T312WMRM5hQ84e84PoXi89tqobNcX8MCsIwIhRehFDPZcrgkis+aF
 uGqWDR/RjFhrootuEYH/VlB91l11jQhQpJDMgRzzmrfkxofYTkwPgpguNAI6CjjEX5f1
 xvBAb7CzB7mNdYP6E23WEsAOeOhNjpHVmV/k8kPye799PLfB1BnfSLTwhw7dzg1ZQLtY
 4V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025605; x=1726630405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SweJhYd1LgdpzyAeKaPgx3vpRfXEC5rkyZegJBYKB3w=;
 b=EXdB3ChnxhTbxa0DRKHOvUs4oO6A5L0ZerrWZDGJRrhQcfhdyaE9BpXyaUslY1xw8C
 zsyAvQNT120WG3atEo/nVyQ+I+VIcPfq0weZ6C1ZjnFUc3F4k10mT+f96v4EHPsO5v/v
 A5lcbkTQc1FLYM9wUBj8J8vu5lir6ETivZkY02GBbQ+ReHXm5+LOwVoZ0llVleXmIv/b
 EhN49cDFtj69TtV1qJgfQqcaftInoHH1L6cm9odckcMsE0DU9UlELf8VvCugFYxvrgxW
 B88kiFnjENw9kSnCk5yc3Qg0Foguh2AYBsz/UBEYWrxBiTLXCr8btCW7uMK8b3z0ZMjG
 uXvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDYDwvdDLXOrxxqT9Pa87XDoVPWyTbzrRNCtsO/ufVR4m3SgB5ScHobxPBeXjlsl1ivgBYsBtCNFHQ@nongnu.org
X-Gm-Message-State: AOJu0YyAMo45icLiRfvjvfnKgl6GVMHYioHX6C8moXiuQayxl5Ei9dQ6
 mNqyjzvV9/vdKSSs5L311FTCK6Z0uQg/yCBMC4cJFNiHt5+ItiTHdU5zfkA9Q2EdI2rddVpYrn1
 r
X-Google-Smtp-Source: AGHT+IG0j2fLh5FEsrWBxVmwT3dgeDZauZ3owUNSEYKNz2HqI1zrArb3y8ZW26g3egn/gCRV+02uCQ==
X-Received: by 2002:a05:6a00:944a:b0:717:8b4e:98b6 with SMTP id
 d2e1a72fcca58-718d5ee4a44mr16637469b3a.21.1726025605258; 
 Tue, 10 Sep 2024 20:33:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fa4sm2069351b3a.35.2024.09.10.20.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:33:24 -0700 (PDT)
Message-ID: <3ef6d3f5-9d48-47af-8876-de35d0ee649a@linaro.org>
Date: Tue, 10 Sep 2024 20:33:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/39] hw/tpm: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-33-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-33-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/tpm/tpm_spapr.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index e084e987e6e..5f7a0dfc617 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -206,7 +206,6 @@ static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
>                   break;
>               default:
>                   g_assert_not_reached();
> -                break;
>               }
>               trace_tpm_spapr_do_crq_get_version(be32_to_cpu(local_crq.data));
>               spapr_tpm_send_crq(dev, &local_crq);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

