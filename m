Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A6DC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUzs-0000w7-6z; Thu, 17 Jul 2025 16:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucSXi-0000Y4-6q
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucSXf-0006S1-5Y
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752773830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QABn+PyJ6yO1AL8f5+dUn7j/wEoCfHBb3tjHt39noew=;
 b=WHk4MFo6P5PHoaH0xLgiDgmia0X+w9cdmxfZYnpehIrwwrGNpEr+ffVFOF8/IhZzstwjNR
 oS+QqrAlKCk7niH6XQQpkya2+cbQSAW5IjiPQFJCGdSz7CpYHFNw7cEOSsB0Cccpmyvusz
 5cptfxjmMePPrh7MJsN87rBjjPBygw0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-z6n0XaHBPHCMO21qUBMTew-1; Thu,
 17 Jul 2025 13:37:06 -0400
X-MC-Unique: z6n0XaHBPHCMO21qUBMTew-1
X-Mimecast-MFC-AGG-ID: z6n0XaHBPHCMO21qUBMTew_1752773824
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF023195FD06; Thu, 17 Jul 2025 17:37:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D781956089; Thu, 17 Jul 2025 17:36:55 +0000 (UTC)
Date: Thu, 17 Jul 2025 18:36:52 +0100
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
Subject: Re: [PATCH v5 22/23] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aHk0tEOhhoRfVsxE@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-22-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-propagate_tpm_error-v5-22-1f406f88ee65@redhat.com>
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

On Thu, Jul 17, 2025 at 06:07:45AM +0530, Arun Menon wrote:
> - We need to have good error reporting in the callbacks in
>   VMStateDescription struct. Specifically pre_save, post_save,
>   pre_load and post_load callbacks.
> - It is not possible to change these functions everywhere in one
>   patch, therefore, we introduce a duplicate set of callbacks
>   with Error object passed to them.
> - So, in this commit, we implement 'errp' variants of these callbacks,
>   introducing an explicit Error object parameter.
> - This is a functional step towards transitioning the entire codebase
>   to the new error-parameterized functions.
> - Deliberately called in mutual exclusion from their counterparts,
>   to prevent conflicts during the transition.
> - New impls should preferentally use 'errp' variants of
>   these methods, and existing impls incrementally converted.
>   The variants without 'errp' are intended to be removed
>   once all usage is converted.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  include/migration/vmstate.h | 11 +++++++++++
>  migration/vmstate.c         | 36 +++++++++++++++++++++++++++++++-----
>  2 files changed, 42 insertions(+), 5 deletions(-)


> @@ -524,7 +542,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (ret) {
>                      error_setg(errp, "Save of field %s/%s failed",
>                                  vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> +                    if (vmsd->post_save_errp) {
> +                        vmsd->post_save_errp(opaque, errp);

We are already in an error path here, and we set 'errp' just a few lines
above. If post_save_errp tries to set it too, then we're doomed.

You'll need to pass an &Local_err in here, and then append it to the
current error.

> +                    } else if (vmsd->post_save) {
>                          vmsd->post_save(opaque);
>                      }
>                      return ret;
> @@ -552,7 +572,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);


Potentially set 'errp'



> -    if (vmsd->post_save) {
> +    if (vmsd->post_save_errp) {
> +        int ps_ret = vmsd->post_save_errp(opaque, errp);

so must not be passing 'errp' here.

> +        if (!ret && ps_ret) {
> +            ret = ps_ret;
> +            error_prepend(errp, "post-save failed: %s ", vmsd->name);
> +        }


> +    } else if (vmsd->post_save) {
>          int ps_ret = vmsd->post_save(opaque);
>          if (!ret && ps_ret) {
>              ret = ps_ret;
> 
> -- 
> 2.50.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


