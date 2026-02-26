Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5ABFD8FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdoK-00074T-R1; Thu, 26 Feb 2026 11:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vvdoE-00072e-83
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:01:53 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vvdoA-0004VI-Pb
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:01:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 169746183A;
 Thu, 26 Feb 2026 16:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A95C116C6;
 Thu, 26 Feb 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772121705;
 bh=2K0GX3mzxxaY4fVt4pRaJHoMk00nh/g7bU3J/t8Ugrg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tCeydCikWsdtRb4a6tHttDgpN/c3VIrttFRCX97FHGNDgtQJGETdhwNPREQ0wgn5D
 pNa9yXDrf8PNBiVXY125P49yA/61Vt+jVekDYYUUsEKvku4ApRiQvBEI18MfQb4hM/
 ypFY9ErOT3oHjE0VpGX78f6oQfXFDw7sJ7irmb49J/sQ90aCm8/Wc6mLkCxJ7HTbGo
 XzGDb1JJ8dKCNcfozKyaUITSRVFc+GJW7ziEyY2Qwrz8JI4SurjaptpjqSJ1ywotbw
 JZZ/hWIpOfCxKJ/ghqWYOqINbQBAN9bLhAb1c3RAT1+L0koWb7/pailnV0B6XfXcAL
 hIOyYdCmKfimA==
Message-ID: <99b0ab59-c1dc-4d23-addc-7bf4b87bfa03@kernel.org>
Date: Thu, 26 Feb 2026 17:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] system/ram-discard-manager: implement replay via
 is_populated iteration
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-10-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2/26/26 14:59, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace the source-level replay wrappers with a new
> replay_by_populated_state() helper that iterates the section at
> min-granularity, calls is_populated() for each chunk, and aggregates
> consecutive chunks of the same state before invoking the callback.
> 
> This moves the iteration logic from individual sources into the manager,
> preparing for multi-source aggregation where the manager must combine
> state from multiple sources anyway.
> 
> The replay_populated/replay_discarded vtable entries in
> RamDiscardSourceClass are no longer called but remain in the interface
> for now; they will be removed in follow-up commits along with the
> now-dead source implementations.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Isn't it significantly more expensive for large guests to possibly
iterate in 4k granularity?

The nice thing about the old implementation was that we could just scan
a bitmap, that is ideally in 2M granularity.

-- 
Cheers,

David


