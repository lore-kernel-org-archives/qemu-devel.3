Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA51C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 09:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viUV8-0002tZ-R9; Wed, 21 Jan 2026 04:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viUV1-0002kD-CA
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 04:27:40 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viUUz-0007Jj-L6
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 04:27:38 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78c66bdf675so55140787b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 01:27:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987655; cv=none;
 d=google.com; s=arc-20240605;
 b=FzOOV09DqUSBNJePKmWHdXqIU4CzbRBZsRy9gWiKJ65Rc4/N1GUoOtJX5MzqTkDzyl
 o7csuFqoRSPMMgYv+UDFPxd5drX77ASvGf56Nb8mBRbRh+1OpvPrKhyEdTS3a1kh30eR
 kdBL0Gakb6s/BqcWgakAbC4tTmeqTr/oHym7rRki2M++XToGB2qNVqCLhkjt2ez0KFUX
 ePEHhgxYlcILSk2nGhyN6aExqewFLNT4rnSD9EelMcyIiTctUWEEuTCta9GMrkC1fDZk
 /mTPYdtPT2SnT3FXl39EZOHhvfNIrGk8kSW47vwldfSo4nGzTTgOGC7/e5HAxUZs/tfg
 flRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OiRDwoLtTsknQ7PacWzNbXiZ/sHl5VJBOJ2/kVClTqw=;
 fh=h5XwtwbFZRZ1FUOtZRgdKZteGKilXmRo+GqhpTRH7tM=;
 b=iw/fbEwCNRU3fS/RhB+T4LDj76ZrUg4aB9Ek66chMA/DGTPw5ILBsbrFayEOWt5Stz
 xjUH639ByjHJB4B350HKlxMzxha/Kdu/JWc3rMxnMbor1Su4ZeQqEq8jmd7nA0JprKGi
 SJi1Z8DZNE0Zp69MmkjMy2IR6Dz8zFWeCjdOiRVlniBh/GJJN0shY5GMrorsPlLKdF76
 S7+w3kqsKyHdZ7K8uR9bfD97c5hhia7UyhWDiFxh03eCNAOgGLX1LchqBxikkLhKCNc4
 YLqWlnCC1yiWS7+kLTJaHDILPjBinVZ4PKqo0PEhbez92Gt3NGmwFxHn4jSLMRHOIobG
 sZHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768987655; x=1769592455; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiRDwoLtTsknQ7PacWzNbXiZ/sHl5VJBOJ2/kVClTqw=;
 b=pEYWHr5tKQxpDDnP+P7hpgbTRJK3WegyKYlsQPVekY7oX6Y+X/WcX14x0CXnlCoNcg
 p5B88R/Ze4cJPWdcQ/gXDHL/82zhhXcrlG1kLbjsg/EyzMVLoFswSbqd/ZsQtArNIic2
 S1vnOBlIJP9xFXhqlcd57WUM1d6fBTM3wLmOCfU0wQTzb7ueMjqcA2ZG1LwLffbLp+4z
 HAitn6rbUM/Gq+b6oFt3HRvhKdjqkPsns6WJ8BOsdcTCAaKzxmsuwOZuVL1yNV7c1Wzs
 msz8651ApWDxCWGyxvgt+NOQERoyvHXcUpP4jNwKJHDzx7w58p1UXtZgslNK+GQk7MpU
 Bg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987655; x=1769592455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OiRDwoLtTsknQ7PacWzNbXiZ/sHl5VJBOJ2/kVClTqw=;
 b=jbbO7YF6U9jtKAgc02v8OCotC67EaYhisEKFXOCs4EpfxzDMN2AlT7cVY1wN3Hckz/
 WkCMUn1/D//FkEmQue1F0SxEqfEmNn3jgwmUyi0Un6wRjSHaPO0YA0mW7jMLl6dVj2FZ
 THj/aMJ4CKPxe699x+qbPQNlEJG2SZfst3Qupgi2OP1hD+9VbBTHsmOQ4s9T7sUpAWZz
 8m6LhKJ/OVjhhgdGdDXIIvUY+rN5FKiGCHz/79gv83nyI7MuRUQYMIdsD70RX1mtxpF4
 tY9ptm1GwzXbBT/fqBV9ZqgxMNDK36VEa+nk2SZTBIT66GwAVaZS6sHR8rpiV6fWu76v
 zRSw==
X-Gm-Message-State: AOJu0YwIj39m9n2OiVfvM641dQ8C6uYEd0HqRzCN1CZo0zl7/7It4lJj
 MOoKM0narSu75hrZSSt3B48oCVda/k5qcrA2/gM2lrqlHhgnHR+R3jj7fAtn1lS9x5nUG+wfK9U
 x1AWAsPRRkQSK3wFjl+svOVvxrEYba9NOsxzb6HUmjw==
X-Gm-Gg: AZuq6aL3uYcruOaA0mT0urOmGrjxkQH6+3Ozm4lgtgp07rJC42IWvbZs4zt31Ic09YJ
 ozZ/1DQWKLvGV9NeiccUASvsSNSAhHuY2bNVNJgJITJ28Z1TpmK38ykq0PLypR6wAeUlQkWu1oN
 eH8WSdiSSqw+LD50XkTyWr5/YgKPE7PPSWloQCBiMdr2Tans9SqPrMZSebKQ9aBLEXzIZcwMlnY
 1q6EoFHsDaZBFHz3yAixUjfMzDA5Hg+FBtYoAPTTaRI02lZXMjKZJMrqZninhPjjK6p7w==
X-Received: by 2002:a05:690c:10c:b0:78c:5dfe:1b57 with SMTP id
 00721157ae682-7940a245084mr38019387b3.38.1768987655428; Wed, 21 Jan 2026
 01:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
In-Reply-To: <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 09:27:22 +0000
X-Gm-Features: AZwV_QhbV9c8W4eGRYL96WaTovp4ICRNg0iXp8GbxBedwhmIWZiOBQd8zxtw9Wg
Message-ID: <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 20 Jan 2026 at 18:44, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 20. Jan 2026, at 19:02, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
>
> > The MSI controller selection logic is already pretty confusing,
> > and this is making it more complicated. I don't think we should
> > need this machine back compatibility, because currently there
> > is no setup where you can have a GICv3 that doesn't also have
> > either an ITS or no MSI controller.
> >
> Hello,
>
> This was to replicate the =E2=80=9Cno_tcg_its=E2=80=9D where this was don=
e when introducing TCG.
> And for the purpose of VM save/restore on HVF with the older machine type=
 continuing to work as expected.

no_tcg_its is there for backwards compatibility: on older
QEMU versions before we added the TCG ITS, if you said
"-machine virt,gic-version=3D3 -accel tcg" you didn't get an
ITS; we wanted to change the default in new machine versions,
so we needed the back compat switch.

What is the command line that works today and where we
want to go from "default to GICv3 without ITS or v2m"
to "default to GICv3 with v2m" ? I might have missed it
but back last year when I was looking at the current
configs I didn't think we had one.

thanks
-- PMM

