Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E53C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 12:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ3ni-0004BS-Vj; Fri, 13 Jun 2025 08:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uQ3nQ-00047U-SC
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:46:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uQ3nO-0006wQ-FI
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:46:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c85so3244776a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749818768; x=1750423568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQJagXkci49tyvjLUWloAaO2UBfs82gKd43tfDDGdxA=;
 b=l4s+OnUaPoi7m3yGqjGCHcXRkMdxSGYaGwKGqIH1V766LACS3DvHw4lWVnxqV4bOWi
 e7Id50JRCkUoH7NBCIFWEjxllepaOjLavA5Sz7moBPyEKfW8HlIL4M4tFciX+QTbcrSR
 fhQXjAyzLk8gBn5J5cjy9+3mSpMLlCaekx3bfXjhg+OK0nURa0lItDQxPh+nahUgOXSD
 PRw/0xbE9a1jXadlp8UFo8T/86bCMfo0zrcUUY99dgep4FMSQMJ6B3e34lDgdxeBuIBh
 8UGGqvIvGK6Fsv6kShegnbpQT1xa0+t9QSPl16ZJxiYEvRTD6axY1bJWzLK9DK9T+1h0
 fQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749818768; x=1750423568;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pQJagXkci49tyvjLUWloAaO2UBfs82gKd43tfDDGdxA=;
 b=WxSQlxwxs1u3gFecVR2hamwtOUJ78NvSR4vF1bNH6l+YqO0DiJFD3lRMcHEDcfqEwe
 y5rDA17ATYICLdgvj4SCbCxfzqMjQTSBOVZGQo60wMcUN66X0vJ9SL7y7nMZ1zLHOO6y
 FTJzPy54i0pHzP7cmtsm8y7gXW7EOGOYvFcSjmGTie2DkaVjOczYhavdsIHSAKyLVL2R
 oics7Exqp3ynA1jfjejWHRZOcLrPg+OsRdm1mOhAdnf5XrIHBpEdjM9GhDXqsnhPXcwO
 JBduv1XEpiHfeIdpRky23W/8aY+jJtkdJ9yDBfTO2VOYnzX8LkxznO7nEl7JmjYXCj//
 onMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlH+zGTLNmUAwAfQVzlz6KUY/WP7xfP2Ozce7aTaZN0iQmGiJ8P0Oz4TLQtE53LFBksDtgS0ziyuem@nongnu.org
X-Gm-Message-State: AOJu0YxNVAZl7rUaw1ukb8mhlMcmE5Sflt3Ji4y+rj7n+1NHgEGTvoXI
 0RcwOUC26DKhl++c4jvHyUkxS20mJNDfNS4CDsmuWQYN27IsYX9QHKfHGZ+SSN34NUc=
X-Gm-Gg: ASbGncsnhtLifyWD3Gq36cmVzCLtXuDDRlQfxrQxrYUwas59KHwQzAS16MsKqXP3Yxa
 tDD06uWA73AtUxeeXbmO0Gm/hQ+5PN86hfuH9WRZD4rWDjJrQpnYo+GoTTB27houN+SXn5xB4f2
 6BbtxMG2928oW0S1UDlZ1bdOqoi/iTXq/BgoWKdSNoFYRVNTZgW5o6WL2eV3uyMamwV2fZhUBDB
 ALm9uKcjbxbe/Xpo9vfWDvNdGsJeB8IluyMndqDYxlTxKxnnNz8taaHEjIUL8UI3G1TxfUM1diV
 VM57G2hAxAOiQiCEchLV1/gox5FspPu/xcY/fz9kG0nONOGRmh65uTtoNSpUpOc=
X-Google-Smtp-Source: AGHT+IFmvRnbkPtJVMSjiTa3PBoX2pgXYHL5/HokYCXBXAvwDS1vYPGhwjVdWndVZ3EqB70XWd0O2w==
X-Received: by 2002:a05:6402:84f:b0:607:f55d:7c51 with SMTP id
 4fb4d7f45d1cf-608b49da467mr2590396a12.17.1749818768141; 
 Fri, 13 Jun 2025 05:46:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b48a8bf8sm1155699a12.11.2025.06.13.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 05:46:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB1A55F827;
 Fri, 13 Jun 2025 13:46:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org,
 Corentin GENDRE <cocotroupe20@gmail.com>
Subject: Re: [PATCH] hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
In-Reply-To: <20250605141801.1083266-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 5 Jun 2025 15:18:01 +0100")
References: <20250605141801.1083266-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 13 Jun 2025 13:46:06 +0100
Message-ID: <87y0tvhks1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The AN500 application note documents that it configures the Cortex-M7
> CPU to have 16 MPU regions. We weren't doing this in our emulation,
> so the CPU had only the default 8 MPU regions. Set the mpu-ns-regions
> property to 16 for this board.
>
> This bug doesn't affect any of the other board types we model in
> this source file, because they all use either the Cortex-M3 or
> Cortex-M4. Those CPUs do not have an RTL configurable number of
> MPU regions, and always provide 8 regions if the MPU is built in.


With the typo fix:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

