Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF82C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk2Hp-0006S3-Po; Thu, 07 Aug 2025 11:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uk2Hd-0006B4-48
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:12:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uk2HL-0006Gv-Gp
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:11:41 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b8db5e9b35so570542f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579498; x=1755184298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nzZKHDdzB1VMGttSmHY8juU+cAh88BKNe6a+gQJg8A=;
 b=o3wXlYN8C4Zy/utn11tYg1TxcmJAA74L9OK05A/E/aGsioZJNiWORDyRqhhkMmzaxc
 XdxTeWr9H2AStog2uDxiDcmileG/skjE+3Efxa/b+/TLkOSGlXEXIvwNfMkgvXxwWeko
 AwEOQWEvePcpDVSJNS9pg7xcrcbKXVB3SscxSELEUqeNFtSkvWsYqB2Rs69Q/GcGBoVA
 4HQxSVnLANylXbCdLJqMUv3Sv40Jq0D/QYT9qxJ9r7qT7SOaWznubsUvxuGmx143Zqx3
 T4galqK50UHUkMCi1w0W0XObOQWPz+V1rn0030CRuK4/9q7d7NfHUVK0/3aKCi9RJ88b
 ByDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579498; x=1755184298;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0nzZKHDdzB1VMGttSmHY8juU+cAh88BKNe6a+gQJg8A=;
 b=oJ3NZ8gRi++I2JH4pE/js7TczEUcOlBbfxN4Fynmyi6Nf0qH69rKeFrTHlkKMPiKrZ
 Si9zQfLZE3dl8iqnTVI1g0BDLGgHaGgJI4t4pqkhG2gLQOYrVT65Qv701Wogw3F38mWG
 ddUDzUmwV47g+cGeg6kPcahant7Vfh8dlRUf9q1Wo72LRCCexVozO8p/MW0koh4Hxh1F
 +gGC3RlksR58swHStQp60LC9F/Dt0PxRlc/TuBeT5b9hrtJKBIEtplxDFOtCbs7IztfA
 Egd2SkfsV8kOgixXbGUVi3EDCC7OPqLg7wq/od+TC5q9TNdf+QFEmW2yKUPDQ2CnV13o
 fZQg==
X-Gm-Message-State: AOJu0Yxxgu7nZ9Gx+pQ5qhIQ9eZzEflCpzf0SIsSKbqOfXeR62q18JT+
 ZhhRZley15TgtF+g3Wq6sgrgQy9zFRYOhCkXK0nNXujVzRBlCObTZ68hnuLxyyaB9zA=
X-Gm-Gg: ASbGncvPUagNhRUoqizPfSTEvPqCDPMPjp387cf0KhRWiT5vS7DwQ0Xz8CXdd0fuUw7
 kVWvof8Hvg29RfjKmTz9X6v4CmwTgTGHCpgMuJsylj3EFUaR3PRfrNbcZiMhsQQPbj2gShoR/HK
 ozbAkGq2YZVa+9eJrkbZSOUk/LeoXj2UTdP411nMbNn3jEQZsgIowmZTccgdybq6TMSVCcp337Y
 feAc4IVB9KkOqQWBcz/PIhM+MQ+xRS6CZ/NYvnqUwL0d4bIdi3So/bzfDQ/t3NAYFVXL8+uID/u
 x3UC9ks0OLY2lWxI09OlnHihBDnb+5012Q1LyjBru2IrLTWXUlMjgmIo6dYZstNyKCfOUO227qT
 T3YhZ3w6zbaOBKcbEg+nb2GQ=
X-Google-Smtp-Source: AGHT+IHd5WX/CSj6LtAJw4/lXm8cPEz/pOhzsLSNtyzDUH4QomuzJMZloRiSBVYMaPyNaT6telnZHA==
X-Received: by 2002:a05:6000:2407:b0:3a3:63d3:369a with SMTP id
 ffacd0b85a97d-3b9000839bbmr10981f8f.25.1754579497913; 
 Thu, 07 Aug 2025 08:11:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm27191581f8f.21.2025.08.07.08.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:11:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56D1E5F88A;
 Thu, 07 Aug 2025 16:11:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org,  pbonzini@redhat.com,
 zhao1.liu@intel.com
Subject: Re: [PATCH 2/2] MAINTAINERS: add Rust docs to qemu-rust entry
In-Reply-To: <20250807-rust-docs-add-128bit-mention-v1-2-1d8a1ece3a51@linaro.org>
 (Manos Pitsidianakis's message of "Thu, 07 Aug 2025 16:02:05 +0300")
References: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
 <20250807-rust-docs-add-128bit-mention-v1-2-1d8a1ece3a51@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 07 Aug 2025 16:11:36 +0100
Message-ID: <875xezyxnb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Cc qemu-rust list when touching developer Rust docs
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76213e3a204bbbf3a83137f1487e4b65..82011bb097fccac3dcc9df46c=
db15afa41c44cbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3519,6 +3519,7 @@ Rust-related patches CC here
>  L: qemu-rust@nongnu.org
>  F: tests/docker/test-rust
>  F: rust/
> +F: docs/devel/rust.rst
>=20=20
>  SLIRP
>  M: Samuel Thibault <samuel.thibault@ens-lyon.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

