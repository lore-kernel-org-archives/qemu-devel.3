Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96984D6204F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKot-0001rW-Dr; Tue, 19 Nov 2024 04:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKor-0001rL-08
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKoo-0004jV-T9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732009605;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8IHCEjAC7hMC7IhB9fUwvXriM+GzSEZvtUiPOnuuJpg=;
 b=RQMmbcfOLlcnsAWgvHf9qCQJK0bnu1Nwhhy6HzN9SfwU2uqCyKDnU5jDbqJfeIKJTmjZwX
 mkLWzicKET3TTxch8aCRrZetr03FQ/PVImBbqFDTygx88zBN7jtdyrfdkSiEVde2gTAySM
 VmgLrFzV7tPAtchJB+r0Qe8lacNcH0I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-gHEv7o-AOWKApbPD9Gg7AQ-1; Tue,
 19 Nov 2024 04:46:44 -0500
X-MC-Unique: gHEv7o-AOWKApbPD9Gg7AQ-1
X-Mimecast-MFC-AGG-ID: gHEv7o-AOWKApbPD9Gg7AQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02E4519540F1; Tue, 19 Nov 2024 09:46:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62EEC1955F40; Tue, 19 Nov 2024 09:46:39 +0000 (UTC)
Date: Tue, 19 Nov 2024 09:46:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/5] qdev: Make device_set_realized() always safe in tests
Message-ID: <Zzxee1_WHrZvIxqX@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118221330.3480246-4-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 18, 2024 at 05:13:28PM -0500, Peter Xu wrote:
> Currently, a device can be realized even before machine is created, but
> only in one of QEMU's qtest, test-global-qdev-props.c.
> 
> Right now, the test_static_prop_subprocess() test (which creates one simple
> object without machine created) will internally make "/machine" to be a
> container, which may not be expected when developing the test.
> 
> Now explicitly support that case when there's no real "/machine" object
> around, then unattached devices will be put under root ("/") rather than
> "/machine".  Mostly only for this single test case, or for any future test
> cases when some device needs to be realized before the machine is present.
> 
> This shouldn't affect anything else when QEMU runs as an emulator, as that
> always relies on a real machine being created before realizing any devices.
> It's because if "/machine" is wrongly created as a container, it'll fail
> QEMU very soon later on qemu_create_machine() trying to create the real
> machine, conflicting with the "/machine" container.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/qdev.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5f13111b77..eff297e584 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -475,9 +475,17 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>  
>          if (!obj->parent) {
>              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
> +            Object *root = qdev_get_machine();
>  
> -            object_property_add_child(container_get(qdev_get_machine(),
> -                                                    "/unattached"),
> +            /*
> +             * We could have qdev test cases trying to realize() a device
> +             * without machine created.  In that case we use the root.
> +             */
> +            if (!root) {
> +                root = object_get_root();
> +            }

IMHO modifying the qdev.c code to workaround limitations of the test suite
is not a nice approach. Even if it is more work, I'd say it is better to
properly stub a /machine object in the test case, so that it complies with
expectations of qdev.c

> +
> +            object_property_add_child(container_get(root, "/unattached"),
>                                        name, obj);
>              unattached_parent = true;
>              g_free(name);

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


