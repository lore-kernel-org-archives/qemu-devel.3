Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5A7C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjUD-0002ZO-Ry; Tue, 11 Aug 2026 06:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUC-0002ZD-PK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:32 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUB-00036a-8G
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=TY8d0avlrIbARxqQSMnHBQafpmmsg+G+pfXBy+1Hoio=; b=Z6TnK2CGgx9ffw1
 6iC/Er7wvHwznV0NoB5xToXWsjOyiwYU/7VQ9ZmQYiu0Q000RyyFiHX7xWaQksLngjvUYYNxXgi6I
 yMqfdv69wIWCLVNY0wBUTy28/pZMUlTvSQoYDEvxTQfNzNxOheFpSaVoAex4mWi79L7UTsI7XspRl
 CY=;
Date: Tue, 11 Aug 2026 12:12:28 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 08/50] helper-to-tcg: Handle LLVM version compatibility
Message-ID: <20260811121228.2d881dba@spawn>
In-Reply-To: <20260730031025.12926-9-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-9-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:09:42 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> +bool isFunctionQemuHelper(StringRef Name) {
> +#if LLVM_VERSION_MAJOR >= 18
> +    return Name.starts_with("helper_");
> +#else
> +    return Name.startswith("helper_");
> +#endif
> +}
> +
> +bool isFunctionQemuLoadStore(StringRef Name) {
> +#if LLVM_VERSION_MAJOR >= 18
> +    return Name.starts_with("cpu_ld") or Name.starts_with("cpu_st");
> +#else
> +    return Name.startswith("cpu_ld") or Name.startswith("cpu_st");
> +#endif

I'd just keep in compat a `startswith` function, not
isFunctionQemuHelper/isFunctionQemuLoadStore.

Let's strive for keeping this minimal.

-- 
Alessandro Di Federico
rev.ng Labs

