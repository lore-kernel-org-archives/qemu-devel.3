Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E830E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsazk-0003i6-Ht; Wed, 18 Feb 2026 01:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vsazh-0003fm-2B
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:25:05 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vsazd-0001lF-6E
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:25:02 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 120AE4371E;
 Wed, 18 Feb 2026 06:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA196C19421;
 Wed, 18 Feb 2026 06:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771395896;
 bh=VkQMl83RBTsbh+uzJWKiwuKyEkyRcN7SE4sn5LKekL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y85KZRgrvE/1bP4bJN6sX5Q968zlEMbY3b7CsrgbD3HoY18DN68SG5TnpP7fXTEOI
 GduNOtLPBJfYt9Zvebi7RQW8HUWTxQkXxREL5FA6eV+p2CwXat2RKIki0lDMmufZg9
 0oHw6Lgxb8IFTLI1wS8L25OiC64HXAHou4XpoUe4w+OKkCoFbg6k/jsl+DRixp5+Gp
 GnSib8UkqNJEkiiy4FhCa7ifsRCKmMoFG+gtr+eG4/D9Qbt/vBN8jvXEL59PaH+aHE
 1TiBy0kpYFwt6HZxJNVlSsSgqFPyB0u5bsxPio7R/5kNIb8fJ9/qNVgDWPZTXdOkqZ
 6CqEuD5yotDvg==
Date: Wed, 18 Feb 2026 06:24:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 04/10] target/i386/mshv: fix cpuid propagation bug
Message-ID: <20260218062455.GB2236050@liuwe-devbox-debian-v2.local>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-5-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211155410.203883-5-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

On Wed, Feb 11, 2026 at 04:54:04PM +0100, Magnus Kulke wrote:
> The list argument was missing a pointer and hence e.g. -cpu qemu64 and
> -cpu EPYC would produce the same of cpuid leaves.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>

