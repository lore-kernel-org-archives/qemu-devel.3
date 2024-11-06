Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCA5D59F75
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 21:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8nZ5-0001ls-3f; Wed, 06 Nov 2024 16:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8nZ1-0001lO-L1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:27:43 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8nZ0-0002tf-2K
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:27:43 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c984352742so241147a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 13:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730928459; x=1731533259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjBdDFOBxN2iYODXoBSDKCtcnbwd0O1glbpAVPQmbZc=;
 b=YeKr28CvlPnmK2Dknxbasv3aq2dW2QO2My/6wUZgDeRc/RnpOE6nX+F1uvgp+t5qIA
 8syt8quRspOjktrgYzoQPClFX8CXvAEaa2GlgnM9g9nS/g9Srs7ltVT0qqJP29AMf42w
 yZw6sKQ3tL8L/y+1qCg7z4A4uWWLq6i81Bn7bdxTYJ7M7sQemEBotvAz1qjD+6KVo3AM
 oazMXQ8GDYrbrBu3RxEltyKdlETa+k++suM8fXk1kLNdVHwV1NKtNg8zoDXcl7oEZyO9
 jMbISB8NssrT0dgFFFo7bbdYEGdPXl6Y4CuiW6sIjXaqJQyNIWzHgBv/TJ/unnEjBbpn
 zBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730928459; x=1731533259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KjBdDFOBxN2iYODXoBSDKCtcnbwd0O1glbpAVPQmbZc=;
 b=JuH3nFrFZ9rB1VA0LUsCEwVRP9KQRJiDfbbl3BTivcz0Ps1YnHvPaBG7MJTfEI+buS
 zVohzaBbfYGngRFqvWfh1cbUOmtIFH+ICMpKF8BpTH4QQRnOprDQfwiYTbt9upBZu4K7
 bKbAM+sxe5GpthKdnCcFdelioLAYkdn8G0qAr5VGZq+ZN1UcLSldZE/WmJ9JEmdTW1DW
 nrqHsD8eh6rpdNtJunlRaG6738aKVXoYUGAmnGY5hIqaRROPbgSeJiMXhDLMheMll341
 rZE1g0uGD2B7rBwsMnipIw7bDuBqVLyYblWqxdKVIyXdo88yguwJwzZbUbdqpeeOn2CZ
 lkWQ==
X-Gm-Message-State: AOJu0YzXygJjrmIvBVMhQCoHE7u5hdx543GBLg3NTGrI0Lj3qfmmdGro
 ftVdulN5LR6AS/pIRBUybYkKF7ObhPOPJWxOZVEuV9o7+jJooTEhJzV8tqhtyMaKjXY+R6PhRgt
 8vnkuCNJA5KEcV3i+pSi9pWyU11eyfQBvonh4XOl31qilOhTV
X-Google-Smtp-Source: AGHT+IGj8fLOI7XEyd6aagZRUCGnUULgDWKjnG7HE54n4EwzUaQVEl+hjcNtSfGRnPYeVVBjMCCQZfjwKs34IH/ixAk=
X-Received: by 2002:a05:6402:34c6:b0:5ce:cffa:3f53 with SMTP id
 4fb4d7f45d1cf-5cecffa43admr10108444a12.9.1730928458940; Wed, 06 Nov 2024
 13:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20241105233503.56812-1-philmd@linaro.org>
In-Reply-To: <20241105233503.56812-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 21:27:28 +0000
Message-ID: <CAFEAcA-qaqJFRhveFc_Myj5M9cpgX9tyR81hk04GfVm93xTDkQ@mail.gmail.com>
Subject: Re: [PULL v2 00/29] Misc HW patches for 2024-11-05
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 5 Nov 2024 at 23:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 44a9394b1d272b53306d097d4bc20ff7ad14b1=
59:
>
>   Merge tag 'pull-nvme-20241104' of https://gitlab.com/birkelund/qemu int=
o staging (2024-11-05 14:23:22 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20241105
>
> for you to fetch changes up to d37eede7a8e6ff33d21aacb41a68e63e8ffa1d60:
>
>   hw/riscv/iommu: fix build error with clang (2024-11-05 23:32:25 +0000)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> - Deprecate a pair of untested microblaze big-endian machines (Philippe)
> - Arch-agnostic CPU topology checks at machine level (Zhao)
> - Cleanups on PPC E500 (Bernhard)
> - Various conversions to DEFINE_TYPES() macro (Bernhard)
> - Fix RISC-V _pext_u64() name clashing (Pierrick)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

