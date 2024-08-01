Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1AAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXJh-0001ky-R9; Thu, 01 Aug 2024 11:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sZXJe-0001cG-5R
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:02:06 -0400
Received: from va-2-40.ptr.blmpb.com ([209.127.231.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sZXJY-0005Px-Co
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1722524513;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=yt+pRC5FOXmek1RzZeuSU/uGknOLwlYhS4JyyYu7eRY=;
 b=lM+jS0fLI8uFiHI1RIj39t+xNg6O0mXCnxD8u+dsP5dFZ9wERSeq4R71JGJk01kyR2dsgu
 4H0s+n65nNiEP2nDnReevL8DE7+PevZ6ndSKa0lERR83f56LRroXpVvw4CsjnDjJhDXzNu
 Q11Zcvd/NhtU+br9AsQX6Xw6TaTg7cDzaf+3N6nUgxduY/iFvLzw8Fdtz48VfEyzRp1gMk
 FLzO7813sMo2sAjBCMZh2L/d32tHcomP6XXLrZapcO80i/3zldqcoMrtoOY5AJO5NoiVkQ
 8KK3foiePbSJYfZeXkE0QRE1yzgQ9Z7Nd063sn+m6Pe7xBqEBMyF9PjopSs8zg==
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
 <20240801101210-mutt-send-email-mst@kernel.org>
X-Lms-Return-Path: <lba+166aba360+c8091c+nongnu.org+xiangwencheng@dayudpu.com>
In-Reply-To: <20240801101210-mutt-send-email-mst@kernel.org>
Date: Thu, 01 Aug 2024 23:01:51 +0800
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=209.127.231.40;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-40.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


> From: "Michael S. Tsirkin"<mst@redhat.com>
> Date:=C2=A0 Thu, Aug 1, 2024, 22:13
> Subject:=C2=A0 Re: [PATCH v3] vhost-user: Do not wait for reply for not s=
ent VHOST_USER_SET_LOG_BASE
> To: "BillXiang"<xiangwencheng@dayudpu.com>
> Cc: <qemu-devel@nongnu.org>
> On Thu, Aug 01, 2024 at 08:45:40PM +0800, BillXiang wrote:
> > From: BillXiang <xiangwencheng@dayudpu.com>
> >=C2=A0
> > Currently, we have added VHOST_USER_SET_LOG_BASE to=C2=A0
> > vhost_user_per_device_request in commit 7c211eb078c4=C2=A0
> > ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE reque=
sts"),=C2=A0
> > as a result, VHOST_USER_SET_LOG_BASE will be sent only once=C2=A0
> > when 'vq_index =3D=3D 0'.
> > In this patch we add the check of 'vq_index =3D=3D 0' before=C2=A0
> > vhost_user_read, such that we do not wait for reply for not
> > sent VHOST_USER_SET_LOG_BASE.
> >=C2=A0
> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > ---
> >=C2=A0 hw/virtio/vhost-user.c | 2 +-
> >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=C2=A0
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 00561daa06..fd12992d15 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev=
 *dev, uint64_t base,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return ret;
> > =C2=A0 =C2=A0=C2=A0 }
> > =C2=A0
> > - =C2=A0=C2=A0 if (shmfd) {
> > + =C2=A0=C2=A0 if (shmfd && (dev->vq_index =3D=3D 0)) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 msg.hdr.size =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ret =3D vhost_user_read(dev, &msg);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (ret < 0) {
>=C2=A0
>=C2=A0
>=C2=A0
> How do things work now after 7c211eb078c4 then?

It does not really work after 7c211eb078c4 and it's my mistake.=C2=A0
I forgot to submit the code to check vq_index in 7c211eb078c4.

>=C2=A0
> > --=C2=A0
> > 2.30.0

