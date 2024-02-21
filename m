Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929ECC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoU1-0000G6-Cd; Wed, 21 Feb 2024 10:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoNJ-0005mr-Cl
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rckqJ-0005pg-C5
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708515169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/PfOV0rUULq7uskiVKCK2tU5oYWzUOp5ZIfBHAUq90=;
 b=BD1RF/H/5rYQ+5CXA1wt/2/ArFZc6MAY5NkEJuLo/D217DQWdf3lF6UqbyBjVJ68PcdSQJ
 eo6+JLdkvPQ6CnNCqUrA6Ll3leZ6lQrSyDlBxkpT4doPKZ8bO5C6YvkAfm4H7gPE66zvhG
 2V2pcupJKhj5ndDncP25x47Pmd2yezU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-N-lm8KnBN5mXUv1hGgdvnA-1; Wed,
 21 Feb 2024 06:32:45 -0500
X-MC-Unique: N-lm8KnBN5mXUv1hGgdvnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC7633C40B50;
 Wed, 21 Feb 2024 11:32:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B41B5C185C1;
 Wed, 21 Feb 2024 11:32:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B052021E66D5; Wed, 21 Feb 2024 12:32:43 +0100 (CET)
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  qemu-trivial@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/6] hw/display/macfb: Fix missing ERRP_GUARD() in
 macfb_nubus_realize()
In-Reply-To: <20240221094317.994454-3-zhao1.liu@linux.intel.com> (Zhao Liu's
 message of "Wed, 21 Feb 2024 17:43:13 +0800")
References: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
 <20240221094317.994454-3-zhao1.liu@linux.intel.com>
Date: Wed, 21 Feb 2024 12:32:43 +0100
Message-ID: <874je2vyqs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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
> * - It should not be passed to error_prepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
>
> Currently, since macfb_nubus_realize() - as a DeviceClass.realize()
> method - doesn't get the NULL errp parameter, it doesn't trigger the
> dereference issue.
>
> To follow the requirement of errp, add missing ERRP_GUARD() in
> macfb_nubus_realize().
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Suggested by credit:
>  Markus: Referred his explanation about ERRP_GUARD().
> ---
>  hw/display/macfb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index 418e99c8e18e..1ace341a0ff4 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -714,6 +714,7 @@ static void macfb_nubus_set_irq(void *opaque, int n, int level)
>  
>  static void macfb_nubus_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      NubusDevice *nd = NUBUS_DEVICE(dev);
>      MacfbNubusState *s = NUBUS_MACFB(dev);
>      MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);

The dereference is

       ndc->parent_realize(dev, errp);
       if (*errp) {
           return;
       }

We check *errp, because neither the callback returns void.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


