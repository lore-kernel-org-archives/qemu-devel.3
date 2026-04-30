Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76330CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLK-0007yu-Ea; Thu, 30 Apr 2026 05:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wINLH-0007xv-Bq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:55 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wINLF-00038D-Ut
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:54 -0400
Received: from linux.microsoft.com (unknown [167.220.197.153])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9290820B7178;
 Thu, 30 Apr 2026 02:05:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9290820B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777539952;
 bh=6YnEmT5Q32AqZNTMmVtBSHQI3md/xowGuuCvSZqpEsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vbj5N6SaTPrZojFhR7MXIg9zUWDhqqEKUKjEBXYCrWZ1+ylqri8Ri4os2cqly2NcD
 sKK80vHTwFgDVxi/iher68ttZRJOu1shYAR4r/p77amHPCGPlqxBKeB3QJ7NBUzY2L
 fktndoL3PSpIHCYfyS53lkT6P6WdX/WnIrInYLPw=
Date: Thu, 30 Apr 2026 12:05:49 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH v6 2/9] target/i386/mshv: fix cpuid propagation bug
Message-ID: <afMbbWu0pJJq4xBc@linux.microsoft.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-3-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416121116.527927-3-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 16, 2026 at 02:11:09PM +0200, Magnus Kulke wrote:
> The list argument was missing a pointer and hence e.g. -cpu qemu64 and
> -cpu EPYC would produce the same of cpuid leaves.
> 
> Fixes: 4fa04dd1621 ("target/i386: Register CPUID entries with MSHV")
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

