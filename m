Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19643CAC587
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 15:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqaRq-00027a-UH; Tue, 17 Sep 2024 11:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqaRo-00026R-Op
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:49:00 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqaRm-0001gg-Sm
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:49:00 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdba33b0so7383893a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726588137; x=1727192937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o1Fnj77DAH9Rf/QVe+8M5qg11838RWGBZE1LCyVs1Zs=;
 b=lhW4/3hkJY7GXrvnQbg2Q1cIoVV7sI5rAsUwnkBPlAURVnKBtp/nkefXqmX3pSAFl7
 UwPvasZy+Um6aIAqfORgRHvGsl5cTPqvDwqGhXP5WXzerUaPfG/6q6KoN0Iesc5b0Pms
 7ncBxOdOvJ/BQOMZqqXpJs7UmHUGHuggZ/sbylUxIVevaqTVThdVSQCLH6nKcV151c8P
 Rf9/ppeDFMwrdGkuGjihtI53D/6miJ/pXBpHDI20SUiauNd6V3m5An7nQXa/Fq4a++L4
 Z+4Fvfc99jhoqBoLtTfC0BmOfYlCrRmTlOoU6RYeIYfF4oViEsYM0thlRlwRJXVMumsq
 iE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726588137; x=1727192937;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o1Fnj77DAH9Rf/QVe+8M5qg11838RWGBZE1LCyVs1Zs=;
 b=jDTHJvPOXBIzRNPK2MYXGR7PGtCTQ1XVN6mCK8pBLKML4ufJ5WdphqRgvMwdft+e3U
 GbmXCfBlpiaGJU5WEyDcnJVYOWfgmJhVxTOUTclea8+zjpRoOXVV4NyLNkyYOZYagxYO
 ZbEWZSGoQNGNXCuZ+6YEyPK5hso7eKmii5yO7rmBfshjx4kjyNaBAWSV5/bSVEVG3U6n
 jTgDLZhTKnfc4U4ThqcmRWpVYgs7AqeTpmp78xebY0eyPQm4EZBSFk+DM6s3+5okh7UH
 /p/4o9txFSJIWR2133v5jUQNXyG5HvSWtW/IfTxagcVRyskEyLGEI6PdP0GmFmprtHMI
 LjYQ==
X-Gm-Message-State: AOJu0YySAYTOCE60Z9tKYN1bcSgRok/E0B9hqZThJXWaZhSv/Pz9E3NY
 AJjZ+u1RoyUdPE8cE6Y7YO8WD1BXs5LTsKMqXEikXtYotGMkI6kKS/BIW2gRolNArCAEj3vLDKH
 FfNy/aThfAN1S+8QQJ9eDJkNOn8tYkSYrhrm2xOSShXHxXsTv
X-Google-Smtp-Source: AGHT+IFWdEy3o2mQqWIE4JOLyWfRpqUtfNnL+aHg72NWk8WCT20CcMtRPAQckSX7Y3/RcF0WEdARI+1+wGxDM62xyVg=
X-Received: by 2002:a05:6402:1d53:b0:5c2:7570:3a2a with SMTP id
 4fb4d7f45d1cf-5c413e1ee8cmr17150855a12.17.1726588136852; Tue, 17 Sep 2024
 08:48:56 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 16:48:45 +0100
Message-ID: <CAFEAcA9ZsxwZb_=A15pUXDF+HH=sD-B8zm1j8MMJ-mPsZNP62Q@mail.gmail.com>
Subject: flakiness on CI jobs run via k8s
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

I notice that a lot of the CI job flakiness I'm seeing with main
CI runs involves jobs that are run via the k8s runners. Notably
cross-i686-tci and cross-i686-system and cross-i686-user are like this.
These jobs run with no flakiness that I've noticed when they're run
by an individual gitlab user (in which case they're not running on
k8s, I believe). So something seems to be up with the environment
we're using to run the jobs for the main CI. My impression is that
the time things take to run can be very variable, especially if the
CI job believes the reported number of CPUs and actually tries to run
8 or 9 test cases in parallel.

Any ideas what might be causing issues here, or config tweaks
we might be able to make to ensure that the environment reports
to the CI job a number of CPUs/etc that accurately reflects
the amount of resource it really has?

thanks
-- PMM

