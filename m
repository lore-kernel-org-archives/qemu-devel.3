Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5719EC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfkIu-0007h6-Kc; Thu, 29 Feb 2024 12:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfkIn-0007ev-Tu
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:34:38 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfkIm-0008S0-BD
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:34:37 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56533e30887so2061182a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709228073; x=1709832873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j0CB503yDDS2velD4O5sOKF4X6KZTo+26vLiODEO/8g=;
 b=ljmTJRYqjy5Yq6OXdCRGD6hCARr6KD8IKro3u7Noo12UT9AW566L69G+f6CIzrN9pY
 V97izyUynhHIt2PlMjKDUQb+4ivB27LQxW14aeNPt8r4x9KDbRH94QYsrjUsN20KT6Ig
 fXpP86XNi+YfBdzo683O/Qt2QVgu0PBjcp6JWXGsiJaKn46zMuztgKOnuodB8R811Ka4
 Q28Qxg2Wlwk4D106O4rdguB5I14+iaB7GoJC8O5DXfIlKqeuta9MKJCxSPRiWG1YGag8
 75s3Y5fRhmMsDQWu7XgG1dxBLx5JQGi30MAVj9o3Uz+9pTCb3basQA2pcAycTrusR8ts
 wwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709228073; x=1709832873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j0CB503yDDS2velD4O5sOKF4X6KZTo+26vLiODEO/8g=;
 b=JNpqoF/bGKKflZsU36GEXzQaLIm0lxN9qeNM7ETUmDO2qLXLnVT2/kwH7/YGveNUIE
 XaHfwm28a1TJQ1BycXybSSxJh5mOIig1I9CMtXKxy4Ej+cLJf42L2xQ8ONPts9Wka2dU
 rZBgiU2+RejNMzbRjiL2Jnx05pKQ+Qxw82W/A7GhOMGhbFHI5DQz20/0EA3DJlueDbMx
 TiB6IVe5bP13mx7Pu83JlW8X7jsAGL6saaANDEXtiAGahacqfthvL4o7KuKqmTjpaUqJ
 PKjjDrMod5KN3SNCd7FF8R/j/O1qF7bjTP+GOo9FxlduWnLKsj5temYKUE4jTCXXr9pO
 Yzuw==
X-Gm-Message-State: AOJu0YxmAUSUNO1ziL9vWoUKJkHASoydzD+aiOoBTu9CoFcIiKrAzWRP
 rPwtaEkazXee0t71s7zpjMErStXXE5owMhzqFwOyWush5R5Vj0NwxS3vahHDV5S//YRvLrYqkSE
 fHo1w45BaGffQJt2hsi2zrpelHQ6jj4JyunrEkmh63dsNdsbF
X-Google-Smtp-Source: AGHT+IHt9bcxHOjB18bJoTMVwd+sxysrH5YFyjUDvOflWsPdchpv6eeaEswTZAlH1fySbHFXMMkXxjmh34XHhHkyxzs=
X-Received: by 2002:a05:6402:ca8:b0:566:c156:aab8 with SMTP id
 cn8-20020a0564020ca800b00566c156aab8mr298061edb.30.1709228073450; Thu, 29 Feb
 2024 09:34:33 -0800 (PST)
MIME-Version: 1.0
References: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 17:34:22 +0000
Message-ID: <CAFEAcA8S-uONJyR5nKh=HGQwKNUtT4VB+VYBh_dp3_3bjZfmfg@mail.gmail.com>
Subject: Re: What is the correct way to add linker dependency to QEMU build
 system?
To: Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 29 Feb 2024 at 16:10, Paz Offer <poffer@nvidia.com> wrote:
> I want to add library 'libdl' to be linked with QEMU build for a particular target (e.g. - qemu-system-arm).
> Using meson I would typically do 'compiler.find_library(...)', and later add the returned dependency to the binary dependencies list.
> However, in QEMU I understand that these configurations are done in the './configure' file?
>
> What would be the correct way to do this?

If you can do the job using the glib g_module_open()/
g_module_symbol() functions (which is how QEMU itself does
loading of plugin and module DLLs, and which on Unix hosts
are pretty much wrappers around dlopen/dlsym) then you
don't need to link against libdl at all.

If this is for something you're planning to upstream
then it might be worth talking at a higher level about
what you're aiming to do. (If it's for something downstream
that you don't plan to ever upstream then you can do
whatever's easiest for you, of course.)

-- PMM

