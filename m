Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3B1C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7qN-0004PP-Qt; Tue, 12 Mar 2024 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rk7q6-0004OX-8E; Tue, 12 Mar 2024 15:31:06 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rk7q3-000260-9Z; Tue, 12 Mar 2024 15:31:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a461c50deccso45329366b.0; 
 Tue, 12 Mar 2024 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710271860; x=1710876660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lERavBCSZyIEiab1mn+GibZsroCG+MnnpsTUbVjtEbE=;
 b=hZ4CJWBXW91o1hOhVWr2MOd5Fr2KDe/Op1CtFLu2zKXKo6K7muMgyfuesG9Zks225r
 wS2GAStxXyi8jEXKh2+YvYYljtmJVZP/mcLAJTY64VmkRC2L3kAggqqFxE1wmY8OLc+q
 L4DYM6m/oF5/u67GvoiW6cjDPUUXvhCT+qw6V8YSm5XIihm/szeFMoJU0B/XmH9DQkNl
 kNfjhdDK3BppYeMGgCDN9+oZ/n/Is/DojmSkc8ScP4ovba/l138Q0KjgdXHXIi1vd8To
 Xcpl3RMY4XvLH3BPehXczGdRTjsBEOzCA0UqUurIcbjNCakMI15IObdkutlc0JLn5PAz
 R1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710271860; x=1710876660;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lERavBCSZyIEiab1mn+GibZsroCG+MnnpsTUbVjtEbE=;
 b=ILWPIPJ7Omh2jlC2EeobxPjMQd8oZ0vXnUfW6FeztTmXGOia2vRLBFCvUxlZqv0pYh
 qA4AGnetJtpcyq7X/KuSzGSUicbPYO3Njck+VYzaO74WwkccflSWvuLoBPgBS942U8vd
 WqPm1/wXjWGyCVo9Ql2CJYS0Phwjez7m9ttkVq2TWfK3VXOA4tIXnvTMAwoZMgr5oZIQ
 hbpeSMYvj5l3ESHz9xyXruzN0bp8PrwTzdSM8AgsT4zPhoVTIiVsgr5aYh+pX06kb/zw
 zoy3mqC2a0AgJEvHJ6S80f+zljClY1XmlpxImrGMpfkJtNbFU91zsmPRbvWyTPU26MzO
 Zezg==
X-Gm-Message-State: AOJu0Yya1lEeq2o+LL2Uo03iT1pMxaSSAIRfbI1biR6ckzumMncuDpGK
 mLGwklERGXdpUDyTYStCgY26XPgwE3l1aNCJQeHoq6ex1pcckntZ2Py4acLt
X-Google-Smtp-Source: AGHT+IH8mRakYxRIk5eEjxL88Y1vP6v1OV9Vt4bK9eZ3BD8eZflyCyflf2pKo97kduCGY1/sSNEToQ==
X-Received: by 2002:a17:906:af97:b0:a46:3c16:a496 with SMTP id
 mj23-20020a170906af9700b00a463c16a496mr885713ejb.31.1710271860165; 
 Tue, 12 Mar 2024 12:31:00 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 rv25-20020a17090710d900b00a455519bcb3sm4133560ejb.55.2024.03.12.12.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 12:30:59 -0700 (PDT)
Date: Tue, 12 Mar 2024 19:29:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
CC: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PULL 00/38] ppc-for-9.0-2 queue
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
Message-ID: <52391359-9A38-44EC-8747-904D0C627F50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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



Am 12=2E M=C3=A4rz 2024 16:58:11 UTC schrieb Nicholas Piggin <npiggin@gmai=
l=2Ecom>:
>The following changes since commit 35ac6831d98e18e2c78c85c93e3a6ca1f1ae3e=
58:
>
>  Merge tag 'net-pull-request' of https://github=2Ecom/jasowang/qemu into=
 staging (2024-03-12 13:42:57 +0000)
>
>are available in the Git repository at:
>
>  https://gitlab=2Ecom/npiggin/qemu=2Egit tags/pull-ppc-for-9=2E0-2-20240=
313
>
>for you to fetch changes up to e1617b845104032f0aaad9b91dcda56c7c437998:
>
>  spapr: nested: Introduce cap-nested-papr for Nested PAPR API (2024-03-1=
3 02:47:04 +1000)
>
>----------------------------------------------------------------
>* PAPR nested hypervisor host implementation for spapr TCG
>* excp_helper=2Ec code cleanups and improvements
>* Move more ops to decodetree
>* Deprecate pseries-2=2E12 machines and P9 and P10 DD1=2E0 CPUs
>* Document running Linux on AmigaNG
>* Update dt feature advertising POWER CPUs=2E
>* Add P10 PMU SPRs
>* Improve pnv topology calculation for SMT8 CPUs=2E
>* Various bug fixes=2E
>
>----------------------------------------------------------------
>BALATON Zoltan (8):
>      docs/system/ppc: Document running Linux on AmigaNG machines

Thanks, Nicholas!

Best regards,
Bernhard

>      target/ppc: Use env_cpu for cpu_abort in excp_helper
>      target/ppc: Readability improvements in exception handlers
>      target/ppc: Add gen_exception_err_nip() function
>      target/ppc: Clean up ifdefs in excp_helper=2Ec, part 1
>      target/ppc: Clean up ifdefs in excp_helper=2Ec, part 2
>      target/ppc: Clean up ifdefs in excp_helper=2Ec, part 3
>      target/ppc: Remove interrupt handler wrapper functions
>
>Benjamin Gray (1):
>      ppc/spapr: Add pa-features for POWER10 machines
>
>Caleb Schlossin (1):
>      ppc/pnv: Improve pervasive topology calculation for big-core
>
>Chinmay Rath (1):
>      target/ppc: Move add and subf type fixed-point arithmetic instructi=
ons to decodetree
>
>C=C3=A9dric Le Goater (1):
>      MAINTAINERS: Remove myself as reviewer from PPC
>
>Harsh Prateek Bora (14):
>      spapr: nested: register nested-hv api hcalls only for cap-nested-hv
>      spapr: nested: move nested part of spapr_get_pate into spapr_nested=
=2Ec
>      spapr: nested: Introduce SpaprMachineStateNested to store related i=
nfo=2E
>      spapr: nested: keep nested-hv related code restricted to its API=2E
>      spapr: nested: Document Nested PAPR API
>      spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls=2E
>      spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls=2E
>      spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall=2E
>      spapr: nested: Extend nested_ppc_state for nested PAPR API
>      spapr: nested: Initialize the GSB elements lookup table=2E
>      spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls=2E
>      spapr: nested: Use correct source for parttbl info for nested PAPR =
API=2E
>      spapr: nested: Introduce H_GUEST_RUN_VCPU hcall=2E
>      spapr: nested: Introduce cap-nested-papr for Nested PAPR API
>
>Madhavan Srinivasan (1):
>      target/ppc: Add power10 pmu SPRs
>
>Nicholas Piggin (10):
>      target/ppc: Fix GDB SPR regnum indexing
>      target/ppc: Prevent supervisor from modifying MSR[ME]
>      spapr: set MSR[ME] and MSR[FP] on client entry
>      ppc: Drop support for POWER9 and POWER10 DD1 chips
>      target/ppc: POWER10 does not have transactional memory
>      ppc/spapr|pnv: Remove SAO from pa-features
>      ppc/spapr: Remove copy-paste from pa-features
>      ppc/spapr: Adjust ibm,pa-features for POWER9
>      ppc/pnv: Permit ibm,pa-features set per machine variant
>      ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
>
>Philippe Mathieu-Daud=C3=A9 (1):
>      docs: Deprecate the pseries-2=2E12 machines
>
> MAINTAINERS                                |    4 +-
> docs/about/deprecated=2Erst                  |    6 +-
> docs/devel/nested-papr=2Etxt                 |  119 +++
> docs/system/ppc/amigang=2Erst                |  161 +++
> docs/system/target-ppc=2Erst                 |    1 +
> hw/ppc/pnv=2Ec                               |  175 +++-
> hw/ppc/pnv_core=2Ec                          |    8 +-
> hw/ppc/ppc=2Ec                               |   10 +
> hw/ppc/spapr=2Ec                             |   98 +-
> hw/ppc/spapr_caps=2Ec                        |   54 +
> hw/ppc/spapr_cpu_core=2Ec                    |    8 +-
> hw/ppc/spapr_hcall=2Ec                       |   24 +-
> hw/ppc/spapr_nested=2Ec                      | 1556 ++++++++++++++++++++=
+++++++-
> include/hw/ppc/pnv_chip=2Eh                  |    2 +-
> include/hw/ppc/pnv_core=2Eh                  |    1 +
> include/hw/ppc/spapr=2Eh                     |   27 +-
> include/hw/ppc/spapr_nested=2Eh              |  427 +++++++-
> target/ppc/cpu-models=2Ec                    |    4 -
> target/ppc/cpu=2Eh                           |   11 +
> target/ppc/cpu_init=2Ec                      |   46 +-
> target/ppc/excp_helper=2Ec                   |  418 +++-----
> target/ppc/gdbstub=2Ec                       |    7 +-
> target/ppc/helper_regs=2Ec                   |    5 +
> target/ppc/insn32=2Edecode                   |   26 +
> target/ppc/kvm=2Ec                           |   11 -
> target/ppc/misc_helper=2Ec                   |    3 -
> target/ppc/translate=2Ec                     |  164 +--
> target/ppc/translate/fixedpoint-impl=2Ec=2Einc |   70 ++
> 28 files changed, 2883 insertions(+), 563 deletions(-)
> create mode 100644 docs/devel/nested-papr=2Etxt
> create mode 100644 docs/system/ppc/amigang=2Erst
>

