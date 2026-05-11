Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304D3CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMO2o-0006PT-N8; Mon, 11 May 2026 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMO2j-0006Jd-Ap
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMO2f-0006wO-TB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778495956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOtf3ltj0xptCWK6dRhka6dLyu1oQ0gLZf9KH0NvEZc=;
 b=OBK6rN6z+MiiUQ7ODSoXECzFCrPJY8dm201/Ar7P4285GWm2gwvudHoVFoIJbm0HD2ZRsh
 qa5el98sJd/oZhtzvdq8fd9VKFQkptn0sjue2FMrdyo+hhlvLL3EJVMO9PUk3JUHlgP3wO
 mJ5fbJ/PeDWApaF0PBIKmIofbaN/7P4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-IJV1rWcUOkWjpAwgn55Ohw-1; Mon,
 11 May 2026 06:39:14 -0400
X-MC-Unique: IJV1rWcUOkWjpAwgn55Ohw-1
X-Mimecast-MFC-AGG-ID: IJV1rWcUOkWjpAwgn55Ohw_1778495953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7E6719560B7; Mon, 11 May 2026 10:39:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A93019560A2; Mon, 11 May 2026 10:39:11 +0000 (UTC)
Date: Mon, 11 May 2026 11:39:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 02/10] qom: validate ID format when creating objects
Message-ID: <agGxy4ezw3lZc7g1@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-3-berrange@redhat.com>
 <b3acf8bc-7ac1-4b4d-b7a4-4848b58ec51d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3acf8bc-7ac1-4b4d-b7a4-4848b58ec51d@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, May 11, 2026 at 12:35:57PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/5/26 13:24, Daniel P. Berrangé wrote:
> > The object_new_with_props/propv methods failed to validate the ID string
> > format, thus diverging from user_creatable_add_type.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   qom/object.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/qom/object.c b/qom/object.c
> > index 9c391071fb..62d2f0486a 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -24,6 +24,8 @@
> >   #include "qapi/forward-visitor.h"
> >   #include "qapi/qapi-builtin-visit.h"
> >   #include "qobject/qjson.h"
> > +#include "qemu/id.h"
> > +#include "qapi/qmp/qerror.h"
> >   #include "trace.h"
> >   /* TODO: replace QObject with a simpler visitor to avoid a dependency
> > @@ -764,6 +766,13 @@ Object *object_new_with_propv(const char *typename,
> >       ObjectClass *klass;
> >       UserCreatable *uc;
> > +    if (id != NULL && !id_wellformed(id)) {
> > +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
> > +        error_append_hint(errp, "Identifiers consist of letters, digits, "
> > +                          "'-', '.', '_', starting with a letter.\n");
> > +        return NULL;
> > +    }
> 
> Use a common object_identifier_is_well_formed() helper?

At the end of this series, the only other use of id_wellformed in
qom/object_interfaces.c is removed, so there is no need for an
extracted helper method IMHO

> 
> > +
> >       klass = object_class_by_name(typename);
> >       if (!klass) {
> >           error_setg(errp, "invalid object type: %s", typename);
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


