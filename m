Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E551FCD0C5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ke3-0008H2-La; Wed, 18 Mar 2026 02:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ke0-0008Gq-Ue
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:44:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2kdy-00075E-BG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:44:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-485345e1013so4032415e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773816276; x=1774421076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EUNk3e35dIs4XHDHXgoZ2KXSywSvq5ZEp//KgFCx0ns=;
 b=yUnClUMpSjHp8Vp1SpTTdtUm1lFOWdTL/E+07lCo88LKDBa9KKSgr411QTGac6pWa2
 bbRF0tzwgGtRw3UR4XQQjfNY7+hTf5E1aTzlk3zyYhpzCrmC4nmzPM5Iauqbxzq9rODm
 1qveY29CScCQv+K7hhifwkkD80wRRx2cr+nrni3gicqSeZVhiL+IOkiKq7Pc+qyUkW8M
 9IXyou9/XnZpj+Zs9VDj2NwFQW4J0bWgcwVIqyNRMaSQk9AMj6mwrpyrIIDGE9uH+Hw7
 w4L0VymdawIip9ldyvJntznyfL0JlFArKZ2+NG+ddlQ71zWZdBi31brpZjXEhLxglcDA
 jL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773816276; x=1774421076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUNk3e35dIs4XHDHXgoZ2KXSywSvq5ZEp//KgFCx0ns=;
 b=jDBlbRJDT/uzGG9NPJeoLrHJePtG6+FF9r5yT0mAKwig9E29iaa+nsdbLYb7IuLaFl
 pUkzT81f8OLYZFUi8wM+p2lQvnHC794kFisZp76IAGgrWyWk7Cf//FXuowrjhuYKTOON
 LSKCnceGirh5FpjJxGWTWUZOZ9lijJOazN0UkaMNIBFSgOBtQkvUJb5aIPL1zI7iM4EF
 OoQ9YVJcVxWmhh7oxdiiwWhTLj+SJmC/wN8N8/NluYTpD9z2JpMDaq4FoEI+oXNWD8t3
 DIN2KYf/sRTz8IILpvn2ZwVjlyCg2KSZitDP+Jo2YvMLk5/mGUndpHnZ6YGXtjurArxQ
 5bXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoV4dEG7PqOdTO82nHMrpBeDlSGGYHbnSwCqEwPV0JkFH/N+L39I+UVUogPi2FXMJrzTzI8PPujmKZ@nongnu.org
X-Gm-Message-State: AOJu0Yy4PfGoyWzPNM9Vw1pLhvUvKkrk1LTjJfgFBDhaM5E3NEFGjbZ7
 G+72IwcD2UPtEYPuJHiW7YCSCSx8qAflOfG+henPoCW6lH7JDeBUtoD7koio+VeGqXg=
X-Gm-Gg: ATEYQzwFcSqDu7S9GI4Dh7FTPZlMYwqMdr42tW/nN0AENtnYniWAksL9P6Eab8w923G
 QqiSiY3Qpaidyil5+RWzRIVMeyOzMc+qgG8mGW+05bemQ60+4br+AWo7iKQO1D6JRKA1Eohx8sV
 EbUgf8reQuDhBx9A+yKynfmt8pjwF8iKPbLl+eo1hZQ5pu0U8GYHVE6QLTpGORYWQm/OG0gD5T6
 lxSMGx2TvoE/bdAV0Xw0eLUYiv7S7+H7BEY/JRXQd8UB6dKgMUvKLCQe/Pb1UNPSxGDtjMu0PJM
 xOcPehm/wJnkk5oPxtFfWddCckMwLp+u1n9GDP3x4kM9pGYNASqltQ6MtN2YRrIggOD3CcduaKX
 lnAzoVBm1r8eMOAEH35bFgMbfbl4/adkr284YrNWF7PGm0IDZ2cA/2YJUCzlTq4mXBw+vfAlEjC
 VWBks9ENj/s4tYPEqNTEt6MATkmOwCYoSc5x2x4TnY4yfMWVAGI4YdoXQTGJZ6Dll4AA==
X-Received: by 2002:a05:600c:2250:b0:485:4f11:aabc with SMTP id
 5b1f17b1804b1-4856eaebb24mr78771495e9.15.1773816276433; 
 Tue, 17 Mar 2026 23:44:36 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51899622sm5818065f8f.28.2026.03.17.23.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 23:44:35 -0700 (PDT)
Message-ID: <720ab71f-eb25-40fc-a692-2955496a0841@linaro.org>
Date: Wed, 18 Mar 2026 07:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/3/26 23:57, Pierrick Bouvier wrote:
> Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/iommufd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

