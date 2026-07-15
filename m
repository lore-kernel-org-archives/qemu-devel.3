Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DC1C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjv01-0007Up-8J; Wed, 15 Jul 2026 04:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wjuzu-0007UX-1h
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:29:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wjuzr-0000fF-51
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:29:40 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3860f32307bso823196a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784104177; x=1784708977; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BeGqMOgTlDCagNu/bWSBNjr6Oi8r2xL+ExkajpaSico=;
 b=BqD18WOcph+DlAXDca/zTScz9aWUf61T+90WTXTnwcDJXQHewkVDsy6SGY9//1FW2z
 rgJwL0XgbVn20KsRCgkv6yQMqdYSPtd+BdhkL3mfQFZXbQG1NpekVh/DxtFP7Zpaw/Nm
 jo7RYzyYna2Xo2DTIa2gLue6NjfeKyhAkoMxS9hrbJZD+1A2WU97yBQekTYgYAb6Q608
 LImtEL4v9UUSffVl3oBzzrdfaZHTIoxfFYFU2wawyiMxl5uPGoSfvquryiiIM2na4n9G
 gvNFSqkZiVC6hj1OGGiF5VXI5/BSYwNmyMDTQyQOugeqYXdX40vquXdy/F99G3GD2r1t
 wg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784104177; x=1784708977;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BeGqMOgTlDCagNu/bWSBNjr6Oi8r2xL+ExkajpaSico=;
 b=hwSYjPpgTd9u55prtMHWM9E056VKn5noU/G0bBa0HxG87o1BA1eQm8RTmwch4yASpD
 jAycBaYsBfQkFSKV7vygCaocZfYgkqvNm+WBta/RuzzUkPx6p0hzxQ1MvUWnrAhK2GG5
 hOAZTNa+Od5AfgVPGLZ2RDfLUPj1kIscQE/EgHfJ3xkCPFkInxsXbUUqDWW0m512N6To
 8ndZEldoS/xfAUmJQz9fheMJvDgfMQDRb1566M4jIGoAVWosuk8tujUFUH6uxq9Lfyew
 +98Vy25/IDQD79zwFwZ7REFZqPY3Z/K+BrH/A1olSWWBzTWzExiKFY7ABEp+uGF/6kZM
 NRDQ==
X-Gm-Message-State: AOJu0YygFW/uhWcqlaJ56z/Lvm+OS18JAwBUuC4+KiHhHCZktDoqaO2T
 TeUERb0z1r2uhGXPY4hz0A0tjztxgxKr8NKHCs1Rofp/T7GetBKZSJKZ
X-Gm-Gg: AfdE7cnJMqY9zAlIAXq/RD3eUqyzuEhHOjRMGL/ek6SvasUPi6RjaVyz+D2aofaEzkt
 uZtbdzC5uhpkRdCfp8RTfG/vJ1wDVYzgFWE2EODo21cWFYfTnJm+WlZXH9SQJPppPRE3UFUFl6g
 ZXU1zp+S4htOQEqsioRgwojQRgIJo1wyjoASTJOlWwmf/XqDgMYuIovNqnxiSPaPTaPBmCRQorO
 mzFKfF41xNEGywYBgq4DxDT7/Dn+cg9KldNZ3qeJmwOUYWjsUfz57zRlmXDvUnl6G6DWoMtYY/0
 46D2wXqGslOgicLQtT+TmQ043Mr88EPUEQfLElbuWMLqrmpT8J1sBtiYiZLoHBUFnFbWaG/vmXA
 OQhzO39IlBEotK7hH4S2Wk+fcbFepHiKa2VofVDyBrsmgMK/1vC5kHfjLkpcN/8Hb/48D6aXxdj
 LEg67mpV/SyTiMuXdxOixAWo5N7u3NrSGvvreY
X-Received: by 2002:a17:90b:4f81:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-38dc7bd893cmr10424114a91.4.1784104177254; 
 Wed, 15 Jul 2026 01:29:37 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172e46basm2785524a91.9.2026.07.15.01.29.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2026 01:29:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] target/loongarch: fix data race in CSR_ESTAT
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <fc1b3da5-2433-7f23-03c4-c1d0a0b5a6f4@loongson.cn>
Date: Wed, 15 Jul 2026 16:29:22 +0800
Cc: qemu-devel@nongnu.org, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FF8CCC1-5065-45E0-8EB8-B414F5C87056@gmail.com>
References: <20260714-loong-race-v1-1-54111549c95e@gmail.com>
 <fc1b3da5-2433-7f23-03c4-c1d0a0b5a6f4@loongson.cn>
To: Bibo Mao <maobibo@loongson.cn>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

> 2026=E5=B9=B47=E6=9C=8815=E6=97=A5 11:16=EF=BC=8CBibo Mao =
<maobibo@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 2026/7/14 =E4=B8=8B=E5=8D=8811:40, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> The CSR_ESTAT register of a CPU can be read and written by both the
>> CPU thread and other threads (e.g., the interrupt controller thread).
>> Currently the possible readers and writers of CSR_ESTAT are:
>> - Readers
>>   - tcg generated by trans_csrrd(, CSR_ESTAT)
>>   - loongarch_cpu_has_work()
>> - Writers
>>   - tcg generated by trans_csrxchg(, CSR_ESTAT)
>>   - helper_csrwr_estat()
>>   - helper_csrrd_msgir()
>>   - loongarch_cpu_set_irq()
>>   - loongarch_cpu_do_interrupt()
>>   - loongarch_cpu_exec_interrupt()
>=20
> yes, there is contention problem when injecting interrupt to vCPU in =
TCG mode, only that it is a little strange to use atomic method on CSR =
estat register.
>=20
> =46rom another side, only loongarch_cpu_set_irq() is called from other =
threads, the other APIs are called from vCPU thread itself.
>=20
> How about using method like KVM, adding software state =
irq_pending/irq_clear in structure CPULoongArchState and using atomic =
method, add cpu_sync_interrupt() and it is called function
> cpu_loongarch_hw_interrupts_pending(). When vCPU thread is kicked with =
new interrupt and executes cpu_loongarch_hw_interrupts_pending(), it =
synchronize software intterupt irq_pending/irq_clear  to CS ESTAT =
register.
>=20

I understand that adding an additional field which is protected by =
atomic
operations to store the pending changes to ESTAT in =
loongarch_cpu_set_irq()
and merging it into ESTAT afterwards in =
cpu_loongarch_hw_interrupts_pending()
is simpler and cleaner.

However, there might be a problem here. In loongarch_cpu_set_irq(), =
without
reading ESTAT, it cannot decide whether to call cpu_interrupt() or
cpu_reset_interrupt(). If ESTAT should be read in =
loongarch_cpu_set_irq(), then
ESTAT should still be protected by atomic operations.

Cheers,

Miao Wang


