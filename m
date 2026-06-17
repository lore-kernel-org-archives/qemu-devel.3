Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F87CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZo0w-0007mw-DH; Wed, 17 Jun 2026 07:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZo0q-0007kB-HD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZo0m-00033O-I3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781694046;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErGwSh/rZ55JZGBIf10DkGi6ELVsm3QkNpNuL3KaXbk=;
 b=K1mzrUt4yGQs5tew+AotNs/nux2GAeuYnEHRf77pLswSAygrKp5KZbDijH6lPuM5HaHXn+
 lOE6gETQGC+FgHzuXyxnBTMojaUQ2Ce/MWvUFRWmsTaSiDwXV3CaKdr9fU2Kbeesa51C3u
 vVwsktbnxG04wZyrsOwB6BrNj940TbA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-pzZIhmI5P3SzBAMmXNnWVg-1; Wed,
 17 Jun 2026 07:00:43 -0400
X-MC-Unique: pzZIhmI5P3SzBAMmXNnWVg-1
X-Mimecast-MFC-AGG-ID: pzZIhmI5P3SzBAMmXNnWVg_1781694041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3DCA1955EB9; Wed, 17 Jun 2026 11:00:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.201])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A432180049F; Wed, 17 Jun 2026 11:00:34 +0000 (UTC)
Date: Wed, 17 Jun 2026 12:00:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 0/7] qom: deprecate embedded objects and instance properties
Message-ID: <ajJ-T1BHTHX9cd_z@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <CAFEAcA-Mmt8=1iPOCbF=XsghFzfNN-=GHyLr70iUNDFFN0OKcg@mail.gmail.com>
 <49a8b482-57f5-4d0b-907c-13ddb77c400a@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49a8b482-57f5-4d0b-907c-13ddb77c400a@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 17, 2026 at 11:39:57AM +0100, Mark Cave-Ayland wrote:
> On 16/06/2026 17:12, Peter Maydell wrote:
> 
> > On Tue, 16 Jun 2026 at 16:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > QOM has two rather unusual / surprising features historicall
> > > 
> > >   * The ability to embed a QOM instance's memory inside another
> > >     struct
> > >   * The ability to register properties against the instnce
> > >     instead of struct
> > > 
> > > While they both look convenient on the surface, they also
> > > have significant undesirable side effects (see the commit
> > > message for each patch for details).
> > > 
> > > The premise of this series is that their convenience does
> > > not outweigh their downsides, and we would be better off
> > > long term by eliminating their usage, rather than trying
> > > to add more hacks on top to mitigate their downsides.
> > 
> > The thing I would like to see before we mark object_initialize_child
> > and friends as deprecated is clear documentation of "this is how
> > we would like you to write 'container/SoC' style devices, here is
> > an device written to the approved style you can look at".
> > 
> > Currently we have in the codebase a pretty wide range of
> > different ways to write devices:
> >   - really ancient, not QOM/qdev at all
> >   - qdev style (lots of Device* pointers)
> >   - embedded-struct style
> > and I'm not sure if this would be adding a fourth style, or
> > rolling back to qdev style.
> > 
> > (Borrowing a paragraph I wrote last time this came up:)
> > 
> > I'm not opposed to the idea of making a design decision that this
> > struct-embedding is no longer what we want to do, and defining
> > that something else is our new best practice for how to write devices.
> > But I think we would need to start by reaching a consensus that that
> > *is* what we want to do, and documenting that "best practice" somewhere
> > in docs/devel/. Then we can all be on the same page about the design
> > patterns we want and it will be clearer to reviewers whether new
> > code and new APIs and conversions of old code fit into those
> > patterns or not.
> > 
> > I think we're getting closer on the "consensus" part but
> > the "document the new best practice" part is important I think.
> 
> Agreed. The only issue I can see here is that often documentation isn't good
> enough: as an example, we've standardised on using "parent_obj" as the field
> name for several years now, but we still get patches using different names
> because developers struggle to find the documentation, and reviewers aren't
> often aware of changes in how we model devices etc.
> 
> Based on this experience, I think the only way we can realistically do this
> is to teach checkpatch.pl about it so that using functions such as
> object_initialize_child(), object_property_add() etc. will cause CI failure.
> 
> I'd love to be able to teach it about "parent_obj" and not to embed objects
> that aren't pointers, but I don't know if that's possible?

For embedding we can teach checkpatch to whine about any use of
object_initialize() in new code easily enough which catches most
cases.

For 'parent_obj' I thought about a macro assert:

$ git diff
diff --git a/include/qom/object.h b/include/qom/object.h
index e9ce15d595..00d9424e3d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -283,6 +283,7 @@ struct Object
     module_obj_name##_class_init(ObjectClass *oc, const void *data); \
     static void \
     module_obj_name##_init(Object *obj); \
+    G_STATIC_ASSERT(offsetof(ModuleObjName, parent_obj) == 0);   \
     \
     static const TypeInfo module_obj_name##_info = { \
         .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \


Unfortunately only a small number use OBJECT_DEFINE_TYPE macros,
most use DEFINE_TYPES which does not have access to the struct
names :-(  Still that does show a few violators of the current
rule.

I also tried the same assert in OBJECT_DECLARE_TYPE which would
catch all usage, but that falls over when the header pre-declares
the struct name, and the source file has its actual definition.
We don't want to force the struct definition into the header
so I'm out of options for build-time checks there :-(




With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


