Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F9DC369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 03:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6hhN-0000CP-HI; Sun, 20 Apr 2025 23:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hhL-0000Br-H5
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hhK-00024K-0E
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745205593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZeM8Fh3JkaTL2q2OsU+R8nl9XV0WBVqvplTgjGA0ZSI=;
 b=KntA/2fngyaoQPldagp2L6/xwhVBBswC5QoNTRhAM0dqGMnIdZZW9ti3mjg12IXKNTvxPl
 Y4johXa0DATIfND2lsLyWy/n03hZpmIQDdxGC67B/P1uIENyitJlGD4gX5XHP66BskOodJ
 SUCEHsRHWIOpGw32o/OjwDPXd/QGT9s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-shvGqZdTP-CgQ1VBY8WkvA-1; Sun, 20 Apr 2025 23:19:51 -0400
X-MC-Unique: shvGqZdTP-CgQ1VBY8WkvA-1
X-Mimecast-MFC-AGG-ID: shvGqZdTP-CgQ1VBY8WkvA_1745205590
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-af9b25da540so2039508a12.2
 for <qemu-devel@nongnu.org>; Sun, 20 Apr 2025 20:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745205590; x=1745810390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeM8Fh3JkaTL2q2OsU+R8nl9XV0WBVqvplTgjGA0ZSI=;
 b=JtCfezvlYGPxpDWsiauz9YzY5sosvZ6UcJUvdczReCF71LQsd9vaFujAo3Zzlf/vlh
 Pciz6TFwwAQaarfHHl2kbTqYrgUEUBIQam8KXiuTmhIF4wHP8kp4FlepBYz0rs03psM/
 ESZlwg+X0LemhiGa8ea4TtQt7ggi0PnQr80ca08LVyhgewgz8AJz+biLWBlMQe7i3Czz
 CSD6b6es//2oUddV8OjeGAWzNuTIjxD1lK8DNiOKX+0PuQ9SnfHX8Z4j0YKOQLRzGfRW
 D9Ct0XEkoEIp0LHO65CFL7ChTQiAbuVMozV73gZuNzB9BwuYXzdGMunYOC22B45uZsIq
 R2Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1U1vmZU44Uw6TvAgRxQhBOWmR2mVCtTnykyYC63vvSrflm9DuKSG6P6jv/gZFo6+7UqBnh9+kqLcN@nongnu.org
X-Gm-Message-State: AOJu0YxfTrsdUNfVSULDImWJMGywEA/fzrNPWQwUurnJ+kPh3WISztEy
 +VrtvGRYqxdMxJ+YtqodMARqhWEeiClj/426mWIrEe153gdBOv+074d/e0o7FtyLHAnAOSS5q6o
 aY1ClTUttL7IjfXqDjoTmlxIfiXiErafFK/dV336NobZK6em5Xs2j1nQlT6YPeYNte8kpS5Gh9N
 3S2si1h6v8HZUZQoVub8PF21q2mlI=
X-Gm-Gg: ASbGnctsoqYqsYvlregTeJ7Xoy4rexKfHdlubRUza3iCFENVqE0jL4sOJeR3rbhYBQm
 mkkHGEA76xG39FZWm8eppJj8FkJf6HpGOZln+AEyCFSYFQe9n2PuR7OY9ndHvucwsFBnung==
X-Received: by 2002:a17:90a:fc4f:b0:308:2b5b:d67f with SMTP id
 98e67ed59e1d1-3087bb51a77mr15602790a91.9.1745205590338; 
 Sun, 20 Apr 2025 20:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ5l3vAZtIG010g1lhTmd/m7r94LbyovxRPMgJut6xVVDWM7vJhpeZ6QHSeRfC5aIVXkdXZh5w4uPzyTf67rM=
X-Received: by 2002:a17:90a:fc4f:b0:308:2b5b:d67f with SMTP id
 98e67ed59e1d1-3087bb51a77mr15602771a91.9.1745205590027; Sun, 20 Apr 2025
 20:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-4-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:19:37 +0800
X-Gm-Features: ATxdqUE7q8i9rJ0EraYxfj5MgvqXA1YGZoPpYiuljuQNPxr5Zh7ASgYcTGgdVN0
Message-ID: <CACGkMEscXQxKSNN=3-0wuYJUxw7wGby1B-pD0yLLbSOHY9ez0w@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] virtio_net: Add second acceptable configuration
 for MAC setup
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.69,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 17, 2025 at 6:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> For VDPA devices, Allow configurations where the hardware MAC address
> is non-zero while the MAC address in the QEMU command line is zero.
> In this case, QEMU will use the hardware MAC address from the device.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 0b6a4e5634..808a2fe4d4 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3757,6 +3757,20 @@ static bool virtio_net_check_vdpa_mac(VirtIONet *n=
, uint8_t *hwmac,
>          if ((memcmp(hwmac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0)) {
>              return true;
>          }
> +        /*
> +         * 2. The hardware MAC address is NOT 0 and the MAC address in
> +         *  the QEMU command line is 0.
> +         *  In this case,qemu will use the hardware MAC address overwrit=
e
> +         *  the QEMU command line MAC address saved in VirtIONet->mac[0]=
.
> +         *  In the following process, QEMU will use this MAC address
> +         *  to complete the initialization.
> +         */
> +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0) {
> +            /* overwrite the mac address with hardware address */
> +            memcpy(&n->mac[0], hwmac, sizeof(n->mac));
> +            memcpy(&n->nic_conf.macaddr, hwmac, sizeof(n->mac));

I'm not sure I get here, shouldn't we need to call get_config() here?

Thanks

> +            return true;
> +        }
>      }
>
>      return false;
> --
> 2.45.0
>


