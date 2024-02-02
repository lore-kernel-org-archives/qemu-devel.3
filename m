Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A45C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtw2-0001jH-6d; Fri, 02 Feb 2024 08:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtvy-0001if-6V
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:50:22 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtvw-0004fa-Gk
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:50:21 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso2974905a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706881818; x=1707486618; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q5hkTKPkQIwC4z38NfjbjEHZbUCMaV3XEmr5sch30PU=;
 b=o2+SGGTEhfEi6dqjpgUo0SRqsCm+KNKZj9duCjEevRWNgyrc6j0/mBMq8axSzkvavz
 KDDddahg8nH87HnGSCcO6YBkMHt83wpUwNk3mHqqe0+QfR9sFjb38GE5qOwphes6yFQq
 rgpww8DVA2w35jU3ocG6pJpIfrRLu+SMk1XaC7KoyOItUtNuZf7kg858Ionav6mOl1Xv
 RaXXjFauCbtjISDuE4VoYGCfWfGG6H3QfJmb51Ce6vUNWZzef5AVJFNfLEKtz99Xd2Ak
 p0RrQVxh8zJ2ZB8Ywl1clfFm21jG4WMLYyLsYWCr1rsNhu2tXWIHiqEvvB/p/FcXPQc9
 c5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706881818; x=1707486618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5hkTKPkQIwC4z38NfjbjEHZbUCMaV3XEmr5sch30PU=;
 b=nNH89CKEJcs/C2hZ843uGzYm0vc1VufLy+iJDYH8LGyMAsvpqzXrH74n/8yFcFRWpO
 Y9AA+Zysil8WAVbv0rD8hIzZMiGqxK3Yps6NvWDkauI2mTY6gcmYy36SIds9ieWysi39
 1rCHTIOJjNbudBo+abIBMzTe1uc3JKVW2/tbqA3cneucVmnFPO72POS+CVF/rueVxHR2
 clBZO/nc4zemr+XrRPp2WtdiusSgYCvwzH08FfBTpG8CbtGAs99l7r5D4cxHvBvxM4SE
 T5CWUr1BaOrczC22VcMzsYcad0lcmgaHsoVGRz5h6m87fJcny3J45K/NBIfaHKkFtZUl
 6mRw==
X-Gm-Message-State: AOJu0Yxe2v9du0atSpg4A1xwvts3zW3G2h6mu2uh51/Xqep/V0Ld6yTu
 e1oXmiT5yGUwdtBrzLocIfeBhLJiYTMC59K61daKdAj4V2viPC2n98Gutb6YoipBmuLKQTz7WgF
 UrzGCoAMbdqsjeANOfWf/pRPrMfSPK5wlZ4BwDtYmme0kszBw
X-Google-Smtp-Source: AGHT+IFCewI0N4zaEWhuU7eZfXGzb2BPDdiLYldgwJ0D4+E0vLFkFTFwdJWzpumJc4qPi30KMcdHBIAhArAea1Kmfdg=
X-Received: by 2002:a05:6402:26d1:b0:55f:a309:172f with SMTP id
 x17-20020a05640226d100b0055fa309172fmr5996387edd.15.1706881818475; Fri, 02
 Feb 2024 05:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20240201073319.2849107-1-gaosong@loongson.cn>
In-Reply-To: <20240201073319.2849107-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 13:50:07 +0000
Message-ID: <CAFEAcA_aVK=64CjhRr9azc1NWbHxHhee3w0Jd9_H7g5GkVDWug@mail.gmail.com>
Subject: Re: [PULL 0/1] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
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

On Thu, 1 Feb 2024 at 07:33, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit bd2e12310b18b51aefbf834e6d54989fd175976f:
>
>   Merge tag 'qga-pull-2024-01-30' of https://github.com/kostyanf14/qemu into staging (2024-01-30 15:53:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240201
>
> for you to fetch changes up to 27edd5040cae63bfa92c68f69883ba81aa3b6cda:
>
>   target/loongarch: Fix qtest test-hmp error when KVM-only build (2024-02-01 15:29:40 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240201
>
> ----------------------------------------------------------------
> Song Gao (1):
>       target/loongarch: Fix qtest test-hmp error when KVM-only build
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

