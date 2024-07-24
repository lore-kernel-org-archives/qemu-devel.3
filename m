Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34753C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZaJ-0007d1-MU; Wed, 24 Jul 2024 06:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWZaI-0007cW-3b
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:51:02 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWZaF-00062V-4X
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:51:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so102129766b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721818257; x=1722423057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p24L1RDES0CGjFt0iFMSuvm3LLDFAMPTuMUwRZl/AOU=;
 b=yWTk66lVRCZquZJWtS1os/fkoZo07zljQlV281iuvjbto636/FpMrpya6OuaRfeJsf
 BfnnzIHdGGz9boxR2LqMMRumECxKTCJHG9bSsd27FFNbI1jxbjlOkFgwWNxxSVV6heIP
 EIQRg0tU6HGFc+ynniYIFd64Mz0QsXVbfExrIzh4LvWhWtAcZdp7yKhtWetBpQeG4v2L
 AZs0CZ4aVFjEDTgzfwd8GUVr2UnwMgqUiGZ8i52bMMw/1kuz5g64Pnu2ZTBCtg+qgS1c
 9H7BnjhD//PT1E2VKwFn0nEagtyTpecLM7aODPuQd6laqwtGnxmHaVTJGr9eT3b+oZvc
 QvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721818257; x=1722423057;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p24L1RDES0CGjFt0iFMSuvm3LLDFAMPTuMUwRZl/AOU=;
 b=iBNFlQL0gpd1Ot8JWDA/dD3s6LtLxjdUXcCOw9Iso/5O0qtVnuHYAzOdVwKKIrtTTT
 vB0ZS4uqYYILKZBiS0V2RJD0iKlnGnKxTtgQDBly/XtJKD71Zi5E+12137kQR5dPTNvI
 dZsxkRAdqagMzr47SLiqqKnNxYTRBZaJwAllWQPb9IlIuEklnAqvWcZsl4STYO7cpjj8
 N4eC4K66j9nNGtdnxp6Lt2RXNQ30B10V4VeuA6I4UPxzuc/4EV3u/wPjsO51TVbm7fuu
 Fe5m/A5D5aAxIUqkuXGP0vOIN0rbWpk4hdgRqYO8usQk37J4pfjtWfBexCRqtq7OAxDE
 9aow==
X-Gm-Message-State: AOJu0YwXhfda3rSw8bwzrrRF0owGFhXaZBxb8e253JleQyHbLTXLPIEe
 dt+CdlHoo56VlSgzJIwGPbRKqss13V4tjoDE9p/W0HOG35Dw7/udSktX+1mq5jIsfo59vGN66qd
 w
X-Google-Smtp-Source: AGHT+IE7BAZ4wz+Ja3j+64nD254bY0nI24KKqOPS7lGKUAQ3HC+ZrnbLbhWxXpODJQmRxcr3f1qSMA==
X-Received: by 2002:a17:906:dac4:b0:a7a:8378:625e with SMTP id
 a640c23a62f3a-a7a8378655fmr397335266b.26.1721818256981; 
 Wed, 24 Jul 2024 03:50:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a9aee8279sm161768666b.144.2024.07.24.03.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:50:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 985BD5F738;
 Wed, 24 Jul 2024 11:50:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] tests/tcg: Fix new cross-compiler warnings
In-Reply-To: <20240724010733.22129-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 24 Jul 2024 11:07:31 +1000")
References: <20240724010733.22129-1-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2024 11:50:55 +0100
Message-ID: <87sevzvzao.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> Recent updates to debian cross-compilers have enabled some
> new warnings by default, which encourage good behaviour for
> userland binaries.
>
> Neither are applicable for our system mode kernel images,
> but we do have a few userland tests that are affected.
>
> The --noexecstack assembler flag takes care of adding the
> appropriate .note.GNU-stack elf note for us, rather than
> writing a dozen lines of assembly template, and so is a
> true fix rather than merely disabling the linker warning.

Queued to maintainer/for-9.1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

