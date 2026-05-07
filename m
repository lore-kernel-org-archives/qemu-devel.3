Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54521CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyha-0000df-OS; Thu, 07 May 2026 09:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyhY-0000dD-Ei
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:23:40 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyhW-0006iG-IT
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1778160204; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Y8J8UEmDLcf63MHnA74uboptyzb9a6XcdqkqHqeZl+DoDO29st7G2KOEtc/pjPtKFRppNJeZC66iZZj3KkDoOPkxGpf/EUB7LTthvB/wLS8Ya4sjcoh7PJ4hFdyKCTQURiCF+xkv9z8/SXa/f05bEHEMeJ4mJ6QjT/Ah+6PyAcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778160204;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iHRWS/Ao6202LXF03ojvKtDm2lCGhZR0sfmcUzliCsg=; 
 b=Q6KVjvyBq68oc0KRaJ1XyrsDwx7qA6GdE87kmttuPXTfhUwc7kkwqQOJUIAkZGkQAr/+x4Gwzzu48GWdzDNNCon1JYmwJ8gYf+BUhrLrukkXXYUx9ZO3Jmgft+1mKb+xRkiDTlaLlyYR0jNZOeQ6uMHiULT4Kv15TKZedEbo2HU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778160204; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=iHRWS/Ao6202LXF03ojvKtDm2lCGhZR0sfmcUzliCsg=;
 b=d54dOHPz83JLErof7l8+6B7QLbtnk9KAgcnWRfdFQqM3I2eywCLwyMAOEhMf+wZt
 ar/y+H9MnqvcKxcvZyYPcMdRvsO/F2Rps1k5D/t4ldMyLAev/qBXLcA+Rf5OE6uauuB
 e0bxgAswyWe9en4CD/yllvEBXgrAaeLha7h1m3lI=
Received: by mx.zohomail.com with SMTPS id 177816020308224.93012071349574;
 Thu, 7 May 2026 06:23:23 -0700 (PDT)
Date: Thu, 7 May 2026 13:23:17 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/7] target/i386/mshv: use the register page to get
 registers
Message-ID: <20260507-unstoppable-berserk-trogon-9fcd3f@anirudhrb>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
 <20260505185028.237207-6-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-6-dblanzeanu@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, May 05, 2026 at 09:50:26PM +0300, Doru Blânzeanu wrote:
> Change the mshv_load_regs to use the register page when it is mmapped
> and is valid.
> Otherwise use the existing logic that uses ioctls to fetch registers.
> 
> When retrieving the special registers, there are some registers that are
> not present in the register page: TR, LDTR, GDTR, IDTR, CR2, APIC_BASE.
> As this registers are not likely to be used in an MMIO/PIO operation,
> and to avoid a hypercall overhead we do not retrieve them.
> 
> Local testing showed no regression when using this logic. To properly
> retrieve all the necessary registers for each decoded operation implies
> having a mechanism that tracks the state of each register, which is
> beyond the scope of this patch series.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 99 +++++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 9 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


