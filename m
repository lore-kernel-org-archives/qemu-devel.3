Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91691E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4fj-0006yN-1b; Thu, 19 Feb 2026 09:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4fR-0006rM-R8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:06:11 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4fQ-0000dB-8Y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:06:09 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-797de0727a4so9723607b3.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771509965; cv=none;
 d=google.com; s=arc-20240605;
 b=Pogbjg3pI78P+lQTYe1t0jvyL6A4II3hy+cB3k8y9BfP5nUkZQtruSHFnquv041r3H
 DVy58VaUl7a5p8YCUK7p4m5Y48SL5EdOeYEqxERQH27Yt2A0f4TVLJKpR1NLSaCg89IH
 3DnTcieSQvvThmrO14108znDE9Qcq0Y+KTPlWsznozOTEpAP82vtksMl6TijV0cRrCFR
 qUsdRMewpv24PJDzRj0g43Lf7J+Jtn660UXxHngnDhHYt0pykz+b6nYJ+YxdyF9TLqhu
 vFK1vaepdpRKFKKvwKxZhjEwxCYrPSwPPbW4bQ3ryMbmzax26xCg13T0L5j41BuGXH56
 Ly6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1uRVA/ilJQpQo+j1yGErgtYFcmf3MFrVl1a1lOJvd9M=;
 fh=ljsPVrMqM9WEgWa5yaVojVHzX4ehGvtuqRUN4Y5D7gg=;
 b=OXMfeExS6I818z2nPsr5QDfiaH0BsOE9r+syKy63JA9+0GCdDT3VCe8m8TmM3rMVvL
 ljc9ecCxfO7dwSGY6QvUWE7azXxHrz61Bg+iNp06gNECdeYOCPq2r5G4xnt6cz1xyOn7
 /P3Q8oeAGWEVF3gERINh24RSE47GF6I9t23SYhFObzQOPL5RSQkhNGc5LdPSiiBbgm+I
 xx5zrX6b93x3jj0vRsY9HVtPRKx1frGMkTyTMts1LQ4GBOunQiDrJJK25QeuMKb+I2vr
 MubCF1fBjxBRcBZfkCAb4/QD+VbFvnd4tzR9rJrILISPKZQdKUavwdTPsaYWiC2RuZ2q
 u2Zw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771509965; x=1772114765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1uRVA/ilJQpQo+j1yGErgtYFcmf3MFrVl1a1lOJvd9M=;
 b=Q268tm8IFGeWQUmJhu2VBkv9yMRp1Dn1ez6+2IEVKqdAWGs+mgNLepcnO82EpnWsxW
 b3773XkzGABAd0NVV01ioG/kVCso0i0wtqi58QLJXXVLQRY78k+9q1KPFz/J0wFTGsp5
 V2HQDLFvgsdnDMbbioXQFGYLUXxpEo0AczAhTGv40Nm5t2TqcKYITs5vNyKUC71nqh5A
 6cSCXKBcMDVJKAUHe7HDOEPhwFB2/dRNk2iadlru1HL1dA4HdoAymY8+FZcipwVAZ9ya
 VyLNHaAKGCE4IfsTSeQo2WVdF+vVEKn7iT1FsU1+sucKVG9LAe5BOpVBRAmSOCRYHAAb
 y1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771509965; x=1772114765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uRVA/ilJQpQo+j1yGErgtYFcmf3MFrVl1a1lOJvd9M=;
 b=nixKGP27sUiyxrvtFvw9u0ooByaOyskZVBSvrlZYJCi+YuPM/0hqrTBNOxkHGyEZpd
 1gHWol69MFQtLOD1tqqkX6ExirRe4ntLiybxMETRlQ5NG/sKgP2DgOLQuEVBcmOhq+i8
 GPxH3b3CUqqzLxnx99920E0huuG1Ty16qKpDuULADSjVkt3/WTdEsphJQy4J5kiFoDcM
 lVv+iDOlQ6vLaCd0h6opgmBjm9OTTJnNeb58TofIAasL0RLfWhTWjWbd9eVfOlkSPdqi
 WG1WomsM+bRC5AuhyW9X1PjNA6CfU/dTU7USYX4BVI8JmWeepaSLvcL7fcAOjGtmIoIR
 Rd0Q==
X-Gm-Message-State: AOJu0Yz/Q3pPJVYbjPQed9TXmAFRI9ZpTzBFm5CdEPsBNIVgt+RKhMD3
 GbkMYbZrUkqRHihTTlRQ0PLyk1/2+imAQJb3hRmauTjWrLOcAVSMQj9zv67FX6CEQmxllqVQxTD
 CU0atLxuFd3/bByells1Wnm71i7TXL6dK6uXuwWFHZQ==
X-Gm-Gg: AZuq6aK+XrgoAPRVAuMcHs16TckzyqQa/WId9a0zDQ7gHaw0xRKTht3E5FLoY+0qXhj
 0zkuqgYklTNj17j5IPaCWv9RgEnqsAVUVMoIfQiwbBhKm+5piCT8rn52zPhkfz9bw7k+cURo+tP
 cCG6WhJ0L31lTrMVm21B0nnQvEn/rfz7I7vLJySZDnUyV4ycMy3VcWPTPSW6ZjNUbJzw6jIsHid
 b7GD2y/yIZDspBFoiVNdZjv+5x95JXkRBzdKQHFDUUv8zb/WokklSqsdbjTQlhw4yucfq1YwQ3J
 IPvmtO1UMgJ7QRdMNPI3F+QnodVjuhFMJR5lSmRm6EhEiycAIYvkUub03WorjmjQJmYCeWZPhTt
 hvQ==
X-Received: by 2002:a53:d016:0:b0:64c:2a4b:72f with SMTP id
 956f58d0204a3-64c556b2d6emr3818234d50.44.1771509965445; Thu, 19 Feb 2026
 06:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <CAFEAcA-jtOBvOs2dJkrd2vwHFj54m2jPKK9fLSBLptAVNorhSA@mail.gmail.com>
 <20260219132729.1eb521cb@imammedo>
In-Reply-To: <20260219132729.1eb521cb@imammedo>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 14:05:53 +0000
X-Gm-Features: AZwV_QgOfPuH3afTS6WkOEMc7rUP4YGrDr2OP9GiiuO1N377bQ-Kw8Jgpkqhd0s
Message-ID: <CAFEAcA-PMj0iVB1r-_fYJZOz5RXtrsYzgMRPJMZOvptH_5TzpA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 19 Feb 2026 at 12:27, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 18 Feb 2026 19:10:02 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > The sbsa-ref machine already implements an sbsa-gwdt watchdog...
>
> yep, but not exposed as WDAT one. Hence the question.
> It also would need clock-frequency tweak if we are expose it via ACPI.
>
> PS:
> I don't even see DT mapping for it,
> looks like sbsa-gwdt is just wired for the sake of compliance with the spec.
> Well sbsa-ref specific firmware could just opencode it's mapping instead
> of getting it from QEMU.

The way the sbsa-ref board works is that it's supposed to be a reference
system and software stack that behaves like a real hardware system would.
So the "dtb" is not a proper DTB, it's just a way to tell the firmware
a few key details (that on real hardware it would probably interrogate
a BMC to find out). The firmware knows the memory map and what devices
are present, and the ACPI tables to pass to the guest are entirely
handled by the firmware, in the same way they are on real hardware.
QEMU's ACPI-fragment handling mechanisms are not used at all.

(This is noted in docs/system/arm/sbsa.rst.)

thanks
-- PMM

