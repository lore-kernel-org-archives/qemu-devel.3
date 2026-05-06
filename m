Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188FCCD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 11:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKaCq-0004tH-8O; Wed, 06 May 2026 07:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wKaCo-0004t5-K8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 07:14:18 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wKaCn-0002o7-Bd
 for qemu-devel@nongnu.org; Wed, 06 May 2026 07:14:18 -0400
Received: from linux.microsoft.com (unknown [86.121.140.248])
 by linux.microsoft.com (Postfix) with ESMTPSA id D55B520B7165;
 Wed,  6 May 2026 04:14:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D55B520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778066052;
 bh=6Z0EXEZo1hCOV200BlMH2NI6lzlmfF+iWAYrfIJdf5Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nQC0Axu0DLoF8DmnKxUhuva/ZmCkp9/kHMMYsqZiheE5PYj6xUds7kCQtQAfgMJuJ
 1JGyaww42fQHuO3kwg+nDff9rrGXUVDrxYjVqgkt41FYuLQTp8HilyxBLpEG0c83/H
 S7K5Px3dlyF3ufX13c8ihaZq01gnfPQhTpKtg3Do=
Date: Wed, 6 May 2026 14:14:07 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>
Subject: Re: [PATCH v6 8/9] target/i386/mshv: use hv-provided [0xD,1+2].EBX
Message-ID: <afsif7mIeVDFqhVv@linux.microsoft.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-9-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416121116.527927-9-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Thu, Apr 16, 2026 at 02:11:15PM +0200, Magnus Kulke wrote:
> We cannot statically set the responses for CPUID[0xD,{1,2}].EBX, b/c
> those are dynamic, dependent on which features the guest enables.
> 
> Hence we mask EBX when registering answers for those subleaves at the
> hypervisor, which will result in the hypervisor providing us answers,
> considering XCR0 and XSS.
> 
> The reported size now reflects the field masks properly (without the
> mask they were 576 and 10728, which is wrong):
> 
> $ cpuid -l 0xd -s 0
> CPU 0:
>    XSAVE features (0xd/0):
>       XCR0 valid bit field mask               = 0x00000000000600e7
>       ...
>       bytes required by fields in XCR0        = 0x00002b00 (11008)
>       bytes required by XSAVE/XRSTOR area     = 0x00002b00 (11008)
> 
> $ cpuid -l 0xd -s 1
> CPU 0:
>    XSAVE features (0xd/1):
>       ...
>       SAVE area size in bytes                     = 0x000029c0 (10688)
>       IA32_XSS lower 32 bits valid bit field mask = 0x00001800
>       IA32_XSS upper 32 bits valid bit field mask = 0x00000000
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

