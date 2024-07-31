Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826DFC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9TN-0001Pu-HX; Wed, 31 Jul 2024 09:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZ9TL-0001OB-FV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZ9TJ-0006W8-BB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722432867;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QKhe1skX0A9BUM0iun7o2z0tKLunb3zPUTWJoI6hvNQ=;
 b=CFQDUotB38mArX93/dRNt3A+LBqhfIZ9p8yhjcOtR9vjj+Cj28TDhV67TX98V0YEPrBlB7
 JzKziQjsyyXnvmmiiZ+sQuwzJ9A1K/tPsdbVpNKBkGpbWHKY5rdoA556wAySefUqXd8t+R
 OtNqdQt3guk8YsVf5th6+o/9ihYkWbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-B1KbsUNONqilnF8Tc79_eg-1; Wed,
 31 Jul 2024 09:34:23 -0400
X-MC-Unique: B1KbsUNONqilnF8Tc79_eg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E241C1955F4A; Wed, 31 Jul 2024 13:34:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76BBC1955DE9; Wed, 31 Jul 2024 13:34:04 +0000 (UTC)
Date: Wed, 31 Jul 2024 14:34:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [RFC PATCH] hw/ppc: Implement -dtb support for PowerNV
Message-ID: <Zqo9SOG_t-iI9xW4@redhat.com>
References: <20240731132235.887918-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731132235.887918-1-adityag@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 31, 2024 at 06:52:35PM +0530, Aditya Gupta wrote:
> Currently any device tree passed with -dtb option in QEMU, was ignored
> by the PowerNV code.
> 
> Read and pass the passed -dtb to the kernel, thus enabling easier
> debugging with custom DTBs.
> 
> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
> 
> But when a '-dtb' is passed, it completely overrides any dtb nodes or
> changes QEMU might have done, such as '-append' arguments to the kernel
> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
> when -dtb is being used
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> ---
> This is an RFC patch, and hence might not be the final implementation,
> though this current one is a solution which works
> ---
> ---
>  hw/ppc/pnv.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3526852685b4..12cc909b9e26 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -714,6 +714,8 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>      PnvMachineState *pnv = PNV_MACHINE(machine);
>      IPMIBmc *bmc;
>      void *fdt;
> +    FILE *fdt_file;
> +    uint32_t fdt_size;
>  
>      qemu_devices_reset(reason);
>  
> @@ -736,10 +738,31 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
>          }
>      }
>  
> -    fdt = pnv_dt_create(machine);
> +    if (machine->dtb) {
> +        warn_report("with manually passed dtb, some options like '-append'"
> +                " might ignored and the dtb passed will be used as-is");

Check whether append is actually set, and report an fatal error in
that case. 

>  
> -    /* Pack resulting tree */
> -    _FDT((fdt_pack(fdt)));
> +        fdt = g_malloc0(FDT_MAX_SIZE);
> +
> +        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
> +        fdt_file = fopen(machine->dtb, "r");
> +        if (fdt_file != NULL) {
> +            fdt_size = fread(fdt, sizeof(char), FDT_MAX_SIZE, fdt_file);
> +            if (ferror(fdt_file) != 0) {
> +                error_report("Could not load dtb '%s'",
> +                             machine->dtb);
> +                exit(1);
> +            }
> +
> +            /* mark end of the fdt buffer with '\0' */
> +            ((char *)fdt)[fdt_size] = '\0';
> +        }

Preferrable to use g_file_get_contents()

> +    } else {
> +        fdt = pnv_dt_create(machine);
> +
> +        /* Pack resulting tree */
> +        _FDT((fdt_pack(fdt)));
> +    }
>  
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
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


