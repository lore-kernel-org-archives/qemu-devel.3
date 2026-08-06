Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24253C55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrnXh-0003F7-9O; Wed, 05 Aug 2026 22:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrnXc-0003El-VD
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 22:09:05 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrnXZ-00054p-Hn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 22:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785982115; h=From:Subject:Date:Message-ID:To:Content-Type:MIME-Version;
 bh=CDSiH+SHq1ucpOJVJWSNYgT1v7sLweKHCtMdFd6vRac=;
 b=pVP4y3un8yEAbiVSc4Oj7tkGfdECkN7E9QfZhWUpiabGBug/zklFH34fzey064atMvt1LZ2ohDfrc1x6NKUXbHSfCdWrMnsxNT7FjR1kzqOtEcYZvuB/GDCbAHEsCi8lakvDO+zm9dPEO2a50BO7QRqLMs1f4CEizo0GtX1C+4k=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X8SWMsr_1785982108; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8SWMsr_1785982108 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 06 Aug 2026 10:08:33 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] runstate: set crash_occurred on guest crashloaded
Date: Thu, 06 Aug 2026 10:08:18 +0800
Message-ID: <178598209815.64427.16767775604984968386@linux.alibaba.com>
In-Reply-To: <7569efba-b88e-4252-9f40-16246dd4362b@rsg.ci.i.u-tokyo.ac.jp>
References: <f76c7662-09d5-4f70-a72f-90dcbe9cfef9@oss.qualcomm.com>
 <178593181019.90910.8754057031123805737@linux.alibaba.com>
 <7569efba-b88e-4252-9f40-16246dd4362b@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, philmd@qualcomm.com, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
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

Hi Akihiko,

Thanks for the detailed analysis. I agree that explicitly passing
the CPU as a parameter would be cleaner than relying on current_cpu
implicitly. That sounds like a good standalone refactoring to pursue
separately.

For this series, I'll keep the current approach.

Regards,
Zhengrong Li

