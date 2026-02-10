Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1E1EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkNc-0003jF-RL; Tue, 10 Feb 2026 04:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpkNb-0003ir-7H
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpkNZ-0006UF-E1
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770716996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1Kk3u2RKO694KJeZV8NCYpa98dl1MX6eHuvS8q2D2HA=;
 b=ahNvSor60+y/FuScrksZxmPwv82FIt4GAKZR1TnnX7IAYpnxtOcgJRRBSMqx63zYa3EY9H
 v+pwTIDrNS997kMXPvaAfj2aX+veDGYDGwb9tlnLRJorMM36oacsYbHfYTRf2RspsZezlL
 bXTByJKIsbWaVTavbXYNeBOimQnYPiU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-lVCh-q8QNsy3LfQ7X39_Qw-1; Tue,
 10 Feb 2026 04:49:52 -0500
X-MC-Unique: lVCh-q8QNsy3LfQ7X39_Qw-1
X-Mimecast-MFC-AGG-ID: lVCh-q8QNsy3LfQ7X39_Qw_1770716990
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 318B1180047F; Tue, 10 Feb 2026 09:49:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.137])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9A8419560A3; Tue, 10 Feb 2026 09:49:43 +0000 (UTC)
Date: Tue, 10 Feb 2026 09:49:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 07/21] qom/object: introduce user interaction flags
 for properties
Message-ID: <aYr_NE0c0LsVz8zx@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-8-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210032348.987549-8-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Feb 10, 2026 at 11:23:34AM +0800, Zhao Liu wrote:
> Introduce three new flags to `ObjectPropertyFlags` to better manage
> property interactions with external users (CLI, QMP, HMP):
> 
> 1. OBJ_PROP_FLAG_USER_SET:
>    Marks a property as having been modified by an external user.
> 
>    This flag is designed to be "sticky": once set, it persists even if
>    the property value is subsequently overwritten by internal logic.
>    It allows the QEMU system to distinguish user intent.
> 
>    The advantage of this design is that it is not needed to manually
>    clear the USER_SET flag on every internal write. This simplifies the
>    logic and decouples flag management from the current property setting
>    path (object_property_set()).
> 
>    This is chosen over a strict "current origin" approach (where
>    internal writes would clear the flag) for a practical reason: QEMU
>    code often modifies underlying struct fields (which are defined as
>    properties) directly, bypassing the property API entirely. This makes
>    it impossible to "accurately" track whether the *current* value truly
>    comes from the user. Therefore, a sticky "user touched this" flag is
>    the only meaningful and robust solution.
> 
> 2. OBJ_PROP_FLAG_DEPRECATED:
>    Marks a property as deprecated.
> 
> 3. OBJ_PROP_FLAG_INTERNAL:
>    Marks a property as internal-only, disallowing external user access.
> 
> Additionally, update object_property_set_flags() to implement the
> enforcement logic. When a property is flagged with
> OBJ_PROP_FLAG_USER_SET:
>  - If the property is also marked OBJ_PROP_FLAG_DEPRECATED, report a
>    warning.
>  - If the property is also marked OBJ_PROP_FLAG_INTERNAL, raise an error
>    and stop the operation.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/qom/object.h | 24 ++++++++++++++++++++++++
>  qom/object.c         | 15 +++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 856b12e7289c..1b77429aa28b 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -109,6 +109,30 @@ typedef enum {
>       * will automatically add a getter and a setter to this property.
>       */
>      OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> +    /*
> +     * The property was explicitly set by an external user.
> +     *
> +     * This flag is set whenever the property is modified via external interfaces
> +     * (CLI, QMP, HMP). It allows internal code to distinguish whether the
> +     * property has been modified by the user.
> +     *
> +     * Once set, this flag persists even if the property value is subsequently
> +     * overwritten by internal logic. It is NOT automatically cleared and must
> +     * be explicitly cleared using object_property_clear_flags().
> +     */
> +    OBJ_PROP_FLAG_USER_SET = BIT(2),
> +    /*
> +     * The property is deprecated and will be removed in the future version.
> +     *
> +     * Any setting to this property by the user will raise a deprecation warning.
> +     */
> +    OBJ_PROP_FLAG_DEPRECATED = BIT(3),
> +    /*
> +     * The property is internal only and cannot be set by the user.
> +     *
> +     * Any setting to this property by the user will raise an error.
> +     */
> +    OBJ_PROP_FLAG_INTERNAL = BIT(4),
>  } ObjectPropertyFlags;

I don't think this single enum design is very desirable, as it is mixing up
pieces of information with three distinct lifetimes / scopes.

The OBJ_PROP_FLAD_{READ,WRITE,READWRITE} values are scoped to the execution
of the property adder methods.

The OBJ_PROP_FLAG_{DEPRECATED,INTERNAL} values are scoped to the lifetime
of the class.

The OBJ_PROP_FLAG_USER_SET value is scoped to the lifetime of the instance.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


