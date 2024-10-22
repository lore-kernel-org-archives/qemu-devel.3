Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C984D0E6FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36qL-0001jy-Gd; Tue, 22 Oct 2024 00:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36qB-0001jb-SO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:49:56 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36qA-0008CY-8d
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:49:55 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea6a4f287bso3298796a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729572592; x=1730177392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h13gnWU1+xNVssAjcbpmvAMWAo0JGnfR+xFZ4VhYqdI=;
 b=Qo+kmqX85hp9QztezDESzQZR6ixkMSInzQ1Y2gJnrpho1WLqhdks2gGcqiphQnaI1T
 fVAq088qBMuKVKT2GIwUH7+Ter/so8BU8EZJjrHbvFs5wQ9nV2phTlf4MAF9OUUB8cre
 ZtLQUfLRKJdG8qgkEaXvn66wzhw0xYuQVD/5TM/Qt3KOlwJqHkRDJX/zdS6r95QSJ0RH
 oPGB1aeRF5plcTnoEvhDt59jV2pkmFt1NjeGNnsgTlDIVMRRp7/bsN5X0ZH8aQOGvxbG
 W8Rf4ODh5JpFAEUQf+tQlJxbgD9DVMZliFSpKSSa19NskbhMv3TgaWhW0ITkaPybWIO9
 cLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729572592; x=1730177392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h13gnWU1+xNVssAjcbpmvAMWAo0JGnfR+xFZ4VhYqdI=;
 b=rn4ML93wp7/U3MpTGBblS7dWfqwriL9WM0LGW9jgA9/9ReJv6rMUS6br1OubJB9Ubj
 yr5ENBv3mD3fx6MeeaRKnFu/DxYsweVBoJsJIuFFByQ1hHi3SxMsId012tnvaQRFPOvx
 JW1Cc0JINFZ+/GxWobZ4H2SEEd+C3muNCbVDUMN79Tgc6jI/TriUgXV+ZA9/lpYcDDfv
 TTX9Zz7i3zLKL49gRJSaxcyELMeJBEeb1eem3ztk3i7Tg9jpusIvQPgWDFSCXJHkpQJ7
 uaptfg01GVRnP29Veg1tQ5+hZcd18X1WIgvh0OktrEN8eARPrHJNPTQXu7s3Gdor3zpV
 9fyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlj38Ywy9v44ZuX1RRemmwjMK3kUw+9DA+RRh3J2Nhlavo5zG4Cw9Fz/PNTwS0qLCZyJOFQUDuAoXD@nongnu.org
X-Gm-Message-State: AOJu0YwI6NYjlybfwemEP58isLqQ4OAawB78AwTJLqLiT63XkOpqS5YP
 Jh88nzqlYu/C18YVYAr+CHP7/KviWr56nB7yivP2tSEO0k9iSyPNIzLelpLJi7U=
X-Google-Smtp-Source: AGHT+IHQRkhutlPEjoz99WB1W2mBHZPA6SQ66XqulNdyEBU0dSt/Er8KgFKbPOZla8W0Lzxtsqxwjw==
X-Received: by 2002:a05:6a20:ac43:b0:1d9:9c6:5e7f with SMTP id
 adf61e73a8af0-1d92c49fa1fmr18880294637.4.1729572591756; 
 Mon, 21 Oct 2024 21:49:51 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d774fsm3796536b3a.106.2024.10.21.21.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:49:51 -0700 (PDT)
Message-ID: <90213550-d745-4e53-b68d-6b4ec5084a87@linaro.org>
Date: Tue, 22 Oct 2024 01:49:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Introduce MIPS64r6 target
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <AM9PR09MB48517A4B3BE0FDC18920247884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB48517A4B3BE0FDC18920247884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x531.google.com
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

Hi Aleksandar,

On 18/10/24 10:18, Aleksandar Rakic wrote:
> This patch series introduces support for the MIPS64r6 target in QEMU,

QEMU supports the MIPS64r6 since 10 years... See commit a773cc79704
("target-mips: define a new generic CPU supporting MIPS64 Release 6
ISA"). This CPU then became the I6400 in commit 8f95ad1c79b. The I6500
was added in commit ca1ffd14ed8.

> bringing the latest architecture features and improvements to the MIPS
> target. In addition to the new target, this series also includes
> several bug fixes that have been in use internally for years within
> the MIPS ecosystem.

What features / improvements are missing in the mainstream repository?
Do you have tests for them?

The I6500 lacks the DSPRAM. Last contribution was incomplete, see:
https://lore.kernel.org/qemu-devel/07b3eb94-30a5-910b-760a-0058e52d23b3@redhat.com/

> These patches are cherry-picked from the branch mips_rel/4_1_0/master on
> the MIPS' repository: https://github.com/MIPS/gnutools-qemu/
> Further details on individual changes are included in the respective
> patches. An instance of a pipeline of QEMU CI jobs run with input
> variable QEMU_CI=1 for this patch series is available here:
> https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1470628690
> and for the master branch is available here:
> https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1462140373

Something is wrong with your series, as each patch is sent
separately. Could you fix that please, since it makes it hard to
apply your patches.

Thanks,

Phil.

