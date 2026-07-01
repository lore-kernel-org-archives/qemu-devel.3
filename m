Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE2FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoUf-0003Zv-Sh; Wed, 01 Jul 2026 02:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weoUb-0003Zf-UZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weoUZ-0001eb-R7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782887534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Thpg+Vt/mLZj4tpNwbiBgBZ+gWdtfAYh5Qxh/Ln79Q=;
 b=UBkYZGIVe/D2nEYQngAOlZjce04uyaBkXoLzJywwMSG+3QFp/3hfmtYUm9DWO/nbtzYaAU
 qETJxMEY4CvgPicxopXlg4OOCy5DDG38Mlm/rdcOjgATzrXLyGkVS/v5C5MUz6L1OATVJN
 5lpwiefeOife47N/y/f8qN56e4oY5xM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-6NAWAt1JNA2khDVkNoDoIg-1; Wed,
 01 Jul 2026 02:32:11 -0400
X-MC-Unique: 6NAWAt1JNA2khDVkNoDoIg-1
X-Mimecast-MFC-AGG-ID: 6NAWAt1JNA2khDVkNoDoIg_1782887530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB1B3185D680; Wed,  1 Jul 2026 06:32:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAEF41800591; Wed,  1 Jul 2026 06:32:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B4E221E6920; Wed, 01 Jul 2026 08:32:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 32/35] monitor: add support for auto-deleting
 monitors upon close
In-Reply-To: <178233405051.3955748.10990724544083287885.b4-review@b4>
 (marcandre lureau's message of "Thu, 25 Jun 2026 00:47:30 +0400")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
 <178233405051.3955748.10990724544083287885.b4-review@b4>
Date: Wed, 01 Jul 2026 08:32:06 +0200
Message-ID: <87zf0busnt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

marcandre.lureau@redhat.com writes:

>> The default monitor is usually a long lived object that will exist for
>> the entire lifetime of the VM. A monitor can only service a single
>> client at a time though, and so it might be desirable to hotplug
>> additional monitors at runtime for specific tasks. If doing that,
>> however, there is a need to remove the monitor when it is no longer
>> needed.

Whatever adds the additional monitor can also delete it.  The fact that
you propose other means suggests you believe this would be cumbersome in
practice.  Why?

>>=20
>> Allowing a client to run "object-del" against its own monitor adds
>> complex edge cases, as it would be desirable to send the QMP response
>> despite the monitor sending it being deleted. Doing "object-del" alone
>> will also result in orphaning a character device backend instance, as
>> there is no opportunity to run the companion "chardev-del" command.
>>=20
>> A simpler way to ensure cleanup is to add the concept of auto-deleting
>> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
>> emitted, the equivalent of "object-del" + "chardev-del" can be run
>> internally. Since the transient client has already droppped its
>> monitor connection, there is no synchronization to be concerned about.

If object-del or chardev-del fail, there's no way to report the error.
Can they fail?

Do we always want to delete both monitor and character device?

>> This is implemented via a new "close-action=3Dnone|delete" property on
>> the 'monitor-qmp' object. This concept could be extended with further
>> actions in future, for example:
>>=20
>>  * close-action=3Dshutdown - graceful guest shutdown
>>  * close-action=3Dterminate - immediate guest poweroff
>>  * close-action=3Dstop - pause guest CPUs while the monitor is not
>>                        connected to any client

I'm not sure these would be useful and safe.  Mentioning them here is
okay regardless.

>>=20
>> This is left as an exercise for future interested contributors.
>>=20
>> Tested-by: Peter Krempa <pkrempa@redhat.com>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Message-ID: <20260624173752.2928717-33-berrange@redhat.com>
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 6affb70a594..b4c49a2e8b9 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1213,18 +1213,37 @@
>>    'base': 'MonitorProperties',
>>    'data': { '*readline': 'bool' } }
>>=20=20
>> +
>> +##
>> +# @MonitorQMPCloseAction:
>> +#
>> +# Action to take when the character device backend is

No line break here.

>> +# closed.
>> +#
>> +# @none: take no action (the default)

The type cannot specify a default, only its users can.  Scratch (the
default).

Blank line between member descriptions, please.

>> +# @delete: delete both the 'monitor-qmp' object and its associated
>> +#          character device backend object

Format like

    # @delete: delete both the 'monitor-qmp' object and its associated
    #     character device backend object

>> +#
>> +# Since 11.1
>
> should be "Since: 11.1" (worth a new check perhaps)

docs/devel/qapi-code-gen.rst:

    Section tags are case-sensitive and end with a colon.  They are only
    recognized after a blank line.  Good example::

     #
     # Since: 7.1

    Bad examples (all ordinary paragraphs)::

     # since: 7.1

     # Since 7.1

     # Since : 7.1

There are a few bad ones in master.  I posted a patch:

    Subject: [PATCH] qapi: Fix misspelled section tags in doc comments
    Date: Wed, 1 Jul 2026 08:11:36 +0200
    Message-ID: <20260701061136.798815-1-armbru@redhat.com>

Code to detect and reject such errors would have to carefully avoid
false negatives.

>> +##
>> +{ 'enum' : 'MonitorQMPCloseAction',
>
> extra space, vs the usual '{ 'enum':'.

Yes.

>> +  'data': ['none', 'delete'] }
>> +
>>  ##
>>  # @MonitorQMPProperties:
>>  #
>>  # Properties for the QMP monitor
>>  #
>>  # @pretty: whether to pretty print JSON responses (default: disabled)

(default: false)

See my review of PATCH 22.

Blank line between member descriptions, please.

>> +# @close-action: action to take when the character device backend
>> +#                is closed (default: none)

Format like

    # @close-action: action to take when the character device backend is
    #     closed (default: none)

>>  #
>>  # Since: 11.1
>>  ##
>>  { 'struct': 'MonitorQMPProperties',
>>    'base': 'MonitorProperties',
>> -  'data': { '*pretty': 'bool' } }
>> +  'data': { '*pretty': 'bool',
>> +            '*close-action': 'MonitorQMPCloseAction' } }
>>=20=20
>>  ##
>>  # @ObjectType:
>> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
>> index 5522e05464b..23829f32f9a 100644
>> --- a/monitor/monitor-internal.h
>> +++ b/monitor/monitor-internal.h
>> @@ -28,6 +28,7 @@
>>  #include "chardev/char-fe.h"
>>  #include "monitor/monitor.h"
>>  #include "qapi/qapi-types-control.h"
>> +#include "qapi/qapi-types-qom.h"
>>  #include "qapi/qmp-registry.h"
>>  #include "qobject/json-parser.h"
>>  #include "qemu/readline.h"
>> @@ -178,7 +179,9 @@ struct MonitorQMP {
>>      Monitor parent_obj;
>>      JSONMessageParser parser;
>>      bool pretty;
>> +    MonitorQMPCloseAction close_action;
>>      bool setup_pending; /* iothread BH has not yet set up chardev handl=
ers */
>> +    bool delete_pending; /* close_action has started 'delete' process */
>>      /*
>>       * When a client connects, we're in capabilities negotiation mode.
>>       * @commands is &qmp_cap_negotiation_commands then.  When command
>> diff --git a/monitor/qmp.c b/monitor/qmp.c
>> index 5301927f09f..1057b0d12ba 100644
>> --- a/monitor/qmp.c
>> +++ b/monitor/qmp.c
>> @@ -28,6 +28,7 @@
>>  #include "monitor-internal.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qapi-commands-control.h"
>> +#include "qapi/qapi-commands-char.h"
>>  #include "qobject/qdict.h"
>>  #include "qobject/qjson.h"
>>  #include "qobject/qlist.h"
>> @@ -103,6 +104,20 @@ static void monitor_qmp_set_pretty(Object *obj, boo=
l val, Error **errp)
>>      mon->pretty =3D val;
>>  }
>>=20=20
>> +static int monitor_qmp_get_close_action(Object *obj, Error **errp)
>> +{
>> +    MonitorQMP *mon =3D MONITOR_QMP(obj);
>> +
>> +    return mon->close_action;
>> +}
>> +
>> +static void monitor_qmp_set_close_action(Object *obj, int val, Error **=
errp)
>> +{
>> +    MonitorQMP *mon =3D MONITOR_QMP(obj);
>> +
>> +    mon->close_action =3D val;
>> +}
>> +
>>  static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict=
 *qdict);
>>  static bool monitor_qmp_requires_iothread(const Monitor *mon);
>>  static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
>> @@ -117,6 +132,11 @@ static void monitor_qmp_class_init(ObjectClass *cls=
, const void *data)
>>      object_class_property_add_bool(cls, "pretty",
>>                                     monitor_qmp_get_pretty,
>>                                     monitor_qmp_set_pretty);
>> +    object_class_property_add_enum(cls, "close-action",
>> +                                   "MonitorQMPCloseAction",
>> +                                   &MonitorQMPCloseAction_lookup,
>> +                                   monitor_qmp_get_close_action,
>> +                                   monitor_qmp_set_close_action);
>>=20=20
>>      moncls->emit_event =3D monitor_qmp_emit_event;
>>      moncls->requires_iothread =3D monitor_qmp_requires_iothread;
>> @@ -550,11 +570,45 @@ static QDict *qmp_greeting(MonitorQMP *mon)
>>          ver, cap_list);
>>  }
>>=20=20
>> +static void monitor_qmp_self_delete_bh(void *opaque)
>> +{
>> +    MonitorQMP *mon =3D opaque;
>> +    g_autofree char *mon_id =3D object_property_get_child_name(
>> +        object_get_objects_root(), OBJECT(mon));
>> +    g_autofree char *chardev_id =3D g_strdup(mon->parent_obj.chardev_id=
);
>> +    Error *local_error =3D NULL;
>> +
>> +    if (!mon_id) {
>> +        /* Another monitor raced & ran 'object-del' on 'mon'
>> +         * before this BH got scheduled, so we have a ref on
>> +         * mon but it is already unparented.
>> +         */
>> +        object_unref(mon);
>> +        return;
>> +    }
>> +
>> +    user_creatable_del(mon_id, &local_error);
>> +    object_unref(mon);

This object_unref() and the one above pair with the object_ref() in
monitor_qmp_event() case MONITOR_QMP_CLOSE_ACTION_DELETE.  Correct?

Is this worth a comment?

>> +    if (local_error !=3D NULL) {
>> +        error_report_err(local_error);
>> +    } else {
>> +        qmp_chardev_remove(chardev_id, NULL);
>> +    }
>> +}
>> +
>>  static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>>  {
>>      QDict *data;
>>      MonitorQMP *mon =3D opaque;
>>=20=20
>> +    /* Protect against race if a client drops & quickly
>> +     * reconnects - we'll have the delete BH scheduled
>> +     * so must not honour a new open request
>> +     */
>> +    if (mon->delete_pending) {
>> +        return;
>> +    }

Consider "something happens between setting @delete_pending and monitor
destruction that triggers the event" and "same thing happens after
destruction".  Any observable differences in behavior?

Are there any other monitor interactions that might need similar
special-casing when @delete_pending?

>> +
>>      switch (event) {
>>      case CHR_EVENT_OPENED:
>>          WITH_QEMU_LOCK_GUARD(&mon->parent_obj.mon_lock) {
>> @@ -577,6 +631,27 @@ static void monitor_qmp_event(void *opaque, QEMUChr=
Event event)
>>          json_message_parser_init(&mon->parser, handle_qmp_command,
>>                                   mon, NULL);
>>          monitor_fdsets_cleanup();
>> +        switch (mon->close_action) {
>> +        case MONITOR_QMP_CLOSE_ACTION_NONE:
>> +            break; /* nada */

Useless comment :)

>> +        case MONITOR_QMP_CLOSE_ACTION_DELETE:
>> +            mon->delete_pending =3D true;
>> +            /*
>> +             * Do NOT run in the AIO context associated with the
>> +             * monitor. We need to run in the default AIO context
>> +             * which is the same context in which 'qmp_object_del'
>> +             * will execute

I believe you.  I don't have the headspace right now to confirm this
myself.

>> +             *
>> +             * Hold an extra ref in case a separate monitor races
>> +             * with the BH by processing an explicit 'object-del'

The extra ref ensures the object still lives when the BH runs.  Correct?

>> +             */
>> +            object_ref(mon);

This is the object_ref() I referred to above.

>> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> +                                    monitor_qmp_self_delete_bh, mon);
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>>          break;
>>      case CHR_EVENT_BREAK:
>>      case CHR_EVENT_MUX_IN:

[...]

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


