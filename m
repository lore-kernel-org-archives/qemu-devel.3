Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E0ECCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 07:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJRxI-0003bZ-Vj; Thu, 13 Nov 2025 02:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vJRxH-0003XR-Ft
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vJRxE-0002V0-PW
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763019675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tzue4XLFxIYlnPFUrxxjp9R2i449yDG741YHnvRod2I=;
 b=M5uY/qY4uZm3Iixq4EYCGoCuMDNaYG8uQy3UtFvoELgvd8Zmw00Ut33oOTE69lloEo1J0F
 RbgBpG1Dq4kxtzG/iclQDmRYtznjin9KzZy+HGQs7t5l/SMy72Jcuw8aj+HlpxojzK2QeO
 rkKrGpdUx2d9SzPer1ZRlGBxkCZEvGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-ao9ctMkJMsGCQmBAF4RldA-1; Thu,
 13 Nov 2025 02:41:10 -0500
X-MC-Unique: ao9ctMkJMsGCQmBAF4RldA-1
X-Mimecast-MFC-AGG-ID: ao9ctMkJMsGCQmBAF4RldA_1763019669
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A861219560B2; Thu, 13 Nov 2025 07:41:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A6EE1955F1B; Thu, 13 Nov 2025 07:41:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F55921E6A27; Thu, 13 Nov 2025 08:41:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com,  mchehab+huawei@kernel.org,
 gengdongjiu1@gmail.com,  mst@redhat.com,  imammedo@redhat.com,
 anisinha@redhat.com,  eduardo@habkost.net,  marcel.apfelbaum@gmail.com,
 philmd@linaro.org,  wangyanan55@huawei.com,  zhao1.liu@intel.com,
 peter.maydell@linaro.org,  pbonzini@redhat.com,  shan.gavin@gmail.com
Subject: Re: [PATCH v4 7/8] acpi/ghes: Use error_fatal in
 acpi_ghes_memory_errors()
In-Reply-To: <20251112172535.403042-8-gshan@redhat.com> (Gavin Shan's message
 of "Thu, 13 Nov 2025 03:25:34 +1000")
References: <20251112172535.403042-1-gshan@redhat.com>
 <20251112172535.403042-8-gshan@redhat.com>
Date: Thu, 13 Nov 2025 08:41:04 +0100
Message-ID: <878qga5qi7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Gavin Shan <gshan@redhat.com> writes:

> Use error_fatal in acpi_ghes_memory_errors() so that the caller
> needn't explicitly terminate on errors. With error_fatal, a qemu
> core dump won't be provided as it doesn't provide anything needed
> by debugging.
>
> There is no way to call ghes-stu.c::acpi_ghes_memory_errors(), an
> abort() is put there as explicit marker. Besides, the return value
> of acpi_ghes_memory_errors() is changed from 'int' to 'bool' as
> the error indicator. ghes_record_cper_errors() also return a 'bool'
> value for that, to be compatible to what is documented in error.h.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

This commit does a number of things:

1. Change abort() to exit() on error, and drop the extra error message
"failed to record the error".

2. Use &error_fatal to separate concerns and simplify the caller.  This
item covers both the new Error ** parameter and the returning bool
instead of void.

3. Make the unreachable stub abort().

The commit message could use polish to make the three distinct things
more clear.

In general, patches that do just one thing are easier to understand and
describe (in the commit message) than patches that do multiple things.
That said, a single commit feels okay in this case.  Up to you.

> ---
>  hw/acpi/ghes-stub.c    |  7 ++++---
>  hw/acpi/ghes.c         | 27 +++++++++++++--------------
>  include/hw/acpi/ghes.h |  7 ++++---
>  target/arm/kvm.c       | 10 +++-------
>  4 files changed, 24 insertions(+), 27 deletions(-)
>
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 4faf573aeb..fc7374b0a6 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,10 +11,11 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t *addresses, uint32_t num_of_addresses)
> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t *addresses, uint32_t num_of_addresses,
> +                             Error **errp)
>  {
> -    return -1;
> +    abort();
>  }
>  
>  AcpiGhesState *acpi_ghes_get_state(void)
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index d3d6c11197..7160cf37d0 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -508,14 +508,14 @@ static bool get_ghes_source_offsets(uint16_t source_id,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(acpi_generic_error_notifiers);
>  
> -void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
> +bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
>  
>      if (len > ghes_max_raw_data_length(ags)) {
>          error_setg(errp, "GHES CPER record is too big: %zd", len);
> -        return;
> +        return false;
>      }
>  
>      if (!ags->use_hest_addr) {
> @@ -524,7 +524,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      } else if (!get_ghes_source_offsets(source_id,
>                      le64_to_cpu(ags->hest_addr_le), &cper_addr,
>                      &read_ack_register_addr, errp)) {
> -            return;
> +            return false;
>      }
>  
>      cpu_physical_memory_read(read_ack_register_addr,
> @@ -535,7 +535,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>          error_setg(errp,
>                     "OSPM does not acknowledge previous error,"
>                     " so can not record CPER for current error anymore");
> -        return;
> +        return false;
>      }
>  
>      read_ack_register = cpu_to_le64(0);
> @@ -550,10 +550,13 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
>      notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
> +
> +    return true;
>  }
>  
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t *addresses, uint32_t num_of_addresses)
> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t *addresses, uint32_t num_of_addresses,
> +                             Error **errp)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> @@ -564,10 +567,10 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>       * Table 17-13 Generic Error Data Entry
>       */
>      QemuUUID fru_id = {};
> -    Error *errp = NULL;
>      int data_length;
>      GArray *block;
>      uint32_t block_status = 0, i;
> +    bool ret;
>  
>      block = g_array_new(false, true /* clear */, 1);
>  
> @@ -605,16 +608,12 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>      }
>  
>      /* Report the error */

This comment is now stale.  I'd simply drop it.

> -    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
> +    ret = ghes_record_cper_errors(ags, block->data, block->len,
> +                                  source_id, errp);
>  
>      g_array_free(block, true);
>  
> -    if (errp) {
> -        error_report_err(errp);
> -        return -1;
> -    }
> -
> -    return 0;
> +    return ret;

I figure you could use g_autoptr() to simplify this further.  Something
along the lines of

       g_autoptr(GArray) block = g_array_new(false, true, 1);

       [...]

       return ghes_record_cper_errors(ags, block->data, block->len,
                                      source_id, errp);

>  }
>  
>  AcpiGhesState *acpi_ghes_get_state(void)
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index f7b084c039..c1f01ac25c 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -99,9 +99,10 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t *addresses, uint32_t num_of_addresses);
> -void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t *addresses, uint32_t num_of_addresses,
> +                             Error **errp);
> +bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
>  /**
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 459ca4a9b0..b8c3ad2ad9 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>              addresses[0] = paddr;
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> -                                             addresses, 1)) {
> -                    kvm_inject_arm_sea(c);
> -                } else {
> -                    error_report("failed to record the error");
> -                    abort();
> -                }
> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> +                                        addresses, 1, &error_fatal);
> +                kvm_inject_arm_sea(c);
>              }
>              return;
>          }

Readability improves nicely here.


