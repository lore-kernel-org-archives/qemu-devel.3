Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BEDC3DA59
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 03:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVN8T-0006fJ-0O; Sat, 20 Jul 2024 23:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sVN8Q-0006ct-4x
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 23:21:18 -0400
Received: from va-2-37.ptr.blmpb.com ([209.127.231.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sVN8L-0006tU-R7
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 23:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1721532058;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=H0qyK51ZJ7CjenPfVwFluItbdtRPnhMEeOXpjqscy1g=;
 b=g+8XWH81DpBlVyqqZA56VNZF9UgwB9unAYEPRRZqXpBgWuef5mjlZiR3eDXVE4204tS9qc
 QHE9aBnP9gTPFu/q/+1Pe1kYKDTfyyvBQTgiRKOlDFvhWUt+sci1V+ALRSmSsCaehcg1lp
 z200m5GLsxgEJLzrFydzuRsZf8+529CyE57++eY51enBSp7v0Lq4rczVk2zpZO+8ywbcSS
 4CgEf0kO1La/kFp3k1hJbdydZhQ9t20uObFIjw0Db9A/TUVTSzodzEP95pmEUYr/Wz2JHA
 /kuXpcBUrjQqa4+D4/YRcd2kYJZ4meq0lL6w+Q+zBSrsCrtaEvfUgUC3cLq/Ew==
Date: Sun, 21 Jul 2024 11:20:56 +0800
Subject: Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
In-Reply-To: <20240720145819-mutt-send-email-mst@kernel.org>
X-Lms-Return-Path: <lba+1669c7e99+4d7753+nongnu.org+xiangwencheng@dayudpu.com>
References: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
 <20240720145819-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.0ff73b39.722e.4462.b426.f477adef04f2@feishu.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: <qemu-devel@nongnu.org>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.231.37;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-37.ptr.blmpb.com
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


> From: "Michael S. Tsirkin"<mst@redhat.com>
> Date:=C2=A0 Sun, Jul 21, 2024, 03:01
> Subject:=C2=A0 Re: [PATCH v2] vhsot-user: Do not wait for replay for not =
sent VHOST_USER_SET_LOG_BASE
> To: "BillXiang"<xiangwencheng@dayudpu.com>
> Cc: <qemu-devel@nongnu.org>
> typos in subject do not inspire confidence.

Sorry

>=C2=A0
> On Thu, Jul 18, 2024 at 04:31:03PM +0800, BillXiang wrote:
> > From: BillXiang <xiangwencheng@dayudpu.com>
> >=C2=A0
> > We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request
> > in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02559.ht=
ml
>=C2=A0
> Pls put commit here not ML link:
> commit ABCDEFGHIKLM ("subject")
>=C2=A0
> > and will send this message only for vq 0.
>=C2=A0
> you mean "should send"?
>=C2=A0

What I mean is the commit 7c211eb078c4 ("vhost-user: Skip unnecessary dupli=
cated VHOST_USER_SET_LOG_BASE requests")=C2=A0
will cause VHOST_USER_SET_LOG_BASE to be sent only when 'vq_index =3D=3D 0'=
 in vhost_user_write,=C2=A0
so that we can not use vhost_user_read to get reply when 'vq_index !=3D 0'

>=C2=A0
> >=C2=A0
> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > ---
> > V1[1] -> V2:
> >=C2=A0 - Refrain from appending flags to messages that could=C2=A0
> > precipitate validation failures upon execution of the=C2=A0
> > `vhost_user_read_header` function.=C2=A0
> >=C2=A0
> > [1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg01923.ht=
ml
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
>=C2=A0
> extra () not needed here.
>=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 msg.hdr.size =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ret =3D vhost_user_read(dev, &msg);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (ret < 0) {
> > --=C2=A0
> > 2.30.0

