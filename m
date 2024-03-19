Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986CBCD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBF-0005LC-6o; Tue, 19 Mar 2024 12:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmcBC-0005Kh-LX
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:11 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmcBB-00047A-03
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:10 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso7444982a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710865140; x=1711469940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8euuPCscVUeQgKfUsXeeuOCz5kA8HqyCYU3UaI6ZWo=;
 b=Omk3yQYV16IdAI5U5uNskhDEG1VoMNkVJgivt0qdcnP56JiIg9m5WUxTW5JFjs3/3u
 Ri+PQvUwHqZrbe7NmUoJ3bnezDRNxtGtSE6mWaIYoxJcLyI0IvslWhzaXHHA1abluyp/
 7jOmz6rCvV5JilVu2Ea10yh5c2S15LwpcH6d0et+Jg2TVKYhbdTgdsWQrBO4g5/pRxf8
 p2IsljVqfTv0kI8Y4bOP9W2jPzwgc/+AwMaEG+/bVKNdRmZCXRnbpL5WQTrIKZAu7hL4
 aCLG1+J68QVQPDEmE2FPT+1H7q91ChM+QKnaJCeV9s80ixHd3av4jXWWp0T4+BYLDscB
 zkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710865140; x=1711469940;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8euuPCscVUeQgKfUsXeeuOCz5kA8HqyCYU3UaI6ZWo=;
 b=iuxMlo3nOSeeobDayUwmTjjgE7lkyhTd1vpi80/Rx/dMjXKKNfmgiRP7vUk4qsaxO6
 egmxORDvPH3Ve1vhEqRzNJ1hX4HZuY6rNPiWQwqw7f8dW5Fkp3WNweLyliz/N4B3koyd
 IvO1asquYZiIwshlEPMAd8NOXrHEwuvBfHM3bup4Y88U6xrIQVdv7wRQSEh0bDtnsJoZ
 TulOAFbGL6h0+cGV8jz1007aUbGUGRtlTjZPnJ4GiK/gQLwIvyKOOmJl33KHgk+EB9Ak
 trVCwX19HRN/WZ+F7fc0x4DowpYnmUm4/rD+5sC5FaLDLSmfNQMw/P621nLbq9StW6eA
 rfFQ==
X-Gm-Message-State: AOJu0YyKrEPEfyIQLS0KSiXaX06auEX8bVYvx0gkSPBaEzZ9RpCjlfFH
 +VK+t8vaP1kBZa79Pal7xe2hf7Vt5ZsssYwWGam/js8PklZtz+14qOVoLQOf6B0=
X-Google-Smtp-Source: AGHT+IHUuKtkzwGneByemU4TuzTk0mQ7eMJ1hhhZV0/R+OsCeUwHQ9tFiTlHwCyt21pqJufJYu8/KA==
X-Received: by 2002:a05:6402:414e:b0:566:18ba:6b80 with SMTP id
 x14-20020a056402414e00b0056618ba6b80mr12914198eda.31.1710865139718; 
 Tue, 19 Mar 2024 09:18:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n5-20020aa7c685000000b00568d4cf3288sm2846385edq.7.2024.03.19.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 09:18:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F329C5F873;
 Tue, 19 Mar 2024 16:18:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Cleber Rosa <crosa@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Brad Smith
 <brad@comstyle.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v3 0/4] tests/avocado: update sbsa-ref firmware to latest
In-Reply-To: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
 (Marcin Juszkiewicz's message of "Mon, 18 Mar 2024 15:08:00 +0100")
References: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 16:18:58 +0000
Message-ID: <87v85i42kt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:

> Updating sbsa-ref firmware for QEMU CI was manual task. Now it is
> replaced by CI job run on CodeLinaro Gitlab instance.
>
> This patchset updates to current state:
>
> - Trusted Firmware v2.10.2 (latest LTS)
> - Tianocore EDK2 stable202402 (latest release)
>
> And Tianocore EDK2-platforms commit 085c2fb (edk2-platforms does not
> have releases).
>
> Firmware images were built using Debian 'bookworm' cross gcc 12.2.0
> compiler.
>
> And while I am in that file I dropped use of 'virtio-rng-pci' device as
> sbsa-ref is supposed to emulate physical hardware.
>
> Added 'max' tests with 'pauth=3Doff' and 'pauth-impdef=3Don' variants.

Queued to for-9.0/misc-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

