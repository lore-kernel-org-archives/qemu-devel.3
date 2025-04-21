Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F73C369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 03:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6hcl-0006jg-Gd; Sun, 20 Apr 2025 23:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hcj-0006hk-1E
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hcg-0001W2-Pq
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745205302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHQmqt9gC3t71DwtGenMr+UddEKoD7rBR56oWz+i72Y=;
 b=ih6qHbhikQKe0QUn0lZUCrl34pVSCFCOolIFr3keO0d0au8YSsMXpZwkLgiRW6R/HKEtAI
 ww+A1c+vt5QzgbdQwUQ7yKrMa4g8y4hiG2RM1UeKDzo4TVTbE4lsCrWvkfmqiLC/rYF7G0
 u/nb3BxIH/eNURPGpm6eELW/PUbdyKk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-TbhXmxkCOdaHHO6GIFucTw-1; Sun, 20 Apr 2025 23:14:56 -0400
X-MC-Unique: TbhXmxkCOdaHHO6GIFucTw-1
X-Mimecast-MFC-AGG-ID: TbhXmxkCOdaHHO6GIFucTw_1745205295
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff6af1e264so4975986a91.3
 for <qemu-devel@nongnu.org>; Sun, 20 Apr 2025 20:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745205295; x=1745810095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHQmqt9gC3t71DwtGenMr+UddEKoD7rBR56oWz+i72Y=;
 b=b3JRFjkMnMjIWP+qY67m5roh7W9WcdApDdw1VXos4/9XEeWNMUJIjc1VM1gYr4Xe/g
 HqMIGSnmm4rQIKAJcIKp1MufaF2ICJHrNi3r4SBARe6ibFs0i6KIM0AP2qvOghrj2hWF
 PGc2emg/hao+B6BWDb8ChjyLk9i/ARqAaeVFHEcHarE2CP2SBsxWZZ5b4mB1TLK4e4vr
 rmeFFPH/MvZz1/iJ3caccDMGIFgfv8JSoIV693os+XzbBbXTTWUP+/n+ty3eqyOaoKJd
 +JC/PamKb8xgxKTgZwG0jFQ5JyzMbNIddCv9yP+qa29a+rffpsva6eJbAQSEFZJjbbEY
 r82g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWktg8l9gWInJ6ff3pmmRB0IdPag/CVG1YVOB17FHT3ZkDyET0PCm6andZvUMhx8uDujHaN74fxiMTq@nongnu.org
X-Gm-Message-State: AOJu0Yxtp2hjLMKv4SB/yZ2XTxt9WIqkkubdKAX7z7tf8A8Plc0qqH6X
 EDdVQNS4dRctvn7HuktznUCM5zZyuTrdEZxb+msK2CASNjTlqvO40LyoViPV76w8bBT6Y3vLiaN
 rm/QNAFn9AivxkhkNp2saTj/Ra6/cRAEkFPLk9gW+BVhIqvI4NllmizxdR58ACa7CySfp8X2C/T
 efrZVvtXMvNkwobS9pGBdkauxPdjo=
X-Gm-Gg: ASbGncv3LQNDNphp+MKmKhVKYW9Umtp7Yd63EH/AQooFUkKicFj+PAhplWrQXiEg/Nz
 /nnoWUzHp0tUEEsQwXTTgxZAwd5703sN0qmAR8cYvkfqZ94zmZ4CQ3QUOpT/UmjseRt1pog==
X-Received: by 2002:a17:90b:2d0d:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-3087bbbddc7mr14664546a91.28.1745205295129; 
 Sun, 20 Apr 2025 20:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFh5onAf7F3EZL7jbO4trE3Cnpdg4pi4dyeLevFpz0F8JOpDqYi9GNIBoXD2OpAJ2w5nPfsI9AgyDU64YRJ5g=
X-Received: by 2002:a17:90b:2d0d:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-3087bbbddc7mr14664525a91.28.1745205294693; Sun, 20 Apr 2025
 20:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-2-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:14:41 +0800
X-Gm-Features: ATxdqUHa4bMjkzY-nx7IU_kb6bw2U1EbXVAGIi0_-Y_riKwj8VKeHRe-ZWKxA4o
Message-ID: <CACGkMEvrX0FouHnrog_GV7Rjtwao+ZU50U-2BpuaceSMz_hmNw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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
> When using a VDPA device, it's important to ensure that the MAC
> address is correctly set.
> This patch adds a new QEMU command line parameter to enable MAC
> address verification,  which is enabled by default.
>
> Usage example:
> ....
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,c=
heck-mac=3Dtrue\
> -device virtio-net-pci,netdev=3Dvhost-vdpa0\
> ....
> To disable this check:
> ....
> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0,c=
heck-mac=3Dfalse\
> -device virtio-net-pci,netdev=3Dvhost-vdpa0\
> ....
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

This patch needs to be squashed to the patch that implements the real
logic of the checking.

> ---
>  include/net/net.h | 1 +
>  net/vhost-vdpa.c  | 5 +++++
>  qapi/net.json     | 5 +++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index cdd5b109b0..fac1951b6e 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -112,6 +112,7 @@ struct NetClientState {
>      bool is_netdev;
>      bool do_not_pad; /* do not pad to the minimum ethernet frame length =
*/
>      bool is_datapath;
> +    bool check_mac;
>      QTAILQ_HEAD(, NetFilterState) filters;
>  };
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7ca8b46eee..7dbe6cf65c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1871,6 +1871,11 @@ int net_init_vhost_vdpa(const Netdev *netdev, cons=
t char *name,
>          if (!ncs[i])
>              goto err;
>      }
> +    /* Enable the mac check by default */
> +    if (opts->has_check_mac)
> +        ncs[0]->check_mac =3D opts->check_mac;
> +    else
> +        ncs[0]->check_mac =3D true;

How could we maintain the migration compatibility here?

>
>      if (has_cvq) {
>          VhostVDPAState *s0 =3D DO_UPCAST(VhostVDPAState, nc, ncs[0]);
> diff --git a/qapi/net.json b/qapi/net.json
> index 310cc4fd19..0607c83833 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -510,6 +510,10 @@
>  # @queues: number of queues to be created for multiqueue vhost-vdpa
>  #     (default: 1)
>  #
> +# @check-mac: Enable the check for whether the device's MAC address
> +#     and the MAC in QEMU command line are acceptable for booting.
> +#     (default: true)
> +#
>  # @x-svq: Start device with (experimental) shadow virtqueue.  (Since
>  #     7.1) (default: false)
>  #
> @@ -524,6 +528,7 @@
>      '*vhostdev':     'str',
>      '*vhostfd':      'str',
>      '*queues':       'int',
> +    '*check-mac':    'bool',
>      '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
>
>  ##
> --
> 2.45.0
>

Thanks


