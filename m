Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CE2E74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXvd-0001iI-8S; Tue, 03 Dec 2024 13:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXvb-0001hk-CN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:47:19 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXvZ-00006m-Vk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=keCj+pI9sEPA/mbo64Y4U0SaqQ/Buxo9VXYUOLPDB1k=; b=HIaBMqPj9EXh0Pr
 YZ9t2wUUOHHzMgm4gXx+sKzJrASfkiyYhN7AuEvxosvtDdd4ye52ucLZxdjP5ZUNsSH//aevgC3WS
 g2sGhCG9UZxroVL+Ey3y9XdTJNq3BrBSS11L5Bi/5L6X6cNXA1Aj2etjlyFMw0bzlU7ABcK1TSIUG
 x8=;
Date: Tue, 3 Dec 2024 19:50:20 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 28/43] helper-to-tcg: Introduce TcgType.h
Message-ID: <w2jmg53tnm3xuloqeegutumt5yf6rl3q5dnfaucd5rjcfi25uj@kyz7y5wk2cdq>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-29-anjo@rev.ng>
 <974f626c-4f51-481e-8e7c-93e8624b1424@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <974f626c-4f51-481e-8e7c-93e8624b1424@linaro.org>
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
> On 11/20/24 19:49, Anton Johansson via wrote:
> > Adds a struct representing everything a LLVM value might map to in TCG,
> > this includes:
> > 
> >    * TCGv (IrValue);
> >    * TCGv_ptr (IrPtr);
> >    * TCGv_env (IrEnv);
> >    * TCGLabel (IrLabel);
> >    * tcg_constant_*() (IrConst);
> >    * 123123ull (IrImmediate);
> >    * intptr_t gvec_vector (IrPtrToOffset).
> 
> Why would you map TCGv (the TARGET_LONG_BITS alias) rather than the base
> TCGv_i32 and TCGv_i64 types?  This seems like it would be more natural
> within LLVM, and take advantage of whatever optimization that you're
> allowing LLVM to do.

No you are correct, we map

  IrValue + 32-bit size -> TCGv_i32
  IrValue + 64-bit size -> TCGv_i64

I was a bit vague in the commit message.

//Anton

