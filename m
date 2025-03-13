Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8177CC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsevQ-0004wM-BQ; Thu, 13 Mar 2025 05:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsevP-0004w3-6m
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsevI-0003qZ-GT
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741858334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ofnuw97rbI+WzhXlGRbTalwnN00fz+r3ODPZYDWqkp4=;
 b=ETOdbpAKDU8tVF96OW4wf2s0fSe5S8507nswx5uGMH1y7FmCSKzSd/PN6eU/YYH99nFV83
 FtZUHBq4JRe0Le0YE5HvPrHUyk7ULr70WI4HHnkfr/IRcLDh1Etkql50V2nPDy8ABRKzfO
 LIT1gpvfsn9ty8r5nRl3SHmnsCeURuU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Y4csQmcbNAmaV1HKBUIaOQ-1; Thu,
 13 Mar 2025 05:32:11 -0400
X-MC-Unique: Y4csQmcbNAmaV1HKBUIaOQ-1
X-Mimecast-MFC-AGG-ID: Y4csQmcbNAmaV1HKBUIaOQ_1741858330
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 314171800260; Thu, 13 Mar 2025 09:32:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580771828A98; Thu, 13 Mar 2025 09:32:08 +0000 (UTC)
Date: Thu, 13 Mar 2025 09:32:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com
Subject: Re: [PATCH] ppc/spapr: fix default cpu for pre-10.0 machines.
Message-ID: <Z9KmFPu-vplBDPcw@redhat.com>
References: <20250312055804.2134569-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312055804.2134569-1-harshpb@linux.ibm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 12, 2025 at 11:28:04AM +0530, Harsh Prateek Bora wrote:
> When POWER10 CPU was made as default, we missed keeping POWER9 as
> default for older pseries releases (pre-10.0) at that time.
> This caused breakge in default cpu evaluation for older pseries
> machines and hence this fix.
> 
> Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to POWER10 CPU")
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c15340a58d..b31a91e2e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4748,6 +4748,7 @@ static void spapr_machine_9_2_class_options(MachineClass *mc)
>  {
>      spapr_machine_10_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>  }

This doesn't make sense.

AFAICT, the commit 51113013f3 was introduced in the QEMU 9.0.0 release,
so it is correct that every machine from pseries-9.0 and newer had the
POWER10 CPU model.

What broke were the machines that already existed prior to the
9.0.0 release, whose default CPU got changed.  IOW, the pseries-8.2
and earlier machines.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


