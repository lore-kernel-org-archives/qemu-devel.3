Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4387AD3F080
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7gy-0005Kv-2b; Wed, 28 Jan 2026 10:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl7gu-0005Hv-KR
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:42:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl7gq-0001qT-NV
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:42:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so7138205e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769614963; x=1770219763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+zLFNn+05NPSP5dN6Z+zoQdVRsA8Fl+5BGYgq8sS0U=;
 b=UKA38IzO1A1s1wB+9eqWz6X3oRwEn0UJKPKebAJ03AC78ltfm8nRZMeAyxZh6t8noh
 stX5JOIiPgFFaj9R39SKcMIW+HUdKFNeh3/JSCTsGlXj0NTWN2m9lfczrvHVpRT0VA7W
 SZ6u8STUL7FfJro3heOzSLlomQyC/JygVMRXvw0XbGrmT0U4zpojrLkeE1wQmkZ8PIMI
 5G4b76Ky6n+3GJFL9oaf2wA8y2nHkINmyf01SntnmXp4xhoeVoDhdgymi6eaRTLoEuIo
 hnWZyQ4FPycXSKbdl8Rzp5lnUkv5SrjX3qCAbRsUX/m4uRfQUOoEu8l3Kw15d7A7KKMf
 2xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769614963; x=1770219763;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+zLFNn+05NPSP5dN6Z+zoQdVRsA8Fl+5BGYgq8sS0U=;
 b=Q/5+RDJ6y5HApzelVQXHuI+FbLzuiR9QnlyB62R2rgBHfaqanyPeZKPSYtjHlmuUNQ
 BW3SCPTbWeyVa6rvE/XQgFpWGRWhgAAyYLNA6K1Yj+YjjJezmVU3hGn0KozlTIaMMymK
 hzsjE2IBASQx7d2fAkl6CYsCbMLyt4XWoA78ubOHmbRCrjiAaZ3vAvTXP3bhnJqeMFC6
 3dhURE8JSBsYO5qMlnsNIlnQVi8yKgcP73lomtjnceMr7mhUfvyqGRqAPLD/e2o0xRAi
 GSYndgLGYR7oWcCU1AlntSVz0IgTrie0eOaxZY2lm7TN3NRET13UVfp/85pM9fir8GOu
 cYhw==
X-Gm-Message-State: AOJu0Yy6mVbxOXH+NKj5ONV5H2K0b+DPTvw6+/iYfLCWdR7Ro0Izpu/s
 QieHc5KCwabQlT0IuEFXcPX4oo3hbH8HE/6R73hV5Iazvf6D8mx7K9iCyCRZ2YNULGs=
X-Gm-Gg: AZuq6aIw0SZyCoVfUIqHE62O6qD6sORfM7lQOO4Eb71heX03jC6Moxv0G9ewtnCKDrO
 CY2yrQZS2u5wr2pyullbiDXriaCSfrITSgrSagxUoJqxakz0Obmk65FS8BpBY5qXVl01XDL1lq/
 tQro4PjkGZtnGzrHLIxq+g2uzT+TMpvNrFF/8nvdzmXi70ePyLPojjreJmVIIGttQjyv7mAqtIf
 Vk2fzsZzqq/gnEEwDAwMkwSb1ISAfCJR/xRoPI3ttMmdAg3vOsNznEQFYCQsfziAolbswm4oLxO
 Zo0UxLnr/toRYxumOhqOFKQNnsFC89gT+C2dYvNGGhHmloDuzNU0z1RLjgaTLyZMUUrgzkvVX3H
 TCPwpjaKFb6Qup0jrQqTu/zvBe+7iq2yJo7MKZTTXeUzqMBriYKajcMq5PDw/yaeZLsM8fE4ez9
 A8SBNp/uiksMR5vXLxJnQiSw==
X-Received: by 2002:a05:600c:154c:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48069e2400amr76600165e9.3.1769614962858; 
 Wed, 28 Jan 2026 07:42:42 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1353f8bsm7974085f8f.39.2026.01.28.07.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:42:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 608735F832;
 Wed, 28 Jan 2026 15:42:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <laurent@vivier.eu>,  Richard Henderson
 <richard.henderson@linaro.org>,  Dominik Disconnect3d Czarnota
 <dominik.b.czarnota@gmail.com>
Subject: Re: [PATCH v3 0/3] gdbstub: Export helper to use GDB errno values
In-Reply-To: <20260116014612.226183-1-yodel.eldar@yodel.dev> (Yodel Eldar's
 message of "Thu, 15 Jan 2026 19:46:09 -0600")
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 28 Jan 2026 15:42:41 +0000
Message-ID: <871pj9bv66.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Yodel Eldar <yodel.eldar@yodel.dev> writes:

> Currently, F reply packets in gdbstub/user-target.c emit the host's
> errno values [1], but to facilitate host<->target independence the GDB
> File-I/O protocol defines its own set of supported errno values that
> should be used in replies instead.

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

