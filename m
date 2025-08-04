Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5FEC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 16:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiy8W-0006kF-S3; Mon, 04 Aug 2025 12:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwee-0003gM-IX
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:59:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwec-0005i8-M0
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:59:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso12301915e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754319549; x=1754924349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olvZ5FB5VEyJUh+um1+/PFlqrknVlRoIebueFjtPUmo=;
 b=f7NJuXrVQomJ7IrQ26t/ssPZ6mYGtRotpiTcReNm5MJ41zibGaBy4peQOs7dyX8Ckm
 Aj4h+2kOXv413yIwvjF5lPrI/tNALglhL0mwFumDgFycDD3Rz7Gq6TZS1Qj/V4AlsPTa
 jD0C0BpEV9pT97RlSbYvA8F861DYrCZ595rf4ozqJTwSNavu75my6/Xd9x5pbY8wPp49
 TpbWmMGqjL7vcBQgZJyKSv/BqPRcWhLU6gk7hbtApSSWzkbYrpTa2y2Hw3P9qOTF6CQ5
 1Jkg+7njZF5NOsUxe7xn12sqAK8piUai4kSGFnHIltHDM0zxVeJEQxYQ/BQZ2PML44UJ
 KF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754319549; x=1754924349;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=olvZ5FB5VEyJUh+um1+/PFlqrknVlRoIebueFjtPUmo=;
 b=SMBhmmgrxGmdSFlW1J/gT+QIoPOUUXukE6O2dpGAZpObIfgrsQirNkflhpli/s7UhT
 kvf1bP8eOA37zhsbEiceZiYWPx+po6v6nnA/kUPs9scv62bMHBOzKtF+tocIDEThEUyc
 FEMVEAqrUYcGcQuynT99gcvTC15F7xbKzi2f93aIlcaQL9/+RxZZoudFLKhtn/FXWkAM
 K8SyXa4k1aXsn2X7fbNIm5cYIFI/8t+hch4TUwafedpA++UGrFiMLnfaW3QXfS9XkqL5
 iqvngwAW0Kn3PY8lrh+BrOwnOirby23V+TpXacXJmqN8rlnUnlncPFQ3T9cpQUOBTyNz
 6IPw==
X-Gm-Message-State: AOJu0YwdDKZudCHGg5bYR7ydPT38bnXW5FyO0t6g96Y7Bh/6Td5zQo/n
 4vKwja2IWvFM4Nz0I7FNTGyROJLhl+f9ENhi81lvyJJUROHtUsrpyt0wonA1SBwYZBY=
X-Gm-Gg: ASbGncs/1ZrP/5i+KgWP911wsbsQZgKe4hhHjtXGxUXXwLPU6dfbbmX1CQN2msZALvV
 q4H+ELBcATHQOKsWKZUD/Be+An0KzajEoLM7m39DgZ5n+1+FOet+12A6+BT6tam56NCjXVDuL2U
 k2FLBpq7QcQmkF4UTm5Sjeog0DRPfLeVQEcS4eCaDp2Ijt0xdDuSYEqxs9gGjyaC4h8essvMXTA
 fqbwW1h2Yc1gULlnskFQ4ql1t9UvptdzXyu6KqDH+6YT6n0Fn3Q6cR4mBRru8g1LLa/Ec81vISl
 PvPkjdQwtbSAULek3DykzG2Ha9cpEowVvNko3TPqgjHn4Po8+sKwUz7oT/c5opGzSH0afB/Ja5/
 n3NkGSN+8rStqraJXyfZckM4=
X-Google-Smtp-Source: AGHT+IFB+KlRFh8QNM7P7+36bZBKsTgbF5Ph0CQ8QwY/UhPrItjAU429YfCIhLR5w81mmMCCE/KR4g==
X-Received: by 2002:a05:600c:3504:b0:456:f00:4b5d with SMTP id
 5b1f17b1804b1-458b6b34ccdmr67599445e9.22.1754319548972; 
 Mon, 04 Aug 2025 07:59:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee5795esm172402005e9.25.2025.08.04.07.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 07:59:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F2EA5F88A;
 Mon, 04 Aug 2025 15:59:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,  Michael Roth <michael.roth@amd.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH] scripts/make-release: Go back to cloning all the EDK2
 submodules
In-Reply-To: <20250721153341.2910800-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 21 Jul 2025 16:33:41 +0100")
References: <20250721153341.2910800-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 15:59:07 +0100
Message-ID: <87bjov6slg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In commit bd0da3a3d4f we changed make-release so that instead of
> cloning every git submodule of EDK2 we only cloned a fixed list.
> The original motivation for this was that one of the submodules:
>  * was from a non-github repo
>  * that repo had a "SSL certificate expired" failure
>  * wasn't actually needed for the set of EDK2 binaries we build
> and at the time we were trying to build the EDK2 binaries in one of
> our CI jobs.
>
<snip>

Queued to maintainer/for-10.1-rc2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

