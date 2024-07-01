Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A98BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sODSU-0005wR-11; Mon, 01 Jul 2024 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sODSQ-0005w8-Oj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:36:22 -0400
Received: from va-1-13.ptr.blmpb.com ([209.127.230.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sODSJ-0005vO-Nv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1719826564;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cxHOtjcW6sqfps+SSm+oRjdTsTsSsn4No3jB6StxyOA=;
 b=o5IeqtF9kYjrnxXfdIVwm8+9YcvipB2RNRvu4CWUJ8M9Qn+5n/JLVRYbovdS6nMz4DBxs2
 NOWgIp0aJD5Si5p0ztPYSj4oTysjI7W+vBCweByKaUjcJq1K0l14vk7f4SP7BBH8OfdnRa
 d/uL7ji8IAZvsHw3nb03lyYJJmmpvrkhMsIPgjpgJhwFWdPqfDjW4q14KB/T8cy8c/fod4
 Q8FT+2XiJsgqvGoJhXLbuqBNm8YVwfy7YBH7rZeS7b2qg5wwtJunrG4dasdrZQ2rV578p+
 dBM6160NRRCPltVSotln2I7ks+GKqQsi7gt7oIN2S1mC3GjBsn4tMwNhuWjm7Q==
In-Reply-To: <87zfr1qyyi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Mime-Version: 1.0
References: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
 <87zfr1qyyi.fsf@draig.linaro.org>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jul 2024 17:36:02 +0800
Message-Id: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.8eed26c3.aba1.4d51.9976.281bbad0a8e6@feishu.cn>
Subject: Re: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
X-Lms-Return-Path: <lba+166827883+dbd367+nongnu.org+xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=209.127.230.13;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-1-13.ptr.blmpb.com
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


> From: "Alex Benn=C3=A9e"<alex.bennee@linaro.org>
> Date:=C2=A0 Mon, Jul 1, 2024, 16:49
> Subject:=C2=A0 Re: [PATCH] vhost-user: Skip unnecessary duplicated VHOST_=
USER_SET_LOG_BASE requests
> To: "=E9=A1=B9=E6=96=87=E6=88=90"<xiangwencheng@dayudpu.com>
> Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>
> =E9=A1=B9=E6=96=87=E6=88=90 <xiangwencheng@dayudpu.com> writes:
>=C2=A0
> > From: BillXiang <xiangwencheng@dayudpu.com>
> >
> > The VHOST_USER_SET_LOG_BASE requests should be categorized into
> > non-vring specific messages, and should be sent only once.
> > If send more than once, dpdk will munmap old log_addr which may has
> > been used and cause segmentation fault.
>=C2=A0
> This looks fine to me but looking at the vhost-user.rst we don't seem to
> make any explicit statements about how many times given messages should
> be sent.
>=C2=A0
There is indeed no explicit statements about how many times given messages
=C2=A0should be sent in vhost-user.rst but already have some discussions su=
ch as=C2=A0
https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst@kerne=
l.org/.
> >
> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > ---
> >=C2=A0 hw/virtio/vhost-user.c | 1 +
> >=C2=A0 1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index cdf9af4a4b..41e34edd49 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUser=
Request request)
> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_RESET_DEVICE:
> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_ADD_MEM_REG:
> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_REM_MEM_REG:
> > + =C2=A0=C2=A0 case VHOST_USER_SET_LOG_BASE:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return true;
> > =C2=A0 =C2=A0=C2=A0 default:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return false;
>=C2=A0
> --=C2=A0
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

