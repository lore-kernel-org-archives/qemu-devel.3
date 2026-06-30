Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D50FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weUaO-0001JJ-QK; Tue, 30 Jun 2026 05:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weUaN-0001J9-LR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weUaL-0003QI-I1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782811011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmhVZZf6ocfEssa9MXJ1b8h/788s37AsGnoNY/gGpzQ=;
 b=CZm+IeyKXFZb/D86n9Not8mEVcMBsQcBwmbK9Rg4wDtGrnJL+Ov0uJf2qdCpDVw7XBBJ2U
 G2gCKazxtypu4z5KhgiytIxc1GAbKTsl3qLw6nWfRVArc+lB/i81axcxoFVaEkT3zn5hCC
 qPZ5/d5PvS++ux6JRXpMq3dOoTCKUUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-W-8fIrw8MgOE25KvtszHjw-1; Tue,
 30 Jun 2026 05:16:47 -0400
X-MC-Unique: W-8fIrw8MgOE25KvtszHjw-1
X-Mimecast-MFC-AGG-ID: W-8fIrw8MgOE25KvtszHjw_1782811006
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F6118A19CB; Tue, 30 Jun 2026 09:16:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B75418005A0; Tue, 30 Jun 2026 09:16:33 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:16:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 01/35] qom: replace 'can_be_deleted' with
 'prepare_delete'
Message-ID: <akOJbvaI7lvoW6Xw@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-2-berrange@redhat.com>
 <87qzlopjlp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzlopjlp.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 09:34:26AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > While most objects can perform all their cleanup in the finalizer
> > method, there can be interactions with other resources / subsystems
> > / threads which require that some cleanup be performed on an user
> > creatable object before unparenting it and entering finalization.
> >
> > The current 'can_be_deleted' method runs in the deletion path and
> > is intended to be used to block deletion. While it could be used
> > to perform cleanup tasks, its name suggests it should be free of
> > side-effects.
> >
> > Generalize this by renaming it to 'prepare_delete', explicitly
> > allowing for cleanup to be provided. Existing users of 'can_be_deleted'
> > are re-written, which provides them with more detailed/tailored error
> > messages.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Tested-by: Peter Krempa <pkrempa@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> [...]
> 
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index 7080f85f95..6faa0b2fd9 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -32,16 +32,15 @@ bool user_creatable_complete(UserCreatable *uc, Error **errp)
> >      return !*errp;
> >  }
> >  
> > -bool user_creatable_can_be_deleted(UserCreatable *uc)
> > +bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp)
> >  {
> > -
> >      UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
> > +    ERRP_GUARD();
> >  
> > -    if (ucc->can_be_deleted) {
> > -        return ucc->can_be_deleted(uc);
> > -    } else {
> > -        return true;
> > +    if (ucc->prepare_delete) {
> > +        ucc->prepare_delete(uc, errp);
> >      }
> > +    return !*errp;
> >  }
> 
> Simpler:
> 
>        if (ucc->prepare_delete) {
>            return ucc->prepare_delete(uc, errp);
>        }
> 
>        return true;

ok

> 
> >  
> >  void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
> > @@ -253,8 +252,7 @@ bool user_creatable_del(const char *id, Error **errp)
> >          return false;
> >      }
> >  
> > -    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj))) {
> > -        error_setg(errp, "object '%s' is in use, can not be deleted", id);
> > +    if (!user_creatable_prepare_delete(USER_CREATABLE(obj), errp)) {
> 
> This changes error messages.
> 
> The old ones mention @id.
> 
> The new ones don't:
> 
>         error_setg(errp, "Cryptodev backend is still in use");
>         error_setg(errp, "Host memory backend is still mapped");
>         error_setg(errp, "IOMMUFD backend still has %d users", be->users);
>         error_setg(errp, "Throttle group still has multiple references");
>     error_setg(errp, "Deleting can bus devices is not supported");
>     error_setg(errp, "Deleting main loop is not supported");
> 
> Visible in the diff to tests/qemu-iotests/245 below.
> 
> Because this runs within object-del, and @id is the argument provided by
> the user there, the error message is still sufficiently clear, I guess.
> 
> If this ever gets used where the object isn't obvious to the user from
> context, the error messages become sub-par.  Observation, not a demand.
> 
> Please cover this change in the commit message.

Oh yes, I remember being slightly annoyed at the need to do
this - I was surprised to realize that an Object does not
actually know its own 'id'. The 'id' only exists as the
name of the property in the parent.

We could add an  object_get_id() API which traveres obj->parent
and then iterates over child properties. Annoyingly O(n) time
for that, but perhaps not a big enough problem to worry about ?
At least for error reporting we're probably ok with that time
complexity even if there are 1000 objects registered as children.

> 
> >          return false;
> >      }
> >  
> > diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> > index f96610f510..e161bcfda9 100755
> > --- a/tests/qemu-iotests/245
> > +++ b/tests/qemu-iotests/245
> > @@ -801,7 +801,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
> >          # Now group1 is in use, it cannot be deleted
> >          result = self.vm.qmp('object-del', id = 'group1')
> >          self.assert_qmp(result, 'error/class', 'GenericError')
> > -        self.assert_qmp(result, 'error/desc', "object 'group1' is in use, can not be deleted")
> > +        self.assert_qmp(result, 'error/desc', "Throttle group still has multiple references")
> >  
> >          # Default options, this switches the group back to group0
> >          self.reopen(opts)
> > @@ -809,7 +809,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
> >          # So now we cannot delete group0
> >          result = self.vm.qmp('object-del', id = 'group0')
> >          self.assert_qmp(result, 'error/class', 'GenericError')
> > -        self.assert_qmp(result, 'error/desc', "object 'group0' is in use, can not be deleted")
> > +        self.assert_qmp(result, 'error/desc', "Throttle group still has multiple references")
> >  
> >          # But group1 is free this time, and it can be deleted
> >          self.vm.cmd('object-del', id = 'group1')
> > diff --git a/util/main-loop.c b/util/main-loop.c
> > index ad8645c30a..67ee06c311 100644
> > --- a/util/main-loop.c
> > +++ b/util/main-loop.c
> > @@ -218,8 +218,9 @@ static void main_loop_init(EventLoopBase *base, Error **errp)
> >      mloop = m;
> >  }
> >  
> > -static bool main_loop_can_be_deleted(EventLoopBase *base)
> > +static bool main_loop_prepare_delete(EventLoopBase *base, Error **errp)
> >  {
> > +    error_setg(errp, "Deleting main loop is not supported");
> >      return false;
> >  }
> >  
> > @@ -229,7 +230,7 @@ static void main_loop_class_init(ObjectClass *oc, const void *class_data)
> >  
> >      bc->init = main_loop_init;
> >      bc->update_params = main_loop_update_params;
> > -    bc->can_be_deleted = main_loop_can_be_deleted;
> > +    bc->prepare_delete = main_loop_prepare_delete;
> >  }
> >  
> >  static const TypeInfo main_loop_info = {
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


