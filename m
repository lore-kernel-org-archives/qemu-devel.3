Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E719CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRorV-00063r-K7; Tue, 26 May 2026 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRorT-00063R-5K
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:18:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRorQ-0002MQ-Ki
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:18:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso36240715e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779790687; x=1780395487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgF/amRW6rNXavJO8YbozrT/OuwnxyrvmNfiRpBFcpU=;
 b=uobSC6dK+/zbx+oDAO66hJV/WSi+TVYxlxVRUbMPd3CnLuGRj3Tdfesy0niqU9ykib
 toQJ8EO//Xr0Zxv7KVGLQPIpfiWoN/X4c+L/V0x4sMQr0nR6/CN/WGWAdrJ0cEcG6LJW
 KaNwelAFY2ZwmTKryRGUUGWMgAL8/fyTxstP2HERTfdlrqztm67a2iauIDgRf2FI0bRY
 BW/9TGKTAmT1xkceL/FcWufsziCaiDB6i9cwfpG9FdWZEPxn34m9CDod1UcV8pViGe20
 DsqtGDL+WZKNvgTclbsZD2yi7T7YyguIqqiLKPkgNxPzV1BPDqqWA+aSntnGmBgdBZ9f
 q83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779790687; x=1780395487;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zgF/amRW6rNXavJO8YbozrT/OuwnxyrvmNfiRpBFcpU=;
 b=XtwPbulAeVYkLVdsP79dDgYI7sA5DtxfD2/SM67SKJ0RZJ+5TXY+a21RiBxd19B5lK
 a4ZG7D2f4ZO5TVta5x/5h/YTOJ779ZTPl8Oe+W6VAFnecgE3+HoHFn/efsIONwfEUTUJ
 ZY0eCvKbAiI5BAa7fBQdGlIdC3+zApgKFdHAiUAbtz606bSDk/mBurnG9f5ES06QXMGG
 Yyq9HfWNMR5b3D3DehM4wEFxoTk7Q432onIGo5Y7IaHpLdg6t1CuuZLOXuecLBEkt0K1
 VJEcOPxkSN6gUTFdJhKXiLCtMfy1toccKjfKrGRI5K0jBFXdU1SKrsa51cmbzeSazFmN
 aMcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9b0kw0Jp8pj+mAZck5p6RalfOxBtHxw+5Mn/RmglWlKwi8358Rdlzlwfw7Ib9utxkJB3yBwcfbJtuH@nongnu.org
X-Gm-Message-State: AOJu0Yyoh6ScHoVrTgMxBhydW4H2otuZWqT7LE/nxFRv8mO1An7+MuMz
 iDb6BS9AqvHNfJ5EzXGwlSBxE89g3QV84y9r5DU6w0a5BCvKcofB2HGb2veMgEggJlg=
X-Gm-Gg: Acq92OGczGdg186TePJJPeYYvjtobRYRJZsMO5IzA7vQBa9yIqhD0Iw1asYt+vZhfQo
 l+OSMFYXIljQ9yE/iUOD34WBIkJYddUlpuhUgoYdOVboA/2M8Af2M+E9GY9zHsPtdxhqDmEsXj0
 +i5vrgmXjzGABGvvsAiAC3eDS+8prNXc7nn87v49GiJYcw7YHFnGI6iopspwEigQLOBhlr/1CiH
 GmHIeQTnkOtE3tg+RKuU/WXKrD65vYPPyTyHiSBJA8ubgHePUqch+dCFvrKPolBU4YwUSXh6X+J
 wAG2sNUjZDcJuEj9iz4kSF93McoBPalA9Q5AjnRQqky0lpPiGBlajUa+CY4M5GBCJ52cCZ03Vid
 QeCmypG0tIuCVSTRJv5MhLQjb4rrJz4CQ0fFufX6tYvCQSiWNt77CML1k8zcnRNvyzXkkEaL+4N
 4chgaBprTtUQpj+Kp6lWR0MUk=
X-Received: by 2002:a05:600c:1c10:b0:490:5380:f2cb with SMTP id
 5b1f17b1804b1-4905380f463mr243400185e9.0.1779790686618; 
 Tue, 26 May 2026 03:18:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490417a3be1sm146752795e9.3.2026.05.26.03.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:18:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBFD35F7DC;
 Tue, 26 May 2026 11:18:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,  Albert Esteve
 <aesteve@redhat.com>,  Alberto Faria <afaria@redhat.com>,  Alessandro Di
 Federico <ale@rev.ng>,  Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>,  Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>,  "Daniel P. Berrange"
 <berrange@redhat.com>,  Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org, dhedde@kalrayinc.com,  Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Elena Ufimtseva
 <elena.ufimtseva@oracle.com>,  Auger Eric <eric.auger@redhat.com>,
 felipe@nutanix.com,  helge.deller@googlemail.com,  Alyssa Ross
 <hi@alyssa.is>,  iggy@theiggy.com,  Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com,  Jan Kiszka <jan.kiszka@web.de>,  Jason
 Gunthorpe <jgg@nvidia.com>,  jidong.xiao@gmail.com,  Jim Shu
 <jim.shu@sifive.com>,  Joao Martins <joao.m.martins@oracle.com>,  Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 matthieu@minio.io,  Max
 Chou <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,  "Ho,
 Nelson" <nelson.ho@windriver.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>,  Roberto
 Campesato <rbc@meta.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>,  z.huo@139.com,  LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: KVM/QEMU community call @ 26/05/2026 agenda items?
In-Reply-To: <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
 (Manos Pitsidianakis's message of "Mon, 25 May 2026 10:46:38 +0300")
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
 <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 11:18:04 +0100
Message-ID: <878q961nkz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Mon, May 25, 2026 at 5:03=E2=80=AFAM Demi Marie Obenour
> <demiobenour@gmail.com> wrote:
>>
>> On 5/22/26 07:56, Alex Benn=C3=A9e wrote:
>> >
>> > Hi,
>> >
>> > The KVM/QEMU community call is at:
>> >
>> > https://meet.jit.si/kvmcallmeeting
>> > @
>> > 26/05/2026 14:00 UTC
>> >
>> > Are there any agenda items for the sync-up?
>>
>> I have (at least) six.  Four are related to the vhost-user spec,
>> one is related to the current vhost-user implementation in QEMU,
>> and one is related to MSI-X interrupts in the virtio PCI transport.
>>
>> I'm not sure if these are better discussed offline, but:
>
> IMHO these are all mailing list topics, vhost-user maintainers might
> not be in the community call anyway.

It might be worth having the wider discussion about if the QEMU repo is
the place for the vhost-user spec. I know the rust-vmm people have a
regular call but I guess there isn't a venue for vhost-user discussions
that is not just on list.

> I suggest sending patches (like you've already done) whenever it makes
> sense, and please try not to flood the zone.
>
>>
>> The first is whether vhost-user memory regions
>> are guaranteed to not overlap.  I sent a patch in
>> https://lore.kernel.org/qemu-devel/20260522-vhost-user-dev-v1-1-b31646cf=
19b8@gmail.com
>> to guarantee this is not the case.  However, this is technically a
>> breaking spec change.  The virtio vhost-user device I'm working on
>> requires this.

Breaking spec changes are always a red flag because of whats already
deployed. Are you sure there is no way to make changes optional with use
of feature flags?

>>
>> The second is when the backend needs to remove memory regions removed
>> by VHOST_USER_REM_MEM_REG.  This could matter for Xen grant mapping.
>> Does it need to happen before the backend replies?
>>
>> The third is whether a vhost-user backend can assume that the frontend
>> will always provide an eventfd where the protocol calls for one,
>> instead of falling back to pipe2() or pipe().  The virtio-vhost-user
>> device I am working on acts as a vhost-user backend and does not
>> support this.
>>
>> The fourth is whether a virtio-PCI device specification can assume
>> that there are a large number of MSI-X interrupts available.
>> My understanding is that a vhost-user device can have up to 256
>> virtqueues.  If so, the version of the virtio-vhost user device
>> I am currently working on will require a device to offer 263 MSI-X
>> interrupts.
>>
>> This is a workaround for a limitation of Cloud Hypervisor: it can't
>> handle changing irqfd to MSI-X mappings once the device has started.
>> This is already a bug, but I didn't want to add yet another feature
>> that Cloud Hypervisor didn't implement properly.
>>
>> The fifth is the importance of the features I'm planning on leaving
>> out at first:
>>
>> 1. VHOST_USER_PROTOCOL_F_PAGEFAULT
>> 2. VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
>>
>> VHOST_USER_PROTOCOL_F_PAGEFAULT is needed for post-copy live migration.
>> However, it requires the backend to provide the frontend with a
>> userfaultfd, which it could use to stall backend memory accesses
>> indefinitely.  This is an easy frontend to backend denial of service.
>> Furthermore, unless async page faults are supported, it is an
>> easy backend *kernel* denial of service.
>>
>> VHOST_USER_PROTOCOL_F_HOST_NOTIFIER requires the driver to somehow
>> tell the frontend what memory to use.  Furthermore, I'm not sure if
>> it can prevent the frontend from mapping too much of it.
>>
>> The sixth is if references to "QEMU" should be replaced by a more
>> generic term.  QEMU is not the only vhost-user implementation nowadays,
>> and there may be implementations that support features QEMU does not.
>> In fact, I believe that this is going to happen in the near term,
>> for vhost-user-GPU blob object support.  Alyssa Ross has implemented
>> this in Cloud Hypervisor, but I don't think QEMU supports it.
>> --
>> Sincerely,
>> Demi Marie Obenour (she/her/hers)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

