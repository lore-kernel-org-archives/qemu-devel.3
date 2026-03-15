Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF6F3026A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 14:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1mZb-0003zW-3t; Sun, 15 Mar 2026 10:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w1mZZ-0003zH-Qu
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 10:36:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w1mZX-0006rY-1E
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 10:36:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so20853625e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773585360; x=1774190160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7OENwe6b3Z1FWqhg6tiozZgwt7jObvjcNZQzK1IeZQ=;
 b=cqAK3JLRsUNo2vJOmL/RzRaxISXHb4tEARApHvAkJsAxrr0rsmjre+OtahzEBdpB+E
 LJYIqukznMMZJZ9D0YST4PHEkSvEg54jhCYi/ICJF8v6aXKD71D/dBNt8bx7vit+AW6j
 xX3a/nWcd/lncO5+PHTPcnTqeNVYG5t2W3PMHeAKvwAByAZGA24ACtUePhyJxAaWb2B0
 4dn+SkMXckXqYJ9/N3pFJIrPclvbn/JGLAybkkWG7shGNVF9q0/I6yZby1pQ5JLtZP3Y
 FojUNdOKiefqpOrnNLCOTQOxGwexMpp2APy3MESGlvWoK5Tn2ixHucQeOu7zPGWDstmf
 EMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773585360; x=1774190160;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M7OENwe6b3Z1FWqhg6tiozZgwt7jObvjcNZQzK1IeZQ=;
 b=jraY65Dr5kPPg+fde6lqpg5QEy2d7DKXyRasby/BiSZb/RpJ8xHwrSKf5iMXkZUibE
 oDu5YpZdjZGwNqsIMn27uDiEYiO+LdK8+qkViXbA15wDcFdRZ1JuOAtL7Ler5JLA6P8B
 KltF1A4Vc5QepE/N2fALlzztYh4NfujeCbcwbog/ZZh7wJtH0wCBVpYiI/T6LmF4h345
 tXBU/m2VJoosPxxogTMB56xhg9cplLkelbBBBZJdgyCbcl04kqTu6Jn8eMaKP6+EmZIU
 TS+YXKsxiG5HPecIZWAKaika7liHzBqsBRKcVUChNy2WxQH1AqY0FSNOdZUD7wryi8g+
 a1aw==
X-Gm-Message-State: AOJu0Yz1ZkMSrKQ3dafIDV2VfR8G2YGmPeRzDRL6fuUxEmcROhvfS0pf
 Z4L+nmjBcEPzof573wIAIZMOuJXNiSW2WcmjJsCjr5gEm3Qj4BGwL73Q8jUlCg==
X-Gm-Gg: ATEYQzyW6miiccqsQgFbtlSaYO4TlsXPduvDAarXKdv67eI0/sfvszxsDr85u0V3kyp
 dN9MOcpuwD8O31uZfVLZ8BskUoSAQaZQlth74XZnT1MwRuo4F7DGdM7QvtlQM/p18gYqQ89iBGR
 dloyddOe5ybcbPchkWEOAbE6dM62C3A9Zi7/TYEWqSiQgliH202qYV0S6X7GSPZZSomtedSsd5F
 yFIRpIZfvbSkx4gqlg6rWZPgIXDZ6ErbKmW+UVmOvbfWJOCehtWR9kN0CGipwf3ADnvJjDBI7fP
 JOo/wBYOiVGtPmI8ivAgwkt+MWFDrOjFIIflv6FSbenduwaHvMRfIO5YXVWtnE8oPTaWzQuZLWs
 rMRG34OATJJ2MZIh14jl2fLeEmq6nJHk85hpeoYXYFXbNSei9X4voI+k5AYgoRMR1yV0PeJU4uv
 amn9SapAobEKHK+N44BgE79mbZpfaQsp1UyRXq2nH7y/UcIB10WMRbvdKpU/ZmmRJCBnqe/32f9
 Ff9hdGfsETTtLIg8Y8aJeQ=
X-Received: by 2002:a05:600c:4592:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-48556714c04mr167945255e9.17.1773585360048; 
 Sun, 15 Mar 2026 07:36:00 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100204c1ac0c53f1a0e.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:204c:1ac0:c53f:1a0e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fd3dsm341557805e9.10.2026.03.15.07.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 07:35:59 -0700 (PDT)
Date: Sun, 15 Mar 2026 14:35:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?ISO-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-s390x@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/4=5D_MAINTAINERS=3A_Downgrade_the?=
 =?US-ASCII?Q?_functional_testing_section_to_=22Odd_Fixes=22?=
In-Reply-To: <20260313113424.15583-5-thuth@redhat.com>
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-5-thuth@redhat.com>
Message-ID: <C7E56FF3-B776-4F4D-B786-19BF88F041A2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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



Am 13=2E M=C3=A4rz 2026 11:34:22 UTC schrieb Thomas Huth <thuth@redhat=2Ec=
om>:
>From: Thomas Huth <thuth@redhat=2Ecom>
>
>I won't have that much time for QEMU anymore in the future, so downgrade
>the status of the "functional testing framework" section to "Odd Fixes"
>to avoid wrong expectations=2E While we're at it, also switch to my other
>e-mail address here that I'm already using for the other sections where
>I am still listed as maintainer / reviewer=2E

Thanks for the dedication you put into the test frameworks and their trans=
ition=2E Sad to see you leave and hopes to still see you around in the retr=
o computing camp here in QEMU=2E

Best regards,
Bernhard

>
>Signed-off-by: Thomas Huth <thuth@redhat=2Ecom>
>---
> MAINTAINERS | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1c7dfab39d3=2E=2E18e4223de1d 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -4514,10 +4514,10 @@ F: tests/vm/freebsd
> W: https://cirrus-ci=2Ecom/github/qemu/qemu
>=20
> Functional testing framework
>-M: Thomas Huth <thuth@redhat=2Ecom>
>+M: Thomas Huth <th=2Ehuth+qemu@posteo=2Eeu>
> R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
> R: Daniel P=2E Berrange <berrange@redhat=2Ecom>
>-S: Maintained
>+S: Odd Fixes
> F: docs/devel/testing/functional=2Erst
> F: scripts/clean_functional_cache=2Epy
> F: tests/functional/meson=2Ebuild

