Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1167C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUmB-0001KD-Vj; Mon, 10 Feb 2025 09:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUmA-0001JR-4v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:28:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUm8-0007Zo-DT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:28:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso2288486f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739197718; x=1739802518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46xlxB1oYnlVOr8Ikw/9xJEJTlqoea2lckYTcdY7BAk=;
 b=NJH8xoW8IzuX7q6bbm6wwEoxEuXtNVhPmUb3PsO2pZ+wosR6hoX5gwVufYbdLrKKcx
 kdHySx1J/9sxC4r7A/c6yg22CbmirFVYSgBvXdHGwR/mXOdq1D0lkFa0F7Dk5BLv2dE/
 pOfX3PuaJnlSRO5jd+LDL5BcG+yNQPqoOgx0r9tYKi1i4h1hcRn14tD5t0qqLNKzgpTT
 0pOchcvazDGXUCA9ulFPR+MPYokfR17QdTMfYd4W9SrhoXYT5Z7tECTv52qfjhDx/JRy
 8Cqs0jgxX82N4ZX4hHFKxwvN9V1CtO/o8KcoMLXWpoLinlehgT0BWRsISRs1jUIBtwTW
 UvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197718; x=1739802518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46xlxB1oYnlVOr8Ikw/9xJEJTlqoea2lckYTcdY7BAk=;
 b=ZNEQEGgiVHpWURJS3oKKpk2yrIRJfsUjBF7eCExceTYuOzbR2neW47zBR1N72xK83f
 z+KRX9wcnxq86QZTa3m/zRI3HFjpvxGmRWP37Pzs/Nz22OzecrVEDQPYNMtkUeiHpJBp
 qGkX3+xgLG0FbTRLeFkj6pWYR8RSse/1xN1KpIlqtxlWi73W/1mvC4OM+yMSMv1nLt4J
 k4XDFkmAKE+2CnxW2eZ/bWWzsk800kxtDNzwcCGknlSaZy5ITsd54nGh940XtK33FuVk
 6Q45MuN2mmV6m1B45x+JTNLx0l4fuLZOzWssZQOIjahfcZFRndG1VWYoTaXYMcimsah9
 bQLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDMWR2HtufDU7Emf/PHI80yoFFJhvtRfIxAFrT5KR+P1+g9KHM87+uvt8gwreX67q3NIoDm47LuM9H@nongnu.org
X-Gm-Message-State: AOJu0Yx9gXzX3AtlYCh/Cus8lrFs9m+UVVXLrZrpfkoE6EPrXHI8E+2s
 qyxRWzlz9mkq9nwDzVvwrpA/b0sC4DTlC2f7tuYiOhF0pAafjKwvW6JNScx35rw=
X-Gm-Gg: ASbGnctY6dCIv6iAsUeswo0guj2J2sBUJ6lflnuwqhb5i0qIauXPs8K9tTKQ0orBWM9
 I/dLzQir9mJQftvKekwTfM/p1E16bH+ckuTX2oCIikOGJxmYCJg6W8wuJkxXZtToJi6xzcdO8j8
 8u6TyG/UQojkSQCvROZHGnqtjKaFJuuJ+V4W9gQsA67NVi65VfiVctjI2fT2WVPOvS9sEcfhy9S
 vyBUOd8SZdrKV7lC8iASrJlEYYlnQ1cSeYXlRJxhKLr17m/1luUJbduGigE8KmPtRSZALz8BThJ
 1xKia/TmMFEW+HSqh9AN5hQiTba6OtWXL2MnVewi0v/VocTHmpbf8oajK/U=
X-Google-Smtp-Source: AGHT+IF1zrXPMB25QQx027LokmCixU+2LiUKAQRo4aSgUiBmvMlxPMc6NS8lGD6xXfZt+xPqJ3I1HA==
X-Received: by 2002:a5d:6da3:0:b0:38b:e919:4053 with SMTP id
 ffacd0b85a97d-38dc934062cmr9446684f8f.44.1739197718490; 
 Mon, 10 Feb 2025 06:28:38 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1dfaesm12618097f8f.90.2025.02.10.06.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:28:37 -0800 (PST)
Message-ID: <595c6e74-d74a-4a92-a44f-1f4270fab2d5@linaro.org>
Date: Mon, 10 Feb 2025 15:28:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] vfio/pci: Replace "iommu_device" by "vIOMMU"
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-3-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130134346.1754143-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/1/25 14:43, Cédric Le Goater wrote:
> This is to be consistent with other reported errors related to vIOMMU
> devices.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


