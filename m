Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2A4C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAY9I-0008O2-8T; Thu, 01 May 2025 13:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAY9H-0008NW-CP
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:56:39 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAY9F-0000kw-Qx
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:56:39 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6fead015247so11253467b3.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746122196; x=1746726996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRG7zlq4WEszYL2BgoS7wm8to68+4SVf1/D26dl+IXc=;
 b=wzfz0TjSU+9F+GtgT8dP668JZiY9qnD03ulpyfYM8T3lgXrathITCLNmVKG3cQcuoA
 FXVGCTpFjoxvaIELUvruEeoFoTe4p0JWQ/hCWC/toJca/ER9kk/1XrX3cVqj9uhOYqCa
 GE/rC66UUr7o7jvw0V2xG74dvOAKM2DQV4ErR3bM3ZwT3IqqongDixgq9hy9E5kgHBPI
 pA8s0E/LSNKH+Hc1JT8KE6kbv0yfsflIHG+2sTFFWjGllKPmo93NwH1cqK45Zri4TQY/
 3csn0mphv64ihlOqeGbn2Gy96psyU8PXSuZ5q6I7ga+Wno1eUTOOSg/f5YNn05h+oNPp
 FWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746122196; x=1746726996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRG7zlq4WEszYL2BgoS7wm8to68+4SVf1/D26dl+IXc=;
 b=GT6bb8WeilOILkUvBM0OvUjqCTb2QC9ss/ITeaacRncBYY9XyvYcot0i5EfVohoeAJ
 X8SGqoAbikvMhYEV86aIfPj7MzNQz2Th/3lHVxCKj9uSudPi2myyvaqQSF9G6sE4c7dB
 tAPZNORmFuWs7G5xPDlwiiOMcSk3JIDVDXkiJlW5S4wRxCW6KKywQEPD2BlHn2hAGGs6
 o73e70t2+zv+zc5jZiBeZ6aLXuIavP+dZybW6G3McdfzenwmtsRRqbNbCcC1BUeH3xYB
 vM45YpKtKn4JDxWm/JHWMbOEwOIj0hLYf1rxom8bf15fcQ0E8QiUyu2pTHIoXDJi+wNE
 NNlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjpnoMHcw/YBQa+mL1ic64E6zYzWC59FhOwVaQSSECO/q3MXjTdBeKyYN207odYVZn+jttKl+fGQJz@nongnu.org
X-Gm-Message-State: AOJu0Yw4wwNuwyyJVqdTNUKspu3buzxZrNl3boOvb5Bf6rUo0J/xHKKj
 6QClSQj5pfwQ65ZjJNNwB0m7a0KELAcPOXgsOSIiGO6MaqgipTu1dGRoj/jYt2dTd4jKeW+ZpKG
 bS15EDhFYfa806PgaNHPm63tdIPh8vbr/gxI+EQ==
X-Gm-Gg: ASbGnctrRrrVAvHAxq2lghOSSMR6O1vH+M/KDMTLs0+BLGe2R1Ekgedlb6Ix9ae+SjV
 qNQoGwQFt6LOpiYwVV5O51RrqG79kfzdse3HTE1zbcg5+IZY5q6FaHVGCEk7G7uJzd2JRQ33+7F
 8ZyBpxdQKNEsi0QZcEfJLdOSU=
X-Google-Smtp-Source: AGHT+IFr5hAV1J/mQa2t7PWrxNrgI3+IgVF8O+FuisCq04ldUpVSxwkXPOeqj2qFkA09Gnuq1R/Jq7ucQ+1gPxytNec=
X-Received: by 2002:a05:690c:7307:b0:708:bb8e:38b5 with SMTP id
 00721157ae682-708ced059c5mr3710767b3.8.1746122196519; Thu, 01 May 2025
 10:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
 <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
 <aBJJqtzQaTH_xcKK@redhat.com>
 <efbaccd1-9ef2-4aed-88ed-d6a2bcb7902b@linaro.org>
 <aBJP-_KJudesY_Pk@redhat.com>
 <f8ca0b3f-5a9a-4182-b0e0-352a90bd9374@linaro.org>
 <aBJSX6kcYQVM2hp7@redhat.com>
In-Reply-To: <aBJSX6kcYQVM2hp7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 May 2025 18:56:25 +0100
X-Gm-Features: ATxdqUGaMIgxbuhgJiL5KAqFAawm-OhsGjcwGUrIYCS5iAnQc-mkm36wvXt-mmQ
Message-ID: <CAFEAcA-G7exikg_qa7USDvfo0+ZTLUiymfDiqK6wLTZmebv4kQ@mail.gmail.com>
Subject: Re: Functional tests precache behaviour
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 30 Apr 2025 at 17:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> FWIW, if you want to run a specific test, personally don't use meson
> or make, as you can just invoke the file directly:
>
>  $ QEMU_TEST_QEMU_BINARY=3D./build/qemu-system-x86_64 \
>    PYTHONPATH=3D./python \
>    ./tests/functional/test_x86_cpu_model_versions.py

The rune in docs/devel says you also need to:
 * put tests/functional on the PYTHONPATH too
 * run from the build tree, not the source tree
 * run using the python binary in pyvenv/

So you can do this, but it's pretty clunky; I have to
look up the runes every time. It would be nice if there
was a wrapper to do this for you.

(Also it doesn't work if the thing you're trying to test
is "does this test pass within the meson test timeout" :-))

IIRC there is also a rune for "run a single test within make/meson",
but I forget what it is and docs/devel/testing/functional.rst
doesn't mention it.

thanks
-- PMM

