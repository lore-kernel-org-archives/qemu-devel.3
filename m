Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD7C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw2L-0003Au-KT; Fri, 16 Feb 2024 06:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1raw27-0001wv-NM
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1raw23-0001Id-EX
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:31 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4124d8f9915so2091025e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081525; x=1708686325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuH9hqTqNDDFmXccRjofPIgFAMpQ8zGYoJVwZaguqNQ=;
 b=NW71z4t08zst/w+yEksGXPB2RCAIHfAsqgWEywICqLtDvPGXHX/kRMURewo35vKwQ2
 OTtaijcTkBbcM4mg+W9kxoE25n1glqGDK/ByE3u3kZrHp5dpRKqY3++o8mzfX0fgnmK1
 ETI9W5ue+2aYWPXwCRQDrOzR7zYyIG6ZEsIgl/qfiYt7en2QWjIV+Q3mpP0mxjQjuZD4
 1llkHj8fVXdEpDtk+67cmLsIy3PY1fcWjdIsMbUMg9USCNER5CSBPRH1izI16/gDAuMG
 t5If/a51csUbu3QvVKNq4sxAiHNXcjj1NwVyc0Hj+f59ELPrUWzREXx6WwGxBbvsNQbd
 cdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081525; x=1708686325;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VuH9hqTqNDDFmXccRjofPIgFAMpQ8zGYoJVwZaguqNQ=;
 b=rNgfWiv51O5FEGkYugQYQI0e7xef0rwlCyCW8WSNfu71+uOoBd7BVARjy0xdr23o2l
 FILTqv0v5bRGBM+fQDNqZtlOleuPYY56fEOb8L4YFo+M0RZZmYrjH/nEeyjcABDm5ooB
 7K1mwGYsG32F55rSXZf7LrGBBsu9V0jbJrV2MW6ejVYRdymFWwyJRqvRzsWPdg6SH5Ic
 NInt/3k/7W+vIe/8lH0q4izHT3oIJv2oL39EpXSOA95GZHwTLJi1ZKmsHUzDEY9Sx+d0
 YRZ1pvgIiwkn8lbtoIP/iOeO/gMRJze1k+E9Wgtp7OMFMQpwHqPs8RvVuZyKylM1wla5
 cyVw==
X-Gm-Message-State: AOJu0Ywd9hKZSOcGyJU74cdzh3yUKlY03rPijTD2BCRVqMLnrpivTD1V
 7jkGS74pRrI+imCBdsvJ6zzrFQvRol0l0Ilw/ja5jd9uuOQ3UyteIU43kQflKZk=
X-Google-Smtp-Source: AGHT+IFUTiVmn+hgnh5vt4fHQ7e8VGyF1snmLvQgURFSHojA2uIGQrJcn7hcu/LA6AKGbVcihYwGhg==
X-Received: by 2002:a05:600c:a15:b0:411:fc83:b10 with SMTP id
 z21-20020a05600c0a1500b00411fc830b10mr3339609wmp.34.1708081525459; 
 Fri, 16 Feb 2024 03:05:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h5-20020a05600c350500b004124219a8c9sm1647110wmq.32.2024.02.16.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:05:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CBFD5F7B1;
 Fri, 16 Feb 2024 11:05:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  amonakov@ispras.ru,  mmromanov@ispras.ru
Subject: Re: [RFC PATCH v4 10/10] util/bufferiszero: Add sve acceleration
 for aarch64
In-Reply-To: <20240215081449.848220-11-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 14 Feb 2024 22:14:49 -1000")
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-11-richard.henderson@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 11:05:24 +0000
Message-ID: <87a5o06557.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> RFC because I've not benchmarked this on real hw, only run it
> through qemu for validation.
>
<snip>
>=20=20
> +#ifdef CONFIG_SVE_OPT
> +static unsigned accel_index;
> +static void __attribute__((constructor)) init_accel(void)
> +{
> +    accel_index =3D (cpuinfo & CPUINFO_SVE ? 2 : 1);
> +    buffer_is_zero_accel =3D accel_table[accel_index];
> +}

This really needs to be:

  -    accel_index =3D (cpuinfo & CPUINFO_SVE ? 2 : 1);
  +    unsigned info =3D cpuinfo_init();
  +    accel_index =3D (info & CPUINFO_SVE ? 2 : 1);

because otherwise you are relying on constructor initialisation order
and on the Graviton 3 I built on it wasn't detecting the SVE. With that I
get this from "perf record ./tests/unit/test-bufferiszero -m thorough"

  51.17%  test-bufferisze  test-bufferiszero      [.] buffer_is_zero_sve
  18.92%  test-bufferisze  test-bufferiszero      [.] buffer_is_zero_simd
  18.02%  test-bufferisze  test-bufferiszero      [.] buffer_is_zero_int_ge=
256
   7.67%  test-bufferisze  test-bufferiszero      [.] buffer_is_zero_ool
   4.09%  test-bufferisze  test-bufferiszero      [.] test_1

but as I mentioned before it would be nice to have a proper benchmark
for the buffer utils as I'm sure the unit test would be prone to noise.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

