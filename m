Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DF9D2AB3F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5mWB-0006Yv-2B; Tue, 29 Oct 2024 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5mW9-0006Yg-2I
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:44:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5mW7-00029M-8E
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:44:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d462c91a9so3943143f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730209453; x=1730814253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WGZVHZzKPdEZ1qvDO96mNX342gz9Qqawi5Ct5T/r40=;
 b=NjoFDVuCHOeNDg1l3GCb8e1iuTpgHI9idjX1p7Q36mhQOGGCWPrnoHqQtG6nRPROIh
 E/dobkaGiCbbB9bywLG19hOijLgY88/anmle1EOLMsmU8qwHY6YvmjuN2ngWetSiXSRt
 xAIIoNUtGvC3YfFmAezudaTM+xRFJ+oEwhQHhzjD1xeh/jnjjxcYeCfD7wrIDc3GSjIw
 3qcWh60G3E7vbUcEhGPMBq//7iCtxYiUhgUQXxXOH2kp+wUjVc/crL+cfptAvPWTAmlz
 Noa3nPIt/2bThbR/kcC4BSFIdbweAGZ0+ARO2h19i76YHDEANLu0E499PwIITxFBKZNh
 hMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730209453; x=1730814253;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9WGZVHZzKPdEZ1qvDO96mNX342gz9Qqawi5Ct5T/r40=;
 b=oxo734KHd7GIKjDq3QtD2fVKLZii04drcPUQYAkxbrDujAFUm3YKnGF3rcQbKa7v54
 qndlPhEZTzi6X0dZdGj18s4ohbK55fDJmgyaf3vx12ojymrNRt/sj6j5+MXGpJ4sQqUO
 pTXHN4dFx8nr0RJp3JMCTViAX47+T1aI3E/MzL+SUsIZa0rEoJ+AH8kV2hv0qeJdKuNN
 H4UQu6VSuOe5+GF7+U1lNtxl5bKgsTkaGEsozKsGNDFXCJa2e7ktwxVdobkfK2ODT60p
 mivqio60TadBYBvPoFEZ8sELrVKKuyovH74KPGjq1NOd63K2e5y+7Iyd2FFZ40RS/fcx
 y6xQ==
X-Gm-Message-State: AOJu0YwXMlmwhjGSi2wFTy5Dn+KNGg3yvlKWina7Sx3nvCfuN16Z+ZYu
 u90aeWa1rooPEVolDZATfT1jyQfc+cThMkcSb2p2bOFcs3k9HHp/g6PTuoJSmfk=
X-Google-Smtp-Source: AGHT+IFWHy8OLUMR8P0M388nGu0NiSrSRUaw+PBx8thZcIFYslH72qpR4DelRULTNTCrb0jv9Z4cPg==
X-Received: by 2002:a05:6000:c06:b0:380:54f2:3408 with SMTP id
 ffacd0b85a97d-38061143056mr8940495f8f.25.1730209453490; 
 Tue, 29 Oct 2024 06:44:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b1323bsm12622177f8f.9.2024.10.29.06.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 06:44:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DB445F860;
 Tue, 29 Oct 2024 13:44:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Alessandro Di Federico
 <ale@rev.ng>,  Alistair Francis <alistair.francis@wdc.com>,  Anton
 Johansson <anjo@rev.ng>,  Markus Armbruster <armbru@redhat.com>,  Brian
 Cain <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,  cjia@nvidia.com,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@kaod.org>,  cw@f00f.org,  dhedde@kalrayinc.com,  Eric Blake
 <eblake@redhat.com>,  eblot@rivosinc.com,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Auger Eric
 <eric.auger@redhat.com>,  felipe@nutanix.com,  iggy@theiggy.com,  Warner
 Losh <imp@bsdimp.com>,  Jan Kiszka <jan.kiszka@web.de>,  Jason Gunthorpe
 <jgg@nvidia.com>,  jidong.xiao@gmail.com,  Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,  Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Max Chou
 <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com,  mimu@linux.vnet.ibm.com,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>,  z.huo@139.com,  LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: QEMU/KVM Community Call (29/10/24) agenda items?
In-Reply-To: <3a6a8109-196e-49ac-8416-49f69b688e5e@redhat.com> (Paolo
 Bonzini's message of "Tue, 29 Oct 2024 14:05:44 +0100")
References: <87bjz38j8p.fsf@draig.linaro.org>
 <3a6a8109-196e-49ac-8416-49f69b688e5e@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 29 Oct 2024 13:44:11 +0000
Message-ID: <87o7336n2s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/29/24 08:24, Alex Benn=C3=A9e wrote:
>> Hi,
>> After a missing a few weeks due to travel and conferences the
>> KVM/QEMU
>> community call is at:
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 29/10/2024 14:00 UTC
>> Are there any agenda items for the sync-up?
>
> I would like to discuss the next steps for Rust bindings, but probably
> it's already too late to have a call today; we can have the discussion
> on the mailing list as well.

I was wondering if you'd been hit by the daylight saving shift ;-)

>
> In particular I would like to understand:
>
> - if it's desirable to have
>   https://lore.kernel.org/qemu-devel/1d6034ef-9e41-4ef4-9a95-d03885b09b2b=
@redhat.com/
>   in QEMU 9.2.

I shall have a look.

>
> - if we agree on (the plan of) bringing the Rust PL011 to feature
>   completion in 10.0 and at the same time toggling the --enable-rust
>   default from "disabled" to "auto"
>
> I would also like to reach an agreement on how Rust patches enter
> qemu.git (that is, whether via my tree or a new one).

Good idea. We can discuss on list and then review in 2 weeks at the next
sync meeting?

>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

