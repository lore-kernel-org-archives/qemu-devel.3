Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13979C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwN1-0002Gx-IC; Thu, 20 Aug 2026 02:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wwwMy-0002BU-F7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:35:20 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wwwMw-000635-Ou
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XyxHZ6NWtBCwNaVqZFWwiSkd5X+gWEtCqz7XZdMDP/M=; b=jTN/2BhtmbzSm+l
 XKSRq0fXD6pnPDrXQci0Xk3q0S8477UmZn0Gc5kUWBHlfXM3Turs4KAdN1HI+2doREn5If7vWImAn
 /qCXh/pF8AqtIqJqG1bG6dJZi7Aa66CmawaO8WdxyL4rMOYhHrz33ml4KP9osCNlTG2/z/9XoLB6y
 2Y=;
Date: Thu, 20 Aug 2026 08:40:29 +0200
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] target/hexagon: fix HVX big-endian byte access
Message-ID: <aoaf2S3tEZog_cja@hive.localdomain>
References: <20260819230939.466856-1-brian.cain@oss.qualcomm.com>
 <20260819230939.466856-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819230939.466856-2-brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/08/26, Brian Cain wrote:
> Keep HVX lanes host-native while converting byte indexes at memory
> and helper boundaries.
> 
> Also place vector comparison predicate bytes according to host word order.
> 
> Suggested-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h           | 22 ++++++++++++++--------
>  target/hexagon/mmvec/mmvec.h            | 18 ++++++++++++++++++
>  target/hexagon/cpu.c                    | 17 ++++++++++-------
>  target/hexagon/genptr.c                 |  3 ++-
>  target/hexagon/mmvec/system_ext_mmvec.c |  2 +-
>  target/hexagon/op_helper.c              | 17 ++++++++++++-----
>  6 files changed, 57 insertions(+), 22 deletions(-)

Wouldn't have thought of using extract, nice!

Reviewed-by: Anton Johansson <anjo@rev.ng>

