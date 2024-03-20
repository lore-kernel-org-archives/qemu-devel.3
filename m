Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C8C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmuuk-0006Em-Ui; Wed, 20 Mar 2024 08:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmuuj-0006EN-Dl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmuuW-000117-Hx
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710937150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z+ssQQQdNxOxj9xKDlEMieDSkHVA/7a1kXcY2syiQZI=;
 b=bJqawBFLZHxPq+rhgLnRTlqsz1t2LV3txJZfN8kMaMupMYj5+O+OLUKxNsQ4D3O8YRUiuX
 7PvEHm3OFf7cN0qWs6JqiEODy0KtbRBT1lhLOJj0WW9g+sdMPZRk35jTnUjki8gBBSu8IU
 f+V7f7oqzjbD9NUYbo5LhxnoVvpfmhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530--8savm7cM3OuOBO5G4Qjsg-1; Wed, 20 Mar 2024 08:19:06 -0400
X-MC-Unique: -8savm7cM3OuOBO5G4Qjsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26464800267;
 Wed, 20 Mar 2024 12:19:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0296140C6CB3;
 Wed, 20 Mar 2024 12:19:04 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:18:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 42/49] i386/sev: Add support for SNP CPUID validation
Message-ID: <ZfrUI3yqliykklMD@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-43-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-43-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 03:39:38AM -0500, Michael Roth wrote:
> SEV-SNP firmware allows a special guest page to be populated with a
> table of guest CPUID values so that they can be validated through
> firmware before being loaded into encrypted guest memory where they can
> be used in place of hypervisor-provided values[1].
> 
> As part of SEV-SNP guest initialization, use this interface to validate
> the CPUID entries reported by KVM_GET_CPUID2 prior to initial guest
> start and populate the CPUID page reserved by OVMF with the resulting
> encrypted data.
> 
> [1] SEV SNP Firmware ABI Specification, Rev. 0.8, 8.13.2.6
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/sev.c | 159 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 

> +static void
> +sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
> +                                SnpCpuidInfo *new)
> +{
> +    size_t i;
> +
> +    if (old->count != new->count) {
> +        error_report("SEV-SNP: CPUID validation failed due to count mismatch, provided: %d, expected: %d",
> +                     old->count, new->count);
> +    }

Missing 'return' here, may result in array out of bounds on 'new->entries'
in the next loop

> +
> +    for (i = 0; i < old->count; i++) {
> +        SnpCpuidFunc *old_func, *new_func;
> +
> +        old_func = &old->entries[i];
> +        new_func = &new->entries[i];
> +
> +        if (memcmp(old_func, new_func, sizeof(SnpCpuidFunc))) {
> +            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x.\n"
> +                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x\n"
> +                         "expected: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x",
> +                         old_func->eax_in, old_func->ecx_in,
> +                         old_func->eax, old_func->ebx, old_func->ecx, old_func->edx,
> +                         new_func->eax, new_func->ebx, new_func->ecx, new_func->edx);
> +        }
> +    }
> +}
> +


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


