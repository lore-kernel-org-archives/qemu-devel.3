Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3736CC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHO4c-0000uI-ND; Wed, 12 Jun 2024 09:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sHO4a-0000u9-Vk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:31:33 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sHO4Z-0006Gi-HB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=bSJCF7lDziu3tqkQ5Y4fXFfZOso19tiJJxVxK3mMAfQ=; b=gG12tEqV5jcJrMo
 6qR2qzoNDJXuh4zeC/W88likTuko34tqn1qqp0b+TJuDf0OUzzwUR66O51ZEnpKIZQrvxAT/bOSuG
 RFhLUYCcma5+B238QIJ47EFgdjxAhndwBjj77OPrnsESxhMPu2hpqqTbndU3fTuTosGXj6lI377Cv
 Nc=;
Date: Wed, 12 Jun 2024 15:32:53 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 manos.pitsidianakis@linaro.org
Subject: Re: [PATCH v2] accel/tcg: Fix typo causing tb->page_addr[1] to not
 be recorded
Message-ID: <3c7calbvwqge5nfrm5tmicx5athgkbbqdr5swap6jyw5a5uwja@2cf7tyykr7l5>
References: <20240612131509.14132-1-anjo@rev.ng>
 <8a3a4707-07ba-4d64-939c-63ccb922aed8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a3a4707-07ba-4d64-939c-63ccb922aed8@linaro.org>
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

On 12/06/24, Philippe Mathieu-Daudé wrote:
> On 12/6/24 15:15, Anton Johansson wrote:
> > For TBs crossing page boundaries, the 2nd page will never be
> > recorded/removed, as the index of the 2nd page is computed from the
> > address of the 1st page. This is due to a typo, fix it.
> 
> Please keep these tags as they are useful when backporting
> (maintainer taking your patch could amend them):
> 
> Cc: qemu-stable@nongnu.org
> Fixes: deba78709a ("accel/tcg: Always lock pages before translation")
My bad, added!

