Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4317AC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwdw-0001rD-92; Wed, 19 Mar 2025 12:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tuwdu-0001qj-Nw; Wed, 19 Mar 2025 12:51:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tuwdt-0003hg-78; Wed, 19 Mar 2025 12:51:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so1747282a12.0; 
 Wed, 19 Mar 2025 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742403102; x=1743007902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lmhjm+fPp5k3VQkAaatIbZ+VRWCMjPQxoTElddp3510=;
 b=bQhOFYYtNYoPsU4KdzYk9YhW9SEIBPiuo9QCDDuRP3Up7MjRwAOP46T5RMji7ej/tf
 E2prDFDtrKTzauXlw083zidA4ReuBs8wvq1Zai7fUmH2aaVi2wARz7XEsGSwivlt/kR6
 mbPv510qVZSiSMXx40t2rETO2RRMKPDhCMfGNt+cYius+7gWnROVGPzFM3bxBkWylJ/B
 yGKLaOuxQqJKaAayQZbdk1ICZhAPaM6w4qd+c3y0eRLi3pgcslYVyAlhbrk7b8G6pK+X
 zwPNkLQ6OdnM4RB01esvj88GJcQMRCQyVJ/MBzxA3AnW/ozBnADj8A/Z9G4ujpBQ17bW
 bT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403102; x=1743007902;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lmhjm+fPp5k3VQkAaatIbZ+VRWCMjPQxoTElddp3510=;
 b=vmmE8Qs6/3IKH2Ht0pN8LutnlZMcNFu14LwJUn1gHvYbgHqCkZh+1tCinSgt5CTcPH
 skn/4GYUYzd7sA9S5CH6fL5yzBfkow7pQS/6l8e0q6PQxjUSYPbvTX5gwAUDwra6xq7U
 kgjOG9r9Ta4kawdFrxPtkKnO5s2XVShBoW5N7R4+hX8UtZD8yv8+2MkCdtBv87wvQnmP
 M/f9NJkzfTRDVLHoPJgtaE2h/rHqDLtV65cPlLPd/oXgKZ6GAcjlVcgDg5uaObVfSv+x
 QzSz9q4RhS7EXwjB0Egb4fSteONL+zSH5geMRD1sEz5ny0yK3SO0j8jolQ7Zo5fByspx
 rLVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKhk0JcniXh7GwKRqzZEeeh/qghIYzstUszdorz8ZRc4Vr8s2+E/U640ozrgDgVK3ZWEh4qckkSg==@nongnu.org
X-Gm-Message-State: AOJu0Yz8O+Uss/ILnneFHU8xRGMWnrOKiHmCGdimR84sMA2ikfzRJDZq
 eBvMsNC6/dzqA6hP1jhb7KBlao0HsQTgos3G6HKdlyRfHyQO6AXVyX2MnA==
X-Gm-Gg: ASbGncunH2872hIsG4tQIL+KExf7vMi6d+g+f/2ApBbABgIMxsF4yCr8cCk/VBC6/nl
 V0su4W8bZCFakTKNOm27MrRimSt2CsQ+hyI5l/yWcGvFj1U52/7HEtP9LUIfBv2BtSx2jQN/re0
 UY6TqYIEfJApx1DGNKHoCWibeo6R34olgO1PfHnCzTKMaFqzPGyyWqEJdIzhDz/NdrgJCwuTZOh
 1Ipt1lDBQ9bTkw7Evc9R+wJOFLTEb+XRIiSWkEkGIkdwUL6SZE33/XhvjZ1oFHmFWxKnJKdYv5R
 tBAfkg3fjJilk3tzQ+vF8Lk8PQujL76LNdaq4ts3
X-Google-Smtp-Source: AGHT+IHEE+1+1Y4FvD18Tu6s8ju7OS/PGvX+SgfsQu/e/kSgzv8HZNQZpHllMhkUktQj206gDD21Ew==
X-Received: by 2002:a05:6402:2356:b0:5e4:95fc:d748 with SMTP id
 4fb4d7f45d1cf-5eb9972699cmr216738a12.5.1742403101931; 
 Wed, 19 Mar 2025 09:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816968aefsm9764015a12.20.2025.03.19.09.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:51:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:51:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_hw/arm/imx8mp-ev?=
 =?US-ASCII?Q?k=3A_Fix_reference_count_of_SoC_object?=
In-Reply-To: <20250318205709.28862-2-shentey@gmail.com>
References: <20250318205709.28862-1-shentey@gmail.com>
 <20250318205709.28862-2-shentey@gmail.com>
Message-ID: <C330829F-02AC-4080-994E-23E48F1146FC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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



Am 18=2E M=C3=A4rz 2025 20:57:07 UTC schrieb Bernhard Beschow <shentey@gma=
il=2Ecom>:
>TYPE_FSL_IMX8MP is created using object_new(), so must be realized with
>qdev_realize_and_unref() to keep the reference counting intact=2E
>

Fixes: a4eefc69b237 "hw/arm: Add i=2EMX 8M Plus EVK board"

>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> hw/arm/imx8mp-evk=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec
>index e1a7892fd7=2E=2Ee1a21e52f9 100644
>--- a/hw/arm/imx8mp-evk=2Ec
>+++ b/hw/arm/imx8mp-evk=2Ec
>@@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
>     s =3D FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
>     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal)=
;
>-    qdev_realize(DEVICE(s), NULL, &error_fatal);
>+    qdev_realize_and_unref(DEVICE(s), NULL, &error_fatal);
>=20
>     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_STAR=
T,
>                                 machine->ram);

