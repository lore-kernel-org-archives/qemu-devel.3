Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D148AC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURNf-0003qm-JJ; Wed, 25 Jun 2025 10:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURNM-0003kW-PO
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:45:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURNK-0004nB-1w
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:45:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so24144b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862720; x=1751467520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dmzX9AmxtsKS9fnN2hZCa5P3gGbdt7dZs/idK9jFaLY=;
 b=Zb355NfZ6jrl9bNxvfe6yNfrngj+kJj7ZsTsXDfMsIGIfpdSMxjEAWAiKdB/HfFIbc
 ZYCcO7LAQc+96Jpj5ZUpGwT6vUBqSYLIg82Qe5ykIvD+piQFGD+nvCnaSdqS5GD0I2n0
 q0m96fXDT4L02KN1z3Wuohc2ePoOII+v4CS39JCAFHtGEjVCNiLxF8RSq/zKDZeiGi+v
 tDaC3yxJqvJz0PYak85+RGJs1I0LFw3OXB97bl6qUMOvpOEAb7nS6M1NqouLuOZmIL0s
 uKHI3pGgOKyly1VDfk30jjdm6mL8+wcCIXISU9fLWO/38ytzF4VzMhs/XG1IAZklMtca
 3BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862720; x=1751467520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmzX9AmxtsKS9fnN2hZCa5P3gGbdt7dZs/idK9jFaLY=;
 b=hvEmCORhrKyRlNhKXqPj/djvqHdRRIRSV5QZVjJqc8kHn+iPO1As/1f60YD4nqBIjS
 DgmlG91jGnIqLwp0cW3Y/HB39aaS7ql2o7lVMMjbGlvy/fikp4U7XfuXQae9K1dT6Rx9
 syEBmtRafwmvxFVDDF+OEheFkhV3jGvu7buJA1rVH4ZZ6JGaYZEmxaEE82nffWI5Mrtc
 j2Cr3y+psGy5ttUs8G8toIQ2zzw/7o9D0hpFKC0aWQlPsaajjVY8sgzgjLfC1cCvGBhs
 4kF0kypNxmZiB3bx5otm09rDfQoX6NGV/D9HMiis5w7B4a0i3wQR+6EfhfZ7fxb3NxEv
 2z4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+SGfXT5rsTA+tJ4sgDAESoIe1QHK3l6shnw5fv1u255aQXvYw2HSlQimvGfCSOvq+FEbmlXjSK/sI@nongnu.org
X-Gm-Message-State: AOJu0YyqLaBfzmnk+Q07wWbkG7VizPGbuBjuE6Sn8iFW69x7eBLFSIiR
 hgXz2R9xG7Nr34cGD+JzsjtHSU451o9xYjBLtzunbFvvAdOue0/lxNZZ1BCBHeiLpIU=
X-Gm-Gg: ASbGncuVWpn6KN+vrjBifl2Rob7wWRoE0zaLs0R9iUJLvKS78Scz9Y7+5zmCYjN3WcI
 mfVdsJnVBC/p2OtHYo8WPDHkHTZslQz81sRe5Ks1i24SBREzPv4TvVwD8Nen5771OovYi1GawVx
 Y7Hua3FNgHbXoPk2hcuqsvCsD9L+uSuwDvAzKM3ugwq+wA27aAhdfJPfbT69gGUA4tIgKc+6s3b
 L4zCxJIx9kfdFTGJXB0BkcLCkVGCJuhzcP6OGcfPk3kl3hAqHm285wYYFxQm0h7q1/OOfqJ+UlW
 yNuEXrE9eukEV28AzUcpUM4ZSka0+46fZ5nkmqkrGwgdSobcQUwPpi5eA660bfm61R0rKPF5hTU
 SAxaM4WzaIA==
X-Google-Smtp-Source: AGHT+IGkcAgjkAtDx6Fcz/wrY2IZLNtQg3Qt+y55sJwvwbqNiSkaTHRRto/boZh4yRVF2HdB+aco1Q==
X-Received: by 2002:a05:6a00:6515:b0:742:b31e:e9c1 with SMTP id
 d2e1a72fcca58-74955ded4c1mr6961330b3a.11.1750862720047; 
 Wed, 25 Jun 2025 07:45:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74a3e46aafbsm4370122b3a.154.2025.06.25.07.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:45:19 -0700 (PDT)
Message-ID: <2183acb2-803c-4768-b4b9-e0d17598ae75@linaro.org>
Date: Wed, 25 Jun 2025 07:45:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/27] tcg/optimize: Introduce arg_const_val
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Use arg_const_val instead of direct access to the TempOptInfo val
> member.  Rename both val and is_const to catch all direct accesses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 78 ++++++++++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 37 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


