Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C40C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeLy-00082C-Q4; Fri, 17 Jul 2026 04:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkeLx-00081w-1y
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:55:29 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkeLv-0005Lk-Co
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:55:28 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81ed073fed0so43359097b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784278526; cv=none;
 d=google.com; s=arc-20260327;
 b=BhCJ5KOp5w8MN/WoMO3OnoRVQ5Ys+V6uzZ5d1jRDO2qw4Je5wjO/vbMJsZj2KPWyH9
 Cd9f8W9Bva4Qlfvz5joHv+MjOxJuQpAvPIOOhv5ozP7B9wcJ03uBXvN/MEBG0UprW3Bf
 pzmRRnGk1AVgdvJWVFJ/CxqemNZYfZGeaKwzXTBANyRxaXyTb+La90TtkjZcgcuHBCpS
 NtaH9OcmbykoLeFfoC1gZ6AjQ/fp3K6xPLugiuRy9mUnUrUMHC19rlyv5Ca0x4bbZtd1
 YOEdiyToQIyNnbo5BzaWlT31Scwlckm8uxeJK8Hp+tSvMVL6CsNum8t+NbVF8pmEPRar
 Vwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qfDpFj5sI7c1lMBs2+vjZfAUb2p+bBhzlM8dFQ160u8=;
 fh=ViYreDVnUBDMZOrvRzzwMHgxbyDdY05QoGLSYCNlAHw=;
 b=HQDqXzV3F6rnGEa8LJ2avMHixkIJCcSyrXGm+GsYTQCpVQk+XRPv1QlJcsjbZLVIYB
 L8XW0Ss+rKXiSqjvdydtu5EBwmaXEF1RSawzKr33IadDwHwFMLxdYdiZylPuYjHP4p6k
 s7pof3ebNr2L83TPPIjSDl7Y1ti859RLjkzCAZqIliVt1aqCzikNq8HcLRRHncTUVIDD
 LMmSc17l/1KplC1SKAdAm9LYmlDyWvt1/PHFaj+CwG7WEA0F75HgKUpIGowQrWbBDxU2
 VNo7apVbBjUspZFIwaDwdKJBXo1UUTiaZDPVAlKZ5fdnBK/JJ+t74/81h080V3HcRt7M
 jpKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784278526; x=1784883326; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfDpFj5sI7c1lMBs2+vjZfAUb2p+bBhzlM8dFQ160u8=;
 b=KoF3yKPQSFaDe/Kt9avpmfj9d79tX7MyBbJlpIIdS4xdGSj9ixIhkOcqJdFMIFMmck
 Qb3kXoUMAWE7D7Do6biMTkNE0d+iNkIneYch2kWbxM3V9CfVa8XlkM3Mv2Wld5/MAdGw
 dwOfK9PfdRVECKody5pbhUlhZ1RecDsBKHaS1eSV65y2nIvQhGTdkeZsYRNgteVfE23W
 pKwsvHwUZuUb29RU108TExmbpOf1g+ABFArL5zwUYCW9W2rfyg2PsZnG3O+COX/zYLd4
 8bHtjMbH1va2YeESeNsz3fr9/Kfafh4NeBiQS/HRJseCUHaJqdcpt5oPM8x301r8bRMQ
 6Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784278526; x=1784883326;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfDpFj5sI7c1lMBs2+vjZfAUb2p+bBhzlM8dFQ160u8=;
 b=fcPfsvoDpAxrDxFobcBMqeFcSa2X0t1dbapnr+qI6qe8d1Poc3rHsHKlkj9OCtIz6s
 EfDbSpK6HZlz8VyEgSo1dnCTcyjauQLNPkiZPB8XUzIziSai+ZYEB4FdO1dE2luL+mjd
 awExSF2JjbWKsnM2S2TYFk8LLhC1EIoEU5AYH4SURWa9P/Dk4qi4EA5qfV9JCQv7/kyY
 HFUxKPtajyUA63/gJtaLdAupaJKg9tqScM742JyNdR1FYftlqGhcEHzbILA/FTrVi8Oo
 CpcRYYwczKv/sOpKzVkaooYfumd54dPUObHXIK4yGWCaX7QAyWcgZVyJOgvu3ssQVv2Y
 A4nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFinQlks3AeH94ZtN7LAGxmgWugIfDeNtjKjqeRBMzHMCaLWDMxPXo9epW+frxBjdUu6CCDwYADBKV@nongnu.org
X-Gm-Message-State: AOJu0Yzu6sm9kTubqyxfF6qMvyOlu21qXI4IcuJcTBW6Xs3zsXY01tPZ
 ZHkbUp8+CUZzRuZupspmxhcZ9D8J9TMo0YxQJTIQS8Vl9fb/RHax5yhX1KWgrzdJ23KtOqM99kp
 II2s+sUUfXe33+qtupM8c/8c48YgDAAuLv5lXv8yV3g==
X-Gm-Gg: AfdE7cnR617qNxeJ6WTUpundb77Gpr67Ik7Y3UjQW9c0vZdDR72lf7QJ15W/Z18M81q
 nPH2Dvx1Fm/0DxsflHO8yfXV5Yvx6k+cqpesGYr3lqD3mSFG8q05MNSmRpGrrYhkcOQ0z66MH27
 BG0hRPcLcfnoSj1oqQggR9ycGhMTpINVsTC25Xt9RpJZGOEeYlEz7q0rNKqrql4UHBJyW/6H8zX
 NQ996OT8b/vbIsuBkd3ragt2WRPrUsIXemepJlPVvasC3mbkBpEJUQSeYAQ9bHvmPr6Yg1Uq+sJ
 uC8H+DTz8Kn9TNZ72xbIuMNXRKskYC1SLrJRtH+K3tWMWjGRwoUarU3b
X-Received: by 2002:a05:690c:3a0:b0:81e:b981:3eb5 with SMTP id
 00721157ae682-81ef25ae906mr4941747b3.23.1784278525669; Fri, 17 Jul 2026
 01:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 09:55:14 +0100
X-Gm-Features: AUfX_mzIBdcuIA0_XiDSTG-R6hxX7SXzzbEIjX6Yf0tDT0ixLrWe6e-nujP8a_0
Message-ID: <CAFEAcA9FoE33wE9HqcsmP8Xe=g6-JYCGgGyw8YnaEJs8Z5Kbbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Correct cbo and lq disassembly
To: frederic.petrot@univ-grenoble-alpes.fr
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 julien.thillard@univ-grenoble-alpes.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 15 Jul 2026 at 20:08, <frederic.petrot@univ-grenoble-alpes.fr> wrot=
e:
>
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>
> The CBO instructions were, AFAIU, disassembled erroneously.
> In addition, lq (load-quad, a RV128 instruction) shares the same
> opcode space as the CBOs, which also led to incorrect dasm for that
> instruction (understandable since RV128 is an experimental feature).
> To avoid overlaps, we now require that lq is decoded only if
> rd is not 0, as CBO requires the field corresponding to rd to be zero,
> both in dasm and decodetree.
> The last patch corrects the original indentation that was making
> checkpatch unhappy.

Reminder: please put some disambiguator in the subject lines
of cover letter emails. "Correct cbo and lq disassembly" doesn't
say it's riscv related so you can't tell without looking into
the email body. Doing this assists people in easily scanning
through the list to find or skip over topics.

thanks
-- PMM

