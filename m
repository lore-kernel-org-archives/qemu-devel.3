Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58076C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuuP-0003LA-EF; Thu, 10 Jul 2025 13:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZuVb-0001oN-ED
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:52:32 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZuVZ-0004fY-UN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:52:31 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73ce2761272so646504a34.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752166346; x=1752771146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bjnXLV3Ph8zKIBKaU+MzWaqCrcAIschWvrB1OUGre1s=;
 b=rxRnoX9WJJM4yU1IckONQcMEDe/xHaJRdw5WN7QwFr4/FEvXqsCYYs9emE6j8eMbJk
 UM6ZVzZ6zXlkUnKhCL9rhVLduMDnqiNuCPedevSrI9Hbedt9K4BYEWKK2HfNuQJgNELt
 EvUYYwuw9AHH1cBRdM8kbrLhvis1WJZHOO2ZAXmGpDwex17WVlf5eZV4SzTJJu5btqse
 rkGwCCZH4YUNOpelcB1Cx8K85/PrwKh0J8NFBaseYy5YTrtz3URkiP785ujIKl9D7I/d
 RglRr8BFj3jMApXp6CLOsp2GyT3cpuoRJritZxo3sulK1AisdOzytlPYKjRjq8NnQ15I
 CnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752166346; x=1752771146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bjnXLV3Ph8zKIBKaU+MzWaqCrcAIschWvrB1OUGre1s=;
 b=DMXD2p6XM5hl+825XelM/f7kN3N7dS62T1RxUvWc6d9JseLpUHTtLn+Eh5gb81FRKu
 5vtapSj+VsBtydZZZMLwUkk730L3fUWwlaEJ5PlH3/5MePBzkGdX7Ziw7G6fFVL6Ke0y
 WgUn+pzCneLW96Cuy5QWJuuseWM1dn0ulU8tESYW0Ewe6/Yvdcp225AM7TElscAIg0bX
 spio1IkTuJvXfKs9LHnZDJNmPFX2HrIMwBtcIkbTplQiKcjW99FExj5RzR86ce846KCu
 +CsQDTnX/vWELIJFkHqu1PRmex4/PfOv4CyAzUZ7BOvxc+lhYmWsfQrL+uu/oVpe98XT
 yHNQ==
X-Gm-Message-State: AOJu0YyMQQ+zrAZut3g86FSVWikoNwuzmd1zX/3icCNzuWM7/htQ+CKI
 P7rjxKZU1FctmMP7Hdmo7GMc6z4qoJqCvJ+unLz03kJjPcuRz4gQVODkLBZYZUy1eeI=
X-Gm-Gg: ASbGncs29ay/aNFVrZAOoYSqx1CzauZwc/J/erBN5w2w2WN9eRxFvh8DUVogTz/kpwZ
 b1Lw0cjKyHByA1D+U1rSz1NNNimLRGQzRHOFjHtSY+5PnzGZjd7eU+sLKAn+zqx0Nidlic3Wffy
 TtjEA9p/mMrRkIkq91RGzFpYeTaI4PqvvCap1wZLh2YSkCIJSueQnAg1bZwz44gtx0g0V0Nugk5
 YWEq/NXMkM2L25Jk+z7r3u0fotipwxAe5j38/8yNndycgIcvqJ0PewA8O/nDb7+C55i7PscvgO0
 3VsJqLlaH8Cy9NnuunRPSffPlw9j5PTmlwa1AMj6HMgx+PLadeoRSnNqYjmLVx7bs7/gbyXBozV
 a/IoJdMpgT8GTIg==
X-Google-Smtp-Source: AGHT+IGRKeapE5fQKp29OdUeBUirnwsDw02u5wbtnFdLtBNuxXUMdeBwMV7+Rz5P1zAPkXRhu3v5zQ==
X-Received: by 2002:a05:6830:6609:b0:739:f863:c4d7 with SMTP id
 46e09a7af769-73cf9e3bee2mr207711a34.12.1752166345698; 
 Thu, 10 Jul 2025 09:52:25 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108a6ebsm265420a34.15.2025.07.10.09.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 09:52:25 -0700 (PDT)
Message-ID: <7ff43c54-1640-4884-a16c-793eaad0423a@linaro.org>
Date: Thu, 10 Jul 2025 10:52:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] target/arm: Add FEAT_SCTLR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
 <20250710163858.1094780-4-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710163858.1094780-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 7/10/25 10:38, Gustavo Romero wrote:
> +static CPAccessResult sctlr2_el2_access(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri,
> +                                        bool isread)
> +{
> +    if (arm_current_el(env) < 3 && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }

Still missing the arm_feature(env, ARM_FEATURE_EL3) check I mentioned.


r~

