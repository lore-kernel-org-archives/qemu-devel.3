Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5143BD3EE77
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwb9-00039G-1G; Thu, 22 Jan 2026 10:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viwaj-00032O-W2
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:27:27 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viwai-0000ZL-4D
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:27:25 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b884cb1e717so68886866b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 07:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769095642; x=1769700442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uW1V+s7u+HNdPobCVun1IWQC93ofS9yzbEBz7pnkFw4=;
 b=c7CMXPqyLasKAABHIh2xZONZpWH4uNDswHYIP4VfXbV9+fAl0k5pttjJ3aIDKLSNJ4
 7291mb7pBdwNOQDT1oMIXNcYdhAYX7+sXnet27ye9baiq6E+CX9AhY8eyB5bxpvD4IBX
 aHw1bLxmiBSDLH32r7YyD/9i+ndYpjP2QSl/G1p7nYUYnPOdLGeNL2A5C6UL7bua1fxg
 vT3Wi5JmLHQVLAQAGVNRC6+YSjHojpGlqXnVmEnc7gJyq8ZMA6lSAXdakJitldz+zMV4
 dpfPtu+Z5TXMO0H0t12c8AqGmtMwAbl/YRsO87fYFGLVQEv8gRZr8sReKdICu6uMFeq9
 3DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769095642; x=1769700442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uW1V+s7u+HNdPobCVun1IWQC93ofS9yzbEBz7pnkFw4=;
 b=jUcgMoDkThyziPzqiqc2MABgfpTHzLJ1KMvAkM4DMhEAB6Y5v1wOvnS1WjJ/p6mua8
 AlCW/SNI2snnZuo1gnHNRa32OKNPkd2+EgRmlDq823Z00TgNB436+RawAIShu5hkigvG
 1okPufv68Hp1Y3FOOd/PkFTj+sRb7nV3Z7hydOt+6KBPoHllUxZlwOCE3zox1k7v23Rp
 9kWR1UMjZS1MrVDisXa3yMv6rKRXxvskeFTrvJmSHsUj1HC+SE+HnbvfxSHEpAT6f0Wv
 GBUU49R3hOLhbeW/mS1tRuzxdZnoMNX7IcqxKSt6D7U2EJfqa4V/2qMkhZwJf3PL11aX
 iSHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdWfZ70TRtI2RzYiHk5rEs7rcsfNAK8DsO7pP5M1yiSn/CoA5F6Km/uSF2zNG0QO3mv+GcjgTRj6jU@nongnu.org
X-Gm-Message-State: AOJu0YydUflBW1IPd9kwTaEt8ICE7aJiKwvK5uiyPBd7/B7I+Ai/K3uB
 DWDNJxH0id/QHFamEtWcrYhGsjjhfmt8a4VNZCD4RfiXfih8sMuBtuWAgwpwtWBeUG4=
X-Gm-Gg: AZuq6aJYEabDu7U6ZkZDrGTwNF3pxZOMHYzNM9Qhu6v5sxHhAa7EujJEwTYo+9F/9Qo
 60+fJWeJMHnxAD3AmjqluNBJWf7Ffznji9MViXkgoLSf+bO4NR8CL5vJHWgnpGzmflJEcEgzXaP
 2Oebf03YAueWLcBZq/14hJTKrRyJlxZ0MT3BA0pJl1nakxe9UVdRHFApL5KKeIdqZS1U/9dFHPH
 /nqi99AzCvMfzz44sIVGs3AHO4pB/hpVKWgYq5MZDMXJjH7MzgKjvrRRSQboXCj4idlehLCOwB3
 HeFCH9lt+jDFxnsrdA1SXi5x63JCR5miUTViGKhjtSGr6uiETff6FkAuBiOg5jLfqtUMA9LCIl3
 U5xSHNK2Huk+OwYHE/dfQ8fD4pFjimol9Gc2qHb+uNmJN3P6wyRDjKqp1NFlGDTBp6Ei0CvLfrm
 vvP+5B9tE+dBsxG+K2u8/jTOyy7aoI5ubVkq2P7iVIoAOGR1dS8rqcH7NoXwbM1h+W
X-Received: by 2002:a17:906:9fca:b0:b87:8c1:1ea8 with SMTP id
 a640c23a62f3a-b8831b1663cmr277509066b.7.1769095642275; 
 Thu, 22 Jan 2026 07:27:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm1732809866b.13.2026.01.22.07.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 07:27:21 -0800 (PST)
Message-ID: <873bf43c-0559-495c-99d3-6bc0ee39ac6e@linaro.org>
Date: Thu, 22 Jan 2026 16:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/virt: Don't use vms->tcg_its in
 create_gic()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <20260120180339.1416328-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260120180339.1416328-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 20/1/26 19:03, Peter Maydell wrote:
> The create_gic() function needs to know whether the GIC
> has a TCG ITS attached, as it should set the "sysmem" and
> "has-lpi" properties of the GICv3 only in that case.
> Currently it does this with
>   (!kvm_irqchip_in_kernel() && vms->tcg_its)
> which implicitly relies on knowing that the only case
> where we aren't using a KVM GIC and we don't have an ITS
> is where we suppressed the TCG ITS because of the
> board-version-compatibility no_tcg_its setting.
> 
> We can avoid direct use of vms->tcg_its now that we
> can identify what MSI controller we are using from the
> vms->msi_controller field.
> 
> This means that the only use of vms->tcg_its is in
> the logic in finalize_msi_controller().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

