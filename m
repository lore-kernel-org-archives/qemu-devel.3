Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FC2C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6DAG-00074E-C2; Mon, 14 Sep 2026 16:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6DAF-00073z-4B
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6DAC-0000Dk-UC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789417227;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZlEMABCxXXzdNGoTaPkKTbPWGhOSPGUEARaEaW50GA=;
 b=VYQZD6lQmgfB3UICH580tkxwJanq1rb24wPWNclR48khh/vx4zvnVs7u4gWn03n4ZhoPLA
 KiVvQGhZQcSs483vZzzUu0AoHbAJxpXe8+ryC+TQkRsklLEZMPKhKe0OPhcYHbkbP3Kwyp
 L61ElmuVBCDDcYkeupyAk7cjLDbO5n0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-OVI_2C6CMxKU2tsgcFXkxg-1; Mon,
 14 Sep 2026 16:20:24 -0400
X-MC-Unique: OVI_2C6CMxKU2tsgcFXkxg-1
X-Mimecast-MFC-AGG-ID: OVI_2C6CMxKU2tsgcFXkxg_1789417223
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C39771955F7C; Mon, 14 Sep 2026 20:20:22 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD7803000223; Mon, 14 Sep 2026 20:20:19 +0000 (UTC)
Date: Mon, 14 Sep 2026 21:20:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 12/14] qom: report & filter on security status in
 qom-list-types
Message-ID: <aqhXANB86gps6UYR@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-13-berrange@redhat.com>
 <7a47ed5e-fc50-4f13-8fac-455c6015d38e@linaro.org>
 <aqhTQ4pad4OOWCcV@redhat.com>
 <0ff70c1c-cf73-46ec-9ae6-e2130bd1eb91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ff70c1c-cf73-46ec-9ae6-e2130bd1eb91@linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 14, 2026 at 10:12:17AM -1000, Richard Henderson wrote:
> On 9/14/26 10:04, Daniel P. Berrangé wrote:
> > On Mon, Sep 14, 2026 at 09:30:56AM -1000, Richard Henderson wrote:
> > > On 9/10/26 00:36, Daniel P. Berrangé wrote:
> > > > @@ -161,9 +163,15 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
> > > >        ObjectTypeInfo *info;
> > > >        ObjectClass *parent = object_class_get_parent(klass);
> > > > +    if (data->has_secure &&
> > > > +        data->secure != object_class_is_secure(klass)) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >        info = g_malloc0(sizeof(*info));
> > > >        info->name = g_strdup(object_class_get_name(klass));
> > > >        info->has_abstract = info->abstract = object_class_is_abstract(klass);
> > > > +    info->has_secure = info->secure = object_class_is_secure(klass);
> > > 
> > > Why are you assigning to has_secure here?  I thought that was just for the
> > > filter test above.
> > 
> > 'data->has_secure/secure' is for the input parameter allowing the
> > QMP client to say whether the returned device list should be
> > filtered based on security status, or include everything (the
> > default).
> > 
> > 'info->has_secure/secure' is for the return value reporting to the
> > client whether each device was secure/insecure.
> Still not getting it.  I understand info->secure as an output.
> I do not understand info->has_secure as an output.
> 
> Unless info->has_secure = true as an output indicates info->secure is valid?
> But in that case, why make them identical.

Since 'secure' is declared as an optional field in QAPI, the
'info->secure' flag will be ignored when serializing to JSON
if 'has_secure' is not set to true.

By setting  'has_secure = secure', it means that the returned
list will include "secure = true" in the JSON, but we will
entirely omit the 'secure = false' field for insecure devices. T

This is essentially a short-cut making the JSON smaller by
omitting the implied default (insecure) value from the JSON.


This was mirroring how the 'abstract' field is handled, where
we don't bother to report 'abstract = false' for types which
are not abstract.

It is also similar to the '-device help' output where we
report "secure" but not "insecure" (the implified default)


The alternative would be to make 'secure' a non-optional field
making 'has_secure' disapppear and including both secure = true
and secure = false in the serialized JSON.

I don't mind much either way, I was just copying how 'abstract'
was handled.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


