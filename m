Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67641C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7QR-0004YD-8A; Thu, 06 Mar 2025 04:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tq7QM-0004Xm-OP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:21:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tq7QK-0000H0-8b
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741252906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fE7ocxEBIWLDJiLQCiXw6MUiosAmWceyhwxWZUHTzM=;
 b=L9qhgjDJIz4UEgvUJQ7e2VY+Pj1d3LUGjy3bl12Z9cfNbSXt1sonOes6VI22/fAp0L65Vr
 b3MOOBFVrYa09tUv3bJfXAfG/WFIQCaaxUyt4j0k4RtRIZ4z0v2UXD6/NKMdGUmfbk8BGi
 orjXCegMkGF/v3gZiNfup4XSQ9XlYcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-xgyO-kMTN9GtFWtkMS4LtQ-1; Thu,
 06 Mar 2025 04:21:21 -0500
X-MC-Unique: xgyO-kMTN9GtFWtkMS4LtQ-1
X-Mimecast-MFC-AGG-ID: xgyO-kMTN9GtFWtkMS4LtQ_1741252880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1BBD1800361; Thu,  6 Mar 2025 09:21:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9719B300019E; Thu,  6 Mar 2025 09:21:15 +0000 (UTC)
Date: Thu, 6 Mar 2025 09:21:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
Message-ID: <Z8lpB6XdNPT8zyTa@redhat.com>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305161248.54901-3-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 05, 2025 at 05:12:46PM +0100, Philippe Mathieu-Daudé wrote:
> For legacy ARM binaries, legacy_binary_is_64bit() is
> equivalent of the compile time TARGET_AARCH64 definition.
> 
> Use it as TypeInfo::registerable() callback to dynamically
> add Aarch64 specific types in qemu-system-aarch64 binary,
> removing the need of TARGET_AARCH64 #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/bcm2836.c | 6 ++----
>  hw/arm/raspi.c   | 7 +++----
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 95e16806fa1..88a32e5fc20 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c


> @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] = {
>          .name           = TYPE_BCM2836,
>          .parent         = TYPE_BCM283X,
>          .class_init     = bcm2836_class_init,
> -#ifdef TARGET_AARCH64
>      }, {
>          .name           = TYPE_BCM2837,
>          .parent         = TYPE_BCM283X,
> +        .registerable   = legacy_binary_is_64bit,
>          .class_init     = bcm2837_class_init,
> -#endif
>      }, {
>          .name           = TYPE_BCM283X,
>          .parent         = TYPE_BCM283X_BASE,

So historically we have a subset of machines that are only exposed in
the qemu-system-aarch64 binary, and not qemu-system-arm.

You're attempting to build a single binary to cover both 32 & 64 bit
arm, so need to be able to filter what machines are available to
create when the symlink indicates invokation of the 32-bit binary.

If we extend your approach into the future, we may eventually have
a qemu-system-any with all targets, and symlinks from the legacy
binary names, so need to filter based on target as well as on
32/64-bit.


The reason you want the .registerable callback is so that we can
have a single static list of all machine types passed into
DEFINE_TYPES in bulk, instead of implementing a manual constructor
to do type registration and conditionally calling type_register()
for each type.

So I can understand why you took this approach, but conceptually I'm not
comfortable with the semantics of 'type_register' being a method that
registers a type, except when it doesn't register a type. That feels
like dubious semantic design.

If I step back a level, I would ask why do we need to skip the registration
of machine types at all ?

It is because existing code blindly assumes that if a machine class is
registered, then it is valid to instantiate that machine class. IMHO this
is where the current design limitation is.

No matter what we do the code will exist in  memory in the binary. If we
register a type that's a tiny bit of memory to hold the "Class" instance
and ought to be logically harmless if we never instantiate a type.

IMHO we should always unconditionally register all types for which we
have code in memory. If there are types like machine types, where some
Classes should be blocked from instantiation based on certain criteria,
we should instead represent that with a check at that class level in
some manner.

i.e, we could have a helper

    bool machine_is_available(MachineClass *mc)

which we use as a filter when querying machine types that are available to
instantiate (-M help, query-machines), and as a pre-condition prior to
instiating a machine type (-M <name>).

That may in turn imply a callback

   bool (*is_available)(void)

on the MachineClass, for which your legacy_binary_is_64bit() method would
serve as an impl.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


