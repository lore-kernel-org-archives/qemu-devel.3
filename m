Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA7BFF885A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 08:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJS3T-0002qm-L7; Sun, 03 May 2026 04:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJS3R-0002qa-Ez
 for qemu-devel@nongnu.org; Sun, 03 May 2026 04:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJS3P-0005tl-Lt
 for qemu-devel@nongnu.org; Sun, 03 May 2026 04:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777796394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBtVehoCthIoQhl8rD6scUBEIG2CbPbB6W8WeFQ7Xds=;
 b=Qc5ZxYOsj6uVViopBWBfvN3B1w0SdPX4/ltAXfvN62vRwfc1CAWSlQKZa2ygJjHf6P1geI
 Ep35o58hGi2Wm7DZUsv35pavUa4mXyOgUX+yGLaFlY04kRg8CTY6uGM7KARFzDJ92nDrYr
 zhcOktRBiG1WjkDAb22T6wkvXTswijM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-HOjQnhe2Pu2KbtKjIG6pow-1; Sun,
 03 May 2026 04:19:52 -0400
X-MC-Unique: HOjQnhe2Pu2KbtKjIG6pow-1
X-Mimecast-MFC-AGG-ID: HOjQnhe2Pu2KbtKjIG6pow_1777796391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D9DE1956080; Sun,  3 May 2026 08:19:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E84F11800667; Sun,  3 May 2026 08:19:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 08/41] hw/intc/apic: guard against NULL cpu in set_id
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, armbru@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9a8407d1-ce20-48a5-9975-4b08075e3768@linaro.org>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-8-c413f3605311@redhat.com>
 <9a8407d1-ce20-48a5-9975-4b08075e3768@linaro.org>
Date: Sun, 03 May 2026 12:19:45 +0400
Message-Id: <177779638511.2741407.15312141135813146902.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+JI2ml+nMAW056Fa9WPVi2xUo6bqI98RmCcQebIciR0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp9wUhZEMsKWAxA8dnuWQSK/VoegLqepEWc1ec4
 ITu4Jd6MjyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafcFIQAKCRDa6OEJdZac
 5XmbD/4jU4TPV92G4jy2/k7SVA7AhLBKq3amjnI7ZYowdsFm0d3GEL3Uw55vpxx7Ufe+Di0RSd9
 3ncJ3vv/T1WCnY3xc5lIna42BtY3K37qQHHZ3v7X8vAUGIJ86xI+7VqtX+MII057S091pZpcUDn
 VNdsoBBz4JVkBUBpXNdgBaD40pa89wNvC6GrXXdg2iackPqRxK1ybK7lmstPadgLdld3S6kDR8c
 6ESAk0iLaTyduqCk3vipdoL1kz9GSdxGYmNS/9Ra/o6ER3OpClsbrMHV9UiKOHKV6T18fzBH/kz
 GjLYmJIB6B2rovnXaJdoy3ldOiSRJG7YtkYy+sOBBFIqxJ8XbRqsPNpL5Oyp1878U1IbaHbzqzN
 0tiBCSH88VWSpih1fQ/vA42P549H6uHasAKiz6XmqNsCrBSOCVZsRUwBXcDvy45j4OSSMWMmY0S
 4QIwt7PQmdJJqjZu35WHmYeG5N2cuKsKJfY9gzqGe7TIi7s8Pftg7S6cWdT1mfEEhJFfNDGTpfC
 Z/EvYqxKmypizk5RThlUyjbSNPQiwESYE6bR5+ubttDSYAZutaYOJ+pysqYgB8MFkscL0ttycyR
 FHpEn1NTvjfzvDMA8n0h67QPTH9cp2Tk1jcd5+mN7+/r6Vhapu3ZGCp9YSc8Mofkcl9lRonDlUR
 PvhPIUUADooex8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 2026-04-27 22:40:16+02:00, Philippe Mathieu-Daudé wrote:
> On 27/4/26 21:42, Marc-André Lureau wrote:
> 
> > apic_common_set_id() dereferences s->cpu to check for x2APIC support
> > when the APIC ID is >= 255. On a standalone APIC object that has not
> > been attached to a CPU, s->cpu is NULL, causing a segfault.
> > 
> > Add a NULL check before dereferencing. When there is no CPU, the
> > x2APIC feature cannot be verified, so reject the large APIC ID.
> > 
> > Fixes: b5ee0468e9d2 ("apic: add support for x2APIC mode")
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/intc/apic_common.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> > index bf4abc21d7b..874a05e529c 100644
> > --- a/hw/intc/apic_common.c
> > +++ b/hw/intc/apic_common.c
> > @@ -421,7 +421,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
> >           return;
> >       }
> 
> Could we check s->cpu earlier, i.e. on entry?
>

On entry of the function? how would that help?

> 
> Or actually, why don't we use a link property checked once
> in apic_common_realize()?

That's also what you asked on commit 63073574e8d5551. But a link
property won't help (or how?).

I think to be more correct than this simple patch, we would need to move
the checks to realize(). There it should check ->cpu != NULL and ->id
validity. I'll update the fix.


