Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE76DCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1en-0000eE-Mv; Mon, 17 Nov 2025 11:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vL1e5-0000WZ-QZ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:00:08 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vL1e0-0001Q1-B5
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:59:57 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78677ff31c2so37235797b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763395192; x=1763999992; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHTgpEzHUXz1adi5KE/ydBVHYXdO1GNQEdl0OMaSsWE=;
 b=qtMWrVVsbZa74zXsjKOpX1Xyf9pV8yEYDyJXbv3ixSi5hFsOlkNAR1pPq2/gBQAD/2
 kMKVn4odfL8b6JfVqgC14lTUBGrs6oSQ43oMmzMX/Rz3llMlg/x0bX3dZAAWfJPa7pWb
 fGGT8WP9k7V/e/vldv529NRQSUDc0ZNsAeINIxbMErQ3PBDeH1qiPTfiqId7b2un0Ht7
 Dpe5bWl3kUf4U0TlOUDkpmiCvlu1k4cobeDhstuQ986N/ZOAt0zXYHICWR/bJde4kXGZ
 HQHKP9MacRbRhDxHnKtvU0brCQoG+oH3aUrewixaUecj1rAO3/SeOHSLDO2Jsz8onP7t
 eUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763395192; x=1763999992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gHTgpEzHUXz1adi5KE/ydBVHYXdO1GNQEdl0OMaSsWE=;
 b=kuwpmz5vb7KV9+MRM7HW9gbzyEwKem/7leFhYgyW0YA0jZqkWcA4csl+rC1X3uibmA
 KGJIMUxOzZUz7fu+7QjbgxJfOGS/I34zh1dYxJo0+g66cX2/eTQGdMZJFrbJUQO0CCAP
 RMHMhlBAT06Kmq8ML0sjbH/la0zz1AVhwy/h5JdIH8rVPPium73hgYIdaTgwEpLZbUbo
 PYSXU8gKvoKM+F2JPuRedFuhgkoQg5G97UCIPMqCgfzWOvjVeou7Haq11B4vnuzicgZD
 ko8Rf7AjZ8810c9V078DlC8Q9xUeqjtKok0sx6a3eFoLrQJfpZhGeMWkjuwBcHy777Fk
 N65w==
X-Gm-Message-State: AOJu0YwaSND8ZKilbWaow8MK+Q2d9IDXofy62zkgt8oiLg3OQBbFb9Xn
 AC9HYelUBhtnwtt8/1xU9DXmrlLZTsg+hQJyDhERceZ/PoJ1/dLeYsSIlRpRmOcxklXtjwzpx0p
 h/vpi6TB1VMgoQD5ZKXAPzH740WNucjgKs0bLsPLVbw==
X-Gm-Gg: ASbGncsbvgqaKlfgB6OlHgY9k++PdpFwHLEdn3ZoLcceMA/8gFMSAcIjIlnIc1sgfmf
 FqEcLORehgh1okuOYaVU6POI9kXW+GnXspLoVI6ttckEKANjEH+Y/NrJMlVMx2Um6F+UVBGgO89
 0cqfGuVlCCYntUzDBNRNiYhkT7id3AD6IsKBDGnwgKRGnokpq25OKGC1WL9jrWbJuJwJx7gWdQO
 TyM7ui8x1VR+X5PV4kuVm1/rc6IrU8pK6xp4e/XYlhJYFGL08x9y5Stam6xKx5GkaqmGp28Hy5E
 SeAnQGA=
X-Google-Smtp-Source: AGHT+IEGLO/ClAuY29s2xR7oSDOkU3t5RgbnSsBgaSel7T4dRMslqbqi3exQa9lBMqONLyJl0QHuXTC5vk/gMiaagpE=
X-Received: by 2002:a05:690e:1587:20b0:641:f5bc:6975 with SMTP id
 956f58d0204a3-641f5bc702bmr5468164d50.81.1763395191880; Mon, 17 Nov 2025
 07:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20251117154154.79090-1-philmd@linaro.org>
In-Reply-To: <20251117154154.79090-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Nov 2025 15:59:40 +0000
X-Gm-Features: AWmQ_bm4lmcRXwYzzA-plWaP0voGQ_CQJZDi5xEDbFMNSCdGvzVWRZftu1A8Dsk
Message-ID: <CAFEAcA-e6fC6yaZP1WSV5qg6-LYYrSDFJik4yLPUPMUDjxQ39Q@mail.gmail.com>
Subject: Re: [PATCH-for-10.2 0/2] tcg: Remove support for 32-bit arm hosts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 17 Nov 2025 at 15:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> 32-bit hosts are deprecated since QEMU v10.0.0; we already
> removed support for MIPS and PPC hosts. Time for ARM removal.
>
> Based-on: <20251117140420.62193-1-philmd@linaro.org>
>           "roms: Do not try to build EDK2 for 32-bit ARM on Fedora"
> Based-on: <20251117153756.78830-1-philmd@linaro.org>
>           "docs: Mention 32-bit PPC host as removed"
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   gitlab: Stop cross-testing for 32-bit ARM hosts
>   buildsys: Remove support for 32-bit ARM hosts

I would prefer us not to drop a deprecated feature after
feature-freeze, please. This seems like it can wait for 11.0.

thanks
-- PMM

