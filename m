Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C8EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFZz-000586-KO; Tue, 05 May 2026 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKFZv-00056z-VP
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:12:47 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKFZp-0002QA-HZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:12:42 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a2b636b944so5364939e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777986759; x=1778591559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCyPu/+8kpyqyuj5Mo1NFau7dJXf0qONfqi2NDsUJ78=;
 b=gZx7XwgeeBddWd2jci9xPPAdknhErQ/iK6exC5TVS7nsIflox06/uFxB5F6CQBXkZH
 9FGYVKeZ9JSqwDvBaqAetTi4YNK4t9IHmLQeKxdINqcQ6ggkc72b0FU5SbU5XZ7OqEdq
 RWUzFUPOjKbE6pKpIB+L4iSsNlKcIPp41/fdTJoZ2xvQo4FVLXzZxnJBadIEjZr45eMF
 TyxYSjqxGvh5W35XFexKFqwiugWZsEFRmxxPdo19k0bi7wlvyZodfekFwiGgF8czHTFm
 RXOw/nlfMI9z+ZlIRz2scASEjwByMBVb+Py+FELKt+ZN1ui/hv8Jz3XD/LFBwAxXQjFv
 /7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777986759; x=1778591559;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCyPu/+8kpyqyuj5Mo1NFau7dJXf0qONfqi2NDsUJ78=;
 b=WWNEHxQpyrmQO4YE12fQxG0ZPQIhczgg21tJV4DHhHGghol7pVfWLByQWee1MU+zU+
 4UAInnnhuo1kRA5SKeYBnfmdM4BBo81WzJT4PLfdlUsNKed0FX794t6U/xHABaQRosif
 BN6s2mEQcwQw+ZyoSRNoK8uNDu1bRoSoP2kz5Q9vty4SOF6SFdpQhgNF58Hmx+sdLMrA
 lm0wb2eg6BNuVKX3iQMDzloW+1loa2yF5RiLDgwRzB2zGBfF9rXLQz2wOgBVgJVbI8nK
 Q/I99RdimCDuNLVyZceD1Rpejzu71hvqgj9QSMoKeRN+TQrCpsX74BXLbf+3APfW3JYH
 VQzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lxB8KZyU7kHvOwRl4ak0GweQxn2z9GBpjnPai42jBEkQpojjgWgfw3pVRmBwYLTiqEg8xmzMw7zMr@nongnu.org
X-Gm-Message-State: AOJu0Yw3n8SVGKa4Ff4WuP5q69F+xpPtXRhsGKDjISF6xYnj1Q5uiMfE
 WqRFPVrF7zu3gEJ7KUBYZxI4dmpjCkIQGj250mWP/9VuqEUPncBwE6UchVD+hDWQdoc=
X-Gm-Gg: AeBDietDHdUkqlr/6WS3g6HObjZxncmrxbbIJ/VWYdq2l8w9Tf319fOLG6MgVCC7dHq
 F7Fe1ZRH+v2WpA3x08WK7ceu4o7lxEMXGo4Ef99+yumoU+GaTBrpfgxD+aHTm/jCex3UFHerht7
 jFDsOtlJoYcsFh7mXa6WUp3mrsocXfV3BJhLIAw8mWtA6tywIMCW5SfAMAz5qQkBrgnM6Xhlxmq
 rXeCwsRcKJFLP14+6FWdHHwpChHUs3FlVXkcGblCvTLfw5Xgg+Hao+EmrGEzY5emKlQCmH53hhr
 Ez6KaHj+A4HZOGk/G+YAuxuKrmY/KtKH88r67WTiBwPtc5FJERvDoMfnpsWn8qsWfm6XAh34XoA
 oOTfIPc43vV79ohSeAvAXa+t88h4/Uas7JukZiQjCt3KK3ebvi9dUfCur7VwlSlpYVL52jIfmLL
 wcY0XzcuQ0zUn53IrSzmQ1YmylNltLnCgsoQdzoyNA/Ygj
X-Received: by 2002:a05:6512:4007:b0:5a4:74e:5f75 with SMTP id
 2adb3069b0e04-5a862ec0f9emr4364681e87.1.1777986759409; 
 Tue, 05 May 2026 06:12:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4504f4857ffsm4360390f8f.0.2026.05.05.06.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:12:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D30A5F8E7;
 Tue, 05 May 2026 14:12:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH] target/arm: Report IL=0 for Thumb 16-bit BKPT insn
In-Reply-To: <20260505103726.419195-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 5 May 2026 11:37:26 +0100")
References: <20260505103726.419195-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 05 May 2026 14:12:37 +0100
Message-ID: <874ikmngoq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> The Thumb BKPT insn is 16-bit, and the ESR_ELx syndrome register
> definition requires that we set the IL bit to 0 for this, and 1 for
> the 32-bit A32 and A64 BKPT/BRK.
>
> We used to do this correctly, but accidentally lost it in the
> conversion to decodetree, because we converted the A32 BKPT first,
> and then when we converted the T16 BKPT we forgot that trans_BKPT()
> was unconditionally setting IL=3D1.
>
> Pass the right value for syn_aa32_bkpt()'s is_16bit argument.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3474
> Fixes: 43f7e42c7d515f ("target/arm: Convert T16, Miscellaneous 16-bit ins=
tructions")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

