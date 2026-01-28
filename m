Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575A4D35666
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 02:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkvin-0007Eg-4a; Tue, 27 Jan 2026 21:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vkviS-00070Z-0U
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 21:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vkviP-0001r7-SQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 21:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769568931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4PZuB20uRcPOjweZc8z93uq/hCXetp/k3nVjZV7kco=;
 b=HPrr6rbMIFxV3KKmRvfd9jcJjzYDkigXTSigreyfXzG1Q4rv1su6AAomGTzMGgUhvUg19V
 U4gnWmmj1Cyd8P0rAe0QKr1/Bqax+JeaSEFiBr7dsCOhnYvgNr19hxu9CfO/Dwj6MMzqe4
 4d1BgylB3LushoVGAqPwn0OzD82P3WE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-X5NdkM5rOzGhvRO4TyGl7w-1; Tue, 27 Jan 2026 21:55:29 -0500
X-MC-Unique: X5NdkM5rOzGhvRO4TyGl7w-1
X-Mimecast-MFC-AGG-ID: X5NdkM5rOzGhvRO4TyGl7w_1769568929
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c7d0c5ed2so5323896a91.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 18:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769568929; cv=none;
 d=google.com; s=arc-20240605;
 b=RoaJwj7IfzL/wSUWkPPZ8qQspobrk8IvGryPxxtS98Qe7lXlJGCLiSFN/Bm37GIKXo
 m1iMs3gEOHYeOY6e7Ik3MQGjOA3TSRqniVeI5VBVPBocWgbnNiRAJMIm/J54O6eFy2yF
 DetBofk+4L6sdDbhgGihs8Dw4jnOHfQ6FMiELMFOUVYAXCUFspJ9//G19gB+rcBiHynu
 4DROGcB7RU3m4SK4MoU3+F21SAeXeV6NjudbmjoeNOAzvZTIi3dON/fxJPAxvhcoFhJ5
 cs7pvbtP22X0ac8gDDOvuprQoWqUMvYvnVr+hHMf9yfrXvmvkRO3bOyINGXA16vMJVOC
 /MPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l4PZuB20uRcPOjweZc8z93uq/hCXetp/k3nVjZV7kco=;
 fh=Byx2AiliFS7tMt68AguwejjVsyGw7sfDoVii4PlN3UE=;
 b=BhiIovd8syyGA+yXfdhVEy2LWjHkdSsEiO4QoVOqm9lvQwOvq6y2CogBW1HSZkKF0/
 HMl7X5XTsX6JwVdSUlh/HSq6Vbh9P5cl64m1WNAIF7Yxj/+Sx2ZMGeF5UQiWN8qGuzWd
 17spggJbQ+sXSohiRu5GTMg5HzCRs9uP+D+IPMROOmvZEmX63J5JjHB57Za1Fp0SqTIM
 0C2RXCUqwhqKxBb3c8GLtBobDl+L+knzth3+GlGQkjj4L14yQwLwlmjrzvHvXRxOLzuC
 Zwif3nSjdrtts7pnUySWLB7r0VBj3T2XZd1kXgxLLSyILtxcHpUDfgukiGE1NsZy66v/
 VaPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769568929; x=1770173729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4PZuB20uRcPOjweZc8z93uq/hCXetp/k3nVjZV7kco=;
 b=kEDbn0r0xZnMzHGGNTskaMt0RbBt6pLAQD1V4VNHBmwcmhY123pXsW7jBUR2MEDOYy
 ijeGJBeeSISKxWY5zChFHtwWi6JFz7gNvC3E0nsTDohZUuTuRRyXCyWUN64MN7LNqjO5
 22TW2QnBh6AeOluO2cmXLX2P+UdXvOLLc6CWcwXVIJ3JnePUupuFROH9fZEZwp/WyWTM
 a0rm5olG0khZ/901i9+jicIW2rtbWbQcZCSkxnkwoQ7D490ts7pH8xBBmK7iDIzCOt7y
 wIpO/0zc7ZQGkKgsjc3JDLJFgebxH+orimAQNDe4ZYK7ehftLR7nkjyzgxg+trHbU8i1
 PXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769568929; x=1770173729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4PZuB20uRcPOjweZc8z93uq/hCXetp/k3nVjZV7kco=;
 b=pX6fUOLuVA3eAY5gAuDRIoR0XqwJfEiw5TIdnk4Xemz+iLGGDdT278OZlK3l/V8oqA
 D/ED7dQG6DiY9oEBpxgD2c4rNwthRad1LlrzbtT3s0xliWQmASLBAAc+wX+9CQj5TzWS
 zGIhr6rbErXYgjnq3GwYikT/AO2yuSxw2NTBAlx8fA7DefjILIOICIRuhffEvg00El0y
 nlxLpyFsxXZYzyGX9dsDm0fGR0Wnt9CZgfSIgpQCgAhk9TBaG8pOpO1AtMUIm1wVX5ke
 5KTpkAweF0DqaqipP1yMFGvd3efrwEINEOPT13GI+lyDlN7ZNDvx3xJo9vzO/cMFVgd8
 2YCA==
X-Gm-Message-State: AOJu0Ywseu346b8t5mOq/pwgCsDL1V8CCZI5pwaeyvVfflHPnekGR/5p
 Wo6WWlGBxZ2au3kYx5ruez9KF8oATvwxsPgk7kzoNCFGSS6oasU7KASQwyPTBWOcRZsO6T+DbHs
 B0OzXTYMdTKKAcG9Y171yYQnlOyCHArNVbmU8lWA45w8sBGu8HVTSAMZ6Wpnnzsu/dTDKuaJp4+
 QyZzIGGe5YztrQ//Rc+j8+dJN/do27fdU=
X-Gm-Gg: AZuq6aK8tGgu+0NtYGgMJ6gKMr5nPJ/50VOimgUdY6plntjvXVcQDJI6XVise7muNjz
 6RNbsXKzZNEGQokjYXRFLfdn+MxH1sazrwQylzNtC/LCeRzt+/ZvnrvxEvgJotPJABsLgrAvVj9
 Q1f+KwlkOWHRwnxQbI3ONVslM4fTcdTWiBuJJbJgSDuHvc2r75/REF0K/eX1PUjSJr
X-Received: by 2002:a17:90b:55c4:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-353feda7268mr3513963a91.27.1769568928684; 
 Tue, 27 Jan 2026 18:55:28 -0800 (PST)
X-Received: by 2002:a17:90b:55c4:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-353feda7268mr3513939a91.27.1769568928227; Tue, 27 Jan 2026
 18:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
In-Reply-To: <20260127140316.4187221-5-jmarcin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jan 2026 10:55:15 +0800
X-Gm-Features: AZwV_QhU-yeYpg_Cid26yYCoXktYzv8vVFSdp520UCdCoEpBP65I__NxDwGzS9Y
Message-ID: <CACGkMEtO93AjdUMD7tGzyLH2Q-PVewxMgxxTgKBpnR-bTwOd9w@mail.gmail.com>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cindy Lu <lulu@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 27, 2026 at 10:04=E2=80=AFPM Juraj Marcin <jmarcin@redhat.com> =
wrote:
>
> From: Juraj Marcin <jmarcin@redhat.com>
>
> During migration switchover both the source and the destination machines
> are paused (compute downtime). During this period network still routes
> network packets to the source machine, as this is the last place where
> the recipient MAC address has been seen. Once the destination side
> starts and sends network announcement, all subsequent frames are routed
> correctly. However, frames delivered to the source machine are never
> processed and lost. This causes also a network downtime with roughly the
> same duration as compute downtime.
>
> This can cause problems not only for protocols that cannot handle packet
> loss, but can also introduce delays in protocols that can handle them.
>
> To resolve this, this feature instantiates a network filter for each
> network backend present during migration setup on both migration sides.
> On the source side, this filter caches all packets received from the
> backend during switchover. Once the destination machine starts, all
> cached packets are sent through the migration channel and the respective
> filter object on the destination side injects them to the NIC attached
> to the backend.
>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  include/migration/vmstate.h |   6 +
>  include/net/net.h           |   5 +
>  migration/meson.build       |   1 +
>  migration/migration.c       |  49 ++++++-
>  migration/migration.h       |   2 +
>  migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++++++
>  migration/netpass.h         |  14 ++
>  migration/options.c         |  21 +++
>  migration/options.h         |   1 +
>  migration/savevm.c          |  37 ++++++
>  migration/savevm.h          |   2 +
>  migration/trace-events      |   9 ++
>  net/net.c                   |  11 ++
>  net/tap.c                   |  11 +-
>  qapi/migration.json         |   7 +-
>  15 files changed, 418 insertions(+), 4 deletions(-)
>  create mode 100644 migration/netpass.c
>  create mode 100644 migration/netpass.h
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 62d7e9fe38..7987e6c85a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -200,6 +200,12 @@ typedef enum {
>       * save_setup() in VMSD structures.
>       */
>      VMS_PHASE_EARLY_SETUP,
> +    /*
> +     * Specifies a netpass VMSD, these devices are copied right after th=
e
> +     * destination is started regardless of precopy/postcopy. Failure in=
 this
> +     * phase does not fail the migration in case of precopy.
> +     */
> +    VMS_PHASE_NETPASS,
>  } VMStateSavePhase;
>
>  struct VMStateDescription {
> diff --git a/include/net/net.h b/include/net/net.h
> index 45bc86fc86..510908845b 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -82,6 +82,7 @@ typedef void (NetAnnounce)(NetClientState *);
>  typedef bool (SetSteeringEBPF)(NetClientState *, int);
>  typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error *=
*);
>  typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
> +typedef void (NetpassEnabledNotify)(NetClientState *nc, void *opaque);
>
>  typedef struct NetClientInfo {
>      NetClientDriver type;
> @@ -130,6 +131,9 @@ struct NetClientState {
>      bool is_netdev;
>      bool do_not_pad; /* do not pad to the minimum ethernet frame length =
*/
>      bool is_datapath;
> +    bool netpass_enabled;
> +    NetpassEnabledNotify *netpass_enabled_notify;
> +    void *netpass_enabled_notify_opaque;
>      QTAILQ_HEAD(, NetFilterState) filters;
>  };
>

Adding Cindy, Eugenio can Chen.

I think we can simple reuse the existing filters:

redirector: which can redirect traffic from the source to the
destination via chardev
buffer: which can hold the packets until the destination is released

And let the libvirt install/uninstall those filters at the correct time.

Which means:

On the source: there would be a redirector that can be enabled when vm
is paused, and it redirect the traffic to a socket/chardev
On the destination: there would be a redirector as well as the buffer,
redirector receives packets from the socket and send it to buffer,
buffer will hold those packets until VM in the destination is resumed.

The current filters need some tweaks (e.g letting filters (redirector)
work when VM is paused). The advantages of this are:

1) reuse the existing filters
2) don't need to care about the vhost support on the source as vhost
is disabled, for vDPA we can reuse shadow virtqueue
3) for the destination we can install a redirector to packet socket to
let vhost works like socket -> redirector -> buffer -> redirector ->
packet socket.

Thanks


