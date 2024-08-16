Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F05C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1semaQ-0006op-73; Thu, 15 Aug 2024 22:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1semaO-0006nE-B4; Thu, 15 Aug 2024 22:21:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1semaM-0004ci-Mx; Thu, 15 Aug 2024 22:21:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-710d1de6e79so1151071b3a.0; 
 Thu, 15 Aug 2024 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723774861; x=1724379661; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wo8oq6ikqHHNWFPyOFoDlGBbwLaYJiM4Q790YHi9Rp8=;
 b=GOof6UpTX9/Md+rBvuBwqTuZKQc6NGE/BW4gPe9FjRWTI9ySbPyz7XJ+OXaugwy8py
 1ND+O8B3DHCkqulCbxx3HPBWonbSv52Pu9BulvglCRx7B0C4D4BELIJZU1jNPWdXqHny
 WzqT4yxWbotR8jRk6AIC6a7T3i5YvqpqHs3Cc5PrROh72e6YYsiCv1vhM/L025ZRdrdA
 BDdlnKl/zbE/mMUYsTcYgQ9mUsYZpymK3bi1f731f8oRvfoUa7NbJsyh2A9bCnDd3pXJ
 gz9MIxkb3dfYZRY+BO/CreQb6n4/JcGGgC1sOJf597B+KZ/+ttz8SSmYG/qCc4ZzAJp4
 Fh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723774861; x=1724379661;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wo8oq6ikqHHNWFPyOFoDlGBbwLaYJiM4Q790YHi9Rp8=;
 b=W9xm9w9cGh5ofG2eEbYqFxUScWSl6RtZ6PsyQbI9yUrVesB+RWjDkJaFj8B4u53j7x
 ls57uwJJ4PuYCkXcuNDIors+8dMkrfTGmsuTIkeXrWbd2pklm8SVhRLMHLUxy7P2iXgG
 ZXd1V6f5965NpElpR6YYXnogfUT28bdw4p3igmbRIHN8xjvc/baGoyWSAV5CHKXQ+7Av
 aJuTD8GoWILEstQ80IEk+HjjyBlvE9R8R5GczLFOR9/17w+te6RxNGe8+GHokvU0Bech
 xNuxKkbnyS/ZH29nISt19msEdzS3pai4ibSHYNTuye7QbzAb2HymRsg7mYvpVVmZXdc9
 0tRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDKCc+lPo5AffZDoGyNq3Z0oFRAOXefufaiF0/kiGXZiwdlZp6u9QN3Lcb3R9UxlrJxFheQljRyvwOyiHYelA0cpos
X-Gm-Message-State: AOJu0YxOqinHg4gHD+Y0RYT3pKtZkaEWwhwYpbbusQppoTO0GnLHeO8n
 gD8MX78Los0LLE0/ypSu5BlCigrtIfLFIFj4IRCOrvW6782YfaMT
X-Google-Smtp-Source: AGHT+IFizLm1+xDJhuIziDmkTvh7CO3eNlmgJpKdmdMySNj62xnDQW9rjwQoKADpr1pJj9Z7M/Lhiw==
X-Received: by 2002:a05:6a20:2d0a:b0:1c4:7a11:9ef1 with SMTP id
 adf61e73a8af0-1c904fa9866mr2202327637.15.1723774860609; 
 Thu, 15 Aug 2024 19:21:00 -0700 (PDT)
Received: from localhost ([1.145.119.203]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae0f466sm1660709b3a.53.2024.08.15.19.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:21:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 12:20:53 +1000
Message-Id: <D3GZ6RL9K9OQ.1A1YQ9YSZPH3E@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Aditya Gupta"
 <adityag@linux.ibm.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v3] hw/ppc: Implement -dtb support for PowerNV
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240813134536.1204513-1-adityag@linux.ibm.com>
 <D3GB5QVADVQ1.XZM3FFV52LIW@gmail.com>
 <6c0cdf26-9795-4998-9d80-1d0095700a59@kaod.org>
In-Reply-To: <6c0cdf26-9795-4998-9d80-1d0095700a59@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Aug 16, 2024 at 3:52 AM AEST, C=C3=A9dric Le Goater wrote:
> On 8/15/24 09:31, Nicholas Piggin wrote:
> > On Tue Aug 13, 2024 at 11:45 PM AEST, Aditya Gupta wrote:
> >> Currently any device tree passed with -dtb option in QEMU, was ignored
> >> by the PowerNV code.
> >>
> >> Read and pass the passed -dtb to the kernel, thus enabling easier
> >> debugging with custom DTBs.
> >>
> >> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
> >>
> >> But when a '-dtb' is passed, it completely overrides any dtb nodes or
> >> changes QEMU might have done, such as '-append' arguments to the kerne=
l
> >> (which are mentioned in /chosen/bootargs in the dtb), hence add warnin=
g
> >> when -dtb is being used
> >>
> >> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> >=20
> > This looks pretty good, I'm inclined to take it as a bug fix fo this
> > release. =20
>
> I don't think this is a bug fix. is it ? AFAIUI, it is a debug
> feature for skiboot. It's QEMU 9.2 material.

Okay.

> > One little nit is MachineState.fdt vs PnvMachineState.fdt
> > which is now confusing. I would call the new PnvMachineState member
> > something like fdt_from_dtb, or fdt_override?
>
> I agree. this is confusing. machine->fdt could be used instead ?

Yeah that could be another option. Test pnv.dtb or add a new bool
to pnv if you need to check whether the fdt has been provided by
cmdline.

> > The other question... Some machines rebuild fdt at init, others at
> > reset time. As far as I understood, spapr has to rebuild on reset
> > because C-A-S call can update the fdt so you have to undo that on
> > reset.=20
>
> C-A-S is a guest OS hcall. reset is called before the guest OS
> is started.

Right, but when you reboot it needs to be reverted to initial
(pre-CAS) fdt.

> > Did powernv just copy that without really needing it, I wonder?
> > Maybe that rearranged to just do it at init time (e.g., see
> > hw/riscv/virt.c which is simpler).
>
> The machine is aware of user created devices (on the command line)
> only at reset time.

Ah, I should have followed a bit closer. riscv, arm use a
machine_done notifier for that (and x86, loongarch for ACPI / BIOS
tables). So that avoids fdt rebuild after the first reset I think.

Anyway I don't really mind then, following other archs would be okay,
but keeping similar with spapr and avoiding code change is also good.
Maybe add a small comment to we use reset rather than machine_done
notifier of other archs to be similar to spapr.

Thanks,
Nick

