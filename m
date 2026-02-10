Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F734EA8124
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpow9-0000Wg-6r; Tue, 10 Feb 2026 09:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpow6-0000WD-MX
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:41:54 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpow4-0000T7-EV
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:41:54 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C07D25969FF;
 Tue, 10 Feb 2026 15:41:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UsHd-fdY1sAU; Tue, 10 Feb 2026 15:41:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD19D5969FA; Tue, 10 Feb 2026 15:41:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AAF815969F6;
 Tue, 10 Feb 2026 15:41:48 +0100 (CET)
Date: Tue, 10 Feb 2026 15:41:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 03/21] qom/object: factor out
 object_class_property_try_add()
In-Reply-To: <20260210032348.987549-4-zhao1.liu@intel.com>
Message-ID: <42a44ab0-feb6-6e9d-df20-2e6d8d50a30c@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-4-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Feb 2026, Zhao Liu wrote:
> Similar to object_property_try_add(), factor out
> object_class_property_try_add().
>
> This allows adding more arguments to the core implementation without
> changing the signature of object_class_property_add(), avoiding the
> need to modify the extensive number of callers distributed throughout
> the code tree.
>
> While at it, add documentation for these functions.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> include/qom/object.h | 56 ++++++++++++++++++++++++++++++++++++++++++++
> qom/object.c         | 34 ++++++++++++++++++++-------
> 2 files changed, 82 insertions(+), 8 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 05706d4d7e3a..060db136988b 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1147,6 +1147,62 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
>
> void object_property_del(Object *obj, const char *name);
>
> +/**
> + * object_class_property_try_add:

This is renamed two patches later so maybe should be named like that here 
and drop the renaming patch.

Regards,
BALATON Zoltan

