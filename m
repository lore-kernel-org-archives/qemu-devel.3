Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A753AC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucoSJ-0000eI-Nm; Fri, 18 Jul 2025 13:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucnw1-0003je-Ot
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 12:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucnvz-0008LH-8u
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 12:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752856061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yhsa/OTDvj8NcOAJ2aL4ccWLXI29v/DHK5ksiaxbRe8=;
 b=F0WzAFY62d3uxJIPrbdE4CzmAUlRhm1qnEB02m5EbtZVYaduYlZvGfp9FHlaV8I4AjczaR
 7HwwYir/Bmaw0cof7kIQmiWKf2U/0bS5JL1Q1nbOUmvoi7ihzelGaDv/ICeN6mV1tGgYME
 XxOyyDrZkRV8n4rmB1U9KJzna2vMt7c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-q4y79fq7OWyjnNbQ2NRxhw-1; Fri, 18 Jul 2025 12:27:38 -0400
X-MC-Unique: q4y79fq7OWyjnNbQ2NRxhw-1
X-Mimecast-MFC-AGG-ID: q4y79fq7OWyjnNbQ2NRxhw_1752856058
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-748fd21468cso2227618b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 09:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856058; x=1753460858;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yhsa/OTDvj8NcOAJ2aL4ccWLXI29v/DHK5ksiaxbRe8=;
 b=J3FkfekRrxvBdABbgsFf7kzRMu5B0yjieyUgXGhtdgUkN5608QyQ4kU6pIl9n2Doum
 j5/eu7acQuSzMZecGkL+TpeBtruI9UhJO0rlzuHOTzLW7HbABr5xJGbEQ+QKA4PXdS4e
 tj1Ewkhkt2j6vhCmT5xgJcMTCSj7ROHd7gc/63NO+y9jdhrwAMnsPcg2ZPZvsjri9s9o
 xp8tYpvqPAsvtTQ1H3Rii93unHqVRWsfnLlZvxxWVww7bWjqyxjX8OZs4WSE3xfbUCh4
 Y2c1GR+KCwLwHNmcgRGcHmxDy4L7+ZKu+eUWBtUKiBM4pRZFrx/a94AgI247BKw4ICue
 TJTQ==
X-Gm-Message-State: AOJu0YzansLIR/dV74FG84JGZVV/IdZYD49/4OZQlVHEq7zLbt39IOLr
 DzTRk/UnXISRWptwYZdKhYcZ+oEqsYZW0d+N0bA3kFpLTcXua/ZGpXmm6FKRhxTsNdFw0HzkjVI
 0nCfo49JijUeyUgw92hDGraQI1MjO/WTwgRfelFEoQreZiX6E0XaIsnVP
X-Gm-Gg: ASbGncu/mEwirxUls6XKZx+JzECTbgUiIrEfU+8ZAWXRtoo9RTbubOGmD3+TkyjVuTS
 TYgzJM4kSeKdmyXjnhrg8uN7IzB5UvUDSn/y2eU1V6YZiQkZ2wF+FpCKLVW6CTHh8Nx5azPUa7q
 XPZR8gbP52iosRYkgVxq0dL35s0gsCHyi2ct3R2vH2aCaaWq9ifFAbtSNyEp27YpfXkaMJrvdMO
 KIB9xSPy9oybrGv2qyJVNI4IKN3hesH7AtxH4GlaJLscyYluwDJ4vDatd4rgYyIvItjrGngfvYu
 yAn/dDB4d2AyinuQPT55Ymfr0w0qs/6p6VbFAWKlXhXXYf9a59Vo
X-Received: by 2002:a05:6a21:33a1:b0:21c:faa4:9ab8 with SMTP id
 adf61e73a8af0-237d5a03207mr18004338637.10.1752856057858; 
 Fri, 18 Jul 2025 09:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG6Fu8Dsf8tLWUujK070jRPsMUsF1rUOqhbKG220F+Bm1PopxGHCL65mRrPLPAsCJdfpfcGg==
X-Received: by 2002:a05:6a21:33a1:b0:21c:faa4:9ab8 with SMTP id
 adf61e73a8af0-237d5a03207mr18004289637.10.1752856057383; 
 Fri, 18 Jul 2025 09:27:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c84e20b7sm1519577b3a.28.2025.07.18.09.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:27:36 -0700 (PDT)
Date: Fri, 18 Jul 2025 21:57:26 +0530
From: Arun Menon <armenon@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v5 02/23] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aHp17rw4JhKzX1YT@armenon-kvm.bengluru.csb>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-2-1f406f88ee65@redhat.com>
 <aHkljmIk5lTbmumj@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHkljmIk5lTbmumj@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

Thank you so much for the review.

On Thu, Jul 17, 2025 at 05:32:14PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jul 17, 2025 at 06:07:25AM +0530, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that vmstate_load_state() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  hw/display/virtio-gpu.c     |  2 +-
> >  hw/pci/pci.c                |  2 +-
> >  hw/s390x/virtio-ccw.c       |  2 +-
> >  hw/scsi/spapr_vscsi.c       |  2 +-
> >  hw/vfio/pci.c               |  2 +-
> >  hw/virtio/virtio-mmio.c     |  2 +-
> >  hw/virtio/virtio-pci.c      |  2 +-
> >  hw/virtio/virtio.c          |  4 ++--
> >  include/migration/vmstate.h |  2 +-
> >  migration/cpr.c             |  4 ++--
> >  migration/savevm.c          |  6 ++++--
> >  migration/vmstate-types.c   | 10 +++++-----
> >  migration/vmstate.c         | 43 +++++++++++++++++++++++++++----------------
> >  tests/unit/test-vmstate.c   | 18 +++++++++---------
> >  ui/vdagent.c                |  2 +-
> >  15 files changed, 58 insertions(+), 45 deletions(-)
> > 
> 
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 526668a020562f303d2ddf030b1c8466659b67be..078a00003023cc248fb16f05017d4c4251fd86df 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -132,29 +132,30 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
> >  }
> >  
> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > -                       void *opaque, int version_id)
> > +                       void *opaque, int version_id, Error **errp)
> >  {
> >      const VMStateField *field = vmsd->fields;
> >      int ret = 0;
> >  
> >      trace_vmstate_load_state(vmsd->name, version_id);
> >      if (version_id > vmsd->version_id) {
> > -        error_report("%s: incoming version_id %d is too new "
> > -                     "for local version_id %d",
> > -                     vmsd->name, version_id, vmsd->version_id);
> > +        error_setg(errp, "%s: incoming version_id %d is too new "
> > +                   "for local version_id %d",
> > +                   vmsd->name, version_id, vmsd->version_id);
> >          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
> >          return -EINVAL;
> >      }
> >      if  (version_id < vmsd->minimum_version_id) {
> > -        error_report("%s: incoming version_id %d is too old "
> > -                     "for local minimum version_id  %d",
> > -                     vmsd->name, version_id, vmsd->minimum_version_id);
> > +        error_setg(errp, "%s: incoming version_id %d is too old "
> > +                   "for local minimum version_id  %d",
> > +                   vmsd->name, version_id, vmsd->minimum_version_id);
> >          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >          return -EINVAL;
> >      }
> >      if (vmsd->pre_load) {
> >          ret = vmsd->pre_load(opaque);
> >          if (ret) {
> > +            error_setg(errp, "VM pre load failed : %d", ret);
> 
> Suggest including
> 
>   vmsd->name, version_id, vmsd->minimum_version_id
> 
> as those are all relevant context which may aid in diagnosing
> this error.
> 
> >              return ret;
> >          }
> >      }
> > @@ -192,10 +193,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >  
> >                  if (inner_field->flags & VMS_STRUCT) {
> >                      ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> > -                                             inner_field->vmsd->version_id);
> > +                                             inner_field->vmsd->version_id,
> > +                                             errp);
> >                  } else if (inner_field->flags & VMS_VSTRUCT) {
> >                      ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> > -                                             inner_field->struct_version_id);
> > +                                             inner_field->struct_version_id,
> > +                                             errp);
> >                  } else {
> >                      ret = inner_field->info->get(f, curr_elem, size,
> >                                                   inner_field);
> 
> This should have the "error_setg" call, so...

About this. I saw few 'get' functions that does not have error_setg() call,
for example vhost_user_net_load_state() or get_fpscr() function calls.
I was not sure, therefore I covered both the cases.
Now I think they do satisfy the if/else if clauses.
Please correct me if I am wrong.

> 
> > @@ -211,27 +214,35 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                  }
> >                  if (ret < 0) {
> >                      qemu_file_set_error(f, ret);
> > -                    error_report("Failed to load %s:%s", vmsd->name,
> > -                                 field->name);
> > +                    if (errp != NULL) {
> > +                        error_prepend(errp, "Failed to load %s:%s ", vmsd->name,
> > +                                      field->name);
> > +                    } else {
> > +                        error_setg(errp, "Failed to load %s:%s", vmsd->name,
> > +                                   field->name);
> > +                    }
> 
> ...this should exclusively do error_prepend.
> 
> Also include the 'version_id' here as an bit of extra context.
Yes.
> 
> >                      trace_vmstate_load_field_error(field->name, ret);
> >                      return ret;
> >                  }
> >              }
> >          } else if (field->flags & VMS_MUST_EXIST) {
> > -            error_report("Input validation failed: %s/%s",
> > -                         vmsd->name, field->name);
> > +            error_setg(errp, "Input validation failed: %s/%s",
> > +                       vmsd->name, field->name);
> 
> 
> Inlucde the version_id too
Yes.
> 
> >              return -1;
> >          }
> >          field++;
> >      }
> >      assert(field->flags == VMS_END);
> > -    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> > +    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
> >      if (ret != 0) {
> >          qemu_file_set_error(f, ret);
> >          return ret;
> >      }
> >      if (vmsd->post_load) {
> >          ret = vmsd->post_load(opaque, version_id);
> > +        if (ret < 0) {
> > +            error_setg(errp, "VM Post load failed : %d", ret);
> > +        }
> 
> Suggest including
> 
>   vmsd->name, version_id, vmsd->minimum_version_id

Agreed.
> 
> 
> >      }
> >      trace_vmstate_load_state_end(vmsd->name, "end", ret);
> >      return ret;
> 
> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
Regards,
Arun


