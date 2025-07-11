Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87326C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaANW-0001Cn-2f; Fri, 11 Jul 2025 05:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uaANO-000108-Be
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:49:07 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uaANL-0002EO-LM
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ijPAPIM2gIFHFk5bLotXLqQHogL/Kae92CWqiaQtpm0=; b=hB4aXyEJI3zRq8NcvnzZ2OqLyb
 4r9aYsuR62O51rhQyPYaV7VPg5DROGExLRC6LP8kG3h7OHdxGO9c5s4eNnWyz5IoTtD0qRrbQGct2
 rUNwa/+xxudNG2WFlWEP97S3njJITcejSjdVZg0/sYBut09VowegOp3BHyHxplvwdknFiQEqOASAJ
 ZPTLZuwqKVe/nu3xlsSi3sIgP8jvIXzTiNULZzneh9AQcktT4eDDlQnlk6tB1A8NgYPUq65Ywt5xN
 xCIm5/F4JSc0EAAShHW1vk/xv0OEeGky8vCasgeDhSEvdiIsZlD5kQLwA225jb4iUikvBKajweSa5
 6xkVvEVg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uaANJ-0003NT-0O; Fri, 11 Jul 2025 11:49:01 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <daniel@iogearbox.net>)
 id 1uaANI-000Og1-1s; Fri, 11 Jul 2025 11:49:00 +0200
Message-ID: <773e70cc-a55d-4878-9fe3-3078f7185b0d@iogearbox.net>
Date: Fri, 11 Jul 2025 11:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] net/af-xdp: Support pinned map path for AF_XDP
 sockets
To: Ilya Maximets <i.maximets@ovn.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
References: <20250704130531.144325-1-daniel@iogearbox.net>
 <20250704130531.144325-3-daniel@iogearbox.net>
 <bd4b60f5-8bf1-4f03-9b9f-9e034bc60574@ovn.org>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <bd4b60f5-8bf1-4f03-9b9f-9e034bc60574@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27695/Thu Jul 10 11:08:41 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Daniel Borkmann <daniel@iogearbox.net>
From:  Daniel Borkmann via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hey Ilya,

On 7/9/25 2:29 PM, Ilya Maximets wrote:
[...]
> Thnaks, Daniel!  I have just a couple of small nits below that I missed in v3,
> the rest looks good and is working fine.
> 
>>
>> diff --git a/net/af-xdp.c b/net/af-xdp.c
>> index 29c5ad16cd..005117c336 100644
>> --- a/net/af-xdp.c
>> +++ b/net/af-xdp.c
>> @@ -51,6 +51,10 @@ typedef struct AFXDPState {
>>   
>>       uint32_t             xdp_flags;
>>       bool                 inhibit;
>> +
>> +    char                 *map_path;
>> +    int                  map_fd;
>> +    uint32_t             map_start_index;
>>   } AFXDPState;
>>   
>>   #define AF_XDP_BATCH_SIZE 64
>> @@ -260,6 +264,7 @@ static void af_xdp_send(void *opaque)
>>   static void af_xdp_cleanup(NetClientState *nc)
>>   {
>>       AFXDPState *s = DO_UPCAST(AFXDPState, nc, nc);
>> +    int idx;
>>   
>>       qemu_purge_queued_packets(nc);
>>   
>> @@ -273,6 +278,18 @@ static void af_xdp_cleanup(NetClientState *nc)
>>       s->umem = NULL;
>>       qemu_vfree(s->buffer);
>>       s->buffer = NULL;
>> +
>> +    if (s->map_fd >= 0) {
>> +        idx = nc->queue_index + s->map_start_index;
>> +        if (bpf_map_delete_elem(s->map_fd, &idx)) {
>> +            fprintf(stderr, "af-xdp: unable to remove AF_XDP socket from "
>> +                    "map %s\n", s->map_path);
> 
> nit :I'd suggest to keep the "map" on a previous line.  We have some space for it.

fixed.

>> +        }
>> +        close(s->map_fd);
>> +        s->map_fd = -1;
>> +    }
>> +    g_free(s->map_path);
>> +    s->map_path = NULL;
>>   }
>>   
>>   static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
>> @@ -336,7 +353,6 @@ static int af_xdp_socket_create(AFXDPState *s,
>>       };
>>       int queue_id, error = 0;
>>   
>> -    s->inhibit = opts->has_inhibit && opts->inhibit;
>>       if (s->inhibit) {
>>           cfg.libxdp_flags |= XSK_LIBXDP_FLAGS__INHIBIT_PROG_LOAD;
>>       }
>> @@ -387,6 +403,35 @@ static int af_xdp_socket_create(AFXDPState *s,
>>       return 0;
>>   }
>>   
>> +static int af_xdp_update_xsk_map(AFXDPState *s, Error **errp)
>> +{
>> +    int xsk_fd, idx, error = 0;
>> +
>> +    if (!s->map_path) {
>> +        return 0;
>> +    }
>> +
>> +    s->map_fd = bpf_obj_get(s->map_path);
>> +    if (s->map_fd < 0) {
>> +        error = errno;
>> +    } else {
>> +        xsk_fd = xsk_socket__fd(s->xsk);
>> +        idx = s->nc.queue_index + s->map_start_index;
>> +        if (bpf_map_update_elem(s->map_fd, &idx, &xsk_fd, 0)) {
>> +            error = errno;
>> +        }
>> +    }
>> +
>> +    if (error) {
>> +        error_setg_errno(errp, error,
>> +                         "failed to insert AF_XDP socket into map %s",
>> +                         s->map_path);
>> +        return -1;
> 
> nit: Maybe remove this line and return 'error' below?

I left this as-is given the rest of the code has similar style as here
and always returns -1 on errors. error would be positive here and we'd
have to return -error, but still it seems somewhat out of place imho.

>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /* NetClientInfo methods. */
>>   static NetClientInfo net_af_xdp_info = {
>>       .type = NET_CLIENT_DRIVER_AF_XDP,
>> @@ -441,6 +486,7 @@ int net_init_af_xdp(const Netdev *netdev,
>>       int64_t i, queues;
>>       Error *err = NULL;
>>       AFXDPState *s;
>> +    bool inhibit;
>>   
>>       ifindex = if_nametoindex(opts->ifname);
>>       if (!ifindex) {
>> @@ -456,8 +502,21 @@ int net_init_af_xdp(const Netdev *netdev,
>>           return -1;
>>       }
>>   
>> -    if ((opts->has_inhibit && opts->inhibit) != !!opts->sock_fds) {
>> -        error_setg(errp, "'inhibit=on' requires 'sock-fds' and vice versa");
>> +    inhibit = opts->has_inhibit && opts->inhibit;
>> +    if (inhibit && !opts->sock_fds && !opts->map_path) {
>> +        error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
>> +        return -1;
>> +    }
>> +    if (!inhibit && (opts->sock_fds || opts->map_path)) {
>> +        error_setg(errp, "'sock-fds' and 'map-path' require 'inhibit=on'");
>> +        return -1;
>> +    }
>> +    if (opts->sock_fds && opts->map_path) {
>> +        error_setg(errp, "'sock-fds' and 'map-path' are mutually exclusive");
>> +        return -1;
>> +    }
>> +    if (!opts->map_path && opts->has_map_start_index) {
>> +        error_setg(errp, "'map-start-index' requires 'map-path'");
>>           return -1;
>>       }
>>   
>> @@ -481,14 +540,23 @@ int net_init_af_xdp(const Netdev *netdev,
>>   
>>           pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
>>           s->ifindex = ifindex;
>> +        s->inhibit = inhibit;
>> +
>> +        s->map_path = g_strdup(opts->map_path);
>> +        s->map_fd = -1;
>> +        s->map_start_index = 0;
>> +        if (opts->has_map_start_index && opts->map_start_index > 0) {
> 
> We should error out if the user specified a negative value.  I'd suggest
> to add the check to the list of user-input validation above instead of
> silently ignoring the incorrect value.  And then we could skip the value
> check here.

fixed.

>> +            s->map_start_index = opts->map_start_index;
>> +        }
>>   
>>           if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
>> -            af_xdp_socket_create(s, opts, &err)) {
>> +            af_xdp_socket_create(s, opts, &err) ||
>> +            af_xdp_update_xsk_map(s, &err)) {
>>               goto err;
>>           }
>>       }
>>   
>> -    if (nc0) {
>> +    if (nc0 && !inhibit) {
>>           s = DO_UPCAST(AFXDPState, nc, nc0);
>>           if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
>>               error_setg_errno(errp, errno,
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 97ea183981..3d80a9cacd 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -454,25 +454,34 @@
>>   #     (default: 0).
>>   #
>>   # @inhibit: Don't load a default XDP program, use one already loaded
>> -#     to the interface (default: false).  Requires @sock-fds.
>> +#     to the interface (default: false).  Requires @sock-fds or @map-path.
>>   #
>>   # @sock-fds: A colon (:) separated list of file descriptors for
>>   #     already open but not bound AF_XDP sockets in the queue order.
>>   #     One fd per queue.  These descriptors should already be added
>> -#     into XDP socket map for corresponding queues.  Requires
>> -#     @inhibit.
>> +#     into XDP socket map for corresponding queues.  @sock-fds and
>> +#     @map-path are mutually exclusive.  Requires @inhibit.
>> +#
>> +# @map-path: The path to a pinned xsk map to push file descriptors
>> +#     for bound AF_XDP sockets into.  @map-path and @sock-fds are
>> +#     mutually exclusive.  Requires @inhibit.  (Since 10.1)
>> +#
>> +# @map-start-index: Use @map-path to insert xsk sockets starting from
>> +#     this index number (default: 0).  Requires @map-path.  (Since 10.1)
>>   #
>>   # Since: 8.2
>>   ##
>>   { 'struct': 'NetdevAFXDPOptions',
>>     'data': {
>> -    'ifname':       'str',
>> -    '*mode':        'AFXDPMode',
>> -    '*force-copy':  'bool',
>> -    '*queues':      'int',
>> -    '*start-queue': 'int',
>> -    '*inhibit':     'bool',
>> -    '*sock-fds':    'str' },
>> +    'ifname':           'str',
>> +    '*mode':            'AFXDPMode',
>> +    '*force-copy':      'bool',
>> +    '*queues':          'int',
>> +    '*start-queue':     'int',
>> +    '*inhibit':         'bool',
>> +    '*sock-fds':        'str',
>> +    '*map-path':        'str',
>> +    '*map-start-index': 'int' },
>>     'if': 'CONFIG_AF_XDP' }
>>   
>>   ##
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 1f862b19a6..0fd4fd8d46 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2909,6 +2909,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>   #ifdef CONFIG_AF_XDP
>>       "-netdev af-xdp,id=str,ifname=name[,mode=native|skb][,force-copy=on|off]\n"
>>       "         [,queues=n][,start-queue=m][,inhibit=on|off][,sock-fds=x:y:...:z]\n"
>> +    "         [,map-path=/path/to/socket/map][,map-start-index=i]\n"
>>       "                attach to the existing network interface 'name' with AF_XDP socket\n"
>>       "                use 'mode=MODE' to specify an XDP program attach mode\n"
>>       "                use 'force-copy=on|off' to force XDP copy mode even if device supports zero-copy (default: off)\n"
>> @@ -2916,6 +2917,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>       "                with inhibit=on,\n"
>>       "                  use 'sock-fds' to provide file descriptors for already open AF_XDP sockets\n"
>>       "                  added to a socket map in XDP program.  One socket per queue.\n"
>> +    "                  use 'map-path' to provide the socket map location to populate AF_XDP sockets with\n"
> 
> nit: it feels like we need some punctuation sign after the 'with', otherwise
> it reads as "populate AF_XDP sockets with beginning from the", which makes no
> sense.

ok, reworded slightly.

Thanks,
Daniel

