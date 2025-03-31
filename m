Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F0DC36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 06:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz8kz-0000RF-7s; Mon, 31 Mar 2025 02:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tz8hb-0007fX-Mj
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 02:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tz8hZ-0001Yi-IF
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 02:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743402772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Hxlgzz3JSC/uBaonRIFh5RxuyRz5eu2v4XANZpb9S8=;
 b=WOQvXqgjKb50yTTxwes/7MyL38VaZbXA28u+IPqqElvTrj+iI8KthbYanU7xu+F0ZkzjmF
 lDmfuzHw8UR6JuL6B+x+klrhkNKKx34V6xggOI0m0QWEEPL7jjJVoBRAcv9LAc+paNoLwE
 VPbUWPHwECgxrBLeBjDq3nKkEd7Lbns=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-UiNuhubkPNyI6SXWC8l-2g-1; Mon, 31 Mar 2025 02:32:51 -0400
X-MC-Unique: UiNuhubkPNyI6SXWC8l-2g-1
X-Mimecast-MFC-AGG-ID: UiNuhubkPNyI6SXWC8l-2g_1743402770
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e6136633b1so3283486a12.0
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 23:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743402769; x=1744007569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Hxlgzz3JSC/uBaonRIFh5RxuyRz5eu2v4XANZpb9S8=;
 b=qnz6qLPdp5aQq6cypHJEjY4iq0U/QV8q9Q7OA44zSAdaXQiTeSyHwp8df4fY/i6fIc
 FH+L8gqb3Qp8Qp0HljnQhaoWPTmijxKJpC6eRLDy7dOK/RmUZHImOcu5sCtfP7Q42zK3
 u2pB4T7D8soBGUPTXC/N1kF+N7cgaXaCYfMkeVRlZIPbCkbCfFGdQotlbYuQ2e/gfSYU
 4gWpzL1lnX9HAPwk+/UU38TcB3BsKAR2P4i9zg/xsHHaDDXWDtHIgZmY5tUJ5yp0lZ1L
 GihNoXIqZAFN4g8uRBX7+NLC67ow0ze1+5wYFWpA0Xb8oq2mduSYPCmvAD/dq43gBkmY
 k3kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxvt6LsVaDVkheZhxRBotgqt1iA4yovnKBM3d2p4z960hBk2UarnZ+Bj7b3kmV+dsMSdABphmPxpve@nongnu.org
X-Gm-Message-State: AOJu0YzCAmK+Kh9KHvPw/IBiQyUN/Q4HDInTPH16Qxzon5id8X09Hgzj
 4+q10dQDguMdv1dVwZ5M3SYV4bvYHx7IcScrQu+fnWomO42JB147vKloRqXuBCuMNtxJa3kwI6t
 AbY7wfwUFoRM4fVa8Nt/cQIXmJaD2w04pYS2uT8l/LUtu5O0110AWBGYGjsZaPgMyaUtvViU7Id
 tmAtTr0rKUQLg8ieI/5q+Lk+D87P7p+LeMitx9Mw==
X-Gm-Gg: ASbGncvITwwlHbVpq6DV7Rx+gOrCvfyxuKimpFMQl1AyYXQ/9JR5QhLt+fqkQejbYn8
 Ca9K4Csyq8UqZcI3unHGeSjtNv8P8tnYIg3VtYBnA6OhFan1c8JQjvUTYae4u7tkDATGNukEuQQ
 ==
X-Received: by 2002:a05:6402:5243:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5edfcc3c249mr5479651a12.1.1743402768706; 
 Sun, 30 Mar 2025 23:32:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE79tzshFK9CxC6AGR1JxBt6XEPUAKGYSDrqk5v2ymPNXppKhAF4jBmGABAVVzhfcgjA6NPYnn626bNaPFXmyk=
X-Received: by 2002:a05:6402:5243:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5edfcc3c249mr5479638a12.1.1743402768340; Sun, 30 Mar 2025
 23:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-3-lulu@redhat.com>
In-Reply-To: <20250326132021.1215568-3-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 14:32:11 +0800
X-Gm-Features: AQ5f1JrcezyWamO3DTpZ42b6hgD7yt31kObLfCyJDJ_t-WERcH9xGgJt3aYnHJo
Message-ID: <CAPpAL=x8Rqd4n9+x0FwvyreugZSufsd=tQ_KKWQG=bpzpJUUBg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] virtio_net: Add the check for vdpa's mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b5302c06319d962a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000b5302c06319d962a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Mar 26, 2025 at 9:21=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:

> When using a VDPA device, it is important to ensure that the MAC
> address is correctly set. The MAC address in the hardware should
> match the MAC address from the QEMU command line. This is a recommended
> configuration and will allow the system to boot.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadff..a3b431e000 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3749,12 +3749,43 @@ static bool
> failover_hide_primary_device(DeviceListener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
> +                                      MACAddr *cmdline_mac, Error **errp=
)
> +{
> +    struct virtio_net_config hwcfg =3D {};
> +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> +
> +    vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg,
> ETH_ALEN);
> +
> +    /*For VDPA device following situations are acceptable:*/
> +
> +    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> +        /*
> +         * 1.The hardware MAC address is the same as the QEMU command
> line MAC
> +         *   address, and both of them are not 0.
> +         */
> +        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0))=
 {
> +            return true;
> +        }
> +    }
>
> +    error_setg(errp,
> +               "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> +               "not same with the cmdline's mac
> %02x:%02x:%02x:%02x:%02x:%02x,"
> +               "Please check.",
> +               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
> +               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0],
> cmdline_mac->a[1],
> +               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4],
> +               cmdline_mac->a[5]);
> +
> +    return false;
> +}
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIONet *n =3D VIRTIO_NET(dev);
>      NetClientState *nc;
> +    MACAddr macaddr_cmdline;
>      int i;
>
>      if (n->net_conf.mtu) {
> @@ -3862,6 +3893,7 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3908,7 +3940,13 @@ static void virtio_net_device_realize(DeviceState
> *dev, Error **errp)
>      nc =3D qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled =3D 1;
>
> -   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> +    if (nc->peer && (nc->peer->info->type =3D=3D
> NET_CLIENT_DRIVER_VHOST_VDPA)) {
> +        if (nc->peer->check_mac) {
> +            if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline,
> errp)) {
> +                virtio_cleanup(vdev);
> +                return;
> +            }
> +        }
>          struct virtio_net_config netcfg =3D {};
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
> --
> 2.45.0
>
>
>

--000000000000b5302c06319d962a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">QE tested this series of patches with virtio-net regressio=
n tests, everything works fine.<div><br></div><div>Tested-by: Lei Yang &lt;=
<a href=3D"mailto:leiyang@redhat.com">leiyang@redhat.com</a>&gt;</div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Mar 26, 2025 at 9:21=E2=80=AFPM Cindy Lu &lt;<a hr=
ef=3D"mailto:lulu@redhat.com">lulu@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">When using a VDPA device, it i=
s important to ensure that the MAC<br>
address is correctly set. The MAC address in the hardware should<br>
match the MAC address from the QEMU command line. This is a recommended<br>
configuration and will allow the system to boot.<br>
<br>
Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=3D"_b=
lank">lulu@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-<br>
=C2=A01 file changed, 39 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index de87cfadff..a3b431e000 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -3749,12 +3749,43 @@ static bool failover_hide_primary_device(DeviceList=
ener *listener,<br>
=C2=A0 =C2=A0 =C2=A0/* failover_primary_hidden is set during feature negoti=
ation */<br>
=C2=A0 =C2=A0 =C2=A0return qatomic_read(&amp;n-&gt;failover_primary_hidden)=
;<br>
=C2=A0}<br>
+static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MACAddr *cmdlin=
e_mac, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_net_config hwcfg =3D {};<br>
+=C2=A0 =C2=A0 static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } =
};<br>
+<br>
+=C2=A0 =C2=A0 vhost_net_get_config(get_vhost_net(nc-&gt;peer), (uint8_t *)=
&amp;hwcfg, ETH_ALEN);<br>
+<br>
+=C2=A0 =C2=A0 /*For VDPA device following situations are acceptable:*/<br>
+<br>
+=C2=A0 =C2=A0 if (memcmp(&amp;hwcfg.mac, &amp;zero, sizeof(MACAddr)) !=3D =
0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1.The hardware MAC address is the same=
 as the QEMU command line MAC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0address, and both of them =
are not 0.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((memcmp(&amp;hwcfg.mac, cmdline_mac, sizeo=
f(MACAddr)) =3D=3D 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vDPA device&#=
39;s mac %02x:%02x:%02x:%02x:%02x:%02x&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;not same with=
 the cmdline&#39;s mac %02x:%02x:%02x:%02x:%02x:%02x,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Please check.=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwcfg.mac[0], hwcfg=
.mac[1], hwcfg.mac[2], hwcfg.mac[3],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwcfg.mac[4], hwcfg=
.mac[5], cmdline_mac-&gt;a[0], cmdline_mac-&gt;a[1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_mac-&gt;a[2=
], cmdline_mac-&gt;a[3], cmdline_mac-&gt;a[4],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_mac-&gt;a[5=
]);<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
=C2=A0static void virtio_net_device_realize(DeviceState *dev, Error **errp)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>
=C2=A0 =C2=A0 =C2=A0VirtIONet *n =3D VIRTIO_NET(dev);<br>
=C2=A0 =C2=A0 =C2=A0NetClientState *nc;<br>
+=C2=A0 =C2=A0 MACAddr macaddr_cmdline;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (n-&gt;net_conf.mtu) {<br>
@@ -3862,6 +3893,7 @@ static void virtio_net_device_realize(DeviceState *de=
v, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0virtio_net_add_queue(n, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0n-&gt;ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net=
_handle_ctrl);<br>
+=C2=A0 =C2=A0 memcpy(&amp;macaddr_cmdline, &amp;n-&gt;nic_conf.macaddr, si=
zeof(n-&gt;mac));<br>
=C2=A0 =C2=A0 =C2=A0qemu_macaddr_default_if_unset(&amp;n-&gt;nic_conf.macad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0memcpy(&amp;n-&gt;mac[0], &amp;n-&gt;nic_conf.macaddr, =
sizeof(n-&gt;mac));<br>
=C2=A0 =C2=A0 =C2=A0n-&gt;status =3D VIRTIO_NET_S_LINK_UP;<br>
@@ -3908,7 +3940,13 @@ static void virtio_net_device_realize(DeviceState *d=
ev, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0nc =3D qemu_get_queue(n-&gt;nic);<br>
=C2=A0 =C2=A0 =C2=A0nc-&gt;rxfilter_notify_enabled =3D 1;<br>
<br>
-=C2=A0 =C2=A0if (nc-&gt;peer &amp;&amp; nc-&gt;peer-&gt;info-&gt;type =3D=
=3D NET_CLIENT_DRIVER_VHOST_VDPA) {<br>
+=C2=A0 =C2=A0 if (nc-&gt;peer &amp;&amp; (nc-&gt;peer-&gt;info-&gt;type =
=3D=3D NET_CLIENT_DRIVER_VHOST_VDPA)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nc-&gt;peer-&gt;check_mac) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_net_check_vdpa_mac(n=
c, n, &amp;macaddr_cmdline, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_cleanup(vde=
v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_net_config netcfg =3D {};<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;netcfg.mac, &amp;n-&gt;nic_co=
nf.macaddr, ETH_ALEN);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_set_config(get_vhost_net(nc-&gt=
;peer),<br>
-- <br>
2.45.0<br>
<br>
<br>
</blockquote></div>

--000000000000b5302c06319d962a--


