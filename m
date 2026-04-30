Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9262AFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINoF-0003qw-Hd; Thu, 30 Apr 2026 05:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wINoE-0003qc-5m
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:35:50 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wINoC-0001zH-OX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:35:49 -0400
Received: from linux.microsoft.com (unknown [167.220.197.153])
 by linux.microsoft.com (Postfix) with ESMTPSA id 28A7C20B7175;
 Thu, 30 Apr 2026 02:35:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28A7C20B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777541747;
 bh=8FmvGvRlVB053uSaYpTD0IUta4oOG8Q25biUjDnVDrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WTilNqgbuwkLyGh6t0tLP5dSGruoO9ktuEjZA0rjEynAoi3M6r+A9VIpahJBulHL5
 wU4wOg1ehA8IkqYzJ1oz3lx1ahgY5+L94B/qz/HyfkbmD1VedRV8MFWZxUORDdyyl1
 AqZDIuStAd1UqRURylJza2TypUlbADs7DdsyJMAU=
Date: Thu, 30 Apr 2026 12:35:43 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH v6 3/9] target/i386/mshv: fix various cpuid traversal bugs
Message-ID: <afMib8LRLTURZdiV@linux.microsoft.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416121116.527927-4-magnuskulke@linux.microsoft.com>
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

On Thu, Apr 16, 2026 at 02:11:10PM +0200, Magnus Kulke wrote:
> - Hardcoded max_leaf was not accurate. We query leaf 0x0 and 0x80000000 to
>   get the actual max leaves
> 
> - On all 0 zeroes on leaf 0x0d, we register 0-63 subleaves with zeros
>   indicating XSAVE is disabled
> 
> - Subleaf 0 was hardcoded, so the Hypervisor returned defaults for other
>   subleaves
> 
> - Subleaf 0 was hardcoded, so we were passing 0 instead of actual subleaf
>   when adding entries. We now pass the correct subleaf value to
>   add_cpuid_entry()
> 
> - Leaves 0x04,0x07,0d,0f,10 weren't marked as subleaf-specific
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  target/i386/mshv/mshv-cpu.c | 88 +++++++++++++++++++++++++------------
>  1 file changed, 61 insertions(+), 27 deletions(-)

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

