Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219FFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOBoK-00068I-De; Mon, 01 Jul 2024 03:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sOBoI-00067r-Aw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:50:50 -0400
Received: from va-2-31.ptr.blmpb.com ([209.127.231.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sOBo4-0002Rb-Rq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1719820222;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=1/Ze1u4kyrVuPk6cv1pCNFIs/JqnXbo8nqVQBK5oDK8=;
 b=1cfOTHqZRF0pqwEeeHAPOvJaCl2Acgk6Zu02u+JE4U08dQ6P8zGW7PwYDu8J7mrn+vzu/d
 xzshfJr55EvAAaT89/Fj8BGn4vTWTd2ksnskr/P03XVw0g0BDjcF+OhKCHgFZeKILO2p15
 tD0nt6q5rOTt8m4q5VaZzLaOhiLGZWtmYDtq7Tcoo6Ztyc0+jnHodTaU6wZYt0KXJn695V
 aSldwzsnVuLE9mXh6WGX+swqNEeee3zH78WWjrfOXNBPhuBodzP2F/2jNVNAyYteZ+x8bH
 J8m7tDKbFU7U4/jb+pWyghv/ik3hd+kbKPg68WHaKRfJMuyyCMsiLwK1lJZCRg==
References: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
In-Reply-To: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
Date: Mon, 01 Jul 2024 15:50:20 +0800
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d523eb81.5114.418c.9508.dac5306b3eb8@feishu.cn>
To: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
From: "BillXiang" <xiangwencheng@dayudpu.com>
X-Lms-Return-Path: <lba+166825fbd+1972e0+nongnu.org+xiangwencheng@dayudpu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.231.31;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-31.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> From: "=E9=A1=B9=E6=96=87=E6=88=90"<xiangwencheng@dayudpu.com>
> Date:=C2=A0 Thu, Jun 13, 2024, 14:51
> Subject:=C2=A0 [PATCH] vhost-user: Skip unnecessary duplicated VHOST_USER=
_SET_LOG_BASE requests
> To: <qemu-devel@nongnu.org>
> Cc: <mst@redhat.com>, "BillXiang"<xiangwencheng@dayudpu.com>
> From: BillXiang <xiangwencheng@dayudpu.com>
>=C2=A0
> The VHOST_USER_SET_LOG_BASE requests should be categorized into
> non-vring specific messages, and should be sent only once.
> If send more than once, dpdk will munmap old log_addr which may has been =
used and cause segmentation fault.
>=C2=A0
> Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> ---
>=C2=A0 hw/virtio/vhost-user.c | 1 +
>=C2=A0 1 file changed, 1 insertion(+)
>=C2=A0
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..41e34edd49 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUserRe=
quest request)
> =C2=A0 =C2=A0=C2=A0 case VHOST_USER_RESET_DEVICE:
> =C2=A0 =C2=A0=C2=A0 case VHOST_USER_ADD_MEM_REG:
> =C2=A0 =C2=A0=C2=A0 case VHOST_USER_REM_MEM_REG:
> + =C2=A0=C2=A0 case VHOST_USER_SET_LOG_BASE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return true;
> =C2=A0 =C2=A0=C2=A0 default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return false;
> --=C2=A0
> 2.30.0
ping

