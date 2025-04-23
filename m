Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D81C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VT3-0007Kl-0z; Wed, 23 Apr 2025 04:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7VSr-0007Gw-5Q; Wed, 23 Apr 2025 04:28:17 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7VSo-0000WS-Lv; Wed, 23 Apr 2025 04:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745396851; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YdzEuxqFMoPtVxAGLjnyV74uP/wVJDnew7k4ogiZYiB7fyB5XHOJ4uDjIIIKv5DKzLUARxuaYQGIaVTUgrnRGTM1F+oaJACCd4Du8O9fmWdVDsf9oHxr/J7AN0MU2L/4mzmCwDiKdo4pnkysgK2cIb7UG+bh2AhQ7NFZmMxBZgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745396851;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3qxON4cikCwnWixyHU7Gsc9w5gqqY/duKNxswVYWL5Y=; 
 b=QK5mDNiAdtaFYvjX4NhMhki10aNTF2vBQldIkyiPhLWtFTSa5ZEVCoc7raN+B/sBd3bGc9EInkE2Wu07ChT2z5qbobZaG+4dR5RzWwUIMz8T2POeGJw7sMukU17wFTFGGm4T8I0PKW1djVnphTAA8aJlewg22babp9md5acZmQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745396851; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3qxON4cikCwnWixyHU7Gsc9w5gqqY/duKNxswVYWL5Y=;
 b=s9KKbNJAtShv4+yPYxiPzBqPxSdtQkjOAuuoM4tN3rbfN85s/1T7pG5Eedx+owu9
 SShTFgLcnrjnvD9cj92Q3OEEITWdYdneIoYvcnmw5Yp+oLYnJAuehVqW0DcihfVKzza
 O4Mk8Xa+WekyavZvKMAiHmlFXvaFzIB3ZUaGDWD8=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745396846882271.25102254364424;
 Wed, 23 Apr 2025 01:27:26 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:27:26 +0800
From: Li Chen <me@linux.beauty>
To: "Gavin Shan" <gshan@redhat.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <19661c250ff.e53d27651300291.7831062716952492543@linux.beauty>
In-Reply-To: <2bbfd5d1-be8a-41aa-822f-4c38449b79a7@redhat.com>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
 <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
 <2bbfd5d1-be8a-41aa-822f-4c38449b79a7@redhat.com>
Subject: Re: [PATCH V2 1/3] acpi: Add machine option to disable SPCR table
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Gavin,

 ---- On Wed, 23 Apr 2025 08:11:24 +0800  Gavin Shan <gshan@redhat.com> wrote --- 
 > On 4/22/25 10:05 PM, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > > 
 > > The ACPI SPCR (Serial Port Console Redirection) table allows firmware
 > > to specify a preferred serial console device to the operating system.
 > > On ARM64 systems, Linux by default respects this table: even if the
 > > kernel command line does not include a hardware serial console (e.g.,
 > > "console=ttyAMA0"), the kernel still register the serial device
 > > referenced by SPCR as a printk console.
 > > 
 > > While this behavior is standard-compliant, it can lead to situations
 > > where guest console behavior is influenced by platform firmware rather
 > > than user-specified configuration. To make guest console behavior more
 > > predictable and under user control, this patch introduces a machine
 > > option to explicitly disable SPCR table exposure:
 > > 
 > >      -machine spcr=off
 > > 
 > > By default, the option is enabled (spcr=on), preserving existing
 > > behavior. When disabled, QEMU will omit the SPCR table from the guest's
 > > ACPI namespace, ensuring that only consoles explicitly declared in the
 > > kernel command line are registered.
 > > 
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > Reviewed-by: Bibo Mao <maobibo@loongson.cn>
 > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
 > > ---
 > > 
 > > Changes since V1: add Reviewed-by and Acked-by
 > > 
 > >   hw/arm/virt-acpi-build.c       |  5 ++++-
 > >   hw/core/machine.c              | 22 ++++++++++++++++++++++
 > >   hw/loongarch/virt-acpi-build.c |  4 +++-
 > >   hw/riscv/virt-acpi-build.c     |  5 ++++-
 > >   include/hw/boards.h            |  1 +
 > >   qemu-options.hx                |  5 +++++
 > >   6 files changed, 39 insertions(+), 3 deletions(-)
 > > 
 > 
 > One coding style issue below. With it fixed:
 > 
 > Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks for your catch! I would fix it in the next version.

Regards,
Li

