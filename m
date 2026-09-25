Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CDDC9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA4WV-00086H-CX; Fri, 25 Sep 2026 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1xA37T-0001vB-OA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 06:25:31 -0400
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1xA37R-00022E-Sn
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 06:25:31 -0400
Received: by mail-qk2-x10.google.com with SMTP id
 af79cd13be357-93910cadeb3so65568785a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 03:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790331927; cv=none;
 d=google.com; s=arc-20260327;
 b=Gryu8zqWKwX5EAMLPAw73cU2tz97THf1sVoQtPRRGI6W9YhA0dKXC/yPKaORLxNvJV
 gSMFfqFJZmB9Q8KpE1qMAy9Qz4Wa62/6PxtTvpqbUpjnPPYAq2dwdMrekw4bSlwss6Vy
 CReKlNkbms3n3FBElLPFLWzz4kJe4eeW+msLvb+tDYMga1mL5Ys0UZapNsAyfJ7/SC2M
 MSiesUfpUpS1TaXfEBTNB67RUU8OFqjt+bcicL29P0pnOTKlwxeeG1Kvs7e4a/SEmOoc
 PZhMf+YPyDpAajsB/hXXJqEGD5s4vXOTVYZGTk8mx+62/ZE6sPWiNLnq9nBReEgkfq6q
 W/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b2RNNH2CQU/BLQYIf7DffRzGPpzX23V85px/jF6IL/Y=;
 fh=vBSFEcTzpPEDTLs5pt+FroN8bqXRK6oP9LVAZdyJrb0=;
 b=iXAO+M7UenGm82ndoEqgnQZjKlt505VeP53QJdg0YVYkinz1qokdP9xRIcEfvthuqT
 wyOtS5FSGo/1Yy0Jy4wNbvlFM0O75YFI/xWqX2na9F8+MoyMApe9v+kjFKj9DBILpL1W
 7uZOD3orE6rwOWVnfNXbEaQX79PL00XJ43A3AexANkqsaNT7M8dZVRzDqCAqqBO2i0+0
 zNRUATUm5HF6Bdf6MLSQMGt19RYRHELzF0iReUGsan4jnvKWySYdfTmTkkEH/qSLVNO8
 Y0kmENxaAchlhK4eQOTT6v+YKjoqhnDSpT6UL46hHHWDUioRvfMHB+YMRiw3RmBWNKxg
 Ihuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790331927; x=1790936727; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b2RNNH2CQU/BLQYIf7DffRzGPpzX23V85px/jF6IL/Y=;
 b=ALRqCkIFOBXvWBvZA9p6uRl32hgkqmCy9X0JBUSSNYrwjbouLmiyJSku1zeqUCLx7g
 cCjzJq7JQFaU/YE6zI8VklHADe7w2bbjfaFwgTwcbW7He+uFHz8ZBMwiaHFInCJOt4r6
 iV92TQ+RcsG8uOfClYarDBrdd0aY7ENGHR0Ok584KcjyE9Wgg1aYOXhaCdBSOK4QXICU
 R6QsNRcDUMY9KDLSL8XmJ3N4CvtydmPPSNf8fpWoQZmVTYrNddwuXjM9lTZFtgI3Ax3N
 xmA3mp8Y9CTvhbYHV4FseD4bQzyNTdpbro+920MWYF3gaQ5hcbYS+QVi+eAIcmyerIy9
 jlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331927; x=1790936727;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b2RNNH2CQU/BLQYIf7DffRzGPpzX23V85px/jF6IL/Y=;
 b=EOT4J0m3BAD+A9O+vJIklyP39RPtIBohMxAXkQypxvdTKrJVIRFZBnQqRA0N81/wes
 pDMO1qQyNNrmzpq5B+JDtjCVOO9DLyhgruDdRcfjrVYpqXU+Zf0mWHbqIm3DCMyBFJQc
 vg+rdD8neSE/6RtjSa3y/p3Ic8U+ynvInLjTILny6T1TRHDalDV4erQVaqKpaiXU/cHu
 5LFwHKMkQJpzheR8afOGHEp0N91MsEjjq8pKSRxxKd7ut9+p2GN9dQxAEeD6r+RULGVQ
 zJtKI293YF7joHp/Vp//ngqhbPlPsGuFnAvCGWTi67npa4JYR4hJGDD5KZXBswUb4JJO
 HxJA==
X-Gm-Message-State: AFuF++ldaCIxLPZOVwFXyrIHIr+OSP2DC3cIfvHsHEn+ezRKQg3+lGD+
 N7sHA46sZYEWu4kZuL8Zm1fVrkrkmTfVkE1Q5/HRRsx4GteVV/Wv3dlwJ/llZK7ry/b+gLpbVcD
 FIbVfNW6GmWzcGbxerFXxLjb40Ak9ew4=
X-Gm-Gg: AYBFou0UE8b2dJhgKGkA26gfn+JUbNeYvsLwtf289or//WMcVGI7sVC5UTwPolAF1lp
 Nn8CgGDNmjn7ZiUjq6BA0/3XpcnEzqZcl1BN1Ufv99xbBhOzfNRnVaGMHFkM6Dqk3Rsi1wJXprB
 0lHvhRwkp1ULATCNtcP8bYzng+d6BLGhOxARt8Netx/EHG/cKNWFGY+VObb26dEIOpfZlVZ6XrA
 U/GOvIvWbB0avu3lvHHL3JSFNZlVLYdEsqAymEwEljkpU0R9evusMDmY8dUnR4Nly3tee+raGmO
 hO3NXpJphC2Euh4f5vTglaZnWV9b2UJDTIfO+JV0iD4K76g2M3qzEdk4l4xVEA==
X-Received: by 2002:a05:620a:1d08:b0:93b:d7a2:dd27 with SMTP id
 af79cd13be357-93c43d22319mr366942185a.55.1790331927506; Fri, 25 Sep 2026
 03:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
In-Reply-To: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 25 Sep 2026 12:25:15 +0200
X-Gm-Features: AclHuK__xfbuQyw8A1yxTiDiOmm-9FYH_oL9ct_yOlM4r5AiL8pHsNyZTc4AMk0
Message-ID: <CACXAS8AizZjUEGF_O+ZQi08e-ADqn=vGy09Y0See_WJm7G-69w@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/sparc,
 hw/sparc64: add hostid=/machineid= -machine properties
To: =?UTF-8?Q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:34::10;
 envelope-from=atar4qemu@gmail.com; helo=mail-qk2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:55:25 -0400
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

On Sat, Sep 19, 2026 at 4:56=E2=80=AFPM Frode Tenneb=C3=B8 <frode@tennebo.c=
om> wrote:
>
> This series adds "hostid" and "machineid" as -machine sub-properties
> for the sun4m and sun4u/sun4v machine families:
>
>     qemu-system-sparc  -machine SS-20,hostid=3D0x352e09,machineid=3D0x80
>     qemu-system-sparc64 -machine sun4u,hostid=3D0x352e09,machineid=3D0x72
>
> Background: these machines report a classic 32-bit Sun "hostid" to
> the guest OS (as read by hostid(1), and historically use by some
> software for license checks), built from two independent pieces stored
> in the emulated NVRAM/IDPROM - a fixed per-model machine-type byte, and
> the low 24 bits of the machine's Ethernet MAC address. QEMU already
> reproduces this scheme, but until now neither half was settable from
> the command line: the machine-type byte was fixed per hwdef, and the
> low 24 bits always tracked whatever MAC ended up on the emulated NIC.
> Both properties default to that existing behaviour when left unset,
> so this series is fully backward compatible.
>
> Patch 1 adds a small shared helper (hw/sparc/sun_hostid.c) rather
> than duplicating the property getter/setter logic between the two
> machine families: a generic SunHostIDProps struct that a machine's
> own instance struct embeds anywhere, located via byte offset, plus
> two functions to register the properties on a class and initialise
> an instance.
>
> Patch 2 wires this into sun4m, via the existing sun4m-common
> abstract machine class.
>
> Patch 3 wires it into sun4u/sun4v. Since sun4u.c had no shared
> abstract machine class before this series, patch 3 introduces one
> (sun4u-common) as the parent of both "sun4u" and "sun4v", and
> registers the properties on it once - both machines pick them up
> through QOM's class-hierarchy property lookup. The "niagara" machine
> (hw/sparc64/niagara.c) is a separate machine family that does not
> use this NVRAM/IDPROM hostid mechanism and is unaffected.
>
> PS: This is my first patch set for QEMU.

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

>
> ---
> Frode Tenneb=C3=B8 (3):
>       hw/sparc: add shared sun_hostid helper for hostid/machineid propert=
ies
>       hw/sparc: add hostid=3D and machineid=3D -machine sub-properties
>       hw/sparc64: add hostid=3D and machineid=3D -machine sub-properties
>
>  docs/system/target-sparc.rst   | 23 +++++++++++
>  docs/system/target-sparc64.rst | 22 +++++++++++
>  hw/sparc/meson.build           |  1 +
>  hw/sparc/sun4m.c               | 55 ++++++++++++++++++++++----
>  hw/sparc/sun_hostid.c          | 88 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/sparc64/meson.build         |  1 +
>  hw/sparc64/sun4u.c             | 74 +++++++++++++++++++++++++++++++----
>  include/hw/nvram/sun_nvram.h   | 11 ++++--
>  include/hw/sparc/sun_hostid.h  | 48 +++++++++++++++++++++++
>  9 files changed, 306 insertions(+), 17 deletions(-)
> ---
> base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
> change-id: 20260917-add_hostid_sub-properties-473a0d2ea35e
>
> Best regards,
> --
> Frode Tenneb=C3=B8 <frode@tennebo.com>
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

