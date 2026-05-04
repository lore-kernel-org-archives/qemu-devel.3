Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14845FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnTC-0000BA-TB; Mon, 04 May 2026 03:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJnTA-0000Ah-UL
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJnT9-0000HT-Bc
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777878713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uL+vycz0AsHSzq3GpUxAuTFuwKgS5ivW/6nF/oZa9jA=;
 b=SIWVt8p2LubE1YDjeZN7BnIWufYzgZBtLjUkfBaBYNb7pm3TE4gJih9nzQBgcYYk47j7eQ
 y/Syopdo5E1B82F7uiz+oZfaxFiLOmkKVlXKOhykri7HKqUCtwwReiyr8Z43Cj1q9jp8HD
 EugUh7U35Lr4R2LWgTLUL5T+CHIQYcs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-5lnn3em9ODmZfd-eMQQe7A-1; Mon,
 04 May 2026 03:11:52 -0400
X-MC-Unique: 5lnn3em9ODmZfd-eMQQe7A-1
X-Mimecast-MFC-AGG-ID: 5lnn3em9ODmZfd-eMQQe7A_1777878712
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2C8A1956046; Mon,  4 May 2026 07:11:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 552CE1800357; Mon,  4 May 2026 07:11:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 13/41] RFC system/ioport: move embedded memory region
 cleanup to portio_list_destroy
From: marcandre.lureau@redhat.com
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, armbru@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afJzLNnljU4hvZuu@x1.local>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-13-c413f3605311@redhat.com>
 <afJzLNnljU4hvZuu@x1.local>
Date: Mon, 04 May 2026 11:11:45 +0400
Message-Id: <177787870572.2741407.2378803234389873865.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wXJS6swutJIfFUaaYI96xRwIKfOh8WP+46UiJGgJDE8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+EaxFdl0i7C3I7eyYQz3TzvGiNTOHx2dRgM6r
 c6VXZ6hX9aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafhGsQAKCRDa6OEJdZac
 5Y5rD/0TaSu+k8Wu8XPSXqgDQVOADIwheKiUPhpkMNIuYUbbD2LmOkYDQuQl/AJZpbtZCN39Jbf
 9xUpZbACtnEMCw+kABpxqpAmTdCXJHpp3GvEHSK/tuB2HdAR5U7xByfWOkvifiw+Vipy+bminPd
 h+Rfrj8C53Cdxn3Jnsw8/327XCEcfInB++9ZYj14txOgHBKnAtKPVOT7KHpvewxiYQMm8hEvpNq
 4fjKCLtIcRvqc8aA0MjsKdHwslcKzhmJ9Ga0GWrJLPHnA8Qozk/CZPDEkBIvnogkOLnnQ8CqU1m
 S5Z8eazplQV1KglLrX0Nj+SYIz1Rnkwq0npztuOyywb2rqN3+XURRgM62Sxm34Vn3n/L/Mi5gsc
 XCSmUjVycC5btGHNJUR8InMw4OYx9U9t71gNy5O9kk0+GEGGqVEQxkvmEfmFsTvU50e2kMU2k2x
 Uj/aKSPKXTaP7BaGMF3Z92HWPT2NtSdeV3aha58a+BTZ1NDFsR0/gZZn9Cb0Pr5MVeuj0pjp3o+
 igXbLl5srxbpTUXOao71NXnFkDwRQfUbZMpbdZRof/aFjBIRMh0U1n3YcR+Lx7u/DKjyfLMiUeP
 y2zAuNRmThXIU4onQRAZpmhivRcwmHkgL6Yo/f0Wfct9LrsvnI/Um11qKzSlTWOPc0Vg4FE53vn
 gDLnaVqAeP5A6Qg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-04-29 17:07:56-04:00, Peter Xu wrote:
> On Mon, Apr 27, 2026 at 11:42:12PM +0400, Marc-André Lureau wrote:
> 
> > memory_region_portio_list_finalize() unconditionally calls
> > object_unref() on the embedded MemoryRegion, but when the object was
> > created via bare object_new() the MemoryRegion was never initialized
> > and has a refcount of 0, triggering an assertion failure.
> > 
> > The unref in finalize drops the keep-alive reference added during the
> > reparenting in portio_list_add_1(). Move it to portio_list_destroy()
> > where the cleanup belongs, and assert the refcount is zero in
> > finalize.
> > 
> > This is an alternative to "system/ioport: Fix qom-list-properties crash
> > on portio list obj" patch, hence the RFC.
> > 
> > Fixes: 690705ca0b0f ("softmmu/ioport.c: make MemoryRegionPortioList owner of portio_list MemoryRegions")
> > Cc: peterx@redhat.com
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >  system/ioport.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/system/ioport.c b/system/ioport.c
> > index 9209bff2eab..aa8f3229804 100644
> > --- a/system/ioport.c
> > +++ b/system/ioport.c
> > @@ -145,6 +145,7 @@ void portio_list_destroy(PortioList *piolist)
> >      for (i = 0; i < piolist->nr; ++i) {
> >          mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
> >          object_unparent(OBJECT(&mrpio->mr));
> > +        object_unref(OBJECT(&mrpio->mr));
> >          object_unref(mrpio);
> >      }
> >      g_free(piolist->regions);
> > @@ -346,7 +347,8 @@ static void memory_region_portio_list_finalize(Object *obj)
> >  {
> >      MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
> >  
> > -    object_unref(&mrpio->mr);
> > +    /* dropped by portio_list_destroy(), or never initialized */
> > +    assert(!mrpio->mr.parent_obj.ref);
> 
> I'm not sure if it's worthwhile to just add such assert and violate the
> layering here, by accessing mr's refcount. Shall we just drop this check?
> 
> OTOH, if we will move the unref to destroy, shall we move the ports below
> over and just go ahead removing the whole finalize()?

Not fond of doing cleanups in non-conventional ways. I will rather take
your "system/ioport: Fix qom-list-properties crash on portio list obj"
patch in next iterations.


