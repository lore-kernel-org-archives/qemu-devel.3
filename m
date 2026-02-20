Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6796AC56205
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS16-0007Yf-Es; Fri, 20 Feb 2026 10:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtS0f-0007Q6-7A
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtS0c-0001kI-Nb
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771599693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGGqV7kfdxRNr0N+CuOeNv8t5DH3fa+zrHbpB8i6iW4=;
 b=fH+ipWl5X8rZa/0ZJpyphySGPEvq4Lg4EhXhM2PdzdO8ggjDQA2V5bVZvxbc3x4w5wj4Ak
 8MSlgO5dq8hOhf4TZNacFNclve/xXuziNwXtlg3PTvFknRACtsSyml/4HuarYfF3D0cTpH
 jrwJ1ps7fRZYH0CYOLN6QVg0l95/TgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-2-FcKjVUPiK_ZdrgY9zhrA-1; Fri, 20 Feb 2026 10:01:32 -0500
X-MC-Unique: 2-FcKjVUPiK_ZdrgY9zhrA-1
X-Mimecast-MFC-AGG-ID: 2-FcKjVUPiK_ZdrgY9zhrA_1771599691
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435add03f12so1465859f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771599690; x=1772204490; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dGGqV7kfdxRNr0N+CuOeNv8t5DH3fa+zrHbpB8i6iW4=;
 b=Ji2ZF7SWSt0ZiClq3cPmvg8+LO2N6JYtjjA2xTIEjAW8G9xXKpOh/Cczi3wXhWSU0o
 5BmQv5++t0W4xGTTVaS4CY8Cy/u1icxN1Tvt/tIaejWON/H79D1TY4M/yLPRSaVG2I6A
 Wb4u30/vSXZsOA04NkeD2w2AyjlS1W/rlsiaqwsRI+amP7jFl/2sXvy9MBgr82/AEoRq
 W3QRPHW0zW+VbNE47I6or+ORno7O6xZmOSRy/TO6ghdp47Yr0KZNXsHMUoRdH/g0eKQj
 LskCuad566izmI09UTXTvL7FoJztznVTdP9idop+8Ro2U3LQPaBBrz+0MsyxUKkyLX+m
 v/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771599690; x=1772204490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGGqV7kfdxRNr0N+CuOeNv8t5DH3fa+zrHbpB8i6iW4=;
 b=Jx7t3x1tv1nc6Z9NztKx+pGCiC+q/XENkURoffyn0IvvIqn/dj4RdxUWr5I3yikAZC
 1tmEULbnCMxk8ntBjD09uXmmCoQJ3G0v8R8rjiZZDXOSlw8HbjfI+qj9uAePNZqb6bwU
 hDz5RBhXOq8r27XA2A1VOzdxRd3CCHUFNJK0Z7ZSGSTToEURR6ndBoI+sRzbj39vti3p
 5XNAKUQgX4raWaKUfj2FqgpmuTWgSG42rAYz80gQpXufFOoSrpaFOeT8EdyS8pwG2Gn5
 gyzr8IzHWBy6vyRpLJ3iMJ8aCb16oENYqqcG7z9adqhR6zaSELrTZwuMgy7DEcxAgoiS
 NLyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLm/+0/i1KFTXiwyH0Q8CHIzgcF3MhhJuT38yc0qq4nCkPLVbJV3qStQh5IN8To7VqvwBn3T+Vhih+@nongnu.org
X-Gm-Message-State: AOJu0YxipmEHs9tj20J6seFlvOCoTeZcujjDfMwgjuwXcB5sX9IYFLp1
 qnKdTDZ0sxJwixF+Bhdy37LDZrgPqlW+E2tnwp7g8XabiALGf2dmwqA3MTijDDH5wCGtydWraM6
 rQzMPrKaoHnFUG+leXBdeZdxdtK5lwf+0G9IzuWNMfBmDtn9B+fr9GJEX
X-Gm-Gg: AZuq6aLmofqLPPCETAngAMUA8DzIAbqH7xZqASeGx18aEcS1/NNK7M3EO3/gc0xdekY
 Zp8F4Do4dCOIKMGH8XmIXNrVkluRkaOH3QgwbD6Nrc9ruMzotQhW6RKspJVAvCGxptgTGdmV/1C
 1PTgfFvusaV4T5iHzZIRH9wjW4AtiZofyJGuYQUd9RdiW2M+3GSMRmBJ3Hj6wmxwc4UBvAQ6EiU
 lYnkV0CfQyIZ2JvYbraPGHXWCimY7vgN2ebvwc/jO3D0VAW59/sF4tI/96HB0Qdbh7T/yb5t3UN
 MNGibt7jgvwyXoVpnXDJvIjkiyb5Iu/d5izfV6jSOiuufEkwajAP4X28RtaIfvXbj3zTSu+WZAS
 3dVXq1MDPcWolrtIGR/rwIBcr0yQ+n38L3U4es3ZzoHgOuQ==
X-Received: by 2002:a05:6000:230b:b0:437:71cc:a246 with SMTP id
 ffacd0b85a97d-4396f153cd2mr449314f8f.10.1771599690293; 
 Fri, 20 Feb 2026 07:01:30 -0800 (PST)
X-Received: by 2002:a05:6000:230b:b0:437:71cc:a246 with SMTP id
 ffacd0b85a97d-4396f153cd2mr449206f8f.10.1771599689681; 
 Fri, 20 Feb 2026 07:01:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74704sm60644897f8f.16.2026.02.20.07.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 07:01:29 -0800 (PST)
Date: Fri, 20 Feb 2026 10:01:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 11/34] hw/i386: refactor x86_bios_rom_init for reuse
 in confidential guest reset
Message-ID: <20260220100116-mutt-send-email-mst@kernel.org>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-12-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218114233.266178-12-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Feb 18, 2026 at 05:12:04PM +0530, Ani Sinha wrote:
> For confidential guests, bios image must be reinitialized upon reset. This
> is because bios memory is encrypted and hence once the old confidential
> kvm context is destroyed, it cannot be decrypted. It needs to be reinitilized.
> In order to do that, this change refactors x86_bios_rom_init() code so that
> parts of it can be called during confidential guest reset.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>


just  a refactor:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/x86-common.c | 50 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index de4cd7650a..c98abaf368 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -1020,17 +1020,11 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
>      memory_region_set_readonly(isa_bios, read_only);
>  }
>  
> -void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
> -                       MemoryRegion *rom_memory, bool isapc_ram_fw)
> +static int get_bios_size(X86MachineState *x86ms,
> +                         const char *bios_name, char *filename)
>  {
> -    const char *bios_name;
> -    char *filename;
>      int bios_size;
> -    ssize_t ret;
>  
> -    /* BIOS load */
> -    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          bios_size = get_image_size(filename, NULL);
>      } else {
> @@ -1040,6 +1034,21 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>          (bios_size % 65536) != 0) {
>          goto bios_error;
>      }
> +
> +    return bios_size;
> +
> + bios_error:
> +    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> +    exit(1);
> +}
> +
> +static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
> +                                char *filename, int bios_size,
> +                                bool isapc_ram_fw)
> +{
> +    ssize_t ret;
> +
> +    /* BIOS load */
>      if (machine_require_guest_memfd(MACHINE(x86ms))) {
>          memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
>                                             bios_size, &error_fatal);
> @@ -1068,7 +1077,26 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>              goto bios_error;
>          }
>      }
> -    g_free(filename);
> +
> +    return;
> +
> + bios_error:
> +    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> +    exit(1);
> +}
> +
> +void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
> +                       MemoryRegion *rom_memory, bool isapc_ram_fw)
> +{
> +    int bios_size;
> +    const char *bios_name;
> +    g_autofree char *filename;
> +
> +    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +
> +    bios_size = get_bios_size(x86ms, bios_name, filename);
> +    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
>  
>      if (!machine_require_guest_memfd(MACHINE(x86ms))) {
>          /* map the last 128KB of the BIOS in ISA space */
> @@ -1081,8 +1109,4 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>                                  (uint32_t)(-bios_size),
>                                  &x86ms->bios);
>      return;
> -
> -bios_error:
> -    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
> -    exit(1);
>  }
> -- 
> 2.42.0


