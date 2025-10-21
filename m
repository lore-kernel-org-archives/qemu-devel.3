Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCDECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBsi-0004h6-Td; Tue, 21 Oct 2025 08:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBBsR-0004ZY-S9
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBBsO-00082V-Eb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761051244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iH6PuMJGmxGvFdajJJjmEmrdgOHbHtyZw3IVcrS+uXk=;
 b=gatN9FdIQl5S3bYJphl2HjBDmfYsd2D5ZSsDgGx/ssg9LaP7lu42u72y1i78SczVo5DgmL
 +qVHTfuradN4XrMt5xnX+YLgzbKL02h8dLCP3W+mVgqphxZnDCi1hfpB+irOi4zwODLEii
 rhIXD6Vs8efN5ihrdZFOGVwecsDkXSE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-Of459TNONFSywo-E0SYCxA-1; Tue,
 21 Oct 2025 08:54:03 -0400
X-MC-Unique: Of459TNONFSywo-E0SYCxA-1
X-Mimecast-MFC-AGG-ID: Of459TNONFSywo-E0SYCxA_1761051242
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BDC51800592; Tue, 21 Oct 2025 12:54:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 525B130001BE; Tue, 21 Oct 2025 12:54:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EDE521E6A27; Tue, 21 Oct 2025 14:53:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] RFC: qdev: add legacy properties only for those
 print()-able
In-Reply-To: <20251015105419.2975542-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Wed, 15 Oct 2025 14:54:19 +0400")
References: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
Date: Tue, 21 Oct 2025 14:53:59 +0200
Message-ID: <87o6q0mn4o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The link properties are not printed in "info qtree", I don't know if
> this was intentional. We currently register legacy properties for
> link/ptr properties, but they don't have PropertyInfo getters (only
> ObjectPropertyAccessor, when using non-legacy properties)
>
> By not registering a (unusable?) legacy property, "info qtree" can now
> print the link.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-properties.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index b7e8a89ba5..fe260a9670 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1143,14 +1143,13 @@ static void qdev_class_add_legacy_property(Device=
Class *dc, const Property *prop
>  {
>      g_autofree char *name =3D NULL;
>=20=20
> -    /* Register pointer properties as legacy properties */
> -    if (!prop->info->print && prop->info->get) {
> +    if (!prop->info->print) {
>          return;
>      }
>=20=20
>      name =3D g_strdup_printf("legacy-%s", prop->name);
>      object_class_property_add(OBJECT_CLASS(dc), name, "str",
> -        prop->info->print ? qdev_get_legacy_property : prop->info->get,
> +        qdev_get_legacy_property,
>          NULL, NULL, (Property *)prop);
>  }

The old code confuses me.  Let's go through it real slow.

    /**
     * qdev_class_add_legacy_property:
     * @dev: Device to add the property to.
     * @prop: The qdev property definition.
     *
     * Add a legacy QOM property to @dev for qdev property @prop.
     *
     * Legacy properties are string versions of QOM properties.  The format=
 of
     * the string depends on the property type.  Legacy properties are only
     * needed for "info qtree".
     *
     * Do not use this in new code!  QOM Properties added through this inte=
rface
     * will be given names in the "legacy" namespace.
     */
    static void qdev_class_add_legacy_property(DeviceClass *dc, const Prope=
rty *prop)
    {
        g_autofree char *name =3D NULL;

        /* Register pointer properties as legacy properties */

The comment talks about "pointer properties".  We used to call
properties defined with DEFINE_PROP_PTR() that way, but these were
deleted years ago.  The comment is even older.  I'm going to ignore it.

        if (!prop->info->print && prop->info->get) {
            return;
        }

To get here, prop->info->print || !prop->info->get.

        name =3D g_strdup_printf("legacy-%s", prop->name);
        object_class_property_add(OBJECT_CLASS(dc), name, "str",
            prop->info->print ? qdev_get_legacy_property : prop->info->get,
            NULL, NULL, (Property *)prop);

If qdev property @prop has a .print() method, we create a QOM property
"legacy-FOO" of type "str" with qdev_get_legacy_property() as .get(),
and no .set() or .release().

qdev_get_legacy_property() is a QOM .get() wrapping around qdev
.print(): it calls .print() to format the property value as a string
(arbitrarily limited to 1023 characters), then visits it with
visit_type_str().

Aside: there seems to be just one property that implements .print():
DEFINE_PROP_PCI_DEVFN(), in qdev_prop_pci_devfn.  Quite a lot of
infrastructure just for that.

Else, prop->info->get is null, because prop->info->print || !prop->info->ge=
t.
So we create a QOM property "legacy-FOO" with no .get(), .set(),
.release().  Why?

Your patch gets rid of these.  How does this make "info qtree" show link
properties?  Hmm...  qdev_print_props() uses "legacy-FOO" instead of
"FOO" when it exists.  But a "legacy-FOO" without a .get() will fail.
When it does, the property is skipped.

Is this what makes the patch work?

    }


