Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F49C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teujG-00054Z-Ej; Mon, 03 Feb 2025 06:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teujF-000541-Bn
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:35:01 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teujD-0006lF-Q3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:35:01 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaec111762bso326419066b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738582498; x=1739187298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8w3pOZAB8D6n0ucDau7LHGqvqe6lncE65qhj7MpIdXg=;
 b=Y/xK52vPkiuBg221wzYIDiyhz8H3La0QZLNHC5DkDpJaeh8MNU4GyODIflEP+r72IF
 DJNSpgXQ5tClRX/jJuIxJqSgrmJa6jCBq8YOnD6y67Rm0OR38dNcB75582GGuDoOPL6A
 /Ay27f3aNKWPwWbCGRfGlKGeN3+TW7uA0IilWgck/mnsp4f12/kUktzeYyXxwOF+Bzck
 aLWmHekKva4MUUSH/myRPhzG74N4/jgpL+Jdtif/jEED6PqRHxxlzpJ2xOQcD3t6n616
 IrHsFuqZxFyCSRDesfJc6N7GkjovEVIzVmbRyUgyyMgIM4yJBRTW2Y/1GOgxeLwAyKMh
 tE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738582498; x=1739187298;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8w3pOZAB8D6n0ucDau7LHGqvqe6lncE65qhj7MpIdXg=;
 b=XYYcG10aixe6uIe59Vut/GlMEhqo5HeSA17DFJftOfDfBKnSf89BsWwS10AqdrSQkI
 1U/JcejPuR584S0F+fgYkjDB6npBc6NDuGVchnP9/IN5Iudu5sWHyRs1YfMAeiI8FzeU
 u2oTi4xbHzLgS2SOEkjIaBPYxQEREGFN5ow7MjOCAOkcdE2VjpnmTWr338X4q8CqI+fA
 kXZJQWi0kfVM7SVW+QEu0EEyf9rJbGj+gCRlj87LAjaw6HbfVkBcqn4yiRx70JRf5h5u
 B/NXXoDfratPHaJ/1egqZJP/sU8folZW3Hrmp8v2X0houZZI59EJXiPPB1u/5h17qtjD
 7blQ==
X-Gm-Message-State: AOJu0YzgSjKyoZ7Gyy+3Wf2mGEwvE0tyXITymImxcVTZoBwaajyGeFFo
 UewO0FWsGc4LD5JUr3Low8hd13WBfry9bbjv6F7t14Nl9TuBbStSAa7NcDP5fyUac80x9zUtJRV
 AIQ0=
X-Gm-Gg: ASbGncsqpIlwF4e6Nh0pTOb5L/wZVvHZm8QaYQbJyhQPTbn3IMrB/nykkACcmlfI6+A
 IOdlJ9dT6yFhXH7WQtG3MFvy+0Ca3vxHTx3m/S0aAQzn+EXFoKBPjBIz1O14Lkb1j+0Ve2HYIFg
 KraplUy4hbTPUVT0FEJfBfTk8K5VNJyTRkVLijtdCkVu879dbXmCoTQ5uEi8A1RlNpde5yLWJ20
 YF75F4m8FVeF2axrEZKjk4MkuriKgGRDtnxHmI2bTqGxDUkSjmm6AnfGzUpfLYlii0ItYhm8AsS
 dneUaxvAV2HTsR5baA==
X-Google-Smtp-Source: AGHT+IGFEz16SrV6ZMnQ579B68guVFcpoUzR1otOzEnjZ/5xJHl0IHMF1/O0ZtmiOcheUVS1VXv4jg==
X-Received: by 2002:a17:907:7b89:b0:aa6:7ab4:4597 with SMTP id
 a640c23a62f3a-ab6cfdbdcb5mr2435419766b.39.1738582497943; 
 Mon, 03 Feb 2025 03:34:57 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ff968sm741134466b.111.2025.02.03.03.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:34:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0AC55F954;
 Mon,  3 Feb 2025 11:34:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 02/14] tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
In-Reply-To: <20250203031821.741477-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:09 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 11:34:56 +0000
Message-ID: <871pwffehr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

> These are not called so frequently as to be
> performance sensitive.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

