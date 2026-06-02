Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BA3CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUK8C-00039r-JW; Tue, 02 Jun 2026 04:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wUK81-00038D-OR; Tue, 02 Jun 2026 04:05:38 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wUK7r-0001j2-FA; Tue, 02 Jun 2026 04:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780387503; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=kaHY0D+Wdx9V3hsWgTf97DSopoPVhxFDi9fEzQW9uC8=;
 b=cUbOVPEUU1TRl7oXYbpWFOF4wS6FuLRFS/b5odWj1XuFf/fLOjartAqZkgHEBluzsRhp7EvE1ob+EZxCSKaJQiqY3g/WGpgheKLFLOyI8++KxQ/6culAmzNUlWaS122CmAPk2vIlMJPqfTY9FJvGO3v7a0HkD+mxiGMtBmydVK0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0X43oDGJ_1780387498; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X43oDGJ_1780387498 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 16:05:02 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: cp0613@linux.alibaba.com
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 daniel.barboza@oss.qualcomm.com, guoren@kernel.org, jic23@kernel.org,
 liwei1518@gmail.com, palmer@dabbelt.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 4/4] hw/cxl: Map committed HDM decoder ranges as RAM for
 direct DMA
Date: Tue,  2 Jun 2026 16:04:58 +0800
Message-ID: <20260602080458.71561-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602074127.63819-5-cp0613@linux.alibaba.com>
References: <20260602074127.63819-5-cp0613@linux.alibaba.com>
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

On 2 Jun 2026 15:41:27 +0800, cp0613@linux.alibaba.com wrote:

CC Jonathan.

