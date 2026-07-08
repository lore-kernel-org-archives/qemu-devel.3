Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92B8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQLq-0002vZ-At; Wed, 08 Jul 2026 07:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whQLp-0002vI-Al
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whQLm-0004Ve-PD
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783509716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smwwBOS5HOwzcp7k5UVeSa8PFD3wlfJkxP23q9wZ2f4=;
 b=eaNuv2+vnado43XefzJaFZ9+eEL1FlNiAeAPK41N4ODLNHEVPEyYjkf87aNHnY7TILPwAE
 H0m3+mMVpEb4dkNXiMYICTMXYysNiG5XFsuG3txSi7YVMKnvFnhrBBya7FXwGTXhAXSL9p
 0KpSqYEktHWhToXiV8nzGuXUTBcL6q8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-9XfFG_K4OjuWkX0c2r0Nyg-1; Wed,
 08 Jul 2026 07:21:53 -0400
X-MC-Unique: 9XfFG_K4OjuWkX0c2r0Nyg-1
X-Mimecast-MFC-AGG-ID: 9XfFG_K4OjuWkX0c2r0Nyg_1783509712
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FA311800651; Wed,  8 Jul 2026 11:21:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22A7F3000C10; Wed,  8 Jul 2026 11:21:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABF2421E6920; Wed, 08 Jul 2026 13:21:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  mst@redhat.com,  mtosatti@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
In-Reply-To: <ak4lRc9u5ol0DtCM@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 8 Jul 2026 11:24:05 +0100")
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
 <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
 <ak4lRc9u5ol0DtCM@redhat.com>
Date: Wed, 08 Jul 2026 13:21:49 +0200
Message-ID: <87fr1tk9pu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 08, 2026 at 11:16:30AM +0100, Peter Maydell wrote:
>> On Fri, 3 Jul 2026 at 10:09, Mark Cave-Ayland
>> <mark.caveayland@nutanix.com> wrote:
>> >
>> > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> > ---
>> >  include/hw/i386/pc.h | 2 ++
>> >  hw/i386/pc.c         | 8 ++++++++
>> >  hw/i386/pc_sysfw.c   | 7 +------
>> >  3 files changed, 11 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> > index 309de2eda1..16cb0ec01f 100644
>> > --- a/include/hw/i386/pc.h
>> > +++ b/include/hw/i386/pc.h
>> > @@ -40,6 +40,8 @@ typedef struct PCMachineState {
>> >
>> >      Object *alias_pcspk;
>> >      Object *alias_rtc_time;
>> > +    Object *alias_pflash0;
>> > +    Object *alias_pflash1;
>> >
>> >      /* Configuration options: */
>> >      uint64_t max_ram_below_4g;
>> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> > index 13c9c1bfc8..11eef176f4 100644
>> > --- a/hw/i386/pc.c
>> > +++ b/hw/i386/pc.c
>> > @@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *=
oc, const void *data)
>> >                                     offsetof(X86MachineState, acpi_dev=
),
>> >                                     object_property_allow_set_link,
>> >                                     OBJ_PROP_LINK_STRONG);
>> > +    object_class_property_add_alias(oc, "pflash0",
>> > +                                    offsetof(PCMachineState, alias_pf=
lash0),
>> > +                                    TYPE_PFLASH_CFI01,
>> > +                                    "drive");
>> > +    object_class_property_add_alias(oc, "pflash1",
>> > +                                    offsetof(PCMachineState, alias_pf=
lash1),
>> > +                                    TYPE_PFLASH_CFI01,
>> > +                                    "drive");
>>=20
>> Does making these class properties fix
>> https://gitlab.com/qemu-project/qemu/-/work_items/3254
>> (which is a report that "qemu-system-x86_64 -machine pc-q35,help"
>> doesn't list these properties) ?

Not showing object properties is a bug.

Cannot be fixed for object properties that are created outside the
object's instance_init().

Now, object properties created in instance_init() should almost
certainly be class properties instead.  Converting them all fixes the
fixable part of the bug:

> Yes, it ought to, as that CLI logic iterates over class properties.

One property conversion at a time.

There's a quicker fix, though.

-machine TYPE.help uses type_print_class_properties() to show
properties.  Here's its loop:

    object_class_property_iter_init(&iter, klass);
    while ((prop =3D object_property_iter_next(&iter))) {
        if (!prop->set) {
            continue;
        }

        g_ptr_array_add(array,
                        object_property_help(prop->name, prop->type,
                                             prop->defval, prop->descriptio=
n));
    }

-device TYPE,help uses qmp_device_list_properties() to show both.
Here's its loop:

        obj =3D object_new_with_class(klass);

        object_property_iter_init(&iter, obj);
        while ((prop =3D object_property_iter_next(&iter))) {
            ObjectPropertyInfo *info;

            [...]

            info =3D g_new0(ObjectPropertyInfo, 1);
            info->name =3D g_strdup(prop->name);
            info->type =3D g_strdup(prop->type);
            info->description =3D g_strdup(prop->description);
            info->default_value =3D qobject_ref(prop->defval);

            QAPI_LIST_PREPEND(prop_list, info);
        }

        object_unref(obj);

Is there any excuse not to do it this way?


