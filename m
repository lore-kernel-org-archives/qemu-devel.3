Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17531CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIax-00035q-WF; Wed, 10 Jun 2026 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIao-000346-Uc; Wed, 10 Jun 2026 09:03:39 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wXIam-0000b4-0d; Wed, 10 Jun 2026 09:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781096601; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=NZ4BHM1yjrt16IQRj2LtjsWfvfTTrCOqekiJi6pkNgg=;
 b=QeNdKtDS8wPYBqPs5kO2PXluy4zvYG1vo+yBZFHiC6a5IZr3n62jGxH3Iug5XMrQFSZZBNbs6kUY5EcjsUChuZZLdb2JWTfslsITYKVUupISV0CNIu0MyhBxJhIkIMFHsY4S/7uQsBv0i69dUmwoNhbS1iBPUoY/lkv9H0XUMnU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0X4ajruV_1781096595; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X4ajruV_1781096595 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 10 Jun 2026 21:03:19 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 cp0613@linux.alibaba.com, daniel.barboza@oss.qualcomm.com,
 guoren@kernel.org, linux-cxl@vger.kernel.org, liwei1518@gmail.com,
 palmer@dabbelt.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, sunilvl@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 4/4] hw/cxl: Map committed HDM decoder ranges as RAM for
 direct DMA
Date: Wed, 10 Jun 2026 21:03:15 +0800
Message-ID: <20260610130315.134515-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609133634.7dbb892c@jic23-huawei>
References: <20260609133634.7dbb892c@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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

On Tue, 9 Jun 2026 13:56:11 +0100, Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

> +CC linux-cxl as that's where you are more likely to get feedback on 
> CXL aspects.
> 
> For this one there is a more comprehensive solution that restricts this
> to the cases that are valid (no interleaving going on).
> https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/#t
> It is rather more complex as a result.
> 
> For other cases we have always intentionally left it as not supporting
> what you have here because we want the interleave to be correct and testable.
> 
> As far as I'm concerned that series of Alireza's has been ready to merge for
> a while. I've been a bit busy with other things so haven't been poking
> for that though.  Might be a week or two before I get back on top of things.
> 
> Anyhow, please give Ali's series a go and see if that works for you.
> There may well be other corners we haven't thought of!

Thanks for pointing out Alireza's series.

I'll test Alireza's series against the RISC-V virt machine with the
same CXL + daxctl + virtio DMA workflow. If it resolves the issue,
I'll drop this patch from v2 and just rebase patches 1-3.

I'll report back once I've tested.

Best,
Pei

