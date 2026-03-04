Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963FFEDEC00
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgY3-0006l1-T8; Wed, 04 Mar 2026 02:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgXx-0006ia-Vh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgXv-00034y-PE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772608886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mqacOXuW5SRXfyaxatnRsJRJ/Oylzbltq+FndNCe0E=;
 b=YpopISfYBdPFKnHEuGRiWOmE1m838XAoK/CAvED9ZnDl8gO5OjOaMFrjb7yiGXL0BHO9FQ
 VhaVUh/3sz2WB+I7Cll8zAFwtJtHTwgzRsRgD6GkFrtO2gyEdsVSL3B4R0uUHl0dlsDt8E
 SraoohC7o2Ngqfokofd3jVwmCSc/0aM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-AHBZ0mR-NxmdT7697TE2-Q-1; Wed, 04 Mar 2026 02:21:18 -0500
X-MC-Unique: AHBZ0mR-NxmdT7697TE2-Q-1
X-Mimecast-MFC-AGG-ID: AHBZ0mR-NxmdT7697TE2-Q_1772608878
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so32109498a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:21:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608878; cv=none;
 d=google.com; s=arc-20240605;
 b=UMWsYuB+4Oxmv6p77Fx7uvjAMPtY7POrO+jyrjBXp6AkJBvXqsEAAajPCoijriYEhx
 tOB9n9g/LxCW8FoHdB/iXCzhu0caKJWeqjR899wEEdgHzADr+rAk4lpE5mR/uTzC+S0M
 tPe05lZZU7tiplj7fr8CZEyUc3O+TaDyG2iq0T7ejE2XUJUK9N0ktzfZEcIMG8+xTjhK
 0znEZBJQexfJWqYYZw7ZC2ATb412qBjr9eL5skSmArfXnZRGz9mNWquN+S1zItibFJin
 m5JAY3cJ7qhxFkcnpDpwlS06GbeZQo9CL9upvCgHmK/JXznpSl4Hhoyg1uG6NQ61R8xb
 ApBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0mqacOXuW5SRXfyaxatnRsJRJ/Oylzbltq+FndNCe0E=;
 fh=bS563s3ZKRoM1ibQ62GS+C+4EXOVhZ/yrlCoDhmNT4s=;
 b=REicawGwjb3SvPd/cf2gFvwMwvzHcE7mF/pGK/xeMvLY5fYf4YaEVdpVwtG045G0gI
 HSm5rgcZHzc7WHlv/wL5+AJ8XXqRqT0ssCYTqgfNj8Ia8jpq9W4k8WtvNC3lwL+dQeD4
 IezCA0/N+TAR3vBv22aNhR88MFWq4vDOIHDZq/S+MKuf80EPQNpcjIW7NtuB+UiWTakR
 tG4pdGvrrgULJXJPPE9wq9EdTA2g9qGIIG3unn2GYuCea6G+6BP0uhC3t4H5SQjQxDKm
 zPqJsO/AzVSmZ/ZkFCsSffziBpYgnoYsSqUVZoH3riCfm/S6s01uML9VgagtCS0CstxZ
 oHzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772608878; x=1773213678; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mqacOXuW5SRXfyaxatnRsJRJ/Oylzbltq+FndNCe0E=;
 b=qOyz+sYSOnB3nsy8pP6tO9q1FBhz5wta9KyqAsKo8i3A9/W3PceY1DsZh6HLSoA6W5
 g+9ebe3v2knWGZhrPcZFaemPBS1H3vLrDa9+9mPxn8vYAqWMpTIjB/B3odU6xJ5NT5I9
 sN/lfnCEviRCYaI4hd+SX15QxMUqu8ldNJUzSxAjFFBAjozxiMyKFWL+02NUmxh+uZ11
 394vAaKVXTrrun2AJvpBEgZB7An/QBSqDHANKPRvzeW5lLtXtco/xbxO0b/02o0NHxTR
 zB+H3HYb1be59+4o26X1WDPdXVLOhu+UjZaxn2T5bRs9YN9OxFH96E9X0Nx5dPAWwGCn
 TdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772608878; x=1773213678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0mqacOXuW5SRXfyaxatnRsJRJ/Oylzbltq+FndNCe0E=;
 b=KzCH1Jkea5K/4zBtVWPccPWOwllINzIeNH8ULIs1gEbElkO5H1C7lv4mFTnbZ3Jtbm
 u53GDdT+hjlVW+zpwQCTfA1v0d8+wUtSb8SolaOKAvjtxRZypQxZGJLuusAhd+IxCNXO
 Pc4+dGJK6Z7VbwXM9pMoloeuWFRpc05BbyWMaYvPTrR7I5lQKeA/g7dYDCewToO4rInw
 v4bhRlzBwTflB1UK9TI9l0e+N4hSc5AQ4yv+/aKVMi4meVhQdrQhwCFHjasSBGZMChe8
 qjh/7YtIwypbCjvOQnR57rBmZgPkyQIkpq0q4QLYgucUUo861xJoHmvIhWi4sFJF/L+P
 UWrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXClC4LCJrMUe/Djd8gGZj3jDsFFK7j8eyW9lB8gWEVakZ9PBC70kyPF65W/cEEFaaF5BNABEjH+8QT@nongnu.org
X-Gm-Message-State: AOJu0YxvreMc9zUQ43i2FCMkJc6yvnoB+tlHPYIt1feUSeDm4weKvk/7
 ziwFK0UdZZc2XlbFyiUEfqDO3SPGXSr9Ng3rPfTYWg2oM5FSFuff85qv4KleXV/6xf9aFuNqaBP
 o/g/ZqpmUImSY8XjqJE6MXnQnf5tt2hW4bAlkaowIuaw5WvYIChrmfKTHRRAIh/bSvGIuXdr4En
 Bey9XelgmaS9DCKLVGyGnSD90k5o3ZbLI=
X-Gm-Gg: ATEYQzxRQiXctny42XXSNUB1wHFsRF0b3yo24aPbA8mt/WMJ7LcJshm7ZouczhsE23Z
 4gXPdsHKXmQP4BkfvF9QzgrDXj6jrZpnNyLxw0w6xyTNAtNMZatICF4/SJRJJfWKdgEio35410a
 nLwr41kAQOpODaAg0fUyBZ6d52xNLwJVNr58/cTyDjV3jZxc1TezA4DoHGq1a1NnrzIQ8Zhg5ch
 th4I1Y=
X-Received: by 2002:a17:90b:48d1:b0:359:8c89:96d3 with SMTP id
 98e67ed59e1d1-359a69f2b62mr1106956a91.15.1772608877825; 
 Tue, 03 Mar 2026 23:21:17 -0800 (PST)
X-Received: by 2002:a17:90b:48d1:b0:359:8c89:96d3 with SMTP id
 98e67ed59e1d1-359a69f2b62mr1106930a91.15.1772608877329; Tue, 03 Mar 2026
 23:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20260213071042.3733239-1-lulu@redhat.com>
 <20260213071042.3733239-4-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:21:06 +0800
X-Gm-Features: AaiRm53eyt5TZLf7uddA1OAstyedK64mLmEYSHExJoM-NgCVW2356Tk3WPV5RPQ
Message-ID: <CACGkMEvQBjt3OYfanUbJvPZu16ecMC8uVhf7_w5U=d0fBoBq4g@mail.gmail.com>
Subject: Re: [RFC 3/5] net/filter-redirector: Add AF_PACKET sockets
 initialization
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 13, 2026 at 3:11=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Implement the initialization logic for AF_PACKET based netdev
> endpoints in filter-redirector:
>
> 1. filter_redirector_netdev_setup(): Creates and binds AF_PACKET
>    sockets to the specified TAP interface. For in_netdev, the socket
>    is used to receive packets; for out_netdev, it is used to send.
>
> 2. filter_redirector_netdev_read(): Async handler for reading packets
>    from the in_netdev AF_PACKET socket. Packets are forwarded through
>    the redirector chain.
>
> 3. Updated cleanup to properly close AF_PACKET sockets and free
>    associated buffers.
>
> 4. Modified allow_send_when_stopped logic to consider both chardev
>    and netdev output endpoints, and to only enable when the
>    redirector is active (status=3Don).
>
> 5. VM state change handler now manages the AF_PACKET read handler
>    activation based on VM running state and enable_when_stopped.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  net/filter-mirror.c | 241 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 224 insertions(+), 17 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 37035f3892..f8001612ec 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -26,6 +26,13 @@
>  #include "qemu/sockets.h"
>  #include "block/aio-wait.h"
>  #include "system/runstate.h"
> +#include "net/tap.h"
> +#include "net/tap_int.h"
> +
> +#include <sys/socket.h>
> +#include <net/if.h>
> +#include <linux/if_packet.h>
> +#include <netinet/if_ether.h>
>
>  typedef struct MirrorState MirrorState;
>  DECLARE_INSTANCE_CHECKER(MirrorState, FILTER_MIRROR,
> @@ -42,6 +49,10 @@ struct MirrorState {
>      char *outdev;
>      char *in_netdev;
>      char *out_netdev;
> +    NetClientState *out_net;
> +    int in_netfd;
> +    uint8_t *in_netbuf;
> +    int out_netfd;
>      CharFrontend chr_in;
>      CharFrontend chr_out;
>      SocketReadState rs;
> @@ -172,6 +183,17 @@ static int redirector_chr_can_read(void *opaque)
>      return REDIRECTOR_MAX_LEN;
>  }
>
> +static bool filter_redirector_input_active(NetFilterState *nf, bool enab=
le)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> +
> +    if (!enable) {
> +        return false;
> +    }
> +
> +    return runstate_is_running() || s->enable_when_stopped;
> +}
> +
>  static void redirector_chr_read(void *opaque, const uint8_t *buf, int si=
ze)
>  {
>      NetFilterState *nf =3D opaque;
> @@ -208,6 +230,40 @@ static void redirector_chr_event(void *opaque, QEMUC=
hrEvent event)
>      }
>  }
>
> +static void filter_redirector_netdev_read(void *opaque)
> +{
> +    NetFilterState *nf =3D opaque;
> +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> +    struct sockaddr_ll sll;
> +    socklen_t sll_len;
> +    ssize_t len;
> +
> +    if (!s->in_netbuf || s->in_netfd < 0) {
> +        return;
> +    }
> +
> +    for (;;) {
> +        sll_len =3D sizeof(sll);
> +        len =3D recvfrom(s->in_netfd, s->in_netbuf, REDIRECTOR_MAX_LEN, =
0,
> +                       (struct sockaddr *)&sll, &sll_len);
> +        if (len <=3D 0) {
> +            break;
> +        }
> +
> +        if (sll.sll_pkttype !=3D PACKET_OUTGOING) {
> +            continue;
> +        }
> +
> +        redirector_to_filter(nf, s->in_netbuf, len);
> +    }
> +
> +    if (len < 0 && errno !=3D EAGAIN && errno !=3D EWOULDBLOCK &&
> +        errno !=3D EINTR) {
> +        error_report("filter redirector read in_netdev failed(%s)",
> +                     strerror(errno));
> +    }
> +}
> +
>  static ssize_t filter_mirror_receive_iov(NetFilterState *nf,
>                                           NetClientState *sender,
>                                           unsigned flags,
> @@ -268,7 +324,19 @@ static void filter_redirector_cleanup(NetFilterState=
 *nf)
>
>      qemu_chr_fe_deinit(&s->chr_in, false);
>      qemu_chr_fe_deinit(&s->chr_out, false);
> -    qemu_del_vm_change_state_handler(s->vmsentry);
> +    if (s->vmsentry) {
> +        qemu_del_vm_change_state_handler(s->vmsentry);
> +        s->vmsentry =3D NULL;
> +    }
> +    if (s->in_netfd >=3D 0) {
> +        qemu_set_fd_handler(s->in_netfd, NULL, NULL, NULL);
> +        close(s->in_netfd);
> +        s->in_netfd =3D -1;
> +    }
> +    if (s->out_netfd >=3D 0) {
> +        close(s->out_netfd);
> +        s->out_netfd =3D -1;
> +    }
>
>      if (nf->netdev) {
>          nf->netdev->allow_send_when_stopped =3D 0;
> @@ -320,13 +388,13 @@ filter_redirector_refresh_allow_send_when_stopped(N=
etFilterState *nf)
>
>      /*
>       * Allow sending when stopped if enable_when_stopped is set and we h=
ave
> -     * an outdev. This must be independent of nf->on (status) so that pa=
ckets
> -     * can still flow through the filter chain to other filters even whe=
n this
> -     * redirector is disabled. Otherwise, tap_send() will disable read_p=
oll
> -     * when qemu_can_send_packet() returns false, preventing further pac=
ket
> -     * processing.
> +     * a redirector output endpoint and the redirector is enabled.
> +     * Keeping this active while redirector status=3Doff can unexpectedl=
y
> +     * drain packets in migration stop windows and perturb vhost ring st=
ate.
>       */
> -    nc->allow_send_when_stopped =3D (s->enable_when_stopped && s->outdev=
);
> +    nc->allow_send_when_stopped =3D (nf->on &&
> +                                   s->enable_when_stopped &&
> +                                   (s->outdev || s->out_netdev));
>  }
>
>  static void filter_redirector_vm_state_change(void *opaque, bool running=
,
> @@ -335,8 +403,16 @@ static void filter_redirector_vm_state_change(void *=
opaque, bool running,
>      NetFilterState *nf =3D opaque;
>      MirrorState *s =3D FILTER_REDIRECTOR(nf);
>      NetClientState *nc =3D nf->netdev;
> +    bool active =3D filter_redirector_input_active(nf, nf->on);
> +
> +    if (s->in_netfd >=3D 0) {
> +        qemu_set_fd_handler(s->in_netfd,
> +                            active ? filter_redirector_netdev_read : NUL=
L,
> +                            NULL,
> +                            active ? nf : NULL);
> +    }
>
> -    if (!running && s->enable_when_stopped && nc->info->read_poll) {
> +    if (!running && nc && s->enable_when_stopped && nc->info->read_poll)=
 {
>          nc->info->read_poll(nc, true);
>      }
>  }
> @@ -362,21 +438,127 @@ static void filter_redirector_maybe_enable_read_po=
ll(NetFilterState *nf)
>      }
>  }
>
> +static bool filter_redirector_netdev_setup(MirrorState *s, Error **errp)
> +{
> +    struct sockaddr_ll sll =3D { 0 };
> +    char ifname[IFNAMSIZ] =3D { 0 };
> +    int ifindex;
> +    int fd;
> +    NetClientState *nc;
> +
> +    if (s->in_netdev) {
> +        int tapfd;
> +        nc =3D qemu_find_netdev(s->in_netdev);
> +        if (!nc) {
> +            error_setg(errp, "in_netdev '%s' not found", s->in_netdev);
> +            return false;
> +        }
> +
> +        if (nc->info->type !=3D NET_CLIENT_DRIVER_TAP) {
> +            error_setg(errp, "in_netdev '%s' must be a TAP netdev",
> +                       s->in_netdev);
> +            return false;
> +        }

This seems inelegant; the netfilter should not be coupled with a
specific netdev type. Any reason for doing this?

> +
> +        tapfd =3D tap_get_fd(nc);
> +        if (tapfd < 0 || tap_fd_get_ifname(tapfd, ifname) !=3D 0) {
> +            error_setg(errp, "failed to resolve TAP ifname for in_netdev=
 '%s'",
> +                       s->in_netdev);
> +            return false;
> +        }
> +    } else if (s->out_netdev) {
> +        nc =3D qemu_find_netdev(s->out_netdev);
> +        if (!nc) {
> +            error_setg(errp, "out_netdev '%s' not found", s->out_netdev)=
;
> +            return false;
> +        }
> +        /*
> +         * out_netdev always uses AF_PACKET.

I think I don't get this.

> For TAP netdev we resolve the
> +         * interface name from tap fd; for non-TAP netdev we interpret
> +         * out_netdev string as host interface name.
> +         */
> +        if (nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
> +            int tapfd =3D tap_get_fd(nc);
> +
> +            if (tapfd < 0 || tap_fd_get_ifname(tapfd, ifname) !=3D 0) {
> +                error_setg(errp,
> +                           "failed to resolve TAP ifname for out_netdev =
'%s'",
> +                           s->out_netdev);
> +                return false;
> +            }
> +        } else {
> +            snprintf(ifname, sizeof(ifname), "%s", s->out_netdev);
> +        }
> +    }
> +
> +    ifindex =3D if_nametoindex(ifname);
> +    if (!ifindex) {
> +        error_setg_errno(errp, errno,
> +                         "failed to resolve ifindex for '%s'", ifname);
> +        return false;
> +    }
> +
> +    fd =3D qemu_socket(AF_PACKET, SOCK_RAW | SOCK_NONBLOCK, htons(ETH_P_=
ALL));

There must be a misunderstanding; can we simply reuse the -netdev
socket for packet socket?

Another concern, using packet socket requires CAP_NET_ADMIN etc.

> +    if (fd < 0) {
> +        error_setg_errno(errp, errno, "failed to create AF_PACKET socket=
");
> +        return false;
> +    }
> +
> +    sll.sll_family =3D AF_PACKET;
> +    sll.sll_ifindex =3D ifindex;
> +    sll.sll_protocol =3D htons(ETH_P_ALL);
> +    if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
> +        error_setg_errno(errp, errno,
> +                         "failed to bind AF_PACKET socket for ifname '%s=
'",
> +                         ifname);
> +        close(fd);
> +        return false;
> +    }
> +
> +    if (s->in_netdev) {
> +        s->in_netfd =3D fd;
> +        g_free(s->in_netbuf);
> +        s->in_netbuf =3D g_malloc(REDIRECTOR_MAX_LEN);
> +    } else {
> +        s->out_netfd =3D fd;
> +        s->out_net =3D nc;
> +    }
> +    return true;
> +}
> +

Thanks


