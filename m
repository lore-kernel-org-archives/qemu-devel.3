Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03EAC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 09:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQkeY-0000AZ-5W; Mon, 08 Jul 2024 05:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQkeM-0008Vz-Je
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:27:13 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQkeL-0005dh-3N
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 05:27:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111aeso4708037a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720430827; x=1721035627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ga+Ta1L8WckIlByEL4NKaVCsySeBSp2lgHQDCsyQkTU=;
 b=eZ/yqIVkUy2fWu0ErzoZSPh2M3d7lRwE7hFj6DdzS3/HzHHaOc8rLsLwm4Rd1xo9x8
 y16rMRfLH2+0Y7GptAVPb9XVnalcS5IiQFqzv2FrxS1IDlTktK6P6XUskZcxKAMWJwCK
 PDzuXSxzBNK3Rs7Y7F2tH2ek4PgZQhcIHnxrYkFjFjLJEfQ5vPrNhmRm5eg6R5CRAghx
 FFTuZa7DHW2SzKhEbAgsuDvnmK9vsv0rVKDHn37E9Cln3EUTZZHoSwuG2Unf5BNy2JpO
 vChKVgPQ+THfzmRA86q7IUpV6CxIIaNBGeuRK1m99z74U4XdZ6NkriOstQJ/C1gAUP7s
 Z3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720430827; x=1721035627;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ga+Ta1L8WckIlByEL4NKaVCsySeBSp2lgHQDCsyQkTU=;
 b=sNwuLjp44XuGZYQgjfQu9goatNjh0cXwyd14M/sDuwP/y2V13IEQlkmdIPaviCMuBD
 /ME1pBXcpgUXxmZwa7agqqA3y97UJPZfja7FoDCtpbFNna+siDB8FzhXW6I+pGCZ0W6k
 5tX5AHCUQefmAJXL76+AEs/WDiYQqW6wozWBEAYTWbV+SN7LAXSrABs5PuEwJRNG87N9
 B4Q4umrhsKeKBS9WVozJWnLgrRr27ckg1GouqFEJ04e61wePrn6COCEd6saePyDaucvp
 s+WKMTYuhnUuh00V+lt3GQylPmUyJ11aO9jDkxTqyi+vZx+fZ0KmVZQXVx1ynVEWj7Qe
 UC9Q==
X-Gm-Message-State: AOJu0YyAd9nM5FDRvpSJgnbgDeMrhppoYhr1qgaGwg4Ol56EzjXBIiyV
 6329BfQEliVm8rJk0t7L7mxNU6KkFy4YTd+HerJYAqTpSB37aapMpTQ5IfZv6g4=
X-Google-Smtp-Source: AGHT+IHgq70MasG5948pSIEWXGJBR/uovzs0Tx/jl4hpM/PYRU0Ui80H08jRi/fwzSF5uxD7x7tjng==
X-Received: by 2002:a05:6402:5114:b0:57c:6234:e95b with SMTP id
 4fb4d7f45d1cf-58e5a6ef55fmr8358621a12.5.1720430826733; 
 Mon, 08 Jul 2024 02:27:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58de8fe6322sm5467729a12.53.2024.07.08.02.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 02:27:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 39B475F7A1;
 Mon,  8 Jul 2024 10:27:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 1/7] plugins: fix mem callback array size
In-Reply-To: <20240706191335.878142-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:29 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-2-pierrick.bouvier@linaro.org>
Date: Mon, 08 Jul 2024 10:27:05 +0100
Message-ID: <87v81gtes6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> data was correctly copied, but size of array was not set
> (g_array_sized_new only reserves memory, but does not set size).
>
> As a result, callbacks were not called for code path relying on
> plugin_register_vcpu_mem_cb().
>
> Found when trying to trigger mem access callbacks for atomic
> instructions.
>
> Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

