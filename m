Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9CEC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIcz-0008So-8B; Mon, 15 Jul 2024 06:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTIcx-0008O0-MY
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:08:15 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTIcu-0002E1-Sh
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:08:15 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7979c3ffb1so244460466b.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038091; x=1721642891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GP13fRwikpSSsa3FAOU0aqUwzV2spGvSDykYLSivG5Q=;
 b=xI6C85CZGxXvSWmNAYZAFGijr8JR80FK6BoCAE7bQYmX+g4xEEkeWR6MvCse4wBrPZ
 ddzC6Zr5w5Y/76dBE2KNuevG+eX7fHrS5vzIYVo8/8s0DNCEG72wyJMWqL9h7eePATeg
 suOwnimTPKsPefk19LsxV4e5nQeNGQhJkbZ++gPdRTDoqkaNQLrSZwg2ueC4GiBLEJOe
 2F+NsiP5VP5ycpAj4P0LqRKmvQHiVtxIuOOyODBijNwUDPGbmARrMNGYGCJo9rLDftbb
 aKo9mbuGiEy1CTMNmJv9K9Je7pVew6e8N/fyHX1kSsdkddk8i8aqoozB64VY/dE2BkmX
 hTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038091; x=1721642891;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GP13fRwikpSSsa3FAOU0aqUwzV2spGvSDykYLSivG5Q=;
 b=niG5tvq0olFnjQprYtJJEWmvgUB4aafle1sUV1LnWVk6mkGOsHt2wSUXpHeO+L/nkF
 jHePPny/knzZs7QIbZmz8r61/j/3YvdzT7T8psLTfY5lVDAHUmLpuarKZh9QmawbWSin
 SBylyLg+1dXUwajXDbcTrut+ARpi5klOArchu0rZIBXTdqcoFlyLBm1brRf2iOr7JoMK
 rqTYf1kaIOlgBHLMk5EKcS/5Ev39yvbPLD6i0llz9cZLKM/BYlpjbTLkvqR08NNjOyLe
 u6EOLe+8mrAyA+MMUgErmyNYIvAHaHcSuPpds7qRr3dLWWsKrbQZIJW/Ns9n2xalGyPe
 dB6w==
X-Gm-Message-State: AOJu0YxsjjbB5KlOLeWw+oFIIrG5Iue9c2RiP5Lj9Z8r0XE+3rlqpSs9
 j8cS/qOiZvk76rj/gRTX3z5Xa9dFirL6iFaAiRvX2Z4n5WAhfOVpbJjxV1UWFqM=
X-Google-Smtp-Source: AGHT+IEiabEfjnmw4tsj56/4r/z6qXA5zx0vAXLzkDNbP6KT5L3BLphjYdTYRdhkrQhxKDl/+CS5dw==
X-Received: by 2002:a05:6402:134f:b0:58d:77e0:5c29 with SMTP id
 4fb4d7f45d1cf-594bb181cb8mr14872633a12.10.1721038090087; 
 Mon, 15 Jul 2024 03:08:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b26f61fcasm3193419a12.86.2024.07.15.03.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7CD265F8CC;
 Mon, 15 Jul 2024 11:08:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  danikhan632@git.sr.ht,  qemu-arm@nongnu.org,
 Daniyal Khan <danikhan632@gmail.com>
Subject: Re: [PATCH 3/3] tests/tcg/aarch64: Add test cases for SME FMOPA
 (widening)
In-Reply-To: <20240715055820.319035-4-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Jul 2024 15:58:20 +1000")
References: <20240715055820.319035-1-richard.henderson@linaro.org>
 <20240715055820.319035-4-richard.henderson@linaro.org>
Date: Mon, 15 Jul 2024 11:08:08 +0100
Message-ID: <87o76zhss7.fsf@draig.linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
> Message-Id: 172090222034.13953.16888708708822922098-1@git.sr.ht
> [rth: Split test cases to separate patch, tidy assembly.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

