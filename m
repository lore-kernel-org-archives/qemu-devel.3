Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413CECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqBG-0002ui-SR; Mon, 18 May 2026 01:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOqB5-0002tN-4V
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:06:12 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOqB2-0004vf-4s
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:06:06 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd3d7c29b4dso267043666b.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779080762; cv=none;
 d=google.com; s=arc-20240605;
 b=Mt2Ba6fyxoptYtsjBavluWbn73jTQidcUCF47f2EZArjjreANy+q3NvSAYtxqoP6y9
 11MTuauJL9jr01xd06R2dwYoF0pBPFZMB6/av6dTXlYY4yfnJARcs4UCntISqNGC0uUo
 +EufJLQa7Zp6dj6TrBk+N1sLY94wiRu4fg9rxIwFXr34K2IUKwpqNS6Y7NEVSOPJlNPJ
 EtR6/AsLR/MXLosZKkTyByUVJQy0f+WiL5OwY5g3jp61a6UK531X1Tagxrv+VKCf70jq
 RdLvkN2tzfP/UHTAcM3H9LKN3l7sz5Tr66VYYkkkoIK99kiEOTc0nsNSp48i40Rzk95S
 dcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QWmQcYU57p4OMf5I0lxF3//HcJkWkUi/KGPWap3Mk7g=;
 fh=KxFgLvB8QpbaNzAHYkYnodH8BxFTJmWAX/wpmrbktoY=;
 b=hbyRvByi69DjgQwTGFXlHUQftAwxq6dHmM+z2ycoNoeaLZqT7QxOP9SzXcPTWatNKF
 PFvxePTD152DyI+P2ykT5Z1q9qONYOuFMMrH3aCmEdqNeaWOcHiqCn3J1U5O7RJrreZr
 0oTzy/L1UJeXj/KAf3njrm3mr7DIVFFXCkliY91bR0OQzJ+Qu6HuL2csEGD1LxhOug5q
 V2SA1jWflQ38gP2tP6/HjzHsyQJN7I2ws/+z4GLT/LWjx0Q6LG0pe1vc7skXW9I+0Cty
 Ji09c0NNGi8H02KqaY48un4v4aQGAjUhN35PUOyyH4W6b4+IjabxEiMQajJ73A1TLFIU
 Sy1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779080762; x=1779685562; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWmQcYU57p4OMf5I0lxF3//HcJkWkUi/KGPWap3Mk7g=;
 b=Mv5OTIs8RfkhjVX0ouuitP1VRsjc7LP4vPvfWynUAbsDDtYZypTahtPkgC00JJUvG5
 yXQ/raKnBqRXK9IXMqbsRqAMj2FpRBiLt9m1cLmzChMtFkl9am0x05K3bg9p/w6JanLv
 Ymq0Mvd/xXSnUDhf30ALIO1Z6WL5XXsov9CD3sz84etkkSqjgG5whyuGE0MqYbiSSUDv
 pM6WqZDHSSI22E4KnBRfG+ZOn/yf7SL35gFbNLlOrU+uj3JKQytnF+Zyq3lTRe6aON6O
 kLoJwFYsU/eoCcdRm6Stq1iDdSvrw42zRhIX+HeQW9hGJwWH8uk+nD0DU85pXHuO1NSJ
 BQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779080762; x=1779685562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QWmQcYU57p4OMf5I0lxF3//HcJkWkUi/KGPWap3Mk7g=;
 b=SrYfxW5K14Me0wLAUsPI6wBfDeIWkbY/OxaQ7eopRPmI/2FOrQInIDMmcT92YNBmHt
 39+nnMIuvSFce/CW+iAySUR7jKRJpyrqp7vzFh7tcTCo+DAevNpR7lUSjiC7SoWH7ukz
 wYqMx1jXX2u0MZ+x3hprCKUNNipXIin/ML8cAEX5/ZwahQWjy8sVB7U+g4koejz6QMqb
 9LbhmfitEbcgddukzPoD/Rzsl1svX9ADSe+p1vBXb2iDEGottaSyMshUNKQesAFxRLeN
 3r9nciT53UXYKjPi1VATCemjK5fQF1le/dhsdVbeuwIFgwCJuRMNMRyv1vcWJF3URGlK
 i1PA==
X-Gm-Message-State: AOJu0Yy6WEzx65tgFsTxgopucr8313Wdg36D+JAXK28pCiDIbvnqTgDc
 QdSt60XjaWXVK5Fvb7lTMCesq2GZGyeMnCvo0VvzKVZJmotsDLBO42tpw/QC+70NeyRUWOGVZ+J
 3GsfMBAlcscABTBIkbkT85f3I+RSLXqY=
X-Gm-Gg: Acq92OGE5QXVG9UFY4Gob8vap/8TWfUPwjVJDc9WnUQAYhc8Kc5DrMDl6nkz1gr081k
 tOEHYOl3C4p0LxqoNF9b7UJGMPovp7WmwLhpVJB5PTn/SwudzXTa35X8+wdKlNGrBiitcA2Sqkd
 rx3nRSF1BNGSkCvVsoAqNPccIT/5gwujrqt+e+lfMPnjbhnUsRQDB5md84DssitsqJelTpYVYNB
 XrclE12NHVvQGm0BSj8Ng+SFb53wCv4fgWpBb0cC6RKtI772UtLHENf0PcrVqfLMh5ZHywpCBHc
 4jJAwNR5vJLtihrsR6lZnT/pmA+Ftdz7fhefBw==
X-Received: by 2002:a17:907:7287:b0:bd1:9f5c:abbf with SMTP id
 a640c23a62f3a-bd51798eb09mr677859766b.43.1779080762175; Sun, 17 May 2026
 22:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251231045000.30120-1-jay.chang@sifive.com>
 <CACNNAjPw1RAQKctNWa5=hVs__qz8uOqzd6VrL8V2XvEfEaepRA@mail.gmail.com>
In-Reply-To: <CACNNAjPw1RAQKctNWa5=hVs__qz8uOqzd6VrL8V2XvEfEaepRA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 15:05:35 +1000
X-Gm-Features: AVHnY4K3dhzRjqly3If50wVEfsMIzBLtcV2X74jzHfjphO6m-FAqPfyeEA_g6lM
Message-ID: <CAKmqyKOeabe3td8s4xxidKzRFEFaGADFAgZkbH4x0y94ZCnxbw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/riscv: Fix PMP address alignment
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 18, 2026 at 12:51=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> Hi,
>
> Gentle ping on this patch.

Can you please resend the series, I lost this the first time around

Alistair


>
> Thanks,
> Jay Chang
>
> On Wed, Dec 31, 2025 at 12:50=E2=80=AFPM Jay Chang <jay.chang@sifive.com>=
 wrote:
>>
>> This series fixes PMP address alignment to comply with the RISC-V
>> specification WARL (Write-Any, Read-Legal) semantics.
>>
>> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
>> value is smaller than the PMP granularity, it needs to be aligned
>> to the PMP granularity.
>>
>> Changes in v3:
>> - Use ROUND_UP() macro for NAPOT address alignment
>>
>> Changes in v2:
>> - Fixed commit message grammar ("it needs to be aligned")
>> - Use ROUND_DOWN() macro for TOR address alignment to improve
>>   code readability
>>
>> Jay Chang (2):
>>   target/riscv: Align pmp size to pmp-granularity
>>   target/riscv: Use macros for PMP address alignment
>>
>>  target/riscv/pmp.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> --
>> 2.48.1
>>

