Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2181C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOGo-0001e5-0U; Mon, 31 Mar 2025 19:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOGm-0001dO-Kk
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:10:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOGk-0006Ly-CO
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:10:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so25939485e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743462612; x=1744067412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cAYIVcO0+7PzggzfAiCIvJVp0eRW/9WLY/Gv8rvnXlM=;
 b=NkMNucMOJgJzQD8cnE24LRTu1x/3EBQmfkkJVhOvV5/N5+vNrScbmlGwPlV6UJlaO3
 azWJUXO+0V4aY4eqdl//39aW08D0avoKma87ZU8bo2K56U4QL1Ov0Du3W3Wtwa/Wy9j0
 ZJTl5QW3rvnbe4cCFZut1oaUPe436IuUIEV8HMtTO502C03epwC1Pb1I9o9rFncoptCk
 rwA9m37i7yzHEtUi4cWwvpe5g+THBngIIO/ZtG4x31oNsLXliQXiL78dVZyS0sjT8wNb
 hXrTlkaNAZ3JEkwbp+eFLa2Fgy0IXTdoXqyCUo5SSR1arPRcpbxUInskRhmZuh4kQf+K
 vYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462612; x=1744067412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cAYIVcO0+7PzggzfAiCIvJVp0eRW/9WLY/Gv8rvnXlM=;
 b=NpVECsZ5KFJYcAzG/j+D9pud8WDe+2TruVrR5n88e5ZodtVX1Z2hKt9O/VbSG7WbM7
 vH+Gw1HXMxY1PU/chKq8jsKF8uFkDWjmVUGqp/iSRSTd097m7/4es/NUWnOlhIDy0dCt
 F0pJYa81u9f8MByIgnHoMoxSCacBSuWoUmU91IDQtmPP1rT6sA54JiVoo/m0emqJYrtw
 MiCHBQssqxw9VJ1ZIpOy90OlzCr1YGnYvs5WnzCd+MafOHNAx35LE5JLb2QzbJsA8lpJ
 Vbb3Sqx3ZbkEoZPhoLHUdr36X0xJVlkyDDALfRvI6NTtVn5rvmXLUUs5S2aor7BtsKRM
 aXOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlX/DWyngbzBxqCkJ8fUTidg2kHQQd5RHqzyX+3MBJv2RwOlvmn8PC9zyNJ6//UOAyITvpAQBbF9XK@nongnu.org
X-Gm-Message-State: AOJu0YzhXH3adHik3SNpxgjI/CSMzRJ2PS0HNugiYzCU5ikEhr2/JDg4
 LvwNYTLJuMFfrs62QBiPWf+undmGieUwZDtuqP08I0NL/lzvTDK32uWKiAzZT5U=
X-Gm-Gg: ASbGncuifSJ+wL/BZTnkE6YL8VSpFDdqNRgCZKAz3pZONXRGp/KEpUrMV9sAeFoOEx9
 QcacUaiB/vljSJtsJuyFG3gCalVidQkMve/0x7dJkOEERTR3oU2Q/b3I8frNkWs+P9B3M+4s9gK
 jxAsc30WOsdneO/gJuy9uIv4aqGVAziR6fFkpcJHAcaHHg/c8WExuJZJyDgr9/8vGqIfsIrlBW4
 p8cdZLjNtMnXueEPeq6PNlqOBKo+xI1/4GMTywVWDMdfkifnk1+taJCTSn359/+EKIzgbgBisqJ
 UGHYLE09t907z9EoOx2aEFCjNG0k4sN3wp18tQ9wW2yhF90wxSWnuNcOklbaMvNV8Dv6f2mzx6S
 +4AJxL9mFHKbw
X-Google-Smtp-Source: AGHT+IGb1o8E90tNkXCNxkNkGfE52P2qP5T1L0RBHLvy8CycNr+Wzv+wM0rVFJWbEowJ6n+Ry0xRbg==
X-Received: by 2002:a05:600c:198f:b0:43b:ca39:6c7d with SMTP id
 5b1f17b1804b1-43db61d8326mr103383355e9.3.1743462611902; 
 Mon, 31 Mar 2025 16:10:11 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d830f5708sm182395345e9.32.2025.03.31.16.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 16:10:10 -0700 (PDT)
Message-ID: <71d6c639-7c85-45f0-9987-afda848a1b82@linaro.org>
Date: Tue, 1 Apr 2025 01:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref
 machine
To: Kun Qin <kuqin12@gmail.com>, Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Graeme Gregory <graeme@xora.org.uk>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250225074133.6827-1-kuqin12@gmail.com>
 <20250225074133.6827-2-kuqin12@gmail.com>
 <CAD=n3R2kuvUzyE7nKPmpyELozdo_+eAKVr_CxA5HQ_jLL25stw@mail.gmail.com>
 <CAD=n3R0ntWYNN9LxJWVXApY3s_LRddx4YVQPYRzRojXcL-BDug@mail.gmail.com>
 <CABhrWrRTFF1f7akWJ-jDZ7MGZGz4cBLq-yjf0vD5baBFc_XgtA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABhrWrRTFF1f7akWJ-jDZ7MGZGz4cBLq-yjf0vD5baBFc_XgtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Kun,

On 3/3/25 23:55, Kun Qin wrote:
> Hi Leif & Peter,
> 
> Thanks for the comments. I will address them in a v2 patch.

Please also Cc me in your v2 :)

Regards,

Phil.

> 
> Regards,
> Kun
> 
> On Mon, Mar 3, 2025 at 12:44 PM Leif Lindholm 
> <leif.lindholm@oss.qualcomm.com <mailto:leif.lindholm@oss.qualcomm.com>> 
> wrote:
> 
>     Doh! Add the lists back in. (No idea how I dropped them off.)
> 
>     On Mon, 3 Mar 2025 at 17:02, Leif Lindholm
>     <leif.lindholm@oss.qualcomm.com
>     <mailto:leif.lindholm@oss.qualcomm.com>> wrote:
>      >
>      > Hi Kun,
>      >
>      > Apologies for delay in responding - I was out last week.
>      > I agree with this addition, since a TPM is a requirement for servers.
>      >
>      > However, to help simplify review, could you add some detail in the
>      > commit message
>      > as to which SystemReady requirements this resolves and whether this
>      > implementation
>      > fulfills all requirements across BSA/SBSA/BBSA?
>      >
>      > I agree with Peter that since this is a non-discoverable
>     component, it
>      > would make sense
>      > to step the machine minor version number. A major version bump would
>      > not be required
>      > since simply adding this component will not break any existing
>      > firmware (which will have
>      > no way of knowing it even exists).
>      >
>      > Regards,
>      >
>      > Leif
>      >
>      > On Tue, 25 Feb 2025 at 07:41, Kun Qin <kuqin12@gmail.com
>     <mailto:kuqin12@gmail.com>> wrote:
>      > >
>      > > From: Kun Qin <kuqin@microsoft.com <mailto:kuqin@microsoft.com>>
>      > >
>      > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625
>     <https://gitlab.com/qemu-project/qemu/-/issues/2625>
>      > >
>      > > This change aims to add a TPM device for SBSA ref machine.
>      > >
>      > > The implementation adds a TPM create routine during machine
>      > > initialization.
>      > >
>      > > The backend can be the same as the rest of TPM support, by
>     using swtpm.
>      > >
>      > > Signed-off-by: Kun Qin <kuqin12@gmail.com
>     <mailto:kuqin12@gmail.com>>
>      > > ---
>      > >  hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
>      > >  1 file changed, 24 insertions(+)
>      > >
>      > > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>      > > index e720de306419..93eb3d1e363b 100644
>      > > --- a/hw/arm/sbsa-ref.c
>      > > +++ b/hw/arm/sbsa-ref.c
>      > > @@ -28,6 +28,8 @@
>      > >  #include "system/numa.h"
>      > >  #include "system/runstate.h"
>      > >  #include "system/system.h"
>      > > +#include "system/tpm.h"
>      > > +#include "system/tpm_backend.h"
>      > >  #include "exec/hwaddr.h"
>      > >  #include "kvm_arm.h"
>      > >  #include "hw/arm/boot.h"
>      > > @@ -94,6 +96,7 @@ enum {
>      > >      SBSA_SECURE_MEM,
>      > >      SBSA_AHCI,
>      > >      SBSA_XHCI,
>      > > +    SBSA_TPM,
>      > >  };
>      > >
>      > >  struct SBSAMachineState {
>      > > @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      > >      /* Space here reserved for more SMMUs */
>      > >      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
>      > >      [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
>      > > +    [SBSA_TPM] =                { 0x60120000, 0x00010000 },
>      > >      /* Space here reserved for other devices */
>      > >      [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
>      > >      /* 32-bit address PCIE MMIO space */
>      > > @@ -629,6 +633,24 @@ static void create_smmu(const
>     SBSAMachineState *sms, PCIBus *bus)
>      > >      }
>      > >  }
>      > >
>      > > +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)
>      > > +{
>      > > +    Error *errp = NULL;
>      > > +    DeviceState *dev;
>      > > +
>      > > +    TPMBackend *be = qemu_find_tpm_be("tpm0");
>      > > +    if (be == NULL) {
>      > > +        error_report("Couldn't find tmp0 backend");
>      > > +        return;
>      > > +    }
>      > > +
>      > > +    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
>      > > +    object_property_set_link(OBJECT(dev), "tpmdev",
>     OBJECT(be), &errp);
>      > > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
>      > > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      > > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
>     sbsa_ref_memmap[SBSA_TPM].base);
>      > > +}
>      > > +
>      > >  static void create_pcie(SBSAMachineState *sms)
>      > >  {
>      > >      hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
>      > > @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)
>      > >      pci_create_simple(pci->bus, -1, "bochs-display");
>      > >
>      > >      create_smmu(sms, pci->bus);
>      > > +
>      > > +    create_tpm(sms, pci->bus);
>      > >  }
>      > >
>      > >  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo,
>     int *fdt_size)
>      > > --
>      > > 2.43.0
>      > >
> 


