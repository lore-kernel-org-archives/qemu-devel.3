Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B25E93802
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 20:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC1bo-0000Ab-PQ; Sun, 12 Apr 2026 16:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1bl-0000AO-3P
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:40:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1bh-0002bf-Dv
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:40:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso34795425e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776026435; x=1776631235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ACJxaywudMwrTLfxzQ6gGKprUXdb7b0YKQf3koP+Buk=;
 b=iFY3sGBiGvcAEtpTWtg/FSdhZ84V3qai5l+FmcvasV9GXHuf+wunj5tG6t4fwJC/KA
 6CATk2Fc/9YPrj7o3zQasBVqREJ2oj3o2QDzEqOy15cvSgEWZrIaADdhn0GW7BsRQvXK
 RDSPlUfhIcZV7t5SEQ7ImC5UBoUORSZUuEebvHH2JmXm8E5tVG6g8WR2m3o+kyr+0Zq4
 aXqoxTD3//r0BAb0lnTXHhUGC0SZiDa8BcLqsltuHhTCqJSk63wmcBabzugKj4pznC23
 gG7OfNLzSgfEevzwIDxLpI6l2zhDQl04jGJ9cvzc70eLQxj8ag/RFLJhQ+FHgGCiHJKL
 cC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776026435; x=1776631235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACJxaywudMwrTLfxzQ6gGKprUXdb7b0YKQf3koP+Buk=;
 b=HQm4eGNVOxb+mr8HveGeLGfkk8LbZi2P+opvuLpKKlcu4owWW2w8ZFtR7FUlrGn/Kb
 0eI2luyKrEeAYUi2GHuVrQPb1tFYn0zvHdC2T5Cvs+cxQ/9a63hm0hCjSIHFoXRY7/dV
 oxpdD4dG01QHLkr4YkNBf7fmjHIm19VYd4xZi11v/u5Jwc8TGKltvsdwFbzuj9Eu06Or
 vZjUbVOoVIF50tEpOavak3CnCSK/tV5FDNdmdudRf5pngHDsR/4oanfyGe6Q6cQw5sOv
 oZbgqKdLogNVeu4SLh5r06/zIE+ZGSxxx8NwrhwPgutvwbPwSVn2cdYoaTmpdNUaO2Or
 N0sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWO3n3l5i79nsLxWCx4WNCCP1LnWLEQPLz8U/15s3lkASlfkW4ilNNlvjGg0CxX2khJp4FoL+buMJ5@nongnu.org
X-Gm-Message-State: AOJu0YyD9t7xV1x1GcpYkkXyom2wpa6RAD9opN2KNjM+dMTz9YUNpeMd
 YGu7WJAJUjiOBGIgjYTu4pj/fQvoT3jQr5+dk5Hd1gfO3OIjGdsJ0AZz4kupZv6jHHI=
X-Gm-Gg: AeBDietp/bSB0vKZaPq5KjK62Mg9nWOg69LOBOw3NuSGW7R1+bjOz87MzR9duVQVNQZ
 sl9D8HtlrJKrl5xeawJTSRYAKRZ1e9Fp4Odc3cmZmzKybSoToQozXqsST5vc639eCNOodrtJYzY
 64A7ICs+u6zCyhHLI0T/WYUYTlAeOfRP5WWN2D1F+g6R4vUApTi/7dg3nHwQXbvrVTQoOhwuqtE
 CLd+RR7+q9GW/qhJ9jRFK332zNP1ySUtXOf4AZ93SK5BwAluT772dA0jW6Yt1GnHkikmWV+Od38
 RBXkpP2FGTVGvFjYkdr95jTe7ztfwyUjDdIKzF3Nctj0mSpzbyEIl9vo7ANGzZLrK3ZUQfsZcz1
 nVd9TVcosQtjQHzfeUPOFFZuSnNNcfj+uYRsIkQJLr19305dtIBKwFXnNQVa5zYbVsdzwBu2BzD
 8bKt5KJ9dqrjaK+ucAPazL6AT6ex2UstKYm37OPrnDgMMe1aoA9MPY71Zt7XKrLDHwiw==
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-488d68766c7mr136914125e9.18.1776026435442; 
 Sun, 12 Apr 2026 13:40:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d58a414bsm244320185e9.4.2026.04.12.13.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 13:40:34 -0700 (PDT)
Message-ID: <1ec64a4c-b648-4b79-a3a1-ca938ef4b7ae@linaro.org>
Date: Sun, 12 Apr 2026 22:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311072614.1095587-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/3/26 08:26, Jamin Lin wrote:
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
> index 9e82328116..d7a0917caf 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1106,7 +1106,14 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>                 "      is enabled and HC is enabled\n");
>           }
>           break;
> -
> +    case CTRLDSSEGMENT:
> +        if (!s->caps_64bit_addr) {
> +            fprintf(stderr,
> +                    "ehci: write to CTRLDSSEGMENT while "
> +                    "64-bit addressing capability is disabled\n");

qemu_log_mask(LOG_GUEST_ERROR, ...).

> +            return;
> +        }
> +        break;
>       case ASYNCLISTADDR:
>           if (ehci_async_enabled(s)) {
>               fprintf(stderr,


