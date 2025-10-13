Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3109ACCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Izv-0008Jg-2a; Mon, 13 Oct 2025 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8Izo-0008Io-58
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:53:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8Izi-0000KJ-5V
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:53:51 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo790915666b.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760363617; x=1760968417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iia8Ngy5p+IRP0JTRaOvsDYsEKbQpQw3PtLmGPv6hgM=;
 b=PqwdYyXZcpllqLo7GJTsQetsSisv3UlkkRAbyDz/fJpUwC7C0SetdOt/rWOc5D6ynY
 TVLnxE0QUKjQ61qVyKQqrtoqHOWIlgZoghYKahV7a3fTkk63cptzCkXFeMRXZbo2psfk
 IT7WFk5eGuOdRxIeUZNilwUt/63FBwmu2yWMpJvRNBPRj3GdW98ow7x3VrqYjENBnMz5
 pImij3G89x30Kd9F2EmDw1/GF8sSL69o4rtEuA7aGBkPWJhBgK3Qb+vVoeYALe2wUJGY
 tFfyHOI2inuQ17n4icmSxOSDBo4ik8VU0BmrF2n/1x1hnKJ0u9sqxoXSLTCICVoV7yBM
 +rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363617; x=1760968417;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iia8Ngy5p+IRP0JTRaOvsDYsEKbQpQw3PtLmGPv6hgM=;
 b=qvUpqXpJHCS5De4guMofsvHGTr0agJF+lysVESVGmxmNfiUfDigeG1kmalCqm0I7wm
 vg88ZH5UIq/vKit+fe+dV+gN49sQj1uLYOmqVq1l+PqTu9wZUGRZUV8/IyJejaU6iefH
 4k47lV9mHjib0hxDN3w04KXMCmC91+g4jOCcY67AFy/uivQkr3OkbdVFS02wTl7yILuq
 qaFod6Fpl2/dw9kDu/xTWOwh+sezbQtHPka3LlgzfOQfLB4sC82Bb7kR1LuaYWX9/9PU
 WUhKDDTu5ynlp1yfBuI4am9cQHbDwi9HS8aZqglRGbA7vhCFjsSg+iFEED45tSQRZpuz
 mCdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEeIMkyH9zqXR63mGjdUKDAG51baKmAAJegYqQy3O2g9K4H9GnvLW+579D9AQ58Zt979vjwkJY7rvC@nongnu.org
X-Gm-Message-State: AOJu0YyABeSBLHjw5UQnsiXLGG7mA5OTH+B2j5AElFfK5JHngGQYEKY8
 mQ5lJ6oDNjoGB/vIiD3m1RTHTxWRt0g7hvsLY2OZX/j7/DXEj6D02JSzR835cc4/AhU=
X-Gm-Gg: ASbGncuAdCDq5utX03ue5wqBj8u5gOl/EwKNy5ZV7rIqMsSOZCH0W6cm+92QFv1+zez
 Y3Mf4dmseioF7fqZoOb+RWsDnRVpTSaDmB9U9yjYlXNGdmWFzYB4e4Tu0SlfOLMPTiLzs0jx+CO
 IOQQzJwVNW6RK137wm3yghX0GUgdek9ajDuN5ldG63CRiXIJZyu9zWlSZ2sov+x41M0kvypVHwK
 3FmB/r28bJ63X9h6Menl7hYHqYWrvdeAR5yZGDRm60UL7D9V4qWj9DakFaHNlJqQjfUEi/irDr9
 CbgVqfCAUJssH14RrSgxROHdAba3LZVDXlXgKenK90yn2tMNICXmM96i5dxe57RY9knEVe/vBMN
 TkjCEr1htEvPZHG8kg0GYNH7/AnNV+AycA4tQVBsVvk8foBjdH1glKBx7
X-Google-Smtp-Source: AGHT+IFZGGe6P6FveWK9Re5wY7etnSAAIBSEHMDelSjVN6o43VcJmLEUlkW14XfudvbhfLgxWQwTxw==
X-Received: by 2002:a17:906:ef05:b0:b3d:8fe0:536d with SMTP id
 a640c23a62f3a-b50aa391e49mr2316554866b.15.1760363617447; 
 Mon, 13 Oct 2025 06:53:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d69dbd99sm930642466b.40.2025.10.13.06.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 06:53:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D60CE5F7A9;
 Mon, 13 Oct 2025 14:53:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call agenda items for 14/10/2025
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 13 Oct 2025 14:53:35 +0100
Message-ID: <87ecr6nc0w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
14/10/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

