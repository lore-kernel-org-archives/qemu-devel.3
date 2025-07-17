Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A89C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUKT-0002eR-Nq; Thu, 17 Jul 2025 15:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRn9-0007Ae-BE
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRn7-0007oh-5S
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752770943;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1MimOt7JSOZXWdvOHA5q5cv+NY3Ej2RMg8rLSC/H0+s=;
 b=f+jQDxSAQPEwWpUClB0FcsY7lL+Al9fcsQeba8NFnXNXgwx4aRra1jvpug/TDsUulB9J7W
 ul3TCr3NcyLT5vgfDroVsKZfRDxFgpO8untFNU88iTBu9zKnuCEVPZPYroW/FGhr5tPbNX
 BHnidMS224YpJ/lhC6ZTpWSjDvG5ars=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-0G5XO7lePQiVvKFN6W-xfQ-1; Thu,
 17 Jul 2025 12:49:00 -0400
X-MC-Unique: 0G5XO7lePQiVvKFN6W-xfQ-1
X-Mimecast-MFC-AGG-ID: 0G5XO7lePQiVvKFN6W-xfQ_1752770937
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4305219560B6; Thu, 17 Jul 2025 16:48:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ACB530001B1; Thu, 17 Jul 2025 16:48:49 +0000 (UTC)
Date: Thu, 17 Jul 2025 17:48:46 +0100
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
Subject: Re: [PATCH v5 06/23] migration: push Error **errp into
 qemu_loadvm_section_part_end()
Message-ID: <aHkpboSZOIfcLtxe@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-6-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-propagate_tpm_error-v5-6-1f406f88ee65@redhat.com>
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

On Thu, Jul 17, 2025 at 06:07:29AM +0530, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_section_part_end() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 63125971751394b72efc9bcaf7c4364715eef07f..22d73999595384519c755c9416b74ba1263a8bb9 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2764,7 +2764,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
>  }
>  
>  static int
> -qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> +qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
>  {
>      bool trace_downtime = (type == QEMU_VM_SECTION_END);
>      int64_t start_ts, end_ts;
> @@ -2776,8 +2776,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
>  
>      ret = qemu_file_get_error(f);
>      if (ret) {
> -        error_report("%s: Failed to read section ID: %d",
> -                     __func__, ret);
> +        error_setg(errp, "%s: Failed to read section ID: %d",
> +                   __func__, ret);

Same note about dropping __func__

> @@ -2810,6 +2810,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
>      }
>  
>      if (!check_section_footer(f, se)) {
> +        error_setg(errp, "Check section footer error");

Include "section_id" as that's the only context we have available.

>          return -EINVAL;
>      }
>  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


