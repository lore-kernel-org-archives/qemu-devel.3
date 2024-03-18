Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C227C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmG1R-0002sy-DM; Mon, 18 Mar 2024 12:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmG1P-0002sc-GR
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:39:35 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmG1N-0000fn-VN
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:39:35 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512b3b04995so4071373e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710779972; x=1711384772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tkn/P8t2wux/lILxCK2aMfW9TFC0LskozAMAU7faOtw=;
 b=nEWGsbNM7N4jLXF41BUhcYTbXq5Xz/dYAxgcPPVPx5itmMDhhpZuZac/enZX64KvS9
 W72/vhIIeaDB8gNWMxvhqe9SGVqsSHQCKQZFjPGXU7LyvSpsKiiVV62lapvN4aVwJpmY
 QkAnRbHdv4las8K9V4rt9lICzLf3X7iumrldpCiogIVAasBfy6aCJpwdDZzli8svtPEQ
 z4U71wqbsCuAlU0xxPQlcI5p36h3yKrtTKMRfKrmzyVyhg73IGDcBIxInuoXTgkMIDyJ
 B72O8eC2qTmhD+OKcjuy8qknVDSnfp+4cf+aVPGhiQU5seFdtPOfSnAGUiXo4UN8b8Sz
 Nfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779972; x=1711384772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tkn/P8t2wux/lILxCK2aMfW9TFC0LskozAMAU7faOtw=;
 b=rY/5vR2/+GQ1t2Vhkevefd+QZwqk9iKS05xw48SGUzq7KfzMP62fWMJPExFVmDhcjE
 22ZbQjO4tEE68WShA/LWu/EAFtmFwhJ426FINg+WztJ6OmOevBEzw+WgS64RlJ8MStxx
 ql7Rr5GTOB0keNlQPULa4ocYr5RvB1+2a5xRIyq3UyRyGISxa3MdU4zG1xpwjCLL7Hat
 Ic3I6lmJRNK9iYjatsPdKWbAQgnj+j0uAvkzzBaDfAu81dcjpNTTIx9f2p9tHPTY9RB7
 PSH5A97YpnkLd1760P/97mZ3LdS1ho1XTAp+4M8WelXuvzQN+iCgHbQlvOcQcVemofOx
 qZzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl1K6gIgDl78Ps4VYR6YPnCbeTTHDFeBvEU9SGo6YF6RoucdAm6/hjMymdkGQFNv+CMaxuIsgLYxdbBhjasQvVlSo8z/o=
X-Gm-Message-State: AOJu0Yyc0/Q7jCdnwB99Ht8U0yBW5jk1Q+ao95VomWz+yNy1XKqDlkQq
 Od6AMvuCWoKjICzjrtvkTA4t9T0d1VRG+acd5cvGz/7Pfa0t/EG1r4rR9ElxQAo=
X-Google-Smtp-Source: AGHT+IEAg9Ahbfz2g280XNd0HWIbQW98nOxqt2UsKN6W/ut+YAc11SVvEWZTOdkYVNK4fsCxeox4Lg==
X-Received: by 2002:ac2:5f92:0:b0:513:cf4e:941b with SMTP id
 r18-20020ac25f92000000b00513cf4e941bmr7984636lfe.19.1710779971873; 
 Mon, 18 Mar 2024 09:39:31 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c501400b00414112a6159sm3275484wmr.44.2024.03.18.09.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:39:31 -0700 (PDT)
Message-ID: <50ceb87a-c2cb-4782-8da9-f716c7f1bb62@linaro.org>
Date: Mon, 18 Mar 2024 17:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/pnv: I2C controller is not user creatable
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <20240318155844.224193-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240318155844.224193-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 18/3/24 16:58, Cédric Le Goater wrote:
> The I2C controller is a subunit of the processor. Make it so and avoid
> QEMU crashes.
> 
>    $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
>    qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize: Assertion `i2c->chip' failed.
>    Aborted (core dumped)
> 
> Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ppc/pnv_i2c.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


