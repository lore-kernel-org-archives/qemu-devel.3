Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07849C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riecN-0006EL-RI; Fri, 08 Mar 2024 13:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riecJ-0006Dz-RK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:06:48 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riecH-0004jS-Dt
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:06:47 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5682f48532eso1373351a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709921202; x=1710526002; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=asfKzhxfax3+IWcjgDj/It1UC89hn5iDw83nZCbFf34=;
 b=Bh5xd5fYAHQ4aYsIqw4GAXNPvs2EUaAj39JE34graOZExD3ZnTztBAVvVcW1GRm1f+
 oYwrMaMxXgRXZwk36VIBD/Ct9hzPjeRkojqfyjQGECPdMp5i+Q/jW6rEg0UZS/YfVe6H
 gKeXQQy4xmakofSNigOOpNbomSwztEr7rbgkhrEo3DqAvas0FHGrFkXl5DP0b2lqU2J9
 WPtdYtoeGKl4xmPcDyhVsANdDBrTy5EWwW5inBbphb4IJFyuFliDSCMtLIWWt0Cj4y4o
 WEpvv15Pox86E5LqLICwjNriEeFU0u32Yo24kLtUT1qcZtg76oZykeFS89EN5Vgm9aU1
 +2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921202; x=1710526002;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=asfKzhxfax3+IWcjgDj/It1UC89hn5iDw83nZCbFf34=;
 b=LfEMIJeHlEeOsxtTlCM2tG2hUinhy4vJgdfHbCfvGGezKUaiPBVO3bSIaNtZ7slUEv
 ALq0JlQWqq2tm3hJ7DhiqWOoUr0ehnYITzbXzS5ycAehbcub0nzhHp9qaIBH2RQplJnZ
 PxddcBltpScNoHHqamCtVGm/Sj7knYrQ7OqyWVCEXM6UaQWhji+BlN2mMunD9sy8gycN
 aebIxq5z4DN9OZ9VzsAxUg86V9WZLqpeXYhUICHQiUen6lHNy23Y94Zo0sNCkmlS0GDE
 Wg3WT4y5YwK62WBFJvcLsIloNOg6zX+pwm1qjGDA8llxyd7NqldqrdycHkbJetun5Bj3
 lWCQ==
X-Gm-Message-State: AOJu0YyXEYB2PxqiHXwz6Yn7Zblm7l3p1WpcfibzfFAcniwtFRZLS+lm
 lk6gwLR+vkgLNLCts/O63ulKE0y+IcYQVSax8ZKNb9mKpxYL4ZacCDaA/3gMcmYqN/y6a93vbRH
 fm78VhsVKeRVucP1L29WL1mWwGEiAZE/11pZ+5oqDPUmSwggc
X-Google-Smtp-Source: AGHT+IFNVCo4BCi9QqAS55YD9DFMpJf8LEAoLa1ASCRGVIS/DPGbBSyuGEE8PcDCYbqgMugTOvohmC4KHjWt//9F5lg=
X-Received: by 2002:a50:d648:0:b0:566:902e:65e4 with SMTP id
 c8-20020a50d648000000b00566902e65e4mr822946edj.18.1709921202125; Fri, 08 Mar
 2024 10:06:42 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 18:06:30 +0000
Message-ID: <CAFEAcA88=WtyqWC4S=vEjv-rW+GBrMYs7CEQmEk5XNnpFzRk4Q@mail.gmail.com>
Subject: reminder: softfreeze coming up
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

Hi; just a reminder that QEMU softfreeze is on the 12th March, next
Tuesday. That means that all feature change work should be in a pullreq
on the mailing list by that date.

Also, if you have outstanding bugs that you know ought to be fixed
for the 9.0 release, now is a good time to make sure that they're
in the issue tracker and tagged with the 9.0 milestone.

thanks
-- PMM

