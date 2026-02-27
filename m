Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0633EFEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxVB-0005bd-RF; Fri, 27 Feb 2026 08:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvxTp-0005Gr-5V
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:02:07 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvxTn-0003UM-NL
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:02:04 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9372552059so183171566b.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772197322; x=1772802122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsNhfzZjd6DPUii8Yi2NK0qbMTanpfGRAntrfOaZSLI=;
 b=ghaQ7D2RDBeuEMQGD6AgGTbnbwd4X11pBYzz65DU3xkBqcf2mxr+iljIN9iBQqCrot
 loF/Hpcoc6MXdC/JO4uKv8StS1x7Tqt8HX6QgsVWNtITvQUfW517ekS8uxlZU5uaH71O
 cPgv8RrvnfYWBRcBOA8KRbmJ7pshyE6QGDYtSYTgffZQV9SywFgZlXArZv1/gOCYzgXx
 XvZOGMzFLb7g6L3rKVZEjv75PGr0SYeb+w3VAoq1qeiGJVgGoD6zxY0cI3nxlWau3wOD
 VXbsbvzXXYzDId7+0CW3CDaBUDVdJ/4S3WzE7bfmyiHPQmEh3aNFTmJvjvdnWGSIBf1n
 rfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772197322; x=1772802122;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsNhfzZjd6DPUii8Yi2NK0qbMTanpfGRAntrfOaZSLI=;
 b=YwauYAirlsBSFKGv8pwEgaQb7yYc+zX5b+gb/fP4pgf3MuENRrgqsTbBPemLZmy5cN
 eIC+NNS4zB9NG6hE/vB69pfZ2A1MWX6sJq9U27Z1rNpbdg6Yju6mEQNvZd3F00e7IASC
 LE5Ca9H1m/J/DFlQ4b6mBR7/Hw7StdkPDXsAkdZglYykV2HqZ/AoSNVdzuPtrePaOcoc
 LZ3ibigcBKEYQMaxd9VyyABNL8b6JXA93xGt+CG6xlDIjDhy2UdxoJzlD0P+ydgKXwh5
 bWk6qJzhNdWNwA3fL0MO0guK2nBjzGUpTkG+l1Mve6frAbR4PG6rPS+2Fe/scjgNypb5
 1z0Q==
X-Gm-Message-State: AOJu0Yzs0X1mX7EMVpcjKD6+AZMB+GGjVic7B3P+0ou94I2UdWd9hhr7
 SokBn2gYzFiV83JEX7GwopHRYZq25bl/2n3LvBlA1AMrtX4wMh5ZWfn+x/I1XUKtoR4=
X-Gm-Gg: ATEYQzzBn4/Ztjgit1UbxVAx2ONcnOeK0cLUOD8qZNB2/JVl9ujE5WlcDFAkHKUrN9E
 SzGL5HnxjWPjxa4JRgWLgQUfJkD1WA8YxoDe5StQlsan/AIUHJlqbaSU8ksxclvLsez0mgdZfvX
 EF3sHvkWDigo/pGN4EU+XPYmYYg6KU/fNk83VBYG6Cgike3uAK+ShKEQgHBjqKxkVeVLCIDBT0F
 gXAVHr/9+kCVjzXAg5HKwYGqRfnRzskr0jWlu/ZPvFfoA5RYQXLX6cf9/izRnD2PAEqJyM/a4C/
 oj/P8JIxHBZvnZvEh8QAbcP7zjmvMJQcX/27xgquGYxRzgfEppKfosELH4mcv4kkZKURQkb/XGp
 A3ikyg/DwzDAlSm6G08prBpDzUgxHHUSnp7VYnfc53jxH1VDoO1VJFg54LDqDDh/R4qV6jJT/ND
 bNM7TPfMsWKZnzg4mYSVWUQG0=
X-Received: by 2002:a17:907:7f8a:b0:b8e:9a0:1bfb with SMTP id
 a640c23a62f3a-b93761736ffmr157989766b.0.1772197322112; 
 Fri, 27 Feb 2026 05:02:02 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ac546ddsm149388366b.20.2026.02.27.05.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:02:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96E0E5F7D1;
 Fri, 27 Feb 2026 13:01:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 2/4] gdbstub: Remove 'gdb-xml/' directory prefix in
 TARGET_XML_FILES
In-Reply-To: <20260227104314.81038-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 27 Feb 2026 11:43:12
 +0100")
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-3-philmd@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 27 Feb 2026 13:01:59 +0000
Message-ID: <87h5r2xrug.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> All GDB XML files are in the gdb-xml/ directory. No need to be
> so verbose in TARGET_XML_FILES, let meson prepend the directory.
>
> Except meson.build lines, this is a mechanical change done running:
>
>  $ sed -i -e s,gdb-xml/,,g $(git grep -l gdb-xml configs/targets/)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

