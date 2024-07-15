Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB87C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 11:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTK2R-0002HN-DM; Mon, 15 Jul 2024 07:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTK2H-0002Gk-MD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTK2F-0003jq-MP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721043505;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=k3p6ApcxFKtqnEI13qGGmaLWKt4ivOFShrfkDB4Qfsw=;
 b=ELOGApNlzwFIvAhqSUPSnEdMBOsJitRpvlQjEQvpAeMGVeSvSfdg/jy9YtChzMLG0Qyrub
 Dd56Gh70xiQxBVOzb1yz4vl42rN33Ya4J8zulEQ6560A+TgzfLoH2+v2Nm8Y7xRZAI6IpZ
 2PMFc/tnNcKJIrTO+B475Hso9rwMwcc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-T4VCQ8CoNIuQNljmoBm4wg-1; Mon,
 15 Jul 2024 07:38:22 -0400
X-MC-Unique: T4VCQ8CoNIuQNljmoBm4wg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 648B01955D52; Mon, 15 Jul 2024 11:38:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 216891955E80; Mon, 15 Jul 2024 11:38:14 +0000 (UTC)
Date: Mon, 15 Jul 2024 12:38:11 +0100
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
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/5] qdev-properties: Accept bool for OnOffAuto
Message-ID: <ZpUKI6ARTpGXI3Oi@redhat.com>
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
 <20240714-auto-v3-1-e27401aabab3@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240714-auto-v3-1-e27401aabab3@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jul 14, 2024 at 02:11:01PM +0900, Akihiko Odaki wrote:
> Accept bool literals for OnOffAuto properties for consistency with bool
> properties.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/core/qdev-properties.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 86a583574dd0..f0a270bb4f61 100644
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

IMHO this is highly undesirable. It is adding redundant new syntax
across countless places in QEMU that use OnOffAuto.

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
>  
> 
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


