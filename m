Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4797DC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjwL-0005wd-8F; Thu, 14 Mar 2024 08:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjwG-0005w0-1o
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:12:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjw5-0006si-7N
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:11:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so515018f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710418304; x=1711023104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5wGf6G6sEPiVspAgbQ1vNiXc8hIrQ09KCxRrHhUPDM=;
 b=TC1aJ9NvwbiYUfbiicAmuyvbATGmPnWJCIDMcigsWUA4hrrShkhF64qQMmyo4rzXVq
 LolkD0n1H1271oVZmR7f4dYeDqOEA09yNcAbXSB68OLBCLCzFtqoJVtkUaMLhJT+WIJg
 QxWTiiqyRBwyWoFHfNnzB2I3v4EG4zl+rTT9miQE9oI/0SvIWhu/+pjzXEoGhOydX9cy
 gwbQU+Heu1kvSxwf0RRarOtdJZVEZuzdVaW/jG2MJxS0SAYnT6bO5fBjXB74U0bv/4x5
 qnlxBsB8HY+SC7jMXIlKDEFUqVlPZx5BAPqMbxpVTGnI3BTJZsD4BX5w7NDRSvvpPS4V
 0qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710418304; x=1711023104;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O5wGf6G6sEPiVspAgbQ1vNiXc8hIrQ09KCxRrHhUPDM=;
 b=IfP/j1uC7a1F6sgF2S8V60hPSaAYOt9U+56dfDm2drlYyPtBqenv4Tq3LWlrbjm52b
 ACjTxW77+KGYDlp9YkxiDtdiTQ05Vfw8NFUJKqgExjgkqTH8qPD6nKvIlyCFIkWkVT44
 yxnhJNDYRZqhTlkqb60t650lRP3ltDenNEHm8wXsd6C5Fmh1cRd93+xW1Y2RbvB6KrYq
 8FM/9go5wqVf2InbQKh1zJ4HQLclkUwuYtv0iN3bDMg6wPhHidUPuHcvgJyjijooaYmH
 DGNKqgKFdqMdL6wet1kziHSe7oQI1rTIn/T5BJN+4Bwj6DLePQ6UvlUael+Wf8qRkiDd
 NSOQ==
X-Gm-Message-State: AOJu0YyjgEWETSlzV42r48DgKg1lMhx/ECnHJpIxw3V6QDITfeZbiiXA
 MfZUGftitA+6m6/4RFq6bVtJ47coSUv5JbBkdLwkiQBZPQbR+08c6ox6DX+fJyY=
X-Google-Smtp-Source: AGHT+IGjiypbkF9/nz8zezjZQxET4lXjTx9jDCRsPRsFO8sUSqZbIrnfi46ekoCUj/rGluwkj0dcGQ==
X-Received: by 2002:a5d:4d05:0:b0:33e:7003:b1bc with SMTP id
 z5-20020a5d4d05000000b0033e7003b1bcmr1217692wrt.7.1710418304117; 
 Thu, 14 Mar 2024 05:11:44 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b16-20020adfee90000000b0033ec7182673sm636455wro.52.2024.03.14.05.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:11:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 408B15F890;
 Thu, 14 Mar 2024 12:11:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Cleber Rosa <crosa@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Brad Smith
 <brad@comstyle.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/4] tests/avocado: drop virtio-rng from sbsa-ref tests
In-Reply-To: <20240314-sbsa-ref-firmware-update-v2-2-b557c56559cd@linaro.org>
 (Marcin Juszkiewicz's message of "Thu, 14 Mar 2024 10:23:25 +0100")
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-2-b557c56559cd@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Thu, 14 Mar 2024 12:11:43 +0000
Message-ID: <87h6h9gghs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

> sbsa-ref is supposed to emulate real hardware so virtio-rng-pci
> does not fit here

What is real anyway ;-)

VirtIO devices exist in real life and I would argue for PCI the device
appears very much like a normal PCI device. I could see the argument for
avoiding virtio-mmio devices which are a lot more VM-only in flavour.

>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  tests/avocado/machine_aarch64_sbsaref.py | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/mac=
hine_aarch64_sbsaref.py
> index cbab793455..259225f15f 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -132,10 +132,6 @@ def boot_alpine_linux(self, cpu):
>              cpu,
>              "-drive",
>              f"file=3D{iso_path},format=3Draw",
> -            "-device",
> -            "virtio-rng-pci,rng=3Drng0",
> -            "-object",
> -            "rng-random,id=3Drng0,filename=3D/dev/urandom",
>          )
>=20=20
>          self.vm.launch()
> @@ -179,10 +175,6 @@ def boot_openbsd73(self, cpu):
>              cpu,
>              "-drive",
>              f"file=3D{img_path},format=3Draw",
> -            "-device",
> -            "virtio-rng-pci,rng=3Drng0",
> -            "-object",
> -            "rng-random,id=3Drng0,filename=3D/dev/urandom",
>          )
>=20=20
>          self.vm.launch()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

