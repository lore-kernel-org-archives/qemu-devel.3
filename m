Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C661CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jxA-0007hB-T8; Thu, 25 Sep 2025 07:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jx7-0007gM-2B
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:15:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jwz-0005Si-LQ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:15:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso892743f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758798943; x=1759403743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMYjTsHmfVG0HjhjDQVuB/zVz84PBqibJP6NCHOIBnA=;
 b=f8YMFgHHrIq96sMwDgvcogriqMqvBjaPThM4IxucXgXRzpNnjbDkLcdRUicMIwEiW8
 XnKBUWrtmSk/Ky4FASSv+aK9ra6Wj3ajgdDALxP5BTSwREK20BodqBvVsTEDcK5hjv/G
 YDHw83MuATOK+5vhsDUBwJZxx5bGpkFHgU3fOK7wuQO0z0AsdjZBqjpxKpjJ0NES4j5/
 SSzMf2tObwiKTnxKeng5mXmvoue3wHNR4X4RcOP7zQw4HttcBFhpdvnX6rPaQx/SMcHw
 yW68Cj9n/L72mqPGC7LuJHtl4+gs/ZrKGFd/5MzYMFFn6Cx0bGwng9s9bC8Q6nS+05sI
 DluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758798943; x=1759403743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMYjTsHmfVG0HjhjDQVuB/zVz84PBqibJP6NCHOIBnA=;
 b=bXiB50rkhV2SeCSGULVcVdOYOxQAzXmnWWBJQ3nwBtm0g1TWfqW/2ZnE4hHfMbHAUs
 D5ihRkP4VDgMOCRxewT/bpUPy+Fbs1ClEIl+CPEnOKHLuhba0T7Dduc5EWbAah3XvPVJ
 jlNhXiZS0gheuAtpcVSuoYuB93xwfbk+zr2WyWWxteVMO9jAyySRu3t7hfNbJzYD/+8Q
 CfvfowqgeIXc/ILFtQfg1H/MDxMiMvY1KN662tiTDTijsJJzLipF4bZkXEivtEH3Nfrm
 jxrQJje4Oi70k8u9l3uCcolvYn0ggLqeLX8NwJmnbPAx5mpbMmClHyQye+axtlHafsJp
 bt9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGrUI3Rgu+8dj5YCnq+lHCDvCdbiEcUeSIG264VNgXb0O0iqoYC6v6ScVexvd4MruMho3vvCiCAn70@nongnu.org
X-Gm-Message-State: AOJu0YwPFGK51Hjrhfd0CwSuj4pSVRzVl3l0gHLSw/tsJx3S5EquL5ob
 HZ5P9e6HfKbDWY7P0cl8aNupeCdPw/E90Rq1omNagimzPVS/VRvdUh+ppLOjKbWhuSo=
X-Gm-Gg: ASbGnctEcFhRFfijDYMfZZm/11KMNg0NbOshifrCg8G+ISu1Zbufup1RSFkatwBw3M3
 knNbiJSAgJfYOMmTwF4/UT5hM/YBi7Gb9fhjBbhtoE9BMGLZ2kMZ8E2NDMy49Pi6WaLWM1kKPQ5
 8QgovX8jjJBI8CAQdy3ir0qR/dsDbe3iRs4lNvsvcOqmAko2DuXj5n6jg8U0RgfhpnXPg9WvJtf
 A0pHlw92IDRiuO6FmTkK9k2DY8sf5LVj3Ie+ln+wRrmCNqLL3seba1tBqFyVzF9uJctGS/Ri2Tt
 qpDujbMWu8S2WugKxw5/mxtWogts2BeS3IKeujFA6Jix1uaYYF7XP7GyFbUOQJqYlNbP6EwgYIu
 Ax/EGhZsZOeS2flYD2vWBtxeSsm6Bi1aQDELjaastbozWNQTJjEHYGhJSD7QIPfzaog==
X-Google-Smtp-Source: AGHT+IEEX1p+/13S6LmmpBYo92Wm7qd0GyfG05xUUAa01EPdSvDwe+/9ptu07ozbU+y87FcwMP3qFA==
X-Received: by 2002:a05:6000:310e:b0:3ee:14db:6ffc with SMTP id
 ffacd0b85a97d-40e43b08e37mr2708317f8f.19.1758798943362; 
 Thu, 25 Sep 2025 04:15:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb1a3sm2625242f8f.10.2025.09.25.04.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:15:42 -0700 (PDT)
Message-ID: <88d64ca1-79ae-4637-8a12-05a556d07a44@linaro.org>
Date: Thu, 25 Sep 2025 13:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/36] target/arm: Remove name argument to alloc_cpreg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> All callers now pass in->name, so take the value from there.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 71dd094fac..da3dd073d3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7421,9 +7421,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>    * Copy a ARMCPRegInfo structure, allocating it along with the name
>    * and an optional suffix to the name.
>    */
> -static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
> -                                 const char *name, const char *suffix)
> +static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in, const char *suffix)
>   {
> +    const char *name = in->name;

This is internal API call, but still, should we assert for non-NULL?
Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       size_t name_len = strlen(name);
>       size_t suff_len = suffix ? strlen(suffix) : 0;
>       ARMCPRegInfo *out = g_malloc(sizeof(*in) + name_len + suff_len + 1);


