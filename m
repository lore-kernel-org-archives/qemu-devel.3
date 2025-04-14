Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32964C369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4FzR-0006SL-AW; Mon, 14 Apr 2025 05:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4FzP-0006S0-UR
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:20:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4FzO-0002F2-5K
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:20:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso19670535e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744622424; x=1745227224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPBoLbQiEuV69BGjan87X1eHdViIL+Cx7yVomL/uzwY=;
 b=ARzdKApv9KG6o66DcZW0zXVWzNCF21OCc+pKnVsvQX1/txQB+QDBFYXGoquyg0gTrX
 +qF57hbN7GiK5gEQtvcefADz5KmGrUO5SgTcaER9Y2xMbbmgWzkI7gwp0v1Jspef564G
 42MhP9AQ2cMRlsehcKCLbiw+0PZwkwR6fgAUZrFwIG1qPznSnlMsOGaOo9gFfuO6vHTN
 5j10j4Ctzr8z31xrUnvsJsHFs5EiqR1lzJciPyT1DykYPE5JxY47mIuIJatUhJ84mtv6
 SldyHjJWYY3J2IwBqMOAnQhhkRyEudRRWrVc2giZTXJOScsfK2c1i/oZjIcf96XrmRqo
 qtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744622424; x=1745227224;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EPBoLbQiEuV69BGjan87X1eHdViIL+Cx7yVomL/uzwY=;
 b=bLks0AqwftcYv+IaZqFO/ymjS6c3EIswjDqrdIcQXIJLdwh79Wk2arll8zYbS1quNr
 +y7lbBc6cg4XcO6ppcvm0HUp1f5L5K55pEOe3bxB6Jh5JEy/TE5IZ6YzzYCJCyLZYupt
 nF9EFVA7LplEUz70W7N0dx+xGFDoi+GQiA5IIrBOLN0VybLplnQtuHnacAshrUU/PXf2
 dYaBqhNb+OOOxpllKEV+22lnhdSb/aTKdU5u9sMpc/jtdkq1MpHIX7WXmYXnexBZDrYv
 IVpwH+YaQ1Y8RsFqLMMjVDEK2baD7qGaZJEbFhJXh1k1HfGp0kjmdmgVXvA6bRyNKvx6
 RjFA==
X-Gm-Message-State: AOJu0Yzf735owXERPpFDm5Anx5GYTHqUZOt2B7n+ViZboHIbSy/sKAYY
 5mNUJBiuPD8B4w5vAMrVjTGKDWcXlHlAMyQl79yxwz52ZJeycu8M7+6Hgw9iFDM=
X-Gm-Gg: ASbGncuRCIJ+5nz75sat7yiYcpQ0lW+M2O8FfE75YyQzDgzZ/pOExw9HqdBwBTz1pzX
 oWQDgTU84fo9dwZNB42qq5WIIstKyQCryvUfamLkirHA6YdHdJ34qg2w9877MbXGVmZRrPDJHko
 yoyV8F6Ws72LkGZ/iCrB2lXo1PAZLTWcqE1fgpLdiOpXM/RLLW0ag0/ouxn/WEo/2cdMzW7iiCW
 /9w8RwTh/adCptFKJRmyXTmw3mZsK5tI3Wryj/A+RsbImN72QsRBlgUsK3TMWhvT6VhoxFVCpQ/
 D8E8Ux9UaQfh6vPb6NIl/MWVOQbs3UBDZRToSVwH1q5qF89FTwWbrw==
X-Google-Smtp-Source: AGHT+IHwCVTYmhqdX622GTW3nD5IgPCzZ9DZfnEc+ud1mEELkmheLEYLlm9VDM5GWykuHRW1FzFqAQ==
X-Received: by 2002:a05:600c:19d4:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-43f3a93dec2mr90532675e9.13.1744622424361; 
 Mon, 14 Apr 2025 02:20:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2a13sm168915825e9.10.2025.04.14.02.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 02:20:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D79135F8A5;
 Mon, 14 Apr 2025 10:20:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Phil Dennis-Jordan
 <phil@philjordan.eu>,  Cameron Esfahani <dirty@apple.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,  Mads Ynddal <m.ynddal@samsung.com>,
 Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH 1/2] hvf: avoid repeatedly setting trap debug for each cpu
In-Reply-To: <20250402135229.28143-2-mads@ynddal.dk> (Mads Ynddal's message of
 "Wed, 2 Apr 2025 15:52:28 +0200")
References: <20250402135229.28143-1-mads@ynddal.dk>
 <20250402135229.28143-2-mads@ynddal.dk>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 14 Apr 2025 10:20:22 +0100
Message-ID: <87wmbndrqh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mads Ynddal <mads@ynddal.dk> writes:

> From: Mads Ynddal <m.ynddal@samsung.com>
>
> hvf_arch_set_traps is already called from a context of a specific
> CPUState, so we don't need to do a nested CPU_FOREACH.
>
> It also results in an error from hv_vcpu_set_sys_reg, as it may only be
> called from the thread owning the vCPU.
>
> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>

Looks reasonable to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

