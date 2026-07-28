Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04193C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 02:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woX8a-0008Ca-A4; Mon, 27 Jul 2026 22:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1woX8W-0008Bl-BG
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 22:01:41 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1woX8R-0003Dn-2Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 22:01:38 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81062fdeaf5so7756377b3.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 19:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785204093; cv=none;
 d=google.com; s=arc-20260327;
 b=sfE1DbHwY+ypywn+1ayBxE/hLzwjr7vHsWCTDO1GrmImROCXIGV6JIvIp95fVmjFh6
 7gpdFUMLob/WFFHV5/TSgkWo+a2/iubPWwp1kzl4oJzzKVfxNF02eSS+5t0gpjbDCMNg
 ahU5J809y0YPRY0WqVNoWfG0ICRx1NIKW1zYsweEGpCt9Q5jkjA702Tf6c2qkxLnaS+D
 1Zoi9Wa8jBBhf2FoqunTTHets7FRu8yj97DxJnfeij2ABgPGOO0UYVXNNuok4avX7Zfi
 hUsGiIR8Da/BDCY2cFvK2Rco3DDv4mFD2nPuoJR27tKQ9jAkTozjlVn5AXjVra5/Ev5x
 3ghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rIS4gKkPfjEPvIYr6ATqDZOWcS8KoVPF56KZr18KIoY=;
 fh=Fk/+UCsYZgmj1YiEeabC6CazmJJqvUfXg35J7jzZTJE=;
 b=bwljVUpArq4bKLa4ksrUZxcDzDjglNBJDEw4UJ8S9uEI3Dskg+zPoWjYGOEpVf8a0f
 NYpQ6Jy+6FlV9dN7T6ijzcF3hlpzMn+UsRsAJBTu90dANjoZHgVVEGwKd9E439VkcMRW
 qQ7/u3zOtYs0DgAsssrveMqSDmLOKRdiyIXVy7QFXa4KPI99SsLmUwOik8WUx2RaGrbU
 fZiUFxP5NaR7lFmYPN9h9zoKki0DfIxVOOsSydwUmLEVT9ifTNlj5jf1+pr6cekbPB4X
 vnwnHfMdffOX4R/R+kZ8Q5BuTWYbZx4yd+VIjQ9lBUsk/2wdFoS/FzEX8xhKO7UKfEhr
 ycGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=summations-net.20251104.gappssmtp.com; s=20251104; t=1785204093; x=1785808893;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rIS4gKkPfjEPvIYr6ATqDZOWcS8KoVPF56KZr18KIoY=;
 b=AW1+P0cktGSDwwVMRGtU4km2CvFz2r5jNFxDc9OXhwcWysoeUTjm7VWM0qKXgIOMFl
 eLjp6MnvpIlW4/A66ZravK80TBaUolv9ayP7Ii5np589H0vPV2hpfcCXw/Vdyjm4zLCP
 VlCECxcoMM1Re5MJdAmTYTTlgJpoxai9khKj4CUWKts4Y+QWfdBOZSV2NoeKBd748SSw
 KsLhCYr6oFcnxo9L6rAv27/xawcH5+Gz6szuqSJvLRqFeUBzC6wCVwQM7z1zkEiiYrkL
 Qpjb3PoUpYi5qHIUgSK2a5Gv0O1OC7g82QtBldfM9vXDkP10BcsSrrILudRZ6vzhZcJl
 0U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785204093; x=1785808893;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rIS4gKkPfjEPvIYr6ATqDZOWcS8KoVPF56KZr18KIoY=;
 b=onVqeoy0WDjUIyxF+eP5KEJGeJuCuHgaEctUOQXKPlqscZs+6/arWg09IZcU6QboCG
 CinGoQJe9kR2FglcY0kBVB9tIEObVAVE8eq35tuatfO7TewEGXS9EyyZf9st8Swm3yGB
 UOSs7xNTm630ZoQNljhoEph0m8lM7jLdDFdAI6273JnURXzDEacEn7nPEgsAXWiw/ulq
 2VAxabp8BHS2Zol7vVuuaFh9FQwMkZG5xsBGNC4edHXIHTnboPpgmG+JQ7Zy0gM8RoGs
 +/SwVS7CHVZCv5SVCx+EsVmp+eNescnRCyInJQ7CAK9RQ8zwtUu2E1n0acFK4L0N9/EA
 zRkw==
X-Gm-Message-State: AOJu0YwLnDH/lYsQYOoi9LZrvw6PAbIbVMKUQeqoHSYtYTjVL0U1CXGD
 CApRR6UIIVyzyUCBywvS+2xcwBESP+Q6C4qVG9Y/D5nxZvry4mP6Q0jqA/7zLzx14ZygkaEpIOL
 qJDqqp0HLDpVHOUOPipQahEDw6dT1hibglSIYqwhRJsw=
X-Gm-Gg: AR+sD138VXJJurDnzBDkVgbwox4ak4khABwVRS0ipsI8TaR9J6nreB0IfpK0gagMaeb
 PiAZLHJxJuk61HnqzVHefv3EvYjJtA+YuAIdX5ocSM9p+zWAc5fXShUpv3v3kdL8OtPIXCeE4BV
 i2ZeexXD2Fo81JoQumo4m99aDleuldu+DlKp9C6ICYquxfjK+E2RJxYTZqNdonv9Yz5bSBC3QY5
 WlttgsC3Mi8nxUrwU5o0AKsP9cAX0HaqGU3c2jLDiOWow42iTASJxwAD4TL1qrbwRt1zmKH9BUj
 SPkPKmddwf8pA8uQQx9J/dVz8sHN53NkQcZY4DfLkFCQ4yGN7kY=
X-Received: by 2002:a05:690c:48c1:b0:81e:fc6c:452c with SMTP id
 00721157ae682-81f99235319mr1460367b3.9.1785204093024; Mon, 27 Jul 2026
 19:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
Date: Tue, 28 Jul 2026 07:31:21 +0530
X-Gm-Features: AUfX_mzbpwBpN8_BT3IEVhDTA6jNnq1su5DhycjG-OZOMbUi2WDJhSb7cHNgOgY
Message-ID: <CABdD5x=TsT+viCs_D-JDs3tttw4u8Pri0VpQpM24KB-ezKFn+Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com, 
 liwei1518@gmail.com, qemu-riscv@nongnu.org, xiangyi.zeng@linux.alibaba.com, 
 cxx194832@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=rahul@summations.net; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-to:  Rahul Pathak <rahul@summations.net>
From:  Rahul Pathak via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 24, 2026 at 1:33=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch set introduces support for the RISC-V Smsdid and Smmpt
> (Supervisor Domain Identifier and Memory Protection Table) extensions
> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
> Smmpt provides a hardware mechanism for fine-grained memory protection,
> checked after address translation, which is particularly useful for
> supervisor-level sandboxing and security monitoring.
>
> The rfc patch set:
> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>
> Rahul Pathak is working on SMMPT OpenSBI support -
> https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
>
> based on his QEMU SMMPT branch -
> https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
>
> As we all agree -
> https://patchew.org/QEMU/20260715145016.17369-1-zhiwei._5Fliu@linux.aliba=
ba.com/
> , we will collaborate on this work and not duplicate efforts. Rahul will
> focus on OpenSBI upstream and I will update the QEMU patch set to v8.
>
> Xiangyi will review the OpenSBI SMMPT patch set and may collaborate to
> upstream the other parts, such as SMSDIA and IOMPT.
>
> v7->v8:
>     1. Update the mfence.pa and minval.pa instruction encodings to match =
the
>        upstream riscv-opcodes definition
>        (https://github.com/riscv/riscv-opcodes/pull/389/): mfence.pa now =
uses
>        funct7=3D0b0011001 and minval.pa uses funct7=3D0b0011011. The deco=
der,
>        disassembler and the system test are updated accordingly.

I have posted the updated OpenSBI SMSDID+SMMPT V2 series
which aligns with this series version

https://lists.infradead.org/pipermail/opensbi/2026-July/010288.html

