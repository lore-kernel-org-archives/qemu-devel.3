Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A1FCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNQL-0000UJ-Lo; Fri, 08 May 2026 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLNQD-0000PM-Vd
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLNQB-0004t2-Mu
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778255242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEC4I9KRb+XazGZGV68PUfREE1b+7je7ImYwCx/T6Dw=;
 b=S2AQaoy7n8bEDVYSwqblUtKY9jXO2SQHENTnSrlXEbY0YdcSP7CvvidkmxLGt9Bpq4vDmh
 09EGv9umKgVjMaJTVN524VFXuCpYSpuzGxrjq0KuosfWjJiSUKqWjkNwDIzQ5vlU22DIWP
 qqOBRlgED2K0lw5hjPiebTXqE63opaQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-c8pmEmBCPlG5ct_r-Js2dQ-1; Fri,
 08 May 2026 11:47:18 -0400
X-MC-Unique: c8pmEmBCPlG5ct_r-Js2dQ-1
X-Mimecast-MFC-AGG-ID: c8pmEmBCPlG5ct_r-Js2dQ_1778255237
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CF86195608A; Fri,  8 May 2026 15:47:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADDDF19560A2; Fri,  8 May 2026 15:47:15 +0000 (UTC)
Date: Fri, 8 May 2026 16:47:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 01/10] qom: add trace events for object/property
 lifecycle
Message-ID: <af4FgLKSCRqZmCk4@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-2-berrange@redhat.com>
 <177825350908.389613.14807854790738677316.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177825350908.389613.14807854790738677316.b4-review@b4>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 08, 2026 at 07:18:29PM +0400, marcandre.lureau@redhat.com wrote:
> On Fri, 08 May 2026 12:24:20 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/qom/trace-events b/qom/trace-events
> > index b2e9f4a7127..9aabbae4f73 100644
> > --- a/qom/trace-events
> > +++ b/qom/trace-events
> > @@ -1,5 +1,13 @@
> >  # See docs/devel/tracing.rst for syntax documentation.
> >  
> >  # object.c
> > -object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
> > -object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
> > +object_dynamic_cast_assert(void *obj, const char *type, const char *target, const char *file, int line, const char *func) "obj=%p type=%s->%s (%s:%d:%s)"
> > +object_finalize(void *obj, const char *type) "obj=%p type=%s"
> > +object_new(void *obj, const char *type) "obj=%p type=%s"
> > +object_property_add(void *obj, const char *type, const char *name, void *value) "obj=%p type=%s name=%s value=%p"
> > +object_property_add_child(void *obj, const char *type, const char *name, void *parent, const char *parenttype) "obj=%p type=%s name=%s parent=%p parent-type=%s"
> 
> The 4th and 5th parameters are the child being added, not a parent.
> In object_property_try_add_child the call is:
> 
>   trace_object_property_add_child(obj, ..., child, child->class->type->name)
> 
> So the parameter names should be "child"/"childtype" and the format
> string should use "child=" / "child-type=".
> 
> > +object_property_del(void *obj, const char *type, const char *name, void *value) "obj=%p type=%s name=%s value=%p"
> > +object_property_del_child(void *obj, const char *type, void *parent, const char *parenttype) "obj=%p type=%s parent=%p parent-type=%s"
> 
> Same here

Opps, yes, I don't know what I was thinking there !

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


