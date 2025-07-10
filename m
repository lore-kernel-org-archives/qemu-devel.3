Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4C3C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoje-0007Aw-3B; Thu, 10 Jul 2025 06:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZoja-00077l-Rz
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:42:34 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZojX-0006f0-V5
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:42:33 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e81f311a86fso661661276.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144150; x=1752748950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TYUd1N+JAahkudpDvfY84MdK9+eRklIdz/GsGZ6/ErE=;
 b=I4hNHCJPksF58ALZfNAiD5dzKVwqGVVBwhlTWx0IN/yrZ/6IqBQteZELI99ZIx8Na4
 s/xV9yS+FZ4GbmUeZvITTpkmF39io51JMDwu6DXSdw8S4QbCZ+GL2Lg0nlFmXMarinUa
 EGxIuOv9vaTl8LrnO3oqVOUczxzpSBy05VXHdXot7HbkcB6qft6zc2dS70MIpqsRLZoV
 cIvUqS77grIN7UQD75cI53pSGooJK5wmBnVDH3p2kEZ7ZhNtcFkb+7i7FUWNPAV8D35n
 Ys8Q9LsCUvjMY1r0zbZ2bpRC9xsrzThHL3rW3IWkUBlah8KGSJnBq/z3nEt5ugOEIvfY
 bZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144150; x=1752748950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYUd1N+JAahkudpDvfY84MdK9+eRklIdz/GsGZ6/ErE=;
 b=MyjyPQhz0DGj/l4tpWw195TiDDkzr5yRJGJr1pJ9682eezYDKunuxyyiwjr6sO6rTc
 xj+5BEKAT6sLN6av65GgNJ1vKJCH3U6Uyh6VLFfKUJqU2gbnIv3FTtFzjTyEbzFBkxsF
 0XYcudV9/CGyKMqKM0agRCR6LqgnV9q8uTGGlJTHSdOsm+CGeaneqxSMZwje+5wMNEvj
 /mt3TSF5+WMirsVc9iQDKg+kOhnd4C8NOKBrbTucwhjcucfQwNX5BWBIELlK/0Voov1k
 i+YhugHIm79KQZx/NGoqqq96NGAqQX8h7gWR6IwB0pKmzB9AVEftZJXtQpMpkBrwhL0d
 S4YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR8GqG2fSTngUOhf4T6eA3xiS2CwfdEmOeDSM6/EkK3OGd9Wj4h94ny3AMPsd+5rMzRJDtskonD/c1@nongnu.org
X-Gm-Message-State: AOJu0YxKEedcF2QN1W+WDqnDBo3XtbV3mK9KKj2KlxEfqCuCOD03NbIV
 P4xZ9VuwzWZXoR9flujHIEmTCDuzvCxKDgJ2xs8O3Be85tm8L4Psfx9asbxxI0ji7YMcShayVRo
 jtKriKlKMNtZcon2p2f4rylTQukkgVdNgEkShOhuaLg==
X-Gm-Gg: ASbGnctwtLm2h/WhzGU/+2GILsCM67AkyfJQb33uWaV7Y7nUwnEgWfAjEh2mhsmnkK0
 e0nqRonp+o3zfNNnKuzxTQj7xkkbDdQa4CcKzbPRxYPCSagpHLwSKUaBWPNfDYNYNIVrwbBKngc
 cEmzjKNYH3HitxLVUuGxcy2ioSGYOUfeApipZ3Kp77ZRzE
X-Google-Smtp-Source: AGHT+IHiCGHwovoSoz7isViSBPUSVoXdgYA6bFnfTwY9+nQihpv2EG8gfGdP6fUlse33BYQgUKxco6esLjt7lY01+a4=
X-Received: by 2002:a05:690c:882:b0:711:4392:7024 with SMTP id
 00721157ae682-717b1a1b334mr88454847b3.37.1752144149892; Thu, 10 Jul 2025
 03:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250707164129.1167837-1-eric.auger@redhat.com>
In-Reply-To: <20250707164129.1167837-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 11:42:17 +0100
X-Gm-Features: Ac12FXyFVNG23ayDaHmGHJCbt218HGl_vnwPYYPHCilPCzqyUEAkEZHRzDOm8Sw
Message-ID: <CAFEAcA8UGHWLY-OpSZ2CP=LY7AynO_YxS27BzLadegL40VgNYA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] ARM Nested Virt Support
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Mon, 7 Jul 2025 at 17:41, Eric Auger <eric.auger@redhat.com> wrote:
>
> This is candidate for 10.1.
>
> For gaining virt functionality in KVM accelerated L1, The host needs to
> be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
> with: -machine virt,virtualization=on.
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v10.0.0-nv-v9
> previous:
> https://github.com/eauger/qemu/tree/v10.0.0-nv-v8


Applied to target-arm.next, thanks. I'm going to squash in
this change

--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2248,8 +2248,13 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }

-    if (vms->virt && !(kvm_enabled() && kvm_arm_el2_supported()) &&
-                     !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
+        error_report("mach-virt: host kernel KVM does not support providing "
+                     "Virtualization extensions to the guest CPU");
+        exit(1);
+    }
+
+    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());

so we can distinguish "QEMU doesn't support KVM EL2" from
"QEMU supports it but the kernel does not".

-- PMM

