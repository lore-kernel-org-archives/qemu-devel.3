Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E9DCCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwLB-00033C-4j; Mon, 20 Oct 2025 16:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwL8-00032T-N2
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:18:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwL6-0003B6-UB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:18:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4711f156326so34975395e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760991523; x=1761596323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9xi0or0x7ZU6pcC1+lqPJVtUwN6O1VEcxIfhitvDu4=;
 b=dakq0/9e+aIGnZrQliVrLhMabc5IVEcDbr3Ayuis4DIwIJfGWkvXFIHT0pm0I30Fzc
 F3okzxPx30Eoe7JrbCBb40UmyQD/rPYFds2mKJmxEuSCtjQ2k9KiZVHgXtqL6ZBsTZLJ
 cNzpdKgfubJ5lwHWEXRT2Js3fcYDySfoE0okrRuuRhFpDj1MFFZlIEuOEPA5cGLyRptw
 syJKG8RTih6NOgYMFy1A40W7CWp/9gDZu+3A/IQOcP+VyRBAk8sencyakPxD5Uys/QPy
 MW59jXrlr7c4C5f0wzBbdXetXCclergsbshX7GEoyKYAyt/kvJ49yC13bQkbriL2dD7G
 0QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991523; x=1761596323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9xi0or0x7ZU6pcC1+lqPJVtUwN6O1VEcxIfhitvDu4=;
 b=D8J9ksgViIfPYG2CQpihr+QMRr1CIzwPCSnjSPf25xdA5fKnZS7lnaGRjx+eIA4/YS
 xdV2bZaazGBAfPnrPzOK/1Xuyyv491zUXK4czNR4fCCU3AzR5WhxGFYzEnwrvkcJid0e
 kLah1gEG6rHZuygze2H4WRRXBKtC3nBxc8MP0UrfNjo9c9oUZdM+u9uXaGy60dBty/GF
 /aH0hYeLgrSZrd+YhNQByyypRh7V8ziHs/zZbCMYSfzhw+GM875v1bcIxNZIi1wnjFpM
 1tyITECRfsrG1fUMNbDhK6RQfRJnu+XvclmQ5gcWDxr1SKcE7c+ygEJyvUk75geLosvw
 BkoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUMACRMx1L0N75+/ob07L7gl8MCSdn3QQh6aRcjLK5ncDGJNFNOvECwfKXwhXAR5/VRjU0mnb1oGXp@nongnu.org
X-Gm-Message-State: AOJu0YxaJeGpvXDpd2WvLQyhXAdDSScDGXaoSOG2Vc0GYegLZWI5EQGb
 EDRMgrVgubdlpfaiLQeVVa9VoEVHVjAj6J7EYNnyKDXZejW2M0cdZ6dzuybRmPshvHPM1jTWhfP
 iRcwdWpQ=
X-Gm-Gg: ASbGnctoKE1lJZ3l65PSnOBFWXng3ujzqMQ9cP1F+tWCvfNjfbIe9zXwNiGhnMd0xNA
 OOGrFCR0yeGGOKjQrnDhcE9Jer0UAQYxsLUDAmtfTWKwvECyvDWgRc8/1wAsjAwqZDwE3LHspBe
 XhIO/iTA+1m1yB6cJgHAwGQcTXC9oRXKD/6laIUGL0oMk9RoAWBuQR5lt/64g0E6zWhTKLvFsNu
 +5LJWas5z/QpNAAvHVQUHKOVMi10nGu9NtsYiUQ2v2u/4X6MC0dfyvZwm4imzCE+IZrV+iYZFj9
 8L6aY4K7czb8vBoEqKRK3eeUQsd4ixc3muKJAGzs+4dQYMiy909mwFaOuVwe7mGJbAfjFuooooQ
 wtOzrkrVep4UbW2rVqV+oYG8NkfveqBJ/vGeiffN4gF2dnYJ3cP+No0HuArZ6CCcMZgs+ciNo/D
 /F3HY0tlwMqaqzxCWTm0+3WqAeENs8ReOdN1RjWTiU+C4=
X-Google-Smtp-Source: AGHT+IGEfoGpkgWAtyjX1cY/IQcpcJOdCr0Psvitn5YpADo988aHVCeZefv3LAlI/UUcZcVZvp8WBg==
X-Received: by 2002:a05:600c:4e11:b0:471:c72:c807 with SMTP id
 5b1f17b1804b1-471179079c7mr117708685e9.22.1760991523420; 
 Mon, 20 Oct 2025 13:18:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c34sm260890115e9.10.2025.10.20.13.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:18:42 -0700 (PDT)
Message-ID: <204af6f8-cb4a-429a-aacf-2fbfb3575a2f@linaro.org>
Date: Mon, 20 Oct 2025 22:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/16] hw/pci-host/raven: Rename direct config access
 ops
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
 <74fcd70106289663ea426161aada78e879995d6c.1760795082.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <74fcd70106289663ea426161aada78e879995d6c.1760795082.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 18/10/25 16:04, BALATON Zoltan wrote:
> Rename memory io ops implementing PCI configuration direct access to
> mmcfg which describes better what these are for.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci-host/raven.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


