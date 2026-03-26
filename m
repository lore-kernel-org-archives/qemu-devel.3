Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A03106F31B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5hqA-0001Vx-EM; Thu, 26 Mar 2026 06:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5hq9-0001Vk-DS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5hq7-0000xY-2g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774520481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/+SpMXv7KGVSk1hOpwxA7vmmap0zT8v7FVtqD4vnJY=;
 b=eRMS4972MYMrtpY7PvOWrN+ZV1tD9DFa12lG9rgPqvd+ddbMitXN7+L391VZwZH7VRPSsR
 /8R7dsUWtojrXzp5sI/Kc6u0iq665pkhErdY7PZ4nYu5OejUufkMPROu7+D0oUrZJomC1N
 NYhOP8xNouj8h/GHMVP9tZjIGukUeDs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-u6ZFKol5NJSPJt2Ikqgd_w-1; Thu, 26 Mar 2026 06:21:19 -0400
X-MC-Unique: u6ZFKol5NJSPJt2Ikqgd_w-1
X-Mimecast-MFC-AGG-ID: u6ZFKol5NJSPJt2Ikqgd_w_1774520479
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79a51ba2bf9so16597227b3.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 03:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774520479; cv=none;
 d=google.com; s=arc-20240605;
 b=g1fH2YEGwa1tKJuPP5j725QYUiE6jNC2x5p+gV1klXVWmWAyIM0YdNPFYcXrCF3nbW
 L5GzPZYGT6LSjZDAdqPu+mz59jCrvDvUyR4GHSlSehqx1v5mq5u6NzoZLAZE+uoZ6FmB
 L3voiC3DwGddnUf9Z4ceFn6jyEJXNeEfdIdHu9eE48NfWSNKv3q0tuzTl6kMVWcMvsd8
 gyY8gytXnXeZw96QQFfVrS/X22Rblq+6P2yuhhzzF7g+q1bJvbGiA28LUILMmPo9rByv
 nk5k3vTXckOcgYPajtscsg02cnITkgR+6XZnKkD9fT02GhGm/9BOXsIog9bAUdUi5I2/
 FHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r/+SpMXv7KGVSk1hOpwxA7vmmap0zT8v7FVtqD4vnJY=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=aX/J0jOMwrDUnbyyqc4S3LuDY1ihElGPrNm3eVoV8mqelW6rCcnWUBaKpKSQmwRvh5
 DmT9bmpesC7AAzixX+WylAzyE7g/dzIyBXPd1bxsecQPTXIlvmQi7naWJwlktnrf+v/C
 O5a+kGWAQliPcRw/OWdmAIjASw0blLoQ9jodvHLUdoGMnZohBRRxbEgx4G3Zm2jMEy6t
 AsCTslfqfYuqAdxPeYLLuiEK1AvOx5c4QUwRMkqoLmOQtOiLIdmDDwhYLoQOZon9RqVy
 jty5kfD+qhE6f9uAaCFDPLlWui4z0ivNI09en5BMI7a0hZJ73InXwWztrkHd1iBUixbm
 nouQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774520479; x=1775125279; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/+SpMXv7KGVSk1hOpwxA7vmmap0zT8v7FVtqD4vnJY=;
 b=i1ubNaWEt2KlALMiD33qRNZLP6JYDamtTQJoAIFgqCN/Hz6pHV9W5Yy+R2iX2Q1lSi
 Ja4aL3Y4sWqCgxro3cIj81ckIBUfTzFlmZ62iEXUgVyiKOI3MURXThjGNqlsOtRyzjyZ
 z22IaYx4/GF71D+gSegpxt+gJ2jxsaguO19Jtohz8JHchCvZfOAk6XSZzyAgKxyNMox1
 tdpDOTywm2G1obqmEO9ocHMtwmB57hpt5cxGi6ozy/FRxZxDiAbfq5Bq20zrdPLYiHZg
 Un/pUkQv40W95VebNR+kf+kF2h1X4GkEw2GhDnPtZIYi5Sjl/en5P+JKYW4Qu9ra6wfv
 BG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774520479; x=1775125279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/+SpMXv7KGVSk1hOpwxA7vmmap0zT8v7FVtqD4vnJY=;
 b=SrVusWXyruxBjcrMyMjEeMf6w0G/hugTFSrWCImZpHM3GcgfHraAnZYIiD8ln8IzCy
 /vQ6g8j/jX2+tdzb1pIaMV5NARs7ohgCfG23KCUNRT7vtextoyiKnfJPlNIJuw4J2+dB
 CFaoMQYsvFSDiQTXrLklE4tuMTmpl6zODMie8g7F51tVsJ6IsQ2Y1HviMOHNPpTiOdHG
 eCQQOp77o+n5VA/KStJlqItBnIggkEiGz5arn486wpIpgK8rkQO7FZLfd9OMquXjUSpW
 V72XDALgaVK0bxqfAkRqKU9m88ipibUrveT7o2bkuLn3FhkQzisJ4O7E0RLOeS4ZVTb8
 tyfw==
X-Gm-Message-State: AOJu0YyNnJwH1X0MPWrhjdqgBsGWabf/qyITECD0+HlMFNDfgMVeOXqG
 y0mbF24p3cpDh+6lau7PT0htPK6YiGTmKZZ+6zTn9d3GrAsAP3HHqZ3IN55orQ6cv+JO2cf8gIG
 moQ+Xkb3y0WwN4rNoqMoHmV5bEik6nmybIIgxY8oraWGvn4NVrktTta92m955NVJpYEO8sAcRD2
 AArv0R+fvUFqvRjfIohjSL82wL2yICQWA=
X-Gm-Gg: ATEYQzyt7WWACkQKu+9h6PdllsYm+WybiEqqKOZ5ZY3fdP/oHQ9nRZTGmq90pGOoe9c
 q8jEP4RMIFjp+ENTI4jYxHuBQiciwafennxmd57kt6NQsN6pl8g/C03axqbD/ibzQohHYEtUEtm
 AW387y9yFuy0QZsTBvIvf0Yw9jNZ40yrvZoWbuLCijfC0ScC/6s0P+AHwon5Nnw+9r9qjpCyETs
 Tzjbg==
X-Received: by 2002:a53:ce83:0:b0:64f:1278:e7b1 with SMTP id
 956f58d0204a3-64f1278eaf9mr2333794d50.23.1774520478732; 
 Thu, 26 Mar 2026 03:21:18 -0700 (PDT)
X-Received: by 2002:a53:ce83:0:b0:64f:1278:e7b1 with SMTP id
 956f58d0204a3-64f1278eaf9mr2333778d50.23.1774520478348; Thu, 26 Mar 2026
 03:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-9-jonah.palmer@oracle.com>
 <CAJaqyWebEJN0GL=5yotWcF=48FW6r2yO+q21ZZ-7DeawbTNocQ@mail.gmail.com>
 <32947c99-004e-4c6f-9e9b-abf50f52813f@oracle.com>
In-Reply-To: <32947c99-004e-4c6f-9e9b-abf50f52813f@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Mar 2026 11:20:42 +0100
X-Gm-Features: AaiRm50CcRZYVpgkk6-L-1B381cgMOUgCzBRyWVrjzMR9BebHNzrfx2nDSmjCmQ
Message-ID: <CAJaqyWf5s+7vkR=mePJ6_HjyVqh_C0n07ouUK9WQtdMOAEj9jQ@mail.gmail.com>
Subject: Re: [RFC v2 08/14] virtio-net: detect VirtIONet status mid-migration
 change
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 5:23=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/24/26 7:26 AM, Eugenio Perez Martin wrote:
> > On Fri, Mar 20, 2026 at 3:21=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Save VirtIONet's status field during early migration and compare it
> >> again during stop-and-copy.
> >>
> >> VirtIONet keeps its own status bits here, including VIRTIO_NET_S_LINK_=
UP
> >> and VIRTIO_NET_S_ANNOUNCE.
> >>
> >
> > These are particular to the device, so we don't need to migrate them.
> > If any, we should check if the destination device changed the link
> > state so we can update the guest, but we don't do that as far as I
> > know.
> >
>
> Sorry I might be misunderstanding something, but isn't VirtIONet's
> status member being migrated today (vmstate_virtio_net_device)?
>

Nevermind, I was too vhost-vdpa centric with this comment :).
Migrating it in the general case is ok.

> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/net/virtio-net.c            | 6 ++++++
> >>   include/hw/virtio/virtio-net.h | 2 ++
> >>   2 files changed, 8 insertions(+)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 2dd130777e..88ce33b1d2 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -3872,6 +3872,7 @@ static int virtio_net_early_pre_save(void *opaqu=
e)
> >>       VirtIONetMigration *vnet_mig =3D n->migration;
> >>
> >>       vdev_mig->status_early =3D vdev->status;
> >> +    vnet_mig->status_early =3D n->status;
> >>
> >>       /* VirtIODevice config buffer snapshot */
> >>       g_free(vdev_mig->config_early);
> >> @@ -4304,6 +4305,11 @@ static bool virtio_net_has_delta(VirtIONet *n, =
VirtIODevice *vdev)
> >>           return true;
> >>       }
> >>
> >> +    /* Has the VirtIONet's status changed? */
> >> +    if (n->status !=3D vnet_mig->status_early) {
> >> +        return true;
> >> +    }
> >> +
> >>       /* Has the VirtIONet's MAC info changed? */
> >>       if (memcmp(n->mac, vnet_mig->mac_early, ETH_ALEN) !=3D 0) {
> >>           return true;
> >> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h
> >> index 1e1f1a3995..59345f1811 100644
> >> --- a/include/hw/virtio/virtio-net.h
> >> +++ b/include/hw/virtio/virtio-net.h
> >> @@ -169,6 +169,7 @@ typedef struct VirtIONetQueue {
> >>
> >>   /**
> >>    * struct VirtIONetMigration - VirtIONet migration structure
> >> + * @status_early: VirtIONet status snapshot.
> >>    * @mac_early: MAC address early migration snapshot.
> >>    * @mtable_in_use_early: In-use MAC table entries.
> >>    * @mtable_uni_overflow_early: Unicast overflow MAC table entries.
> >> @@ -176,6 +177,7 @@ typedef struct VirtIONetQueue {
> >>    * @mtable_macs_early: MAC table entries.
> >>    */
> >>   typedef struct VirtIONetMigration {
> >> +    uint16_t status_early;
> >>       uint8_t mac_early[ETH_ALEN];
> >>       uint32_t mtable_in_use_early;
> >>       uint8_t mtable_uni_overflow_early;
> >> --
> >> 2.51.0
> >>
> >
>


