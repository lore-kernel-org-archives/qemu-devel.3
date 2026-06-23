Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6188FCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzjN-0003Rw-PL; Tue, 23 Jun 2026 07:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbzjL-0003Re-Qh
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbzjJ-0004tP-KX
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782215748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxSnilgD9dKcyVyhwcyJsw+F2T8Okpwxf6No/M3QnhY=;
 b=GjFODehHz4EEnfwhv88cBLhu7SGJiVCecnxQr6UQOpFAPzCKsROV9ZaRIu/+3t/96FyhcW
 vQxDPCFsUtZnvMwGeqtgH/jYrJrn+y8fAMdeI/I8ezkAHKb+nzzGYE8fLzsZbe1assY0BA
 x1o7039L3WNFaE052aQxIQ8mxgzjPRc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-w6ME-g4JMr-so5xmu2EUIA-1; Tue,
 23 Jun 2026 07:55:45 -0400
X-MC-Unique: w6ME-g4JMr-so5xmu2EUIA-1
X-Mimecast-MFC-AGG-ID: w6ME-g4JMr-so5xmu2EUIA_1782215744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C01D1955F27; Tue, 23 Jun 2026 11:55:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 189E71956049; Tue, 23 Jun 2026 11:55:40 +0000 (UTC)
Date: Tue, 23 Jun 2026 12:55:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 32/35] monitor: add support for auto-deleting monitors
 upon close
Message-ID: <ajp0OSbg32-LrZlX@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
 <20260623095551.2106712-33-berrange@redhat.com>
 <178221561777.3416386.3900546214136378913.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178221561777.3416386.3900546214136378913.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 23, 2026 at 03:53:37PM +0400, marcandre.lureau@redhat.com wrote:
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
> > Message-ID: <20260623095551.2106712-33-berrange@redhat.com>
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
> > index 5301927f09f..f6b7fe65bbf 100644
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
> > @@ -550,11 +570,38 @@ static QDict *qmp_greeting(MonitorQMP *mon)
> >          ver, cap_list);
> >  }
> >  
> > +static void monitor_qmp_self_delete_bh(void *opaque)
> > +{
> > +    MonitorQMP *mon = opaque;
> > +    g_autofree char *mon_id = object_property_get_child_name(
> > +        object_get_objects_root(), OBJECT(mon));
> > +    g_autofree char *chardev_id = g_strdup(mon->parent_obj.chardev_id);
> > +    Error *local_error = NULL;
> > +
> > +    g_assert(mon_id);
> 
> If object-del beats this BH, mon_id might be NULL. Return silently?

Yeah, will do.


> > @@ -566,6 +613,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >          qobject_unref(data);
> >          break;
> >      case CHR_EVENT_CLOSED:
> > +        mon->delete_pending = true;
> 
> Shouldn't it be set in the MONITOR_QMP_CLOSE_ACTION_DELETE case only?

Yes, this is the cause of the bug that Peter reported with libvirt
hanging.

> 
> >          /*
> >           * Note: this is only useful when the output of the chardev
> >           * backend is still open.  For example, when the backend is
> > @@ -577,6 +625,26 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >          json_message_parser_init(&mon->parser, handle_qmp_command,
> >                                   mon, NULL);
> >          monitor_fdsets_cleanup();
> > +        switch (mon->close_action) {
> > +        case MONITOR_QMP_CLOSE_ACTION_NONE:
> > +            break; /* nada */
> > +        case MONITOR_QMP_CLOSE_ACTION_DELETE:
> > +            /*
> > +             * Do NOT run in the AIO context associated with the
> > +             * monitor. We need to run in the default AIO context
> > +             * which is the same context in which 'qmp_object_del'
> > +             * will execute
> > +             *
> > +             * Hold an extra ref in case a separate monitor races
> > +             * with the BH by processing an expliciti 'object-del'
> 
> "expliciti" -> "explicit"

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


