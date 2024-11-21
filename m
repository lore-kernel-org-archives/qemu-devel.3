Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C062ED711CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE4Sy-0001Uc-6e; Thu, 21 Nov 2024 05:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4SS-0001TE-K1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4SQ-0003W5-Hm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732185041;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wCKbNJSJrvVsQtpRBgMtzic3x98d61Ff3lr76iKp3t0=;
 b=c5E3XVZt+7CkmAe9iC6jfFf3fhozk8ymsnm5iKB6J+6ZLoI/2QZn2nZAYZqqS1xZAe1XJ5
 dzfVy5haLrK7W7iUsrMngsM7KsP8IjBcwqWpo9PdEcEA3g2jmOzRg0PaFa4osiTmxg/SsA
 6+RbeBXxTat278kM6tc6sNfY7A5sSB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-tZ3S0123OhG3iFRBJJwieg-1; Thu,
 21 Nov 2024 05:30:36 -0500
X-MC-Unique: tZ3S0123OhG3iFRBJJwieg-1
X-Mimecast-MFC-AGG-ID: tZ3S0123OhG3iFRBJJwieg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C64E6195608B; Thu, 21 Nov 2024 10:30:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C46A230000DF; Thu, 21 Nov 2024 10:30:30 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:30:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
Message-ID: <Zz8LwhXsa6ail5qo@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120215703.3918445-11-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Nov 20, 2024 at 04:57:01PM -0500, Peter Xu wrote:
> Always explicitly create QEMU system containers upfront.
> 
> Root containers will be created when trying to fetch the root object the
> 1st time.  Machine sub-containers will be created only until machine is
> being initialized.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/machine.c | 19 ++++++++++++++++---
>  qom/object.c      | 16 +++++++++++++++-
>  2 files changed, 31 insertions(+), 4 deletions(-)


> diff --git a/qom/object.c b/qom/object.c
> index 214d6eb4c1..810e6f2bd9 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>      return prop->type;
>  }
>  
> +static Object *object_root_initialize(void)
> +{
> +    Object *root = object_new(TYPE_CONTAINER);
> +
> +    /*
> +     * Create all QEMU system containers.  "machine" and its sub-containers
> +     * are only created when machine initializes (qemu_create_machine()).
> +     */
> +    container_create(root, "chardevs");
> +    container_create(root, "objects");

This is where I would expect 'backend' to have been created
rather than ui/console.c, though you could potentially make
a case to create it from the machine function, snice console
stuff can't be used outside of the machine context, while
chardevs/objects can be used in qemu-img/qemu-nbd, etc

> +
> +    return root;
> +}


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


