Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC2DF8E4AB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcmo-0006C6-Jr; Fri, 17 Apr 2026 02:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDclw-0005Qe-Tl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:34:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDclv-00081C-Ep
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:33:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so2571605e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776407624; x=1777012424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dp6XEdqto1t/92N6PFEoVsJxmpkNvRTtKwhTkck828Y=;
 b=CY/WE4Uk/wKIph3MGfKhAQtFREF6e6kiy1nA1QnSKQBV1vh1osXa0+2PqEhT4jmpOV
 HWIn4tsi6toAcZmIFJFTt9DDfwss29czE05t1gqsIiYYjwPUyp8gXO0Cv6jHq11NgJcA
 /b7eWZJnVi9+QAMey3HWb0pgDy8M5CSCbPmk/vOvZjlmnISp9Ti1GtiwnEMe0O1dQ9Fq
 zz0K3tHNfOk6e9oHUYnjztH2evuviyR9kZhDzRE91K5rI1+BH3/EkWEBsJtkx2QBNGqK
 POQM5V+ONdaQ2TCJWiQS0bgwmMtzFeTsnBnXOAC/5c3AAnrHSMv5b5bObLIzjI56aAp5
 VXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776407624; x=1777012424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dp6XEdqto1t/92N6PFEoVsJxmpkNvRTtKwhTkck828Y=;
 b=bwDz9h392iJEr1r8/Oh8IA52hPsEOY48QKZ5xWqmI+x7qXZJ8csFTKmMOpja1gUqUf
 nqpo64iVhdBVMBfRIVVk0REBMLFkkxdZObhzR7167ZordC7I+7kgHA/tuMevGT9b6LHC
 wlropoIxKSpfIoKMsZ3SkHlTjLN010CjlreewLsYZqfscRAooYXn6+f+lI7V3RIYekv1
 GLLDgBBuL3b0pSg7sNXB2ApMaRoxbIUQY8pfa+KMcfSMXVrR+SQYgCBICYjUiHCxR4Rm
 iZ1g0he8uge80kMQMaP+mGC/B7XosdWujNTZxQNNOVE68IZT6G3tPke40Xs69ZIwYEBI
 7+mQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cp3v7WEnVH/fq+NAyC7N5WHilv/zrZ21bJBeivEEw8pmSq6CyjA84CbY38F/Q/3w2bv+XLEGDx1fd@nongnu.org
X-Gm-Message-State: AOJu0Yy+AWVgjq5sA43v79reW8zm5QwY6mcXBKoCl26jJpn5++nJh7c8
 Db3I1R2b3be3m9T474T+vIj7ubG81l6eCc0ME1uZk4fhZ7uoThR1Vj9pMOTE1LYqB7o=
X-Gm-Gg: AeBDiesQTrbJkCentroXGvPTGu13qzXIq1nj5YpsI+BiUMaJ0kCPjb7ZJKRIcEKcjl9
 cKa6b3YuYJeQMIKCSwhg8qivciGnS6EevWStovJ9nQPyFMmWewk/UfTjlOT4VRPyVsu5FzG1/54
 koDU9h2eQaJdzHJKlqEBWZ1XAfThWJUOYN41UFwelh6wN5SOZJWqQu7TUtrNi7TP7dOws8REHFh
 +Uio67ZTEyXhd6YFkcG51aUBBzQIQjZfjdpdjJHgUv0RsU1EiQYAWz9K0kSGJH65uDaVntPnI6l
 jElvkF+81QtdDDeRNFde4sd07IRORTvFbMyAQGepE6s8aHIDmUtEOG3ao5NC/qsFKDdYqwAJYBP
 PVCjPf8Id1ZU6bHT7B5mI5eXXeTuVgPHgzv0h7nqZ4aizBLd494yO0NKo8icafZgfY1EhY+eLVJ
 1l0Ya/ACHCXOSpgDxDxMf/HYg8sCOGgpkMYIQtKezcdoVvZ34y6qWsqcq6gJagqDXkGpDt3kjeL
 qpP
X-Received: by 2002:a05:600c:c0db:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-488fb73b259mr15107465e9.3.1776407624313; 
 Thu, 16 Apr 2026 23:33:44 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7bf969sm9010785e9.33.2026.04.16.23.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:33:43 -0700 (PDT)
Message-ID: <e025f46e-8cee-451e-a25b-0d59fe6b2e15@linaro.org>
Date: Fri, 17 Apr 2026 08:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/4/26 03:49, Jamin Lin wrote:
> The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to
> form 64-bit addresses for EHCI control data structures. Per EHCI 1.0
> spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit
> is zero, CTRLDSSEGMENT is not used: software cannot write it and reads
> must return zero.
> 
> Add a capability check in the operational register write handler and
> reject guest writes to CTRLDSSEGMENT when 64-bit addressing is
> not enabled.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 6409457186..b9e4251d62 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1108,7 +1108,14 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>                 "      is enabled and HC is enabled\n");
>           }
>           break;
> -
> +    case CTRLDSSEGMENT:
> +        if (!s->caps_64bit_addr) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ehci: write to CTRLDSSEGMENT while "
> +                          "      64-bit addressing capability is disabled\n");
> +            return;
> +        }
> +        break;

I'd squash with previous.

