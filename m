Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49DCCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1j3R-0007C6-RI; Thu, 25 Sep 2025 06:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1j3B-0007BS-0w
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:18:10 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1j2v-0000ZW-6V
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:18:07 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6353e91a04aso370974d50.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758795469; x=1759400269; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CaCP64UrwKP4Wgxn6ein3eHOxagjsn0jyFVx6H8/3gk=;
 b=fM3YVyzISysNFLDdLu19oZf2HPc7Q3bVUIuSS2fNcdpi/fAniRvtRPevVnMG7NP5l5
 xsJBFHHD0KsmBcCU+SxmlW+icGuckEHVRNQiMygO2gY0+DbOQlqvOV82DaeHp23E4ZTI
 R2LReB1vkTt9znXeuPBAH5XhbVUfRS8Q6Xt6OsWpY4I3WLxZv/Nv5x4Rw+RaWTRaRv8a
 aNOz38GLJg6RRihvaEFBd8hnmOJ+D8Njh7awv466cCHImiKYLYqhm0pNJKD36DoDDXof
 nhz4umCNmtpiW6v3RxLWkJ79vv6/Vkh34iLphY2/zdV3VIG5DtTvuuO3N04QEG8dN5iA
 vlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758795469; x=1759400269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CaCP64UrwKP4Wgxn6ein3eHOxagjsn0jyFVx6H8/3gk=;
 b=D9WPVwvOUbdqdMu8ncg1uyxkdCZSp+udxRSGgT3FWKPM3AXoV8GypYV0myu4C6ReqW
 Fi5kznEjFWwYAJyFgdeGwLyI9mskMURJFZDhDDOpCV+ogYRwbvltn8vGSeMxioiu+viD
 9v6nkW/Uv/nluuWk0QOswjg9Z3/D6yn7nHo9LbKtSq607y4xxt4fZnK0DfzrQBgKhOVN
 m+af0bmpOkN+Jge8XYrpBVhVHfjC3nYMwP0VDiksvs/ZJY79AloV4RS/bZ8uTXIfq1yB
 TyBTjrWKm4NTmXRq8KA5Ojn7i2amwiMX/UiqtL1BHYlblxaQS8V30TxgQ6Fj5npe1CSZ
 w2Pw==
X-Gm-Message-State: AOJu0YyWJWIBRgq69REAOyOjgux9XK/zZPk9WbbuUdsiT0TUzJ7g7LE/
 L5C50h21kuWkoY2PVl/sAn11iP/ojansxcq2dYSboR2+M05HHnhxAWjJjgfmZq6UKR36yZqCUjw
 olU/Y/2a49Ai6JR0a7eJO9D4YbPt/WtndPv/ZEvgxuDTAcAWPOXDj
X-Gm-Gg: ASbGncsySL5DuA5kEvqpD870tVxcCMdwg9360cwExA0Vn9TNDJthW16hF6rTj0sy9iy
 jBXIWSTt85CKjn2I23JL0vxW3fCSSc1QZ+Wjn2UeDhzrxHuNvRS1Xm2e1/5LeZiBjIDdrLp0vy8
 Uz80gOWcIcBvHs9GUEmpBggBSXAeBGL4LsO8yzcDSEq7l5CKbWuucd/KZP5vGiAQ/kzMOuw+1V5
 vwCvY2hVvCbcZYUJ5A=
X-Google-Smtp-Source: AGHT+IGR41dPF1V0goOufSPGPWbN5X9fZqO/iCzls13ivL4E9ybbKwLbK5/8SOlqfic0NzcQyGq8ysMyQrdtwMGonMs=
X-Received: by 2002:a05:690e:251b:10b0:636:cc3:af48 with SMTP id
 956f58d0204a3-6361a716926mr1832676d50.8.1758795469249; Thu, 25 Sep 2025
 03:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250903155410.1910145-1-nabihestefan@google.com>
In-Reply-To: <20250903155410.1910145-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 11:17:37 +0100
X-Gm-Features: AS18NWAJBq-gYZJ0HoXsE3nstejBfzePtm6cH8tKhdG1WN8D_Lqh3UsGHaQBKOw
Message-ID: <CAFEAcA_OiO9UynBQ4SO_KMRv2Z6S8VMC0NJotpePvmmavoGkEw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/sensor: added MAX16600 device model
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org, 
 farosas@suse.de, lvivier@redhat.com, qemu-arm@nongnu.org, 
 Shengtan Mao <stmao@google.com>, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 3 Sept 2025 at 16:54, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Shengtan Mao <stmao@google.com>
>
> Signed-off-by: Shengtan Mao <stmao@google.com>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  hw/arm/Kconfig               |   1 +
>  hw/sensor/Kconfig            |   4 +
>  hw/sensor/max16600.c         | 197 ++++++++++++++++++++++++++++
>  hw/sensor/meson.build        |   1 +
>  include/hw/sensor/max16600.h |  46 +++++++
>  tests/qtest/max16600-test.c  | 241 +++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build      |   1 +

No documentation, and no board code user of it? The
empty commit message gives no hint of the motivation
behind implementing this device either.

thanks
-- PMM

