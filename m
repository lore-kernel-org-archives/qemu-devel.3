Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BE3C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20YQ-0005rd-K9; Thu, 03 Sep 2026 02:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20YI-0005r4-ID
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 02:04:00 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20YB-0007Z9-O5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 02:03:54 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-861f30636f9so27823107b3.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 23:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788415430; cv=none;
 d=google.com; s=arc-20260327;
 b=Q6PEi44iUEUnC7PcOx7Cmck/qSpcc0kVomhUY9/aT/TjfSSBCyueNbSZ45z+LSyeV4
 Cjefooz3mljszgQbcsL0I0uHh3S9zx/GQ4hURrxZgEbpDtWtA8RRZOnOWZ7oWPGENNxC
 fTQtuMbJY4KU8cv+1eeBhSH1uRmOimagzuPBxpj1w2M+1Q2wwDZSOpMcz1LpoKpgcH1D
 u3I0mgY+DfjCXIqtcIQzNnEA11GquIj9I2mLSSlleRDc52BI3/qsDDUweNPr137YdQ6y
 5QUkrrM4p51FZU/Z6jizdYo7m0befJ3yvoBemr1WyvPSpzRhplR73uTjOKbCTZoSjH27
 A/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TQqJdGmgIswz+dHrwW970Ng1x54TxYt5LKqbBQDyswk=;
 fh=8uTrJb90l5R3XB1p22UwGmGHmBMrgyp5rK7jzFP6Wg0=;
 b=YLuJvUfdlaNUouUMX+yCyGbNKYzKjbOrNptMaVtp9zcLq2tv8juy5SJBwKa/iDVHhj
 BHIvbSdAuSArESrkptONIV70zIyVmqdt0u8n3XJZow0TFbfHSwMsRWwsIog6j26igO9w
 pnVbRkP+A+O43aSsNf/Ufm6ezJcYrCSm+Fvq5r97QshvfLl6ZaKSN2eF0ZBac498Umr5
 Nosrqzq2r+4Yb9POEzz2qIALkAszt5H4tDaRHY0MpcSaar3QKj+LDDgR+DcjQJG8wTiF
 kz5r8aoGh61TQeWX+GbuGWzJ5ieh8FXyU4XHNGRhvtO+mpuV+na++3RskUqW1QOOKxj4
 Q7Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788415430; x=1789020230; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TQqJdGmgIswz+dHrwW970Ng1x54TxYt5LKqbBQDyswk=;
 b=TpR8bOl30I+KvzKOCgnMVZ8h4f7zsqvQLfsiQLvZ2FTu2beJ7fdc7pKFfoDGQcdHCJ
 Z31mSxODJGv8E8UJIsV03nCYWoqMCoNBK14iWrsh2x4KHUxD8TMNKnO3d2dVG6Y2uQ+0
 ZsPnUJacseCrgdULPGkf+NqHKf59tHimLiuPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788415430; x=1789020230;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TQqJdGmgIswz+dHrwW970Ng1x54TxYt5LKqbBQDyswk=;
 b=HAM+hwqxUv3SwyqmoluDYyHY6vuN+pjrh6Liywwsnt2+kfbibmyk/I5bFUbK3kPqhY
 P5w3w/kFbyyDOKVHAZlgJEpsZbUy3ftHrSwf0W+Eg53dhSntFfmq3K7T9GoHi3+/bTqL
 neInsVqoOVTumZUaA1urgMtQsY1zsddx8pzx3H/UDRhV2wEM0QexO7QuJc8tNK9Vt+Yj
 ATI69rDn64w+Rsej1DzerQXv/oUDHgsBUNvKzanKiaJraGaOvBFYwQ+vTmL5rIvqJ719
 RX3gJJ0zR9HxrmdZ8deBIdaN4GvYoCH9ijrHGmoT7P8XTLJCUcIEJCfSvfAJmApt/4ji
 zmTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPItN/6vxTAym28SHI4nGSS1WH+oiwvhmhYaLW1tm+TmfwWGzkvxouClYIcOzsk+vg7QvER6THEoV6@nongnu.org
X-Gm-Message-State: AFuF++kVPduMbFi3zZz173JpfhW+Jx+VhoGA/73wnrT5wZAxUnuCduYw
 vJ4po+ddsqLhoIQppp2wLwfMHmbXtDhiKFob7LXcy6FOyt0MEkhzkvu/HqEc35vmnokD+mM+QOW
 ICo04unuGNemB0VOYXLKrHUfFzisSiDo=
X-Gm-Gg: AYBFou0AW/fAmoXHYgqh5wms0O3h/CgPNUPQ7zDpB+Auh45Sym9iRQZq+2M8eGRuhxE
 ddFDzbYIjqYvI2HMcJTzRXlYXEpL7b9JH2jq2EwbXQGaA2KHFB+FqleJ9bOE3ow4Ye3C01vhJPm
 kIcTjHQjr0QpWrVHztfyqSpkkg8DJilX/M2DKh22Q27gNUtwz7rCziP2PVuBdWL4SXUYLwyJeVj
 CBbV7P2KELJNq4XDRwq1KL9l4yjOzGJSYdTR/1smGAxBnKqZMPDqsO2xUDID1gAHEbbTombkohI
 cIl+UV9dF/tGef96OcPoWRN0h9R8tLJAQlbpWRX3CHH30F+pOwrtjYQZlnet8ew0Q96zVdPb91a
 IXox9cNKiuorq24LyLzFjIwthey63pavKN/inbikOYhT+uAb0GpamuqxlCac642+Zj7jZj0Renx
 5nSzAgrzHPpXY0MLBb
X-Received: by 2002:a53:aa0c:0:b0:66f:8b35:dedd with SMTP id
 956f58d0204a3-66f9bb62519mr2580148d50.6.1788415430255; Wed, 02 Sep 2026
 23:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260831021500.82565-1-joel@jms.id.au>
 <b4605e538d7a49decef273b314e2c74dbaba9476.camel@wdc.com>
In-Reply-To: <b4605e538d7a49decef273b314e2c74dbaba9476.camel@wdc.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 3 Sep 2026 15:33:38 +0930
X-Gm-Features: AcwNN1XwcJ64jJpfqwVFp9MLjJ52FNjKWnYkHfsv-F9C6YiJUb81JYGhNIesxqc
Message-ID: <CACPK8XeEnR1gnY6PaadsegmtDuOZXgkMJX4oeDO1QjswA_6row@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] hw/riscv: Socify Atlantis
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>, 
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>, 
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 3 Sept 2026 at 13:41, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2026-08-31 at 11:44 +0930, Joel Stanley wrote:
> > v1:
> > https://lore.kernel.org/qemu-riscv/20260826220528.54516-1-joel@jms.id.au/
> >
> > Changes in v2:
> >
> >  - Reword patch 14 "hart private memory" commit message to clarify
> > hart
> >    vs hart array
> >  - Fix indentation in patch 4 (riscv_aplic MemoryRegion)
> >
> > Thanks to Daniel and Philippe for the reviews.
> >
> > Original commit message:
> >
> > This addresses the review given by Cedric on v1 of the Atlantis
> > patches,
> > where he suggested making the machine a SoC. This is the pattern
> > followed by the Aspeed ARM machines, where the SoC represents the
> > modelled hardware, attaching its devices to a memory container, with
> > the
> > SoC instantiated by a QEMU machine that provides the memory container
> > and the machine's RAM.
> >
> > Aside from the clean abstraction that this encourages, this pattern
> > will
> > be useful in adding other SoCs to the Atlantis machine, such as the
> > RCPU
> > (boot microcontroller) and CPL (Cluster Power Logic microcontroller).
> >
> > The series converts the RISC-V interrupt controllers to take a
> > MemoryRegion for mapping themselves, with no change in behaviour for
> > existing machines, and then cleans up the CPS device to place its
> > devices in the memory container provided.
> >
> > The next few patches clean up the Atlantis machine to make extracting
> > the SoC device and mapping it in a container relatively
> > straightforward.
> >
> > Joel Stanley (15):
> >   hw/riscv/aia: Take a MemoryRegion for the created devices
> >   hw/intc/riscv_aclint: Take a MemoryRegion for the created devices
> >   hw/intc/riscv_imsic: Take a MemoryRegion for the created device
> >   hw/intc/riscv_aplic: Take a MemoryRegion for the created device
> >   hw/intc/sifive_plic: Take a MemoryRegion for the created device
> >   hw/riscv/cps: Map interrupt controllers in SoC container
> >   hw/riscv/atlantis: Make UART unimp region a SoC device
> >   hw/riscv/atlantis: Remove unused fdt_size
> >   hw/riscv/atlantis: Rename hart array 'soc' to 'cpus'
> >   hw/riscv/atlantis: Rework device tree creation
> >   hw/riscv/atlantis: Use local reference for system memory
> >   hw/riscv/atlantis: Decouple RAM size from MachineState
> >   hw/riscv/atlantis: Make TTAtlantisState own memory containers
> >   hw/riscv/atlantis: Extract an Atlantis SoC device
> >   hw/riscv/atlantis: Map the SoC through a memory container
>
> Thanks!
>
> Partially applied to riscv-to-apply.next.
>
> I applied the first few patches, after that I hit merge conflicts with
> the recent FDT changes. Should be pretty easy to fix, but I pulled in
> the first patches to keep the ball moving.

No worries. I didn't see any of the patches when I pulled, so I sent
the full series as a v3 rebased on the device tree patches you'd
merged and pushed.

Cheers,

Joel

