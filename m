Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30AEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nRt-0000tH-Jz; Tue, 29 Apr 2025 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9nRs-0000sM-5z
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:04:44 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9nRq-0004jj-1w
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:04:43 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so1211978366b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745942680; x=1746547480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJclPTx+7JRnM2ofio18oJppuZaQyKGGddVTpxIwTnk=;
 b=zsp5jO7IaFoOgfKxrkAJrn3jgcc/CJ+Q+sFzq7MwCMDIOpUN4YtXd7lUvS2XVrbgRF
 9IzG6g5Y3LST2ASMnfksU494A0E71bxj8ivEW9h6tdifOGqZDusER7yJY6rdflW5Xvtb
 Q6efULtoAREJ3IVQPYypux/XPT26sDfbsXiPdoLdkAp3AfVOnrJxWCfNV8a2HhiM0Zrk
 BCENDIaFm0JnxuT0kd1bRHx3F3U5GAX7aDXB7QP5+9xj/L327pOJyPFJz4U3Ue++Ocfp
 SVG/93n2CVw0GrSK37+FzZGHV8r2AzpZeVtV2scviEsLZvj6nC9KEPpF1htKo+qGq4bE
 pUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745942680; x=1746547480;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AJclPTx+7JRnM2ofio18oJppuZaQyKGGddVTpxIwTnk=;
 b=J02/ZEscyZuqLT20uuKm6qXyuQyxuiIJPqyHlaRAm1W53zxbZ41/431xRzvXGm6onM
 U6ETdKKjecSEf5//vy/uQzvdZFWLsD02+bhULPrEEqRBU1uONXM7de86duFNuBOcG2yc
 Q17SPVpaP3ATzp6rWBi+9dn0jDAhxmFXOrdsss6LyGRpVgmqbQNNEGWxz1KCMma79WbS
 ZQyBpcT9wyDdzxX+TyLQiuW2D9IrmHM4gZDPMGJqF8yDlI4AFcJfxj6l5FeDwLH2pliL
 O7zxt3LyAoYDYBMvuwZPu1Jcurx3Sno4wp+oHrwPpczu+guEQuG9jk0rx2HGmAbBBsmq
 T6vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH7WhNcV8ci3fl2rw4IXFfEdyMNrH36KcvdqkiYZRh5E5PVp4iU9zexieihDYlKWgXnBi2PQHDSpKk@nongnu.org
X-Gm-Message-State: AOJu0YzgEJ7/uNJwtVxLQIeS/IbxZASF7AEI6g6B5lToOAwgMzMfwYTm
 B3T++yQ8Yg5tgOVIdtuKgI65Os0CCad3t3Zh1wyTAoO6/egf7WS+pd+76pbCjkA=
X-Gm-Gg: ASbGncv5HKOjYo6mRnbkEqLeVNpRQT0FljpbRWLqzhGuM9yYLc/CFIgioF7U+gNj7jy
 vbMNQKudRbZHT6pYRATtDtL95uQJZxnAMisW8lYl058+AA8Vsc/vFeZcWsKgyD2fVr1r2CtWWpg
 +029H5IkT+z0jcJNYEdhtqPrCjOUD6VwAS2uFDWHBGBexMqKk9cJ2HmB+fTMjBj5r54T0dsHdIZ
 aOz0v0lo4E0bu2SfiFJT0OcZmxbxWG7J+7mJg0vnNhf00WdpxV0b/ULi51qTrC7GMbN+yNBVWbs
 +UD3SRp3sUg5N0xoFGun1YU8RV0axxiryfqKNs1dYqU=
X-Google-Smtp-Source: AGHT+IGvgHEsHj/PjgPsEJzhBBLMN5XnPkBJShqAn2nWOj2f98e6igjXPbXLY9EzZeksaAzXEemHDA==
X-Received: by 2002:a17:907:934a:b0:ace:3732:8a86 with SMTP id
 a640c23a62f3a-acec8758f61mr360643666b.41.1745942680220; 
 Tue, 29 Apr 2025 09:04:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ed70611sm807701166b.143.2025.04.29.09.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:04:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B88965F863;
 Tue, 29 Apr 2025 17:04:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu> (BALATON
 Zoltan's message of "Tue, 29 Apr 2025 16:40:28 +0200 (CEST)")
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
 <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 17:04:38 +0100
Message-ID: <875xin3qeh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 28 Apr 2025, Richard Henderson wrote:
>> On 4/28/25 06:26, BALATON Zoltan wrote:
>>> I have tried profiling the dst in real card vfio vram with dcbz
>>> case (with 100 iterations instead of 10000 in above tests) but I'm
>>> not sure I understand the results. vperm and dcbz show up but not
>>> too high. Can somebody explain what is happening here and where the
>>> overhead likely comes from? Here is the profile result I got:
>>> Samples: 104K of event 'cycles:Pu', Event count (approx.):
>>> 122371086557
>>>  =C2=A0 Children=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self=C2=A0 Command=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shared Object=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Symbol
>>> -=C2=A0=C2=A0 99.44%=C2=A0=C2=A0=C2=A0=C2=A0 0.95%=C2=A0 qemu-system-pp=
c=C2=A0 qemu-system-ppc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 [.]
>>> cpu_exec_loop
>>>  =C2=A0=C2=A0 - 98.49% cpu_exec_loop
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 98.48% cpu_tb_exec
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 90.95% 0x7f4e705d8f=
15
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 helper_ldub_mmu
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 do_ld_mmio_beN
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
pu_io_recompile
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - 45.79% cpu_loop_exit_noexc
>>
>> I think the real problem is the number of loop exits due to i/o.  If
>> I'm reading this rightly, 45% of execution is in cpu_io_recompile.
>>
>> I/O can only happen as the last insn of a translation block.
>
> I'm not sure I understand this. A comment above cpu_io_recompile says
> "In deterministic execution mode, instructions doing device I/Os must
> be at the end of the TB." Is that wrong? Otherwise shouldn't this only
> apply if running with icount or something like that?

That comment should be fixed. It used to only be the case for icount
mode but there was another race bug that meant we need to honour device
access as the last insn for both modes.

>
>> When we detect that it has happened in the middle of a translation
>> block, we abort the block, compile a new one, and restart execution.
>
> Where does that happen? The calls of cpu_io_recompile in this case
> seem to come from io_prepare which is called from do_ld16_mmio_beN if
> (!cpu->neg.can_do_io) but I don't see how can_do_io is set.

Inline by set_can_do_io()

>> Where this becomes a bottleneck is when this same translation block
>> is in a loop.  Exactly this case of memset/memcpy of VRAM.  This
>> could be addressed by invalidating the previous translation block
>> and creating a new one which always ends with the i/o.
>
> And where to do that? cpu_io_recompile just exits the TB but what
> generates the new TB? I need some more clues to understands how to do
> this.

  cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;

sets the cflags for the next cb, which typically will fail to find and
then regenerate. Normally cflags_next_tb is empty.

>
> Regards,
> BALATON Zoltan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

