Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B031CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHqk-0004YM-OL; Fri, 24 Oct 2025 09:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHqh-0004YE-Ld
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHqe-0006HB-Vk
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761312530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4U+9aA/eizcVCwSSh1Rcm/X6ety3uP/JudYORh/n7Q=;
 b=bND2WX8FS+w6n6fozoxbXLAQLEvkwcT7eAHWu0yAwrEy1F4rhlT0GrNJjx/ve7OIUSqPlj
 eMis+JPh+HI8Nab1ybt3MclJ5dkhIs0EsusVR8Y+K6Wx+dtI9RgoqQ4i8T1oo+bFeDPxot
 j6Tf6QKJ285ULBAQ6aXysdoCmqwgXyo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-0zga0tcwNqCV_JMd84XtYA-1; Fri,
 24 Oct 2025 09:28:44 -0400
X-MC-Unique: 0zga0tcwNqCV_JMd84XtYA-1
X-Mimecast-MFC-AGG-ID: 0zga0tcwNqCV_JMd84XtYA_1761312522
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25C381800669; Fri, 24 Oct 2025 13:28:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D6D619540EB; Fri, 24 Oct 2025 13:28:39 +0000 (UTC)
Date: Fri, 24 Oct 2025 14:28:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 08/32] system: check security of device types
Message-ID: <aPt_A2AHAeGrUAo6@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-9-berrange@redhat.com>
 <87bjlx7s0f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjlx7s0f.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 23, 2025 at 01:54:24PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This wires up the DeviceClass types to have their
> > security checked when devices are created.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  system/qdev-monitor.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 2ac92d0a07..520fe5c495 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -43,6 +43,8 @@
> >  #include "hw/qdev-properties.h"
> >  #include "hw/clock.h"
> >  #include "hw/boards.h"
> > +#include "qapi/compat-policy.h"
> > +
> >  
> >  /*
> >   * Aliases were a bad idea from the start.  Let's keep them
> > @@ -644,6 +646,13 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >          return NULL;
> >      }
> >  
> > +    if (!compat_policy_check_security(&compat_policy,
> > +                                      object_class_get_name(OBJECT_CLASS(dc)),
> > +                                      object_class_is_secure(OBJECT_CLASS(dc)),
> > +                                      errp)) {
> > +        return NULL;
> > +    }
> > +
> >      /* find bus */
> >      path = qdict_get_try_str(opts, "bus");
> >      if (path != NULL) {
> 
> All users of compat_policy_check_security() in this series pass
> 
>     object_class_get_name(<the-object>),
>     object_class_is_secure(<the-object>),
> 
> Have you considered passing just <the-object> instead?

That would make qapi/qapi-compat.c have a dependency on QOM which I
felt was undesirable. What I could do, however, is introduced a
object_check_security method in qom/object.c that calls into
compat_policy_check_security, so we simplify the callers.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


