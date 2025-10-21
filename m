Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9473BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBADw-000322-6R; Tue, 21 Oct 2025 07:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1vBADu-00030t-GV
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:08:14 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1vBADs-000437-Dg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:08:14 -0400
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82D611F397;
 Tue, 21 Oct 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761044884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaBBd+XdryUfpAsID7YC7Ekp97FYZ09q7tdZODr7lks=;
 b=ubj3blZhn7dJbHx6ALKD0ISKr/cmhyzYQl2hRSLgIKbVR92Fp3/hJgCoP7Whj+7OUHlMA9
 cZlT7drJ6jg4OLmJbPSHfnPZPKesiCsVDQsH0fjnRCXrL2yGohWqqRFpY9pspJhUQ3luzN
 8ZmQUY2/rpg7FGKTIgqDZeuHJCXuhts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761044884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaBBd+XdryUfpAsID7YC7Ekp97FYZ09q7tdZODr7lks=;
 b=rnq1UIRVjq6ZITQA/eaMk71CQCsyuxsbrstkgcjh7EhOTXUCUL4LCR0XY+FvFNCdsGmkNT
 ydQxx2pJRI8Q8UCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761044880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaBBd+XdryUfpAsID7YC7Ekp97FYZ09q7tdZODr7lks=;
 b=B/lq3WTD319V36Nb4MLJVyyeULhm50bw+ULGwvnlOEDhiF5yx39eauFSn71Lj7yh0Cylc+
 6vN2HBcj0a226D5Yp8aKq5uBXPTiS2/Nc9qFUfblU7zBjNhe4yUax+c22mG6JrRJ9rHbXH
 xmy5O6EtL3G26o1QI6mddXv9lWtsDHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761044880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaBBd+XdryUfpAsID7YC7Ekp97FYZ09q7tdZODr7lks=;
 b=dx2E3qT9/Gvlkm58DN/iTQygC9LYkVHzTXnwGobWYkBE3ylrhqeh8jsw66DlyCq7Tdhu7p
 uf//8HCHtTa3NeCQ==
Date: Tue, 21 Oct 2025 13:07:59 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v2 00/11] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
Message-ID: <aPdpjysqFBAMTvG-@kitsune.suse.cz>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_ZERO(0.00)[0];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[kitsune.suse.cz:mid,kitsune.suse.cz:helo];
 FREEMAIL_CC(0.00)[nongnu.org,linux.ibm.com,gmail.com,vger.kernel.org,redhat.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=msuchanek@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

I noticed removal of old pSeries revisions.

FTR to boot Linux 3.0 I need pSeries-2.7 (already removed earlier).

The thing that broke booting linux 3.0 for me is
357d1e3bc7d2d80e5271bc4f3ac8537e30dc8046 spapr: Improved placement of
PCI host bridges in guest memory map

I do not use Linux 3.0 anymore which is the reason I did not notice this
breakage due to old platform revision removal.

At the same time quemu is sometimes touted as a way to run old OS
revisions. That does not work very well for pSeries.

Thanks

Michal

On Tue, Oct 21, 2025 at 10:43:34AM +0200, Philippe Mathieu-Daudé wrote:
> v2: Rebased on https://lore.kernel.org/qemu-devel/20251009184057.19973-1-harshpb@linux.ibm.com/
> 
> Remove the deprecated pseries-3.0 up to pseries-4.2 machines,
> which are older than 6 years. Remove resulting dead code.
> 
> Harsh Prateek Bora (5):
>   ppc/spapr: remove deprecated machine pseries-3.0
>   ppc/spapr: remove deprecated machine pseries-3.1
>   ppc/spapr: remove deprecated machine pseries-4.0
>   ppc/spapr: remove deprecated machine pseries-4.1
>   ppc/spapr: remove deprecated machine pseries-4.2
> 
> Philippe Mathieu-Daudé (6):
>   hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
>   hw/ppc/spapr: Inline spapr_dtb_needed()
>   hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
>   target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
>   target/ppc/kvm: Remove kvmppc_get_host_model() as unused
>   hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback
> 
>  include/hw/ppc/spapr.h     |  16 --
>  include/hw/ppc/spapr_irq.h |   1 -
>  target/ppc/kvm_ppc.h       |  12 --
>  hw/ppc/spapr.c             | 299 ++++++++-----------------------------
>  hw/ppc/spapr_caps.c        |  12 +-
>  hw/ppc/spapr_events.c      |  20 +--
>  hw/ppc/spapr_hcall.c       |   5 -
>  hw/ppc/spapr_irq.c         |  36 +----
>  hw/ppc/spapr_pci.c         |  32 +---
>  hw/ppc/spapr_vio.c         |   9 --
>  target/ppc/kvm.c           |  11 --
>  11 files changed, 77 insertions(+), 376 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

