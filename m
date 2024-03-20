Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C7CCD11DC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmv8J-0005Dz-ED; Wed, 20 Mar 2024 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmv8I-00058Q-1Z
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmv8F-0005Nf-Kf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710938003;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LI54pxdGKEWVTWxWzs7S5KmA8mpkqqZDrOFVx2kvCH0=;
 b=egAZAaNh5rZHFPSns2pKudBzvKyzU66QSJmp4Z0TklCXn2Z9FtHF2NO2O/IY/Vgvco9JaV
 T9S96NpqZaZwyIPrnxQVJt+pNrCwcIKfStMWJNoM3gky8wie/y1ktAcYD4O/VB0Lfo5QyA
 EK3STXXoz/r/pntM0+v50oJARghgmFc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-URfAf05JNkG4lG_Pftr4Uw-1; Wed,
 20 Mar 2024 08:33:17 -0400
X-MC-Unique: URfAf05JNkG4lG_Pftr4Uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EE8F1C54460;
 Wed, 20 Mar 2024 12:33:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A69112132A;
 Wed, 20 Mar 2024 12:33:15 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:33:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 29/49] i386/sev: Don't disable block discarding for SNP
Message-ID: <ZfrXhhfvVEzPKMc5@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-30-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-30-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 20, 2024 at 03:39:25AM -0500, Michael Roth wrote:
> SEV/SEV-ES rely on pinned memory to back guest RAM so discarding
> isn't actually possible. With SNP, only guest_memfd pages are used
> for private guest memory, so discarding of shared memory is still
> possible, so only disable discard for SEV/SEV-ES.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/sev.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 134e8f7c22..43e6c0172f 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -888,10 +888,18 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>      uint32_t host_cbitpos;
>      struct sev_user_data_status status = {};
>  
> -    ret = ram_block_discard_disable(true);
> -    if (ret) {
> -        error_report("%s: cannot disable RAM discard", __func__);
> -        return -1;
> +    /*
> +     * SEV/SEV-ES rely on pinned memory to back guest RAM so discarding
> +     * isn't actually possible. With SNP, only guest_memfd pages are used
> +     * for private guest memory, so discarding of shared memory is still
> +     * possible..
> +     */
> +    if (!sev_snp_enabled()) {
> +        ret = ram_block_discard_disable(true);
> +        if (ret) {
> +            error_report("%s: cannot disable RAM discard", __func__);
> +            return -1;
> +        }
>      }

Pre-existing code bug, but this method must use 'error_setg' to fill
the 'Error **errp' parameter.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


