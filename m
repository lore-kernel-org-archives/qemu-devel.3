Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1134CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYW0-0006NB-8j; Fri, 19 Jun 2026 08:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waYVx-0006LR-J2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 08:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waYVv-0001qn-10
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 08:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781872801;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEzSDDFobu00fpA3TkeLk7CbZGsjFtIRYe9S+oe8Mac=;
 b=Xi8DNAKCp4p3y/SEKL20brbv+20dbARg1LBjkmnCpyDK+U2DA3x5nTTuDFPiDuZHH478oh
 c26TWNTD0Nh7xzksNV8bPkPct7dH83l5cdHz99ek2HQ7BkgIwq8ObC4ScoF1e1tm/zrp+f
 8U9SkRhw6iqa1RR4szqgLOBphKjwVm4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274--R4G9ZyWPrO97DvQ9C0gQA-1; Fri,
 19 Jun 2026 08:39:59 -0400
X-MC-Unique: -R4G9ZyWPrO97DvQ9C0gQA-1
X-Mimecast-MFC-AGG-ID: -R4G9ZyWPrO97DvQ9C0gQA_1781872797
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5A601845432; Fri, 19 Jun 2026 12:39:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E94E30001BE; Fri, 19 Jun 2026 12:39:52 +0000 (UTC)
Date: Fri, 19 Jun 2026 13:39:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v3 32/35] monitor: add support for auto-deleting monitors
 upon close
Message-ID: <ajU4lZuO9ywb27pP@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-33-berrange@redhat.com>
 <178178367256.2477794.3774306065880935155.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178178367256.2477794.3774306065880935155.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 18, 2026 at 03:54:32PM +0400, marcandre.lureau@redhat.com wrote:
> > The default monitor is usually a long lived object that will exist for
> > the entire lifetime of the VM. A monitor can only service a single
> > client at a time though, and so it might be desirable to hotplug
> > additional monitors at runtime for specific tasks. If doing that,
> > however, there is a need to remove the monitor when it is no longer
> > needed.
> > 
> > Allowing a client to run "object-del" against its own monitor adds
> > complex edge cases, as it would be desirable to send the QMP response
> > despite the monitor sending it being deleted. Doing "object-del" alone
> > will also result in orphaning a character device backend instance, as
> > there is no opportunity to run the companion "chardev-del" command.
> > 
> > A simpler way to ensure cleanup is to add the concept of auto-deleting
> > monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
> > emitted, the equivalent of "object-del" + "chardev-del" can be run
> > internally. Since the transient client has already droppped its
> > monitor connection, there is no synchronization to be concerned about.
> > 
> > This is implemented via a new "close-action=none|delete" property on
> > the 'monitor-qmp' object. This concept could be extended with further
> > actions in future, for example:
> > 
> >  * close-action=shutdown - graceful guest shutdown
> >  * close-action=terminate - immediate guest poweroff
> >  * close-action=stop - pause guest CPUs while the monitor is not
> >                        connected to any client
> > 
> > This is left as an exercise for future interested contributors.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20260618105836.991609-33-berrange@redhat.com>
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 6ed510858e1..63335b8fd09 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1213,18 +1213,37 @@
> >    'base': 'MonitorProperties',
> >    'data': { '*readline': 'bool' } }
> >  
> > +
> > +##
> > +# @MonitorQMPCloseAction:
> > +#
> > +# Action to take when the character device backend is
> > +# closed.
> > +#
> > +# @none: take no action (the default)
> > +# @delete: delete both the 'monitor-qmp' object and its associated
> > +#          character device backend object
> > +#
> > +# Since 11.1
> > +##
> > +{ 'enum' : 'MonitorQMPCloseAction',
> > +  'data': ['none', 'delete'] }
> > +
> >  ##
> >  # @MonitorQMPProperties:
> >  #
> >  # Properties for the QMP monitor
> >  #
> >  # @pretty: whether to pretty print JSON responses (default: disabled)
> > +# @close-action: action to take when the character device backend
> > +#                is closed (default: none)
> >  #
> >  # Since: 11.1
> >  ##
> >  { 'struct': 'MonitorQMPProperties',
> >    'base': 'MonitorProperties',
> > -  'data': { '*pretty': 'bool' } }
> > +  'data': { '*pretty': 'bool',
> > +            '*close-action': 'MonitorQMPCloseAction' } }
> >  
> >  ##
> >  # @ObjectType:
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 5522e05464b..23829f32f9a 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -28,6 +28,7 @@
> >  #include "chardev/char-fe.h"
> >  #include "monitor/monitor.h"
> >  #include "qapi/qapi-types-control.h"
> > +#include "qapi/qapi-types-qom.h"
> >  #include "qapi/qmp-registry.h"
> >  #include "qobject/json-parser.h"
> >  #include "qemu/readline.h"
> > @@ -178,7 +179,9 @@ struct MonitorQMP {
> >      Monitor parent_obj;
> >      JSONMessageParser parser;
> >      bool pretty;
> > +    MonitorQMPCloseAction close_action;
> >      bool setup_pending; /* iothread BH has not yet set up chardev handlers */
> > +    bool delete_pending; /* close_action has started 'delete' process */
> >      /*
> >       * When a client connects, we're in capabilities negotiation mode.
> >       * @commands is &qmp_cap_negotiation_commands then.  When command
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 5301927f09f..7257edc19d2 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -28,6 +28,7 @@
> >  #include "monitor-internal.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-control.h"
> > +#include "qapi/qapi-commands-char.h"
> >  #include "qobject/qdict.h"
> >  #include "qobject/qjson.h"
> >  #include "qobject/qlist.h"
> > @@ -103,6 +104,20 @@ static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
> >      mon->pretty = val;
> >  }
> >  
> > +static int monitor_qmp_get_close_action(Object *obj, Error **errp)
> > +{
> > +    MonitorQMP *mon = MONITOR_QMP(obj);
> > +
> > +    return mon->close_action;
> > +}
> > +
> > +static void monitor_qmp_set_close_action(Object *obj, int val, Error **errp)
> > +{
> > +    MonitorQMP *mon = MONITOR_QMP(obj);
> > +
> > +    mon->close_action = val;
> > +}
> > +
> >  static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
> >  static bool monitor_qmp_requires_iothread(const Monitor *mon);
> >  static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
> > @@ -117,6 +132,11 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
> >      object_class_property_add_bool(cls, "pretty",
> >                                     monitor_qmp_get_pretty,
> >                                     monitor_qmp_set_pretty);
> > +    object_class_property_add_enum(cls, "close-action",
> > +                                   "MonitorQMPCloseAction",
> > +                                   &MonitorQMPCloseAction_lookup,
> > +                                   monitor_qmp_get_close_action,
> > +                                   monitor_qmp_set_close_action);
> >  
> >      moncls->emit_event = monitor_qmp_emit_event;
> >      moncls->requires_iothread = monitor_qmp_requires_iothread;
> > @@ -550,11 +570,33 @@ static QDict *qmp_greeting(MonitorQMP *mon)
> >          ver, cap_list);
> >  }
> >  
> > +static void monitor_qmp_self_delete_bh(void *opaque)
> > +{
> > +    MonitorQMP *mon = opaque;
> 
> There is a potential race if object-del is called on the same MonitorQMP before the BH fires.
> 
> > +    g_autofree char *mon_id = object_property_get_child_name(
> > +        object_get_objects_root(), OBJECT(mon));
> > +    g_autofree char *chardev_id = g_strdup(mon->parent_obj.chardev_id);
> > +    Error *local_error = NULL;
> > +
> > +    g_assert(mon_id);
> > +
> > +    user_creatable_del(mon_id, &local_error);
> > +    if (local_error != NULL) {
> > +        error_report_err(local_error);
> > +    } else {
> > +        qmp_chardev_remove(chardev_id, NULL);
> > +    }
> > +}
> > +
> >  static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >  {
> >      QDict *data;
> >      MonitorQMP *mon = opaque;
> >  
> > +    if (mon->delete_pending) {
> > +        return;
> > +    }
> > +
> >      switch (event) {
> >      case CHR_EVENT_OPENED:
> >          WITH_QEMU_LOCK_GUARD(&mon->parent_obj.mon_lock) {
> > @@ -577,6 +619,23 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >          json_message_parser_init(&mon->parser, handle_qmp_command,
> >                                   mon, NULL);
> >          monitor_fdsets_cleanup();
> > +        switch (mon->close_action) {
> > +        case MONITOR_QMP_CLOSE_ACTION_NONE:
> > +            break; /* nada */
> > +        case MONITOR_QMP_CLOSE_ACTION_DELETE:
> > +            mon->delete_pending = true;
> > +            /*
> > +             * Do NOT run in the AIO context associated with the
> > +             * monitor. We need to run in the default AIO context
> > +             * which is the same context in which 'qmp_object_del'
> > +             * will execute
> > +             */
> > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                    monitor_qmp_self_delete_bh, mon);
> 
> ref it?

We should have checked the "delete_pending" flag in the
prepare_delete callback too, to block this situation.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


