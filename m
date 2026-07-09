Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D57C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfsu-000590-IQ; Wed, 08 Jul 2026 23:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfsr-00058T-PV
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:57:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfsp-00037w-49
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:57:08 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso794300a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783569425; cv=none;
 d=google.com; s=arc-20260327;
 b=S2rZ+CCYJeKRkN4G/Dbm3csETGI/eVTtXeprc6BxOhBSL6yJm8KHqPiDlhtJlKV4k6
 gmP5peGD8rL2eJr28oUKJDh01/D3WHhv2bkk4o+so903VnGRN5zvoh60gJ6rthGPcCbB
 dqUXO32NWLc+KKggAIiJjWftUxQPhJJCuwA8wkqerIqflzhj+U7L3FOfFEXSUbdtZvgM
 m8dPx4hxJVuvmnyC33P/tAFiD9/I6L2/LiXN4VJlO0m3YgxH7dmgR6QEVWMbWYCkYO9F
 m0G1V7cnBDBfh1wy7s93cyiO+6btuVpjeW63aMiJC6BvtIQ2rtziRnPK8B820Qt7Xuhb
 rNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nLplJtHM2neuMqbdGc8BysGwibKRIQ2sUJ9QDSTjj9U=;
 fh=DmP7s0wSrC5SJwQI1YS+4wW4eU6GvbJZdTmacNyCgm4=;
 b=Y/lTUq1azPMZzP/lgY9YiJ2ZgjgO7RG4nUpjCDpgAH4TpmZvk/wyFf7FEo+8cnjvLh
 d3KQ3Wu9v8xm06oyJAQV36IROB80m2Tz5FLYBehnRLD5NRYovJwdQKnFEwCS2Wmje21t
 +/7Qy8eYgjecusJvdmFWETFirBEupPIy/Dd02/cqI49rveyLYStWLS6HXbP1ME3J3Jma
 AzUoB9rK5fZt7o32aVubfslkilBQMNskrZmSSRdVqPrXiclfKChIDnFMUpYnQ5oX5SNa
 +wKhpckvr/Gl5967CGnmcB52XIfLg6GyHEpZuKeWHwknQ8mxgG3CvKWPlT5SzANjwIz2
 /dMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783569425; x=1784174225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nLplJtHM2neuMqbdGc8BysGwibKRIQ2sUJ9QDSTjj9U=;
 b=TwNwBiUuuKT9EaHqnkwdnc2cAkI3wy8559dabWOToqxbSOOonBXCJSYBu3W2IECdHr
 n2macz1tdbptP+Bc8IxA+aAl//7w1N219BDRnYYotah+sJiXYhbvdreVExnAkFuUk/Zy
 +7wtBM9DvreXJcuWAqUOzqwtAFtvMIGUv0vaKL7BuwARMdQnuOVmW5KwMYsr4vjl5E7x
 tKUF0roTH6lbtTmVgvZGhICO3OASxSKxxG3agUzuSgAeKJdljHoazPpWyQf6afknH1lv
 5raFhfviE9Zt1easFwqjbrpgToY9sZUv7wMDIh1hlqkCMJgQAlKXfoCLxbdL3JxvC5oF
 ImWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783569425; x=1784174225;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nLplJtHM2neuMqbdGc8BysGwibKRIQ2sUJ9QDSTjj9U=;
 b=pVF3KoISGJ38fJw+ah7zpnF75zZ9oKj/1ZvCXpJ6YkGpalRelC1WX79fdTY1lYQeaD
 gFNNhY2rxklEja9GUIIZNnudlO9xqXeQglVG6P7B8KGAi3ZDfjVNIUZffLGk2G+QvlV5
 o/uYjw5b1RPGzCBwxvtdoVT5W/7l/IRAPxCC11oSlcepZ5rVJXeff1dkwS63XZv+phQS
 RbBVJnR2Q7NPJkivD/cMBRVlledcj/KtyTXZ+zoL4qBOZsUNERoyt0wRm8yriw76tv1V
 /yYW81ks/WSmMffxEuUHPqsp+BmXIbRuB5U36RUb19VcenpAyfMdInGYNAvGRZkcVcco
 Z1VQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEqCPU1dctAA9GCpTkDQHDRpR6fUd7VYMvmFpTJkgspJbNAhkxYqde5P1eqZPvQBFzkYU5Qd7ums2E@nongnu.org
X-Gm-Message-State: AOJu0YxDy7nrUIkviyPGQu3iP95h7045YoWPcCNpxHr0uJOjtuLThY/P
 Hgb8lfmxMf1SnXRPYREHz77NbGfv/QORSA1temP4A0IoUnNLBCnF8jbJxHHF6jS63dvgTbLdR8s
 jbXG6XhsxBgFynno2Iz800lv/DBBT6tY=
X-Gm-Gg: AfdE7cnZGxttoKZod/AxcV7xTAReLuyOUpNzj0xi1yIA/RA2zEVsRfK0/J24Ffnf63o
 F19rZmeUnwyZzmeZegqUCC+DF6csAvpuRV2UNQtLAX3ID4CyXKIIV2yJGtWRlUog1aNV59GF4MH
 5UJUAnJqbbrpFdLP3wtq2EqAdLLIIA/7zOJZxi+Xdl9d0eIp7mfXHflLGNIn2dKBZ9OC10R9FMs
 byFLm66K8J1YYblT1nPyPdmelhSG150LroDrD9jBNH3QrUgQnmMG7rMfc8tgLKbrYYIfy0QBWW8
 RVNFT1K2steIdlaQCq93boZp0tI=
X-Received: by 2002:a05:6402:3814:b0:698:7418:57a9 with SMTP id
 4fb4d7f45d1cf-69c032a82a1mr376176a12.17.1783569425398; Wed, 08 Jul 2026
 20:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-3-cp0613@linux.alibaba.com>
 <CAKmqyKNmFdJRUegowCGggk+4fOmY7vBxOH+_gnmTSpNhyqWqHg@mail.gmail.com>
 <20260707115030.5161-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260707115030.5161-1-cp0613@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 13:56:36 +1000
X-Gm-Features: AUfX_mzGPIZl7w4I_sfMBRvqxgaPOqutCMZGwIBH_MVFtTqZr67SNShdej1XIes
Message-ID: <CAKmqyKPskHLaQMs1SCNjNRzhZjX-E=4KO4x_KS8kAc+LvSh3qQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com, 
 alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com, 
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 7, 2026 at 9:51=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com> =
wrote:
>
> Hi Alistair,
>
> On Mon, 6 Jul 2026 14:08:45 +1000, Alistair Francis wrote:
> > What happens to kernels that don't have this change?
>
> Good question. The behavior depends on how old the kernel is:
>
> - Kernels that support _DEP processing but lack the
>   acpi_dev_clear_dependencies() call in acpi_pci_root_add(): the
>   ACPI0017 (CXLM) device will remain deferred indefinitely because
>   its declared dependency on ACPI0016 is never cleared. CXL memory
>   would be unusable on such kernels with this QEMU.
>
> - Very old kernels that ignore _DEP entirely: the behavior is the
>   same as v1 =E2=80=94 the probe-ordering race between acpi_pci_root and
>   cxl_acpi remains, but nothing is worse than before.
>
> The kernel-side fix has already merged:
>   https://lore.kernel.org/linux-pci/20260526025118.38935-1-cp0613@linux.a=
libaba.com/
>
> So this is effectively a "new QEMU requires a sufficiently new kernel
> for CXL to work" situation, similar to other QEMU features that depend
> on kernel support.

That's fine, we can say you need a new kernel for this new feature to
work, as long as it doesn't break existing PCIe for old kernels

Alistair

>
> Thanks,
> Pei

