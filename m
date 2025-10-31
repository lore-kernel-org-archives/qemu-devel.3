Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE600CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEsRy-0000fs-2O; Fri, 31 Oct 2025 12:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEsRq-0000et-RV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:58:00 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEsRi-00086C-NP
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:57:57 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63e10cd6efeso2664687d50.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761929860; x=1762534660; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/zqAfUZYeziv1avZ5odx+cLX9Ncn2Uiz8SeqeiDkn7Y=;
 b=kKoAE/6vmpAU2k9DAC5BAeHM+KNNgRaX5nOArd56RxoyJQpijc1Ja+jrcJkjy0pmsD
 W+spbdPTwoDtpGTFvJuBJpmGdU759Dpar9wmdiOcsOt6NV2CHvYe08owXwzEn2ecww+C
 YB5eJgNzxo9cQ65c+yCbG+TibTpDqIDeRtDH8W0B2jQoQeoS+CJTdC8R7x3Azq3cyERc
 Rt//cZutpade8OFB8/PPKaM1pr5Xvke6L09LI9Ja2VDjtzltDuvKedKbatUBUcvfk3b3
 SKA4jJCsbcMGRWo3vVk5EYDiZr8KkNAtk0r8O9rXxMQH4o+WNVxY4ducQAcVjGCDacBi
 3scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929860; x=1762534660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zqAfUZYeziv1avZ5odx+cLX9Ncn2Uiz8SeqeiDkn7Y=;
 b=PfjflApt9iyWayKXlX/eSxxVcFKoJjNi5MgkutKsRbmAqT54wCycG0DlwJkD+o6+k4
 rnKdqprbNxINaccaWYCEnEBb6g4eHbBtgzt9b0KSykpIz2i3HV7KNjm7916b5QoTa2U0
 3FSUYsIWWoAnOTtP+unuReSCnFc76s48SZ4xzJ8MWzrRLhlpVTYwGf/ThNGDSpUGNQ2C
 YR9PQkPQ7HHBRM80FRB898g1RH+K8xAHIjsPpKJ7vYEVp2cFT2hFhM1NWlKEFO1uM1SZ
 I1d0SvfRhsADlLxzZX3jfbxjYGO5AayyugJPkxiXFU/VFcjny5ynBUvqdxYRkdpljv/0
 MHQQ==
X-Gm-Message-State: AOJu0YzLCsH8C1U1sns125fONX60IDBRprMgLsggftnS02vbof30UWRD
 rfsEMA20dtfREoW2OyKu1Wx4ho3ctNFCvI8aZKzATHKb5ek5q3vtxef1z6r4J9O2RZ83JKeEMq6
 GcqGF7OhJh8ljj3tNxA9E0Llij22FmM9uRacig7aPvQ==
X-Gm-Gg: ASbGncv0oPwMpgCb41byBnof2/SJeINJvwjNjoIEi8feYngdTWGBNBJx6czQn6wWDDx
 3UQvaTLzsCgzNCzF3LuKsl5tMJmWjdiEKg8gPIo0HfYbiyKYS+Ygj5vmj0Org+ifXM6uuaYjRhU
 e6KOfhaRKUUO9kRHyCpWR2uyK6wSwMMwUyCPISwb5HazYHLFnhgoLUavDzBljSME7GdHavn9Lvn
 XUwQVpE0L8H1iISXTLXBuCwJf5keaZtvY7ehPMiOg763voAHM02bEtzYvRFbJkYOPrOsHYD
X-Google-Smtp-Source: AGHT+IFDh0Lq09uQ0mMdrengAFCe4Bctd0JoPp/w/vegteTwO6uF/QQhJZNKSo5WYJBbq7TU1Hbi0Ey8zpyGRM+G4B4=
X-Received: by 2002:a05:690c:6a83:b0:784:9076:a0f5 with SMTP id
 00721157ae682-786484df969mr61456517b3.44.1761929860437; Fri, 31 Oct 2025
 09:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251029142311.2986-1-shentey@gmail.com>
In-Reply-To: <20251029142311.2986-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Oct 2025 16:57:28 +0000
X-Gm-Features: AWmQ_bnbxV3CM7AYGaHx_0JL9Gz9R1Luc26flGIXTnkyRyxRVFFnWT2doySoyKk
Message-ID: <CAFEAcA-CGQ2JwDoBVZNhQyBMNKXbZsy2Ds+=m0MAPq0hrsWHhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM Support for imx8mp-evk Machine
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 29 Oct 2025 at 14:23, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series adds KVM support to the imx8mp-evk machine, allowing it to run
> guests with KVM acceleration. Inspiration was taken from the virt machine. This
> required a device tree quirk for the guest clock to be kept in sync with the
> host. Without this quirk the guest's clock would advance with factor <host
> system counter> / 8Mhz.
>
> Testing done:
> * Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
>   `qemu-system-aarch64 -M virt,secure=on,virtualization=on,gic-version=4 \
>   -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx8mp-evk \
>   -accel tcg -smp 4". Observe that the `date` command reflects the host's date.
>
> v2:
> * Mention various tradeoffs in the board documentation (Peter)
> * Accommodate for single-binary (Peter, Pierrick) by having CPU defaults
>
> Bernhard Beschow (2):
>   hw/arm/imx8mp-evk: Add KVM support
>   hw/arm/imx8mp-evk: Fix guest time in KVM mode

Thanks, I've applied this to target-arm.next. I tweaked the docs
for the bit about security slightly to add a link to the security
policy page:

-* Unlike other machines with KVM support, the ``imx8mp-evk`` machine makes no
-  attempt to protect itself from malicious guests. If you don't trust your
+* The ``imx8mp-evk`` machine is not included under the "virtualization use
+  case" of :doc:`QEMU's security policy </system/security>`. This means that
+  you should not trust that it can contain malicious guests, whether it is
+  run using TCG or KVM. If you don't trust your

-- PMM

