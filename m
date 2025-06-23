Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8AFC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiap-0003o5-Cn; Mon, 23 Jun 2025 10:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTian-0003nr-1t
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:56:17 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTial-00074f-D0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:56:16 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-710bbd7a9e2so39511287b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750690574; x=1751295374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=unRATwUijFCVixAbI9xUnnuP2XYDSs3BDxn+OMqjuLk=;
 b=Zua7qm+JBh9xiELHpzbSrlc4f+RIF2j1uORftFuBjyzPN2dXX0eU1DahsGpFbEQYrC
 yOmTWDcYFjSs9sKYZ2cejaqDFRoh5Cw4NUrUSDbunBU9OIAZqyse0JTqXQA657xhst75
 tyLmBO4tR3pZsqnw/4ycudZnWCaQ+lwlrmPtmDjPmhIZszxL68johTkjEqWT+XMfkBEx
 bPEDye+/2ILgpwp9OpDnZhu4gG07ixjnvTdzwQOEuVvkBTw0T600WSYZ15zxH6l3Oc7t
 fJ7Hx9MONoPDfFRVVyy30blvmUqhi4suwrWPMueNPfZvKBeStCUk3wpYsXFoiTytn1af
 4wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750690574; x=1751295374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=unRATwUijFCVixAbI9xUnnuP2XYDSs3BDxn+OMqjuLk=;
 b=gvP7KLwVVZnll8XvVVwTJ9CSzjfj6U2kK8RWp+S+onhr4qGZoJtn4WZlwed3F4dJHS
 oQzNm9uuSWEVRQyyWtAGBa5uckZRvFX3Jxis+gZcI47yaVuBT9Ua6u7mKa+C5gdHFqdg
 oJSxkOjX5CAVfcwrlflz6tAO+H0mz7c6r6Rl2mXFSekMwztleGFhOj3d3ugIapBDL1PD
 lC5zxEqOE1PEHWKHhuNcMCJvOrpX22jPfOgxauYxxtaU+SyISXXcywi9tf7Rvp1aeKPw
 Lufvgd2gi/3+Pf7VT6a/V75PVc75FtM2mP7+qGmRJfRRaPDmCKNK6UgI/4ESBWmgkKEc
 Sk2Q==
X-Gm-Message-State: AOJu0YztulApujaZFge87LvGTFv2SM9W553vtAZ1JxmHIoNtY4Dd5I6y
 dQTfMW1wureHGFDKEviKD508pXUbOyw/vm9qw3RpZV3Cl1HUvde2oltj5YYNBX7TRsdBcBbA15z
 8+bnNcQN9C5RLGMqzE3vx3KcEQa25y8tzd2On/k6i0gaGl2xVBYhL
X-Gm-Gg: ASbGncuEr0RqvxegC6KH5p0zL6EfMfIu/F0JFciZ/zRylLeuh/5FghdfHkG1T9EcJAr
 1uMgGoppjDdm/252TRSyTzAZAnquyFdIxuGi8Gip+809cHDjEB9ao+HBdcyJrIFk9um5KrxMWeT
 3zJO9Ydqi4PjDrT+Bj3za8Aj/k5sMvm+NJj6r+Bn7lDBaF/zR6hfCT0+k=
X-Google-Smtp-Source: AGHT+IFM+O1nb+8LZ8hr+ZtZGrmVgh51NfndPuMDr9UPDFIGcFOKN6t5bwxpbdywOWD92c9FeN9VX626IYkEYrrSlNI=
X-Received: by 2002:a05:690c:4b90:b0:712:c55c:4e48 with SMTP id
 00721157ae682-712c631235cmr183761477b3.8.1750690574111; Mon, 23 Jun 2025
 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-29-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 15:56:02 +0100
X-Gm-Features: AX0GCFvtua89KvTci_c8zw0uMISJZE1MIskBY_AUOK3sZ5YoOAQDZsiQWUqg4YU
Message-ID: <CAFEAcA_hVBER10s_LVNj0zWYMp_8+sjTLbNPU4X=DQpQi-mDug@mail.gmail.com>
Subject: Re: [PATCH v2 028/101] target/arm: Introduce gen_gvec_sve2_sqdmulh
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> To be used by both SVE2 and SME2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

