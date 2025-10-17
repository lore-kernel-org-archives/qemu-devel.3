Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14605CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lR5-0006YC-75; Fri, 17 Oct 2025 10:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v9lR4-0006Xu-B8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v9lR1-0007hv-84
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760711273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrSl8hLKSJGOG68Ko42eLHWtHGcpztcPu+p1QpZ1ErY=;
 b=c/z19kJi4SG6oFFGA81K/CRgmJrg3pS0lnukgHqFKVqhttoOlx/jMJXhRfW+Iy5G3VIgrm
 Lm9L6rWiM+8yBh4y6Tsi89Kpzaa6oB3aww7z2IHoJJqerhx1J0W3RG1NKlS/yEWfEBRZIh
 C4J+f4nDZyaUSnXDEelfnzirf0q0mL0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-WorNP_dqOh-Jex8pm32VVg-1; Fri, 17 Oct 2025 10:27:52 -0400
X-MC-Unique: WorNP_dqOh-Jex8pm32VVg-1
X-Mimecast-MFC-AGG-ID: WorNP_dqOh-Jex8pm32VVg_1760711271
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47111dc7bdbso18002475e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760711271; x=1761316071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrSl8hLKSJGOG68Ko42eLHWtHGcpztcPu+p1QpZ1ErY=;
 b=iVrK7sltTVZiIfQE4vFZssoVWZ+iBpnV/mBkbAN5c05e9/ysaZNowA/7Ko2E9WNdE/
 8URzN4He5/ztwXmVqEMwOcNw2wIUwbaTFinisQK75amBMGv61UhHsIm2LGYZGDEw4/RQ
 46hhl7N7OcLXQ4en17odLq/gAacqHYMdN/RU+oCqCxHqlATHq/6P+XD2gRB3urq6AlUS
 q7Od34QtcXNSrqDZZs7OfnNC+LQv9ZyIrcRV0a8toFNhNH1qq2jqEURBpqWvnbDBqAYq
 9nadWOzMyPR0WRo7V2AXsNMMB6OEovC+LWo3MXoARI9etrg60Ers9neKmFa5m8TQzKDb
 4r1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0QMGSaa1hoqxqE4mf3slBAMPtS4zCsMGCmXE01v8AboYgGDQMjeVxNr6AQ1jSl554IH30gUcn8Zly@nongnu.org
X-Gm-Message-State: AOJu0Yxl785zvX1EvCClGOmiL0iQcKbqgzlzmc2ChwdJVMbVDFOcTKW/
 7PdKk1x0qkXrcq/EDyA1ighj+jeWPSTC+cIlm1Rq6D+uR/+qEx51DAyBv9JYhEq5FM5vfTY3/IP
 GI+8WjIIQQF6OMXUhoumGCQZv3AD1gy+OIoyOGxy4Tmi+/eOMwvf70zZI
X-Gm-Gg: ASbGnctNT5iEEatMzn4cb+R7MYBK7yVenxKWV2FdGepPx7bnoy4vPfOyaqQRme1wYaW
 YM/pjDVZftzZHwdbviuiu5z4kLEZeFM59G/qBfDVtmvPai5lbfDH6F0vKqC1GB8wxSWI0pvegOs
 KGVarCw5pIkCVxw639qtZ94/Vqs0n8UwTMCwYwHcQx6z1ft2oWYIQ/m7GVacs4qkLr3v/hS9KDO
 JXcvwvSUumUneZ6wTqfJ52SZibaLYORZVS9pgzbPuk0DKwD30en6gXQIwMDu132YqRm/XmVn95m
 gO33shkKY9pcx3d9Izd5SFM+72BA2r1OcYXDQq6sj1QqAeH+a+hlA7+Ivnb1VLQD3Q==
X-Received: by 2002:a05:600c:3149:b0:46f:aac5:daf with SMTP id
 5b1f17b1804b1-4711792a51bmr27864155e9.35.1760711271066; 
 Fri, 17 Oct 2025 07:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGwxVVNwsFMcWZO8p1xAkGtRVwJetDwQ/aJgYFkjFuZehLt2Orir2SzfvRVDUMVmkG0vm+Yw==
X-Received: by 2002:a05:600c:3149:b0:46f:aac5:daf with SMTP id
 5b1f17b1804b1-4711792a51bmr27863865e9.35.1760711270574; 
 Fri, 17 Oct 2025 07:27:50 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c34sm93546185e9.10.2025.10.17.07.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:27:49 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:27:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory
 CPERs injection
Message-ID: <20251017162746.2a99015b@fedora>
In-Reply-To: <20251007060810.258536-4-gshan@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-4-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  7 Oct 2025 16:08:10 +1000
Gavin Shan <gshan@redhat.com> wrote:

> In the combination of 64KB host and 4KB guest, a problematic host page
> affects 16x guest pages. In this specific case, it's reasonable to
> push 16 consecutive memory CPERs. Otherwise, QEMU can run into core
> dump due to the current error can't be delivered as the previous error
> isn't acknoledges. It's caused by the nature the host page can be
> accessed in parallel due to the mismatched host and guest page sizes.

can you explain a bit more what goes wrong?

I'm especially interested in parallel access you've mentioned
and why batch adding error records is needed
as opposed to adding records every time invalid access happens?

PS:
Assume I don't remember details on how HEST works,
Answering it in this format also should improve commit message
making it more digestible for uninitiated.

> Imporve push_ghes_memory_errors() to push 16x consecutive memory CPERs
> for this specific case. The maximal error block size is bumped to 4KB,
> providing enough storage space for those 16x memory CPERs.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/acpi/ghes.c   |  2 +-
>  target/arm/kvm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 045b77715f..5c87b3a027 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -33,7 +33,7 @@
>  #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
> -#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> +#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
>  
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index c5d5b3b16e..3ecb85e4b7 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include <sys/ioctl.h>
>  
>  #include <linux/kvm.h>
> @@ -2433,10 +2434,53 @@ static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
>                                      uint64_t paddr)
>  {
>      GArray *addresses = g_array_new(false, false, sizeof(paddr));
> +    uint64_t val, start, end, guest_pgsz, host_pgsz;
>      int ret;
>  
>      kvm_cpu_synchronize_state(c);
> -    g_array_append_vals(addresses, &paddr, 1);
> +
> +    /*
> +     * Sort out the guest page size from TCR_EL1, which can be modified
> +     * by the guest from time to time. So we have to sort it out dynamically.
> +     */
> +    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
> +    if (ret) {
> +        goto error;
> +    }
> +
> +    switch (extract64(val, 14, 2)) {
> +    case 0:
> +        guest_pgsz = 4 * KiB;
> +        break;
> +    case 1:
> +        guest_pgsz = 64 * KiB;
> +        break;
> +    case 2:
> +        guest_pgsz = 16 * KiB;
> +        break;
> +    default:
> +        error_report("unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
> +        goto error;
> +    }
> +
> +    host_pgsz = qemu_real_host_page_size();
> +    start = paddr & ~(host_pgsz - 1);
> +    end = start + host_pgsz;
> +    while (start < end) {
> +        /*
> +         * The precise physical address is provided for the affected
> +         * guest page that contains @paddr. Otherwise, the starting
> +         * address of the guest page is provided.
> +         */
> +        if (paddr >= start && paddr < (start + guest_pgsz)) {
> +            g_array_append_vals(addresses, &paddr, 1);
> +        } else {
> +            g_array_append_vals(addresses, &start, 1);
> +        }
> +
> +        start += guest_pgsz;
> +    }
> +
>      ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
>      if (ret) {
>          goto error;


