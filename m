Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ACEC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 15:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfhL7-0007tv-WE; Wed, 05 Feb 2025 10:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfhL6-0007tJ-Vy
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 10:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfhL4-0005AF-Gf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 10:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738769356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUEDkOrAZE4Odz0LlC7fhF3OyCDGO8AwENKpnafkJ+g=;
 b=H/xXyKR/aR0Q4dWFwg71JUbH3cwwpB3l0jPuRcpFmGKSbYFHFcoOwnOg8XqRcZqWbcMuUU
 QKVcNoIPZ0AzDP/TaJsoipYyQ9myUphh3zqQnZI28qIqFZ2j1zJHOu0f4J8SW/q1Th2phv
 hRfzKauBSIOp2kOmrkAJ/eLNP5tGfnU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-OfLVFOczO5O6uCEE7dd7mQ-1; Wed,
 05 Feb 2025 10:29:10 -0500
X-MC-Unique: OfLVFOczO5O6uCEE7dd7mQ-1
X-Mimecast-MFC-AGG-ID: OfLVFOczO5O6uCEE7dd7mQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94A4F195609D; Wed,  5 Feb 2025 15:29:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E14195608D; Wed,  5 Feb 2025 15:29:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2143721E6A28; Wed, 05 Feb 2025 16:29:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,  Dmitry Fleytman
 <dmitry.fleytman@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,  Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>,  Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Michael Roth <michael.roth@amd.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Lei Yang <leiyang@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
In-Reply-To: <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> (Akihiko Odaki's
 message of "Wed, 08 Jan 2025 15:17:51 +0900")
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
Date: Wed, 05 Feb 2025 16:29:03 +0100
Message-ID: <87cyfwxveo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Accept bool literals for OnOffAuto properties for consistency with bool
> properties. This enables users to set the "on" or "off" value in a
> uniform syntax without knowing whether the "auto" value is accepted.
> This behavior is especially useful when converting an existing bool
> property to OnOffAuto or vice versa.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/core/qdev-properties.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 434a76f5036e..0081d79f9b7b 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
>      .set   = set_string,
>  };
>  
> +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    Property *prop = opaque;
> +    int *ptr = object_field_prop_ptr(obj, prop);
> +    bool value;
> +
> +    if (visit_type_bool(v, name, &value, NULL)) {
> +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +        return;
> +    }
> +
> +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
> +}
> +
>  /* --- on/off/auto --- */
>  
>  const PropertyInfo qdev_prop_on_off_auto = {
> @@ -498,7 +513,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
>      .description = "on/off/auto",
>      .enum_table = &OnOffAuto_lookup,
>      .get = qdev_propinfo_get_enum,
> -    .set = qdev_propinfo_set_enum,
> +    .set = set_on_off_auto,
>      .set_default_value = qdev_propinfo_set_default_value_enum,
>  };

The qdev properties defined with DEFINE_PROP_ON_OFF_AUTO() now
additionally accept bool.

The commit message tries to explain why this change is useful, but it
leaves me confused.

Does this solve a problem with existing properties?  If yes, what
exactly is the problem?

Or does this enable new uses of DEFINE_PROP_ON_OFF_AUTO()?

I'm trying to understand, but my gut feeling is "bad idea".

Having multiple ways to express the same thing is generally undesirable.
In this case, "foo": "on" and "foo": true, as well as "foo": "off" and
"foo": false.

Moreover, OnOffAuto then has two meanings: straightfoward enum as
defined in the QAPI schema, and the funny qdev property.  This is
definitely a bad idea.  DEFINE_PROP_T(), where T is some QAPI type,
should accept *exactly* the values of T.  If these properties need to
accept something else, use another name to not invite confusion.

If I understand the cover letter correctly, you want to make certain
bool properties tri-state for some reason.  I haven't looked closely
enough to judge whether that makes sense.  But do you really have to
change a whole bunch of unrelated properties to solve your problem?
This is going to be a very hard sell.


