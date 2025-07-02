Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5105C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwHB-0000i0-75; Wed, 02 Jul 2025 08:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWwH9-0000hL-Bc
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWwH4-0004IJ-NL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751458153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ugoGxzJXmisjAtnEL82DoETJYDvzW4Wbq78NmCSX+qs=;
 b=bxbCzv858xy5VGAlFDwWJySFydYii/z61sI1l0mV49VoWsFPG9Ln4xhonoahQkz1B/s/7E
 9Xkr643yiAoVF+NJ6/3rbB7jtOcM3fqGERvGsbWDjeKQul26LeBy6Z0eJ3M2jzmYtmc3hk
 MO713ZDHaxdpiuz5AXExY9CpOnJNBYI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-v8wBTJ_uMqC5fjCoEi0b3g-1; Wed,
 02 Jul 2025 08:09:07 -0400
X-MC-Unique: v8wBTJ_uMqC5fjCoEi0b3g-1
X-Mimecast-MFC-AGG-ID: v8wBTJ_uMqC5fjCoEi0b3g_1751458144
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2762B180034E; Wed,  2 Jul 2025 12:09:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1945330001B1; Wed,  2 Jul 2025 12:08:54 +0000 (UTC)
Date: Wed, 2 Jul 2025 13:08:51 +0100
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
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] migration: Pass Error object errp into vm state
 loading functions
Message-ID: <aGUhU_Sjsp68oTWp@redhat.com>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
 <20250702-propagate_tpm_error-v3-1-986d94540528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702-propagate_tpm_error-v3-1-986d94540528@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 02, 2025 at 05:06:50PM +0530, Arun Menon wrote:
> - This is an incremental step in converting vmstate loading
>   code to report errors.
> - Minimal changes to the signature and body of the following
>   functions are done,
>   - vmstate_load()
>   - vmstate_load_state()
>   - vmstate_subsection_load()
>   - qemu_load_device_state()
>   - qemu_loadvm_state()
>   - qemu_loadvm_section_start_full()
>   - qemu_loadvm_section_part_end()
>   - qemu_loadvm_state_header()
>   - qemu_loadvm_state_main()
> - error_report() has been replaced with error_setg();
>   and in places where error has been already set,
>   error_prepend() is used to not lose information.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  hw/display/virtio-gpu.c     |   2 +-
>  hw/pci/pci.c                |   2 +-
>  hw/s390x/virtio-ccw.c       |   2 +-
>  hw/scsi/spapr_vscsi.c       |   2 +-
>  hw/vfio/pci.c               |   2 +-
>  hw/virtio/virtio-mmio.c     |   2 +-
>  hw/virtio/virtio-pci.c      |   2 +-
>  hw/virtio/virtio.c          |   4 +-
>  include/migration/vmstate.h |   2 +-
>  migration/colo.c            |  13 +++--
>  migration/cpr.c             |   2 +-
>  migration/migration.c       |  19 ++++--
>  migration/savevm.c          | 137 +++++++++++++++++++++++++++-----------------
>  migration/savevm.h          |   7 ++-
>  migration/vmstate-types.c   |  10 ++--
>  migration/vmstate.c         |  40 +++++++------
>  tests/unit/test-vmstate.c   |  18 +++---
>  17 files changed, 158 insertions(+), 108 deletions(-)
> 

> diff --git a/migration/colo.c b/migration/colo.c
> index e0f713c837f5da25d67afbd02ceb6c54024ca3af..808c980b4af3199968771cdc6cca3c2451a2f4a6 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
>  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
>  {
> +    ERRP_GUARD();
>      uint64_t total_size;
>      uint64_t value;
>      Error *local_err = NULL;
> @@ -686,11 +687,13 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>  
>      bql_lock();
>      cpu_synchronize_all_states();
> -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_err);
>      bql_unlock();
>  
>      if (ret < 0) {
> -        error_setg(errp, "Load VM's live state (ram) error");
> +        if (local_err != NULL) {
> +            error_prepend(errp, "Load VM's live state (ram) error");
> +        }

This doesn't look right to me.

The old code would unconditionally report an error, but this code
now only appends an error if 'qemu_loadvm_state_main' already
reported an error - if 'qemu_loadvm_state_main' was silent this
method reports nothing too.

IMHO this is a bad design for qemu_loadvm_state_main - when we
add an 'errp' to that method we *MUST* ensure it fills that
in *all* possible error code paths.

This code should then unconditionally use error_prepend().

>          return;
>      }
>  
> @@ -729,9 +732,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      bql_lock();
>      vmstate_loading = true;
>      colo_flush_ram_cache();
> -    ret = qemu_load_device_state(fb);
> +    ret = qemu_load_device_state(fb, &local_err);
>      if (ret < 0) {
> -        error_setg(errp, "COLO: load device state failed");
> +        if (*errp != NULL) {
> +            error_prepend(errp, "COLO: load device state failed");
> +        }

Same flawed design here - qemu_load_device_state must guarantee it always
fills its 'errp' parameter on failure code paths.

There are more instances of this general error reporting problem through
this patch

IMHO this patch is changing too many methods at once to be confident when
reviewing it.

This would be better changing 1 single method and its *immediate* callers
only.

IOW, if we have a sequence a() -> b() -> c() -> d() all of which
currently use 'error_report', don't try to change the whole call
chain at once.

First add an "errp' to 'd()', and make 'c()' use 'error_report_err'.
Then add an "errp' to 'c'()', and make 'b()' use 'error_report_err',
...repeat..

This is what I tried todo previously to address this problem in
migration code

  https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html

Though those patches are horribly outdated now, so can't be used as
is, IMHO they show the right kind of incremental conversion

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


