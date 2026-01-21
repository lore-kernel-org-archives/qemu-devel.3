Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9248DC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vibh8-0004X1-M2; Wed, 21 Jan 2026 12:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vibh7-0004Uy-7p
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:08:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vibh5-0001ck-O8
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:08:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so712555e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769015313; x=1769620113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvoDqKMXdLPpXk2aD5zu/X3oBZskdZMH8hhgfIfhqwk=;
 b=ga43g42GEvG0UknPNlDzKK21pPWFxwYpkNR9mzarLiBj57j8jeNtp2yQr6ZKV3GoiF
 4cfW7LrWiZqYkbqtNB3MBIBSlZAOVt/ESOLLL0bVWvYdn7JnOVxuC8/x+PH6uGeYrcfJ
 a0ddJtzHOQ/P5wm0M9AMEGYKb274t4Hu7OxMm2mFiBCqRfQQRq8hugD/4Tztxzm0fvN7
 WVcP7HdnTMWzMEasc/jTT4wYxYe2kvN/kkGf7PxTUD3P7Hh9eMn067dNqxZ7eJe9SJul
 658E5ukYjCZbk/oUWmqEqdar3CFfXB9E5pCM5Vo/yJ/P9bvPeNF9iDCKnpNnw2q5wUz4
 GamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015313; x=1769620113;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvoDqKMXdLPpXk2aD5zu/X3oBZskdZMH8hhgfIfhqwk=;
 b=BdNV9cSA5uQgyyEO+cPrNQk48wqHFTkAf1jOGXQZcAREK/hYX3WOX62KFtsoLHXRy3
 LjuvjtqMQG16UeNjsAYLTi1pSFo0B9UdAo99jkpCbpIKlaJIw7chfTy5awv+ojEZCmbb
 mF3Z3mWrgGA0BxEeCEBMZxt8S+kq5MMtGZfWFJhHOimOkIgGM9Z9TMk3qbaLqWYMVm0z
 D2MKtCmfdzuqNewQPNZzPlsLkFbzeyan18FJBqHeyzU0wN/EZZ6FSW6SZGcBo9HNuG1l
 WwBcbeO4BYB3sKL18UFkgELg+2fb1afCb+EH8dWJOD8BLcaVfY1UvpN3z1mUoeo/FEoN
 QaHQ==
X-Gm-Message-State: AOJu0Yz43oFlVXMSDfDYlpJqC1xoAK1Az0L9w9g38Clgf19c7sRIHBDV
 gG1LsyA9GKkR1Kmdv5cqjr2Y79zWk0gh2GwtF4hpgvX63/x6LbbKjEq5hI3S5cTWkPweEqE4iqT
 tHaQS0iY=
X-Gm-Gg: AZuq6aLmYokxj8z/DG62pW2JGCljEGvQ7NAHnY1ispOLO8j3HN3Yyz6BsT8CfU+4rI8
 DKaA3C+GMbuXoiFpDvkXldarTA+IBCPoMDG7cjYS0gnV2s49YJkP27StuAd+1gT2tXXmTuAVamN
 3Fsy0NXoJ5p2t2PoJ2sM7jdpjYndAcOXSKhLvwmSau1RbsTg9hSQ2fD/5klGZMqKpbN5OTEg/VS
 3oK7vMDDSYzT8YGa5MbrKuEID9ELMcimmTa73myKO9QVqrAAxgrKlYAGuaZYXAhC0LfV7QrJ0Um
 5quxJx0IRV39bfkWnc3c12G3mdgMPIf4n2o3XvLiZLtFTnufjBlVQS+gDS5HxjNk2FeCjOcGSjp
 zafcq2g3jW5Qv/jTkfKuLnPlz8UAwM78FpXi/GG/TKpB97cCeS/VxlvISGAiLDvc2RguABJ2wpj
 6hyvC+wtGJ+gr/
X-Received: by 2002:a05:600c:8b82:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-4801eb0e5demr258730765e9.25.1769015313070; 
 Wed, 21 Jan 2026 09:08:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48046fba46dsm3224485e9.0.2026.01.21.09.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:08:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D4745FDE8;
 Wed, 21 Jan 2026 17:08:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: remove myself as reviewer
In-Reply-To: <20260121112725.40060-1-mads@ynddal.dk> (Mads Ynddal's message of
 "Wed, 21 Jan 2026 12:27:25 +0100")
References: <20260121112725.40060-1-mads@ynddal.dk>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Wed, 21 Jan 2026 17:08:31 +0000
Message-ID: <87zf66opv4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Mads Ynddal <mads@ynddal.dk> writes:

> My work has changed focus, and I do not have the time to continue.
>
> Signed-off-by: Mads Ynddal <mads@ynddal.dk>

Queued to for-11.0/maintainers-update, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

