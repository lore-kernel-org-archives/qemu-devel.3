Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1581AE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZlL-0000u9-Kz; Wed, 08 Jan 2025 12:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVZlJ-0000tj-Ge
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:22:33 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVZlI-0005Zz-0J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:22:33 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so10410331a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736356950; x=1736961750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoyEssfuFe7qvhQw0cEYVUHywmaP1ZkY8kC4vZt676Y=;
 b=KjPgIK+BV/imRb5huiUwBKNwGqu3zhoYzrlvWUqjXVpn2hrQDWqFc075nlwmL50BSR
 Gt8S2pMevM+j2YarpUU0DKzSPkioXYyAm89Dg/iaCw5x0tRv1DutlTVgrrkEGMPV3ugB
 44QRj6/fknNvD6eo1oOQlHioBNtdS1zGDwkWquTueE4n6SPoMqq/2M6uM1MXVPtlQ+6F
 WyQ3oYcDnAd1YCnY1Xj5ukA5iaPm1Q7RnG2k9ZGrtoo85dwOiwSMHDkPTKZMNScVKfMS
 YhR4XVWyQ3NV5I3e0ilBNbhCSk5BWkShb3IttHmXSrUl8fnsOP5cC8jkaqyZmklKjZVb
 fgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736356950; x=1736961750;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XoyEssfuFe7qvhQw0cEYVUHywmaP1ZkY8kC4vZt676Y=;
 b=aPjRYsd320ko/BWmHBBxNRrRMLdUh5HIvF7cOwLWO6elEBUluDnbBHrCgH71XR5Q6S
 UxFKRi5z/kqHDkAmmkK7f2XLJ7FQnYXjzEy7FAdprZdDeeGsdVDUkhiAghoZXyjQxkSw
 VdtDP6gxKdt+waj+tKfGYa6zP36VvE/AMVnZ0Uld+1HOtzQXAnSikbi81nEOi6hv6NvA
 S0fPTjnzTK5YG1zNu0kJDTXsjOPwnVuyFV4B6Qw/YHxr4jckd/7oKlKAn1cJds4ia0o7
 GG5cE1Qs+miIj4CaAh9FY2eMjm2X89DxaT05pIBzArDcV2wVc51xv1m6ihnyfnL9SAfy
 Z45Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPyVBw/9CqlMXvyEvtYLXGGUX/Uq9svNjPep8b+iE9scDT8NFqUMEUgaW2qjoawfzh6aqBCJ+/nt+8@nongnu.org
X-Gm-Message-State: AOJu0Yx5eJO7SYJuytgzuGiqJ6/Ohpxst16KYM/M1H+647svHF+juj0r
 Jaev/ySzHL+5hUC4FZ89WeArZKw5/C8oH/SNRZYnkky9KIhrj9vAtQq2R6WQnaw=
X-Gm-Gg: ASbGncvTjU2PcWTGuCvwxY9/OV1wu+gv6oYKqaVtujDENjxxgu9OfBozju1Z4AwGAcM
 EAhLdcSXePtUmBMerA9bNsZbXxYIUMbl0XheNNjaeoXLZWZqYS68tfJhZgrh3YveUmgKfpQXHSN
 IkJlNV3Ao574T9Nq+IGOLYAaAuuZ4TWEqtSIwPq0n0t5BP/aIh8qz7Lj/8IPLPnaP8JDSrt/1sG
 QoP7FColmTXMgkkPCGwCT2vhj5FYnqNQPlJ/InoMV649ePLU190y38=
X-Google-Smtp-Source: AGHT+IG1KOcdPm2tw3ljyv/aqeDrEVtuhvQXkLKnSHNFX0bulZkLPqNerYWNekONR27k0J0wiowNKQ==
X-Received: by 2002:a05:6402:50d4:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5d972e6460emr3523275a12.26.1736356949693; 
 Wed, 08 Jan 2025 09:22:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d95a597faesm2780511a12.52.2025.01.08.09.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:22:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4D525F8AC;
 Wed,  8 Jan 2025 17:22:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 8/8] tests/tcg: Add late gdbstub attach test
In-Reply-To: <20241216123412.77450-9-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 16 Dec 2024 13:33:26 +0100")
References: <20241216123412.77450-1-iii@linux.ibm.com>
 <20241216123412.77450-9-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 17:22:27 +0000
Message-ID: <87ikqp9q5o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Add a small test to prevent regressions.
> Make sure that host_interrupt_signal is not visible to the guest.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

