Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7262BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 06:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZPlY-0006uz-Rz; Thu, 01 Aug 2024 02:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZPlX-0006uE-BJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 02:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZPlV-0005Et-68
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 02:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722495499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYBCzb2E3FyybqN2WXwxvnfu9DHmMiJODCcOpo9qf9k=;
 b=f8kTyFG3eqE6Mipk29YUXSauybwvwpknz6H8Lt2vL5XOtJdA7cM+nHIiUaB75y4X1GxNFv
 ZXPbB34JWdyzMAbiwuNBVMag6CzqzJ096rlJEWTk/dBuTzKCGSt31nVvt/gA8Z6yDRHhfp
 SzuVU1g4b7/S+nUkmtzNNgD+IPDQkG0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-365VSHYQMi-Y8JoFWlw8MA-1; Thu,
 01 Aug 2024 02:58:15 -0400
X-MC-Unique: 365VSHYQMi-Y8JoFWlw8MA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B453A19560AD; Thu,  1 Aug 2024 06:58:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C814D300019B; Thu,  1 Aug 2024 06:58:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A349621E668A; Thu,  1 Aug 2024 08:58:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  eduardo@habkost.net
Subject: object_new() cannot fail, and that's fundamental (was: [PATCH v2
 1/2] qom/object, qdev: move globals functions to object.c)
In-Reply-To: <ZqPR_dFL5O6IFHlk@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 26 Jul 2024 17:42:37 +0100")
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-2-dbarboza@ventanamicro.com>
 <ZqPR_dFL5O6IFHlk@redhat.com>
Date: Thu, 01 Aug 2024 08:58:10 +0200
Message-ID: <87mslwhgql.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> CC: Markus since he's had opinions on stuff related to -global  in
> the past.
>
> On Wed, Jul 03, 2024 at 05:41:48PM -0300, Daniel Henrique Barboza wrote:
>> Next patch will add Accel globals support. This means that globals won't=
 be
>> qdev exclusive logic since it'll have to deal with TYPE_ACCEL objects.
>>=20
>> Move all globals related functions and declarations to object.c. Each
>> function is renamed from 'qdev_' to 'object_':
>>=20
>> - qdev_prop_register_global() is now object_prop_register_global()
>> - qdev_find_global_prop() is now object_find_global_prop()
>> - qdev_prop_check_globals() is now object_prop_check_globals()
>> - qdev_prop_set_globals() is now object_prop_set_globals()
>>=20
>> For object_prop_set_globals() an additional change was made: the function
>> was hardwired to be used with DeviceState, where dev->hotplugged is chec=
ked
>> to determine if object_apply_global_props() will receive a NULL or an
>> &error_fatal errp. The function now receives an Object and an errp, and
>> logic using dev->hotplugged is moved to its caller (device_post_init()).
>>=20
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

[...]

>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index f3a996f57d..894372b776 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -673,7 +673,7 @@ static void device_post_init(Object *obj)
>>       * precedence.
>>       */
>>      object_apply_compat_props(obj);
>> -    qdev_prop_set_globals(DEVICE(obj));
>> +    object_prop_set_globals(obj, DEVICE(obj)->hotplugged ? NULL : &erro=
r_fatal);
>>  }
>
> This is pretty awkward :-(
>
> If we're generalizing this global properties concept, then we want
> object_prop_set_globals to be called from the Object base class
> code.

Yes.  This series copies the concept from devices to accelerators.  But
since it clearly makes sense for any kind of object, we better move it
to objects instead.  We may not be able to get there in one step,
though.

>       We can't do that given this need to check the 'hotplugged'
> property.
>
> That check, however, is total insanity. Pre-existing problem,
> not your fault.
>
> I imagine the rationale is that we don't want to kill QEMU
> if setting a global fails, and we're in middle of device_add
> on a running VM.

Yes.

> Throwing away errors though is unacceptable IMHO.

To be precise: we're silently ignoring any -global that fail to apply.

I agree that's wrong.

>                                                   device_add
> can report errors and we should be propagating them. Likewise
> for object_add, or any object HMP command creating QOM types.
>
> The trouble is that we're about 4-5 levels deep in a call
> chain that lacks "Error **errp".
>
> The root problem is that none of object_new, object_new_with_class
> and object_new_with_type have a "Error *errp" parameter.

This is a fundamental QOM design decision.

Not mine, mind.  Moreover, I wasn't there, so my idea on design
rationale may well be off; keep that in mind.

QOM properties are not declared statically, they are created
dynamically.  Aside: this is, in my not particularly humble opinion, a
spectacularly bad idea.

Properties are generally created in instance_init() methods.

Fine print: we later added "class properties", which are created
dynamically within the class, and cloned into the instance before=20
its instance_init() method runs.

Object creation doesn't take arguments, and cannot fail.  An
instance_init() method doesn't take arguments, and cannot fail.

Objects are configured via properties.  Property setters take an
argument (the property value), and can fail.

Any part of object creation + configuration that could fail must be done
in property setters.

Common usage is create object, configure by setting properties, operate.

The state transition between "configuring" and "operating" is important.
For devices, this state transition happens when property "realized" is
set to true.  For user-creatable objects it happens when method
complete() is called.  Both can fail.  For everything else, the
transition is implicit / ad hoc / unclear.

For more on this (and other QOM design issues), see my memo "Dynamic &
heterogeneous machines, initial configuration: problems", in particular
section "Problem 5: QOM lacks a clear life cycle".
Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

To introspect properties, you need an object.  You can always create one
for that (can't fail).  Properties created outside object initialization
cannot be introspected that way.  This is how qom-list-properties works.

> object_new_with_props and object_new_with_propv both *do* have
> a "Error *errp" parameter,

Yes, because they combine object creation, which cannot fail, with
setting properties, which can fail.

>                            but then they call into object_new_with_type
> and can't get errors back from that.
>
> IMHO we need to fix this inability to report errors from object
> construction. It will certainly be a painful refactoring job,
> but I think its neccessary in order to support global props
> without this horrible hack checking the "hotpluggable" flag.

Beyond painful.  Possibly infeasible.

Object creation cannot fail.  If we revise this fundamental QOM design
decision, we get to update all call chains leading to object creation.
That's a *massive* undertaking.

Can we solve the problems we have without revising QOM design?

We'd need to delay the actual failure to a point where the design admits
failure.

Here's an idea.  Formalize the life cycle, i.e. make it an explicit
state machine.  Add a "failed" state.  Any error during object creation
makes the object go to "failed".  Going from "failed" to "operating"
fails.  Which is fine, because the design admits failure there.

Thoughts?


