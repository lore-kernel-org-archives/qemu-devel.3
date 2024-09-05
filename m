Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB64CD5BAE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smB0D-0007cv-F1; Thu, 05 Sep 2024 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB0B-0007XS-Ij
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:50:15 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB09-0001VB-D6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:50:15 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e1a9dc3efc1so846439276.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537002; x=1726141802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfV9pAqpw4taDrLOaHlrfwZ30fLUxp7pKu4Gl3hSOjQ=;
 b=E3jUsaxZ67Q/K5MdXBxwDZbjES5W37pWffjODAkx1yva2xYm/tPr4NAMuGy0Ig5xY0
 jFu96YdTzMKk49t/dMdhBxaW45pFyaqxXpAO1Yf6ojaMUnz2nQ1+29klwQBBBNczzkzO
 OTHwcQ6TL9qR+y9qWqSNMTaP6LUC3ZsCZCD4SqXxW0DKbVAIW49ZKUidF14tL0uYQfje
 jL74U8X+sVh50mFX/a2elktwgrApjTaCAaHl7aIyS3L2KR41qMpmwKpufMiSupxUvzn6
 tEVzVPCfxFkQIcUInutj8SupdtjFl0Q53lmsy3tI0I0K0CPidkxHM7IDh/rIXHs2n0yR
 N3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537002; x=1726141802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wfV9pAqpw4taDrLOaHlrfwZ30fLUxp7pKu4Gl3hSOjQ=;
 b=Cfq86EBqerUOSKKYlbphH0S/tozjKag1G0FMl2BT16mIZqlvg1JSg8RVN1nmqsyB5H
 DDvTkC770DqsWjMUum5i65Mti7vt/trgYbk733aL19eYsG8HTlOEnqIh1vWRVD1dZoNH
 G0hBRpp8cDO0vnoAUFQBcsD0v+YaxuRjCv0APDmNAG1hfx5liW48MsRkrNhZR+XzKuiM
 OM/LqllkDV5vxR3MPEcRZ1YH9uMBMy3YEtA9VHF6x7p8bHfMnK2Au+gRKXbsM0gIKXMS
 8QqKs18y5mHDgp9Q1PHUP6xXFbCEaSYoWKOkx19FikJtEIDc9/BopPX/mcA/qeDChyCY
 Or4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdViWABqkCvRczHatmkFo+9et3bwCkprihNpJ96XeH9/mwgstYdqXYnuVmQUHIPJ2ZZCsXtSNTVOD/@nongnu.org
X-Gm-Message-State: AOJu0YybKBYd9IYB3jvvvQJK5M0HD4EEDD4vIZHTd2L7GoQTAHcvS4DK
 t5xNDgc8vXnqQIUrYy/Y3wUvSCU24HMSVJOq36S6DKw2qL1ymwCdWmInbOi892Q=
X-Google-Smtp-Source: AGHT+IHOAWUomrHCBYO/gN77zvvg5jFecSXXTE8RI8bF449lhY5ub+eDw59z4BdCC6CX1ZXgrsbyMQ==
X-Received: by 2002:a05:6902:1003:b0:e1d:2d9b:b2ed with SMTP id
 3f1490d57ef6-e1d2d9bc150mr534091276.28.1725537001894; 
 Thu, 05 Sep 2024 04:50:01 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201e42a5sm6862206d6.36.2024.09.05.04.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:50:01 -0700 (PDT)
Message-ID: <ff03f3df-dbd0-4a53-aae1-d3ae0c5fb9de@linaro.org>
Date: Thu, 5 Sep 2024 13:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 25/53] hw/arm: Remove 'n800' and 'n810' machines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-26-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=philmd@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the 'n800' and 'n810' machine types, which modelled
> Nokia internet tablets. These were deprecated in 9.0 and
> so we can remove them for 9.2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |    3 -
>   docs/system/arm/nseries.rst             |   33 -
>   docs/system/target-arm.rst              |    1 -
>   configs/devices/arm-softmmu/default.mak |    1 -
>   hw/arm/nseries.c                        | 1473 -----------------------
>   hw/arm/meson.build                      |    1 -
>   tests/avocado/machine_arm_n8x0.py       |   49 -
>   7 files changed, 1561 deletions(-)
>   delete mode 100644 docs/system/arm/nseries.rst
>   delete mode 100644 hw/arm/nseries.c
>   delete mode 100644 tests/avocado/machine_arm_n8x0.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


