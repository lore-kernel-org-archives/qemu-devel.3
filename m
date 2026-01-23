Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E2DD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIV6-0007kp-E7; Fri, 23 Jan 2026 09:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIV0-0007j6-U4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:50:59 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIUy-0005kO-R7
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:50:58 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so1923334f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769179851; x=1769784651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyADWa78snf3kwHRYWGSohegbl1R3iIqto1n5mMiUwc=;
 b=ebou0TssHVNv2vJCHizXgPGEahXZhBXevFZN4Z3mgHw1SUfZ5Oh9562Nhl2gXDAWoU
 ps60l39keL+m5HDdwtJ1X6LqQs5Ylq3KAQtaTdBP3BKgrv1tWGJ4JT311PhFeJB2ZZJG
 IdnK/rTkjhaZPcWLczkBLy1rNFz3V8Zk/Q2RMDuh3sBbrDnzjqIzfn2LPVnrIarb7QtS
 uIuAMlOQWzMBkqqHVndLn3YrRe0RSYtgMYFvT45snYoojwOTwxa4o6TOSRK/32Pu7/Gw
 OjaS+qMBi26TZs2BnwNB/D1yb52bws0Xvon5bK6DYVmfMVuT4cypJqqshnQnKBNgeTVN
 0g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769179851; x=1769784651;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WyADWa78snf3kwHRYWGSohegbl1R3iIqto1n5mMiUwc=;
 b=rd31i2U7O0c74ukcLorZGuVzR1wDQxfJX8GeKH7s+ias0F/MoFmPkhHVDmPLjpvx8/
 avAltNVt8Qyti361GHVVpzgrXTG1XxZgGBdXMAPRLtMOygohtV8JvNFcC+zFsmhfoF4d
 Y9o0INAVNGQmbha2ySyEgIm3uGmRUB0ohHsqLHiOBnT4QH3O9UXzViuzyjEVCoPjd+jT
 bLhXcJ3IoLMSLUWty2YkXJUOHw0aOh+3ECMguQOB56wPNM+LuUitM79XZ9JxIt7akdSa
 bOeHfW+ffqAEAmTn1v4rSVEs+QT3BEJy9tJt0TvGjbOOko4odtc1fRi+/ZBdvbQJAefg
 A0Lg==
X-Gm-Message-State: AOJu0YxvfQrlmZAPGPnKqBo1+ynOzlaF9htZiZm92vFP/pFwIpwISkFG
 xOcfmPusR6WCJSnV9S49YBzW1lSk96mnFDwekTzzDvxQJuyiKjc7Fp4nXD3p+ljr4nQ=
X-Gm-Gg: AZuq6aL6FfFpFTPa0YcucdLYDxRc65+lsuWsKKxqMIgkil4FP1e2690mfRiHhMvGe0T
 b+Bmqh0go1PREdeIKfq7hpL3uZO/0jD6/C8HlE3zgdSO5zzUSYf+B/N+6w8ggViI+s6kEM4sC1D
 +n5tnwy67Xgrl707aM80LTiO5CYOqmTyizjLIwpBj+VAw0EJkum2TRp0yNQHFzAT1xVDeo0+RDe
 5flcKabVseIdBKxYOBGWZig5Gj1GlrY9tzbPktTligVBYUoRVpKk3lEm1igE2qycwqeKj5GUDCL
 I70tyR6k8uqyTsgiXeoQwLya+HheZvMS/IAh4vdm2iZ9My5bAFrBByHWIynj0oe6iIueOXBBiYw
 bnQ0fMXWIs4RFq3t8iU423nQVZVpN7HmLiRJmWSR0qTZ85Vwq0r4asVgWiCQeFJpW49rgzQvCBB
 5Nznqs8myfIvyd
X-Received: by 2002:a05:6000:144a:b0:42f:b690:6788 with SMTP id
 ffacd0b85a97d-435b1587ca8mr5470394f8f.10.1769179851237; 
 Fri, 23 Jan 2026 06:50:51 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7c269sm7651291f8f.43.2026.01.23.06.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:50:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA1E35F7B3;
 Fri, 23 Jan 2026 14:50:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Anton Johansson <anjo@rev.ng>,  Gustavo Bueno
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Phil
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add reviewer for linux-user
In-Reply-To: <20260115201712.2706663-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 Jan 2026 12:17:12 -0800")
References: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Fri, 23 Jan 2026 14:50:48 +0000
Message-ID: <878qdomlh3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

> I had interest in this area for some time, and would like to help
> reviewing it.

Queued to for-11.0/maintainers-update, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

