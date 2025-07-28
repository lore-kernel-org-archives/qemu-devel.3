Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA01C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJmY-0006xK-1K; Mon, 28 Jul 2025 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugJkR-0004ZQ-Og
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugJkM-0007Gr-4H
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753693331;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNpRk9P3NXPzAiV2/QmCY8/O42SU3SmfS6vtwyLMsyA=;
 b=EutIHVrDq+oix50YRFvCtSpRo15Q3Ss1Q/ZJlJyW/J10pitB+1c58KNWEaIitnAmL12X+R
 87yvshD8emwZ2eFo31vGH1+MgejgLlKbswJA2pddaM49l9s9ax+Bm+bMFsVEwVvKfhISMh
 p/s/F7H+xlOhZeIa6tRh7c9cKKFUjCQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88--pIYNZAcNfaKMR0QWPVPGQ-1; Mon,
 28 Jul 2025 05:02:07 -0400
X-MC-Unique: -pIYNZAcNfaKMR0QWPVPGQ-1
X-Mimecast-MFC-AGG-ID: -pIYNZAcNfaKMR0QWPVPGQ_1753693324
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8CCD180028F; Mon, 28 Jul 2025 09:02:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16F7A19560A2; Mon, 28 Jul 2025 09:01:53 +0000 (UTC)
Date: Mon, 28 Jul 2025 10:01:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v7 01/24] migration: push Error **errp into
 vmstate_subsection_load()
Message-ID: <aIc8fjnoA_G8iCqZ@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
 <CAMxuvaznYbcpxc7dtDP5yVBzVcDJpVWVXHeWxB1zo0bfdBuw2g@mail.gmail.com>
 <CAMxuvawsX6ePZV=ek7d0rDwpJYQJmNwiFKhTetLW6u1PW6cTbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawsX6ePZV=ek7d0rDwpJYQJmNwiFKhTetLW6u1PW6cTbA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 28, 2025 at 12:44:53PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 25, 2025 at 5:46 PM Marc-André Lureau <
> marcandre.lureau@redhat.com> wrote:
> 
> >
> >
> > On Fri, Jul 25, 2025 at 4:19 PM Arun Menon <armenon@redhat.com> wrote:
> >
> >> This is an incremental step in converting vmstate loading
> >> code to report error via Error objects instead of directly
> >> printing it to console/monitor.
> >> It is ensured that vmstate_subsection_load() must report an error
> >> in errp, in case of failure.
> >>
> >> Signed-off-by: Arun Menon <armenon@redhat.com>
> >> ---
> >>  migration/vmstate.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> index
> >> 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f2747906ddf9aca891b
> >> 100644
> >> --- a/migration/vmstate.c
> >> +++ b/migration/vmstate.c
> >> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>                                     void *opaque, JSONWriter *vmdesc,
> >>                                     Error **errp);
> >>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription
> >> *vmsd,
> >> -                                   void *opaque);
> >> +                                   void *opaque, Error **errp);
> >>
> >>  /* Whether this field should exist for either save or load the VM? */
> >>  static bool
> >> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>          field++;
> >>      }
> >>      assert(field->flags == VMS_END);
> >> -    ret = vmstate_subsection_load(f, vmsd, opaque);
> >> +    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> >>      if (ret != 0) {
> >>          qemu_file_set_error(f, ret);
> >>          return ret;
> >> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription *
> >> const *sub,
> >>  }
> >>
> >>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription
> >> *vmsd,
> >> -                                   void *opaque)
> >> +                                   void *opaque, Error **errp)
> >>  {
> >>      trace_vmstate_subsection_load(vmsd->name);
> >>
> >> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>          sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
> >>          if (sub_vmsd == NULL) {
> >>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> >> "(lookup)");
> >> +            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
> >> +                       idstr, vmsd->name);
> >>              return -ENOENT;
> >>          }
> >>          qemu_file_skip(f, 1); /* subsection */
> >> @@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>          ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
> >>          if (ret) {
> >>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> >> "(child)");
> >> +            error_setg(errp,
> >> +                       "Loading VM subsection '%s' in '%s' failed : %d",
> >>
> >
> > extra space before ":"
> >
> > other than that
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> 
> Actually, almost systematically when you introduce an extra **errp
> argument, you should ERRP_GUARD() in the function (see include/qapi/error.h
> doc). Was this discussed before? Can you update the following patches too?

ERRP_GUARD is only needed in functions which derefence errp, which should
very rarely be needed when all functions are non-void return value.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


