Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2421C54E69
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9pC-0006k0-0i; Mon, 18 Mar 2024 06:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9pA-0006jf-Dw
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:02:32 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9p8-0005Js-Ts
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:02:32 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so47896591fa.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756149; x=1711360949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMvKoy9V5bcSQrl5zQ/CxDXv6WUwmgbWdE7xSOCVh+c=;
 b=GdsVvf4d42gpbgaeLj8FMQTq+CrquEgTjZrR1vgm4BcrkaVNXfDiTzeNLBZ6X+dk5n
 BpXDfOEup2QCZx2bIOEM0iA+CKupxkOOkSTnbgrPtKxp2U89k8ccpeuqOYZKGjzaf2cW
 SkqcRnFZVy8M1s7XTpcQ4MKiHlZ5R8MxkjuBSKL7jlwKDo3PZGpmtNtsKX/2kSs9jMcA
 9WpOklC6njwJ55fd0H9sY7P5MwLyxRMOZ/4bNaV3mTYaHMos6PRNZc7bJ0oj2v+TrCC0
 Dms5w1cRNGQaXdaEjnu95uK8L3XHgtBYiwFGuBkSTigaBrm9kG0mlfYvWo1wnnPxVEPR
 V42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756149; x=1711360949;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LMvKoy9V5bcSQrl5zQ/CxDXv6WUwmgbWdE7xSOCVh+c=;
 b=SvL0DA8m1mjV9LA1baHwv+eA4FDeO8QLqQ+vYX2wLKU+NVRH/+IkmMwAB9CY3+qzlv
 cmENIuQzfqgImBw26lCA0TVM8we7f/U7SmnpSHgeDNzYIidG8l55ctCFc7HMRc5ccpt1
 5k3UQiutWj/WO+iNZu2DHa/qiCy2g2jQ9ZE3dxY/SCYiBeaGBfWsH0uO7kSQmbAzeLJb
 rNos+YfEjNFBuPp6pIGn5k1quIEM2RulmN9gf4K9QLknvETgrNH6GN8I9/QWw9fnxop/
 0kEyDbZ4GqNLxqhkMRGAbz6LCw7cUNpdqp7i4RnkKBMbZT4kTxwDr7YIuDFa5LvMr3f0
 xKTw==
X-Gm-Message-State: AOJu0Yz5vSY1niGAe8+ZCDXVVqlwufNMpq9uNltm0zd6J4zXm2wMYHmd
 15VmKmHDwUDvlc9bk17MJ+0aV3qlF/TSejy518mdRNKX/ALy/EQ1KQLxo2Q5IXw=
X-Google-Smtp-Source: AGHT+IG9FFQ1TEt1DaJXLzhkM7sBoYFVBMb7aUiffYbUa0GjsM9Zi19MC0i2+vsNyoZr2ZsXERUsVQ==
X-Received: by 2002:a2e:6a07:0:b0:2d4:5ce9:f909 with SMTP id
 f7-20020a2e6a07000000b002d45ce9f909mr7756275ljc.17.1710756148909; 
 Mon, 18 Mar 2024 03:02:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ds11-20020a0564021ccb00b005689baaae61sm4427194edb.26.2024.03.18.03.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 03:02:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 460CC5F88C;
 Mon, 18 Mar 2024 10:02:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 03/22] tcg: Pass function pointer to tcg_gen_call*
In-Reply-To: <20240316015720.3661236-4-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:01 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-4-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 10:02:28 +0000
Message-ID: <87il1joo23.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> For normal helpers, read the function pointer from the
> structure earlier.  For plugins, this will allow the
> function pointer to come from elsewhere.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

