Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECDDC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylCI-0005LR-63; Tue, 25 Aug 2026 03:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1wylCE-0005LE-D7; Tue, 25 Aug 2026 03:03:46 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1wylCB-0005Av-9s; Tue, 25 Aug 2026 03:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=fcN7X+Xe6tIlsnfmZIBWKlkLfPrFqlGafM
 OLhd13yrA=; b=ehgROFMi1K6uVFETQh6V2uTjZ3t7Dt75ABPAyxuiTTGgAnNQHg
 /Uy+v9sHZ7Ppy6vwNiuIOvTAEtgp4qZOrQmGQOVaEWBpR7hPY5mgyHctWiXZ+Pc5
 QLSa1Gmr0QxDRh79IUj4evKFuyEEAr2DToHVyFC5nFKWrpumgAdkK0PFY=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwB3V847Po1qgC4BAA--.308S2; 
 Tue, 25 Aug 2026 15:03:34 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Xie Bo <xb@ultrarisc.com>
Subject: Re: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
Date: Tue, 25 Aug 2026 15:03:09 +0800
Message-ID: <20260825070309.1086125-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808125157.1220511-1-xb@ultrarisc.com>
References: <20260808125157.1220511-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3V847Po1qgC4BAA--.308S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1UXry5trWrCrWkXrWDArb_yoWxtrcEgr
 W29r1vkay5ZF10yF17WF4UCFy3K3ykJryYva17JrWDW348XrnxJan8AryrC3yfAFW8XrZ3
 X3ZFqa47Aw17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbIxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
 Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
 1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
 6r1DMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
 026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
 JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
 vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
 14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
 7VUjMqcUUUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAJB2qKZnsAAgALs7
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Now that this series is in master, could it also be considered for
stable-11.1?

Both commits are needed together:

7df9aa5 target/riscv/kvm: Synchronize privilege mode
ddac7cf target/riscv/kvm: Preserve MP state across migration

They fix RISC-V KVM live migration with multiple vCPUs. Without the
second fix, secondary vCPUs can remain stopped after migration; without
the first, the vCPU privilege mode may be restored incorrectly.

I tested the series on native riscv64 hardware with KVM enabled,
including multi-vCPU live migration, a 24-hour post-migration run, and
multiple repeated migrations across two guests. I did not observe guest
hangs or soft lockups.

Thanks,
Xie Bo


