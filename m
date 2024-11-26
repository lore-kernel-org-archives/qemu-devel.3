Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793B5D5A6EA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 07:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFpse-0004te-HG; Tue, 26 Nov 2024 02:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tFpsV-0004sy-LE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 02:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tFpsT-0004tR-Lz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 02:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732605651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/t+3zN1N/Z1eFtsFHvzBm9JzfRD3zH5mb3eNt0z7WMA=;
 b=Oa4JbG0f29VED8FsbX0Oiw3EzP9a1Z6U9SdoBNqyXRGZoCHuNUeo4xuv5NZc+pXUC/lzaM
 4mXepZqPjII3/hpAmXJ370sncjr1N0IbPstB21KR5kR0Q9npaKtVURFUsdwJ/9bCQtJlgN
 a6yqa1OI5NQhSqqok6Ll0OHtiDwjC0s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-O8Qmtis3MBu2W0E0Cfso3g-1; Tue,
 26 Nov 2024 02:20:48 -0500
X-MC-Unique: O8Qmtis3MBu2W0E0Cfso3g-1
X-Mimecast-MFC-AGG-ID: O8Qmtis3MBu2W0E0Cfso3g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 974F0195608A; Tue, 26 Nov 2024 07:20:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A757195DF81; Tue, 26 Nov 2024 07:20:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49BDF21E66D2; Tue, 26 Nov 2024 08:20:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: peter.maydell@linaro.org,  richard.henderson@linaro.org,
 philmd@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 alex.bennee@linaro.org,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v3 10/26] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
In-Reply-To: <20241125195626.856992-12-jean-philippe@linaro.org>
 (Jean-Philippe Brucker's message of "Mon, 25 Nov 2024 19:56:09 +0000")
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-12-jean-philippe@linaro.org>
Date: Tue, 26 Nov 2024 08:20:42 +0100
Message-ID: <87wmgqsbp1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Jean-Philippe Brucker <jean-philippe@linaro.org> writes:

> The Realm Personalization Value (RPV) is provided by the user to
> distinguish Realms that have the same initial measurement.
>
> The user provides up to 64 hexadecimal bytes. They are stored into the
> RPV in the same order, zero-padded on the right.
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: Fix documentation
> ---
>  qapi/qom.json        |  15 ++++++
>  target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index a8beeabf1f..f982850bca 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1068,6 +1068,19 @@
>    'data': { '*cpu-affinity': ['uint16'],
>              '*node-affinity': ['uint16'] } }
>=20=20
> +##
> +# @RmeGuestProperties:
> +#
> +# Properties for rme-guest objects.
> +#
> +# @personalization-value: Realm personalization value, as a 64-byte
> +#     hex string. This optional parameter allows to uniquely identify
> +#     the VM instance during attestation. (default: 0)

QMP commonly uses base64 for encoding binary data.  Any particular
reason to deviate?

Is the "hex string" to be mapped to binary in little or big endian?  Not
an issue with base64.

Nitpick: (default: all-zero), please, for consistency with similar
documentation in SevSnpGuestProperties.

> +#
> +# Since: 9.3
> +##
> +{ 'struct': 'RmeGuestProperties',
> +  'data': { '*personalization-value': 'str' } }
>=20=20
>  ##
>  # @ObjectType:
> @@ -1121,6 +1134,7 @@
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
>      'qtest',
> +    'rme-guest',
>      'rng-builtin',
>      'rng-egd',
>      { 'name': 'rng-random',

The commit message claims the patch adds a parameter.  It actually adds
an entire object type.

> @@ -1195,6 +1209,7 @@
>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties=
',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',
> +      'rme-guest':                  'RmeGuestProperties',
>        'rng-builtin':                'RngProperties',
>        'rng-egd':                    'RngEgdProperties',
>        'rng-random':                 { 'type': 'RngRandomProperties',
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 83a29421df..0be55867ee 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -23,11 +23,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>=20=20
>  #define RME_PAGE_SIZE qemu_real_host_page_size()
>=20=20
> +#define RME_MAX_CFG         1
> +
>  struct RmeGuest {
>      ConfidentialGuestSupport parent_obj;
>      Notifier rom_load_notifier;
>      GSList *ram_regions;
>=20=20
> +    uint8_t *personalization_value;
> +
>      hwaddr ram_base;
>      size_t ram_size;
>  };
> @@ -43,6 +47,48 @@ typedef struct {
>=20=20
>  static RmeGuest *rme_guest;
>=20=20
> +static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
> +{
> +    int ret;
> +    const char *cfg_str;
> +    struct kvm_cap_arm_rme_config_item args =3D {
> +        .cfg =3D cfg,
> +    };
> +
> +    switch (cfg) {
> +    case KVM_CAP_ARM_RME_CFG_RPV:
> +        if (!guest->personalization_value) {
> +            return 0;
> +        }
> +        memcpy(args.rpv, guest->personalization_value, KVM_CAP_ARM_RME_R=
PV_SIZE);
> +        cfg_str =3D "personalization value";
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }

This function gets called with @cfg arguments 0 .. RME_MAX_CFG-1, from
rme_configure() right below.  RME_MAX_CFG is defined to 1 above.

The switch assumes KVM_CAP_ARM_RME_CFG_RPV is zero.  Such assumptions
are ideally avoided, and alternatively checked at build time.

> +
> +    ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
> +                            KVM_CAP_ARM_RME_CONFIG_REALM, (intptr_t)&arg=
s);
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "failed to configure %s", cfg_str);
> +    }
> +    return ret;
> +}
> +
> +static int rme_configure(Error **errp)
> +{
> +    int ret;
> +    int cfg;
> +
> +    for (cfg =3D 0; cfg < RME_MAX_CFG; cfg++) {
> +        ret =3D rme_configure_one(rme_guest, cfg, errp);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static int rme_init_ram(hwaddr base, size_t size, Error **errp)
>  {
>      int ret;
> @@ -123,6 +169,10 @@ static int rme_create_realm(Error **errp)
>  {
>      int ret;
>=20=20
> +    if (rme_configure(errp)) {
> +        return -1;
> +    }
> +
>      ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
>                              KVM_CAP_ARM_RME_CREATE_RD);
>      if (ret) {
> @@ -168,8 +218,69 @@ static void rme_vm_state_change(void *opaque, bool r=
unning, RunState state)
>      }
>  }
>=20=20
> +static char *rme_get_rpv(Object *obj, Error **errp)
> +{
> +    RmeGuest *guest =3D RME_GUEST(obj);
> +    GString *s;
> +    int i;
> +
> +    if (!guest->personalization_value) {
> +        return NULL;
> +    }
> +
> +    s =3D g_string_sized_new(KVM_CAP_ARM_RME_RPV_SIZE * 2 + 1);
> +
> +    for (i =3D 0; i < KVM_CAP_ARM_RME_RPV_SIZE; i++) {
> +        g_string_append_printf(s, "%02x", guest->personalization_value[i=
]);
> +    }

The size of the destrination string is known at compile time.  Why grow
it dynamically?

Base64 would take less code.

> +
> +    return g_string_free(s, /* free_segment */ false);
> +}
> +
> +static void rme_set_rpv(Object *obj, const char *value, Error **errp)
> +{
> +    RmeGuest *guest =3D RME_GUEST(obj);
> +    size_t len =3D strlen(value);
> +    uint8_t *out;
> +    int i =3D 1;
> +    int ret;
> +
> +    g_free(guest->personalization_value);
> +    guest->personalization_value =3D out =3D g_malloc0(KVM_CAP_ARM_RME_R=
PV_SIZE);
> +
> +    /* Two chars per byte */
> +    if (len > KVM_CAP_ARM_RME_RPV_SIZE * 2) {
> +        error_setg(errp, "Realm Personalization Value is too large");
> +        return;
> +    }
> +
> +    /* First byte may have a single char */
> +    if (len % 2) {
> +        ret =3D sscanf(value, "%1hhx", out++);
> +    } else {
> +        ret =3D sscanf(value, "%2hhx", out++);
> +        i++;
> +    }
> +    if (ret !=3D 1) {
> +        error_setg(errp, "Invalid Realm Personalization Value");
> +        return;
> +    }
> +
> +    for (; i < len; i +=3D 2) {
> +        ret =3D sscanf(value + i, "%2hhx", out++);
> +        if (ret !=3D 1) {
> +            error_setg(errp, "Invalid Realm Personalization Value");
> +            return;
> +        }
> +    }

Looks like this supports hex strings shorter than
KVM_CAP_ARM_RME_RPV_SIZE * 2.  How these get padded is not documented.
Fixable, but are you sure the convenience is worth the complexity?

Again, base64 would take less code.

> +}
> +
>  static void rme_guest_class_init(ObjectClass *oc, void *data)
>  {
> +    object_class_property_add_str(oc, "personalization-value", rme_get_r=
pv,
> +                                  rme_set_rpv);
> +    object_class_property_set_description(oc, "personalization-value",
> +            "Realm personalization value (512-bit hexadecimal number)");
>  }
>=20=20
>  static void rme_guest_init(Object *obj)


