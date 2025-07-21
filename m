Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC2C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqdr-00029i-7m; Mon, 21 Jul 2025 09:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udqdl-0001al-IZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udqdi-0006OV-PF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753104788;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aK+tzYjCRayd9HuOraSn8VF8VY1E/hyk3gguaEClc4o=;
 b=WE5OSG8X3ZBYbQqFkcuqbTEjvRnotmP0BFf2yBoX8iYaTPsMw0UqJ1jQMEepinVNN2nYvv
 gUGBDRGr6lH5kKN4+iTwB6NNdQ3m2gCORlLB7iJ94NuAfHmtQiAI8pwea7B48E3Z38hpJ2
 QMBTuQXoYXDENJVVRVMk0n+nv1gn0RE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-cIbPsd68PuC0jgySTmeruQ-1; Mon,
 21 Jul 2025 09:33:04 -0400
X-MC-Unique: cIbPsd68PuC0jgySTmeruQ-1
X-Mimecast-MFC-AGG-ID: cIbPsd68PuC0jgySTmeruQ_1753104781
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B6BC19560B7; Mon, 21 Jul 2025 13:33:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3DC3195608D; Mon, 21 Jul 2025 13:32:51 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:32:48 +0100
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
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aH5BgAVc2x_tjsHJ@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

On Mon, Jul 21, 2025 at 04:59:28PM +0530, Arun Menon wrote:
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
>  migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 6 deletions(-)
> 

> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 288b57e1ed778cce21247b64d5e97dfef41ad586..d96908d12ccffaef421e5d399a48e26cada2cb77 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c

> @@ -524,7 +548,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (ret) {
>                      error_setg(errp, "Save of field %s/%s failed",
>                                  vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> +                    if (vmsd->post_save_errp) {
> +                        ret = vmsd->post_save_errp(opaque, &local_err);
> +                        if (ret < 0) {
> +                            error_propagate(errp, local_err);
> +                        }

This is still broken. 'errp' is already set a few lines earlier, so you
can't propagate a new error over the top

> +                    } else if (vmsd->post_save) {
>                          vmsd->post_save(opaque);
>                      }
>                      return ret;
> @@ -552,7 +581,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>  
> -    if (vmsd->post_save) {
> +    if (vmsd->post_save_errp) {
> +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> +        if (!ret && ps_ret) {
> +            ret = ps_ret;
> +            error_propagate(errp, local_err);
> +        }

Again, propagating over the top of an existing error

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


