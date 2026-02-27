Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53932104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5q7-0007MM-Nl; Fri, 27 Feb 2026 16:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5q3-0007M7-Nb
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:57:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5q2-0004ji-64
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:57:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so28922545e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772229452; x=1772834252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0GpsygPvlN/a2wXsnUdPgim+zYrmdQWQq7EA14iOTA=;
 b=YdZZjpaxlSugu05RPrAp5M4skMDqfz2DAEwtS3rgGbjRURE0MpXJ5QqEth20qBc9aX
 avE0lS/Jf89rhC/tmkMRlv0l21MTTWIp5au1fQILzdYh0hcrdG/KC3UqHhKql9dCqATH
 +WDQLETXWwzjvdsd+yGEP+mcN9od9sjSIX+fXY+4YZsAv5q0emSzsjKovAFNSGM5EXzX
 qwqRLgjSvd+7YKHbtSZ/vqxhQqZoXXAG6a+tOhkj5Ra5gFg0c/fj0NhhAxRoPCW31xGA
 olecGBIAq8uYpCN1JSbfQHGMEBdLdHOVeTJOxKkfGs+3NVnmmiRvvY1sGQUNTxKSaUmG
 E/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772229452; x=1772834252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D0GpsygPvlN/a2wXsnUdPgim+zYrmdQWQq7EA14iOTA=;
 b=KMdBQHCcY0OOFugXkZXX7GHa3j29DRnJhUZSfKd61Wye4HVHPMPbSYXVY+K3gYuOdq
 DihxQMvf5wTWEePVYtQX+thhA2pbwYgUAyHuOsQDJGtu8FgUi4M2jQD160kutGHOu2EH
 2cigebsL48ofik7PctTTTTxYRYGsF06PL++0eciQcJnezBkpT4q32AGuYzy3fVw/LbuD
 X8XXTAVxTPGQOpwmtwoSJq53/ixVBYY15U6KqSZ+rS/PnHRcK6+Dt/Indn8V1UGG7FFX
 iZ+umPtyjpqRsPCB6EtlvR4yMnpzRDxalh658CQluCU/2mpQzW2gJjgAYmjKpNl01q0P
 xuAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuxMg9C1G8j9D8IJh2+VzmQurKgtjVgOubUP1qP78+ufwW1baVI2j84Sl/xdsI8ITGkQ5Z02dZASFW@nongnu.org
X-Gm-Message-State: AOJu0YwCdlsrMvwgWY6AA+I2zXDeFaDqjsvbt554BzxmijOJlS3XqW3/
 MFIhnhLnZmzk+alMaHA6cSU8NXpJTstURg+7Gh9K/10H/ig7ZZd0Tw2C+Cm6Z0hdWsk=
X-Gm-Gg: ATEYQzzz1iYR4WIIUTYUiY7s7ymAPXIqeuPHDOr31HRBgxC2iK548CYGZ9H4+KR+NfR
 ETaGj30bcZAwq2RcgqNKR+KL5EhiA24AjL4J5uPxJ0PqOkdAfGrjjaAtgHy8JKLkSLJzA32Qm9Y
 lXofuZ56NrNTegBivPbFZwE6tUD40fgx8dp6M8YSsWHEpcurehFW+Iq1qNKrZ7pb8gPsRSaphgv
 Cfn/z1sYB+GB6mxAX/Bzj/RP4Jc7Omu8ZBQmUSbjej8qBziIgE/vzrTpGJCxh17NHcmckNul/Cy
 im/MNYTOlXoI2scd3M67STQTBTgyUuznkXqsynTILVomsVPupD8jXD6FNnwnmTMcspaxC/p37c9
 aqIczGEzJVxbxPEqcQrr1ChXRU5GMITgqBDv7Xbvep4diq3W2zp3ojQ0e0+P3hE0Fr1ui7niZD/
 9LAZL2s83Gbf15mWf1b0ciI4i/fUvVTejdNloRJr6hL0zNJSt+hO+YKO03A7EIJ7D1IQ==
X-Received: by 2002:a05:600c:1989:b0:483:71f9:37f3 with SMTP id
 5b1f17b1804b1-483c9bb663amr79362565e9.1.1772229452523; 
 Fri, 27 Feb 2026 13:57:32 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm10205266f8f.32.2026.02.27.13.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:57:31 -0800 (PST)
Message-ID: <2d78870b-b5d1-4c2d-8ca1-bed5cef38b10@linaro.org>
Date: Fri, 27 Feb 2026 22:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/37] target/hexagon: Add privilege check, use
 tag_ignore()
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-10-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/2/26 21:35, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h            |  1 +
>   linux-user/hexagon/cpu_loop.c   | 16 +++++++++++++++
>   target/hexagon/cpu.c            |  1 +
>   target/hexagon/translate.c      |  8 ++++++++
>   target/hexagon/gen_tcg_funcs.py | 35 +++++++++++++++++++++------------
>   5 files changed, 48 insertions(+), 13 deletions(-)


> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
> index 5711055aff2..b63990663ab 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -22,6 +22,7 @@
>   #include "qemu.h"
>   #include "user-internals.h"
>   #include "user/cpu_loop.h"
> +#include "target/hexagon/internal.h"
>   #include "signal-common.h"
>   #include "internal.h"
>   
> @@ -60,6 +61,21 @@ void cpu_loop(CPUHexagonState *env)
>                   env->gpr[0] = ret;
>               }
>               break;
> +        case HEX_EVENT_PRECISE:
> +            switch (env->cause_code) {
> +            case HEX_CAUSE_PRIV_USER_NO_GINSN:
> +            case HEX_CAUSE_PRIV_USER_NO_SINSN:
> +            case HEX_CAUSE_INVALID_PACKET:
> +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
> +                    env->gpr[HEX_REG_PC]);
> +            break;
> +            default:
> +                EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
> +                    "cause code 0x%x - aborting\n",
> +                    env->cause_code);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;

Just a comment (not blocking anything), I'm confused here because the
series is about system emulation but you add code to user emulation.

