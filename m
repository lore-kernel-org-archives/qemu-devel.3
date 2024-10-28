Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA78D3399E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Swe-0006n5-IR; Mon, 28 Oct 2024 12:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5Swc-0006mt-Sy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5Swb-0002Hg-0r
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730134215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vSaHk1KpDjz+u6S0LBVuCzzu2JvDKd3r3is6kVM/rVc=;
 b=StipPaMrFsSfwZPeNlCFSfp4ETDg9pqOXy0U5Iy8VAYt0FZgErtKc0hLGp84DjvPb45HKY
 85WLnVIynuKFeGhZIWP/qFtfqwcnHp3FO1tOBi2N4XSFGgPELgPOt18bjGs7FqqYGmh7IE
 qTbZmjl8vQ6jrwitcpzdmpq6TgNbavE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-gwOx9-ZuO720ErIrZ4mv6w-1; Mon,
 28 Oct 2024 12:50:11 -0400
X-MC-Unique: gwOx9-ZuO720ErIrZ4mv6w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6938719560A2; Mon, 28 Oct 2024 16:50:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E35E119560A2; Mon, 28 Oct 2024 16:50:03 +0000 (UTC)
Date: Mon, 28 Oct 2024 16:50:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
Message-ID: <Zx_AuOl7l5b2UIjG@redhat.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-2-b2394236e053@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022-virtio-v2-2-b2394236e053@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 22, 2024 at 01:50:39PM +0900, Akihiko Odaki wrote:
> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
> bool.

Again, same feedback as last time.

With this design, existing users of DEFINE_PROP_BIT64 that
get converted to DEFINE_PROP_ON_OFF_AUTO_BIT64, in addition
to gaining the desired "auto" value, also gain redundant
'on' and 'off' values as side-effects.

In the next patch, the stated problem is that virtio code
needs to distinguish between bits that are user set, and
bits that are set based on available host backend features.

That doesn't seem to require us to accept any new values
from the user. It should be sufficient to track user
specified features, separately from user specified values.
ie when parsing user input for bitfields, we need to parse
into a pair of fields

  uint64_t has_user_features;  /* which bits were specified */
  uint64_t user_features;      /* values of specified bits*/

> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/qdev-properties.h | 18 ++++++++++++
>  hw/core/qdev-properties.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 09aa04ca1e27..afec53a48470 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -43,11 +43,22 @@ struct PropertyInfo {
>      ObjectPropertyRelease *release;
>  };
>  
> +/**
> + * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
> + * @on_bits: Bitmap of elements with "on".
> + * @auto_bits: Bitmap of elements with "auto".
> + */
> +typedef struct OnOffAutoBit64 {
> +    uint64_t on_bits;
> +    uint64_t auto_bits;
> +} OnOffAutoBit64;
> +
>  
>  /*** qdev-properties.c ***/
>  
>  extern const PropertyInfo qdev_prop_bit;
>  extern const PropertyInfo qdev_prop_bit64;
> +extern const PropertyInfo qdev_prop_on_off_auto_bit64;
>  extern const PropertyInfo qdev_prop_bool;
>  extern const PropertyInfo qdev_prop_enum;
>  extern const PropertyInfo qdev_prop_uint8;
> @@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
>                  .set_default = true,                              \
>                  .defval.u  = (bool)_defval)
>  
> +#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defval) \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,         \
> +                OnOffAutoBit64,                                             \
> +                .bitnr    = (_bit),                                         \
> +                .set_default = true,                                        \
> +                .defval.i = (OnOffAuto)_defval)
> +
>  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
>      DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
>                  .set_default = true,                         \
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f0a270bb4f61..cc76ff0dfae6 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -187,7 +187,8 @@ const PropertyInfo qdev_prop_bit = {
>  
>  static uint64_t qdev_get_prop_mask64(Property *prop)
>  {
> -    assert(prop->info == &qdev_prop_bit64);
> +    assert(prop->info == &qdev_prop_bit64 ||
> +           prop->info == &qdev_prop_on_off_auto_bit64);
>      return 0x1ull << prop->bitnr;
>  }
>  
> @@ -232,6 +233,69 @@ const PropertyInfo qdev_prop_bit64 = {
>      .set_default_value = set_default_value_bool,
>  };
>  
> +static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop = opaque;
> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
> +    int value;
> +    uint64_t mask = qdev_get_prop_mask64(prop);
> +
> +    if (p->auto_bits & mask) {
> +        value = ON_OFF_AUTO_AUTO;
> +    } else if (p->on_bits & mask) {
> +        value = ON_OFF_AUTO_ON;
> +    } else {
> +        value = ON_OFF_AUTO_OFF;
> +    }
> +
> +    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
> +}
> +
> +static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    Property *prop = opaque;
> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
> +    bool bool_value;
> +    int value;
> +    uint64_t mask = qdev_get_prop_mask64(prop);
> +
> +    if (visit_type_bool(v, name, &bool_value, NULL)) {
> +        value = bool_value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +    } else if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
> +        return;
> +    }
> +
> +    switch (value) {
> +    case ON_OFF_AUTO_AUTO:
> +        p->on_bits &= ~mask;
> +        p->auto_bits |= mask;
> +        break;
> +
> +    case ON_OFF_AUTO_ON:
> +        p->on_bits |= mask;
> +        p->auto_bits &= ~mask;
> +        break;
> +
> +    case ON_OFF_AUTO_OFF:
> +        p->on_bits &= ~mask;
> +        p->auto_bits &= ~mask;
> +        break;
> +    }
> +}
> +
> +const PropertyInfo qdev_prop_on_off_auto_bit64 = {
> +    .name  = "OnOffAuto",
> +    .description = "on/off/auto",
> +    .enum_table = &OnOffAuto_lookup,
> +    .get = prop_get_on_off_auto_bit64,
> +    .set = prop_set_on_off_auto_bit64,
> +    .set_default_value = qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- bool --- */
>  
>  static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
> 
> -- 
> 2.47.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


