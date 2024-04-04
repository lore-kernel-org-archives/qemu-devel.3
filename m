Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FAECD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNqs-0003GX-SV; Thu, 04 Apr 2024 10:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNqh-0003EI-Tb
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:13:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNqe-0007jU-54
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:13:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso1257043a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240025; x=1712844825; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lh6SM8nqZCY9MV4kGQNtUNP4KSdgoAYMzY3mL7jQHR0=;
 b=FK4U5ODKJK7CBotS2nbhL9FY72Cpo4Yb5E5kT2GchYl1scZitPIC/qIOGMJvUHt9na
 yDfR7ACN9PiZCTLi/sVKDSgVTNzpS1eW6V1DTTeDM7cwZjCsxRPBJx4aZclT8AVtB2/r
 fIcCsUnV8WIyIZncS6VUOZBWpMzZhL5tU+PlYF7AYtw409c5nWx/eR6g1fFcENIIbe1Y
 SxiAbhnKQhhDoQuhCmyboYkiYtPJy4rqGT4IxQ64yc5F6T5vYgndYrvHNnAcj7T6sDVA
 pfuqCtKGVmD2kf2KBU9e+uR7xEQo/4ebGi4IssrjdT5B2offlXQQ6Yc0NaPK+P3CW1bX
 1RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240025; x=1712844825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lh6SM8nqZCY9MV4kGQNtUNP4KSdgoAYMzY3mL7jQHR0=;
 b=asN8Ozw1wiZrrrwVsQs5rTUzvLDDqhLBDH9XfF4QS2IpjMYLwKVNb6buoXynTMUhb3
 FgGDchKrXCAwM23Fsg974Um47bISLvJqqamAnlhzNsFw6B864MZ9Bzml7kMWjuKIFDAg
 GFiaBS8Bf2B4GppTXmtlTzholTYFIeRhzepgYGk+vZKaIWoZPiNJ/GiFfFJYwcEqwqHV
 ZOvCQITuu6uNCs0tErpIBW8xoM4SJRVcU74hBuhWUYXb33E+I4/rT08KioTAR++OIUS+
 SQOiC9EmUsjUsZsdxeWq7W934mMHAzTxFLTflPmJDhI2Xl7W7McAMznyIUMc9qq9GwMk
 B1iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU80aP3ZZ3Zyl/oVqVhOfw00xGktKDjnqhStmFFzQ6QSUPjFHB7b6OVcvEx1Zrb4oONcOGRDztBhfnihlUYeh6auttVXVw=
X-Gm-Message-State: AOJu0YyRheuVMUmBcB3IReZ1p4GKBkGJK8dkndPxYQ1Y12VOB4UZJbhs
 g7m57KsbEkwWyHjLdnfReQQXcak92gpE1yJbHcye2fUEFE19qbSo72gkGben93lo1d6ghFBNhIT
 1Ym7f8UhfSBPKUvSQJsJxJjA+iPX5kmnBHGpncg==
X-Google-Smtp-Source: AGHT+IF0L8dXXBT9/9/qlnEesXIkhY7F8Th+hM4PLff5EYD/HKkzz5wWt+4oY9dYEyBMxynBpZPs0JCPhJuSL2vxP5M=
X-Received: by 2002:a50:cddd:0:b0:56b:8153:54f7 with SMTP id
 h29-20020a50cddd000000b0056b815354f7mr1990213edj.30.1712240024751; Thu, 04
 Apr 2024 07:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-2-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-2-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:13:33 +0100
Message-ID: <CAFEAcA9qhpvGmNKYGO6j2+j20mZo2P1ug86SFiN051m0dt9bDQ@mail.gmail.com>
Subject: Re: [PATCH v12 01/23] target/arm: Handle HCR_EL2 accesses for bits
 introduced with FEAT_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 3 Apr 2024 at 11:17, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> FEAT_NMI defines another three new bits in HCRX_EL2: TALLINT, HCRX_VINMI and
> HCRX_VFNMI. When the feature is enabled, allow these bits to be written in
> HCRX_EL2.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

