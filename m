Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86828CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9TAW-0002gP-1u; Thu, 16 Oct 2025 14:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v9TAS-0002f4-Vc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:57:40 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v9TAN-0004PD-53
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:57:40 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c0c9a408aso1822904a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760641053; x=1761245853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=suLubD8BbBa/a1LvWiAm4xHlqz8fAATXqu/WUFjnYkE=;
 b=dqw69xV47I92W20r2MSyt9Hff/fVXu30HfWeeetJjV/Z9+qf7yWJW8nXI72UpPvzss
 JXsg+0pEpoHP6y/rC/jAislBE8tucGxPuq1OGlsH6eJc1cDtnsk/sytjEWRajY/EZGfD
 rqbUnEFKYa2Z/rV9b8kmg9XJ1HvXFBH2+xpoQu2Xf4NQZdFzB6QmD9T9/uB7F+fCrKF7
 giVwWKqtzkqQJK+Dim1QftTFiJA0gfHROzRZjyJIKFJbKti2oWxgBxSuCw3UJwbfn9tu
 Mauu+ukcfvbci6ZO79suZuDt31XO3EmzptE+wBJKj42TD+Be6UHDEnAY3fwhqQq0ORP3
 uurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760641053; x=1761245853;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suLubD8BbBa/a1LvWiAm4xHlqz8fAATXqu/WUFjnYkE=;
 b=SFXz2bYih2YhOUfdVOfBVJQRvrJBXtKsTSJeGDHBS8S73ccYeEDA30gPWljywxwCmM
 Q1ew2mCx0u4eapLjC6+DvDv860HnhadZ47b2zkzhhWLciku2TB6zIXUOAz2K75LC+cBg
 iEW+OHPgS5Xe9+Ck7k+gHMatyYr0/Toc4PcSUFn8R3uHOacxc3vcG2qaXGaa3+KPZmTk
 6GGjZwVrBZieIEvewYzgzMEe0GTv5PssRXCHYd022SXGzSvxKWwUBn/ogQgFjLUIeByf
 JOvYy3+ek0Db4F/GnMYcnDz/o727+9kFpuMLtTiWpLUTO/mMlP7vca5s9GKsajAHT1bd
 qAVg==
X-Gm-Message-State: AOJu0YxpiLL3DYwfeHTykyqupqd4s8PEcmuo67MOMkmMiKdKGvpR5GLc
 PFLumSECs5lxRIv26xRHxyrGGnZtrdWP+d9hMqMr9UPsrN+t7U0P+ZoZQhaWURK7TFL+HqrhG5O
 58SjI6HovUZnRveoC6KqzGt41kkTQUAw=
X-Gm-Gg: ASbGncu9mlO7j3t5HXSOLgHXl4tT/gLmlyjWrEpZ/feSkUyPasLiDUsTemNLMr4exLr
 QEOY5qsHptEwTMw9YjhiaWx6xhphpkMuWjEyAoQR3VDjylyl3NTBKH7AFdB34R7u5VRD9hRnr4K
 dHd1riBPt5AftvplMNvSUiPXfBB+2GLsDVE0+VSEhaQeiU0Zp708jUGZHAcqASsLrUdoL9QXLkU
 ZKyU81G3fZFVHZW0oaPQZpVO+0WRg2qrFDqWqZMuWdSmCgjU5VHRB7e0E3cMbqaYMvd+MkSxkJv
 yPFD
X-Google-Smtp-Source: AGHT+IECXgTbz1cE/6otQJuOsb3jDyATzeqlw+P+4DZB8hxN965hsinAu5yHIEq94tOXzwdB/fbpMR93WsHEOVc29Ek=
X-Received: by 2002:a05:6402:3595:b0:63b:f67b:3782 with SMTP id
 4fb4d7f45d1cf-63c1f6e0330mr938202a12.27.1760641052806; Thu, 16 Oct 2025
 11:57:32 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Oct 2025 14:57:20 -0400
X-Gm-Features: AS18NWCvz3fPZ7JpVgNisFo2DAk6z_wAMPcIkgg3Q7Ssp7ig7rw9IHLQlSFN8xE
Message-ID: <CAJSP0QXLR5QkPwS62aGyKTTajwaXz-6bXzq8FNumW-HfMiQptA@mail.gmail.com>
Subject: SLOF repo mirror URL updated to GitLab
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,
QEMU's SLOF mirror at https://gitlab.com/qemu-project/SLOF has been
updated to pull from https://gitlab.com/slof/slof instead of
https://github.com/aik/SLOF.

Thomas Huth requested this change on IRC and I see that
https://github.com/aik/SLOF has a notice pointing to
https://gitlab.com/slof/slof as the new official repo.

Thanks,
Stefan

