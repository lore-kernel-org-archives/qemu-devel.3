Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CFED1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jnf-00041X-8i; Tue, 15 Oct 2024 11:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0jnJ-0003fH-Ju
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:49:14 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0jnF-00019T-TA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:49:09 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a991fedbd04so527498666b.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007344; x=1729612144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h8yxg9y4vv4qI/jrS4Ln3/iEtaNWndxMD91mSBaNHWg=;
 b=KYLd4d70jvnRPGrswRJPT5Ywcab3SfFvUFFI81czG7Mx2aIFo4V1ptLhaP0OsVfvDy
 Xj+iMXRMQb6ypneuLcg6YnadKvC4/lvkx1trpoQY9uEHEuBiE5P5Of0X7srYq6me9PXy
 TjGcdaEgUUD7N1hIJ/4OKVGP6GuG88B2Biv5qzBkuQZvaWWkInTonEucVewR7kRHS5cC
 EWMtExBp2LC1HD13EPFoeCU7P6LlToVgUZnT8orA+xsehXLkyw42wjNxfuaDi3lZi9BV
 o2ksd/Ine+5q9OSLmmsgvtJWg6dlnHUVO1Bc0qZE/lODbFaWN3IBZ8nB286MARL4Vmok
 Y0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007344; x=1729612144;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h8yxg9y4vv4qI/jrS4Ln3/iEtaNWndxMD91mSBaNHWg=;
 b=NPVIjcn32UlHNHSwM6NB1+CjvRAdATtYkYkp8dcNInAmNBU35XIKXWqDZnRPOCen/j
 u31rbpgQpvUu3Z+R0X+2tMRtZDdg3EDtQmLaADm9FNCbrdHGhjip2EXcMchnQWCDH8Ez
 8IuxQ1+x71E9FvFZbqy13p7X5zgFomiwLcwmZXzRzY4n2d+zTKyo052VUg5iiC9/tEPb
 e5i0QkSNfQNWN8z2xhH2dJnCcTSWF0lARN60XtsUXxk+ANczb5WhzHXI4AW+mvM3MTar
 MA/NRs4uCySHCkSb0S8RfZFyYQP4Gvx1arRmMjYImR7BabFHGWIuR4Sc8K9P+JX2h3jO
 yJ5Q==
X-Gm-Message-State: AOJu0Yyt6jyLSdrv9R1b+G0OCeLr/VgFHFHtxTkNiLGeCWgEHyUZ8KQw
 FMDGYj2jhuBu9YKJX00TcmHJSHcXdSRd37ZG6p6E0uRQmV3A2cWyjh7pkp3NNIwkt32eXecfV2O
 148YHgAa7/mvsNLAOW8qF/1PxK2Vvz/wfkgAsFrAINHIuNumd
X-Google-Smtp-Source: AGHT+IGM+9DkcJCDY0v8KzXQN1mjBRHsMhiLKQ67esltuWKeS9wUl99GIzv2WOXAoUW9XnHmNR9UXfB4tl8Tdo5bHOw=
X-Received: by 2002:a05:6402:8c3:b0:5c9:55aa:4285 with SMTP id
 4fb4d7f45d1cf-5c95ac63c95mr15472562a12.34.1729007343878; Tue, 15 Oct 2024
 08:49:03 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 16:48:53 +0100
Message-ID: <CAFEAcA9CthdJz+QM=_q2NxPbdCyyf+YBGE+qDVYs7VbqWT+aqw@mail.gmail.com>
Subject: patchew no longer pushing patches to git branches
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

It looks like since a few months back patchew stopped pushing patches
to git branches: eg

https://patchew.org/QEMU/20240526204551.553282-1-richard.henderson@linaro.org/
from four months ago had a git branch created for it, but more
recent patches in patchew's UI don't seem to have that.

Did this get accidentally lost when patchew moved server, or
was it deliberately disabled?

thanks
-- PMM

