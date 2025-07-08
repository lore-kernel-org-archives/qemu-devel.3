Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51F9C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFM-00034Y-KW; Tue, 08 Jul 2025 16:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZE7K-0007DE-Rt
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:36:40 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZE7J-0004mT-9b
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:36:38 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4a43d2d5569so55012881cf.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752003396; x=1752608196; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3gXcDba5XjXwj4VxzITchOJeSktDK0fljaShAYOG7RI=;
 b=X2b3p7dXAIs/v3YHZlYgreKMUU6DgdtYVwlpX9iOTskH7SQI5kHJAl+MeFAYSz4Gn+
 Z68YuCEOj9Vpht2WEucbbfs7x9nmrICY74D1azzkiP/zSuTnIdkA54N7k8JmZv+R1V1N
 b9v/Al1/Ia1eTtZhj7FNEhjeXEnfvBPMAla125RGBgBxZ9v12V2rKhJj0bME7W6ga/KH
 JY+1RSn8VxIpfnQcUMvD5TBy9qPE7D5qg+4ltHr9yj2j9xJaKIIcFcMXDp+8T8adnybw
 ZjsYaaTYSKgXiOazZsVc6YYJg8AICHvpRUR4WAOagL5y8HWUx3rvGIRIfzG7QVtQKmFX
 3cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003396; x=1752608196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3gXcDba5XjXwj4VxzITchOJeSktDK0fljaShAYOG7RI=;
 b=DGPGOO8G44TY+jKNYrN8bhzw5s7bypS2VomImrEP54bX6ifFVGdLCQzKcRIwAHoci9
 JNbtuP2pALipQ6FWmYmcaaBSiK3ttzwVWGja5KJdXmtIiYGGckpyv1SX/j5w3aFG9toR
 VV+NJZ6kxJBydnRKDykAbjJ1E5efAJjgvCr/SBI1zSxy/fxV3sHsfMasUO8ALQ2QmPfQ
 6cSLDg1yOwST6g0Y24c8LXy5p8xx6ojt/Qa0gOsSFqyPF4pPW4y2njhnG0pVBMdKetKY
 5sAOZLTONd/VIG0lQ5d1eyliVQMjQmesGJsDuU8n2XfEX1onX4hdLP441E9dggG+E458
 kTWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrchjFANq8Vy4dkxPzb8PMorkx9ZJjZSjNs2zWurgUXvRe+w1jL4jae09iEIil8AEq1gnEj1pFrQiE@nongnu.org
X-Gm-Message-State: AOJu0Yx7F10smATCMX4VtN5vqZRMnmIZkaIu6wWjh/ZhVE5lb0oJ0w6b
 fMgVxy5DpKoo0FLTp43+YggfWV/u+uRqthmtOMNMDmV9t3Xnah+JJJhe23h10SzHwFYz9bRPj7O
 cG1gqNjIVQqugeUvUlQ6UtvT80Gk8diQ+vO6DQIaVOGKcnYB5Swjq
X-Gm-Gg: ASbGncvla6iyZ9jcFjSPXL96PTLW2rHHHGAqJ1RqgW8KFzm3FT3LKC/KxCXuBulY/ry
 sF/YQ7xcwpfwgw4iwYJZUSaQzBQeceXPhEsV1Bj+t29MQEa3ga1whkVM98YmY8T9tcByjkrWws6
 6uBp7iDty92PLY4tZ5RKBoQ1mgsS65ExCWTPs2CWr7DPDhHCkvyjfSfUE=
X-Google-Smtp-Source: AGHT+IFjSmpyQ3CHcXmyN3qtie09DmBDcnmCHCImr7srtXytjoxMt/Y/TM5jsXE10uSIOhaWtgLk6rptieFqvshz0jk=
X-Received: by 2002:a05:690c:64c5:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-71668c0e7femr201134407b3.8.1751983184994; Tue, 08 Jul 2025
 06:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250703123728.414386-1-eric.auger@redhat.com>
 <152beeb2-7de7-4a4b-8f5d-806e7f18dda6@redhat.com>
 <20250707135106-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250707135106-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jul 2025 14:59:33 +0100
X-Gm-Features: Ac12FXxru7-LIqXPAtbxe2m1XeZoaHsn1qaQChfgk3r9Zc7wPOli4RE35O_Yci4
Message-ID: <CAFEAcA__rH00vLRSK23JyvafAwq5q9yV=_L8bcR4oV5P5vTULw@mail.gmail.com>
Subject: Re: [PATCH v5 00/36] ACPI PCI Hotplug support on ARM
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, imammedo@redhat.com, Jonathan.Cameron@huawei.com, 
 gustavo.romero@linaro.org, anisinha@redhat.com, shannon.zhaosl@gmail.com, 
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=peter.maydell@linaro.org; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 7 Jul 2025 at 18:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 07, 2025 at 07:09:34PM +0200, Eric Auger wrote:
> > Hi,
> >
> > On 7/3/25 2:35 PM, Eric Auger wrote:
> > > This series enables ACPI PCI hotplug/hotunplug on ARM.
> > > It is not enabled by default and ACPI PCI hotplug can
> > > be selected by setting:
> > >
> > > -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> > >
> > > Expected benefits should be similar to those listed in [1],
> > > ie. removal of some racy behaviors, improved latencies.
> > >
> > > The infrastructure used in x86 is heavily reused and a
> > > huge part of the series consists in moving code from
> > > hw/i386/acpi-build.c to a generic place and slightly
> > > adapting it to make it usable on ARM. The DSDT table is
> > > augmented to support ACPI PCI hotplug elements.
> > >
> > > On ARM we use use a GED event to notify the OS about
> > > hotplug events.
> >
> > gentle ping on this series. I was hoping that this could target 10.1 but
> > I ackowledge this is a big series to review and I am already very
> > grateful to all reviewers.
> >
> > At least patches 1-15 have collected R-bs including Igor's ones. They
> > can be seen as code move/reshuffle/cleanup and does not bring any
> > functionality. I think patches 16-19 also belong to prerequisite and
> > fixes and are easy to parse.
> > So if we could at least have patches 1-19 merged in 10.1, this would
> > alleviate the rebase efforts for next respins if any.
> >
> > Of course I have not totally lost all hopes to get this in in 10.1 ;-)
> > and I will be able to diligently respin upon comments.

> If no one objects, I can queue this. OK with ARM maintainers?

Judging by the diffstat this doesn't really touch the arm
stuff specifically, so if reviewers who are familiar with
hotplug and ACPI are happy that this is the correct way to
do PCI hotplug for Arm and have reviewed it then I'm fine
with going via the ACPI tree for whatever subset of patches
you think are ready to go in.

thanks
-- PMM

