Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjqU-0002Yo-Jm; Tue, 16 Apr 2024 10:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjqK-0002YG-Ok
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjqI-0000KJ-C3
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713277883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yvCBVrfIf/N07HnBf0uLP0OCvWqPYsDlsCCdaDfn8EY=;
 b=BgNqoG7w4OsWCbFImFg2LCc9vvBRzLdjzGil1ipCOsmy4oAf4HYoMH9YE+eHlWViKdrglW
 Rt5yuP8fwuI2s+rM9pRsKJVURZnI/Gmgo9HTyzeKruES/5zOBF2Yi2EVvnQm62a4C725Jk
 GjQs6uY6dNFiY8GSsnxiZKuuQ1QNqqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-7JuUkSkoPdqBzZ7E_92rtA-1; Tue, 16 Apr 2024 10:31:21 -0400
X-MC-Unique: 7JuUkSkoPdqBzZ7E_92rtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DBFA808785;
 Tue, 16 Apr 2024 14:31:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8714910E;
 Tue, 16 Apr 2024 14:31:15 +0000 (UTC)
Date: Tue, 16 Apr 2024 15:30:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v2 08/10] i386/sev: Implement ConfidentialGuestSupport
 functions for SEV
Message-ID: <Zh6LnDrUzCw8o5ii@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <2ec365fa84338168164cdaea85050cbb022ab932.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ec365fa84338168164cdaea85050cbb022ab932.1712141833.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Wed, Apr 03, 2024 at 12:11:39PM +0100, Roy Hopkins wrote:
> The ConfidentialGuestSupport object defines a number of virtual
> functions that are called during processing of IGVM directives to query
> or configure initial guest state. In order to support processing of IGVM
> files, these functions need to be implemented by relevant isolation
> hardware support code such as SEV.
> 
> This commit implements the required functions for SEV-ES and adds
> support for processing IGVM files for configuring the guest.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  target/i386/sev.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 31dfdc3fe5..46313e7024 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -37,6 +37,7 @@
>  #include "qapi/qapi-commands-misc-target.h"
>  #include "exec/confidential-guest-support.h"
>  #include "hw/i386/pc.h"
> +#include "hw/i386/e820_memory_layout.h"
>  #include "exec/address-spaces.h"
>  
>  #define TYPE_SEV_GUEST "sev-guest"
> @@ -170,6 +171,9 @@ static const char *const sev_fw_errlist[] = {
>  
>  #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
>  
> +static int sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr,
> +                                  uint64_t len);
> +
>  static int
>  sev_ioctl(int fd, int cmd, void *data, int *error)
>  {
> @@ -304,6 +308,14 @@ sev_guest_finalize(Object *obj)
>  {
>  }
>  
> +static int cgs_check_support(ConfidentialGuestPlatformType platform,
> +                             uint16_t platform_version, uint8_t highest_vtl,
> +                             uint64_t shared_gpa_boundary)
> +{
> +    return (((platform == CGS_PLATFORM_SEV_ES) && sev_es_enabled()) ||
> +            ((platform == CGS_PLATFORM_SEV) && sev_enabled())) ? 1 : 0;
> +}
> +
>  static void sev_apply_cpu_context(CPUState *cpu)
>  {
>      SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> @@ -384,6 +396,54 @@ static void sev_apply_cpu_context(CPUState *cpu)
>      }
>  }
>  
> +static int check_vmsa_supported(const struct sev_es_save_area *vmsa)
> +{
> +    struct sev_es_save_area vmsa_check;
> +    size_t i;
> +    /*
> +     * Clear all supported fields so we can then check the entire structure
> +     * is zero.
> +     */
> +    memcpy(&vmsa_check, vmsa, sizeof(struct sev_es_save_area));
> +    memset(&vmsa_check.es, 0, sizeof(vmsa_check.es));
> +    memset(&vmsa_check.cs, 0, sizeof(vmsa_check.cs));
> +    memset(&vmsa_check.ss, 0, sizeof(vmsa_check.ss));
> +    memset(&vmsa_check.ds, 0, sizeof(vmsa_check.ds));
> +    memset(&vmsa_check.fs, 0, sizeof(vmsa_check.fs));
> +    memset(&vmsa_check.gs, 0, sizeof(vmsa_check.gs));
> +    vmsa_check.efer = 0;
> +    vmsa_check.cr0 = 0;
> +    vmsa_check.cr3 = 0;
> +    vmsa_check.cr4 = 0;
> +    vmsa_check.xcr0 = 0;
> +    vmsa_check.dr6 = 0;
> +    vmsa_check.dr7 = 0;
> +    vmsa_check.rax = 0;
> +    vmsa_check.rcx = 0;
> +    vmsa_check.rdx = 0;
> +    vmsa_check.rbx = 0;
> +    vmsa_check.rsp = 0;
> +    vmsa_check.rbp = 0;
> +    vmsa_check.rsi = 0;
> +    vmsa_check.rdi = 0;
> +    vmsa_check.r8 = 0;
> +    vmsa_check.r9 = 0;
> +    vmsa_check.r10 = 0;
> +    vmsa_check.r11 = 0;
> +    vmsa_check.r12 = 0;
> +    vmsa_check.r13 = 0;
> +    vmsa_check.r14 = 0;
> +    vmsa_check.r15 = 0;
> +    vmsa_check.rip = 0;
> +
> +    for (i = 0; i < sizeof(vmsa_check); ++i) {
> +        if (((uint8_t *)&vmsa_check)[i]) {
> +            return 0;
> +        }
> +    }
> +    return 1;

Can this just be:

   return !buffer_is_zero(vmsa_check, sizeof(vmsa_check))


> +}
> +
>  static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
>                                 uint32_t ctx_len, hwaddr gpa)
>  {
> @@ -446,6 +506,77 @@ static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
>      return 0;
>  }
>  
> +static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
> +                               ConfidentialGuestPageType memory_type,
> +                               uint16_t cpu_index, Error **errp)
> +{
> +    SevGuestState *sev = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    int ret = 1;

This results in a return '1' in some errors, but several of the callers
are checking '< 0' for the error condition. This variable is redundant
anyway, i'd suggest just putting 'return -1' calls after error_setg

> +
> +    if (!sev_enabled()) {
> +        error_setg(errp, "%s: attempt to configure guest memory, but SEV "
> +                     "is not enabled",
> +                     __func__);
> +    } else if (memory_type == CGS_PAGE_TYPE_VMSA) {
> +        if (!sev_es_enabled()) {
> +            error_setg(errp,
> +                       "%s: attempt to configure initial VMSA, but SEV-ES "
> +                       "is not supported",
> +                       __func__);
> +        } else {
> +            if (!check_vmsa_supported((const struct sev_es_save_area *)ptr)) {
> +                error_setg(errp,
> +                           "%s: The VMSA contains fields that are not "
> +                           "synchronized with KVM. Continuing would result in "
> +                           "either unpredictable guest behavior, or a "
> +                           "mismatched launch measurement.",
> +                           __func__);
> +            } else {
> +                ret = sev_set_cpu_context(cpu_index, ptr, len, gpa);

This needs to set 'errp' if 'ret' is non-zero, or assert
that it is always zer0.

> +            }
> +        }
> +    } else if ((memory_type == CGS_PAGE_TYPE_ZERO) ||
> +               (memory_type == CGS_PAGE_TYPE_NORMAL)) {
> +        ret = sev_launch_update_data(sev, ptr, len);

Likewise needs to set 'errp' or assert.

> +    } else if (memory_type != CGS_PAGE_TYPE_UNMEASURED) {
> +        error_setg(
> +            errp,
> +            "%s: attempted to configure guest memory to use memory_type %d, "
> +            "but this type is not supported",
> +            __func__, (int)memory_type);
> +    }
> +    return ret;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


