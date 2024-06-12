Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F6FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJNJ-0000sK-QR; Wed, 12 Jun 2024 04:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHJNI-0000s9-OD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHJNG-0001SA-Sm
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718181028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5J4zs9cJmmGO99W/I3dfSsAXt52SURVOm8dXnZpoitc=;
 b=K855uRH1EAWkW24U+5JB/FlYX0HY0ROXpGCgGaeHkM2vKXcd7ONdCb6dQQrGiv1KBy2Unn
 4wtkwgcWGP9WMpB4nn+ibCyVaWiRSxO5Sc6XOfdV+ycAnP55HRIkowzseHcAdfq+1X455u
 krLkdzDTy40MmAb0Oe+EzIcGuCbuGh4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-u-i3Bp7PPA6ez7I0URP8AQ-1; Wed,
 12 Jun 2024 04:30:25 -0400
X-MC-Unique: u-i3Bp7PPA6ez7I0URP8AQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55F2919560B2; Wed, 12 Jun 2024 08:30:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D392D19560AE; Wed, 12 Jun 2024 08:30:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0F1A21E6757; Wed, 12 Jun 2024 10:30:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 4/4] qdev: add device policy [RfC]
In-Reply-To: <20240606143010.1318226-5-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Thu, 6 Jun 2024 16:30:10 +0200")
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-5-kraxel@redhat.com>
Date: Wed, 12 Jun 2024 10:30:21 +0200
Message-ID: <87le3aftr6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Gerd Hoffmann <kraxel@redhat.com> writes:

> Add policies for devices which are deprecated or not secure.
> There are three options: allow, warn and deny.
>
> It's implemented for devices only.  Devices will probably be the main
> user of this.  Also object_new() can't fail as of today so it's a bit
> hard to implement policy checking at object level, especially the 'deny'
> part of it.
>
> TODO: add a command line option to actually set these policies.
>
> Comments are welcome.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/core/qdev.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f3a996f57dee..0c4e5cec743c 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -43,6 +43,15 @@
>  static bool qdev_hot_added = false;
>  bool qdev_hot_removed = false;
>  
> +enum qdev_policy {
> +    QDEV_ALLOW = 0,
> +    QDEV_WARN  = 1,
> +    QDEV_DENY  = 2,
> +};
> +
> +static enum qdev_policy qdev_deprecated_policy;
> +static enum qdev_policy qdev_not_secure_policy;
> +
>  const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
>  {
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
> @@ -144,6 +153,43 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
>      return true;
>  }
>  
> +static bool qdev_class_check(const char *name, ObjectClass *oc)
> +{
> +    bool allow = true;
> +
> +    if (oc->deprecated) {
> +        switch (qdev_deprecated_policy) {
> +        case QDEV_WARN:
> +            warn_report("device \"%s\" is deprecated", name);
> +            break;
> +        case QDEV_DENY:
> +            error_report("device \"%s\" is deprecated", name);
> +            allow = false;
> +            break;
> +        default:
> +            /* nothing */
> +            break;
> +        }
> +    }
> +
> +    if (oc->not_secure) {
> +        switch (qdev_not_secure_policy) {
> +        case QDEV_WARN:
> +            warn_report("device \"%s\" is not secure", name);
> +            break;
> +        case QDEV_DENY:
> +            error_report("device \"%s\" is not secure", name);
> +            allow = false;
> +            break;
> +        default:
> +            /* nothing */
> +            break;
> +        }
> +    }
> +
> +    return allow;
> +}
> +
>  DeviceState *qdev_new(const char *name)
>  {
>      ObjectClass *oc = object_class_by_name(name);
> @@ -162,14 +208,26 @@ DeviceState *qdev_new(const char *name)
>          error_report("unknown type '%s'", name);
>          abort();
>      }
> +
> +    if (!qdev_class_check(name, oc)) {

Anti-pattern: use of error_report() from within a function that returns
an error via Error **errp argument.

One such call chain: QMP core -> qmp_device_add() -> qdev_device_add()
-> qdev_device_add_from_qdict() -> qdev_new().  Your error message goes
to stderr, which is wrong.

> +        exit(1);

Worse, QMP command device_add can now kill the guest instantly.

You need to lift the check up the call chains some.

> +    }
> +
>      return DEVICE(object_new(name));
>  }
>  
>  DeviceState *qdev_try_new(const char *name)
>  {
> -    if (!module_object_class_by_name(name)) {
> +    ObjectClass *oc = module_object_class_by_name(name);
> +
> +    if (!oc) {
>          return NULL;
>      }
> +
> +    if (!qdev_class_check(name, oc)) {
> +        return NULL;
> +    }
> +
>      return DEVICE(object_new(name));
>  }


