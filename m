Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DC2C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 09:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSQo-0005Fv-N5; Thu, 01 Aug 2024 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sZSQm-0005EL-BT
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:49:08 -0400
Received: from va-2-32.ptr.blmpb.com ([209.127.231.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sZSQh-0003fU-LO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 05:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1722505718;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=VzDKqb5cywqOkSOGbX8+L8Sdk7F2n3pVd4J/YH+RTZE=;
 b=oCR6FHNDNYT5Nb1pqva7LQilpqmIAZXKHdJhloxAL8Uc/ljNS9WSsqw2EqnwrZ92PDzaMq
 N7M40GCJeoGR73kMhbXHLjXOJOLKAXOE7xJmZlKYfnqGH5pKcotOPIBdMiA3s0Z8QMih4i
 ac2KvTDDi0YRmS092PB5yT482JuoZ25kuoa02OZLI2/w3DTRI5p5mCrNRiDW1LQDlD+eZn
 SghemyHHJx/JS9vJ+Rny2VXbRwABms52X2sYeD6xGMpS+xDc4Q7qUe3z3ReTLFobv5gYnW
 afgRoU67gkjs+HofDALL9LnjBRWNV1G2SkqV7oDEKH77J583lzMzTATncaeHlQ==
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.cce6af4a.43f3.41da.bd6c.5fdb96e92401@feishu.cn>
Subject: Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
Mime-Version: 1.0
X-Lms-Return-Path: <lba+166ab59f5+cdcf46+nongnu.org+xiangwencheng@dayudpu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Aug 2024 17:48:36 +0800
Cc: <qemu-devel@nongnu.org>
From: "BillXiang" <xiangwencheng@dayudpu.com>
References: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
 <20240720145819-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.0ff73b39.722e.4462.b426.f477adef04f2@feishu.cn>
 <20240801042507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801042507-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Received-SPF: pass client-ip=209.127.231.32;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-32.ptr.blmpb.com
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
> Date:=C2=A0 Thu, Aug 1, 2024, 16:26
> Subject:=C2=A0 Re: [PATCH v2] vhsot-user: Do not wait for replay for not =
sent VHOST_USER_SET_LOG_BASE
> To: "BillXiang"<xiangwencheng@dayudpu.com>
> Cc: <qemu-devel@nongnu.org>
> On Sun, Jul 21, 2024 at 11:20:56AM +0800, BillXiang wrote:
> >=C2=A0
> > > From: "Michael S. Tsirkin"<mst@redhat.com>
> > > Date:=C2=A0 Sun, Jul 21, 2024, 03:01
> > > Subject:=C2=A0 Re: [PATCH v2] vhsot-user: Do not wait for replay for =
not sent VHOST_USER_SET_LOG_BASE
> > > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > > Cc: <qemu-devel@nongnu.org>
> > > typos in subject do not inspire confidence.
> >=C2=A0
> > Sorry
> >=C2=A0
> > >=C2=A0
> > > On Thu, Jul 18, 2024 at 04:31:03PM +0800, BillXiang wrote:
> > > > From: BillXiang <xiangwencheng@dayudpu.com>
> > > >=C2=A0
> > > > We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_requ=
est
> > > > in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg0255=
9.html
> > >=C2=A0
> > > Pls put commit here not ML link:
> > > commit ABCDEFGHIKLM ("subject")
> > >=C2=A0
> > > > and will send this message only for vq 0.
> > >=C2=A0
> > > you mean "should send"?
> > >=C2=A0
> >=C2=A0
> > What I mean is the commit 7c211eb078c4 ("vhost-user: Skip unnecessary d=
uplicated VHOST_USER_SET_LOG_BASE requests")=C2=A0
> > will cause VHOST_USER_SET_LOG_BASE to be sent only when 'vq_index =3D=
=3D 0' in vhost_user_write,=C2=A0
> > so that we can not use vhost_user_read to get reply when 'vq_index !=3D=
 0'
>=C2=A0
>=C2=A0
> do we try to do it now? in which configurations?
>=C2=A0

Sorry, I'm not certain about what you're instructing me to do.

Maybe I should merge this patch whit commit 7c211eb078c4
("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests"=
)=C2=A0
=C2=A0and "[PATCH] vhsot-user: Remove redundant judgment" into one patch.

All of these three patches are aimed to do the same thing as=C2=A0
commit c98ac64cfb53 ("vhost-user: send set log base message only once")
which is not a good solution because there is already a function vhost_user=
_per_device_request
for those messages that should be sent only once per device.

In commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated VHOST_USER=
_SET_LOG_BASE requests")=C2=A0
I added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request so that it=
 will be sent only once=C2=A0
per device when 'vq_index =3D=3D 0'.
After that we should remove the check add by commit c98ac64cfb53 ("vhost-us=
er: send set log base message only once")
in "[PATCH] vhsot-user: Remove redundant judgment".
And last, in current patch "vhsot-user: Do not wait for replay for not sent=
 VHOST_USER_SET_LOG_BASE"
we should only read reply when 'vq_index =3D=3D 0'.

>=C2=A0
> > >=C2=A0
> > > >=C2=A0
> > > > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > > > ---
> > > > V1[1] -> V2:
> > > >=C2=A0 - Refrain from appending flags to messages that could=C2=A0
> > > > precipitate validation failures upon execution of the=C2=A0
> > > > `vhost_user_read_header` function.=C2=A0
> > > >=C2=A0
> > > > [1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg0192=
3.html
> > > > ---
> > > >=C2=A0 hw/virtio/vhost-user.c | 2 +-
> > > >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=C2=A0
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 00561daa06..fd12992d15 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost=
_dev *dev, uint64_t base,
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return ret;
> > > > =C2=A0 =C2=A0=C2=A0 }
> > > > =C2=A0
> > > > - =C2=A0=C2=A0 if (shmfd) {
> > > > + =C2=A0=C2=A0 if (shmfd && (dev->vq_index =3D=3D 0)) {
> > >=C2=A0
> > > extra () not needed here.
> > >=C2=A0
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 msg.hdr.size =3D 0;
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ret =3D vhost_user_read(dev, &msg=
);
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (ret < 0) {
> > > > --=C2=A0
> > > > 2.30.0

