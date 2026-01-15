Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A855D44C51
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOYy-0001Wx-Ml; Thu, 15 Jan 2026 09:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgOYv-0001Ul-IA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:43:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgOYu-0000pY-2P
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:43:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so10562845e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768488178; x=1769092978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaRSJ9XAtqx6zjeKepX4g79IrpAT77TZ0Nl61eo2pMQ=;
 b=zlloEM4H4xTA2vnM7ApJlCg0MlG2+059viM3LshmCDt4h5Z9iHX/qBd1PsFWY1vGby
 +PQIkThXO54x9qaSAGW6XtR89SaA9xoi9/EsvpbvAS7SgxAPIx3laFN5lk8hjVnyQNI6
 a+KnBB3OmcRivPqgtZJ00FFPIV/uf84Cn9KtK75jN9lF39iOpILmn+vJJoZjkke5pIRW
 R50J0MytmspHvzdagZ3rG5tXz9Lww2oO8LcefCfdB6oNW/i0+9DGYGWDTnzkjHiBp5PT
 09jPWVbUNWFD7sumNZ/1QMnIxVYgQvGLXZwGlljVKr79zw1avJZXsnUsLVV7lA45zIUx
 4g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768488178; x=1769092978;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UaRSJ9XAtqx6zjeKepX4g79IrpAT77TZ0Nl61eo2pMQ=;
 b=gH8mf4MyQDjAgt0bA5gGGDBChjceAqOPlOlhNp3rIBbdqkIx3algLh1vXzXBr/aoGh
 gb41ggCK4DIIU7uhtJi8I+yguxJadqj04BPvnOYmbitdijf+Cdlw/iKrccF+4kzeuVYP
 Lygwr6e1tu/uICTHpTScYQIB6DJIC+KgAqXXlO8wAtUNhAFtxnblA2Ztf5ZOCem7VOP7
 oYz56BaQ9KXyyp3HwzvGILX0BpP3V+EjMfIdeuXmHB5Lk7cdmUyx+DqQGj8iEa9QsXRG
 FfqQgojwo4fykqYXMBmV01NxslCVoS4NEbFBS2SoAh1uIBV7RdskIEM/mTzYa8iip4jR
 LzUA==
X-Gm-Message-State: AOJu0YxAJbDPhP+HsEnhz2o/i1schvG64iIB5LLQqiJS4uAZSrHmJvR7
 OahGaM3s1oQMbq4s/y7z/UxZy7n3QYygJZMleQI7wCGXdXcQkTKCFaUwwYidkZD4vOk=
X-Gm-Gg: AY/fxX4Pq2wUIipFTwIxEfACJrxzyKDpuIm0zNAgsTVFiOK0VlfgyzxfiN9LaB5BeTY
 laXCx6WI6dncESuctfHqm3zLDCz7Kw+cot+n1UGxVBlPO288agV5EY7UtXtIjkcUQhPEPdSSzyZ
 kz3LV+MIBWnnuX/iqnDP2AFBgrebCqIUl6qnxhzr69EoQM6X/5DUXAnwKfxXP1THu4x7f4kk6Tb
 p1x8rlHAjJB+WVVqKCFkFtPf0JgOvYl+y8qaVBsaKRFihhnvgsPXjW/CARbGsItYyIyWDF9gWAX
 LUZwGHC0uWzPTbPPBtZ4RbbhMCerC2XcqbH5wUp3mhymNbVvuLC2oxDwoGuln9QOZCEtlkrTxBR
 nsQsGsTvLy2owb5yJarj/UTTf5uBuZ3UyhQsZCtP7OUKLLEXXBwwxtcUPzv4ijuj7uUAHHQFng+
 4+7NmccUMpV60=
X-Received: by 2002:a05:600c:548c:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-47ee32e09a8mr72377205e9.1.1768488177996; 
 Thu, 15 Jan 2026 06:42:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee2840dc0sm43868865e9.13.2026.01.15.06.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:42:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91E665F88E;
 Thu, 15 Jan 2026 14:42:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Edgar E.
 Iglesias"
 <edgar.iglesias@gmail.com>,  Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 0/4] docs: Remove bogus mailto links, minor cleanups
In-Reply-To: <20260115142629.665319-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 15 Jan 2026 14:26:25 +0000")
References: <20260115142629.665319-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 14:42:56 +0000
Message-ID: <87ikd3hr7z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> I noticed while reviewing a patch to add documentation for
> a new Arm board that an unescaped '@' character resulted in
> an unintended mailto: hyperlink. This prompted me to grep
> to see if we had any others of those, which we do. This
> series fixes them, plus some other things I noticed along
> the way.

For series:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

