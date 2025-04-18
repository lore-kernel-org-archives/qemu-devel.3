Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14862C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 02:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5bPJ-0007aw-Lc; Thu, 17 Apr 2025 22:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1u5bPH-0007ae-JW
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 22:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1u5bPF-00031f-Mo
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 22:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744943077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us/yCe+81fX4Hye8bzeb4M6/0RizDVqyKIAjZe1L68E=;
 b=Dri0icKqY1J0xixEVDXRlv8r4ObAsnd7Rzogg3Mvx30zJnFE1f7gqSAmHrG5uzzvMy7ZBI
 +Vg2vkPujZByMr+VZuZSkKSi7uHWPuN/Z8R9EPB7isQR4AzyG2qcx2FiifQTNVpRzM6Qet
 4D87FFnnoQDhtKLBey8Q8OvLd8VYYcI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-udOOe_urO0Wokhf-pEr6cQ-1; Thu, 17 Apr 2025 22:24:34 -0400
X-MC-Unique: udOOe_urO0Wokhf-pEr6cQ-1
X-Mimecast-MFC-AGG-ID: udOOe_urO0Wokhf-pEr6cQ_1744943073
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5e5c808e777so1226723a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 19:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744943073; x=1745547873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Us/yCe+81fX4Hye8bzeb4M6/0RizDVqyKIAjZe1L68E=;
 b=BO72vYxJGJ+H9u5PIyzr3uVuIZik7amHgWfNSLdpWEKgWGhftOFdZlYMlOQ6iZU4qW
 TsMjhZlsmXAAerCd2x6YyFayVSbQpsRlFiQWuk5I/TkcKzCsI1C8aBjTuIyoX3Nk9KlU
 7ixL9P8O0KVALYhgYP5z1N3fQ+oKOtWCrd9k5xLmLXOaLSYSROI2Az5w1cn4jBJEyANu
 DN8oSNYiuNX/wJX1L8ghe3fky0bD7TdlGaNCgeDX/2EeJmUStW+k43+Ke1/wp17gYoHi
 AUn2OU5aQiyWrlHx2xg7XUkVyucaZgH0pteuUwfnRyusWpfIsMSfOqa/2UsCUeUhod65
 FsJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl+AQnUyJyGH50PsP4r6lZCMmqGL7UDRDMqtUDl4tX7z+f3KaZ0j5c9iwTE9r1JNWlxWhMolIzd6ml@nongnu.org
X-Gm-Message-State: AOJu0Yw2H0NYuPyT7XfQcr55R1EJyP+gUd6bUDiDtwwER8fCE+pXM04G
 cTz6etZhcjzmM19P5vUIhTiddEa197PDqKHp6B1fIUKoT0yM7QiFequGHt/EziTKBVfCYXQmW0U
 giDMUppTeYYMGgARY2/rtylZWlzLkb+uvZryvrJmXlCtqlV3yk06YouMCMKUx1Z+OIJJr1o6NdN
 xZMjkSB/JG12uDWSwUmL/xcuRHHjg=
X-Gm-Gg: ASbGnct8k5RH1RHgokgZWNNatj1OGsjk76oIKxHNz2SIpjupYKabBmb1sI6DfsUpING
 IAw9Q1fFtMDqsjfeN1DmcQa5mML+KazKsbH9qMQVEOkiHDh0Ga5ejTk1kE210TcXEvdB8WQ==
X-Received: by 2002:a05:6402:354a:b0:5f4:d605:7f5c with SMTP id
 4fb4d7f45d1cf-5f6285e88ecmr881377a12.22.1744943072844; 
 Thu, 17 Apr 2025 19:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1CpsIg7LrRiAA9nzFBazqKT0BVVCl6a7edJf7jwhFu8f/ugdLwhLO3vAFl8rO3pCp2UP7lCX0N0MTE69G9f4=
X-Received: by 2002:a05:6402:354a:b0:5f4:d605:7f5c with SMTP id
 4fb4d7f45d1cf-5f6285e88ecmr881363a12.22.1744943072426; Thu, 17 Apr 2025
 19:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-2-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-2-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 18 Apr 2025 10:23:55 +0800
X-Gm-Features: ATxdqUHcm1yWStJc_oFdZQg9C3NrwHFALQuSce0__djCGrQmIvtfYgdcyBgrIzI
Message-ID: <CAPpAL=wN5Kjk4=FzyucWjrK4QZHdEy4NUVyvZY_kqkybBzgccw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I tested this series of patches v7 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Apr 17, 2025 at 6:26=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
>


