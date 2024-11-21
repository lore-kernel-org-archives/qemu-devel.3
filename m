Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40A7E6400D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDfR-0007bC-FT; Thu, 21 Nov 2024 15:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDfM-0007Z7-Lu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:20:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDfL-00057L-35
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:20:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso11579105e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220437; x=1732825237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N8Tir4z5GndmiWvo4SN85AGdzkamMd7wjNfqZGZtibA=;
 b=t9HTQs7omoMBf+qmZ29Zpe5Z0Ds8XCWiueocQrZHbBf8jFQYkEgd0KaV+TuvIcUF6/
 6Wa1Uct42s91YNCFT0sCHOOI+/c7n94k/mD9QD7wlo+A8J3zYtH+3gvmQhsbvTHq0Cec
 0ZBwB6QWrbjFo2+TtzpK5/p5wj9lhk4CmmG/x6LohVlJ1Dq3kZITmlRN2ifwLXzzt6Z2
 GeFJpKjyBLIvzfuZwO6KwH/+JrmhVcblw6hOcv0+UCD1jMQFo1/tOLm5nULr4Fq0Bfcy
 F3O9o5gsSSvtl6umfKb6cgHp5iXoPg00ZjcZj0iVnZdM+WrfTdetV3LzOPJudq0WsABa
 3BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220437; x=1732825237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N8Tir4z5GndmiWvo4SN85AGdzkamMd7wjNfqZGZtibA=;
 b=kJzNeYdJGBsIUO9/jm0ZbkTjM8vWMZuZ9L6o61+fac8606u4JYQ/8UNFR8mMfeKLYd
 2PO0MZtL90wzHHq8M/w/pdRxU+CvMXAiuSbLi2NAhzmpuDTw2v5qwzsplobX6XwfvaOA
 caxiffP+hoEUDnQ8njh3u7gao8azrrKB2n5G1/4zLK9Jasnn2wzP1Sj5OYSss978JT3v
 bT7Ct3EX7m02s0Gv7G8yfWO5iYf0b48eV6T2pU68uzaoXvN6eIHqHbzbAQWa6TrgMJZM
 q+mj73m4aCx4hyhYiohcR7ivdYV/a5H+wQ8cD6T8/ZW5Z6PI/rnkCs+G+GHC96uySiRG
 GHrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCWL7G5xmNCc9h88NGEJxlHQckbTyQar09pgSUiF1lMOR+QNnb0n3NDiinCMUGLx8ZDM23rYwxH0IY@nongnu.org
X-Gm-Message-State: AOJu0Yx9Okx+rFZv/RSEpOPWPua7/rwl4qH+Z91KRTLIUt0JAzqRRdNj
 J4XkfpqpVsowX8jg2/FRJmolbdWZpc3ZxgiFAM315Qxfr3L8z7qNRA3DUfQFTCw=
X-Gm-Gg: ASbGncsKkpkxw2Lt/gqOboEcymv3ZBJGSYhTa5bRK0bBIERx8cv3mV3/q+PUMt7JD3l
 Qd+J02ax0PC8cPGF6rCaKP/qH9ulp2RmMnrRj9XFEkzgyhqCSpGJdvnFllugzeJTQ0gRMM4UhDd
 UuvYKPQy1O8wXkqdhTro8qgWrXAMPbJRwmQPteUJcxJGy7JC1q8AHy7cihstOKH48PblIW3VLWe
 SuK3Qg8C6SXJp0XbrzbLclRr3gjDBeb0+ZzGfsxR9d3m8/hg8/zrO+Nv8xqyWmKWrNH
X-Google-Smtp-Source: AGHT+IEVWmLgJf+YWVj8roQsFDdRHG4xGEyPqk0iNSEfDlR7uQ+3e/IcyK/XQnKuYqeAjNFip1j8+A==
X-Received: by 2002:a05:600c:1c9a:b0:431:57e5:b251 with SMTP id
 5b1f17b1804b1-433ce4d4c15mr1004005e9.28.1732220437382; 
 Thu, 21 Nov 2024 12:20:37 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd4d1sm68269555e9.12.2024.11.21.12.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:20:36 -0800 (PST)
Message-ID: <b9244aa0-b250-4b29-9a06-b087a7da2c79@linaro.org>
Date: Thu, 21 Nov 2024 21:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] hw/ppc: Explicitly create the drc container
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-7-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 21/11/24 20:21, Peter Xu wrote:
> QEMU will start to not rely on implicit creations of containers soon.  Make
> PPC drc devices follow by explicitly create the container whenever a drc
> device is realized, dropping container_get() calls.
> 
> No functional change intended.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/ppc/spapr_drc.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


