Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F83C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsM8k-0004XS-Af; Fri, 07 Aug 2026 11:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wsM8i-0004Wz-Lz
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:05:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wsM8h-0003Pt-Cn
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=B9EX2iAtcwzptlpQ/BgyhBRmcK00O3t0O3mcl19ENQs=; b=a0uA0j7K4zYSISo
 nRrZfOURNCP8Omi9TlORpAnUgt3FZq8IXwBBDvwZRYreGjJlupEiTIw1YuCKc5PS66GMkmZZCof7F
 xX4iXs29kmWi1P1Op6YXhqmpC83309vzQM90Js+XsM8KDwyie75iwiMrngORPY0mXErWzrVpkqVnC
 9Y=;
Date: Fri, 7 Aug 2026 12:27:20 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 30/50] helper-to-tcg: Introduce TcgGenPass
Message-ID: <20260807122720.7bda66c3@spawn>
In-Reply-To: <20260730031025.12926-31-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-31-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
 helo=rev.ng
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:10:04 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> +    std::error_code EC;
> +    ToolOutputFile OutSource(OutputSourceFile, EC, compat::OpenFlags);
> +    ToolOutputFile OutHeader(OutputHeaderFile, EC, compat::OpenFlags);
> +    ToolOutputFile OutHelpers(OutputHelpersFile, EC, compat::OpenFlags);
> +    ToolOutputFile OutEnabled(OutputEnabledFile, EC, compat::OpenFlags);
> +    assert(!EC);
> +
> +    MPM.addPass(TcgGenPass(OutSource.os(), OutHeader.os(), OutHelpers.os(),
> +                           OutEnabled.os(), OutputHeaderFile, Annotations,
> +                           DebugInfo, TcgGlobals, VL));

I'd move all the `cl::opt` from this file to `TcgGenPass`.
Ideally, passes should not have constructor arguments and should be
runnable from `opt`.

Make an effort to have all the passes be default constructible.

> +    MPM.run(*M.get(), MAM);
> +
> +    OutSource.keep();
> +    OutHeader.keep();
> +    OutHelpers.keep();
> +    OutEnabled.keep();
> +
>      return 0;
>  }

-- 
Alessandro Di Federico
rev.ng Labs

