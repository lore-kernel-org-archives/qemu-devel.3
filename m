Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03342C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 12:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvyeC-0005Bs-Ee; Sun, 14 Apr 2024 08:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvyeB-0005Bf-Fe
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 08:07:47 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvye9-00054M-Q0
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 08:07:47 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516cbf3fe68so2814305e87.0
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713096463; x=1713701263; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6j1GQnQ/SHA3zuCdI50a9YKWq0druT7dD6CmbR5RRm4=;
 b=vjnwyuGrLYFTdos0+L1UvcxDTUDkqAp4GTV6vgtBmUu8ooINq3p+3AAaRScKWb8cYr
 JyqVpFR6vVfICBygcPdRvg4IUUB0k7JoGHkBneyAlktVGQS5orrr+2w8dkzONdT0rKoH
 tnLmg/rtn99awzo3wXDM6mtzwGiZDhX6Ez1HnqZKHfiexoDBPJdsGuDWGq0G367sJfQ5
 7GGXFZuX+XnF2k1welsacB3P4mV6iJB+f/FClgzw3USi/XvF80FW+21sXS1yJ+YdFIww
 XVh+xfsMtnx3VGepfAQZyWWdGnl35aokCYbbPr6ALFfLnm7ErZHOl6+hZXM3x4s8Y06X
 2okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713096463; x=1713701263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6j1GQnQ/SHA3zuCdI50a9YKWq0druT7dD6CmbR5RRm4=;
 b=tj28/jHnP9rgxMk863dU0uGnVPXOw4HjbPAMwVr8bBz086foCIkHIzg3UMf3PYqJI1
 YdzMNlGaeN/qu4cqaiXObPmcAVmidXPxRht6GBHBOW4hlKnw3OrGJyI9fNizVuIWCtB/
 nijdX1mPQL3qEBWKVBMdJI0CrAPbAk674zIMLllSBNjFaHUlPLBFazyAV4iR2p2DU0ML
 5bfF1NARIAKLRxvH+E/7So7q5vwgFt96MUud216Rn8YZ1J7F7RtrALUJ6B9xZTJHe8Bl
 V084ir5tyY5WNn/FLeFTbe4MEUKjAKhTTj3FkqxmaYkkpLVZU/CkSgP1c8vtTJi9la7Y
 KIIQ==
X-Gm-Message-State: AOJu0Yylvw2POyWLzHF5O7+paSt1heEPnsB75YYTGCRgq/QdSbBkTTqV
 UQSag9sdcw4jhYemYYWrXLXrSkfnImJcC75AaZ3n7n/Ulcc6c9NoVUS/yP+0vjSV0r66TkJ65+Y
 gGVKP6ibHfsncZM/uxpnzPScaUdsdFml6pRzfh9Ryn8wjDEFO
X-Google-Smtp-Source: AGHT+IECyN/sJfWR9zg8pKAM12NRLflAXYe/PHJ+6i/VnXSVDczvFBXRivlDifTjshyYMOmzk6yy4TElKu0ao54xPok=
X-Received: by 2002:a05:6512:48d9:b0:513:2c86:3498 with SMTP id
 er25-20020a05651248d900b005132c863498mr4398089lfb.48.1713096463203; Sun, 14
 Apr 2024 05:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240412185431.465942-1-richard.henderson@linaro.org>
In-Reply-To: <20240412185431.465942-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2024 13:07:32 +0100
Message-ID: <CAFEAcA_vySNi9zYKQN5czKJt575=6Zyb+ztMtmS6iOJTgx3NRg@mail.gmail.com>
Subject: Re: [PULL 0/1] target/sparc late fix
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Fri, 12 Apr 2024 at 19:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since this problem has 4 issues open, let's get it for 9.0.
>
>
> r~
>
>
> The following changes since commit be72d6ab361a26878752467a17289066dfd5bc28:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-12 16:01:04 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-sp-20240412
>
> for you to fetch changes up to c84f5198b0b676ad67962b5250af1b0d0842e319:
>
>   target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and ASI_USERTXT (2024-04-12 11:48:26 -0700)
>
> ----------------------------------------------------------------
> target/sparc: Fix ASI_USERTXT for Solaris gdb crashes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

