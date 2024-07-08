Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EA8C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjJF-0006lt-Gw; Mon, 08 Jul 2024 04:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sQjJE-0006ku-ED
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sQjJC-0006pW-2h
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720425672;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0rwjnCRKTQdedvrkNO3y6YI4VU4Fa04C1ZUujeH4CEM=;
 b=At5JLXEeOl9VIV1SFO/ZW8Ik9Rnq54/E480padeIwMM2kAQuD7WQIRtCQTK9hmsAHNGD7J
 i+KG85/0CtOpnlunW5mIrd8vYoweYoOr3diCav4zp1+92pEWjYHx4bfSc1xT4fIZ7PNQX/
 twwKuUSVF2+mueNHzvkK48OZVLgyHqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-0-7ypLL1Mnm7qBwy1QODoQ-1; Mon,
 08 Jul 2024 04:01:02 -0400
X-MC-Unique: 0-7ypLL1Mnm7qBwy1QODoQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FD1B1955E9A; Mon,  8 Jul 2024 08:01:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7C091955E85; Mon,  8 Jul 2024 08:00:53 +0000 (UTC)
Date: Mon, 8 Jul 2024 09:00:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <ZoucsqZBEjrlWYC8@redhat.com>
References: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
 <20240706-rombar-v1-3-802daef2aec1@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706-rombar-v1-3-802daef2aec1@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 06, 2024 at 06:29:23PM +0900, Akihiko Odaki wrote:
> rom_bar is tristate but was defined as uint32_t so convert it into
> OnOffAuto to clarify that. For compatibility, a uint32 value set via
> QOM will be converted into OnOffAuto.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/igd-assign.txt               |  2 +-
>  include/hw/pci/pci_device.h       |  2 +-
>  hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
>  hw/vfio/pci-quirks.c              |  2 +-
>  hw/vfio/pci.c                     | 11 ++++----
>  hw/xen/xen_pt_load_rom.c          |  4 +--
>  tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
>  7 files changed, 81 insertions(+), 29 deletions(-)

> +static void rom_bar_set(Object *obj, Visitor *v, const char *name, void *opaque,
> +                        Error **errp)
> +{
> +    Property *prop = opaque;
> +    Error *local_err = NULL;
> +    int *ptr = object_field_prop_ptr(obj, prop);
> +    uint32_t value;
> +
> +    visit_type_enum(v, name, ptr, prop->info->enum_table, &local_err);
> +    if (!local_err) {
> +        return;
> +    }
> +
> +    if (visit_type_uint32(v, name, &value, NULL)) {
> +        if (value) {
> +            *ptr = ON_OFF_AUTO_ON;
> +            warn_report("Specifying a number for rombar is deprecated; replace a non-zero value with 'on'");
> +        } else {
> +            *ptr = ON_OFF_AUTO_OFF;
> +            warn_report("Specifying a number for rombar is deprecated; replace 0 with 'off'");
> +        }

If you're going to say something is deprecated, you need to update
the deprecated.rst docs to make this visible to users.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


