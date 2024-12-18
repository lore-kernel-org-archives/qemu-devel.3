Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0040E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwkT-00059F-Sq; Wed, 18 Dec 2024 11:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNwkQ-00054c-RX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNwkI-0003U1-Ma
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734538676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYKjrkJRWjzHKmM/pQpwasuiCDmRdGn9UbHhpJk1ymM=;
 b=aZlRgKkmmKyPNOrHlsh0WqSfWkCWlKsiq39atDnWO7FjbNzpBFOxdLPpCEgakMDAn3Mraw
 1Ts9X52qn3w86i8rlFEovNeqoon/jCByG+QYd728HksrGGL7PviiRJ4eLGZwLJYROmRDsu
 2mTta1m0OPFH8BZZe1kJnigdBOr50fI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-lrRuWrC_OG2bWpCNTzju7g-1; Wed,
 18 Dec 2024 11:17:52 -0500
X-MC-Unique: lrRuWrC_OG2bWpCNTzju7g-1
X-Mimecast-MFC-AGG-ID: lrRuWrC_OG2bWpCNTzju7g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 312AF1956065; Wed, 18 Dec 2024 16:17:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3940B300F9B5; Wed, 18 Dec 2024 16:17:41 +0000 (UTC)
Date: Wed, 18 Dec 2024 16:17:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] target/i386/sev: Reduce system specific declarations
Message-ID: <Z2L1o7xesp5EcRuW@redhat.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218155913.72288-3-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 18, 2024 at 04:59:13PM +0100, Philippe Mathieu-Daudé wrote:
> "system/confidential-guest-support.h" is not needed,
> remove it. Reorder #ifdef'ry to reduce declarations
> exposed on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/sev.h  | 29 ++++++++++++++++-------------
>  hw/i386/pc_sysfw.c |  2 +-
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 2664c0b1b6c..373669eaace 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -18,7 +18,17 @@
>  #include CONFIG_DEVICES /* CONFIG_SEV */
>  #endif
>  
> -#include "system/confidential-guest-support.h"
> +#if !defined(CONFIG_SEV) || defined(CONFIG_USER_ONLY)
> +#define sev_enabled() 0
> +#define sev_es_enabled() 0
> +#define sev_snp_enabled() 0
> +#else
> +bool sev_enabled(void);
> +bool sev_es_enabled(void);
> +bool sev_snp_enabled(void);
> +#endif
> +
> +#if !defined(CONFIG_USER_ONLY)

I'm surprised any of this header file is relevant to
user mode. If something is mistakely calling sev_ functions
from user mode compiled code, I'd be inclined to fix the
caller such that its #include ".../sev.h" can be wrapped
by !CONFIG_USER_ONLY

>  
>  #define TYPE_SEV_COMMON "sev-common"
>  #define TYPE_SEV_GUEST "sev-guest"
> @@ -45,18 +55,6 @@ typedef struct SevKernelLoaderContext {
>      size_t cmdline_size;
>  } SevKernelLoaderContext;
>  
> -#ifdef CONFIG_SEV
> -bool sev_enabled(void);
> -bool sev_es_enabled(void);
> -bool sev_snp_enabled(void);
> -#else
> -#define sev_enabled() 0
> -#define sev_es_enabled() 0
> -#define sev_snp_enabled() 0
> -#endif
> -
> -uint32_t sev_get_cbit_position(void);
> -uint32_t sev_get_reduced_phys_bits(void);
>  bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
>  
>  int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);
> @@ -68,4 +66,9 @@ void sev_es_set_reset_vector(CPUState *cpu);
>  
>  void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
>  
> +#endif /* !CONFIG_USER_ONLY */
> +
> +uint32_t sev_get_cbit_position(void);
> +uint32_t sev_get_reduced_phys_bits(void);
> +
>  #endif
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index da7ed121292..1eeb58ab37f 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -36,7 +36,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/block/flash.h"
>  #include "system/kvm.h"
> -#include "sev.h"
> +#include "target/i386/sev.h"
>  
>  #define FLASH_SECTOR_SIZE 4096
>  
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


