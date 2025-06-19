Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AABC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM9M-0002o2-6N; Thu, 19 Jun 2025 16:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM9K-0002nU-D9
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:46:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM9I-00060K-RO
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:46:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so13742795e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365975; x=1750970775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MB1CBl6O0IlHjlJqofBUU5XvyRuiXL+4PObhOwtWClM=;
 b=epLuE3vOWdmfUafaIrDMKxr5BO0kGcfAQOu6UpxU4RZuu6L7V0gfN1SNaQjGctYRue
 OvCRWt93xdmezHN9wvLJiCTgaYM8eKVNdBCE5XdIQoKZz2HufJjvHhQI+VNpx1upqLE4
 YO6Se/wEs36HauY63Pdb1q+iwIi/RsCrCephD5dBJV0/Iq8edGeWZtd43/9m2kpSnomC
 5UVF7ln704pYRAJb+gMWDd9/EkaenLlzklSyCkHVcCsOHwUeJhekS7+l94V2TitLJMS0
 9UZOqiWw5IG6J36rIOtzTvIMdRiSFx7pcFNbFgdqyrny7aUIpEeImS17x1zoAuU3odnD
 9/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365975; x=1750970775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MB1CBl6O0IlHjlJqofBUU5XvyRuiXL+4PObhOwtWClM=;
 b=dEnqX1tn6m5ykCI4AJkgcg1M3Cak7M4uwE4DEbVkM1INYi94rD24zIDOUQFmnF/+Mr
 FbBBf5LLSbRXqhOQ1kcPNgwr1YlmdCwpKYoh5FVKG7rXIwNkr+wK1spdsk2ce1VKBS43
 z1ZW8PaP+aSuQVAiCDuxaK+bDAQs2kiQq4aKND8uIBzKb8d04NcYno1kbsIgjiAcU3EM
 SciaTEFv8IeWEo6SjAAfL8CnU9EonUiQPy90rqvHjZyVl7betniXKQXZbxsz8yacXQv1
 gUmY1DjpFsiZoMSFUDeh21Z0dnwsF4JcrFL2iCKn6FndLUjoZ9qs8eXoOBBjiPZM01IJ
 zwCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlPGYi7qJH3oc29FyAvinu1I8uSTgUSac5cSzWPkpMBVixhCRgzpjS6z8UfWM3QkAEmT17q3TBlnO7@nongnu.org
X-Gm-Message-State: AOJu0YzPPz01nlEi/0Fg95UeIIBS80kwr7ozjI/dfIjfvXoNcUeZ8DdR
 9Nbkz+LDbHgWH+4qn0kEtUeb8a5s2tWkqv2vXa4KBey0U4cIcJwSIGMp+19wyZEgQNU=
X-Gm-Gg: ASbGncsoGS6FN+GaC3WSEyP/tUC2WrkJ5/RXthZer+iwcVxikyb/EQGlzHwJ1hsJ1DH
 n3GxYdZMAfk/uhJFbe8Tu3Xd33MTc40hAschBxDxvCgguztd+3nt3u/aiOOZGg6Nq1rgBazS4a5
 U7R4K0nB0WpSHC53HjnsVWyYv0dxxhXTRQuOx8A3Cj7SAk5U6CMqC8wQl9KbFRc6/uKYpbEl4oT
 LP+11ajFH6nRHzrrsfx6/R4NZxzWChRvNWNKa64z8pKgumcGGWqhIzDZk71HGabczhNPKmNDyI5
 LPXBxCITkO6g26Hk01CU+xew0XkD59SU0/itmClf4OnSbwSVfe3mBJ4HaDoYFqj3SLYkD4Ks+xI
 3WuLXZwbI6bmDO+DsD0YIw3Xbsm3c2Q==
X-Google-Smtp-Source: AGHT+IF3mTTHTJ3F9XYIPqbFNYia5Zt0KyNatX+A0RxS7Z36vi9SHyAZPy/Wa7r5SXExihXyJLA4sw==
X-Received: by 2002:a05:600c:83c6:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-453653b46d0mr2015575e9.0.1750365975152; 
 Thu, 19 Jun 2025 13:46:15 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f19b30sm316971f8f.37.2025.06.19.13.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:46:14 -0700 (PDT)
Message-ID: <640e22c3-9565-4854-bad3-6cba7cf8444a@linaro.org>
Date: Thu, 19 Jun 2025 22:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-7-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
> accordingly.

s/32-bit CPUs/32-bit address space/?

> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>   1 file changed, 4 insertions(+), 54 deletions(-)

