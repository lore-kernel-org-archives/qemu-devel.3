Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3285F31E5E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAs66-00010P-0L; Thu, 09 Apr 2026 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAs61-0000xj-Q5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:19:09 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAs5y-0004Lf-AP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:19:09 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65006c99d38so1283441d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 09:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775751545; cv=none;
 d=google.com; s=arc-20240605;
 b=lNHWRCzjLaBUGCfplXvYq7sl0gwDsvh7dpfohKuIkehUnkadxBW9MTJ6aBALdCGbKk
 gwfc0PaQU4eZZvf3PAO33HV8TdPt+sbi0KTbyviWqfeUphNfI5/cK3SZKmGoO79WrPih
 oOM/LIpCRMY/mykYyN8GiaU9XmoKLoCNzLGftcZa2vS3M0xWkk1CAlFa07rOXerXZry7
 AQ84PaOP41cmx1z/JNZjQ8D67i3xbQNIxMpvLj+WYzPldKLyB8dg3jZ2ZpxewrmeO4Hg
 b3u4X+pAl0uVDMEsYSwC6YU/pdDNyWa/DZkDEr2e1TpdnNAd2Tf+swa2R2n2HVjqUGZl
 UeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vvGnVZUJgEfitcTTXy67x0cksLZoxifI9oeHAZMv+Ys=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=YYyE5zlrmDgo7dlaNz3wNgVw2IcROMTB0QebsHK5dq3FwebetVFczEUHFr5Iq2MIlU
 ABkM2j73djMDjzGJ0rmj0GftSi3p0Zo44DcO5vLzLBrMwa0Abe0VJKSo703WLR+Exuin
 QfLofk7pfecv85arPjTU5+y0bo341iPUnPgTOLKTU5qeJFaxmiMmXhA2rEFrlWGhso0p
 PrwsAa67LmMTCTxFsUI4hsIY2iPlsfe0dcpfgF+Vrn0JMoRXcQ6Hf0tSSf0w8avLqBfF
 MNYH7SlqE2by+1DMQD7st62FjlXxf7Oa8bkgWlEBJwDk36oqnNbNpcGofHErpp04U+EB
 ZGOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775751545; x=1776356345; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvGnVZUJgEfitcTTXy67x0cksLZoxifI9oeHAZMv+Ys=;
 b=RC4keSTXJvfpANGMCLAaHK9IXwZmE7q6iIPupBESCnkJBiANgpsm3uMo9Lw6g15vUS
 PvWqqmIIctUxZY7V40vlaFX6Uy63tjPKGn4l2CmRFzJx0HMLQqs9/X8Zqfh6aZvxpYYH
 ZNzw4JN7d/bF61FpD/nYKWQmu9w84BjkzstdBCfJioI/ryEcCbT3aHQb8ybCeaREAW7H
 JEsW5w4IwIKTFZJR27cc9iGmcBiVCDk8SZZEN/V0Wq2MEWYFtSS0Nxuc4/RwbJa9Fi3g
 ggNKP/qDoyjme/DSLsnviAz6wo1mBl2wRYMP8JR3Y0Deb/Hfzy2MJhOj9Rn0lTBiSMlb
 sRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775751545; x=1776356345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vvGnVZUJgEfitcTTXy67x0cksLZoxifI9oeHAZMv+Ys=;
 b=TZz+tOFNlmay0nngZ6JalKHye4NR7G6ZfHpUoKxJ9WFTieFC2fkNvefixF0BCc0dvn
 AM965yKdN4+cRaVh/n9G6P4Mzk7D26K3k/mdNzcs4lSDZxlr98mts0xpI6JZnqXHvtTu
 Oe4rJGWS3V14ckD7MemCkLpK+NxamTgDlxI8wozxkEMT7q8lT6DRU5pCkLVh6cr9LFSK
 Q4jIud48twDgqIcrMcvZB5NUq1ZOZXC89kcIKYHhS89UC6iIe4SIjv4t6W/vh/jXpwIp
 Bsl6fvG9xWGnukK3jacJQGeKYbQcWszZSjLh9SihAqJjh+oEeUoq9GpjFcfQIg+bhv7C
 S6+A==
X-Gm-Message-State: AOJu0Yx9DGEUpAvDDI3BQRRqpw/ilZwqIvKNpniGYUhhIqe2RusxzT0/
 rx+0hgiGl4jcZJ4ut8OJgETXFEYcDhEgrp6KPRHiTa4AjHp7ExcB1qd3sqAiLUFr94bCbAHnJNO
 XYlh3Gs2LqqAbpQkzb9YCDkiAXyJHomd/xLPutRo2Kd5xgpwAcwDGj8g=
X-Gm-Gg: AeBDieuyTceRwkwJJgT+TQdw5WFfZwhRFlCHxP4D0y2K2VEgFlB1KSbpa1iLdsXINGN
 vS1O5RhkSDsjE1hXHO70duO4DM+RPWrqjhmpn5h7cPLJilFjh4Rjoqo969yHmPUTk8LxtMruyiE
 zj/0wg2otyTYLFV5pWelp0C9sXvIkqSTZzIrkTBE4CHGjKL+LFyRfcgsEurFl+qJZIPH9WSAXvm
 clFtsMfyqTm8swJ1VU2bxgRhdpjvv0q+pAHod6M1X1wcT/9S5xDPaGGI2oz/+CEjnH3jv7SShC3
 lsB5aUySBg+lewkqsdG3Dc0jqPS1uAFJl92nt6jhcY5KnX0hbUTxhpGuZlx23aI/SnE=
X-Received: by 2002:a05:690e:a4f:b0:64d:6bee:2c5b with SMTP id
 956f58d0204a3-651875cad39mr4095862d50.16.1775751544369; Thu, 09 Apr 2026
 09:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260409142137.58349-1-philmd@linaro.org>
In-Reply-To: <20260409142137.58349-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 17:18:52 +0100
X-Gm-Features: AQROBzDa-wbt26k1EMxoJmCi8-pgXm5JdJ5iWspdb0pjy9IVg0GmKBsL09lXPlM
Message-ID: <CAFEAcA_vTp4E6Yc=vH8+fY4=2JjJ=xcDPVSfLEGJ0zF1wVnU0g@mail.gmail.com>
Subject: Re: [PULL 0/4] Misc HW patches for 2026-04-09
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 9 Apr 2026 at 15:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit a87e211600e5e2a86ae51ea53615cd4d866b24=
a2:
>
>   Merge tag 'hw-misc-20260407' of https://github.com/philmd/qemu into sta=
ging (2026-04-08 19:16:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260409
>
> for you to fetch changes up to 4e6fb62fb0f33c815b089d0b59e1313b768c55d0:
>
>   qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config (2026=
-04-09 15:44:58 +0200)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> Few hw/ fixes and a keymap one.
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

