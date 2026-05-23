Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F020FCD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 09:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQiDL-0006XJ-Td; Sat, 23 May 2026 05:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQiDJ-0006UQ-6D
 for qemu-devel@nongnu.org; Sat, 23 May 2026 05:00:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQiDG-0004ol-Su
 for qemu-devel@nongnu.org; Sat, 23 May 2026 05:00:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d75312379so6800842f8f.1
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779526805; x=1780131605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMDhRa5Wh5zuSfzGJ41ggf7y8Ak+PE3Tl6OJb9OnBuw=;
 b=mtVKJlRCNv206lDgkVXG3KWkvh5TgY4AFkWAkxOCvCLhOOSVNeiGI5xY+VrmXJaXel
 69/0Gw7BYXudvnV31l6d7Y9cjaOA5gP/nHkk30VfNjTM5Ec8Yqto4ZsgC9eG2ZO+56RD
 DjRUWOnbXTj8JV08mvEcwrYpzH89GJeh+GUFmzi/RGyeJy/c5iqeCM0liY7hfRqcgllo
 AtdVeCu3sgHJDZfaVwyIyMTnBmeYz7/TmUrIkscZNSN861r8Rdf/MwXvQ469nrmUTGX6
 dxoKTa8lW0a7dVSAM7O1IGoqDZPWxth7N3G5hvt5Ox0JRbPI4RYkyBeH+bWomZeI73UV
 s4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526805; x=1780131605;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dMDhRa5Wh5zuSfzGJ41ggf7y8Ak+PE3Tl6OJb9OnBuw=;
 b=YQ8T025iFY4Id/uHphvfyPA49c8S0gnAO7oj4hUAmKSgpQCL7GFtAutn+YtZt51714
 NF9EwYdaH+t0nD3thF8PVzdmR5Ri9bibAw+OYKd7YrSlcKFlf3Z/Ho/5kiMo0PINqfK7
 mOgcS0R3Cmcql+5U0w4iONtLfPGRQy8eHRsXQNNJ0LI4CpgP4aHCbrP9zD1uCLImOheW
 NR1xi/KQqjlPyQQykKxz2Osf/A7bVpht734zOjbWxbcTr7ONtiKtfjrdk4B8xvEBq3JP
 QsoJtiDEIDcGEerqISTNpXzReuh/NbF45BP3f+OA9CB06gMq7dhRnYnIleRvmV8bjh0O
 efRg==
X-Gm-Message-State: AOJu0Yyn4UUc2ufXzNvqKfAc/fh8n6WiPPic0104EL+4pW0fAIvXBMob
 kcbLxYTm7CTUi/dkiOY+AeSdkirO7DeYG8pmOPtVK8rHT5Toz+u59bXNinRJnA907kJ3aXx1xF1
 4rw+t
X-Gm-Gg: Acq92OFHWejuDcdOGHw469pUsfKIvVPW3M/lndnplV0ltcx4nR8b/glJXdjgwy1kmoG
 V6fYyfrXphQgLA2NBNYBnTSgRPO5FktpQSzxLO2tvKs9WWBqH/qe5o8sSM4Nsn2PkhK758FIbXk
 devqwH4VD2obdK3OK58Q8OmawOkR76M6tQBDPFehZeMQSjl+m1O+09FZzP6/q3i37WIMw2i4MgZ
 SMhtFh6oZXY/xt0a83PiUVkLmp1si6ZXS0X6YELE5S6E+tRdhVgDLn/tMwEBR8/ZjezJNGAFwGL
 FUvutm29fDNv1947uHSTSEmhy7Q8KD5bGc99/fGxV13Gx7aiwWAYw/vHNTZnyimMvoMQbkHQBzE
 2xR4pALSvakgh6IB2tOebwTg1C3uhQ0TMJ83vQvWhru8hH0DoLWrLpyM8wI5llzHC8fbqrpKFsm
 j97gRczP1zZYebI8Z85Z9mxNI=
X-Received: by 2002:a05:6000:4614:b0:45e:abe8:41f8 with SMTP id
 ffacd0b85a97d-45eb30cfe53mr8959116f8f.4.1779526804866; 
 Sat, 23 May 2026 02:00:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6bc5479sm12339649f8f.0.2026.05.23.02.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 02:00:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C2ED5F7F1;
 Sat, 23 May 2026 10:00:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [Stable-10.2.3 v2 000/149] Patch Round-up for stable 10.2.3,
 freeze on 2026-05-22 (frozen)
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru> (Michael
 Tokarev's message of "Sat, 23 May 2026 00:48:31 +0300")
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Sat, 23 May 2026 10:00:03 +0100
Message-ID: <877bouec18.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> The following patches are queued for QEMU stable v10.2.3:
>
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-10.2
>
> Patch freeze is 2026-05-22, and the release is planned for 2026-05-24:
>
>   https://wiki.qemu.org/Planning/10.2
>
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
>
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.

I just wanted to make my appreciation known for the work you do keeping
the stable trees going. I suspect the AI-pocolypse is going to result in
quite a number of stable series patches over the next year.

>
> Thanks!
>
> /mjt
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

