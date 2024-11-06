Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2534D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jp4-0006Lm-Q3; Wed, 06 Nov 2024 12:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jp2-0006LP-QO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:28:00 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jp0-0003Vk-St
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:28:00 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso9373982a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914077; x=1731518877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KUkdAC62SORZw27ZiY6noJmbb1tHsidkViPofEPWYPg=;
 b=c3JgCIAG50wv5nrfGb7MsGBKL20p8EKJvzDliymENd/nJ6WQmmBRF1TC+cXzIQ/ilo
 YGKmzUWEYuHO3bBTq92tw6WC3aIHLlCnuIJX6r+Q1Omutu0vcg01bOUOUimeZK3X/vgR
 t9wSeXshN/lrbusrPovEpbjqD2f3ziBssaH9+gN/HRB2uEEtcrE2bHepz88mbrok7PLD
 rgNWNPQ3G7+HWX5A7U721r77Hi4WztnPNctNeQFd88fbVG6khknLrIGUcgDLczUEcW5M
 39E0oVNx2sigkabn6qiMdnt3gIfkoEpBpuxLiK7rC5916eGfWeqJIRp5bYxBPVczr5BN
 AhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914077; x=1731518877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KUkdAC62SORZw27ZiY6noJmbb1tHsidkViPofEPWYPg=;
 b=UTmz3wo+id2Oumb5iTKAfcjVtBctYCkx2LaDtgRx9+qMhI/KMXeFb9ZXSTxXeRqsrr
 1sbq4/Al0xClODJvV2k3AdEsGGoZ0Bcg4wfJ+Zevm50V6LKbxokrttzaveWWskhelL5n
 vN9f4O5hA6c/VRopGOAOY7dOpLzE1RiMevA/6DfBke3UzXChlNzAdDKKDKfxIPuLMfal
 7GD/M8hEhyTdB5S3gqn2aLb2S0XwHdjpeCHHbh8rkFJxqaxdTnOh0ixju6FC+8oBfKH2
 YYPPfzvTJ+01Ryxte3aKlIAErytOW3WV8z3dl0MXRvYBxnQa1+xoVwZpOU7x2JqGo3OX
 w3Sg==
X-Gm-Message-State: AOJu0Yzz2PJbafB307cki1a5HSjhDIegBxbbg2upPXUeHwQBwRluesJZ
 aK5fAnHVm9HwaWmGDTXNUszNDOTpEM40tssi2B831Zi/oKYMzkFVlStB5hHNpb9DQfR9BRzjb6b
 fNWrIIPrw2qYYYk3BWmnx6XxQbXV12Ah6ZjQobEVqfoKKBB89
X-Google-Smtp-Source: AGHT+IGGw6h/DFVGwk0SAHE+54VZNqhcTKNfAkz9RhZLNA9qoFfaocX+xBRjoCfg72clssSWon2q1Pw2CYcmapqjKEQ=
X-Received: by 2002:a50:cc0d:0:b0:5c9:5665:8df5 with SMTP id
 4fb4d7f45d1cf-5cea9755e56mr14694577a12.34.1730914076910; Wed, 06 Nov 2024
 09:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20241105034039.31143-1-imp@bsdimp.com>
In-Reply-To: <20241105034039.31143-1-imp@bsdimp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 17:27:45 +0000
Message-ID: <CAFEAcA89OHYY5MPfB5cKM=vPV8_OQLBYZhpvKRNRzHqX_WERHg@mail.gmail.com>
Subject: Re: [PULL 0/3] Bsd user 2024q4 patches
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Jessica Clarke <jrtc27@jrtc27.com>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 5 Nov 2024 at 03:43, Warner Losh <imp@bsdimp.com> wrote:
>
> The following changes since commit daaf51001a13da007d7dde72e1ed3b06bc490791:
>
>   Merge tag 'seabios-hppa-v17-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-11-04 16:01:23 +0000)
>
> are available in the Git repository at:
>
>   git@gitlab.com:bsdimp/qemu.git tags/bsd-user-2024q4-pull-request
>
> for you to fetch changes up to 52a523af71448f62e8523ed002447c95170381e9:
>
>   bsd-user: Set TaskState ts_tid for initial threads (2024-11-04 20:26:40 -0700)
>
> ----------------------------------------------------------------
> bsd-user: Minor fixes
>
> These patches have been in my queue pending too long (I have a bunch of others
> that haven't been reviewd, but those will be done clsoe to the end of the
> release to not get in the way of the release).
>
> The patches align the stack properly on x86_64, implements setting the tb-size
> and properly setting the ts_tid for initial threads. They have all been
> reviewed.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

