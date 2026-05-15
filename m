Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0649ACD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 09:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNoaY-0002AV-15; Fri, 15 May 2026 05:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNoaW-0002AM-By
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:12:08 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNoaU-0004FJ-Si
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:12:08 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c5361142fso11660473d50.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 02:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778836325; cv=none;
 d=google.com; s=arc-20240605;
 b=GpgCqxs5rPjo7ICccY8df21mtslhHZ5dhC6mHMXpF5hxyIPM1d9eFTuIeUJlkRvYGF
 7CpLJxCM5j9qlapRsPB7TI7nGqgu6GjJ1OCeM3JcT1jbR9FrXbCM1qkg3jTLphDSdVGq
 O2OftctTAgVnExRIrT53QnPUPELK+oUj9bWS2usi2l1+pW+VcpyPQT2j4E4xnudVXX9L
 5r9xe4ZQJkIkZqGDpUlu7FpscphC7LRx1gC2wgq4P1i5FU0lS6/s+rgcHh2QhcNiNP0P
 WfeQic4npMZHT5QlzRjCI2wnVrD+cBiFAxcrknyiHfFOR66FIprhB7fNftiPlkR/nSI3
 GI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SpXBInfx1Xi2APX4Uu6TA920Ypc3+pCiYiddVDuYeKE=;
 fh=d6Oyf/MCVHC30rDDM8v6CuBD9/u+KGqFbTyKViu3qIE=;
 b=HKhrAu9NFvymB5K+Hbd6Old4MlK8p7S+MWQ8CU00jVb2P82ckfQQdawGZspNZujjpp
 OeGzhl/862ddFbLtfVMnIFHyc2LBYM4tcGet0FVjASVNJmHX/6kvcA2u9nc+WPPcMBfQ
 qMRwe2pB83g0Co3MsPyHjt0KHmMsYfyyQMDzDdDjFIq1CRHyI2flJDIR4nPvbWuhurK1
 O8RESegHwzflnmX25dScSzyuyvDy8Nt1M//a5ZD9zfaNfIlHdbKE6VicKFlE4oq9KAWC
 hLRQAPbzHr5oxiyyb79cOwmTdkGr8QKUC4tILuPVsL8VyIYIJ0o9r7HrIkcMLoJCiej7
 BVxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778836325; x=1779441125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpXBInfx1Xi2APX4Uu6TA920Ypc3+pCiYiddVDuYeKE=;
 b=RBA/Wg8iylhr8Y6OW6TkO1xNSju6K2Fn/epvQ3Qfe9uuX9KXfMKMh5/eQghNZUaxw4
 97b5/Re8QRqU18uKdA2ojRP+2/dvrWpgTs4PZxWknm0rXeGokexufl/xemfmu90bBoPD
 q2c0oX0L+aki4WcJ/glvjltd+hEi86Q7VsZQxj3Z+hoLRBrmrSV/mQTKLCJwzpZNFy3I
 RykKnRMYA2QTawY7eghoD4sztHMndDtaF5YSC3Xy/YiaH+K3H2L3sQAHKovcJOj3plpD
 K3XIIikE3kcBVzm4H5cD+X7PyFjCnFMguySrYQx7i+37KzuxYlnv2BYfLYMCiBcHVa+w
 SGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778836325; x=1779441125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpXBInfx1Xi2APX4Uu6TA920Ypc3+pCiYiddVDuYeKE=;
 b=DyxDgf1Z7haybwBvVDyH9LUae0ZGgGoi89P2aPmiWO8rCFqFhdHYGEk9kZBRrT/MwU
 DlDyA3LFOa7I4z90LvDgQSMr9Cs53twS2uEeRdAy7QtGXRbGdOz9MTaHA7M35pyQabiy
 MplTioG5PDxz+Y+EM3KJupwnIdaUgqCI5ajcGmilAI5De5TnzcmBXu/AGCUznHvZKfHR
 1B0hePJTGrAJActs3vWvEvAbwo4OkuqMjFelq5+Ke+X8NQ++AxoQJ/drgHXG8FtJz/bx
 WdfSL29MZ2kNvXdserfnPZIb8vPtNf7XdDiYe84B9JlVqiEo3d1FvOyalRWXId2KPeRb
 gB6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ks4AtLPwQgIweFOwyaYhqTjF/gdKaTQ6Dn65e3/RMlxhgvkvRcBnyGW+nSEAppQ0LQlLAwuqQckTk@nongnu.org
X-Gm-Message-State: AOJu0YwfM4O6cvr0X2JfXhOmiE+tLUi3hY/m6GCuXUdr/JRXZbc5cYDD
 uJCBSvHwyvLbQaDJ4HDnZmNVVzG7U3zWuYpqYawvUynMJsIoVCYXdNXsgBryHIgcds7WsoY/BRV
 gNyGTB2iIwPaGi1TVgaoAq1yRj/rrm0sGooTPMRdhOJq6Ue2+N5p2
X-Gm-Gg: Acq92OGkorYh6vjT2G/ym03avlIcY7+nLyrkL9nZKFCUmrF/2KD5W6VYTYZ+qoU1pvX
 Pl9QegunbmpxVtqsa5W/92TVjhqpgQyLgfLpBfn0TNjx31THS9++VZFwkT7b4pbXxJW0eETgXNC
 P0/YhdF91Qn7V0jecb0qEv5Y+uXxIh/pNQ+hlT2hyf+zYYpVLyYtl6QO6QBqKTf2bJujhiQqUXi
 o04gyDWYgnvGeLvnyGsu+zxQdCekxjaCKPPoURfpvC+0dG9ijRaoYj4+a5BI2JJyzRZUh3UEfiJ
 i80LWsnn+BJoFDUXNNG5Rm7FX+DYvP33RTk1E6yt2cuX+tAoIsyK+IgSyIru98KADww=
X-Received: by 2002:a05:690e:480f:b0:64f:edcf:6f1 with SMTP id
 956f58d0204a3-65e2281edd0mr2248506d50.52.1778836325345; Fri, 15 May 2026
 02:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260317072018.2586572-1-gaochengbo@bosc.ac.cn>
 <e94b67fe-30be-4932-9b73-ef76bd2aa9be.gaochengbo@bosc.ac.cn>
In-Reply-To: <e94b67fe-30be-4932-9b73-ef76bd2aa9be.gaochengbo@bosc.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 10:11:54 +0100
X-Gm-Features: AVHnY4JhnU0jYXFcn94Mq4_kynSTHw8glOMPitOzQbFtUmOHIyBu1IOdA0SdL3E
Message-ID: <CAFEAcA9MyJKuCbfpTEqxFNsMnFSrUN5RQm0PLjVwiJkM50XJ+w@mail.gmail.com>
Subject: Re: [PATCH v1] hw/pci-host/xilinx-pcie: Set explicit bus name for
 Root Port
To: =?UTF-8?B?6auY5om/5Y2a?= <gaochengbo@bosc.ac.cn>
Cc: paulburton <paulburton@kernel.org>, arikalo <arikalo@gmail.com>,
 mst <mst@redhat.com>, "marcel.apfelbaum" <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 15 May 2026 at 09:52, =E9=AB=98=E6=89=BF=E5=8D=9A <gaochengbo@bosc.=
ac.cn> wrote:
>
> Re: [PATCH v1] hw/pci-host/xilinx-pcie: Set explicit bus name for Root Po=
rt
> Hi,
>
>   Gentle ping for this patch.
>
>   The motivation for this change is to make the secondary bus behind the
>   Xilinx PCIe root bridge addressable from the QEMU command line.
>
>   Without an explicit bus name, it is difficult to attach another PCIe
>   device or bridge below the XDMA root bridge using the -device bus=3D
>   property.  With this patch, the root bridge creates its secondary bus
>   with a stable name, so command lines such as the following become
>   possible:
>
>     -device xio3130-downstream,id=3Dswitch1,bus=3Dxdma-pcie
>
>   This is useful when building PCIe topologies behind the Xilinx XDMA PCI=
e
>   host bridge, for example when testing PCIe switch/downstream-port setup=
s
>   or IOMMU requester-id behavior.
>
>   Could someone take a look when convenient?
>
>   Thanks,
>   Chengbo

I'm not a PCI expert, but nowhere else in QEMU seems to reach in
to the PCIBridge private data bus_name field and set it like this,
which makes me think this isn't the right way to do this.

There is a pci_bridge_map_irq() function which lets you set
the bus_name, but we use that in only two devices, so I'm not
sure about that either.

thanks
-- PMM

