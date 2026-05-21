Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19406CD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5PR-0003uC-Hy; Thu, 21 May 2026 11:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5P6-0003j1-0B
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:33:45 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5P3-0001MB-Kk
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:33:43 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-90ca6f20872so869996185a.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779377619; cv=none;
 d=google.com; s=arc-20240605;
 b=OcZYn5V+CIlKyhfaPH9n2CX/NxE67OTIqty0FvaLHsXlg7nlIlTvWXGtYAYgLEmuKx
 NKFLI7MpmxK9sdTvmrOiPnjxDdyj4YmA2M37M+GGznqnefjx97VdkksrT0k7JWjdMSXP
 ZVNIUcqbil82JjfnM19ShYOzTeTukEnWOdygR50T+z7U/DnC/8AWGOe7A81q2brmJgZx
 HdxJCL5LXCKhxYoNkffYBOvktFf45ShCUIle93ZsULm0WOH/J46txjHBuLPPGTqaE7c2
 GXAAbB4LakLdUqejSrhh+duEP30nhfozJlgzLrgnA1IxFbheSQF3dDM5MfU6halyZ98S
 sauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=peDINXBxcKWQYjVspnPJmH/goNDZV4Xd6bFqDbTEs+c=;
 fh=qz5jHiMNfVBJ88oqmstg9p/MLllNZlxY5VnP9u6Gy/E=;
 b=fSxLxiOEGP+5DT47N7H91urtmqsbDTYuv9j0jrxpVnUD58H+oT6cq/h+7gQJAiB+dF
 aiOkJ4c+2l+2brO4CV7xrcU34WNWU5npgeZLNzzlLp1YjhAuPDeanELqcIVT6M9WWiM5
 Y5lxN/1IwjBO9E6R89WHfCe41HtFbsSF/6yP3PODMCqdC1sMy4PnbmZqDpGP72OULKCK
 /qLoCOPQy5f8WnxsVrDcP7bVaZ5cdD/yCt7xikoVjWJ3DxEWX9BSGN4iZbITACB07a9Y
 lSC6jRJxJjrJABtpXUCowb5Es19eZGtNe7LWrSbzebirTaIBt/cmd++Uvhpcq5wM+qnW
 ZcsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779377619; x=1779982419; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peDINXBxcKWQYjVspnPJmH/goNDZV4Xd6bFqDbTEs+c=;
 b=jitNQCdD4psjDLEOWx3wkF8MY87GOnC+0PB3wgrKuuBYAHbR90pGL9rI52UwjcEvGX
 t3UdviaORhtweupaQhG/oDXXWn82h9WW2lEnEfGhliSQeDwXBNwM6ieAji88ykibtmB6
 Hp4H7xpie19eVxrkIPMvm5IqE0cQtqCi4mEq/wBmMZ1xHyv0i0mWU+2OAK6Wax+7ja9s
 3yVk4YNSICdxwlo925ndeNkXkcVH4QzbJBPWuPfIpsgap7AS5YoMNdz3EtypvClPu5cO
 cDlNrvi0dkwNiX7bNzDHdXdPlX1G7SKCyE6zbFDowvZk2IeLTZUiG9XPsx/Y9lPvldH1
 d5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377619; x=1779982419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=peDINXBxcKWQYjVspnPJmH/goNDZV4Xd6bFqDbTEs+c=;
 b=duEtQD3Jhak3+RapdCiq41c5nGH+O/l2TTS+epQyOcZI0FtUg00iXRx09vXk3dHFJ/
 wN974ymmqQ9WCkm9dkD7s/fCcQx8Q55Pl7dhvJGU9o1WtWy4VjporYQJ6cNGIiVpJmG9
 HQ4ugqZCNuUts8EF/W2nr0kjvUbTWVuxY9SAZph6wNV8vXOp7M828hHLRkG4EQm6+2qg
 rNrJmbaC3i1Pi3gH3zfecwgBSsVkmZHXmEDYlqps37mMexyiCde/2oTUQGpobVlC86OU
 g/GmPCvRHecyZQCpiesDhM6HVuofHS2BNIbgKyGUizrLh3PzmvKUWKDZ2Zwc7KIhr2Oj
 pKjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nKx6/ol4XLM6nHmS+aFpfCA+R2s7PJWEB22Qphdz1FKD5Ce0Y29E9/KfnPhnKia/m0TrQM0sXxO5v@nongnu.org
X-Gm-Message-State: AOJu0YwiuZavhwqyR52zzWjjX5H/7gEUXSMJKVHnpwYR53aNdise3iuL
 drmJVS3g9MKspJxzm3wBPdutIB8olcaZKwvucMhrrXhy8W7ez+5H1gFHcZcCpL3qTa0cv8NHx8H
 Nv4mliFI8nhwnFORHFH+vB/8Zn8PuhHLNbwIgotLaaAp1isf90X+fZ1M=
X-Gm-Gg: Acq92OGxtVhntYBpiUyprIeijYcKzrH1H4UAQCIxmGH0MToM9lSKwY5HoniHK8fc295
 N536u2cBVraV/oWRceTqE3tyfhIX3nRfkURGcnFQX3+N4X0bJDfKDpt8TTOMBvpmnQAoXAHGGTF
 7vKulWA2+G/aFjgLwgzS8hscFpKIIxOV+l1cZCX31//RYBjS8m6L6ecveftMvDuC84Zod6i/fzT
 jSpOt3O2/wrGGVwck66xzMDFXsDsmc7Sst/ez6r51cziBgxUc3KwsT1mycTU/2YUEa8HHXTcri6
 dHHiwi1ecLz45b/XXXBlQ37DA0nILapM6mqSCQ8A38bEVr7lpSar2g/dzRDLnz7W0ks=
X-Received: by 2002:a05:690e:4106:b0:65e:28f3:4a51 with SMTP id
 956f58d0204a3-65eacf4c084mr2450181d50.24.1779376891622; Thu, 21 May 2026
 08:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
 <20260521122913.1565011-3-peter.maydell@linaro.org>
 <87mrxsolqb.fsf@draig.linaro.org>
In-Reply-To: <87mrxsolqb.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 16:21:19 +0100
X-Gm-Features: AVHnY4Ii6rVxvA1qROzVPUpXFSIwUzts1U0lx8wgf2cfqvUYsOFufjyE9IZvlhs
Message-ID: <CAFEAcA9JuUY-en-_ZOnO3bjtgqG-MHp2ESGskdm-D0+fqFng_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=peter.maydell@linaro.org; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 21 May 2026 at 15:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The SVE FCVTLT_hs operation produces a halfprec result, so we should
> > use the FPST_A64_F16 fpstatus for it.
>
> Maybe I'm reading the Arm ARM wrong (I can't find FCVTLT_hs but I can
> see FCVTLT in the SVE encodings). But these are all widening operations
> so I can see halfprec to single, not the other way around.

Yes, I got the commit message wrong here; this is half to single,
and we need to use the A64_F16 fpstatus for conversions from
halfprec, not conversions to it. The e07b48995aaa commit message
does a better job of explaining this than I did this time around.

The _hs is how the QEMU decode file splits the half to single
and the single to double encodings, which are the same insn
mnememonic in the architecture.

Improved commit message:

=3D=3D=3Dbegin=3D=3D=3D
We should be using the F16-specific float_status for conversions from
half-precision, because halfprec inputs never set Input Denormal.
If we use the FPST_A64 fpstatus then we will incorrectly set
FPCR.IDC for input-denormals when FPCR.AH=3D1.

In commit e07b48995aaa we updated most of the halfprec-to-other
conversion insns to use FPST_A64_F16 as part of implementing FEAT_AHP.
However we missed the SVE FCVTLT instruction, which has a
halfprec-to-single encoding.

Correct the FPST we use for the hs variant of FCVTLT.

[cc, fixes, &c]
=3D=3D=3Dendit=3D=3D=3D


thanks
-- PMM

