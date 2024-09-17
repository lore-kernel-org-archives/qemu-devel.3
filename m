Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A1CAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqae8-00078i-9x; Tue, 17 Sep 2024 12:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqae6-0006y5-4t
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:42 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqae4-0003xB-C3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406e29so4874123a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726588899; x=1727193699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q/5xsMMvS7v+dj2//klH1BoTXqckiobFqW8DVaXBLmU=;
 b=QtNDx7tGhhdErKdphT4IFjN9WzCeNdm5tlW39WIQ6xl94juncWAh7aDwevgKLxZGUk
 vdIAlgZnTpri2f59mluqdyjn3Vw2ZS0wHt28DE44xGtjGjAR3XkifliRHBqcI/9qbkU2
 eVIltmMafrFJzqKCBpOrT3sXN/GWr6EQu07ycnD5WxRjJYDo93KMgr7WnAQAHkQNAiiv
 NeqSU+JtiClucQXR+C0skvZP11S/N+2bKX2jgHaMX1N84NuCInuG474LMvf0MarCUUAm
 t7jTmyjZCZvFFmpD1g7ZRf9DcMp0XCuOV9DZ7m1EVEcmRITX5VTpSnVGYxc4jyLnDtQ4
 V9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726588899; x=1727193699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/5xsMMvS7v+dj2//klH1BoTXqckiobFqW8DVaXBLmU=;
 b=Xl1ZVkOSBlEVEYRuhkNHyqgpegUt/sl0UD0LR3ccYnIFfCIOxC2evZ3F25xUIAgST0
 VRupY/IWHh8vHZ5cznNSTWmG21xsSycV/azF4bSJE4P3zZVGuPdhPs5zwMqQXYQ+Ptuu
 8C9jYtQVulXjCzsnasRVvu8Eh2+PU6ge6HIYl7reKS0ArTHHnzmLbpJoMnb/goSFWOjL
 Ua7Hjzvfh7Yp/PTAnNLe82kjA4P3RSNRRbTaXgulemoPr88yKFPdex6NqiXcWdy7LseP
 EtZxV78iBRr47f1bJE4NwVnUUqvwTOdUktykeco5wwTKipSJDELccrKFVAbjKcEAg3k3
 ZjGA==
X-Gm-Message-State: AOJu0YxC/w9nL2auzCkqAnjhnuR9nEFg1NqPRgehz8MYSl9RCBlgFJMm
 TXjMOfj77SfywZ5tyrcgTGZLbqgz6AXblgbozjDB/JPajLV5OFbiqt/PEYLOpt9SbPP2xN/Cz3Y
 RWBUAcEjfDZP8w7luQ4fWu5DCJzQJ9FpurC+RXw==
X-Google-Smtp-Source: AGHT+IHVLtKorG+3+Ssr7T5KZdbroUTdgr/azS+YzYe3rzcrwOqtpTjQiNTj6wOofkfLo2n4lx5Rh4brQgtS2NFxdlU=
X-Received: by 2002:aa7:c3c9:0:b0:5be:cdaf:1c09 with SMTP id
 4fb4d7f45d1cf-5c413e50f05mr14939988a12.28.1726588898256; Tue, 17 Sep 2024
 09:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240910-b4-move-to-freebsd-v5-0-0fb66d803c93@linaro.org>
In-Reply-To: <20240910-b4-move-to-freebsd-v5-0-0fb66d803c93@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 17:01:27 +0100
Message-ID: <CAFEAcA9W4h4TDr+d_xE9MB4Jc+bCeAS5r0MyH8tuMWssDcRqvw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] tests: updates for aarch64/sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 10 Sept 2024 at 10:48, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> We want test to run on default cpu settings. For now it is plain
> Neoverse-N2 but we are considering either disabling PAuth or going with
> 'impdef' way.
>
> We want to have some non-Linux OS in testing in case one of changes keep
> Linux booting but crash elsewhere. So far OpenBSD was used for it but we
> move to FreeBSD 14.x due to longer support cycles (OpenBSD 7.3 we use is
> already EoL).
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Applied to target-arm.next, thanks.

-- PMM

