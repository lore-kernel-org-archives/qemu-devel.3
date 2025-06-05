Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85306C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN8IV-0006Lu-5J; Thu, 05 Jun 2025 06:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN8IO-0006L7-12
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN8IM-0005Xb-Cj
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749121080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8C6P2q45ormWMPSV3e5vCsO70p1lFYkJDL7sXSAhYaw=;
 b=do3rkKDPzB4ppayFI7kFw3+BxWsGKhNgLz7/0kHRmec/kpAWqO2e5GRfMZvhaWO//pEoU1
 1bUsGMfo5IrlkrcR17Jt+bZTKgRX5eO0p/Up9urZsJMfMaEcbPBJtalIYpoefReo75mBv7
 vXPrUxQ3+9UidhY18tziQusf3ET+8/4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-51fIg8loNGqN1X3ZA3GrWQ-1; Thu,
 05 Jun 2025 06:57:57 -0400
X-MC-Unique: 51fIg8loNGqN1X3ZA3GrWQ-1
X-Mimecast-MFC-AGG-ID: 51fIg8loNGqN1X3ZA3GrWQ_1749121076
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE90D195608B; Thu,  5 Jun 2025 10:57:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5AE51956094; Thu,  5 Jun 2025 10:57:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 066ED21E6757; Thu, 05 Jun 2025 12:57:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org,  chao.p.peng@intel.com,  david@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael S.
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/5] virtio-mem: Fix definition of VirtIOMEMClass
In-Reply-To: <20250605102311.148171-2-zhenzhong.duan@intel.com> (Zhenzhong
 Duan's message of "Thu, 5 Jun 2025 18:23:07 +0800")
References: <20250605102311.148171-1-zhenzhong.duan@intel.com>
 <20250605102311.148171-2-zhenzhong.duan@intel.com>
Date: Thu, 05 Jun 2025 12:57:52 +0200
Message-ID: <87cybiihfz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhenzhong Duan <zhenzhong.duan@intel.com> writes:

> Parent of VirtIOMEMClass is VirtioDeviceClass rather than VirtIODevice.
>
> Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/virtio/virtio-mem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-me=
m.h
> index bc4f787772..e0ab31b45a 100644
> --- a/include/hw/virtio/virtio-mem.h
> +++ b/include/hw/virtio/virtio-mem.h
> @@ -134,7 +134,7 @@ struct VirtioMemSystemReset {
>=20=20
>  struct VirtIOMEMClass {
>      /* private */
> -    VirtIODevice parent;
> +    VirtioDeviceClass parent_class;
>=20=20
>      /* public */
>      void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo =
*vi);

*Ouch*

I guess this isn't catastrophic only because sizeof(VirtIODevice) >
sizeof(VirtioDeviceClass).  Suggest to mention that in the commit
message.

Out of scope for this patch, but I'd really, really appreciate more
consistent spelling of VirtIO.


