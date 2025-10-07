Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9394ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64La-0007Nc-21; Tue, 07 Oct 2025 05:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64LF-0007Fi-EF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:50:45 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64LC-0003Iu-PX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:50:45 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-635349b6fe6so4930078d50.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759830641; x=1760435441; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QQRlGq5iEz0PqBDGwqnp4uIgDuZXe6UJ5EjGAWxfQU=;
 b=ZpAXx2USPhisQMsTkMxy0UerS36/qqDJjhVCtR08I6+d0EI1TpyyI2r0of1/IOV9lA
 jTBB154EuBp9u08ahC4VYSzZeCnZBLSKYY+bgJXPQb0NUsTMVI3mBHvCFtJp2VqQzvzF
 cX7mVyCCM8JsFkLydDtU0P06mfiWByUc24Zn6CC88vT+VVGkfQit5vau7xH6AG4XfCY1
 AeCLEWz038JIGro5mlve2ItQ5v191LchmNGsEkTRCVUxquMWbqPJem0goJWuYz1WJ7GH
 HNYPoCEjAJk8GWtsQ7OppwkPFqk3WaRVHOPrE9pvMBHxGrHjZVIBpjvfPp0nPQ5qA9xg
 w1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759830641; x=1760435441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QQRlGq5iEz0PqBDGwqnp4uIgDuZXe6UJ5EjGAWxfQU=;
 b=AKL1usuvH5fwXpBZKbDzk3mK1I/ageEE2WnWpioE4OEW05YRQH1INwrOidNeBxfMYn
 sf8Xi2VfYYaR9FCp58N8BwbMjCCGsPpcWFnpGCyq8lN6XrQrDaUen/Gln3H82EFyyP4T
 QpiUcCbuCxpkLZFuG7/I1DAHaXpjjmZvXJrIoQQheJi0fr0NUrtHEgwgsMdxuuJcIxtM
 e7LjnF7XvWRqHG1ilAnSY13gOfOPUmGMhGIg1n/8q5Ibcrlw7wyf0gG8SrpUR0vLIvAQ
 fWHEW8+3xhl6hZN8HYpV+lUk/Lod6c+M3eliQMKmvQ7naDdZT9NPjI2NbkHW09wcT2/z
 SCcQ==
X-Gm-Message-State: AOJu0Yy2XYmI2TKzNOX5PSUVYXQ+j6Fu0fB0KiTwOnprPVVIiIJ8DCXY
 WzBrA4hAr/grwVyx/fjsCnzpZxHf/i0FFsffAkg/ypqrtZK10q7Da+ab4/4YcBD4wd3ErFJNzRG
 bVzcDTkAGypOSFSxiPvxnN9t6BLBe70gWT9aeZvGeEQ==
X-Gm-Gg: ASbGncvfMkNKn8LlWc48M+QoOP1U1WdTHBaP1EM3iL+v165CaUi8gLfTSvZfbBI1qLe
 +rW+yUSZMKgzpl7ywKPShGNxwjzDT77a0WWLnMhR/6G107+u88Z+Ho79xeBOALgh03vmJHhmLwL
 XVLXvrwlVQHSKKWB4HWjg5VViQ/pF0VGr2rjrquJXUTL0G9qFKStpfyK8koMlj6mY0Fww8Gmd2C
 0ku6a/+44DxKEI9Izvltd31vSjgzCIF6slf
X-Google-Smtp-Source: AGHT+IFieBnq/e7LlyNcrWqS4M6wCuEHmQlZlq5ZwlEVYFlZE9046+gKtjdrutxjZglysm+94ZH/DoRgxoO8C9evV/8=
X-Received: by 2002:a53:a0ca:0:b0:633:ab16:f82c with SMTP id
 956f58d0204a3-63b9a0701b0mr11536282d50.18.1759830640358; Tue, 07 Oct 2025
 02:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250930115718.437100-1-chigot@adacore.com>
In-Reply-To: <20250930115718.437100-1-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 10:50:29 +0100
X-Gm-Features: AS18NWA6Tdg31JfY1JRui4UZtahTggsj4Atu5Tr_AyBkahDNg0zXo04QKve2UM0
Message-ID: <CAFEAcA8+F0jwWaqexO2bbtUp3kuLvg+9v42KAnt7rjj_Vh-_Qg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/xlnx-zynqmp: wire a second GIC for the
 Cortex-R5
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 30 Sept 2025 at 12:57, Cl=C3=A9ment Chigot <chigot@adacore.com> wro=
te:
>
> The first two patches are minor improvements before the core third
> patch.
>
> This was initially a single patch split as per review comments (see [1])
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2025-09/msg05899.html
>
> Cl=C3=A9ment Chigot (2):
>   hw/arm/xlnx-zynqmp: move GIC_NUM_SPI_INTR define in header
>   hw/arm/xlnx-zynqmp: introduce helper to compute RPU number
>
> Frederic Konrad (1):
>   hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5



Applied to target-arm.next, thanks.

-- PMM

