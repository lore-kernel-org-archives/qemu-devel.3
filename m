Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD23C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgQk-0005GI-Fo; Thu, 30 May 2024 10:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgQi-0005F8-K6
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:06:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgQg-0000mf-MX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:06:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35dca73095aso533997f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078013; x=1717682813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u/KokNqw+9saHYGEYOOZJB7Qg5jKvekYzZO4t+TV4nM=;
 b=v654au7dTcx4LRCr03rQUB77fTBgJurEQHMzJFwMSsc1jJjtJUw3tc2mG26uQPiE47
 gp9kY1Sk0SE9VUGbpVwkxHL7EyodYTMTya4CaWtNN7SElJTc/z+1H0i5z08W/PoJb40K
 MfK42yGuNoMgCSK8nZ+qOKLeAWgsFOiJByqqDwZTUHkA7dkJWInCeGq1d77d3MkVy3o6
 HmKB7PuFRG4c+rCFAdi1PJx69oq7beivOXSgZ3Rb6GR5OU/D/kI7BZg4mkrOXkHT14dr
 boZWa0Y24/Sqf+oAdC0DwBlDN2YzDk2iDtjYJXDDASwGpqrMq65hmP/tJWdMJA9j3mFm
 zXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078013; x=1717682813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/KokNqw+9saHYGEYOOZJB7Qg5jKvekYzZO4t+TV4nM=;
 b=vteXw6GQdqocJQ2pueKGT2M6VxBskgHZzKdTH3R/IigZpaUbPKyiRZDmW35e0sLKc1
 pacEfvqBdWh+DUoiCOttB3pHsJJI6JCcmm1cX8+w6Tf1gTcSzbIO1JS1xaowE3GJCvvB
 kjaOgzD6jcY8l3+H7smoOO8xfsMPgoXDhGuQr4W/azeVNCJx+MiYhxcyNORfpGJDiTdH
 vTMx6zn0e+GwLziXnYEmQBUo1vUimOYADoJyTp4nNitFiIUUxyWBds7Yb8Zdp1pJloNb
 f6p8slvSiGJ9Ah9l0XffL7Li+21JLBrcmWwF5TuRKQiPczvRd0erpI0O+E+aYIr1IQBg
 DgMA==
X-Gm-Message-State: AOJu0Yx1I6Nx6nOhJyK3SmuVyTaXdH1GhjOYCwgvjR1k4ih4HyCFtPXr
 l/tE4VN7fKxfAUmHCLnUvGknKfO6Td7yZsHZHDW8sFenbvg0TTxyXkCqMpj9ip/HLTEfwkKYcOT
 ICTTSc6Oxf6YqzF9gbLRCJI7sDJso6dY6zRd5RA==
X-Google-Smtp-Source: AGHT+IGmezAIOfPGAcaDFcjE7SjbJb71CGbtltk/RstRbxY2G/0/5j9NGkHuNNx+NEF8QOSsqLzUzO/q9Dna+HsG2YQ=
X-Received: by 2002:a5d:4dce:0:b0:354:fbc8:1d90 with SMTP id
 ffacd0b85a97d-35dc00bdd31mr1538121f8f.43.1717078012742; Thu, 30 May 2024
 07:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
 <20240528203044.612851-33-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:06:41 +0100
Message-ID: <CAFEAcA8RJxUGZn1QcZ9WZ+9e597UQFzxSJyxgPSE2gB2zCxnKg@mail.gmail.com>
Subject: Re: [PATCH v3 32/33] target/arm: Convert FMADD, FMSUB, FNMADD, FNMSUB
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

On Tue, 28 May 2024 at 21:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the only instructions in the 3 source scalar class.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

