Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D7C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfgo-0001lJ-Kz; Wed, 24 Jul 2024 13:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfgl-0001kB-VE
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfgj-00031g-NA
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721841723;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fFWc2mCE91wGwqOmMKaNmEKI9inIaNdrgcW5ZVRdlB0=;
 b=c0J+hE3pSeWADI0VSapsswAjZHb0FfHy/GYC2SutxnIy7/wMDn82wuSUem76vpmO2lep13
 ouOv4FQ/t2lQP/eaqITU+qDT8GC8DtL0mQfCdsz2zsysb5hDxy+joRbeL/ocVKaBoucJK7
 w+y7jbuBDPsv7htSG3pyIseu/uUf3XE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Lj0Tm-wQPyK4aniu8RXSbg-1; Wed,
 24 Jul 2024 13:21:58 -0400
X-MC-Unique: Lj0Tm-wQPyK4aniu8RXSbg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1639A19560A2; Wed, 24 Jul 2024 17:21:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66AB919560AE; Wed, 24 Jul 2024 17:21:50 +0000 (UTC)
Date: Wed, 24 Jul 2024 18:21:47 +0100
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
Subject: Re: [PATCH v4 07/17] sev: Update launch_update_data functions to use
 Error handling
Message-ID: <ZqE4K1iXMOBEul9D@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <d988d0ca2eadb0594cb694b65e972164a681af8e.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d988d0ca2eadb0594cb694b65e972164a681af8e.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 03, 2024 at 12:05:45PM +0100, Roy Hopkins wrote:
> The class function and implementations for updating launch data return
> a code in case of error. In some cases an error message is generated and
> in other cases, just the error return value is used.
> 
> This small refactor adds an 'Error **errp' parameter to all functions
> which consistently set an error condition if a non-zero value is
> returned.

Ahh, OK, so you've already addressed my suggestion from the previous
patch then :-)


> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  target/i386/sev.c | 59 +++++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 491ca5369e..5eabeadda6 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -121,7 +121,8 @@ struct SevCommonStateClass {
>                                         Error **errp);
>      int (*launch_start)(SevCommonState *sev_common);
>      void (*launch_finish)(SevCommonState *sev_common);
> -    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, size_t len);
> +    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
> +                              uint8_t *ptr, size_t len, Error **errp);
>      int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
>  };
>  
> @@ -945,14 +946,16 @@ out:
>      return ret;
>  }
>  
> -static int
> -sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> -                       uint8_t *addr, size_t len)
> +static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> +                                  uint8_t *addr, size_t len, Error **errp)
>  {
>      int ret, fw_error;
>      struct kvm_sev_launch_update_data update;
>  
>      if (!addr || !len) {
> +        error_setg(errp,
> +                   "%s: Invalid parameters provided for updating launch data.",
> +                   __func__);
>          return 1;
>      }

This change I'm not too sure about. I feel like this was written to
be an intentional no-op, rather than an error. If it is supposed to
be an error then change to 'return -1' too.

>  
> @@ -962,8 +965,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>      ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
>                      &update, &fw_error);
>      if (ret) {
> -        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
> -                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
> +                   ret, fw_error, fw_error_to_str(fw_error));
>      }
>  
>      return ret;
> @@ -1091,8 +1094,8 @@ sev_launch_finish(SevCommonState *sev_common)
>      migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>  }
>  
> -static int
> -snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
> +static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
> +                                  int type, Error **errp)
>  {
>      SevLaunchUpdateData *data;
>  
> @@ -1107,13 +1110,11 @@ snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
>      return 0;
>  }
>  
> -static int
> -sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> -                           uint8_t *ptr, size_t len)
> +static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> +                                      uint8_t *ptr, size_t len, Error **errp)
>  {
> -       int ret = snp_launch_update_data(gpa, ptr, len,
> -                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> -       return ret;
> +    return snp_launch_update_data(gpa, ptr, len,
> +                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
>  }
>  
>  static int
> @@ -1165,8 +1166,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
>      return 0;
>  }
>  
> -static int
> -snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
> +static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
> +                                   size_t cpuid_len, Error **errp)
>  {
>      KvmCpuidInfo kvm_cpuid_info = {0};
>      SnpCpuidInfo snp_cpuid_info;
> @@ -1183,26 +1184,26 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
>      } while (ret == -E2BIG);
>  
>      if (ret) {
> -        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
> -                     strerror(-ret));
> +        error_setg(errp, "SEV-SNP: unable to query CPUID values for CPU: '%s'",
> +                   strerror(-ret));
>          return 1;
>      }
>  
>      ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
>      if (ret) {
> -        error_report("SEV-SNP: failed to generate CPUID table information");
> +        error_setg(errp, "SEV-SNP: failed to generate CPUID table information");
>          return 1;
>      }
>  
>      memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
>  
>      return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
> -                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
> +                                  KVM_SEV_SNP_PAGE_TYPE_CPUID, errp);
>  }
>  
> -static int
> -snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
> -                                void *hva, uint32_t len)
> +static int snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp,
> +                                           uint32_t addr, void *hva,
> +                                           uint32_t len, Error **errp)
>  {
>      int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
>      if (sev_snp->parent_obj.kernel_hashes) {
> @@ -1214,7 +1215,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
>                 sizeof(*sev_snp->kernel_hashes_data));
>          type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
>      }
> -    return snp_launch_update_data(addr, hva, len, type);
> +    return snp_launch_update_data(addr, hva, len, type, errp);
>  }
>  
>  static int
> @@ -1252,12 +1253,14 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
>          }
>  
>          if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
> -            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
> +            ret = snp_launch_update_cpuid(desc->base, hva, desc->len,
> +                                          &error_fatal);
>          } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
>              ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
> -                                                  desc->len);
> +                                                  desc->len, &error_fatal);
>          } else {
> -            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
> +            ret = snp_launch_update_data(desc->base, hva, desc->len, type,
> +                                         &error_fatal);
>          }
>  
>          if (ret) {
> @@ -1542,7 +1545,7 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
>  
>      /* if SEV is in update state then encrypt the data else do nothing */
>      if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
> -        if (klass->launch_update_data(sev_common, gpa, ptr, len)) {
> +        if (klass->launch_update_data(sev_common, gpa, ptr, len, errp)) {
>              error_setg(errp, "SEV: Failed to encrypt flash");
>              return -1;
>          }
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


