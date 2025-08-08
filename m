Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B795C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQAZ-0003UZ-JD; Fri, 08 Aug 2025 12:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukQAW-0003K3-QI
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:42:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukQAU-0005kO-DL
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:42:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so15843995e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754671329; x=1755276129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBp4Z9X4Zu54uV8c//qzLmRKIosrDeLLfiJ8vnQLuKI=;
 b=aiGUBpFY2D3phnA/FvDSsBAC48j6sA/FsbGwshlhgAQtJE9xf62adrp+xzARbyvAZx
 CEyy4SUryvsEY4N2TvnRXf0NQbWA8W0JdgWY6kRkrBEmxDJDY9xsvJATvgxZvJ8NGAQ7
 cqO1M43BWCUD/WuYjLqg2EmMfFQYyrQfks4A+8k6V+3H5qzqOgHGBFc5LUHLtAA7wsLd
 o292+T4W6U1lUTEiChCKQRt3cLafrycljpE3z/yq8Zio6mS1QMb1N5LYkJJZ4Lnb7bet
 a0A4MfKFylKRtpomHLPo1YUVmWQO3pqeo0feamoTjZYobivLB3ouuuQwh/AfDKy+xYeb
 L2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754671329; x=1755276129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBp4Z9X4Zu54uV8c//qzLmRKIosrDeLLfiJ8vnQLuKI=;
 b=seCKIt/p5b34ewmbIO8M6Su3w+VAvQgkhrtp6u0ONQeCFEIMzGgKhLm8mjcc9aiMyt
 hXLaWeaxpR+b8Mhax3knBNmpZfIMThXtoyovqy7dj3SZHmHd7se74nmpKhpcfm7ewhMv
 UEBTROIuFkUQuKJrAMbjsNUfb/QxdLNwmvSWe4oNd4lU4TkbG1hicM2N6mxXlYDXQtAb
 bqGZrtLE8l+ycwJHKQkWzZLXIY/AGb1dRw0ie3C1AHalfSnEMmwC+4HqxWrMYyCKLhQt
 68umKcx7imuU3nVdNj3rSldz+D9G4Ntb4Kh3/s99GIcjJfO1tF481JeFRWpXSaq1P+3F
 r7Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDrnxWg/3KU5RJbZv9p8uECfHUQ/yQzeABvBAoZVKho1CQ6UXRZ+aNugJyP9PwyPCy17sNm2YNankS@nongnu.org
X-Gm-Message-State: AOJu0YydrgSW8Gj70ebWyfyj/+MdJ9/MvAF3BWKJi314JdBoXR0rL2sI
 pUVJF/+9nBWu9Ryd5fg5BzLSsUUZ6JF/HKtDQhYo3j7vPRQQ7S/pSbIvF8glsTrhv68=
X-Gm-Gg: ASbGncuPK2mH+AkgfIhhIyHD+Ac9MzdNb2gjII6meGWtwE4U6Mx7OaFG97FpkadDmUt
 7NSlmRgg5WKSmd+qvyAHYGrOCYuOMus/HC8zhjxUNqjIoHgKaeFAVCYYSAk3IywZN57D0AVVC0S
 dXSWJBmYvZoQIjx2tdeWsE3cBEVYMXNdlgq8s9zCS1DH5eVjprnQwukMIb+nQ2hmmjOZ0m2r5lw
 Zi4PhjHdHO7Qx121IfY9/CT8et8d2fxfiMfS3I7LsJPi36E3r7Fo0AsjzODf6VlD0hBSUdj1fHh
 QH7NK24V5efn0ycx5v9vPgn5PhQY3VHRZhGCIGS/mR5Qp/VR+/RUZooMSWFSYlhXw2esC3z7Oin
 xLzcTB2G7l3XZAbdwFpHLWeSJwCe6EwPRab/YBBCxezUYa+R0kZ5ST0ov6W0+jh31Jw==
X-Google-Smtp-Source: AGHT+IGWtt0f+VO70j/Bym7iPy81gUPIWkIY3lZ73aWreZ31rYIuVtBUffC4iujne4u7GpX3XfJuog==
X-Received: by 2002:a05:600c:190d:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-459f4f9d9ddmr33422005e9.16.1754671328635; 
 Fri, 08 Aug 2025 09:42:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e009e465sm22125953f8f.43.2025.08.08.09.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:42:08 -0700 (PDT)
Message-ID: <6daaff50-c951-450e-bd94-9f0e4365ebe4@linaro.org>
Date: Fri, 8 Aug 2025 18:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi,

On 17/7/25 11:38, Djordje Todorovic wrote:
> I addressed several comments in this version, major ones:
>    - split CPC / CMGCR into separated changes
>    - split CPS into a separated change
>    - added functional tests for boston-aia board
> 
> Djordje Todorovic (14):

>    hw/misc: Add RISC-V CMGCR device implementation
>    hw/misc: Add RISC-V CPC device implementation
>    hw/riscv: Add support for RISCV CPS
I'm not keen on having theses models duplicated with the
MIPS ones. Are the IPs really different? They are just
dealing with bit masks to stop/start VPs AFAICT.

Could we model them with plain CPUState objects instead?

