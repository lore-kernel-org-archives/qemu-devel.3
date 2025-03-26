Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2555BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txP23-0000rZ-Fr; Wed, 26 Mar 2025 07:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txP20-0000r9-OL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:34:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txP1y-0007MJ-Pk
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:34:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso69656225e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742988885; x=1743593685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akZ8qs/Xxsoa+xOxqgQwA81zDOR3vrkO5oeTxPGaEns=;
 b=eudo6uIOyzGhHjqxc3SEbgPjuDW4JHikglg78c2t9WhmycB/PL620Js3vd0XnTOAzw
 yslL2rzzY+mo5/Eixe1JWu0lX5QGfZYr7sBxo+yATkNz+be5GSGq8dv3llWBC+nFh9EY
 3SVc52jMLY3PC/gBAge0b1DMHz/6SbThqUD938uZMARieZxbt0o7amHkuFpcUGS7yD5u
 7derKVeSj2vfolB/C42Fdlfy0b+Mv2vFaPIBK7AjlUImERwpFc2XmAdGjMN3VXzRsgA1
 nz3cQ/bkNaLDNyEOGsg5K7LK7OJcySwz9NBoK77ACkle5r+LVzwhznl4hs3+TjUdJmrW
 sraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988885; x=1743593685;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=akZ8qs/Xxsoa+xOxqgQwA81zDOR3vrkO5oeTxPGaEns=;
 b=kdRUIllNe5n8wjEWXXW0Rz3WCavh8deTx52BlqdjCLjaJZhbvzl+v1etqGV7RCFC5F
 8I/iIUdaIkBn4Z74lTy+3CqaGXYwxyhnd58tDORw5SDkPQ8KDyCMdhcoRhiB0Hjs7Ro4
 ODCWlSs9ZubiKstToATBKtyb0ARyjs4ZKVOFYXCv3jDkhed0aMXXvvi0E0QQM2w0yutl
 JDGuRnbRe7yGG0LV4fTLufY/s2KopJb6HE5l9q8YiTEQ1fOG+NBYDPgpXgLEkQF+LF4h
 Ur3bt0s210qp2nQr1jOntypPrbWB9xVte2ou4DO4UkGjaOmCodL347ONdLB3EzlrwmvU
 nIaQ==
X-Gm-Message-State: AOJu0Yy2HMD8fn1ssOVtT1y3sKSp/Ycu63kYDXeA/D4Qa+293F8U1e5G
 JDhU3hSxDgwB3X06THesC6uXC57/Cj1Gmp+jS2cmO+8TcW8rwyqbqtDmCajwoy0=
X-Gm-Gg: ASbGnctEOIuAkZ7FvvJOBpoj9RWllmWhYvw6p7ZHQL2GVbeGCpUMWCZ1VPPyvUnYAbf
 20E12/CKNl1+CSnJJI4aCX3aq5U6ucXCXnuxLQEkDFMunRG4d1vZWE3IFkMzi+K6hzP3vKnAY4e
 F01u+/RI1cH5+LFUy+DMWo4b2RdG3oNyTfeEXaRBrJpbTIrVTYOM7iFBACK7jkq1Ry8Vqm7W63g
 vCGmZm0CwlOwSpcSAQde3mrHc1GH0mbz267YXBYtIkM7bDfOVDhclqPynOoRBgjFz9jCQvNKQnU
 DqICfxEEREZ7h03/zv2RqcjvFTbmhhPATKgOqPZu10wIvJsuBI8nVp4Ecw==
X-Google-Smtp-Source: AGHT+IHmZ9gycHok8LOPsKwQswa0qI1F8TgsTt0g3q1eysg0WtX+k2XQBeCWWtWmG00/z7XWtUJjIQ==
X-Received: by 2002:a05:600c:3491:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43d50a1d166mr193740315e9.19.1742988884876; 
 Wed, 26 Mar 2025 04:34:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fbd321esm182788655e9.0.2025.03.26.04.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 04:34:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 98A315F90B;
 Wed, 26 Mar 2025 11:34:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH-for-10.1] gdbstub/helpers: Remove ldtul_p() macro
 definitions
In-Reply-To: <20250325155543.95684-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 25 Mar 2025 16:55:43
 +0100")
References: <20250325155543.95684-1-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 26 Mar 2025 11:34:43 +0000
Message-ID: <87o6xo10vg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> There are no more use of ldtul_p() in the code base,
> remove the definitions.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to gdbstub/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

