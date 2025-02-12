Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4BAC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 23:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiM8B-0003NH-At; Wed, 12 Feb 2025 18:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tiM89-0003N9-6L
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 18:26:57 -0500
Received: from out-175.mta0.migadu.com ([2001:41d0:1004:224b::af])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1tiM86-0007XV-GN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 18:26:56 -0500
Message-ID: <c36fe3a8-9541-4775-a538-91eeb9d6e3a3@zabka.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1739402805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOaet+G5RkciX3zRJ78wAEegVpOPOwTkROSwSUCx520=;
 b=T4sUJOUGrMeZ+VQIPQ++3dk39P9x0ehNFGmSTdyRfdzZBq+3b6Yq4JASAjaczSzKGJ6PJv
 UYp91WYMiBsoGqg7RvA/z/IXBmtuOpE51z21zhpwLwx1tnWmn7rXMIcWbNIVlbWP7EZGmY
 Pg6k+oAJzgoXmI8Inz+uR4NrY6cYLwg=
Date: Thu, 13 Feb 2025 00:26:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/7] physmem: teach cpu_memory_rw_debug() to write to
 more memory regions
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250210084648.33798-1-david@redhat.com>
Content-Language: de-DE, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Stefan Zabka <git@zabka.it>
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::af;
 envelope-from=git@zabka.it; helo=out-175.mta0.migadu.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Sorry for the delayed engagement, I failed to apply the patch set from 
the mailing list and had to remember that David had published this 
change set on GitHub.

Tested-by: Stefan Zabka <git@zabka.it>

This addresses my initial use case of being able to write to a single 
MMIO device. I have not set up a scenario with an interleaving of
MMIO and RAM/ROM regions to ensure that a single large write is 
correctly handled there.

Reviewed-by: Stefan Zabka <git@zabka.it>

I don't know if this counts for anything, but I've read through the 
entire patch series, tried to make sense of it and couldn't spot any 
issues. It should be noted that I am a terrible C programmer and have 
only written basic devices so far.

On 10/02/2025 09:46, David Hildenbrand wrote:
> This is a follow-up to [1], implementing it by avoiding the use of
> address_space_write_rom() in cpu_memory_rw_debug() completely, and
> teaching address_space_write() about debug access instead, the can also
> write to ROM.
> 
> The goal is to let GDB via cpu_memory_rw_debug() to also properly write to
> MMIO device regions, not just RAM/ROM.
> 
> It's worth noting that other users of address_space_write_rom() are
> left unchanged. Maybe hw/core/loader.c and friends could now be converted
> to to a debug access via address_space_write() instead?
> 
> Survives a basic gitlab CI build/check.
> 
> [1] https://lore.kernel.org/all/20241220195923.314208-1-git@zabka.it/
> 
> v2 -> v3:
> * Rebased, only a minor conflict in the last patch.
> 
> v1 -> v2:
>   * Split up "physmem: disallow direct access to RAM DEVICE in
>     address_space_write_rom()" into 4 patches
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
> Cc: Stefan Zabka <git@zabka.it>
> 
> David Hildenbrand (7):
>    physmem: factor out memory_region_is_ram_device() check in
>      memory_access_is_direct()
>    physmem: factor out RAM/ROMD check in memory_access_is_direct()
>    physmem: factor out direct access check into
>      memory_region_supports_direct_access()
>    physmem: disallow direct access to RAM DEVICE in
>      address_space_write_rom()
>    memory: pass MemTxAttrs to memory_access_is_direct()
>    hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
>    physmem: teach cpu_memory_rw_debug() to write to more memory regions
> 
>   hw/core/cpu-system.c      | 13 +++++++++----
>   hw/core/loader.c          |  2 +-
>   hw/remote/vfio-user-obj.c |  2 +-
>   include/exec/memattrs.h   |  5 ++++-
>   include/exec/memory.h     | 35 +++++++++++++++++++++++++++--------
>   monitor/hmp-cmds-target.c |  3 +--
>   system/memory_ldst.c.inc  | 18 +++++++++---------
>   system/physmem.c          | 24 +++++++++---------------
>   8 files changed, 61 insertions(+), 41 deletions(-)
> 

