Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E061D1062878
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Iuu-0000p7-AI; Wed, 11 Mar 2026 08:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Iuq-0000hC-U1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:43:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Iuo-0000uT-VO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:43:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so27351125e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773233033; x=1773837833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X0O1QjTZuf7fYB/wFOuDsLUD4pS3LpeUVJW7OblWKRE=;
 b=Q5b8YjNy1SCAVUzZPdSNtMCmznA9w6usQV6SCxHSF2LJDtLk64XxAPD+3miYxk8SSE
 +OLPtC50iPurcAKkUheXlmegoKmfdSdzVcZsZj+wVdL+BvLLd8yhc601YXML39PpPotH
 iS0ZDcumWYUkcjEZW/guV5uPmC/FCICg+NijpoIHd9xch/90Vz4dG18tFF2B6+BSHCbS
 TzrkvzaxI10Cf3O2OZILZQ41eRiBz1PjQy57kgl36iCOYBD018i/Yi+PJpPLksN8udBz
 PytlkW2v7emDB/BJlWi/Qwt1l3VMWAROscyQ0R4KrZD11/mGpLHi4Ih1dV78RxhR0hko
 jrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773233033; x=1773837833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0O1QjTZuf7fYB/wFOuDsLUD4pS3LpeUVJW7OblWKRE=;
 b=PSPyb3KxC4lqBRWA3jVrdLCs6bZmlb7DAOLqhTuEuF6l2z9vful5XxkKWxT9pu4F5I
 +QKZ3Mrxio8FiRnwN4fFsSRYEDPm2cPX96y12iIgMAMdtPG3CkUBLdW8ybYiD/apNxF4
 aRfwRwEM+3E7vDSz1Pb4dhZ5XliXACajDCk5xhcbBPlhNVyDFzj/xAaVCO1MnL6e5W7v
 n97/HNuVMo08XtINY+ofE41BeErmfUGFOMuHKSeRSbIqIiz8W5uXuu0Bjt16mRM9wyFe
 AcuzBJn33QxJcgrJLF4IzjnZzmC0ZB0VzRgVli9vBJjzNffg000LZGTG9wgPc7+r+n7B
 aX8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHGDkKowFxBA7iFN3bWhU24Xpy28Gs8uOpCDU2FENtdh3lMsLj1CiCuLORVOlg2pWsmEa7ahmaPAFz@nongnu.org
X-Gm-Message-State: AOJu0YxfNs1r6LBTcE43F7hNIo10Ciohoex4myOWl+39JS5ZIY3HFmFJ
 q8AQxZScoSdKxRRCnft3lVjOkKyB2zCIioWOjMr98t56OVbaUHD0eOLJ0RF2akkFBus=
X-Gm-Gg: ATEYQzzUV3dTNoJz5PLDhXTpC5byQcFN6xkS+J0FdQfCiqHtQlzh9mpFiznwkY+mWYB
 ouP83LpQmrQv5efBVitC4YJnTR5n+x3nFT1tyZLr8BGvwuM4idan3R41rXeoM4UCy4yALoQRv31
 J1RD5l3r43ub6NzolpH51i1cWKwasFuvZNrMKGKwP3dsmMLif3IBjax+3epal+CcGzalv53tspN
 hX/YDSZI7L6YgdDIgsVljdJByIlpZBihQrwaTfakxjsEHO6xWMc3K1teT6rR1OusB162+/Wa+xX
 StC05qzHh0YI+B+nfMaf741I+xw4BrZR2kZG4W8yX+0euQXd68vCrD54vSQ789777pIbKdVUV4M
 Ry5EaXkmSNg2gRLNc9WhqQYPpsEKm7UzUBxH/aEdFlidLUKGW5Y0mMwKXT0oLE/N0B1bboX8lbS
 A9+Nz/LkXbE87bSePnjZr6331jWkN4S9MlKsN2MbJpCTaLu31JEYywtuIdVj6j0lewmQ==
X-Received: by 2002:a05:600c:1f87:b0:485:363b:fafe with SMTP id
 5b1f17b1804b1-4854b0a4fe6mr40008375e9.1.1773233032927; 
 Wed, 11 Mar 2026 05:43:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541acea11sm176106595e9.7.2026.03.11.05.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:43:52 -0700 (PDT)
Message-ID: <0ab6bb36-0938-4ab9-a769-e0aa364c40e2@linaro.org>
Date: Wed, 11 Mar 2026 13:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] hw/alpha/typhoon: Create instance_init and
 class_init
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-5-4375b00a85ff@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260310-qomify-alpha-v1-5-4375b00a85ff@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/3/26 23:31, Yodel Eldar wrote:
> Define the Typhoon class and instance initializers.
> 
> Add "cpu[*]" link properties in the instance_init of Typhoon.
> Setting these cpu link properties will occur in a later commit.
> 
> Note: This is one step towards splitting typhoon_init() into the
> instance_init and realize hooks. typhoon_init() currently takes
> a fixed cpus array as a parameter; that array will be removed soon.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/typhoon.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)


> +static void typhoon_pcihost_init(Object *obj)
> +{
> +    TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(obj);
> +
> +    int i;
> +    for (i = 0; i < 4; ++i) {
> +        g_autofree char *name = g_strdup_printf("cpu[%d]", i);
> +        object_property_add_link(obj, name,  TYPE_ALPHA_CPU,
> +                                 (Object **)&s->cchip.cpu[i],
> +                                 qdev_prop_allow_set_link_before_realize, 0);
> +    }
> +}

Hmm this machine is modelled using quite legacy style. The Typhoon
PCIHost object shouldn't have direct access to CPUs but only expose
IRQ lines, then the board layer wire these lines to CPUs.

