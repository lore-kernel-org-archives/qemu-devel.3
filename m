Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3D1C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NG6-0007og-1K; Mon, 14 Apr 2025 13:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4NG3-0007mc-S4
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:06:07 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4NG1-0002rQ-RJ
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:06:07 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-86192b6946eso54453339f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744650364; x=1745255164; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eoRmx5jWFwxR3IrS9Xpnp+5w0xVSuvU72mNWfqm4P4Q=;
 b=a0UzrIvaQ3xnWBSxsPrgRtTcOCGCGj3bIgYwq8KENhd2wCSABCpbEnQkuUqNzqwsEI
 YCR4FdIdNXjXMId7zeehizW7DcXG4EK7axuQC+4qJLS5KbZPsNsCRJHbRNNtT0FGqZxy
 6gmdWXOfryTDVF+n1E93HstCaehCisCSpYIGd1Y8dXIOUFcp6NyTfSE0HVIVlvVADlNE
 0g82apoFM2mpQPsZlRSb+bw2ArjonFw8NqBdYSHF+GaR29pIVLIhBcj2ltCADlTlRdFQ
 4/kELzfy1bBConU7xmsR/q1qVlr+T3Z7OMjxaAoh+2szy5Rsij659lkGAxmo5auQ4X0M
 34nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744650364; x=1745255164;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eoRmx5jWFwxR3IrS9Xpnp+5w0xVSuvU72mNWfqm4P4Q=;
 b=sr077/XekcreHdFRFueuh+EdWKczqrX8avqJhbyDeRlnZR2xqtI++uiYsXGiA3bpbL
 wzqlS9pKByF3Yl/fxz6FOXPDGLmIzfnv6qaTzKUvg2vAlB+fJ++cD1w33+gaiLEJLZgd
 DJOLI3JY3dqYJ8yPSb48gqrbHjwWwFSGIiu1e8ET86mFccJfTR8p1eMOMAI2hEHVYqRb
 UquDKCGYQgxEP7vr3xtTihHO9mRq/IS4kMX+2C/6M9UuajoLy+AmOXu+ahHreOHiKbvV
 V4N7aEByIqRse2FsJwZt3sho315OoGDfITJx1u//G1hta8kVqIoOqS7rPh/pvLRI/1Vw
 kZow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf9tJJeQrhXm89XU2/UDfu7DiD0nh6foelXAZvFPNfFsGBu8zzcZJvuVcBYBwUAUuG9XqgLnjM0hdB@nongnu.org
X-Gm-Message-State: AOJu0YwP753uTbSSThQP7f7NV8TwyOGvHi/lD19OjvgFBbT6XofVh6yk
 Q2w+ujCgYkCQRaqyY3moca7Y1E/G+UO9hSQG7moAf0wBV8A9w0K9
X-Gm-Gg: ASbGnctxfo0worK+Kl7KkNFMCap0pSflF3pAUUR2sjjolSqUe7mGwpSn6Jqawbomw6Z
 JwvvykGPgeTUDEehOK7ccLxnOLC6qZy5KaWnEfFUhiPn7GlkTp1MMYI70ugUh5YuYUYHpgt5QvY
 9VaSb9LUUfs/d5rW0R2sA5uVPTz0IhXx2jY5UMcVQE0FijeU9TvtmhHD1TW0HBKJ6uJ7b3VYjyv
 4wO8vfG+rrptZyTg9A8+GyfzvZoQlMh44rp//eXdmA1iKCi3sghT2QtfHTimSaL9rd2rYB8XxK8
 2qXw8hNZrFzy4JuWetW+cqIWVM8xjDgjPJcd3opjZmdtEvIz+9YRWoHUCv11kuwQJ+AnF4QRG2g
 =
X-Google-Smtp-Source: AGHT+IH6Xkd4CnbCM4ag2+BNz+dDkKaLVQN/tEYhF5eAeiXA3IKCbU+6Thnnhvdm46F/Cj6mjQGApQ==
X-Received: by 2002:a05:6602:4803:b0:85d:badb:a42e with SMTP id
 ca18e2360f4ac-8617cc66166mr1673846439f.14.1744650364000; 
 Mon, 14 Apr 2025 10:06:04 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d16a79sm2701808173.50.2025.04.14.10.06.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Apr 2025 10:06:03 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250407192705.2605614-5-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH v3 4/5] target/hexagon:
 s/pkt_has_store/pkt_has_scalar_store
Date: Mon, 14 Apr 2025 11:06:00 -0600
Message-ID: <058401dbad5f$80ec26a0$82c473e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxbseScfkce8xHjxBW05Q6egvQNQHhzKT0tGjSpQA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250414-0, 4/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Monday, April 7, 2025 1:27 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH v3 4/5] target/hexagon:
> s/pkt_has_store/pkt_has_scalar_store
>=20
> To remove any confusion with HVX or other potential store =
instructions, we'll
> qualify this context var with "scalar".
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/idef-parser/README.rst       | 2 +-
>  target/hexagon/insn.h                       | 4 ++--
>  target/hexagon/macros.h                     | 8 ++++----
>  target/hexagon/decode.c                     | 4 ++--
>  target/hexagon/genptr.c                     | 3 ++-
>  target/hexagon/idef-parser/parser-helpers.c | 4 ++--
>  target/hexagon/op_helper.c                  | 4 ++--
>  target/hexagon/translate.c                  | 9 +++++----
>  target/hexagon/gen_helper_funcs.py          | 2 +-
>  9 files changed, 21 insertions(+), 19 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



