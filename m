Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12DFC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 18:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhYBd-0000Op-Ho; Thu, 31 Jul 2025 14:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhWMq-0003uh-7Y
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 12:42:56 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhWMo-0003XI-Gw
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 12:42:55 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8e0aa2e3f9so693676276.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753980173; x=1754584973; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qi0c6cRVTk5kpKlIOxo9TZgeuUqi6ecgK1FBpxmZQdQ=;
 b=uIW/K3SjXloXc9cfSqCSy37CG/+/Gli8bShDOfrn93LqcT7ii+aWmVHmDO+/uHUysP
 xVhTwhjdWSy4Ok8GCIss1946MwQ1plMzuiaHiCagdNq1LhJwkAK354APc20a53fA4j4j
 p0EUgKf78gMwUi8isVmBBaH065OYmE11w68BzgIgPkPmy7zzvhGEBJvz81ZZ+E16+R0+
 Rnm1CvB1r/J82p4fKObJANEl1gXf3TyjWds1x765Ye2QDwBTd5Q1+juUTP1f8HGujc1T
 FtbaJZsySv2L1m9BhAANKKGlwnB01OeUv0mwyTLYuqvZ2mQ1WfZvtfqG83pQN7tUD8AJ
 P74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753980173; x=1754584973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi0c6cRVTk5kpKlIOxo9TZgeuUqi6ecgK1FBpxmZQdQ=;
 b=kDUIMQ8y/cs8NFxnqqojIz33BwSGZykEqNHZ3DtHe8/sOSqVciJ9/dbwkhDCiHkOGo
 rZeQwgR61F4dJCQ9etBMMQtZiw4UES4/d/Q4f1exMJJd3ntnOH3017mByF+4QaetMKLX
 fGBuL2MVxq1Ml2uCRMgD4hc2u+tBY6OczSqFMQ0tu6FLWUGZH/UaE8pvsKdIo1NXL7Qm
 ZfcnjId2hrJxNMB2qSaWjzs/Xi2WllRJbIviUUPW8oC82Qjb/fobB6ftWzYVSRYK8sXf
 Fx2Lx0DRAnr7IhO2AN54mIP+0Dj/1wenanjhW/mll1/YSboxoLilNZjbuYHr4/mvSEo6
 x+6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmeuHBGj6miH2257YC+uwti+4fLUiNlHWcIBbdymYr1qwAS5XgHJKSYOQuKb8CjqOfIuaxiVCQIGny@nongnu.org
X-Gm-Message-State: AOJu0YyEgjWAFZyBsmnDLZW6iCcbjrotkSKgUokaAp++uOSyNMTNnrxa
 fh07PzIF/+z2Q70J9oIAHNXIpPEFpLQIJK7K9xrAzmGtm78kKnzW7QyMgQjOgBTjMoycir8KD7b
 ipZi0NrI8LRzbn8k9jMSRVSRR9555qFd3tpr+2LqxhBY2wR2a4kAF
X-Gm-Gg: ASbGncsJ8bL+UZQTgwS8OQGZEogadOJjHqV6PJozpTFuJWhrAygYA2uJBm9J1wroLOv
 79VSxeyGf9sGk/oR0V5svnGiyBrqs6Y89siNYDM2i2KSKX0UM8hLb2SOT8ZwYeExSQNgpwHTOlj
 NpS+ae3k1S2tllmoon9XgaGbMWRnl861P5jOanxcn73bdZbfLp+EtcCG2ynbSmMQMwRaBwwQWr4
 /11b5UjHl+SX8rvnXM=
X-Google-Smtp-Source: AGHT+IH/A+Y4E1zBqX0wLau/1TfHFp55le/lmc7dKisliTmrMC+eXmk3qSCW9vOOP/X+8araS1IWGK7WjwmHT6SlzeE=
X-Received: by 2002:a05:690c:338c:b0:719:5664:87fd with SMTP id
 00721157ae682-71a4696d7b9mr115868877b3.37.1753980173073; Thu, 31 Jul 2025
 09:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250729161650.43758-1-zenghui.yu@linux.dev>
 <20250729161650.43758-2-zenghui.yu@linux.dev>
In-Reply-To: <20250729161650.43758-2-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 17:42:41 +0100
X-Gm-Features: Ac12FXzWisjJdV4iwLO0FJcR6gcIQwSjS4vLO9j561HKx_iU42KQuntvtrKAYWA
Message-ID: <CAFEAcA-hOWhKKhWLjD1pWyb+V8SPdOOuW0jWKN=wmn+mo=SBPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc/arm_gicv3_kvm: Remove writes to ICPENDR
 registers
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 29 Jul 2025 at 17:17, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> As per the arm-vgic-v3 kernel doc [1]:
>
>     Accesses to GICD_ICPENDR register region and GICR_ICPENDR0 registers
>     have RAZ/WI semantics, meaning that reads always return 0 and writes
>     are always ignored.
>
> Remove the useless writes to ICPENDR registers in kvm_arm_gicv3_put().
>
> [1] https://docs.kernel.org/virt/kvm/devices/arm-vgic-v3.html

The kernel doesn't implement any state behind these
registers today, but that doesn't inherently mean it
will never do so or that it never did do so.
Since we have the state fields in the GICv3State struct (for the
benefit of TCG) and the kernel defines the accessors for it,
I prefer to leave this code in QEMU, and leave it up to the
kernel whether it provides any state behind them.

thanks
-- PMM

