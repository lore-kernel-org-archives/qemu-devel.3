Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C722CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 15:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruZZQ-0002id-VE; Wed, 10 Apr 2024 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruZZM-0002hM-SP
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 11:09:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruZZK-0001Qg-Pm
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 11:09:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso6898437a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712761736; x=1713366536; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpsgksyzGzRcNm2JzwzAubRePYESOxLQouIXaqDLpYs=;
 b=UgVZs+0RCb37TdNERa+xnOM+PAl3aNRDQZ9PqDK/5bf2VLnXeieWki1Ca0SUJekb7A
 1I5b3JtIQBW29eu1Kped8CRM5WZBJDkqskzoCMOFcSQ6paDheRvH/ZvlwXyMK5Ck9WDL
 lxQBI0O7vZwmegImOM5u/sX7KnzLStObz1eLLAWm0LVwUXMukimcOuMmJWdbQp8e/32n
 Okz+2Wo9S/PCtBJc9fD3K9bM8oMZblDVOKDaZSc0DxIJafgvYe6EkTXfoYH8GpM+oMQC
 d6DkjIsnTDakCAveN2VMw7wgsDoNWqGHhH+6UaGl1VSYmMcng3sPU7ZSDVIXavWa4F/a
 xjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712761736; x=1713366536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpsgksyzGzRcNm2JzwzAubRePYESOxLQouIXaqDLpYs=;
 b=fFKX5x6pYXTolnk7ri7JOAVuz+6zKMmAHSpsCn22sfRm9TYshJQ418fc+90Ui/VLY5
 57NgU1lWx7WrIbXORaDd0dLrakHLRNOaH0hot+QxbcnOKyHoSWPVDpyHDXP6xykg9KSm
 g3k+ovp586xSeT/uZDknJMVpGlVztKQJG1fcPZyLu5KRZB/ZZie90bRrBeGGD9Bn7lj8
 BgaluIi6z3AzJfScFWhXexxdFTRdbJvKtGz+9RdhxXMUveSFMjIQQqW6e8L0UUiPkOlL
 pl+fYCRUEw2aN7qzO/MG7Jl8Nwe8U20q9piRIaUaf2hIn4gYS6RxDrxDXtI7NOJRLjxH
 avFA==
X-Gm-Message-State: AOJu0YxhPYlNFagXhXW9XoR3yoe+NtDYxVuem63vWnaDBqaHHA/voB4Y
 7Xm7If2wG5KtTjG4d4WJpuogyad+aauiJmZ/AW16q6bSAIPAYasd6M5R18zfiVF9uDPlV5NIVCV
 EuNo+XGH5N2ddm8Mvx4/cFrFTmIxerj8T9MbBzQ==
X-Google-Smtp-Source: AGHT+IHCW25VQcvF+q0Uy/TDuKOw5q38MRQA9U/e0QJ7lXnvtzdC07yrZWgELC/iyCjXh4KihV7kcuJ6qG5NZKVFyoU=
X-Received: by 2002:a50:99da:0:b0:56b:cecb:a4c8 with SMTP id
 n26-20020a5099da000000b0056bcecba4c8mr2488330edb.39.1712761735877; Wed, 10
 Apr 2024 08:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240410091315.57241-1-philmd@linaro.org>
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2024 16:08:44 +0100
Message-ID: <CAFEAcA_sKiio5JjQ4H+8dvjf39gvR1oS3anF-PM+K-h_uu=nuw@mail.gmail.com>
Subject: Re: [PULL 00/16] Misc HW patches for 2024-04-10
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 10 Apr 2024 at 10:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 927284d65bce63ab1495d3febe7c7b5b6d5638=
74:
>
>   Merge tag 'edk2-20240409-pull-request' of https://gitlab.com/kraxel/qem=
u into staging (2024-04-09 17:36:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240410
>
> for you to fetch changes up to dcb0a1ac03d6b5ba6c7fcbe467f0215738006113:
>
>   hw/audio/virtio-snd: Remove unused assignment (2024-04-10 11:07:37 +020=
0)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> - Fix CXL Fixed Memory Window interleave-granularity typo
> - Fix for DMA re-entrancy abuse with VirtIO devices (CVE-2024-3446)
> - Fix out-of-bound access in NAND block buffer
> - Fix memory leak in AppleSMC reset() handler
> - Avoid VirtIO crypto backends abort o invalid session ID
> - Fix overflow in LAN9118 MIL TX FIFO
> - Fix overflow when abusing SDHCI TRNMOD register (CVE-2024-3447)
> - Fix overrun in short fragmented packet SCTP checksum (CVE-2024-3567)
> - Remove unused assignment in virtio-snd model (Coverity 1542933 & 154293=
4)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

