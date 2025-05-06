Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC93FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIhk-00033F-9w; Tue, 06 May 2025 09:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCIhT-00031h-Cx
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:51:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCIhP-0002gI-FE
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:51:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so25178145e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746539465; x=1747144265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rT4fPnQNYVSpKXaZe3xxD7dUp8OrkU2kP58wHu3jrnI=;
 b=wg/k8Zic0wFfa072XIFmqIHNyLYaEin+g2rDjfoGKIPOWpqEFeV7sM8+W06Hi9slPS
 5kVq8C/trJLvN71vUeTQktHE31hf//BeHgID+gA0Dl99Eu99ZPgjiZuuTo7jBhJPbntp
 NoZFwI4rlJJ663hJBOAdtfWcKDyi3AVNdkxhQW7sExxpCVbOPsRw/nGGDJMjbmY8xlqG
 Ju3Run94wnISlHGWyGs/cEzDCWzGswQ9XyGtscTleu0GLdJmmWFg7a3w4QApHsiaq6Xm
 Mto7bxIDnGbURdbwIoEFZzPN7C/Km02jYME4lGe7EY0eu2Lr75fpUKghzcdNABRkpUkw
 bpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746539465; x=1747144265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rT4fPnQNYVSpKXaZe3xxD7dUp8OrkU2kP58wHu3jrnI=;
 b=tsITIkpuabYF3RaYkMzEjVf0PDY9/FzBCsdvQ0vypHnn93+BTBt0uqjsxvxX2h1/2Q
 t3rxCY8r0pAP5Z/d3mweTwUqKzCpfYTq2cu7SNVbv/GXpJwGY0MfBhwcBho35xU/rQxz
 tyU1kvqq2ksvlKRq7UwaT1sxsUGA7uecmz09lozhGPlJQsVvOrWgRdlTZrIXAlQsHjts
 GGlBGssMZjkTZmp6pMHTmVOYd9ENHo6UmaTQsOKznI9kqaQmPfFvBa3ICK49YbrOraHw
 gKU9oPX06w92zME6GidyYBYVXhPuxteZsHG0yYVoeNNlAbO/Rn5BqT0PMbnNGSV8vGr5
 eKNg==
X-Gm-Message-State: AOJu0YyAdNrJKREXBEYg80KWURvJH85hJ1vSF1vza+osF0q65EhxLfH2
 +FEdZwG2UshzWLc/0v2nZ5+fmSZMoBBmax9fVrIF+VTk/C4aHn9Skg11R5JaGJiFF+J3o5OXUjf
 c
X-Gm-Gg: ASbGncsz3fTL65YE/4+fDpoXa7nxeIPar2pUMTvFBJWfmUtXQLVeQbC88zyM2rKDf0m
 6sompVxh/wKwiIvrjZaBvwPOWGxk+n2umq/z3rAnCX7u32puhyqqqm3dPzo9ezuXY20uhj0IBvS
 Myoqn+l5aSko0G/wDuBg7F/qwL301xbMCAXWaKv/kRxVjUwRr4OmqKD2fZF9ZVGPHwvrwwTmfeQ
 3ch21DKTQJ08YBQgUH/P7Shvgz7YaqwJFygKa6gweghcKbaKF5aKZ6l8dHysyT85QvkR2KT5ZFI
 JkL62sqVOV0jcF2S2UVmvRCwAFI/8vP05tZpg+Yg3YIkT8tO0PMCUQrCQFGNTLQTokn+UuxODTh
 F9xQ5ng==
X-Google-Smtp-Source: AGHT+IEWYYAO4li78Jphg1iinyCQ8bnY1NKoF81bNPCldXwK478aLvPriuJvXLRjas4L1FrDMHshlQ==
X-Received: by 2002:a05:600c:3e05:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-441d0fbd329mr29060155e9.4.1746539464939; 
 Tue, 06 May 2025 06:51:04 -0700 (PDT)
Received: from [192.168.1.82] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af2a0csm215159895e9.18.2025.05.06.06.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 06:51:04 -0700 (PDT)
Message-ID: <abb339d7-7f2b-48bf-bb45-c88e79e4dc7e@linaro.org>
Date: Tue, 6 May 2025 15:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20250429100419.20427-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429100419.20427-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

ping?

On 29/4/25 12:04, Philippe Mathieu-Daudé wrote:
> We'd like to have some unified QAPI schema. Having a structure field
> conditional to a target being built in is not very practical.
> 
> While @deprecated-props is only used by s390x target, it is generic
> enough and could be used by other targets (assuming we expand
> CpuModelExpansionType enum values).
> 
> Let's always include this field, regardless of the target, but
> make it optional.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qapi/machine-target.json | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 541f93eeb78..3b109b4af87 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -244,19 +244,18 @@
>   #
>   # @model: the expanded CpuModelInfo.
>   #
> -# @deprecated-props: a list of properties that are flagged as
> +# @deprecated-props: an optional list of properties that are flagged as
>   #     deprecated by the CPU vendor.  The list depends on the
>   #     CpuModelExpansionType: "static" properties are a subset of the
>   #     enabled-properties for the expanded model; "full" properties are
>   #     a set of properties that are deprecated across all models for
> -#     the architecture.  (since: 9.1).
> +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
>   #
>   # Since: 2.8
>   ##
>   { 'struct': 'CpuModelExpansionInfo',
>     'data': { 'model': 'CpuModelInfo',
> -            'deprecated-props' : { 'type': ['str'],
> -                                   'if': 'TARGET_S390X' } },
> +            '*deprecated-props' : { 'type': ['str'] } },
>     'if': { 'any': [ 'TARGET_S390X',
>                      'TARGET_I386',
>                      'TARGET_ARM',


