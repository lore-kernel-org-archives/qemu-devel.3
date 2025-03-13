Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE77C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspYR-0005Lq-KA; Thu, 13 Mar 2025 16:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspYQ-0005LZ-7I
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:53:22 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspYO-00057w-CM
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:53:21 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso2645620a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899199; x=1742503999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7NHexazmaFSsL0J9qFmWYPocLwEZabpCh0jRjq7c1E=;
 b=FwnfYmAeOELeiXetcjTPSX0lrT85Cquh8AxORYyBzwKERSqPp1XHxpVHhk2zJ5ZpSN
 ir2OBiJZZleqtbbw+8/f47KGgk2Z5ev3gA9t4lxjWKEN479K2PpGGs8P0UXZCC9W3LBB
 EX7uiw8uDcN3AlxN7SYHvBVxgn6HUMFZDWL67dZFzxK7rXoVDTjaPjMRONrk6zQGadC5
 zhOF8dwaISGc+AGWHiVtLShG3Qn2oZMbdq9HUV7SZjT5ThIXOMy4LAJHJDyDYlo8iFon
 1LosrQQbZBNmei2Mz98abVx8szHIjDPfgVFb6Yb91ibK36cbpufaZsMY2mbS429X+Scn
 TtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899199; x=1742503999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q7NHexazmaFSsL0J9qFmWYPocLwEZabpCh0jRjq7c1E=;
 b=fbq2K0bH1g5EIfyEqX75R850Pi6h6VHQshaUBwURdMfNq9uHlEDqMEkPXUz/exATvt
 KF052gqfAYdmOuDBMdTZKDq1Yp5K9jCvjx0CBeyCqg7E3YgNeIMMNoVOvChA480Zb3R/
 pIAwj7SmUJaH8bvgvcNgUU/HjHgXnt54US2pDsnc58SMku6A7fFRPaClLJwHhf8Imk/8
 ckyOt0alzzZnAnKnlHW71fk4UmugFUu29Y0ZS2IKMtzUtrOdJblJXpZa/SseWo07F1Ws
 Pg8JCyDGeEQH1AUc5Kqb6iLCjTJTp6YDHvGE/vJ0YFoz5fe25QMe6yPvQEoGcPrNn7ne
 qOPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcUbNaePcTpjKKBfCzxlhv3bUKIAxX973o8WOlJzgZAoU1j6gdUPiB22s34nA8hMa8/X0/t+eEhKOv@nongnu.org
X-Gm-Message-State: AOJu0Yw8IJXC3zxRVTQd360dwn4jfsjBS8K+cr8Ad+l1HEOyVf7kJWfM
 BtDKfPjCXoA25Pyb4TYIyZzwJwduepcyA/ikEKdacyb52OU+RHcxdF/cTwzEL8w=
X-Gm-Gg: ASbGncuM/4a00nJ1O9y1sVXKw//AS7nAGRNUtLIZ/uUH1jcdSp0R3VwqVHuEgjrsuIW
 gWPNBeNU+20Tdm5JmDL+xP4NcKOMyRBRhAYAGwL0FdMBTQrOADuQ/hXMzT819Bza2/8Z1RiksI2
 TIGgG5Nma4FBniG8h9Oc8uqmwkHwarQ3iPAsmMYJXITu3KjZb7K+ma3JxPt7a/OAW3uny2Qfxba
 rrIiSHDhvPEtkXrBR7Y2kRxm5Vyf+04Q/BDOW3sCUuLvOdnY53pQI+XEalZ3s7ZglNrtz/LAmy+
 s2JWWK0zm1aRdit2s02+C2Vf5pIbm+MDIS52SMO+qLwAZw4Pq78/ES8W2Q==
X-Google-Smtp-Source: AGHT+IFlG0ENxyfEpiEW8J2DfiNnpGqpKoBInkq/T4kI7RIQCfwFX6qOxtDsKdgQruau/p207N2QBg==
X-Received: by 2002:a17:90b:2801:b0:2fe:a77b:d97e with SMTP id
 98e67ed59e1d1-3014fabb07cmr649975a91.11.1741899198834; 
 Thu, 13 Mar 2025 13:53:18 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301390adae9sm1844234a91.46.2025.03.13.13.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:53:18 -0700 (PDT)
Message-ID: <d7a967d9-f136-4b04-8e7c-1d451bcbfe35@linaro.org>
Date: Thu, 13 Mar 2025 13:53:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/37] accel/tcg: Use libuser_ss and libsystem_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> While some of these files are built exactly once, due
> to being in only libuser_ss or libsystem_ss, some of
> the includes that they depend on require CONFIG_USER_ONLY.
> So make use of the common infrastructure to allow that.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/meson.build | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 185830d0f5..72d4acfe5e 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -1,12 +1,21 @@
> -common_ss.add(when: 'CONFIG_TCG', if_true: files(
> +if not get_option('tcg').allowed()
> +   subdir_done()
> +endif
> +
> +tcg_ss = ss.source_set()
> +
> +tcg_ss.add(files(
>     'cpu-exec-common.c',
>     'tcg-runtime.c',
>     'tcg-runtime-gvec.c',
>   ))
>   if get_option('plugins')
> -  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
> +  tcg_ss.add(files('plugin-gen.c'))
>   endif
>   
> +libuser_ss.add_all(tcg_ss)
> +libsystem_ss.add_all(tcg_ss)
> +
>   tcg_specific_ss = ss.source_set()
>   tcg_specific_ss.add(files(
>     'tcg-all.c',
> @@ -22,11 +31,11 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
>   ))
>   
> -user_ss.add(when: ['CONFIG_TCG'], if_true: files(
> +libuser_ss.add(files(
>     'user-exec-stub.c',
>   ))
>   
> -system_ss.add(when: ['CONFIG_TCG'], if_true: files(
> +libsystem_ss.add(files(
>     'icount-common.c',
>     'monitor.c',
>     'tcg-accel-ops.c',

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


