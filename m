Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0835C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmuqm-00039M-Ew; Wed, 20 Mar 2024 08:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmuqj-000392-3o
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmuqg-0008MD-P3
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710936911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=V9NFEISS+7LkO+X3NM8SEQ5cL8nXFeBIf+Ti9rAUnFw=;
 b=Sn7BoaDgERWaSnvs7LJQhnOXw9YWfmq7V0N82+fgI7szqgEljr+EcnEGVu6T4XAwCZNtYA
 wnO9bITPZlgDMw/hyzrCzL4+AJbU7BKOea31yvEaF+0QKBLkwy4RV8qfw68Uzv5pIbTxSB
 41WC8qalqlxbF4ACLoUbKFBN4aT0ABE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-re6iepRVMdaltkouaNRPiw-1; Wed, 20 Mar 2024 08:15:07 -0400
X-MC-Unique: re6iepRVMdaltkouaNRPiw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3717B80026D;
 Wed, 20 Mar 2024 12:15:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC6E6492BD0;
 Wed, 20 Mar 2024 12:15:05 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:15:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 32/49] i386/sev: Don't return launch measurements for
 SEV-SNP guests
Message-ID: <ZfrTQyEHrxXBq1nB@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-33-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-33-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On Wed, Mar 20, 2024 at 03:39:28AM -0500, Michael Roth wrote:
> For SEV-SNP guests, launch measurement is queried from within the guest
> during attestation, so don't attempt to return it as part of
> query-sev-launch-measure.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/sev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index b03d70a3d1..0c8e4bdb4c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -803,7 +803,9 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
>  
>  static char *sev_get_launch_measurement(void)
>  {
> -    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
> +    SevGuestState *sev_guest =
> +        (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
>  
>      if (sev_guest &&
>          SEV_COMMON(sev_guest)->state >= SEV_STATE_LAUNCH_SECRET) {

The QAPI docs for query-sev-launch-measurement should be updated
to reflect that this command is only valid to call for SEV/SEV-ES,
not SNP.

The error reoprting in qmp_query_sev_launch_measure leaves a little
to be desired just giving a generic message

   "SEV launch measurement is not available"

I think that this sev_get_launch_measurement method should report
a more fine grained error, to distinguish

  * Unavailable because we're not a SEV/SEV-ES guest
  * Unavailable because the guest hasn't reached launch state

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


