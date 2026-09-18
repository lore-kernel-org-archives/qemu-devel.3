Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD0BC982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WCN-0002au-LS; Fri, 18 Sep 2026 06:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x7WCM-0002ah-A3; Fri, 18 Sep 2026 06:52:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x7WCJ-0003ud-Pc; Fri, 18 Sep 2026 06:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789728664; bh=YfflH7td60Sj7UK5eYmJMUJLjjhqEP6LG5WD81Mf00I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=k74PCKX63Xc65MM1j4Qub7SYzybQ1o16AdLpWjDCBTRg9lSOz9vpUdRJj1t6lCcK2
 ObB61DBCR7NJMq3SiXaEbqF85qNU56DWP6ft+3LVaKCDuVg+qLL0j4eW8Abc1YBJl5
 pz8uSLRXUeaAW6JuXOOony1Ix4F6Hm86mdqgyh/DLqGHXRKADZowEhKHK+tPpJc2Cc
 uz+lyFqjHX2s6+yqFffdr1SSdHWmJ4SCPVXxcJVMyOBP7FWV1YqMw4htde3bq0myoj
 Zh2IcT8ZLU20u4ydek+QSj6DiFs3VLhNpkWwa6XoHwx3Scq45IsnR7H7+KLokFEH5M
 FuNbc02mdgkXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C87D1D6419;
 Fri, 18 Sep 2026 13:51:04 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3D3F642B902;
 Fri, 18 Sep 2026 13:51:51 +0300 (MSK)
Message-ID: <7f5d6e7a-882f-4784-9944-6449eba14e0c@tls.msk.ru>
Date: Fri, 18 Sep 2026 13:51:51 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v5 1/2] igvm: validate and honor byte_offset in parameter
 directives
To: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-stable@nongnu.org
References: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
 <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 9/16/26 18:10, Luigi Leonardi wrote:
> Parameter directive handlers either ignore param->byte_offset,
> overwriting each other when several parameters share one area, or use
> it without validating it, letting a malformed IGVM file corrupt QEMU's
> memory.
> 
> Add qigvm_get_param_data(), which validates byte_offset against the
> parameter area size and returns the offset-adjusted pointer together
> with the space left after it. Convert all parameter directive handlers
> to use it and to check their writes against that remaining space, so
> that no parameter can be written past the end of its area.
> 
> Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
> Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
> Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>   backends/igvm.c                | 89 +++++++++++++++++++++++++++++++-----------
>   include/system/igvm-internal.h |  5 +++
>   target/i386/igvm.c             | 12 +++---
>   3 files changed, 77 insertions(+), 29 deletions(-)

Hi!

This patch (set) has been Cc'ed to qemu-stable.  I'm assuming it is valid
for 11.0.x and 11.1.x series (since all commits mentioned in Fixes: tag
are past v10.0.0).  For 11.0.x, there's one tiny issue: this branch does
not have commit v11.0.0-2280-g4d3b9dc4d1f "igvm: Report error on missing
parameter area in directive handlers".  Is there a prob for 11.0.x if I'll
pick that commit too, in addition to this one?  It looks ok to me :)

Thanks,

/mjt

