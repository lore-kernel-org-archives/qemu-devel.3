Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B2CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIKn-0006QD-5n; Wed, 10 Jun 2026 08:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIKh-0006Pz-L0; Wed, 10 Jun 2026 08:46:59 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIKb-0001LL-35; Wed, 10 Jun 2026 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781095583; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Ngv3xXarhR2caHB2jbwy1oqPuF9c2mWLpXtG40CGJo0=;
 b=jHaguGJqHvWy/Mh+RUEMEXU68yfHDldctRX6TX9g2bXa8GZ9FLeTAUifp0Dk40X0pco+b0OlyHLjl3HrK5LTRc9Kl6CArmdgmGWrmJJU25vVdNgdppWmzxUV9tasT+kJaj5eXhrYU5/L2mjRAEk/wT2J8lkW4iPEzjRgvtz/Soc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0X4ajnDB_1781095577; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X4ajnDB_1781095577 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 10 Jun 2026 20:46:21 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 cp0613@linux.alibaba.com, daniel.barboza@oss.qualcomm.com,
 fan.ni@samsung.com, guoren@kernel.org, jonathan.cameron@huawei.com,
 liwei1518@gmail.com, palmer@dabbelt.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Date: Wed, 10 Jun 2026 20:46:18 +0800
Message-ID: <20260610124618.131421-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609134101.1dd53f93@jic23-huawei>
References: <20260609134101.1dd53f93@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On Tue, 9 Jun 2026 13:41:01 +0100, Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

Thanks for the review.

> > @@ -1426,6 +1446,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
> >                                       machine_done);
> >      MachineState *machine = MACHINE(s);
> >      hwaddr start_addr = s->memmap[VIRT_DRAM].base;
> > +
> > +    if (s->bus) {
> 
> There is a guard against !s->bus inside the function so you should be
> able to do this unconditionally.

You're right. Will drop the outer if (s->bus) guard in v2.

> > @@ -64,6 +65,8 @@ struct RISCVVirtState {
> >      struct GPEXHost *gpex_host;
> >      OnOffAuto iommu_sys;
> >      uint16_t pci_iommu_bdf;
> > +    CXLState cxl_devices_state;
> > +    PCIBus *bus;
> 
> That's a very vague bit of naming.  I'd make it explicit what PCIBus this is.

Agreed. Will rename it to `pci_bus` in v2 to make it clear this is
the root bus of the PCIe host bridge (PCI0).

Best,
Pei

