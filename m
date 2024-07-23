Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259A7C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCeN-0000bo-P8; Tue, 23 Jul 2024 06:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWCeC-0008Lo-WE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWCe8-00029E-9Z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721730087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QkTOKAdtLriMcyGBCy4XsaAoDURVVMm3riVjUxKckA=;
 b=HoO9QFRFyz9OEI54v9iQbt4xpLnFJdDfxiIT30VkMbKnpJqD+bBGacFbIi0T02l9/mjDVN
 PDjGqBGABTivisP0BaEcJWMcs6qRFZ8QG2vxqq+MgPel0SguSFCnrQK13uM5AT6/72o9jZ
 CcLLrzsFKKRLWO++ZlbL1zI4Oh856is=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-Y7z4xClrMmW8RquI2JTNBA-1; Tue,
 23 Jul 2024 06:21:23 -0400
X-MC-Unique: Y7z4xClrMmW8RquI2JTNBA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D99B1955D62; Tue, 23 Jul 2024 10:21:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FDA91955F65; Tue, 23 Jul 2024 10:21:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1D1121E6682; Tue, 23 Jul 2024 12:21:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
 nubus_virtio_mmio_realize()
In-Reply-To: <20240715095939.72492-1-zhao1.liu@intel.com> (Zhao Liu's message
 of "Mon, 15 Jul 2024 17:59:37 +0800")
References: <20240715095939.72492-1-zhao1.liu@intel.com>
Date: Tue, 23 Jul 2024 12:21:17 +0200
Message-ID: <878qxswgrm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhao Liu <zhao1.liu@intel.com> writes:

> As the comment in qapi/error, dereferencing @errp requires

Suggest "According to the comment in qapi/error.h".

> ERRP_GUARD():
>
> * =3D Why, when and how to use ERRP_GUARD() =3D
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
> But in nubus_virtio_mmio_realize(), @errp is dereferenced without
> ERRP_GUARD().

Suggest to scratch "But".

> Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
> method - doesn't get the NULL @errp parameter, it hasn't triggered the
> bug that dereferencing the NULL @errp. It's still necessary to follow
> the requirement of @errp, so add missing ERRP_GUARD() in
> nubus_virtio_mmio_realize().

Suggest

  Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
  method - is never passed a null @errp argument, it should follow the
  rules on @errp usage.  Add the ERRP_GUARD() there.
=20=20
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/nubus/nubus-virtio-mmio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
> index 58a63c84d0be..a5558d3ec28b 100644
> --- a/hw/nubus/nubus-virtio-mmio.c
> +++ b/hw/nubus/nubus-virtio-mmio.c
> @@ -23,6 +23,7 @@ static void nubus_virtio_mmio_set_input_irq(void *opaqu=
e, int n, int level)
>=20=20
>  static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      NubusVirtioMMIODeviceClass *nvmdc =3D NUBUS_VIRTIO_MMIO_GET_CLASS(de=
v);
>      NubusVirtioMMIO *s =3D NUBUS_VIRTIO_MMIO(dev);
>      NubusDevice *nd =3D NUBUS_DEVICE(dev);
       SysBusDevice *sbd;
       int i, offset;

       nvmdc->parent_realize(dev, errp);

Here's the dereference:

       if (*errp) {
           return;
       }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


