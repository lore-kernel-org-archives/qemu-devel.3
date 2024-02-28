Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4F2C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 07:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEOV-0003e7-R2; Wed, 28 Feb 2024 02:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfEOU-0003dd-0Y
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfEOS-00009Z-AV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709105418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fsb6wqWPtLgyEJyteYP5HWHeRZOILnjmTS6NLknJUXY=;
 b=UwrLguScwjhdqeIbR85HaNJy+R8SZTbbybBUQtx7JnsnQMxPsJ/OQGWixSRcmIVkzzqCya
 3RGCVlHmD6/D1Gc5kWytg8EoX+ofUKKxBV9Pia7/GZk+eP4RT59/cN3JGDWLxjltryXAT1
 m+iugT8RlDrUO3foq1/InA0NXb9Bid4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-ziVIXGdjNku_CInty1az6Q-1; Wed,
 28 Feb 2024 02:30:14 -0500
X-MC-Unique: ziVIXGdjNku_CInty1az6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B34D3806703;
 Wed, 28 Feb 2024 07:30:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CAD9492BC6;
 Wed, 28 Feb 2024 07:30:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3979921E66F9; Wed, 28 Feb 2024 08:30:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,  Fan Ni
 <fan.ni@samsung.com>,  Laurent Vivier <laurent@vivier.eu>,  Alistair
 Francis <alistair@alistair23.me>,  "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 1/7] hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
 cxl_fixed_memory_window_config()
In-Reply-To: <20240223085653.1255438-2-zhao1.liu@linux.intel.com> (Zhao Liu's
 message of "Fri, 23 Feb 2024 16:56:47 +0800")
References: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
 <20240223085653.1255438-2-zhao1.liu@linux.intel.com>
Date: Wed, 28 Feb 2024 08:30:11 +0100
Message-ID: <877cip3v24.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Zhao Liu <zhao1.liu@linux.intel.com> writes:

> From: Zhao Liu <zhao1.liu@intel.com>
>
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
>
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
>
> But in cxl_fixed_memory_window_config(), @errp is dereferenced in 2
> places without ERRP_GUARD():
>
> fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
> if (*errp) {
>     return;
> }
>
> and
>
> fw->enc_int_gran =
>     cxl_interleave_granularity_enc(object->interleave_granularity,
>                                    errp);
> if (*errp) {
>     return;
> }

No need to quote the dereferences in full.

  But in cxl_fixed_memory_window_config(), @errp is dereferenced in 2
  places without ERRP_GUARD().

  In these two places, we check "*errp", because neither function

would do.

Same for the other commit messages.

Hardly worth a respin, though :)

> For the above 2 places, we check "*errp", because neither function
> returns a suitable error code. And since machine_set_cfmw() - the caller
> of cxl_fixed_memory_window_config() - doesn't get the NULL @errp
> parameter as the "set" method of object property,
> cxl_fixed_memory_window_config() hasn't triggered the bug that
> dereferencing the NULL @errp.
>
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> cxl_fixed_memory_window_config().
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> Suggested by credit:
>  Markus: Referred his explanation about ERRP_GUARD().
> ---
> v2:
>  * Add the @errp dereference code in commit message to make review
>    easier. (Markus)
> ---
>  hw/cxl/cxl-host.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 2aa776c79c74..c5f5fcfd64d0 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -26,6 +26,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
>                                             Error **errp)
>  {
> +    ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
>      strList *target;
>      int i;


