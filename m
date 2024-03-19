Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3501C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmWdJ-000736-P9; Tue, 19 Mar 2024 06:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmWdH-00072Q-Bj
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:23:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmWdF-0007If-1N
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:23:47 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so6112726a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710843823; x=1711448623; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d0BcUNPe4h78gE6OFW/SnzBAkuXGeQRcmqC+DlwXge8=;
 b=BmSNsRniQBgb98DyOB5JGPNELOla7tP3cdpkJFP0t+rzj8/FYtlGgH02EqjuqrudkM
 1it/1fpejAppP4tVvt5HNf8Dh5tzXcGndPVhMkZg/ImXoXQVRIQCdJf+DKeHwjMedtf5
 fa6TUXH5BX9bgYfjICF6L7gdHB7U+Jx8pIZZchAn5ltLE/nBradeiOKDDn7n3tVv2RX5
 IFEEY948ovxhH20YYHEMuXPW0rGbV1U2ym0seBgRUoyDy0djImtZvOwuybBqzDcYT9s9
 8fuETrEIqCBSqg8t0jRAYPNiZKwqGVzAasp4TSqOF7IgLdSfnYKtGKMoHOnhWfRUH6qF
 t5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710843823; x=1711448623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d0BcUNPe4h78gE6OFW/SnzBAkuXGeQRcmqC+DlwXge8=;
 b=rSHRHii2GkErK12r1tI2o0ZBBVONNtOm+yd/75VVpP3UpoiMdCESuZ4xmHUOhHsAue
 /ZrNpDutEuwJwpKEbgBBkLXNWce+/LcmLu52cuPXMq6XsuBBzuFs/VsyXP6Y3z1WXqFC
 medWMpDrq8XBtDCvZMJaitmU1yRKv83vNcyb43cUz79Bwt5JCfQcU+hhx8cOguYcADnB
 NS09rAWNohPhXfO/xuhOHBnLW5BKoaZ4yLcEn7YLwI98cVCojP1IWuWatbnXJuAhy+S1
 u6QCdVLk3mjGL1d1szFgJADaUG+t06UN8R/RNiCFobR2q0L0+/FNHZXGfdljaDBRDcxS
 S08A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXib1K10vCtwHsaX2gfXKFNQHxsGaFPCXJu9VOewjmaxVlAPXA65lgUX3ukOSh3kcw+pLSqMcOc8IpRyN4eFo/rjfLkDSo=
X-Gm-Message-State: AOJu0Yw8vUNABuXOQ83bLFcMhngyXFl4SNTgec/zhWYHXyOOkNmNFw7X
 Bj203e7+BNt38EMP97ZcSEIfkZSf1Ik/rrOfrFjZg9lEa1ZHmrdLQhjVmynIwQdeFmKedRXKJ7I
 6kg3JUZJRZGqxiwH7BO02knGT0NIj+jmbr51w5Q==
X-Google-Smtp-Source: AGHT+IGsI6QJCd/qxi+mvnEb5vQ4zoV9QLcrDqqhrPE1LvixgnwwLalSuT8sZ0cBjwyR0Q9cVEyak3oHLA7RqMYdI5Y=
X-Received: by 2002:a05:6402:4498:b0:568:c26d:8718 with SMTP id
 er24-20020a056402449800b00568c26d8718mr1593093edb.6.1710843823630; Tue, 19
 Mar 2024 03:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240318130118.358920-1-kwolf@redhat.com>
In-Reply-To: <20240318130118.358920-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 10:23:33 +0000
Message-ID: <CAFEAcA8vkE3h+mX_1J90+DJAtX9e=9=wAMfLdzyXaiQAZz6XOg@mail.gmail.com>
Subject: Re: [PULL 00/15] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 18 Mar 2024 at 13:04, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>
>   Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 39a94d7c34ce9d222fa9c0c99a14e20a567456d7:
>
>   iotests: adapt to output change for recently introduced 'detached header' field (2024-03-18 13:33:54 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - mirror: Fix deadlock
> - nbd/server: Fix race in draining the export
> - qemu-img snapshot: Fix formatting with large values
> - Fix blockdev-snapshot-sync error reporting for no medium
> - iotests fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

