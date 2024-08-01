Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F07C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 11:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZUQD-0002vT-CC; Thu, 01 Aug 2024 07:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZUQB-0002uL-It
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZUQ8-0003Y7-L7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722513395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btFsVw5B4k6QCu6hnav6eyKMpEVHj6ZYpplqTPL4y9Y=;
 b=EnCA0QIsq1XC/lch1RKnKB0nzzZP715Y+3yFw5VP78Rl5PAha6iItCg1ovb3lDuWxWwAKT
 fD9dsuEOXLT7LPOFOjwIkdNM9v69irBzVFg9L43eCh1ykKfyFVRQy0dx5CYwSfDAz4wuAx
 fG5qA0iBWa7d8xTxKmtWEFhBgp1UtEk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-VqgVGJpXMsOhI9YGLVu-jg-1; Thu,
 01 Aug 2024 07:56:34 -0400
X-MC-Unique: VqgVGJpXMsOhI9YGLVu-jg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF4131944A8A; Thu,  1 Aug 2024 11:56:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33E8619560AE; Thu,  1 Aug 2024 11:56:29 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:56:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: object_new() cannot fail, and that's fundamental (was: [PATCH v2
 1/2] qom/object, qdev: move globals functions to object.c)
Message-ID: <Zqt36rZY8ungKzXD@redhat.com>
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-2-dbarboza@ventanamicro.com>
 <ZqPR_dFL5O6IFHlk@redhat.com> <87mslwhgql.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mslwhgql.fsf_-_@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 01, 2024 at 08:58:10AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > CC: Markus since he's had opinions on stuff related to -global  in
> > the past.
> >
> > On Wed, Jul 03, 2024 at 05:41:48PM -0300, Daniel Henrique Barboza wrote:
> >> Next patch will add Accel globals support. This means that globals won't be
> >> qdev exclusive logic since it'll have to deal with TYPE_ACCEL objects.
> >> 
> >> Move all globals related functions and declarations to object.c. Each
> >> function is renamed from 'qdev_' to 'object_':
> >> 
> >> - qdev_prop_register_global() is now object_prop_register_global()
> >> - qdev_find_global_prop() is now object_find_global_prop()
> >> - qdev_prop_check_globals() is now object_prop_check_globals()
> >> - qdev_prop_set_globals() is now object_prop_set_globals()
> >> 
> >> For object_prop_set_globals() an additional change was made: the function
> >> was hardwired to be used with DeviceState, where dev->hotplugged is checked
> >> to determine if object_apply_global_props() will receive a NULL or an
> >> &error_fatal errp. The function now receives an Object and an errp, and
> >> logic using dev->hotplugged is moved to its caller (device_post_init()).
> >> 
> >> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> [...]
> 
> >> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >> index f3a996f57d..894372b776 100644
> >> --- a/hw/core/qdev.c
> >> +++ b/hw/core/qdev.c
> >> @@ -673,7 +673,7 @@ static void device_post_init(Object *obj)
> >>       * precedence.
> >>       */
> >>      object_apply_compat_props(obj);
> >> -    qdev_prop_set_globals(DEVICE(obj));
> >> +    object_prop_set_globals(obj, DEVICE(obj)->hotplugged ? NULL : &error_fatal);
> >>  }
> >
> > This is pretty awkward :-(
> >
> > If we're generalizing this global properties concept, then we want
> > object_prop_set_globals to be called from the Object base class
> > code.
> 
> Yes.  This series copies the concept from devices to accelerators.  But
> since it clearly makes sense for any kind of object, we better move it
> to objects instead.  We may not be able to get there in one step,
> though.

Looking at how 'DEVICE(obj)->hotplugged' gets set, this logic does
not really need to have a dependancy on Device.

  static void device_initfn(Object *obj)
  {
      DeviceState *dev = DEVICE(obj);

      if (phase_check(PHASE_MACHINE_READY)) {
          dev->hotplugged = 1;
      ...
  }

IOW, we could at least be doing

  object_prop_set_globals(obj, phase_check(PHASE_MACHINE_READY) ? NULL : &error_fatal);

if we wanted this logic in the Object base class, however....


> >                                                   device_add
> > can report errors and we should be propagating them. Likewise
> > for object_add, or any object HMP command creating QOM types.
> >
> > The trouble is that we're about 4-5 levels deep in a call
> > chain that lacks "Error **errp".
> >
> > The root problem is that none of object_new, object_new_with_class
> > and object_new_with_type have a "Error *errp" parameter.
> 
> This is a fundamental QOM design decision.
> 
> Not mine, mind.  Moreover, I wasn't there, so my idea on design
> rationale may well be off; keep that in mind.
> 
> QOM properties are not declared statically, they are created
> dynamically.  Aside: this is, in my not particularly humble opinion, a
> spectacularly bad idea.
> 
> Properties are generally created in instance_init() methods.
> 
> Fine print: we later added "class properties", which are created
> dynamically within the class, and cloned into the instance before 
> its instance_init() method runs.
> 
> Object creation doesn't take arguments, and cannot fail.  An
> instance_init() method doesn't take arguments, and cannot fail.
> 
> Objects are configured via properties.  Property setters take an
> argument (the property value), and can fail.
> 
> Any part of object creation + configuration that could fail must be done
> in property setters.
> 
> Common usage is create object, configure by setting properties, operate.
> 
> The state transition between "configuring" and "operating" is important.
> For devices, this state transition happens when property "realized" is
> set to true.  For user-creatable objects it happens when method
> complete() is called.  Both can fail.  For everything else, the
> transition is implicit / ad hoc / unclear.




> 
> For more on this (and other QOM design issues), see my memo "Dynamic &
> heterogeneous machines, initial configuration: problems", in particular
> section "Problem 5: QOM lacks a clear life cycle".
> Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> 
> To introspect properties, you need an object.  You can always create one
> for that (can't fail).  Properties created outside object initialization
> cannot be introspected that way.  This is how qom-list-properties works.
> 
> > object_new_with_props and object_new_with_propv both *do* have
> > a "Error *errp" parameter,
> 
> Yes, because they combine object creation, which cannot fail, with
> setting properties, which can fail.
> 
> >                            but then they call into object_new_with_type
> > and can't get errors back from that.
> >
> > IMHO we need to fix this inability to report errors from object
> > construction. It will certainly be a painful refactoring job,
> > but I think its neccessary in order to support global props
> > without this horrible hack checking the "hotpluggable" flag.
> 
> Beyond painful.  Possibly infeasible.
> 
> Object creation cannot fail.  If we revise this fundamental QOM design
> decision, we get to update all call chains leading to object creation.
> That's a *massive* undertaking.
> 
> Can we solve the problems we have without revising QOM design?

Hmm, to cover  object_add QMP and -object CLI, we could just put
setting of global props into the object_new_with_prop{s,v} method,
which would deal with usage of user creatable objects, and a few
internal calls which handle errors.

device_add/-device won't hit that code path. Even if we converted
those over to object_new_with_prop{s,v}, that only handles the top
level device. Many devices will create sub-devices behind the scenes
and global properties are supposed to apply to those, and those will
all just be using plain qdev_new().

> We'd need to delay the actual failure to a point where the design admits
> failure.
> 
> Here's an idea.  Formalize the life cycle, i.e. make it an explicit
> state machine.  Add a "failed" state.  Any error during object creation
> makes the object go to "failed".  Going from "failed" to "operating"
> fails.  Which is fine, because the design admits failure there.

I guess the challenge is that we then need to be confident that the
state change is effected everywhere it needs to be, which sounds like
another bit of hairy work unless we can limit the scope.

We could do

  * Add globals support to  object_new_with_prop{s,v}
  * Convert Accel creation over to object_new_with_prop{s,v},
  * Records errors setting globals in device_post_init in a
    field in DeviceState
  * Make qdev_realize() check for & report the error from
    the step above, before doing its normal logic

IOW, going forward we have two patterns

  * Creation uses object_new_with_prop{s,v} and has globals
    set that way (preferred). Works for -object, -accel,
    object_add and some internal direct API calls

  * Creation uses a post-init hook, but the type has to have
    some state change equivalent to 'realized' to do delayed
    reporting of globals errors (discouraged, ideally only
    for Device). Works for -device, device_add

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


