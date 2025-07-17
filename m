Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17472C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucU9T-0004Ig-HK; Thu, 17 Jul 2025 15:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRXB-0008AT-PA
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRX8-0005co-QY
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752769953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=65/LOSSnuz26QTJtZP9R5d8KCo2BtuXFDpSCPc/v0L8=;
 b=hFm1teK1rusu1HTclTSgBsdMhIBgSCyIK0qC+M0m4/ig1rx6cXDOQQfZg+G/rNf8WhwrfF
 ac281Z7+QBtz5CmEy/edDMqXihWQnloQtS0KVqe0imFeeUCOG5aUW17nA0tPUEmf0ripuh
 jufYJeXtUMqYgcUltBu5UEkbyuKbL5Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-a51U89TUOy-O4sBPF1a1Qg-1; Thu,
 17 Jul 2025 12:32:30 -0400
X-MC-Unique: a51U89TUOy-O4sBPF1a1Qg-1
X-Mimecast-MFC-AGG-ID: a51U89TUOy-O4sBPF1a1Qg_1752769948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52AFA1800EEF; Thu, 17 Jul 2025 16:32:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DE8E180049D; Thu, 17 Jul 2025 16:32:17 +0000 (UTC)
Date: Thu, 17 Jul 2025 17:32:14 +0100
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
Subject: Re: [PATCH v5 02/23] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aHkljmIk5lTbmumj@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-2-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-propagate_tpm_error-v5-2-1f406f88ee65@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, Jul 17, 2025 at 06:07:25AM +0530, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load_state() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  hw/display/virtio-gpu.c     |  2 +-
>  hw/pci/pci.c                |  2 +-
>  hw/s390x/virtio-ccw.c       |  2 +-
>  hw/scsi/spapr_vscsi.c       |  2 +-
>  hw/vfio/pci.c               |  2 +-
>  hw/virtio/virtio-mmio.c     |  2 +-
>  hw/virtio/virtio-pci.c      |  2 +-
>  hw/virtio/virtio.c          |  4 ++--
>  include/migration/vmstate.h |  2 +-
>  migration/cpr.c             |  4 ++--
>  migration/savevm.c          |  6 ++++--
>  migration/vmstate-types.c   | 10 +++++-----
>  migration/vmstate.c         | 43 +++++++++++++++++++++++++++----------------
>  tests/unit/test-vmstate.c   | 18 +++++++++---------
>  ui/vdagent.c                |  2 +-
>  15 files changed, 58 insertions(+), 45 deletions(-)
> 

> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 526668a020562f303d2ddf030b1c8466659b67be..078a00003023cc248fb16f05017d4c4251fd86df 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -132,29 +132,30 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
>  }
>  
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id)
> +                       void *opaque, int version_id, Error **errp)
>  {
>      const VMStateField *field = vmsd->fields;
>      int ret = 0;
>  
>      trace_vmstate_load_state(vmsd->name, version_id);
>      if (version_id > vmsd->version_id) {
> -        error_report("%s: incoming version_id %d is too new "
> -                     "for local version_id %d",
> -                     vmsd->name, version_id, vmsd->version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too new "
> +                   "for local version_id %d",
> +                   vmsd->name, version_id, vmsd->version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>          return -EINVAL;
>      }
>      if  (version_id < vmsd->minimum_version_id) {
> -        error_report("%s: incoming version_id %d is too old "
> -                     "for local minimum version_id  %d",
> -                     vmsd->name, version_id, vmsd->minimum_version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too old "
> +                   "for local minimum version_id  %d",
> +                   vmsd->name, version_id, vmsd->minimum_version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
>      if (vmsd->pre_load) {
>          ret = vmsd->pre_load(opaque);
>          if (ret) {
> +            error_setg(errp, "VM pre load failed : %d", ret);

Suggest including

  vmsd->name, version_id, vmsd->minimum_version_id

as those are all relevant context which may aid in diagnosing
this error.

>              return ret;
>          }
>      }
> @@ -192,10 +193,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>  
>                  if (inner_field->flags & VMS_STRUCT) {
>                      ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> -                                             inner_field->vmsd->version_id);
> +                                             inner_field->vmsd->version_id,
> +                                             errp);
>                  } else if (inner_field->flags & VMS_VSTRUCT) {
>                      ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> -                                             inner_field->struct_version_id);
> +                                             inner_field->struct_version_id,
> +                                             errp);
>                  } else {
>                      ret = inner_field->info->get(f, curr_elem, size,
>                                                   inner_field);

This should have the "error_setg" call, so...

> @@ -211,27 +214,35 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                  }
>                  if (ret < 0) {
>                      qemu_file_set_error(f, ret);
> -                    error_report("Failed to load %s:%s", vmsd->name,
> -                                 field->name);
> +                    if (errp != NULL) {
> +                        error_prepend(errp, "Failed to load %s:%s ", vmsd->name,
> +                                      field->name);
> +                    } else {
> +                        error_setg(errp, "Failed to load %s:%s", vmsd->name,
> +                                   field->name);
> +                    }

...this should exclusively do error_prepend.

Also include the 'version_id' here as an bit of extra context.

>                      trace_vmstate_load_field_error(field->name, ret);
>                      return ret;
>                  }
>              }
>          } else if (field->flags & VMS_MUST_EXIST) {
> -            error_report("Input validation failed: %s/%s",
> -                         vmsd->name, field->name);
> +            error_setg(errp, "Input validation failed: %s/%s",
> +                       vmsd->name, field->name);


Inlucde the version_id too

>              return -1;
>          }
>          field++;
>      }
>      assert(field->flags == VMS_END);
> -    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> +    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
>      if (ret != 0) {
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
>      if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
> +        if (ret < 0) {
> +            error_setg(errp, "VM Post load failed : %d", ret);
> +        }

Suggest including

  vmsd->name, version_id, vmsd->minimum_version_id


>      }
>      trace_vmstate_load_state_end(vmsd->name, "end", ret);
>      return ret;



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


