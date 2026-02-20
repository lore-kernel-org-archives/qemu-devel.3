Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEECC56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS5c-0003av-A1; Fri, 20 Feb 2026 10:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtS5K-0003Jb-CC
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:06:31 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtS5I-0003v8-2U
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:06:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65a40f3f048so3951697a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 07:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771599982; x=1772204782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hee/oRg14qzKO8J1dGh3sIJ/MTM+zj3eJ1EYC0Ozf0=;
 b=wNniWfPLHTPUXfEs1ILs7wYaAM4s2+BrkxF/5dwTF6ADfgxYiGU5gFpI+TVX3YQn4+
 LLsCcH4NSkSxVt4oGjqG9tnCEkSzuhAwEfIwekJAowPjp9rJwge6/ziWVwRWcXsxginF
 D2vN1iqAptSQ5/M23iPjih0y0KdRk1i/1VQs4Y4hV4w+XgAMDy1ulARlV5uf4abCVMeW
 G8cyEdZ9mrUfnDCQwWwOnF24VydtQbZl1IIgn7T/Otp70MXnNDrEiu+0Hcm5zj0VYWZf
 3AXk5kPL2mTcFbBaNQM4b9aNL+uXQ0qdtxBOC5hvKIAUFRYTw3tnjSIwtvcO3uZ5w+tf
 6ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771599982; x=1772204782;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1hee/oRg14qzKO8J1dGh3sIJ/MTM+zj3eJ1EYC0Ozf0=;
 b=RnAkh0Yjf9zUu6NQXSjLqBya41SB2zkJhWwCXTGC5/0gHWJ7lPei95K7w5VhG8kObU
 rGPRHNgo54pNg/y7dnQrU+jQDs3pxlOGf8+4YKshjwzxGJWxZZ6VVrpSFQzKr/YfEJ4h
 mpNTgY/DbELjPyjBrxGyXMDt+M7xJgRMbcnlgRXz5yEtRiiDRCLV/gF6LKHaUGvJbyrS
 3nd6M3yCBJ+2QyVBP0iUNcKWuAnJUtOyboaihLb9e3dFN69uqZT4IwzCRTeizxURvRwQ
 I+1PYQbTSxmqkkDBUeDQnRdLHZn0wt+jSDX+HGIuzBwKXqytaDnfbgpbXsFQpV06AR4M
 SJTA==
X-Gm-Message-State: AOJu0Yw2VOqm99T4a21BFeqEVI+bnJkY4UW1TDL1bzCc5+L2kvNvFB7L
 ZqimR5whqmSjW3KeGQr6mtp2SJ4zv8zfOtyhwc+NPAYFPodmD5f0gmaFG9dRaADJPhkkQkKCJ3v
 uAlW7
X-Gm-Gg: AZuq6aLmo6dM6sfl1C44Ppw53bdPen52BvYwsb8QLAUQlPEW4SmYBdfvRcav2nhsC4/
 EMpxt66XiObuOEnpdBlI/HQxdsO6aF1ODY4V+T9O85z9SvvdpfqHmsBtGmtvCzGD/SUSY67gsIb
 u0V70/rVN/pv6QeQJu0MleLKw7G5MKNCVztzVXQCvNdE3CHNj0w8wBhSp3tMQGTLlwEL21THdnZ
 a8mFHxDsUUoXLKoxCGNoKX8r3GVJqo5unXbX1VZPJWkQvHPtAWo8b6Gj7nG0CX3B/P25swlaeIV
 kiWaet5AveiGUf1RYrGB4tyKFK13ApdnjxwdhqAQvLwzxsyKzJgxn2hYQ804CKyDRuVThNvz1xB
 Lc1L6mhcXjPxuIX1xLT+IKED0D5d6jqVJBwLp60C5C0qF80S8UV2/ReR5xb2sXXxNWceIIs1rrK
 oZ8TRQMI2Fja1Z4PXD0wsyQZ0=
X-Received: by 2002:a05:6402:1ec4:b0:65c:2120:4056 with SMTP id
 4fb4d7f45d1cf-65dbd376345mr4198687a12.15.1771599982390; 
 Fri, 20 Feb 2026 07:06:22 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad29df12sm5016718a12.14.2026.02.20.07.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 07:06:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C01875F838;
 Fri, 20 Feb 2026 15:06:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org
Subject: Re: Record/replay thread determinism
In-Reply-To: <aZhuzUi4P0-mB-FH@linaro.org> (Jim MacArthur's message of "Fri,
 20 Feb 2026 14:25:17 +0000")
References: <aZhuzUi4P0-mB-FH@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 20 Feb 2026 15:06:20 +0000
Message-ID: <87zf534fpv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> It looks like we have a solution to the RCU patch which was causing probl=
ems with the func-alpha-replay test (see 20260217-alpha-v1-0-0dcc708c9db3@r=
sg.ci.i.u-tokyo.ac.jp).
> While this was going on I spent a bit of time investigating repeatability=
 in record/replay and I think there may be broader problems with record & r=
eplay.
>
> While running the func-alpha-replay test we have two threads reading
> or writing the replay event log; the "main" thread running
> qemu_main_loop and the "RR" (round robin) thread running
> rr_cpu_thread_fn. Both of these use replay_mutex_lock() and bql_lock()
> to synchronize some actions. There's a third thread running RCU
> maintenance which also uses bql_lock(), but not replay_mutex_lock().
>
> replay_mutex_lock() has some extra logic to improve fairness of
> locking. This means that the first caller of replay_mutex_lock()
> should obtain the lock first. However, so far as I can see, this
> doesn't make the scheduling of the Main and RR threads deterministic.
> I have observed times when neither of those threads holds the lock,
> and as such, there's no way to predict which will call
> replay_mutex_lock() first. This means the ordering of events during
> either recording or replay is not deterministic.

The replay_lock was a kludge we added when we did the original
transition to multi-threaded TCG which involved nailing down the BQL
calls that had previously kept everything in sync.

However if we could keep all replay events in the single RR thread we
could get rid of replay lock because everything should behave serially.

> It is possible to alter the lock function such that the two threads
> will run in lockstep; see
> https://gitlab.com/jmacarthur/qemu-jmac-development/-/commits/jmac/replay=
-tick-tock
> for a rough demonstration. Adding this significantly reduced timeouts
> on func-alpha-replay; I can also see that the replay recordings are
> much more consistent from one recording to the next; typically
> diverging around the 380000th event, rather than the 20th event
> without this hack.
> This is not a good fix since it slows QEMU down significantly and may be =
prone to deadlocks, but I think this demonstrates that the current system i=
s not perfect.
>
> Do you agree with my analysis above? Is there something I've missed which=
 is meant to deterministically schedule these two threads?
>
> Jim MacArthur

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

