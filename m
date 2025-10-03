Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E81CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 12:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4fFQ-0006F4-7s; Fri, 03 Oct 2025 08:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4fFJ-0006Be-KJ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:50:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4fF8-0000A7-6n
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=uBE9rJ2h99TnFCpjP6oulZ6pWiFmTnQZM0yvxM2NaPw=; b=KPKLOLbrIBN/1FC
 y2ML4LEDVKx5aUEKpfiwfm7SZV9NkO0BYlS44vgQIAP1OKKmTsS3v6FBObi5sm3/h4bUGfQvx1zLt
 SGt5SzfjZdy1MdKQEH96+PzK4HQNwyNKW5vpH1B61SkWrhsTzCdz1O9MhpdxZ8v45QB35hH71avoW
 oU=;
Date: Fri, 3 Oct 2025 14:52:57 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 30/33] target/riscv: Move debug.h include away from
 cpu.h
Message-ID: <f5rjtehuhnmvwvb7aunsujblqcoqchqftaj5tajvnzansxhtqg@xl7uur7n7ppx>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-31-anjo@rev.ng>
 <f29cebf7-42f1-419d-9bbe-46ad91adb57d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f29cebf7-42f1-419d-9bbe-46ad91adb57d@linaro.org>
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

On 02/10/25, Pierrick Bouvier wrote:
> On 10/1/25 12:33 AM, Anton Johansson wrote:
> > All debug.h definitions except for RV_MAX_TRIGGERS are internal to
> > target/riscv.  Move RV_MAX_TRIGGERS to cpu.h and include debug.h from
> > all translation units which relied on the cpu.h include.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/cpu.h         | 4 ++--
> >   target/riscv/debug.h       | 2 --
> >   target/riscv/cpu.c         | 3 +++
> >   target/riscv/csr.c         | 3 +++
> >   target/riscv/debug.c       | 1 +
> >   target/riscv/tcg/tcg-cpu.c | 1 +
> >   6 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index a53981a09b..70e0f3718c 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -177,14 +177,14 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
> >   #define MAX_RISCV_PMPS (64)
> >   #define OLD_MAX_RISCV_PMPS (16)
> > -#if !defined(CONFIG_USER_ONLY)
> > +#if !defined(CONFIG_LINUX_USER)
> 
> Squashed from another change?
> 
> ...
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Yup, nice catch!

