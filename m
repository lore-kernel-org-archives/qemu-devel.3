Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E30CFD2FD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBcK-0001hZ-GW; Fri, 11 Oct 2024 05:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1szBcH-0001hB-Uh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1szBcE-0001Ji-4M
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728637636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WEYCaYfe9yg7amMWdOmkXI0AsPzyBuohYqzNg8hUGAQ=;
 b=I11DijoMz4EtGJuCXC7IA1ChUuKWfJgaQ5WqcO/pQHQk26s5+Nl/dXJMl8MxUcjWTJjDLm
 ZM5r0vaS2xkgJxaWQV2db5vp21BUgSjrSSSGr4tDUuq4LDRpSyP21Yn9k9JfAhWEAar4yB
 xycxR3qn81vXGowcHE2GxzMfu6k03yg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-09dnO1OJP5qveUOHVaCmCA-1; Fri,
 11 Oct 2024 05:07:12 -0400
X-MC-Unique: 09dnO1OJP5qveUOHVaCmCA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 835CF1955D4D; Fri, 11 Oct 2024 09:07:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC2AC19560AA; Fri, 11 Oct 2024 09:07:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0CFA21E6A28; Fri, 11 Oct 2024 11:07:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Better QAPI/QOM integration
Date: Fri, 11 Oct 2024 11:07:07 +0200
Message-ID: <87wmif9fes.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This memo is heavily indebted to Kevin Wolf.  Its mistakes, however, are
mine.

= Critique of current state =

1. QOM properties serve several purposes: initial configuration
(external interface), run time control and monitoring (external
interface), and internal purposes like versioning.  Which purpose(s) a
property serves is often unclear.  Documentation of the external
interfaces is for the most part poor to nonexistent.

2. QOM properties get created in handwritten C code.  Creation can
depend on state, typically other properties.  This makes QOM
introspection problematic.  It also leads to (commonly undocumented)
restrictions like "must set property X before property Y".

3. QOM introspection uses a primitive, under-documented type system that
is weakly connected to QAPI via names: when qom-list-properties reports
a property's type as "T", and "T" is also the name of a QAPI type, then
the property's type is probably that QAPI type.  This is not documented.

4. QOM doesn't define a life cycle.  Various classes define one of the
form create - set configuration properties - configuration done -
operate.  Variations of "configuration done": realize() for DeviceClass,
complete() for UserCreatableClass, possibly more via
machine_init_done_notifiers.

5. There are two external interfaces for object creation: one for the
subtypes of DeviceClass (QMP: device_add), and one for objects providing
interface UserCreatableClass (QMP: object-add).  The former still
bypasses the QAPI type system.  The latter defines the configuration
interface in the QAPI schema, enabling QAPI introspection.  Properties
used for initial configuration need to be specified twice: once in
handwritten C, and once in the QAPI schema.  Additionally, the type
needs to me made user creatable: once in handwritten C (put
TYPE_USER_CREATABLE into .interface), and twice in the QAPI schema (enum
ObjectType, union ObjectOptions).  Bothersome, and risks inconsistency.
Doing DeviceClass the same way feels unappealing due to the sheer number
of devices and properties.

6. We convert configuration data back and forth.

   QMP/JSON-text
       |
       |  JSON parser
       v
   QMP/QObject
       |
       |  QObject input visitor
       v
   ObjectOptions
       |
       |  QObject output visitor
       v
    QObject
       |
       |  convert & delete members "qom-type" and "id"
       v
     QDict
       |
       |  qobject_input_visitor_new()
       v
   same wrapped in QObject input visitor
       |
       |  for all members: set property
       v
   configuration data in the object

7. QAPI uses IDs to refer to things.  For QOM things, it also uses QOM
paths.  Both are of QAPI type 'str'; what is being references is not
expressed in the schema, only in documentation (hopefully).  QOM does
this better: link<T>.


= Goals =

Addressing all of the above in one go is not feasible.  Smaller steps
are.  Here's one: specify the configuration interface in the QAPI schema
instead of burying it in handwritten C code.

For subclasses of DeviceClass, the configuration moves from C code to
the QAPI schema.

For classes providing interface UserCreatableClass, handwritten C code
duplicating QAPI schema definitions goes away.

Properties that are just for configuration are not created in C anymore.
If needed, QAPI-generated code could create them (read-only).

Introspection of object-add remains unchanged.

Introspection of device_add becomes possible.


= Proposal =

Kevin posted RFC patches that work towards the goals above:

    Subject: [RFC PATCH 00/12] QOM/QAPI integration part 1
    Date: Wed, 3 Nov 2021 18:29:50 +0100
    Message-Id: <20211103173002.209906-1-kwolf@redhat.com>
    https://lore.kernel.org/qemu-devel/20211103173002.209906-1-kwolf@redhat.com/

Aside: yes, it's been a while.  At the time, I didn't get how this
works, and why it's good.  Later I did (with Kevin's patient help), but
had doubts on whether the benefits justify the investment.  Since then,
I've seen potential benefits in various contexts, and I've come around.

The QAPI schema has QAPI type definitions ("enum", "struct", "union",
"alternate"), and QMP definitions ("command", "event").

The QMP definitions use QAPI types.  For convenience, they can define
QAPI types implicitly in places (e.g. with "data", but not with
"returns".  The code generated for QMP is mostly about marshaling
(command and event argument value) and unmarshaling (command return
value).

Kevin proposes to add a QOM definition "class".  As for QMP definitions,
"class" uses QAPI types (possibly defined implicitly), and the generated
code is mostly about unmarshaling (instance configuration value).

Syntax:

    CLASS = { 'class': STRING,
              'parent': STRING,
              (
              '*config': ( MEMBERS | STRING ),
              |
              'config': STRING,
              'config-boxed': true,
              )
              '*if': COND,
              '*features': FEATURES }

The value of @class is the name of the QOM class.

@parent is the name of the QOM parent class.

@if and @features work as usual.

@config and @config-boxed work like command's @data and @boxed: they
specify the arguments of a (handwritten) C function.  For a command,
that's qmp_COMMAND_NAME(), for a class, it's CLASS_NAME_config().

If you embed a boxed argument type in the state struct,
CLASS_NAME_config() can be as simple as

    static bool CLASS_NAME_config(Object *obj, CLASS_NAME_Options *cfg,
                                  Error **errp)
    {
        obj->cfg = *cfg;
        return true;
    }

"class" implicitly defines a QAPI type 'qom-config:CLASS-NAME' to hold
its instance configuration, i.e. the product type of the class's @config
with its parent class's 'qom-config:PARENT-NAME'.  This is for use in
object-add's argument type ObjectOptions, and later in device-add's
QAPIfied argument type.

As long as we define the argument type of instance creation commands
like object-add manually in the QAPI schema, we need the instance
configuration to be a QAPI type.  Use of a name prefix like 'qom-config:
has no precedence in QAPI.  Better ideas welcome.

We could perhaps keep the type out of QAPI if we generated some more.
Whether that's worthwhile is unclear.

QOM classes provide a new method .instance_config() that consume their
instance configuration.  qmp_object_add() has to shunt configuration
data from ObjectOptions to the .instance_config() involved, i.e. the
class's and all its parents'.  Employs visitor wizardry.

Incremental QAPIfication of QOM instance configuration makes this
somewhat hairy.  Support for unconverted parent classes in particular:
first, the .instance_config consume their arguments from the visitor,
then what's left in the visitor gets consumed the old-fashioned way with
object_property_set().


= Check against critique of current state =

1. Configuration is now clearly separate from other QOM properties: it's
in the QAPI schema.

2. Configuration is now compile-time static: it's in the QAPI schema.
Restrictions like "must set property X before property Y" are no longer
possible.  Introspection is reliably complete.

3. The weakness of QOM introspection no longer matters, since we can use
query-qmp-schema instead.

4. Life cycle is out of scope.

5. Duplication around object-add is reduced (we drop the handwritten C
code), but not yet eliminated (we still need to add to both ObjectType
and ObjectOptions in the schema).  Further work seems desirable there,
and might be necessary to make full QAPIfication of device_add
practical.  We have more than 2000 devices...

6. We still convert configuration data back and forth.  I figure we
can't get rid of that as long as we need visitor wizardry.


