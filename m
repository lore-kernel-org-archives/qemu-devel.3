Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D34C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNXs-0007kr-Mx; Thu, 03 Jul 2025 13:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNXn-0007cl-P2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:16:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNXk-0002Mp-Np
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:16:19 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0df6f5758so12717466b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751562973; x=1752167773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5N8nSpnR4RxglQ60znnX/pMBkyxkQSJtqq/Rd/PKb0=;
 b=veP7gq6IDJSnurd9DP6fKYaoQBCPuNCGshlCKdsHMWqZhs33Z9O1gY7V92m+d00jXp
 JkeDF8JPjuMBY4TRlU2RLrMwY7vJXu6gyhuRJ57IX4PUBlULbDsEPXzPqHZ5ptWr8hSr
 gyh3/yrW7z+0EHzWJi21+X9autiRsT9SW++5loLMuW0eSw6R9ReoU24W+2v/hX9Ms52M
 9eSAQXUzldjjNoXc2Njd5rDxc16soMC9kTFBH4xWEyWpbgc2Du5U1YXHE8Z3yDE7KxMH
 O/h9akekbuq8gH77tmMUsv22lVEWAB3dhE8QJQhc+89m/18P1osNNbKxMWE390bWAPAX
 y1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751562973; x=1752167773;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L5N8nSpnR4RxglQ60znnX/pMBkyxkQSJtqq/Rd/PKb0=;
 b=mV3sszpFdmo7LugWUYIipcl6YK/13F3TwhLc79npOHb4A7VNmejtjeWX34TsFVnfhl
 3fsaFMaiyJ3z54ZQInH/ciHgtZAFEbpvttyT0ZfyAS+35shzlJqYpToRncqE3Lw9LZD/
 63bbj5ds/3HrdA8o2mcJPLMDUNaSS4HIxLsuxfQfcQ7zpayXk8gk/E+1sTxmdl3hnYqo
 c57mGYfbDRrGiMhGoA1N+dRcY5ALILX5n1PXQihECuPcFewQkoS/GXpPZKX5K8JQZiqS
 oK9yjqZ3EEzd/m2K8eXMjJtQpnhC4Y0KHFJ5k4qSfoDyirimmttoC35DencfSxaOJ6Er
 A0DQ==
X-Gm-Message-State: AOJu0YwIlT9Lk3UtXFkGx705tssVY3PJWrG6yvrM3aweXkUA48wZK83f
 FRtrTN0Vd0DFBSnNtn+ROKk8ZSblIKtKQD9PeWIPeodaw/L7uPnQbzXugNFJZb0g3Fo=
X-Gm-Gg: ASbGnctsPYBme348EFmxvy7NABSxwFFr5x+1FMdMcLTGezhW8f/GqcTFa8H5TtMae/b
 eQJlZ9sQ/w9vq/XRNNY8qM1YO2JAyaiDxIaPj60TSS5vcJk8VL7PLmJ/rbzRsX0F0ZM7kquGO0o
 V1dnWw/nAVKjZQhNrdWpAqvw8qmchDSe60CmHMn2No36bqmpuu/Xf5WHCtsH6L7bz65N9S5DPhj
 r3GgEAdF7Df3BUsppH+I0pr2MG24Ooj1+8txqOR3H726gba6t8qz4t/TzgD9DAHi8gWajEYdJhD
 NcK4nIvS64MPrkYuvf4LiKT6IUxzEWGuP5Z0XJ22rdpfVQmHUYPdFQefmr+UYP8=
X-Google-Smtp-Source: AGHT+IHt+jMvbNgDjY2ln/lOgAbxHw4Xnsp1eQgbbW/ku4g+ojOeEmnaAuGA7i20chwmFBiHJQlZQg==
X-Received: by 2002:a17:906:7309:b0:ae0:d798:2ebd with SMTP id
 a640c23a62f3a-ae3c2bb9a84mr803133266b.35.1751562973277; 
 Thu, 03 Jul 2025 10:16:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d91cdsm9912966b.22.2025.07.03.10.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 10:16:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD39E5F8AE;
 Thu, 03 Jul 2025 18:16:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 94/97] target/arm: Implement SME2 BFMOPA (non-widening)
In-Reply-To: <20250702123410.761208-95-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 2 Jul 2025 06:34:07 -0600")
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-95-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 03 Jul 2025 18:16:11 +0100
Message-ID: <87v7o9b3fo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

