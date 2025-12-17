Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78449D6408E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 08:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVmoG-0002uD-BL; Wed, 17 Dec 2025 03:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVmoE-0002tx-98
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVmoC-00021Q-R4
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 03:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765959775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bqI8y5CAkeJ2FRE+4SnPfODGf2FeBOFjV1kN+nb9NhU=;
 b=hKxPJ//h6FKZPrf+FTH2wiwBwuU13wbOa8+5Iw5UkVt5BxQmZxLkRDOA9zn/YlCCTcWEDE
 OzOaUQiVzXmBZvnDeONnmzQ52knmujo9tcDP0FFYHZPdOSRNR9K5xfRIXVPxVerCbnJpt+
 /UXE+b5WZ+tBXyK4Hhh57esp7yNUNCE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-AHs1m9AmNwG7ohEpEeOaig-1; Wed,
 17 Dec 2025 03:22:52 -0500
X-MC-Unique: AHs1m9AmNwG7ohEpEeOaig-1
X-Mimecast-MFC-AGG-ID: AHs1m9AmNwG7ohEpEeOaig_1765959771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D8B41800451; Wed, 17 Dec 2025 08:22:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B0CE1800367; Wed, 17 Dec 2025 08:22:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C1FB21E6A27; Wed, 17 Dec 2025 09:22:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zesen Liu <ftyghome@gmail.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH] qdev: fix error handling in set_uint64_checkmask
In-Reply-To: <20251217-qdev-fix-v1-1-bd33ea463220@gmail.com> (Zesen Liu's
 message of "Wed, 17 Dec 2025 11:59:52 +0800")
References: <20251217-qdev-fix-v1-1-bd33ea463220@gmail.com>
Date: Wed, 17 Dec 2025 09:22:48 +0100
Message-ID: <877bulo6uf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Zesen Liu <ftyghome@gmail.com> writes:

> When specifying lbr_fmt=VALUE in cpu options with an invalid VALUE, error_setg() gets triggered twice, causing an assertion failure in error_setv() which requires *errp to be NULL, preventing meaningful error messages from being displayed.
>
> Fix this by checking visit_type_uint64()'s return value and returning early on failure, consistent with other property setters like set_string().
>

Let's add

  Fixes: 18c22d7112a7 (qdev-properties: Add a new macro with bitmask check for uint64_t property)
  Cc: qemu-stable@nongnu.org

> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---
>  hw/core/qdev-properties.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 422a486969..0930d64252 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -494,7 +494,9 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
>      const Property *prop = opaque;
>      uint64_t *ptr = object_field_prop_ptr(obj, prop);
>  
> -    visit_type_uint64(v, name, ptr, errp);
> +    if (!visit_type_uint64(v, name, ptr, errp)) {
> +        return;
> +    }
>      if (*ptr & ~prop->bitmask) {
>          error_setg(errp, "Property value for '%s' has bits outside mask '0x%" PRIx64 "'",
>                     name, prop->bitmask);

Reviewed-by: Markus Armbruster <armbru@redhat.com>

We haven't tagged rc4.  I'll post a PR right away, so we have a chance
to get this fix into 10.2.


