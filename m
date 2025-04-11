Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAAFC369A9
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVs-0002ut-7X; Fri, 11 Apr 2025 06:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BVf-0002dk-KR
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BVd-0005QA-KV
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so14704675e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744366871; x=1744971671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2OHFG/wuMESVdiY/brern+bOe9wGDZGr7SfTt8104c=;
 b=T8IgfIxvyBalU/pe1C62ENAdBwYh0fq5vWRoN+gnZ1OxbEre9C3Qr9AIvIxzi8UrMm
 e6kxIkbyhTmwmtcVTmB9FOouKTPj++3dWB26kbBaOvFlzZKYjDtcWGbxn3dGfshZTt78
 urw9mXjkbvYM6WDglT0ok0Uupw/YArFg2SvQ3XhUh7tb0MhV925ilTPcevTbPbJ4Qqva
 sCGaRA5iQ9roxy9SkPU0kB5O/rXnA7zmub6sZR6D516lFikhJeZP0pUyuD6WTTa7HVJk
 ZcmNYXCkR3CxizbmW3ayAQpI7y4P/Jg4efBBvUF7lV51rM45tGckImlsvDg2wgD8KayH
 NkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366871; x=1744971671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2OHFG/wuMESVdiY/brern+bOe9wGDZGr7SfTt8104c=;
 b=qQq7ADLn/0l296ZgjtmO7jpKWLenykoxshKkP/Cxhxny398rJUD3+pNVWnmlHTLueo
 CNFMOfsCSGkp8Pf2ENKbla1FMuGmnknfs5qruwrxLRB8Ndc7ObYF1BzQSx+jxpmVrsMr
 km6JwAHSdd2x+izRd+5hCubt2okSmXtxaTnPnAbBMYhdjk7JB7oQR+DIiSw7y5wH5k0V
 aaECKTQ/MqRpOdChhHoCCAYLC6+vP7VDbHwwTh3Bil9FPzR53/dmUqeQ5CWiev8aDAUR
 eWCMJZmUJ3ivnOWZAOO6ykYr4m5JxScNPLhhcNoBrZtfdlg/pLM+n3p5xug92Sn9dGY+
 UZ5g==
X-Gm-Message-State: AOJu0YwZiAJ3KoPWEfeg4OSTxcmn415ihbMH7BXAAfzErP38qeMiOh7a
 AV3DgiFDiGhRAF82AIXrUX5hQ152H/oeSyMv4caiktu+fgZAlUr+DN6KWhOpW2U5SYcAMaD7tla
 a
X-Gm-Gg: ASbGnct+kP6XER16VUkQgqkJRM/l1wfgLEfEaNS++kJK1n/tZaH806AKGzPVJnt7g4o
 rc1V+IyLQKjMx5IkJJKUWLiRHiOueDPkesQEmx4CUjtKC4x5Bl/thvycly1U6ztt2a9klbRNHm+
 Gw1NjJIvfSx4Ms1ZCpmouTdMIb7QgN8ZZREa9TBg7R4SQZTLdQyG7XzBaCV9rtoTYdNzwDUCpyl
 SqB8n/OeMUuT1pYiAI1B3knM45H8GM6iCyiO/J9KrWUy5VtlKdhQehrMY39NceHPQQg/IRCOZO3
 TxJnIB8AELpknnXDtNLgEDcjO4Y7ZTuKwZ+MWt5YQBeriR1nhl2xl1U71nLgrFl92iM8umIHj9V
 UFw3l+Rge
X-Google-Smtp-Source: AGHT+IFefUarty8q+Lk6bHjuo9tRQ117ztA+FsdMK1IQUNIW1TTbwAUMsiORe055fM4Ffg5CsRPE0w==
X-Received: by 2002:a05:600c:3591:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-43f3a959e43mr18141795e9.18.1744366871349; 
 Fri, 11 Apr 2025 03:21:11 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ec97csm85181655e9.6.2025.04.11.03.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:21:10 -0700 (PDT)
Message-ID: <88ac3951-bac9-48d5-bee7-6ca2e465fe0f@linaro.org>
Date: Fri, 11 Apr 2025 12:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] usb/msd: Ensure packet structure layout is
 correct
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 11/4/25 10:04, Nicholas Piggin wrote:
> These structures are hardware interfaces, ensure the layout is
> correct.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/dev-storage.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index 2d7306b0572..87c22476f6b 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -27,7 +27,7 @@
>   #define MassStorageReset  0xff
>   #define GetMaxLun         0xfe
>   
> -struct usb_msd_cbw {
> +struct QEMU_PACKED usb_msd_cbw {
>       uint32_t sig;
>       uint32_t tag;
>       uint32_t data_len;
> @@ -636,6 +636,9 @@ static const TypeInfo usb_storage_dev_type_info = {
>   
>   static void usb_msd_register_types(void)
>   {
> +    qemu_build_assert(sizeof(struct usb_msd_cbw) == 31);
> +    qemu_build_assert(sizeof(struct usb_msd_csw) == 13);

Can we add definitions for these 13/31 magic values? Then
we can use them in try_get_valid_cbw().

> +
>       type_register_static(&usb_storage_dev_type_info);
>   }
>   


