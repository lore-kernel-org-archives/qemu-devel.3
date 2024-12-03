Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F664E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXuX-0000tZ-Am; Tue, 03 Dec 2024 13:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXuP-0000sw-Ma
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:46:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXuN-0008TH-N1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=D1M2LitLHQ1QQnmXOaPJF3c4lB+K0gkPJwBIkRgWw0g=; b=f+Id1O5JS5wxVi5
 b44q4npI9snSxx1zAOJmUNuf3bLbaR3/M+PDECjfC/aW+M1nNTkP43o7DVEZImAtzLScqD0ZGMG/V
 Hk3O+XEx05ZaqdBh9v1nOCldBe0XKPj82fjqSGWg2n+Q++1+J5Ja5uB/b0owFV+pusr4862n7OerW
 68=;
Date: Tue, 3 Dec 2024 19:49:05 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 09/43] helper-to-tcg: Introduce get-llvm-ir.py
Message-ID: <gteafxkqq6lk2nnqascf5jvtzsp5pnacdgn7243ua7jscjrvsz@7jevdtobocw3>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-10-anjo@rev.ng>
 <6b087061-fb11-4ac5-aecc-43f3324060df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b087061-fb11-4ac5-aecc-43f3324060df@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/11/24, Richard Henderson wrote:
> On 11/20/24 19:49, Anton Johansson wrote:
> > Introduces a new python helper script to convert a set of QEMU .c files to
> > LLVM IR .ll using clang.  Compile flags are found by looking at
> > compile_commands.json, and llvm-link is used to link together all LLVM
> > modules into a single module.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   subprojects/helper-to-tcg/get-llvm-ir.py | 143 +++++++++++++++++++++++
> >   1 file changed, 143 insertions(+)
> >   create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py
> 
> Is this not something that can be done in meson?

Possibly, I'll look into it, not sure it would be simpler though.

//Anton

