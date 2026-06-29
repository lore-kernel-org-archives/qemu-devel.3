Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2843EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we80n-0006g2-2F; Mon, 29 Jun 2026 05:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1we80k-0006fR-JT; Mon, 29 Jun 2026 05:10:39 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1we80i-0005ag-LJ; Mon, 29 Jun 2026 05:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782724227; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=cWSTOqfNKFUiiCcPmBA38s9HF/7AxHSB7v6e87yRM0Q=;
 b=gxJhYQzySN93TMpejx7u5fb3bfdh+9WpaDYu2OfJt6dopB5SHwLinSWS47KCBuQloaFV85XzrIypyMEpJ1pNWVXlFBVw+e7WwGQoHbdopgqQkQs/VUEP6+Us3a/qmJpkKi3iI12nyB/oPbmaeKEhgBYrjBc2PnxOhGQ3p1YcY0Q=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0X5qxXep_1782724221; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X5qxXep_1782724221 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 29 Jun 2026 17:10:25 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, dave.jiang@intel.com, alison.schofield@intel.com,
 imammedo@redhat.com, mst@redhat.com, guoren@kernel.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,
 gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Mon, 29 Jun 2026 17:10:17 +0800
Message-ID: <20260629091019.71770-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <79017627-4888-415a-9686-16367490b5b5@oss.qualcomm.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-4-cp0613@linux.alibaba.com>
 <79017627-4888-415a-9686-16367490b5b5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Hi Daniel,

On 6/24/2026 2:21 PM, Daniel Henrique Barboza wrote:
> We can get rid of the braces - it's just adding an extra identation level while
> not doing anything special. 'mmio32_size' can be declared at the start
> of create_fdt_pcie().

Makes sense. I'll move mmio32_size to the top of create_fdt_pcie() and
remove the extra braces in v3.

Thanks,
Pei

