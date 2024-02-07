Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A76EC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXjf9-0001lq-PC; Wed, 07 Feb 2024 10:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rXjf6-0001lY-50
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 10:16:34 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rXjf3-0007GE-Tl
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 10:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DrPdQFVNRumFaeoE9EWXN/sUXGXjnN3p8txNIw82V7c=; b=Zl1Vqk4HZNrfhui9vVgsMNgvpW
 rzWnhTmphf+GbmToEaM6/EUbOLWTkH0lcyAOw0wvWueF4dIQVwoy4YalR07P5n5740rnZOrCyQsvd
 7EKMivOxA2/k7DPRSia7i284iehdx3k9sLAR5u+nMyAz7Jl55PU5bKOP40c+APcFvIZ8=;
Date: Wed, 7 Feb 2024 16:16:31 +0100
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, bcain@quicinc.com, quic_mathbern@quicinc.com, 
 sidneym@quicinc.com, quic_mliebel@quicinc.com, richard.henderson@linaro.org, 
 philmd@linaro.org, ale@rev.ng
Subject: Re: [PATCH v2 0/3] Hexagon (target/hexagon) Only pass env to
 generated helper when needed
Message-ID: <tivf6r3zffa5dptdrf2y5g6rrgyjce7x6c7elzg7umbfn7jos4@evxzl6saqxrp>
References: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 06/02/24, Taylor Simpson wrote:
> Currently, we pass env to every generated helper.  When the semantics of
> the instruction only depend on the arguments, this is unnecessary and
> adds extra overhead to the helper call.
> 
> **** Changes in v2 ****
> - Separate patches to pass P0 and SP explicitly to helpers that need it
> - Add the TCG_CALL_NO_RWG_SE flag to any non-HVX helpers that
>   don't get ptr to env
> 
> Taylor Simpson (3):
>   Hexagon (target/hexagon) Pass P0 explicitly to helpers that need it
>   Hexagon (target/hexagon) Pass SP explicitly to helpers that need it
>   Hexagon (target/hexagon) Only pass env to generated helper when needed
> 
>  target/hexagon/gen_tcg.h            |  3 ++
>  target/hexagon/macros.h             |  4 +--
>  target/hexagon/attribs_def.h.inc    |  1 +
>  target/hexagon/gen_helper_protos.py | 10 ++++++-
>  target/hexagon/hex_common.py        | 44 +++++++++++++++++++++++++----
>  5 files changed, 54 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
> 

Series:
Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>

-- 
Anton Johansson
rev.ng Labs Srl.

