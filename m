Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE1AC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viblA-00081i-8W; Wed, 21 Jan 2026 12:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vibl6-00080n-Dx
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:12:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vibl4-0002IG-Uv
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:12:44 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so48778f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769015561; x=1769620361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8+/TPhvJm+ZDETO1CkLHZFOTl+bHApch7y/qo2kvD4=;
 b=V+YiBT9o63QqYKxqMyS5WhtJ+XnFec8bmLI1Hzd9UA0BswZDuhsU7c0yaS/EMxd7VJ
 h2pyHEK8+x2i0Qmp6VEqI4X7o504GJHntUIuiTzyCzGKpL0MLMvx4mB7DAW3fG1jF1No
 xQP1zqTgB7p6fvxOcuuy6AAUbjBhPxEt+7gTDuvw+9aMRZaXdhBGxnUZmUWRWJS28BAI
 YqkEllEi3CovlvlC0WJMNc/hrRoOjCtt38pjbYNrWEWA2D1pVUo1MRCvP5lt7twqE5wm
 wliTxAFxv1+xpfiPz5AN1xaZcYZfyIaQIDzfvmz80+3Q3/zN9Fg4kQ/wjgWoQvnUun98
 AtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015561; x=1769620361;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x8+/TPhvJm+ZDETO1CkLHZFOTl+bHApch7y/qo2kvD4=;
 b=o4tu6xWw1k9Zb1SowmLVshrDxsCszjGwIFFI0P1SBTUxzO2O5ZNTpgIbRU2bAyACLL
 0+V6KKCwLfkwQZ1WXW8ovSP09XVnO1XoRI7Ulivf1k7X8esnFeWgR7gak75srsMRsz4t
 Hhssubtft6lan3Lp6kF9Y38GFJtb1hmAuxZlygptRnb6Z0wZ2zCLOg87tIGbEbKR277w
 wCzxlzhsL2FoIBnzLCayFqGlFt6nKQBnhWtUWSV/lWO3JQwKTQYbKoun0s0mRrUSveaU
 p2B5HS3L+iQbL8QNzGQUfEMyXEGywE2xq2w/ASvBAESVfQek0hJ5xKV8uuthrKQSDQtb
 cJWA==
X-Gm-Message-State: AOJu0YznL3JbDhXq319Ns49mGL0QlrpxWmFyLuHOuJT/4gO3RQNmAlAS
 v1RVbiAJaLuEShOLfVE2K18bkgL5216d/v+SHZVzT+CO7490Kg2jxgWYPBmfFTrrh6k=
X-Gm-Gg: AZuq6aJ7Xa+Hsa5L2Y9lAk/jWunWPNoxEdhUXAjWPDlQ1z6NelU6yaftGIMthEZ6bIo
 L1cSHfKsqZJZmvFutoilbtSSJvmKKv06d0laLn+CGSb1mjBk99KfuRmiOmoLX4Os5Z5cpI/hXTV
 O9tJFx+dmsovpIGInIWyVcrlxPAiG/u7K8hNAvIGyUP0M656TsCEww2BFVNxb7dFUD65Qxt79E/
 crcJ1m15XqD68jFuRHnNOT6X7x9nrHS8BtY0F6qWEAqO53cvSCjAUjbA91uvW9LvZZtSCTd0Y34
 x122QZ52vxMEe/mteIgY8CEJsOcq8YZ1SMNV6oUUfhGdq+DDDakcZTWaza+suH5zcv+qU5HG96Z
 8AS6FpNlyuXbC0fNwodd9fvG7slUHHB/8CBi0LnDzDiAcWsIKESa/iheU6zz8SKAKXQrhgNzTvU
 FhjGca+bXQrdnJ
X-Received: by 2002:a05:6000:230d:b0:432:e00b:8687 with SMTP id
 ffacd0b85a97d-4358ff5683amr10493369f8f.31.1769015561037; 
 Wed, 21 Jan 2026 09:12:41 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435a575c396sm969221f8f.9.2026.01.21.09.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:12:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3AE085FDE8;
 Wed, 21 Jan 2026 17:12:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Markus
 Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  John Snow <jsnow@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
In-Reply-To: <20260115203529.2713193-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 Jan 2026 12:35:29 -0800")
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Wed, 21 Jan 2026 17:12:39 +0000
Message-ID: <87tsweopo8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> I would like to help maintaining qemu documentation and I've been
> invited by Alex to apply as maintainer.
>
> Files in docs/ that are already maintained will continue to be under
> their respective maintainer. The goal here is to have someone that can
> help on all other files that don't have an official maintainer.

Queued to for-11.0/maintainers-update, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

