Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D273FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNX1-0006xP-7E; Thu, 03 Jul 2025 13:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNWz-0006x0-Pq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:15:29 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNWy-0002F0-5k
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:15:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0bde4d5c9so16167566b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751562926; x=1752167726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5N8nSpnR4RxglQ60znnX/pMBkyxkQSJtqq/Rd/PKb0=;
 b=DNjCxBtj64pd48ORtfIIFqHNKiQXT32d2zoUwp/XzxeBaA1B4rI44dnaxHwE0Q0Toi
 WdoQ5jo7mRnhTQNoaWZzlWqRjM0dHzBZQ84N6wehi1L1FE8y38BWTwfz6r4tJfZjLF4K
 xUk0OvKyaO6bvf5IkmrCYd9wXFjpt0aQunktBkVhNuXmJE6vhDp3yYO5CxQG+GvYO674
 SNWWLt079L9VQ3McGSuWug96zwBEx44IDjj7K2FCVaoWwYbm28/pOjAZ2yMiCu2RT1HQ
 u48AScS1yKBrBeoyPt8RiTTLs91i5bBNhGduUGB1FX87RUlWTBoHjKUI7qeklFRSfB0u
 4Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751562926; x=1752167726;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L5N8nSpnR4RxglQ60znnX/pMBkyxkQSJtqq/Rd/PKb0=;
 b=ELr8qEuxvh1wdNk1u2iTWKSwZwR/LoylHObHjw3QtcnEgvp1t/x4/58GHGsvoFpuND
 DHTGtHxNM6K7MlWHD9cgUk8ZkFSfzKIBQmCPmmfFUnMbWiKyLYDInbHEKU2r4bwQ2GLz
 w+ToZkUm685Tw4atpnYKZl9WP31Vcdcktjj53YrzKc+gfbxc2NvBG5pNHY3WTnUvkdZg
 6p5Mf2H3NV/s+cM6pZ8txMpqdXOT3y6uO2E1XRpoVpOVxuNrGyRd93oho3eB6d7MLsbe
 95BaJXJkKfIhv/KQ+wm1ysHVxh/Curktqcfp8IqBr+XBwiqzRWXCH0r8taJ1L5/e2n+v
 tSow==
X-Gm-Message-State: AOJu0YxARW+jh9lELTZlvHcy9AHBDXhNLywQFNZR+jXz7QXfUz0/KxS4
 MBoQ5b1JBpSe8+Wi/0Ol92PpZKdvpUMXA3MDqYMfGuU2PxL2ummMovtnA23x3TkiohE=
X-Gm-Gg: ASbGncurT8KrFawc9YN2aGTH6Fo63b0hMMWO4boG1DLQU/mJ04BxvGoQ/3Q+CE/8eLH
 ZPI5AsMMgjfY6qU3yH4hm+zasi8jGeKMfU35xz55SGNocjUzHomgsn+BcUC6pQnNulYO+rh/oqP
 CgXXUh93aSf6crwlzhL15Sxt/wL1K4zpMVq+CX2EyDEzRZXgo3X899qeu1DhM5dyQdQRMUME1My
 6xzWglWFm1zmFtdEE1AVvTV/yz77di8qMKELc/Vt3/cMam+ySUNpg44t2FAU1/y/3Cl1fQ4SyFp
 h7YPsLPXLtYhIEEBkdYR4dubkEkpRWOkNc0A8CErtdaoqXcBnBGW0H87gMNAwDx/veXS5bLCKg=
 =
X-Google-Smtp-Source: AGHT+IFxdd+rt+dg5AwxSQyWQPTdbRoSjlSqV26i8zNUUKQyuPNd/NWxqDPe0BmHD51UiZDGHLUWLg==
X-Received: by 2002:a17:907:9445:b0:ade:8634:7b24 with SMTP id
 a640c23a62f3a-ae3d83bee46mr429456566b.1.1751562925804; 
 Thu, 03 Jul 2025 10:15:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac630dsm8653966b.93.2025.07.03.10.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 10:15:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37AE85F8AE;
 Thu, 03 Jul 2025 18:15:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 93/97] target/arm: Implement FMOPA (non-widening) for
 fp16
In-Reply-To: <20250702123410.761208-94-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 2 Jul 2025 06:34:06 -0600")
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-94-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 03 Jul 2025 18:15:24 +0100
Message-ID: <871pqxci1f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

> From: Peter Maydell <peter.maydell@linaro.org>
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

