Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0F8C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Q2Z-0005AT-0u; Mon, 13 May 2024 03:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6Q2K-00056x-TE
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6Q2J-0005oo-D0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715585030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HZGApIurcdsnIGwnOrwHMkNwPsnHqxAS3zMciEUQqlE=;
 b=UwCS19mOV610lJPcczjSr/UofHd14NbsIQpFcK7J1VGKekyicwyrT2K6akX8Fx/+IY3QkB
 1vVmynsqkt2S2c0ykcRn/6c01nU8Vm8QONzkhTVq/Hik0+sAep89VdW4SH4pdJoGeZVV5w
 n+0lecFhaKdKEPE2pZ6eTR9TnVqKegE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-KEKI_0mjP3CQcoFHpk0gSw-1; Mon, 13 May 2024 03:23:47 -0400
X-MC-Unique: KEKI_0mjP3CQcoFHpk0gSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E69D68030A4;
 Mon, 13 May 2024 07:23:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CF31C15BB9;
 Mon, 13 May 2024 07:23:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A51521E66E5; Mon, 13 May 2024 09:23:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: kbusch@kernel.org,  its@irrelevant.dk,  foss@defmacro.it,
 qemu-block@nongnu.org,  qemu-devel@nongnu.org,  npiggin@gmail.com
Subject: Re: [PATCH] hw/nvme: Add CLI options for PCI vendor/device IDs and
 IEEE-OUI ID
In-Reply-To: <20240509124723.3930-1-saif.abrar@linux.vnet.ibm.com> (Saif
 Abrar's message of "Thu, 9 May 2024 07:47:23 -0500")
References: <20240509124723.3930-1-saif.abrar@linux.vnet.ibm.com>
Date: Mon, 13 May 2024 09:23:45 +0200
Message-ID: <87ttj2b2f2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Saif Abrar <saif.abrar@linux.vnet.ibm.com> writes:

> Add CLI options for user specified
> - PCI vendor, device, subsystem vendor and subsystem IDs
> - IEEE-OUI ID
>
> e.g. PCI IDs to be specified as follows:
> -device nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01
>
> IEEE-OUI ID (Identify Controller bytes 75:73) is to be
> specified in LE format.
> (e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD, Byte[75]=0xAB).
>
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

[...]

> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..35aeb48e0b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c

[...]

> @@ -8451,6 +8480,13 @@ static Property nvme_props[] = {
>                        params.sriov_max_vq_per_vf, 0),
>      DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
>                       false),
> +    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
> +    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
> +    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
> +                                                    params.id_subsys_vendor, 0),
> +    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
> +    DEFINE_PROP("ieee_oui", NvmeCtrl, params.ieee_oui, nvme_prop_ieee,
> +                                                                      uint32_t),
>      DEFINE_PROP_END_OF_LIST(),
>  };

You add properties, not CLI options.  Properties are accessible via CLI
-device, but also via monitor device_add, qom-set, qom-get.

Please rephrase your commit message like "Add properties for".


