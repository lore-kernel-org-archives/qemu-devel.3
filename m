Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23891D41C1F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeee-0006X5-39; Thu, 11 Dec 2025 06:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeeb-0006U1-Bv
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeeY-00036H-I2
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765451768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGjKevl2KNgfC8tVMV5G7TSSLfkSd+O3wEhDxq6nPVM=;
 b=ejIAMV2xGKx9qasi1gfyFnRo/wDrnqz0NRgahswVdfmFYJBthEKgV2jAso0sWRuSoD1dVh
 cy+5T98slLAc3rNO2gZ3zISffdJnCjWUlJZhYIu3oG88DQbBXDBqaCEFhPEfeKCoHxoinI
 Sm0vvg+e6Ldbbe3sJKVlQ6VeLdJc7mY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-QTT-Q78QM-mQL3ppn45-qQ-1; Thu,
 11 Dec 2025 06:16:05 -0500
X-MC-Unique: QTT-Q78QM-mQL3ppn45-qQ-1
X-Mimecast-MFC-AGG-ID: QTT-Q78QM-mQL3ppn45-qQ_1765451763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1778C1956058; Thu, 11 Dec 2025 11:16:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 003FD1953984; Thu, 11 Dec 2025 11:16:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A65161800608; Thu, 11 Dec 2025 12:15:59 +0100 (CET)
Date: Thu, 11 Dec 2025 12:15:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 3/3] igvm: Fill MADT IGVM parameter field
Message-ID: <h4256m67shwdq4aouxpqadb2zozhq2f5dfeo74c5jnet5f26kz@a3av5xjfyfow>
References: <20251211103136.1578463-1-osteffen@redhat.com>
 <20251211103136.1578463-4-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211103136.1578463-4-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> +static int qigvm_initialization_madt(QIgvm *ctx,
> +                                     const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
> +    QIgvmParameterData *param_entry;
> +
> +    if (ctx->madt == NULL) {
> +        return 0;
> +    }
> +
> +    /* Find the parameter area that should hold the device tree */

cut+paste error in the comment.

> +    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
> +    {
> +        if (param_entry->index == param->parameter_area_index) {

Hmm, that is a pattern repeated a number of times already in the igvm
code.  Should we factor that out into a helper function?

>  static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>  {
>      int32_t header_count;
> @@ -892,7 +925,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
>  }
>  
>  int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> -                       bool onlyVpContext, Error **errp)
> +                       bool onlyVpContext, GArray *madt, Error **errp)

I'd like to see less parameters for this function, not more.

I think sensible options here are:

  (a) store the madt pointer in IgvmCfg, or
  (b) pass MachineState instead of ConfidentialGuestSupport, so
      we can use the MachineState here to generate the madt.

Luigi, any opinion?  I think device tree support will need access to
MachineState too, and I think both madt and dt should take the same
approach here.

Long-term I'd like to also get rid of the onlyVpContext parameter.
That cleanup is something for another patch series though.

take care,
  Gerd


