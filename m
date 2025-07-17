Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE0C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTs9-0001ct-QK; Thu, 17 Jul 2025 15:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRGV-0006iu-1E
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRGM-0003Kc-1C
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768912;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YhQQovLiBz7bLkEiiWW9mfj+5Zj5EDVfGKoHYmnOE4Q=;
 b=CSGzkSrMvhz4EeaB4fY7Lyzm57h88+N7wuiNY3ul+pM/BmfXI/h6aIbUaJaiFu4UJxND29
 wBINAwrcPRPACc2an983ABL/9kZl0+rY1fwlXuk69B6BVDlU3hjP8e6lPAJqwnSquZBW9H
 77uzHfgETdV4J2j3YuwK2FZ5QO6O0LU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-XC8EHIZZPoOsgxqOKhKsqw-1; Thu,
 17 Jul 2025 12:15:09 -0400
X-MC-Unique: XC8EHIZZPoOsgxqOKhKsqw-1
X-Mimecast-MFC-AGG-ID: XC8EHIZZPoOsgxqOKhKsqw_1752768904
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 465FD1800294; Thu, 17 Jul 2025 16:15:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57CA91956089; Thu, 17 Jul 2025 16:14:52 +0000 (UTC)
Date: Thu, 17 Jul 2025 17:14:49 +0100
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
Subject: Re: [PATCH v5 01/23] migration: push Error **errp into
 vmstate_subsection_load()
Message-ID: <aHkheTMZ25I7QAfR@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-1-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-propagate_tpm_error-v5-1-1f406f88ee65@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 06:07:24AM +0530, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_subsection_load() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/vmstate.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 5feaa3244d259874f03048326b2497e7db32e47c..526668a020562f303d2ddf030b1c8466659b67be 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>                                     void *opaque, JSONWriter *vmdesc,
>                                     Error **errp);
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> -                                   void *opaque);
> +                                   void *opaque, Error **errp);
>  
>  /* Whether this field should exist for either save or load the VM? */
>  static bool
> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          field++;
>      }
>      assert(field->flags == VMS_END);
> -    ret = vmstate_subsection_load(f, vmsd, opaque);
> +    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
>      if (ret != 0) {
>          qemu_file_set_error(f, ret);
>          return ret;
> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
>  }
>  
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> -                                   void *opaque)
> +                                   void *opaque, Error **errp)
>  {
>      trace_vmstate_subsection_load(vmsd->name);
>  
> @@ -598,6 +598,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>          sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>          if (sub_vmsd == NULL) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
> +            error_setg(errp, "VM subsection does not exist");

Lets include the contextual details

           error_setg(errp, "VM subsection '%s' in '%s' does not exist", idstr, vmsd->name);

>              return -ENOENT;
>          }
>          qemu_file_skip(f, 1); /* subsection */
> @@ -608,6 +609,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>          ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
>          if (ret) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
> +            error_setg(errp, "Loading VM subsection failed : %d", ret);

           error_setg(errp, "Loading VM subsection '%s' in '%s' failed : %d", idstr, vmsd->name, ret);

>              return ret;
>          }
>      }

In general this method puzzles me. There are four places where we call
trace_vmstate_subsection_load_bad() whose name indicates it is for an
error condition.

The first two places, however, then 'return 0' to the caller indicating
success, which looks inconsistent with the trace point. Assuming that
is correct though, then your patch is also correct in only adding error
reports to these two places.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


