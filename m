Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEBBCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSapB-00033y-73; Thu, 28 May 2026 09:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSap8-000331-QT
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:30:58 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSap5-0004Qg-LP
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:30:58 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7c58e6eb2c8so129218527b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975054; cv=none;
 d=google.com; s=arc-20240605;
 b=e0VseUjFN1GVhPz2mfHs7Iq8gdjcMtyZbeEEFZmWrD0a4y48tsVStOVkGyLYcNT8wg
 I43VTcy7UZTWdkhLlvbWf4HgbHHpgxkWWbDhmlnVcp6FR1zn3huuuxuXZSsu3WwcQLQs
 VH5J0+sWX8x3giufj835Z15/cffug1wmTMs69aIAesNXHUYVA+rhRI7+UJDPa4KSp0x3
 m0JxbIfGaUXUMYXWzVU3tdjNMCNEHDOD93HHbmCCRSChCGrjzTwN53cydF3SL+iwwXPs
 rdPytHVw7SYD69jIMj5G9Yo3A3G+8i5vYd1gy8O7c0Mdk9UzQFK1fj9OITc+pF8jJciZ
 9FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ypOqJwt6MG32xNjPn5nD9rwsVdwX4MHa5fFYaSfgigk=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=UyEINLOuS4szK5hVSPpTBkgDtvfZscAVeQcsGKPJvFXKWezAy5iEBpUhjaOPaN9lzP
 0zBCKz5x5HwdBjLvSVQPy6N2gKJ0fahX43n6RrwsdlkP1bcMHMuFGuT5mNOOxztFeyN5
 Om3OXRNXMgLIXyxMROOkUnxQ4nDy4ScdkRGuEpcnjfw9OG1311wGAqm9AzLRqVSA9HCL
 SGe35NIdvljK7/UsHFjfz9yfxwfjDQytyKgpUJOzKXxQ3EKybIZeiPIcW7oe58N4cY/u
 /D0dRCPVxX3zkrWOm9OOb17Hp3qxoafZveA1TsBmsZi963wZ1QHjPJcg39T1Id6hDM8K
 X41Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779975054; x=1780579854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypOqJwt6MG32xNjPn5nD9rwsVdwX4MHa5fFYaSfgigk=;
 b=iu3U1KksYdYy5vDjJwWiHSzo/y9+PIpqZMqVBI7RdUR/RG9sR/u0dYI61kCxLklKTN
 Z6bwLIeZ9ypIgq3iVDibQ9E19AEDXkPlWOYnW0aYsG25gDTZ4051O6Kdpwx1/9ekos9w
 4SVJFsjhCeqS/dfzM3h6X5ZHePK5UFDpXYxifp0Selnkd/aCGX79zI1RX8Jrin4kFyNh
 Vq4onUiK6ZL0B6joLKAvbq11MrlvNxYd14HbiCrf5yviYXeju+tVbO+Mp/hsBhgBgr0t
 44hCgW/ioUHSgWR0bX5wAV4/lB27OlZue/dkHUBEmPY0KRkuQ7J56/ZLpHxUCFsfohtS
 pOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975054; x=1780579854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ypOqJwt6MG32xNjPn5nD9rwsVdwX4MHa5fFYaSfgigk=;
 b=E9I3/BisILOvbU6o3iLjHK05cgq1F9XdcGvEZQlmx1z3pisqYdij1Juq8yYIfIhNty
 W+odmqCFeSoOZNri5F31UmxLb98LRqu/BdvpcGQaky5scXR0tgM0SmfZBr9S+D8ighhx
 gGCnDpztppRy/Znm4QsgYiIywwuFmhqIMClPv0XtkprCB6V6PnFHo5hsv8TWixr0B1AS
 y+fLd2V+ZYLDU/uq7m89QOVy5w82gqDluI/udwK2B+SlQW7/3/+BZQcPs0l65GwTBI+q
 /e3hgbeCOMLnIX2ZFLHInaQtjAzDtXw/ag2uTjWL+/RGtRqC8BHLQiBiteE+lhZbtqWf
 3WWg==
X-Gm-Message-State: AOJu0Yy0HlZwPlI4nClAH/qMvIWqJzJ4XLaC+/o7rHcsxcdX88e8ofOa
 YrMtWPyo5T9HvaNl0JhxBZXTcVDQlUxLdmf2OZWBVEerPLT4S1qLSplbhvllwG2jTSjNv1C4UYg
 Hbx+S6/6DVNprxgy3/yMEI/SgN3yrDhp8K0L10gqJ8g==
X-Gm-Gg: Acq92OEDpB+HQT2yYTBTYa4Mfz7WBkBilE0FS+chliAmgPf8fMWYJkaRccCuACiY7hI
 ygrWDfmPeyNl45mNUtUZZEbIZ2yJKhqGl0kQPkiEL3ybKh2hiORb231lG4LfPo3E+3VBjOzQavk
 2uS1YlhuPpN5TAiFAcUbFeepot6T3pU6lE0L7Fx3XqmzXwDWYKghrk+33cVg2/53FWpRlRK7PNJ
 PqtyL2coIJStkoNtfgZ6zYUWl1jziFzcWPzWZCaXAGMv3GdLrsRKnKYE0IPaVcsSkFtsPkXS/zS
 ofF01eYmO3wvuEB6I8sfoAVSeTNshtvR7EiDpkG2Yq5QrMwNW3QOpzkyDMHJXLfHySwIVCkjGNv
 ozw==
X-Received: by 2002:a05:690c:6e8d:b0:7cf:d242:d94a with SMTP id
 00721157ae682-7d336cb26f5mr294889847b3.25.1779975054261; Thu, 28 May 2026
 06:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 14:30:43 +0100
X-Gm-Features: AVHnY4ICvIK2kVYst-xM5rCWkEt_5-MtQKgfi0AIxtJX4e3SQiWpvev-OPk8Obo
Message-ID: <CAFEAcA9eNjS6MLjmub8YRFHiGUvRt47KnNGk8_T03VO-63JcAQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] hw/arm: add Beckhoff CX7200 board
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> Hi,
>
> Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> platform. This commit series adds the Beckhoff CX7200 as new board varian=
t to
> QEMU.
>
> The emulation is able to successfully boot an CX7200 image. The image inc=
ludes
> some self tests executed on every boot. Only the cache self test fails du=
e to
> QEMU emulating the cache as always being coherent. The self tests include=
 f.e.:
>
> * Network
> * Flash
> * CCAT DMA + EEPROM [1]
> * TwinCAT (Beckhoff's automation control software [2])
>
> [1] https://github.com/beckhoff/ccat
> [2] https://www.beckhoff.com/en-us/products/automation/
>
> YannickV (16):
>   hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
>   hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
>   hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in
>     user mode
>   hw/dma/zynq-devcfg: Simulate dummy PL reset
>   hw/dma/zynq-devcfg: Indicate power-up status of PL
>   hw/misc: Add dummy ZYNQ DDR controller
>   hw/misc/zynq_slcr: Add logic for DCI configuration

>   hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
>   hw/arm/xilinx_zynq: Split xilinx_zynq into header and implementation
>    files

I'm taking these patches into target-arm.next, since they've been
reviewed and most of them are bugfixes to the existing zynq code.
That should make this patchseries a bit smaller for the next round.

I've left code review comments on the others.

thanks
-- PMM

