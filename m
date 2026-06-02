Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC04CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUQG9-0003SR-L8; Tue, 02 Jun 2026 10:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wUQFx-0003RS-I2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:38:13 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wUQFv-00030s-Hj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:38:13 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85F9143B84;
 Tue,  2 Jun 2026 14:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AF01F00893;
 Tue,  2 Jun 2026 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780411087;
 bh=v1WMeXKskUaXSuwNsyVzxqgC4aNDlUoxHgrmCj9WRr8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lE3q/getv2Zn+jRRgHrGVtRcE6BxO68oWoxXqgQEaMYdav+sXbpTmhkBzXobArSVq
 lXmXM+phLLaeOnPEbtCMXvkeHGIt1Y9HIvhIEoZPyxVXL7q5jVWg7EqFaXaycdFs7g
 LSWDV8q8zz11KtvUsUgLj1zZWgkj6VBQfKsIeLSlm5qhVmqlD0Ixl2NOjIIVJkxb0a
 X3VauI3bpZHMMbl4kOwCDUo4bMGHrDCjSS+0rOnbukD62Q0LW4OMq2V/Z6oHhR2sfm
 mPHycdpWnYBhMzgrS4VC5liYS+otnuxMrZmMGHZSOcmqm9y+fMy/PqcJouBBGjlF4V
 eI82gga7dlxqA==
Date: Tue, 2 Jun 2026 15:38:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH -qemu] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Message-ID: <20260602153803.322bf993@jic23-huawei>
In-Reply-To: <20260602043029.2341246-1-dave@stgolabs.net>
References: <20260602043029.2341246-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Mon,  1 Jun 2026 21:30:29 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Change the default CXL Fixed Memory Window restrictions from
> 0x2f to 0xe, dropping Device Coherent and Back-Invalidate,
> which are considered spec violations when using in combination
> with host-only.
> 
> For HDM-D and HDM-DB models, the user will need to explicitly
> pass the correct restrictions bitmask.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

So this only applies on my staging qemu tree (as the
restrictions control patch is not upstream yet). Would you mind
also doing a fix for mainline qemu as we need to change the default
prior to that restrictions patch?

For anyone wondering why that isn't upstream yet - it is mostly
a question of working out a better command line than writing the 
bitmap.  Probably as set of flags for each thing with checks
to ensure we don't end up with impossible combinations.

If you have time to look at that Davidlohr, would be much appreciated.
Without it the BI stuff in upstream qemu will be untestable.

Jonathan

> ---
>  docs/system/devices/cxl.rst | 5 +++--
>  hw/cxl/cxl-host.c           | 2 +-
>  qapi/machine.json           | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 32b1b5d7733b..079f65660dc3 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -385,7 +385,8 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
>  An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> -use HDM-DB for coherence, which requires operating in Flit mode::
> +use HDM-DB for coherence, which requires operating in Flit mode with the CXL Window
> +configured with Back-Invalidate restrictions::
>  
>    qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>    ...
> @@ -405,7 +406,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
>    -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
>    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>    -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> -  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.restrictions=0x2d
>  
>  A simple arm/virt example featuring a single direct connected CXL Type 3
>  Volatile Memory device::
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 11a455b28ab8..a2595633ff0c 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0x2f; /* No restrictions */
> +        fw->restrictions = 0xe; /* host-only coherent, volatile, pmem */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 11ce0457d2f1..f832f0b84a53 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -558,7 +558,7 @@
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
>  #     BIT(5) - BI
> -#     Default is 0x2F
> +#     Default is 0xE
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.


