Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B757C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjL5-0000ej-3L; Tue, 11 Aug 2026 06:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wtjL3-0000eb-UE
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:04:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wtjL2-0001gZ-79
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=PgHrLIt0kv9bf0A35WWTaZe8O888nHEwsimKmGGPzz0=; b=gHqEHlFDppeLBLK
 wrL1Krt4t0sqHjMsXCvnrCoScq99SbgX8e4rzOSL/wK2LfYdMWzzWe7dTNN/wVjW6Ej9xtDXd+HaN
 ui0a6LeGY24qv2q+lyi9GY5Jq0yfDv89ujKzvXSxze95bJQAA8YtDCHv5qecVOqdkrXHyI+KctvDj
 NQ=;
Date: Tue, 11 Aug 2026 12:09:17 +0200
To: Alessandro Di Federico <ale@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 13/50] helper-to-tcg: PrepareForOptPass, demangle
 function names
Message-ID: <anrxuDKlPOrWoH0k@hive.localdomain>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-14-anjo@rev.ng>
 <20260807180326.6e915537@spawn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807180326.6e915537@spawn>
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

On 07/08/26, Alessandro Di Federico wrote:
> On Thu, 30 Jul 2026 05:09:47 +0200
> Anton Johansson <anjo@rev.ng> wrote:
> 
> > +        Index = DemangledName.find_last_of(':');
> > +        if (Index != std::string::npos) {
> > +            FunctionName = DemangledName.substr(Index + 1);
> > +        }
> > +        // Remove arguments
> > +        Index = FunctionName.find_first_of('(');
> > +        if (Index != std::string::npos) {
> > +            FunctionName = FunctionName.substr(0, Index);
> > +        }
> 
> LLVM provides a dedicated function to parse mangled
> names: getFunctionBaseName. It's in LLVM, so new dependencies (I thought
> was in clang).

Right, as a part of ItaniumPartialDemangler, I'll use that then.

> 
> The current code wouldn't handle `ns::function(ns::type)`.

Fair point

> 
> Also, more in general: why are we setting the function name to the
> name of the original C++ function name?
> It's a feature worth documenting in the README along with its ratio.

It's a bit hacky, but I really didn't want to pass around yet another
Function * -> StringRef map.

> 
> Reviewed-by: Alessandro Di Federico <ale@rev.ng>

Thanks

-- 
Anton Johansson
rev.ng Labs Srl.

