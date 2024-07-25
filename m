Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD108C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvT0-0002nF-6V; Thu, 25 Jul 2024 06:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvSz-0002mj-8n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:12:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvSx-0006Vc-9r
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:12:57 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso895003a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721902372; x=1722507172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h1pOl57HbT3vKqDp0OBpwXp6YEwuU5kOJnAJt2bPTSA=;
 b=ReFc3HdMnXUetoPrJa1/f8pTkyE9obYzkrp+QE/O4yWhedYTlGL9BkV4rh0hv8MsK9
 DRFhrd3HbLvsM3fUkkJU0CyYMUGfTIXpAB81NpD99NWlLQW4bznBid5dAVfSBTEywKqt
 gZtyKLixYQTEHwnFyHszGCXceDDFi4wrKMoC8Kp7GJYSzn1tcSLI81L7jtlmBHQSS99A
 nVtISg55LonrcKDCGYAyqs4yBqGpiPhZ3U7FMA0xqmphp7/jcNlAABsxDsmrX7vwPj5b
 uh070TyFAsg4RlKRRZPPLlyZNesGzLlq3Nd3qSuJ9FXpM6kWgABgmtPLpCLOSyLGQAEI
 FOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902372; x=1722507172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1pOl57HbT3vKqDp0OBpwXp6YEwuU5kOJnAJt2bPTSA=;
 b=s8k639x7m4qLqVMF5W3ZEjtMTUvMYkU62nU2obvIyXP/RO67GDJaDgG7bQ9woisG5t
 35yqQmxG7cFCLfcrPxbTbgoGcaZwO1Dgg9tJkAkZgxgK176X+1jeW4DymiS4Sr/Dt6WC
 YmQF31vLRgxUpp++o5+gCwS5H1CjDTF7f5RQu1/IAN7TwBPUV/VXVAxohHjb9RoL5Xp5
 96Xu2Qj+5TR76tnqxVdx9TKgRzWFegJgM1vTxZ+7HW3sWze6URk/b4WnpCGCJyfr0wHD
 XHN2rJI5MB+eyq6rcRpgIdAzn/TQ38ElAyinakDDyXuI2YlsksGKoXrvMRJLMUvGLhnh
 1kIg==
X-Gm-Message-State: AOJu0Yxfio/0p0TmGGCU5NycRnbl+7/3KWUw0pxHv1KzMABm1QDBNWdM
 3O9vm8wQO7tJRKFkNQzoBK325SBX8yeieOzzduM+yXq3/jg6yNfR8xJ0w3wQpU1uJebF5bTQDtR
 qkEIY/Oi94Rzf36cUFHHIAEYKhDkTMOjNewFCeQ==
X-Google-Smtp-Source: AGHT+IEUTyquXoNsXHmMw9Lu3MzKiNpXyI8Y3IvHCi4PuOIZ7+FaB8RqpAZ1Wo0JgN2trleNkpdKApEHHziN9dNnxAs=
X-Received: by 2002:a05:6402:3592:b0:58e:4088:ed2 with SMTP id
 4fb4d7f45d1cf-5ac2a7b73a1mr1600840a12.16.1721902372520; Thu, 25 Jul 2024
 03:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240723070251.25575-1-kkostiuk@redhat.com>
 <20240723070251.25575-26-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-26-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 11:12:41 +0100
Message-ID: <CAFEAcA831S0wGbyLwDK7yVeEoi1SFPD7gpYribNqP6AmyQHN5A@mail.gmail.com>
Subject: Re: [PULL v2 25/25] qga/linux: Add new api 'guest-network-get-route'
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 23 Jul 2024 at 08:03, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> From: Dehan Meng <demeng@redhat.com>
>
> The Route information of the Linux VM needs to be used
> by administrators and users when debugging network problems
> and troubleshooting.
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Message-ID: <20240613092802.346246-2-demeng@redhat.com>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>

Hi; Coverity points out some potential issues with this commit:

> +static char *hexToIPAddress(const void *hexValue, int is_ipv6)
> +{
> +    if (is_ipv6) {
> +        char addr[INET6_ADDRSTRLEN];
> +        struct in6_addr in6;
> +        const char *hexStr = (const char *)hexValue;
> +        int i;
> +
> +        for (i = 0; i < 16; i++) {
> +            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);

We don't check the sscanf() return value here. (CID 1558558)

> +        }
> +        inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
> +
> +        return g_strdup(addr);
> +    } else {
> +        unsigned int hexInt = *(unsigned int *)hexValue;
> +        unsigned int byte1 = (hexInt >> 24) & 0xFF;
> +        unsigned int byte2 = (hexInt >> 16) & 0xFF;
> +        unsigned int byte3 = (hexInt >> 8) & 0xFF;
> +        unsigned int byte4 = hexInt & 0xFF;
> +
> +        return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
> +    }
> +}
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    GuestNetworkRouteList *head = NULL, **tail = &head;
> +    const char *routeFiles[] = {"/proc/net/route", "/proc/net/ipv6_route"};
> +    FILE *fp;
> +    size_t n;
> +    char *line = NULL;
> +    int firstLine;
> +    int is_ipv6;
> +    int i;

The handling of the getline() buffer in this function doesn't
seem to be correct (CID 1558559).

Firstly, the manpage says that to get the initial "allocate me
a buffer", line must be NULL and also n must be 0, but we don't
initialize n here.

> +    for (i = 0; i < 2; i++) {
> +        firstLine = 1;
> +        is_ipv6 = (i == 1);
> +        fp = fopen(routeFiles[i], "r");
> +        if (fp == NULL) {
> +            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
> +            free(line);

Here we free() line, but we continue the for() loop. So next
time around the loop (assuming the second fopen succeeds)
we'll pass line to getline() and it will be a non-NULL
pointer to freed memory.

Is this error case supposed to exit the for() loop entirely
instead of continuing?

Either way, it shouldn't free(line) here I think.

> +            continue;
> +        }
> +
> +        while (getline(&line, &n, fp) != -1) {
> +            if (firstLine && !is_ipv6) {
> +                firstLine = 0;
> +                continue;
> +            }
> +            GuestNetworkRoute *route = NULL;
> +            GuestNetworkRoute *networkroute;
> +            char Iface[IFNAMSIZ];

Our coding style says you shouldn't declare variables in the
middle of a block. Coding style also says variable names are
lowercase with underscores, not CamelCase. (CamelCase is for
typenames.)

> +            if (is_ipv6) {
> +                char Destination[33], Source[33], NextHop[33];
> +                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
> +
> +                /* Parse the line and extract the values */
> +                if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %s",
> +                           Destination, &DesPrefixlen, Source,
> +                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
> +                           &Use, &Flags, Iface) != 10) {
> +                    continue;
> +                }
> +
> +                route = g_new0(GuestNetworkRoute, 1);
> +                networkroute = route;

Why do we have separate "route" and "networkroute" variables
here? As far as I can see they are identical and can be merged.

> +                networkroute->iface = g_strdup(Iface);
> +                networkroute->destination = hexToIPAddress(Destination, 1);
> +                networkroute->metric = Metric;
> +                networkroute->source = hexToIPAddress(Source, 1);
> +                networkroute->desprefixlen = g_strdup_printf(
> +                    "%d", DesPrefixlen
> +                );
> +                networkroute->srcprefixlen = g_strdup_printf(
> +                    "%d", SrcPrefixlen
> +                );
> +                networkroute->nexthop = hexToIPAddress(NextHop, 1);
> +                networkroute->has_flags = true;
> +                networkroute->flags = Flags;
> +                networkroute->has_refcnt = true;
> +                networkroute->refcnt = RefCnt;
> +                networkroute->has_use = true;
> +                networkroute->use = Use;
> +                networkroute->version = 6;
> +            } else {
> +                unsigned int Destination, Gateway, Mask, Flags;
> +                int RefCnt, Use, Metric, MTU, Window, IRTT;
> +
> +                /* Parse the line and extract the values */
> +                if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
> +                           Iface, &Destination, &Gateway, &Flags, &RefCnt,
> +                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) != 11) {
> +                    continue;
> +                }
> +
> +                route = g_new0(GuestNetworkRoute, 1);
> +                networkroute = route;
> +                networkroute->iface = g_strdup(Iface);
> +                networkroute->destination = hexToIPAddress(&Destination, 0);
> +                networkroute->gateway = hexToIPAddress(&Gateway, 0);
> +                networkroute->mask = hexToIPAddress(&Mask, 0);
> +                networkroute->metric = Metric;
> +                networkroute->has_flags = true;
> +                networkroute->flags = Flags;
> +                networkroute->has_refcnt = true;
> +                networkroute->refcnt = RefCnt;
> +                networkroute->has_use = true;
> +                networkroute->use = Use;
> +                networkroute->has_mtu = true;
> +                networkroute->mtu = MTU;
> +                networkroute->has_window = true;
> +                networkroute->window = Window;
> +                networkroute->has_irtt = true;
> +                networkroute->irtt = IRTT;
> +                networkroute->version = 4;
> +            }
> +
> +            QAPI_LIST_APPEND(tail, route);
> +        }
> +
> +        free(line);

Similarly here we free(line) but next time around the for()
loop we'll pass it to getline anyway.

> +        fclose(fp);
> +    }

Since getline() will reallocate the buffer as needed, we don't
need to free it anywhere except right before we exit the
function, here.

> +
> +    return head;
> +}

thanks
-- PMM

