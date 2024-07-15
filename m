Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0A4C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTI6K-0002Yh-EB; Mon, 15 Jul 2024 05:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTI6G-0002X5-QN
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:34:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTI6F-0003vK-7S
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:34:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a797c62565aso428124666b.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036065; x=1721640865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l3gzntefYhV39WsljDzZGId+IBzavZQfJWtPqLQ8scc=;
 b=uLACAsptQe5Sl3cLkoHk6Ge2L07dqmffML+1Lqj166xb63NW0uv34easSm0uvTYedi
 ACwWkpn4CEbNW6N9/ZYQZ+i4alDPi/bFGuw8nlfw18U08MYdyRBFi5aUfTcPFkJ66L8j
 XrrTyR0lNlHi20oMsDwfn71WkAQWn1Kn5gs2HTZElnUvh9E7XM9XWZukCJYuicj/FUH5
 D+rWpEuIL9Or2hAFcxL5e4bgkl2IHCS1MG9bxWXffGogugcjsMW7nxK3PXq6D+v94NxR
 6VyAe3i16QTkQ1Dh6NTlqcblufJ9OYiM/YzLNX4+riqU+HCVSAG3y1UUOoBcTXNgE/m1
 3jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036065; x=1721640865;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3gzntefYhV39WsljDzZGId+IBzavZQfJWtPqLQ8scc=;
 b=wls9GifDodbA06WKZcUhl74IKLANzQYQWhVeqWT0TMNWJpcgb+a0QI0l6Ij8205mCa
 9FIviFQsXH3F2qP3lR5ttuNYPuaXhrTOF0Q3cYYSyYFWL6HbiwIp/fFaq8K4KaOpM30q
 w3JMkI4LiNZAK8p+P0IT++jEghO99TKWaZP8KgChKDB01k9H22jW5Y+0buGrO9rYPDL9
 y1gKAfwOjqMFFp6J6U13ZgUaozkIvTqxm2OXY8kLn98M2uxY8xhDZjCG9wB2DzJi/NT2
 UyoRMFxO7RmJB2BIbXQBWYGlCrG7gVgdbrjqSH8Elk8AZDaAfyVVCXgxX9hxQ+E420YX
 +B+w==
X-Gm-Message-State: AOJu0YzRqCR8gf69DFE2KDi4mahDN5MccikW8KfocavNAFqmpPg6gBPe
 V3OI5WtSj8JfW6/Izak2C6mDJDJ9mNDCQ1Yq7LOv2OlCndm1J7NhtVoXYbxLiFU=
X-Google-Smtp-Source: AGHT+IFnrXOmHdgIyAIpu+/J/66F3VCT5Yl2/kZ1WTB6gJbfe8H2SyamE2KUNIUuYaom7dQaHf2Qbw==
X-Received: by 2002:a17:907:3f8a:b0:a77:da14:840a with SMTP id
 a640c23a62f3a-a780b89ec89mr1491756266b.69.1721036065037; 
 Mon, 15 Jul 2024 02:34:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7ff775sm199031066b.171.2024.07.15.02.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 02:34:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A7625F8CC;
 Mon, 15 Jul 2024 10:34:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  danikhan632@git.sr.ht,  qemu-arm@nongnu.org,
 Daniyal Khan <danikhan632@gmail.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] target/arm: Use float_status copy in sme_fmopa_s
In-Reply-To: <20240715055820.319035-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Jul 2024 15:58:18 +1000")
References: <20240715055820.319035-1-richard.henderson@linaro.org>
 <20240715055820.319035-2-richard.henderson@linaro.org>
Date: Mon, 15 Jul 2024 10:34:23 +0100
Message-ID: <87wmlnhucg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> From: Daniyal Khan <danikhan632@gmail.com>
>
> We made a copy above because the fp exception flags
> are not propagated back to the FPST register, but
> then failed to use the copy.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 558e956c719 ("target/arm: Implement FMOPA, FMOPS (non-widening)")
> Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
> [rth: Split from a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

