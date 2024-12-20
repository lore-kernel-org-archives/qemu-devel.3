Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184D7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 22:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOlOe-0002GT-Kx; Fri, 20 Dec 2024 17:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tOlOd-0002Fz-GA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 17:22:59 -0500
Received: from out-180.mta1.migadu.com ([95.215.58.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tOlOa-0005mG-2p
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 17:22:59 -0500
Message-ID: <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1734733372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndJO+bNZHjbgHgEUvyvhUDkgIbeoQzcfycLjMkmor+w=;
 b=ey5DnE3erg9pcgkeSv4dymR2UKQQdw2cs9BAyHglYaxM7SidZ+Q0TPbYYNVkts/IauR9G8
 FUKy67lCUf4EQzvz3Ug7bAYWYa3Xw5LrNlaEEtF/aXBkzprS8Un6wcy0U51Ew7wJf92sWD
 7usUvH+ZuwIwwZKqXwrfy3IsDFLkd3o=
Date: Fri, 20 Dec 2024 23:22:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
Content-Language: de-DE, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: vringar <git@zabka.it>
In-Reply-To: <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.180; envelope-from=git@zabka.it;
 helo=out-180.mta1.migadu.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/12/2024 21:59, David Hildenbrand wrote:
> Good point, I suspect that will be problematic.

Looking at flatview_write_continue I see no early exit, so maybe it 
would still try to get through everything and work as we are hoping,
but that's why I'd like to write a test for it.
I'm just not sure if it should be a unit test or a QTest and
what examples I could look to copy.

> Maybe address_space_write() should be taught to be able "force write" to 
> ROM instead, so it can just handle everything as part of a single loop. 
> But that's a bit more churn ...

Tbh I'm not sure whether I understand the intricacies of this code well 
enough to write such a patch without significant guidance.

> Building another loop around address_space_write_rom+address_space_write 
> looks a bit suboptimal, but maybe it really is the low-hanging fruit here.

I don't understand what you mean by this
Do you mean keeping the current patch or going back to v1 or a different 
third approach?

