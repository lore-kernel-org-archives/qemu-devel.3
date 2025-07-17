Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BB8C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUsf-0003pO-7o; Thu, 17 Jul 2025 16:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucSU9-00063s-Aw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucSU5-0005rv-ML
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752773608;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=An8hRqXygYhUmSPCxGlxURl7Vf5y5rzkOFQ4l+1cpXU=;
 b=SwQyFMWrusshmRGfUYb7chcM1sACvLLBO7uovT3emjYs4ViaciRWbN1NJsTV6c9ufiIuza
 ZamIxHyx+//KzyVxDXfjjZClVk4MxUspBepA3u54Epu2/yHjhI+rKIjJkz+3r4PSW9z1ww
 yXgm2ufwfY8EJiFbd5xVfxTFA3504H4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-wwImG5SZNzCNMbrP21lfGA-1; Thu,
 17 Jul 2025 13:33:24 -0400
X-MC-Unique: wwImG5SZNzCNMbrP21lfGA-1
X-Mimecast-MFC-AGG-ID: wwImG5SZNzCNMbrP21lfGA_1752773601
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC0B1800281; Thu, 17 Jul 2025 17:33:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CEF930001B1; Thu, 17 Jul 2025 17:33:11 +0000 (UTC)
Date: Thu, 17 Jul 2025 18:33:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v5 21/23] migration: Capture error in
 postcopy_ram_listen_thread()
Message-ID: <aHkz1JSTB20Me4yY@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-21-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-propagate_tpm_error-v5-21-1f406f88ee65@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 17, 2025 at 06:07:44AM +0530, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> to load the vm, and in case of a failure, it should set the error
> in the migration object.
> 
> When postcopy live migration runs, the device states are loaded by
> both the qemu coroutine process_incoming_migration_co() and the
> postcopy_ram_listen_thread(). Therefore, it is important that the
> coroutine also reports the error in case of failure, with
> error_report_err(). Otherwise, the source qemu will not display
> any errors before going into the postcopy pause state.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/migration.c |  2 +-
>  migration/savevm.c    | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 


> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0fff65c96344c65191353311e72730cd6e3bfb23..4f67eebe5321c175d51e8029e36ceb336c98ad1f 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2086,6 +2086,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>      QEMUFile *f = mis->from_src_file;
>      int load_res;
>      MigrationState *migr = migrate_get_current();
> +    Error *local_err = NULL;
>  
>      object_ref(OBJECT(migr));
>  
> @@ -2102,7 +2103,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>      qemu_file_set_blocking(f, true);
>  
>      /* TODO: sanity check that only postcopiable data will be loaded here */
> -    load_res = qemu_loadvm_state_main(f, mis, NULL);
> +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
>  
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2128,7 +2129,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
>                           __func__, load_res);
>              load_res = 0; /* prevent further exit() */
>          } else {
> -            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            if (local_err != NULL) {
> +                error_prepend(&local_err, "%s: loadvm failed: %d", __func__,
> +                              load_res);

IMHO __func__ is redundant if you change the message
to be 'loadvm failed during postcopy' like the earlier part
fo the "if { " does.

> +                migrate_set_error(migr, local_err);
> +                error_report_err(local_err);
> +            }
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                             MIGRATION_STATUS_FAILED);

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


