Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827EC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XRd-0008Ho-Gz; Tue, 15 Sep 2026 13:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1x6XRZ-0008Gp-TW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:59:46 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1x6XRY-0004xD-5u
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:59:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42793411FF;
 Tue, 15 Sep 2026 17:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7997D1F000FF;
 Tue, 15 Sep 2026 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789495183;
 bh=8zoKsP470aqDDwqwXvLW07dQb2yiVtQ3w8IhifEP4qk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ONj4lyHt16Tv81SJ0Ei2DsAzYXXEnQiQyJMYcnczfxa8IdwFuEr67JiDIH96srPR5
 Se/JwIqtsAoRUu5j/81oPZlc8iFLy3gmxALzle682xMUi2fwgoZHxYy2rWVJ/cryhk
 M5a51rxeMlD+7jsocUlmp7wfqYLLwlVJCxFmqb6PGBnH2+HTMl628rnpY4nZkzW9WR
 d/COA4pbIcWwm6JaX83L0JJQ+6KZukkCl8pNtyRPfJhzTOtJJtIhmIMgN7poK3ijRU
 JXxDoj7kuRwZSqKntJAvWmwzcQ9/tHAxwBpIZsT+mvWWILUPMzzUpW0A9O+1cLel3f
 QkcbCP6AhnVJA==
Date: Tue, 15 Sep 2026 18:59:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, philmd@oss.qualcomm.com, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 46/47] hw/pci-bridge: filter from CONFIG_CXL
Message-ID: <20260915185938.0772edfe@jic23-hlaptop>
In-Reply-To: <20260828225901.367438-47-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 28 Aug 2026 22:59:00 +0000
Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Fine by me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


