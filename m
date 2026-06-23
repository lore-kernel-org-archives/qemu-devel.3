Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CF0CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc50z-0004BG-5w; Tue, 23 Jun 2026 13:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wc50x-0004B7-2g
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:34:23 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wc50u-000899-9l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1782236046;
 bh=TV7cCDfLsFxNTpH5fit1Hz+76NNwwSJR9b/B/CBSjnQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RUhRqou5SlsDiqadpP/yeffHZvroAlUvlTxJE+UuivhEfkLmsa1HrWTrzIdmSH34n
 Y+5gKsUpS5Q/Y2DgxyINPdeRXFh/ThmajARNaZY5deuOvlZEkD75RR/Wo3nHh5pEPl
 zjIL87Abtt4wSwImp8SCIZpnzn1WQVwx04Q6bXscjLfo+4eS+zUhqjVRSCVLhD9Z3L
 m1rSUw5BuDUpFyQ1JrgCnyZSRFTy8EsuVejqaNcW4+CD4vlxDLFTAXYHf4d03wM7nd
 QvT2YhSl7dv/L73uaXVrUA//nphnMSOewaVYQKqOzyBi3nIQCI8Q+snvD+hNeAqOnW
 9gvpGnlTWu1VQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 43B752FF55B;
 Tue, 23 Jun 2026 17:34:06 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 1D85937C8C7;
 Wed, 24 Jun 2026 01:34:05 +0800 (CST)
Message-ID: <9039fb2c-e6db-4130-ba64-b54bd4e487ec@sjtu.edu.cn>
Date: Wed, 24 Jun 2026 01:34:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <70f7c4f9-ab2d-4a5a-b440-0599b4c16242@oss.qualcomm.com>
 <06e6901f-0f45-4f01-bd06-eb1928548367@sjtu.edu.cn>
 <9cbeb740-405d-4738-90cc-fce7eca7d9ec@oss.qualcomm.com>
 <fb504309-4e3e-48e6-9e33-108edbcbb173@sjtu.edu.cn>
 <831eeb2e-cd0e-4b47-b573-f5f9bf31ee4d@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <831eeb2e-cd0e-4b47-b573-f5f9bf31ee4d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 23 Jun 2026 10:16:18 -0700, Pierrick Bouvier wrote:
> Sure, as soon as we have this publicly available, I would be happy to
> see this plugin merged also. Corner cases can be be solved later, it
> doesn't have to support 100% of the libraries that exist in real world.
Thank you! Lorelei currently only needs to add some documentation and
integrate the host runtime with the current plugin. This won't take up
too much time. Of course, we will also provide CI for x86_64, arm64 and
riscv64 for everyone to review.

Regards,
Ziyang Zhang

