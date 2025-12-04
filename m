Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A67D2444E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 17:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDPW-0005i4-NP; Thu, 04 Dec 2025 12:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vRDPT-0005hf-B1
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:46:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vRDPR-0000ic-2f
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764870386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wDXGgAxw4PIi13v7pCmu9hsZiI+cOiBER9HkmXCij5M=;
 b=Nxaq8DPJLuCLjDcHz5f3pgEYkdUmOSjfKFDBqAsYQvyV1ssTKQG52mz+95ypMSE7AxFerA
 fDVlgTI8NCg8TyVqTtzuQZUkEwC1QOOJdcLfdPF/z7SkQ6pIxL6v6csfAB8sqnd5AjYO8z
 v+8B4JPirr1tpyfwe2Vs73Mj7gZyPp0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-rQTwaLu0OPCRK1K1cQrBkQ-1; Thu, 04 Dec 2025 12:46:24 -0500
X-MC-Unique: rQTwaLu0OPCRK1K1cQrBkQ-1
X-Mimecast-MFC-AGG-ID: rQTwaLu0OPCRK1K1cQrBkQ_1764870383
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso7510845e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 09:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764870383; x=1765475183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wDXGgAxw4PIi13v7pCmu9hsZiI+cOiBER9HkmXCij5M=;
 b=Zd6TcoGb0WTFMIpF3xWTl+rNJW4mengTTWmpvtoLJ6eOsLIPj0vOwqjgQGUTCrjfSZ
 o/78BchQVPspN0/VcubcejY7X7oxQn+8SmXpg8XvWkXhW63ndhWzHMHaVb0DcFN7XiTB
 fsyORomEiyoNBYffNXjgQChqPJOyXmQbz/kTJGMqsde1Yb47rl2/FsqLatC8OaK5H9gq
 spcuETqH8S9eBE37hz+48XrbSH4XQH6/5oKZ1fq4qDvaAYg7jpmQkC5enyRY3ZgxhFxK
 db6D6wt+xP3UVmu7XKUobAlghHy/ufWvpBDnVwfHR33FjFZaLuejP7CBq7T1CNLXFdPW
 CKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764870383; x=1765475183;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDXGgAxw4PIi13v7pCmu9hsZiI+cOiBER9HkmXCij5M=;
 b=t7DR04wYuw+wP1bUeQY/eQdbyMNZBNybGVPZtxf05jM4s0FkG4jsrID6ZBKEFtqB5M
 CPb02YRkNuFl6BfDYUbnIR/r5j6v4SqZLb4YzrRA+aYAgUei13hmrh7CJMUbRcrjeNWp
 43e+D4yntaSPdK5XibHWQpKQgFwMQo6EFxLTL0t3Kye2pew+JVlDMxALHRfLXnVf5GuZ
 sgavwJcr1njdwpUo8dfDDnXbxAOl0RSdp9PRPc1D1BjORu9D/t9zKt5lpR5Oum47573Z
 WLkz6maZjqQSteO1MoatieVDsVFYxkVbIwcraYRUkEVyQWuEGNFECem6Ahg14fpO2J6c
 OJSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO4VkVfLyMTMk9It3BmddS/p6DzWuDASdp2DfnqyfRDxMC1U5BGxkQx1X6U7lyseXdEJMhMvA5RUtm@nongnu.org
X-Gm-Message-State: AOJu0YzCY2l3labT8KGuJKYDoktc1nbgaEaqvvNmPfwTTPLFOh/vVRPE
 VMYWAtfm5xY9yySZfWLK/IkUH0EAKcRCzYsvfdK9dMEPsJoGsWMlrVNzXVsU+P4bzQyM+YKovbW
 tf/wzrjXq9+mVU+taKcjXXlpMUaWdqkkl+LoELctrKlFF2Vi8YCntfKpt
X-Gm-Gg: ASbGncuggS+uiTTYG2K6PcLv65UncuL6iRUUDtztJDn7diulkMp2izxmiru4yorZ/g0
 bLhtsENW+O9xupfsQOi5uoNYG9HcqrJuHgJ60quWS2X+SaHLg9snTG/EEjegylPDSRUCl+Uy2tF
 VMP25fyE0Vh0FvQysTVUzlDBT8PvYpLHP12XdndrI67qNlCs10rFKWCmKT5ZpsJ5q0gxwiwwEZ/
 BMr28l+I+ffLH/JJT3Lh3nixzYlyXNOIruvQcLtHs7D0yOWtS0PqYY8y1rTpj+LD5RVzOlli+7n
 PJMm7hRqx8xUndohDUO4St2dnsvTzAEV9N3pdrzXuHCZrsdA+4sMjHfTh1FU/z0LVXWR7088MM8
 PiBIpnRY9lclCZda9NfciiKisgmfEQYslpO8VjjfE7TzwYNAh
X-Received: by 2002:a05:600c:4f54:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-4792af34a2emr75311375e9.24.1764870383101; 
 Thu, 04 Dec 2025 09:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ9sW64pJjwFoPdGxY/BmTPZvjj/fYtq0IvDs802Gu03Y+pzzu2jSW+pAROvroU1bhWZchCg==
X-Received: by 2002:a05:600c:4f54:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-4792af34a2emr75310915e9.24.1764870382485; 
 Thu, 04 Dec 2025 09:46:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b0d5e55sm65679855e9.2.2025.12.04.09.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 09:46:21 -0800 (PST)
Message-ID: <fbc8007b-2667-42c6-9fdf-56147cae664d@redhat.com>
Date: Thu, 4 Dec 2025 18:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] tap: cpr support
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/3/25 19:51, Ben Chaney wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Provide the cpr=on option to preserve TAP and vhost descriptors during
> cpr-transfer, so the management layer does not need to create a new
> device for the target.
> 
> Save all tap fd's in canonical order, leveraging the index argument of
> cpr_save_fd.  For the i'th queue, the tap device fd is saved at index 2*i,
> and the vhostfd (if any) at index 2*i+1.
> 
> tap and vhost fd's are passed by name to the monitor when a NIC is hot
> plugged, but the name is not known to qemu after cpr.  Allow the manager
> to pass -1 for the fd "name" in the new qemu args to indicate that QEMU
> should search for a saved value.  Example:
> 
>    -netdev tap,id=hostnet2,fds=-1:-1,vhostfds=-1:-1,cpr=on
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
>   hw/vfio/device.c        |  2 +-
>   include/migration/cpr.h |  2 +-
>   migration/cpr.c         | 11 ++++----
>   net/tap.c               | 73 +++++++++++++++++++++++++++++++++++++++----------
>   qapi/net.json           |  5 +++-
>   5 files changed, 70 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 76869828fc..73e622f7b5 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -362,7 +362,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
>   
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>   {
> -    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
> +    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0, true, errp);


This looks weird to me.

This calls a cpr* routine with a 'cpr' bool argument that toggles
CPR on or off. It looks a bit hacky. Could you clarify the intention?


C.

>   }
>   
>   static VFIODeviceIOOps vfio_device_io_ops_ioctl;
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index d585fadc5b..68424b4b03 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -48,7 +48,7 @@ void cpr_state_close(void);
>   struct QIOChannel *cpr_state_ioc(void);
>   
>   bool cpr_incoming_needed(void *opaque);
> -int cpr_get_fd_param(const char *name, const char *fdname, int index,
> +int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
>                        Error **errp);
>   
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> diff --git a/migration/cpr.c b/migration/cpr.c
> index c0bf93a7ba..19bd56339d 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -316,6 +316,7 @@ bool cpr_incoming_needed(void *opaque)
>    * @name: CPR name for the descriptor
>    * @fdname: An integer-valued string, or a name passed to a getfd command
>    * @index: CPR index of the descriptor
> + * @cpr: use cpr
>    * @errp: returned error message
>    *
>    * If CPR is not being performed, then use @fdname to find the fd.
> @@ -325,22 +326,22 @@ bool cpr_incoming_needed(void *opaque)
>    * On success returns the fd value, else returns -1.
>    */
>   int cpr_get_fd_param(const char *name, const char *fdname, int index,
> -                     Error **errp)
> +                     bool cpr, Error **errp)
>   {
>       ERRP_GUARD();
>       int fd;
>   
> -    if (cpr_is_incoming()) {
> +    if (cpr && cpr_is_incoming()) {
>           fd = cpr_find_fd(name, index);
>           if (fd < 0) {
>               error_setg(errp, "cannot find saved value for fd %s", fdname);
>           }
>       } else {
>           fd = monitor_fd_param(monitor_cur(), fdname, errp);
> -        if (fd >= 0) {
> -            cpr_save_fd(name, index, fd);
> -        } else {
> +        if (fd < 0) {
>               error_prepend(errp, "Could not parse object fd %s:", fdname);
> +        } else if (cpr) {
> +            cpr_save_fd(name, index, fd);
>           }
>       }
>       return fd;
> diff --git a/net/tap.c b/net/tap.c
> index 9d480574c3..79e29addd1 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -35,6 +35,7 @@
>   #include "net/eth.h"
>   #include "net/net.h"
>   #include "clients.h"
> +#include "migration/cpr.h"
>   #include "monitor/monitor.h"
>   #include "system/system.h"
>   #include "qapi/error.h"
> @@ -80,6 +81,7 @@ typedef struct TAPState {
>       bool has_uso;
>       bool has_tunnel;
>       bool enabled;
> +    bool cpr;
>       VHostNetState *vhost_net;
>       unsigned host_vnet_hdr_len;
>       Notifier exit;
> @@ -323,6 +325,9 @@ static void tap_cleanup(NetClientState *nc)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
>   
> +    if (s->cpr) {
> +        cpr_delete_fd_all(nc->name);
> +    }
>       if (s->vhost_net) {
>           vhost_net_cleanup(s->vhost_net);
>           g_free(s->vhost_net);
> @@ -690,18 +695,24 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
>       return fd;
>   }
>   
> +/* CPR fd's for each queue are saved at these indices */
> +#define TAP_FD_INDEX(queue)         (2 * (queue) + 0)
> +#define TAP_VHOSTFD_INDEX(queue)    (2 * (queue) + 1)
> +
>   #define MAX_TAP_QUEUES 1024
>   
>   static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>                                const char *model, const char *name,
>                                const char *ifname, const char *script,
>                                const char *downscript, const char *vhostfdname,
> -                             int vnet_hdr, int fd, Error **errp)
> +                             int vnet_hdr, int fd, int index, Error **errp)
>   {
>       Error *err = NULL;
>       TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
> +    bool cpr = tap->has_cpr ? tap->cpr : false;
>       int vhostfd;
>   
> +    s->cpr = cpr;
>       tap_set_sndbuf(s->fd, tap, &err);
>       if (err) {
>           error_propagate(errp, err);
> @@ -736,7 +747,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>           }
>   
>           if (vhostfdname) {
> -            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
> +            vhostfd = cpr_get_fd_param(name, vhostfdname, index, cpr, &err);
>               if (vhostfd == -1) {
>                   error_propagate(errp, err);
>                   goto failed;
> @@ -745,13 +756,22 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>                   goto failed;
>               }
>           } else {
> -            vhostfd = open("/dev/vhost-net", O_RDWR);
> +            vhostfd = cpr ? cpr_find_fd(name, index) : -1;
> +            if (vhostfd < 0) {
> +                vhostfd = open("/dev/vhost-net", O_RDWR);
> +                if (cpr && vhostfd >= 0) {
> +                    cpr_save_fd(name, index, vhostfd);
> +                }
> +            }
>               if (vhostfd < 0) {
>                   error_setg_errno(errp, errno,
>                                    "tap: open vhost char device failed");
>                   goto failed;
>               }
>               if (!qemu_set_blocking(vhostfd, false, errp)) {
> +                if (!cpr) {
> +                    close(vhostfd);
> +                }
>                   goto failed;
>               }
>           }
> @@ -777,6 +797,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>       return;
>   
>   failed:
> +    if (cpr) {
> +        cpr_delete_fd_all(name);
> +    }
>       qemu_del_net_client(&s->nc);
>   }
>   
> @@ -809,7 +832,8 @@ static int get_fds(char *str, char *fds[], int max)
>   int net_init_tap(const Netdev *netdev, const char *name,
>                    NetClientState *peer, Error **errp)
>   {
> -    const NetdevTapOptions *tap;
> +    const NetdevTapOptions *tap = &netdev->u.tap;
> +    bool cpr = tap->has_cpr ? tap->cpr : false;
>       int fd, vnet_hdr = 0, i = 0, queues;
>       /* for the no-fd, no-helper case */
>       const char *script;
> @@ -845,7 +869,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>               goto out;
>           }
>   
> -        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
> +        fd = cpr_get_fd_param(name, tap->fd, TAP_FD_INDEX(0), cpr, errp);
>           if (fd == -1) {
>               ret = -1;
>               goto out;
> @@ -866,13 +890,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
>   
>           net_init_tap_one(tap, peer, "tap", name, NULL,
>                            script, downscript,
> -                         vhostfdname, vnet_hdr, fd, &err);
> +                         vhostfdname, vnet_hdr, fd, TAP_VHOSTFD_INDEX(0), &err);
>           if (err) {
>               error_propagate(errp, err);
>               close(fd);
>               ret = -1;
>               goto out;
>           }
> +
>       } else if (tap->fds) {
>           char **fds;
>           char **vhost_fds;
> @@ -903,7 +928,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>           }
>   
>           for (i = 0; i < nfds; i++) {
> -            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
> +            fd = cpr_get_fd_param(name, fds[i], TAP_FD_INDEX(i), cpr, errp);
>               if (fd == -1) {
>                   ret = -1;
>                   goto free_fail;
> @@ -930,7 +955,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>               net_init_tap_one(tap, peer, "tap", name, ifname,
>                                script, downscript,
>                                tap->vhostfds ? vhost_fds[i] : NULL,
> -                             vnet_hdr, fd, &err);
> +                             vnet_hdr, fd, TAP_VHOSTFD_INDEX(i), &err);
>               if (err) {
>                   error_propagate(errp, err);
>                   ret = -1;
> @@ -958,9 +983,15 @@ free_fail:
>               goto out;
>           }
>   
> -        fd = net_bridge_run_helper(tap->helper,
> -                                   tap->br ?: DEFAULT_BRIDGE_INTERFACE,
> -                                   errp);
> +        fd = cpr ? cpr_find_fd(name, TAP_FD_INDEX(0)) : -1;
> +        if (fd < 0) {
> +            fd = net_bridge_run_helper(tap->helper,
> +                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
> +                                    errp);
> +            if (cpr && fd >= 0) {
> +                cpr_save_fd(name, TAP_FD_INDEX(0), fd);
> +            }
> +        }
>           if (fd == -1) {
>               ret = -1;
>               goto out;
> @@ -980,13 +1011,14 @@ free_fail:
>   
>           net_init_tap_one(tap, peer, "bridge", name, ifname,
>                            script, downscript, vhostfdname,
> -                         vnet_hdr, fd, &err);
> +                         vnet_hdr, fd, TAP_VHOSTFD_INDEX(0), &err);
>           if (err) {
>               error_propagate(errp, err);
>               close(fd);
>               ret = -1;
>               goto out;
>           }
> +
>       } else {
>           g_autofree char *default_script = NULL;
>           g_autofree char *default_downscript = NULL;
> @@ -1011,8 +1043,14 @@ free_fail:
>           }
>   
>           for (i = 0; i < queues; i++) {
> -            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
> -                              ifname, sizeof ifname, queues > 1, errp);
> +            fd = cpr ? cpr_find_fd(name, TAP_FD_INDEX(i)) : -1;
> +            if (fd < 0) {
> +                fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
> +                                ifname, sizeof ifname, queues > 1, errp);
> +                if (cpr && fd >= 0) {
> +                    cpr_save_fd(name, TAP_FD_INDEX(i), fd);
> +                }
> +            }
>               if (fd == -1) {
>                   ret = -1;
>                   goto out;
> @@ -1030,7 +1068,9 @@ free_fail:
>               net_init_tap_one(tap, peer, "tap", name, ifname,
>                                i >= 1 ? "no" : script,
>                                i >= 1 ? "no" : downscript,
> -                             vhostfdname, vnet_hdr, fd, &err);
> +                             vhostfdname, vnet_hdr,
> +                             fd, TAP_VHOSTFD_INDEX(i),
> +                             &err);
>               if (err) {
>                   error_propagate(errp, err);
>                   close(fd);
> @@ -1041,6 +1081,9 @@ free_fail:
>       }
>   
>   out:
> +    if (ret && cpr) {
> +        cpr_delete_fd_all(name);
> +    }
>       return ret;
>   }
>   
> diff --git a/qapi/net.json b/qapi/net.json
> index 118bd34965..264213b5d9 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -355,6 +355,8 @@
>   # @poll-us: maximum number of microseconds that could be spent on busy
>   #     polling for tap (since 2.7)
>   #
> +# @cpr: preserve fds and vhostfds during cpr-transfer.
> +#
>   # Since: 1.2
>   ##
>   { 'struct': 'NetdevTapOptions',
> @@ -373,7 +375,8 @@
>       '*vhostfds':   'str',
>       '*vhostforce': 'bool',
>       '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*cpr':        'bool'} }
>   
>   ##
>   # @NetdevSocketOptions:
> 


