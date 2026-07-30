Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E08EC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpT7Z-0006Ab-Bv; Thu, 30 Jul 2026 11:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wpT7R-00067i-QN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:56:27 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wpT7P-0007ku-Dm
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IZ/y0VsJoIXL4hqrcP8IdlZNZl4ulU+I+jssnVjQ8qk=; b=H5+o0qK5Jg9yZzo
 R3rsPDJXlLECgt9gp7RhxJBJqsY6KoKF3RWYUvWHxGGMKWrCIKAZQx+Hs+ikW+qrBm972lU8PlhE3
 Iyp3FBSH5VrF033T6DZAhjaDf/QMN5cEnxZeBn++OPZO255FWh3NIAgVN9Md+b5jMnTOHGkmRYsQX
 co=;
Date: Thu, 30 Jul 2026 17:56:08 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 06/50] Add helper-to-tcg subproject
Message-ID: <20260730175608.2fb2dd44@spawn>
In-Reply-To: <20260730031025.12926-7-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-7-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:40 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> +project('helper-to-tcg', ['cpp'],
> +        version: '0.8',
> +        default_options: ['cpp_std=c++17'])
>
> ...
>
> +# Find LLVM using llvm-config manually.  Needed as meson struggles when multiple
> +# versions of LLVM are installed on the same system (always returns the most
> +# recent).
> +llvm_config = get_option('llvm_config_path')
> +cpp_args = run_command(llvm_config, '--cxxflags').stdout().strip().split()

`llvm-config --cxxflags` cotains `-std=`, which takes precedence over
`cpp_std=c++17`.
As a result, on LLVM 15, we get `-std=c++14` and the build fails.

I'd just add on the next line:

cpp_args += '-std=c++17'

And drop `default_options`.

-- 
Alessandro Di Federico
rev.ng Labs

