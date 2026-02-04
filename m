Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106D1E9D416
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngHc-0004Mn-H2; Wed, 04 Feb 2026 12:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vngHV-0004FC-8a
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:03:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vngHT-0007UB-5u
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=buYvQIbu8MRIpy/CW1e4gzJIyVxmGbvPhxtQ9zvZBvc=; b=ahj6t8jsBfp0IP4
 kC8jSs7rBDaRYzu/9xC/dE8I5iuuJC35eDQI0GHYNa+Fvl5QDeyjuMF2MyFJJlGl/4Zhp4a7L2sLs
 MuRd3slgY8qPKAMfX5zT733QR73ND0WvUmy6++URdTUmLDtd3QN8MbY2cwwfVWrE8MuINEhztpOul
 hM=;
Date: Wed, 4 Feb 2026 18:06:25 +0100
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 richard.henderson@linaro.org
Subject: Re: [PATCH] target-info: set target_arch statically
Message-ID: <aYN8WyIQvISIJAUz@hive.localdomain>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/02/26, Pierrick Bouvier wrote:
> target_arch() function will reparse target_name() every time if it was
> not set to a proper SYS_EMU_TARGET_* value (when using
> target-info-stub.c), which is not efficient.
> 
> Since we want to preserve the constness of TargetInfo but C doesn't give
> us flexible compile time expressions, we simply set target_arch using a
> static constructor once instead.
> 
> This was found when doing changes to virtio_access_is_big_endian()
> function, having an overhead of 50% after switching to runtime checks.
> With this, overhead left is around 3%, due to indirect function
> calls.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target-info-stub.c | 11 ++++++++++-
>  target-info.c      |  9 +--------
>  2 files changed, 11 insertions(+), 9 deletions(-)

Good find!

Reviewed-by: Anton Johansson <anjo@rev.ng>

