Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BD9CAC585
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 05:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvqme-0002jx-AK; Tue, 09 Sep 2025 01:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uvqmM-0002hJ-Nt; Tue, 09 Sep 2025 01:20:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uvqmF-00055T-7t; Tue, 09 Sep 2025 01:20:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0431c12df3so891445966b.1; 
 Mon, 08 Sep 2025 22:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757395191; x=1757999991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiMGmGc4HDdoSPkV38KUKKsrILUvXzYduDCzRAWdwfs=;
 b=gxBhBsHinSn+Rg1o/4xFbj/hfeA6iEMG0Le8jlXM0FF1dzwWn/vIqiWaCjzJROPyv0
 VzxrJnQMWE+hRLv4zrCqBDyfCpJj1EGy0S49vmmhn+onJ8kk1nB58nBTeRRvHjt88t45
 Vi0H+0hjqiOhmj48j0DT2je4vk8hduAnaL2+/oO8jEmP0hai0L2BTW/cpA55+pJaXdyq
 IoE2hhYFBn3FJVLYj5EjJfoJ3PUWhgLk+PQ9y8zflBLcKOwXdp8pPTrMwVdE3GPW2Cim
 msggHyDICXPxI7Fya5/q2U3i4o+AbhTsl6Vlgak5FdozqNDtOj4meQJYIf41XRWc7fdO
 tEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757395191; x=1757999991;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiMGmGc4HDdoSPkV38KUKKsrILUvXzYduDCzRAWdwfs=;
 b=Oi4GOksHhL9bq0xhTnk9IEVzDJE4ZuggVcuafqsV48066M6RrpGc/IdlTTJrXOLNiK
 GuHxykEQY0xP0ETl5Sg8MLYRW2EDSF6tMHmSd6CL55zWdeXBWokQ2ejVul4/nmE+JRUP
 ohSE2gwwg92TZqhGImN+ScjuKRrYTgnrWecfWBG/gXjexi6Hn84fUEhpwGPZ/LuP+wzl
 xUS+bHPS5iRw0pYRXKYBrX+Cbwpy5m0Mdnau1I3uyJ+AQwvf8j6qClyie3G7lGJXQEMt
 2Bk0sQJQdOIMOaRlCGwI6Ackr5yNfzimhfcwYA1+W78jhK7wtgHY5yG8TWJAD44lL7uW
 ieWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaPsFwBDbsEnIIoafCCiXN8wgmnUjkZNDKG4BB/z6kiysJ54bggUF68b6wjlotgA4FeiXLdMPgaRg=@nongnu.org,
 AJvYcCVXqfmciYlmhLac28BIpwX4W8wptOlPKymRlld14GXKX5x1mcrTYFk3JIZRd2q/GpLM5i9bxmdHbAMfZA==@nongnu.org,
 AJvYcCW18SY8eC/WihmFMgTHqAJ/SanRBpJBSPwAXFjithyJliKnaQ5p1F4CnPYHsoRxX1tkYjUS1gw9nejF/w==@nongnu.org,
 AJvYcCXj/W3eX8xwk5w6E9Dt/nExx9cLuotwfG2HFRx6Fj6FNEXP42rAM9JzgpsKyTjRlz7hXWFavDrk944a@nongnu.org
X-Gm-Message-State: AOJu0YxiJ6chHewtoJyBaPduKa8IRKA1idIq/UeFjGe6K05/J1+C+8Rs
 SwNd6TD1XHUSVpJ21FKzXUCoJh0UUI2zRcSQFDuzApcYPBLF2Jr56VKQ
X-Gm-Gg: ASbGncuUB9afuw08fDMTY5jtzg/GeM05/4UwSxBHCHxNnzRbvUEcFeQnvV8LXE5mUX1
 zo4g9f+e+6I8xEuYfDYV6tAVKfFKpdV5K4Sjp1/a5UKUR3LPzyQlhDyuaGWMcjmVTl90NyxGwUn
 OUhqo6Lb2a3CnYa2LFrMhXgAOafwhEjOHOl503MxoA8OsqY7QNSxaelm0+8rbzg369JuzF0ezHf
 7B78wSamJSE1gcMBr4rKzRo7aq4kkz/j6k71app5uc2auPyaYQI09sx4AlwDF9gEbmdH8k7Sh8H
 hE3oG1TOPk+ZdGwRSenf3M0B334jRmS/ZAb/rz+vYL0gj3P8F+q8ghAVKBcAkbaevS1BJXYBa+z
 m6KYwozNZ0DErkbaWzFlioIMENUsGWgnEVd8Y6nG6stW0YFh+u3pKCnuQrVnWC+D6zK/bD22abi
 MZ4q1wIC8PNvzchrKV1fdDfSq4WWJq2cjtjYK7BGX5B6ViX6cLB//4
X-Google-Smtp-Source: AGHT+IHIDL+NqATTSAmmr3vUd0PsicyPno5jOJAqaFNkQ2bWpfv9zZl0m+BO4EDNXlPRIcgnDuMOEQ==
X-Received: by 2002:a17:907:3e9f:b0:b04:3402:3937 with SMTP id
 a640c23a62f3a-b04b1466da9mr940076466b.28.1757395191027; 
 Mon, 08 Sep 2025 22:19:51 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2544-af00-cdc9-6b46-02f2-ff9a.310.pool.telefonica.de.
 [2a02:3100:2544:af00:cdc9:6b46:2f2:ff9a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b047373b000sm1325744766b.68.2025.09.08.22.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 22:19:50 -0700 (PDT)
Date: Tue, 09 Sep 2025 05:19:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
CC: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <20250908125058.220973-1-peter.maydell@linaro.org>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
Message-ID: <E6DAA9A9-5D7B-44EC-AC07-149DB096ABE2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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



Am 8=2E September 2025 12:50:57 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>Currently our security policy defines a "virtualization use case"
>where we consider bugs to be security issues, and a
>"non-virtualization use case" where we do not make any security
>guarantees and don't consider bugs to be security issues=2E
>
>The rationale for this split is that much code in QEMU is older and
>was not written with malicious guests in mind, and we don't have the
>resources to audit, fix and defend it=2E  So instead we inform users
>about what the can in practice rely on as a security barrier, and
>what they can't=2E
>
>We don't currently restrict the "virtualization use case" to any
>particular set of machine types=2E  This means that we have effectively
>barred ourselves from adding KVM support to any machine type that we
>don't want to put into the "bugs are security issues" category, even
>if it would be useful for users to be able to get better performance
>with a trusted guest by enabling KVM=2E This seems an unnecessary
>restriction, and in practice the set of machine types it makes
>sense to use for untrusted-guest virtualization is quite small=2E
>
>Specifically, we would like to be able to enable the use of
>KVM with the imx8 development board machine types, but we don't
>want to commit ourselves to having to support those SoC models
>and device models as part of QEMU's security boundary:
>https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-shentey@gm=
ail=2Ecom/
>
>This patch updates the security policy to explicitly list the
>machine types we consider to be useful for the "virtualization
>use case"=2E
>
>This is an RFC partly to see if we have consensus that this change
>makes sense, and partly because I was only able to identify the
>machine types we want to cover for some of our target architectures=2E
>If maintainers for the other architectures could clarify which
>machine types work with KVM that would be helpful=2E
>
>Notes on the listed machine types:
>
>architectures I'm pretty sure about:
>
>aarch64:
> -- virt is definitely the only supported one
>s390x:
> -- s390-ccw-virtio is the only machine type for this architecture
>loongarch64:
> -- virt is the only machine type for this architecture
>
>architectures where I've made a guess:
>
>i386, x86_64:
> -- I have assumed that all machine types except the "experimental"
>    x-remote are supported
>
>architectures I don't know:
>
>mips, mips64
>riscv32, riscv64
>ppc, ppc64
>
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>

Thanks, Peter, for this proposal=2E It's nice to see the positive feedback=
 which may eventually make hardware-assisted acceleration accessible to a w=
ider range of the community=2E Much appreciated!

Best regards,
Bernhard

>---
> docs/system/security=2Erst | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/docs/system/security=2Erst b/docs/system/security=2Erst
>index f2092c8768b=2E=2E395c2d7fb88 100644
>--- a/docs/system/security=2Erst
>+++ b/docs/system/security=2Erst
>@@ -35,6 +35,34 @@ malicious:
> Bugs affecting these entities are evaluated on whether they can cause da=
mage in
> real-world use cases and treated as security bugs if this is the case=2E
>=20
>+To be covered by this security support policy you must:
>+
>+- use a virtualization accelerator like KVM or HVF
>+- use one of the machine types listed below
>+
>+It may be possible to use other machine types with a virtualization
>+accelerator to provide improved performance with a trusted guest
>+workload, but any machine type not listed here should not be
>+considered to be providing guest isolation or security guarantees,
>+and falls under the "non-virtualization use case"=2E
>+
>+Supported machine types for the virtualization use case, by target archi=
tecture:
>+
>+aarch64
>+  ``virt``
>+i386, x86_64
>+  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``isap=
c``
>+s390x
>+  ``s390-ccw-virtio``
>+loongarch64:
>+  ``virt``
>+ppc, ppc64:
>+  TODO
>+mips, mips64:
>+  TODO
>+riscv32, riscv64:
>+  TODO
>+
> Non-virtualization Use Case
> '''''''''''''''''''''''''''
>=20

