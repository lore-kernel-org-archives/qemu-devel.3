Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5035E9E2E1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq7mc-0000FY-AJ; Wed, 11 Feb 2026 05:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq7ma-00008P-19
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq7mX-0003zw-H3
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770806956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=62OtIlocVsqhwIEET/P40WF4fUCZ4EuDM+KcdHQR1TQ=;
 b=J0ZEgLmWUGUoQdvDo5aG3WiW7NZFggezO7aISvsLjJO12VqJOoK+xLoN9cXg2HRnanXF/0
 2xsD1k5z0rAzUEpAHaYcck8ddjckkVrs2oLMv4Skz1KTY29Xq5Sz21VrFhugNwpQ84oDd0
 1hUdUtyB95c1Fgg8eUbD6NQ+xD/dPj0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-_RqQgx2SNC-NoiwqSHAKDg-1; Wed, 11 Feb 2026 05:49:15 -0500
X-MC-Unique: _RqQgx2SNC-NoiwqSHAKDg-1
X-Mimecast-MFC-AGG-ID: _RqQgx2SNC-NoiwqSHAKDg_1770806955
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c5296c7e57so2028517085a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 02:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806955; cv=none;
 d=google.com; s=arc-20240605;
 b=SDxw4rUDPcpYB6Va1JmCn9CnTkhODnZVOGXG08UvheqI3mEdD3v4wE/C82ocvFupxP
 MwuOgeH7z5bPwAfIjPjDIexf4txzY8IBmfpvilmIzcUMvhyRcsnsc7Kou6CzJnBca/84
 1D4YMzOmYOp0MX5ZflyHy7hvbTWsA89zRTgZIeKG29f2fZYInpYj8rCFstnZG1S2Tqqe
 XEN53pYtZ0GJSfjT0ZCJRtrL7339tQ/NENV1SBHcvrwwohZ0fZAsyxq4F6T6gqSxlLnS
 lSe0VWgSZh7m6OhqM62RtpDoUGiR/DHP21oI7Nwo0RZpwoZucEmhzDMaLaoYJjfGYHL5
 rYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=62OtIlocVsqhwIEET/P40WF4fUCZ4EuDM+KcdHQR1TQ=;
 fh=y2IBWUgtcUjG6NJSqP3lV5ogPzGemdHdE6RYndP4ox8=;
 b=bhMhDYGt4N99RWwEDcQz5y6UkBHAG5UEAQhZdRXFNuII8Rto5n7CPmXztrNNw9dtCY
 WqgYanMQJK3PtW9Ii1G080/c4VWTCm2aY08E6jby8Y9F7NSsnJVf1WK5XMJgqYWchejI
 DOd+quNVjBXeaTkyrsX278MbsogliuZW5frIQ3PWe46hEIYZbVcRF+iliFWyCQGqO4nJ
 /FNxFZWlbVEYKAi6RH0obdVXk3b6rtBxUk9aufbwmjeitH47dZvFFzUEfqhG377Ax4rj
 Xxv+rz1iDXYeuswQxGP1we3P/Jm2PPS6mQjYf5zy3oUmCqU4FnBjYqdu9HvHGUq05/yJ
 WlTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770806955; x=1771411755; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=62OtIlocVsqhwIEET/P40WF4fUCZ4EuDM+KcdHQR1TQ=;
 b=ftzc78MTwA3KQ0IsBwGzQIk+HbTVFH4d4z6stm0hJvc24ZgJ+dwXHj18j/CvcAARRD
 xxMxlzi9d3CTp6DwKL6ZLGvUfWimxHC11WuBR99G6CIlkddhWA5Aut8oT18T8tEIkvMe
 MbKgB916vly7o+YMOmpCFfKOnOoAm73P48EgLl/pybtgo5Z08901zqTMbzL2NNWMLZg/
 2NQogPb9kv77A9J1Ybixn5HdGHV60XCAFyybob7rbIScsN2HbqwrN3EOzLZLdRdh9Bz8
 8XEMYnPdCRTS4QHnhsp4UlUHvzjxe5sg+IM5ooA+0Zv3suizOcVV6aJoGUBrFNkjJgBq
 5Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770806955; x=1771411755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62OtIlocVsqhwIEET/P40WF4fUCZ4EuDM+KcdHQR1TQ=;
 b=tyJVwcIME68dGfsb0iQPhxE7c7Ur+BHSKUYCosmOJCoXwmJ0n6gpPVoN21NOyjqLy6
 f64C+8mfrX3X0OeAj3dIDTkjws1aND+DUQyD9ojL6+6nv0HE4yxhOBe90tYlJdro0CHz
 8l6bJ/HsdtklCn75aRHmErnnxHD/l/bnts43CVx8V5e7/+dssRemLDfCCEs5ZfYEMq9v
 caM+a+69lKOKhwKJaV/H3Q30umWt5di24cuRN6QKaz1AMaDqyOIlbgN+XZ20oabhvm2m
 pcdGpGzCksWdFtyz4Q1h288p/z8+9i6MDpTJhZnpe8BHTfYEt5Ds16nwOUbyHNo0tZU2
 6gkQ==
X-Gm-Message-State: AOJu0YyLK4/6n3D3Nm4pKvW8+u5gmqTkf8vmX9+TeZrKgD3UrDsuVuJe
 Iwx3X1wXw8SZ4Ngev8tuBPiy1g4gmOdTAUgCusaXIxH0UKujv1PiD5qejOMpHldohhLt25pd8be
 O/QPCjVWsM83W1orxHpz9W/Xp/804IBCtLTeng55wOKxuFXOmfvHr+Vm/zXR3ZNtcSrzVasDThl
 TrEzl2ps7xZ0wejjtZbtMLBwJaFLaX3+Q=
X-Gm-Gg: AZuq6aJC51VBBFTt/n9DKBvIT8Z22KLo+4HQhqWPqTDyZg7HCSVQ6Ko62Tq9iRbr5kU
 itbN7Ozwu/4Ugy334Ow6dhktETvJfWVZPzCUXH3CgOqucoXNJ3t5yz8iQ8ak2Fwtl5EA92QlzsU
 8qkhZIkpoPL1svHs0Zs2/DUdGQjOtDJ6VwDz44L0fc6D4jCjueq+rxBogoJAfpDYr6+hqaGgvMZ
 9TOSEvc
X-Received: by 2002:a05:620a:3191:b0:8c9:f8e5:9f07 with SMTP id
 af79cd13be357-8cb2804161fmr264284385a.54.1770806954664; 
 Wed, 11 Feb 2026 02:49:14 -0800 (PST)
X-Received: by 2002:a05:620a:3191:b0:8c9:f8e5:9f07 with SMTP id
 af79cd13be357-8cb2804161fmr264283285a.54.1770806954241; Wed, 11 Feb 2026
 02:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20251222144031.3115317-1-eashurov@redhat.com>
In-Reply-To: <20251222144031.3115317-1-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 11 Feb 2026 12:49:02 +0200
X-Gm-Features: AZwV_QjyGu6VitL-n8XN9cOliGxNuceyBPEe2nT_vlztAMO3jlh8jorsj7Oywzg
Message-ID: <CAPMcbCqmH0OgbG1bg4KAEP_mJbnpi0bvR-juctUQuj=GsfK4Cw@mail.gmail.com>
Subject: Re: [PATCH v3] qga: implement guest-network-get-route for Windows
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000079452a064a8a1ff2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000079452a064a8a1ff2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Dec 22, 2025 at 4:41=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat.=
com>
wrote:

> Add Windows implementation of guest-network-get-route command to provide
> network routing information on Windows guests.
>
> Features implemented:
> - IPv4 and IPv6 route information retrieval using GetIpForwardTable2
> - Human-readable interface names via GetAdaptersAddresses
> - Proper route metrics combining route and interface metrics
> - MTU information for network interfaces
> - Support for destination, gateway, mask, and metric fields for IPv4
> - Support for destination, nexthop, and desprefixlen fields for IPv6
>
> Implementation uses modern Windows IP Helper API (GetIpForwardTable2,
> GetIfEntry2).
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/commands-win32.c | 172 +++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json |  11 +--
>  2 files changed, 178 insertions(+), 5 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index acc2c11589..577e00dc65 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2592,3 +2592,175 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp=
)
>      ret->load15m =3D load_avg_15m;
>      return ret;
>  }
> +
> +/* Helper function to get interface name with fallbacks */
> +static char *get_interface_name(const MIB_IPFORWARD_ROW2 *row,
> +                                IP_ADAPTER_ADDRESSES *adptr_addrs)
> +{
> +    IP_ADAPTER_ADDRESSES *adapter;
> +    char *iface_name =3D NULL;
> +
> +    if (adptr_addrs) {
> +        for (adapter =3D adptr_addrs; adapter; adapter =3D adapter->Next=
) {
> +            if (adapter->Luid.Value =3D=3D row->InterfaceLuid.Value) {
> +                iface_name =3D guest_wctomb_dup(adapter->FriendlyName);
> +                break;
> +            }
> +        }
> +    }
> +
> +    if (!iface_name) {
> +        iface_name =3D g_strdup_printf("if%lu", row->InterfaceIndex);
> +    }
> +
> +    return iface_name;
> +}
> +
> +/* Helper function to fill IPv4 route information */
> +static void fill_ipv4_route_info(GuestNetworkRoute *route,
> +                                 const MIB_IPFORWARD_ROW2 *row)
> +{
> +    struct sockaddr_in *addr_in;
> +    char addr_str[INET_ADDRSTRLEN];
> +
> +    addr_in =3D (struct sockaddr_in *)&row->DestinationPrefix.Prefix;
> +    if (inet_ntop(AF_INET, &addr_in->sin_addr, addr_str,
> INET_ADDRSTRLEN)) {
> +        route->destination =3D g_strdup(addr_str);
> +    } else {
> +        route->destination =3D g_strdup("0.0.0.0");
> +    }
> +
> +    if (row->DestinationPrefix.PrefixLength =3D=3D 0) {
> +        route->mask =3D g_strdup("0.0.0.0");
> +    } else {
> +        uint32_t mask =3D htonl(0xFFFFFFFF << (32 -
> +                               row->DestinationPrefix.PrefixLength));
> +        struct in_addr mask_addr =3D { .s_addr =3D mask };
> +        route->mask =3D g_strdup(inet_ntoa(mask_addr));
> +    }
> +
> +    addr_in =3D (struct sockaddr_in *)&row->NextHop;
> +    if (inet_ntop(AF_INET, &addr_in->sin_addr, addr_str,
> INET_ADDRSTRLEN)) {
> +        route->gateway =3D g_strdup(addr_str);
> +    } else {
> +        route->gateway =3D g_strdup("0.0.0.0");
> +    }
> +
> +    route->version =3D 4;
> +}
> +
> +/* Helper function to fill IPv6 route information */
> +static void fill_ipv6_route_info(GuestNetworkRoute *route,
> +                                 const MIB_IPFORWARD_ROW2 *row)
> +{
> +    struct sockaddr_in6 *addr_in6;
> +    char addr_str[INET6_ADDRSTRLEN];
> +
> +    addr_in6 =3D (struct sockaddr_in6 *)&row->DestinationPrefix.Prefix;
> +    if (inet_ntop(AF_INET6, &addr_in6->sin6_addr, addr_str,
> INET6_ADDRSTRLEN)) {
> +        route->destination =3D g_strdup(addr_str);
> +    } else {
> +        route->destination =3D g_strdup("::");
> +    }
> +
> +    addr_in6 =3D (struct sockaddr_in6 *)&row->NextHop;
> +    if (inet_ntop(AF_INET6, &addr_in6->sin6_addr, addr_str,
> INET6_ADDRSTRLEN)) {
> +        route->nexthop =3D g_strdup(addr_str);
> +    } else {
> +        route->nexthop =3D g_strdup("::");
> +    }
> +
> +    route->desprefixlen =3D g_strdup_printf("%u",
> +
> row->DestinationPrefix.PrefixLength);
> +    route->version =3D 6;
> +}
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    GuestNetworkRouteList *head =3D NULL, **tail =3D &head;
> +    PMIB_IPFORWARD_TABLE2 pIpForwardTable2;
> +    DWORD dwRetVal =3D 0;
> +    DWORD i;
> +    PMIB_IPFORWARD_ROW2 row;
> +    GuestNetworkRoute *route;
> +    IP_ADAPTER_ADDRESSES *adptr_addrs;
> +    MIB_IPINTERFACE_ROW ipifrow;
> +    MIB_IF_ROW2 ifrow2;
> +    Error *local_err =3D NULL;
> +    GHashTable *interface_metric_cache;
> +
> +    dwRetVal =3D GetIpForwardTable2(AF_UNSPEC, &pIpForwardTable2);
> +    if (dwRetVal !=3D NO_ERROR) {
> +        error_setg_win32(errp, dwRetVal, "failed to get IP routes");
> +        return NULL;
> +    }
> +
> +    interface_metric_cache =3D g_hash_table_new_full(g_str_hash,
> g_str_equal,
> +                                                   g_free, NULL);
> +    adptr_addrs =3D guest_get_adapters_addresses(&local_err);
> +    if (local_err) {
> +        error_free(local_err);
> +        adptr_addrs =3D NULL;
> +    }
> +
> +    for (i =3D 0; i < pIpForwardTable2->NumEntries; i++) {
> +        row =3D &pIpForwardTable2->Table[i];
> +
> +        if (row->DestinationPrefix.Prefix.si_family =3D=3D AF_INET) {
> +            route =3D g_new0(GuestNetworkRoute, 1);
> +            fill_ipv4_route_info(route, row);
> +        } else if (row->DestinationPrefix.Prefix.si_family =3D=3D AF_INE=
T6) {
> +            route =3D g_new0(GuestNetworkRoute, 1);
> +            fill_ipv6_route_info(route, row);
> +        } else {
> +            continue;
> +        }
> +
> +        route->iface =3D get_interface_name(row, adptr_addrs);
> +
> +        /*
> +         * Get interface metric for combined route metric calculation.
> +         * Windows calculates effective route metric as route + interfac=
e
> metric.
> +         * This matches the values displayed by Windows 'route print'
> command.
> +         * See:
> +         *
> https://learn.microsoft.com/en-us/windows/win32/api/netioapi/ns-netioapi-=
mib_ipforward_row2
> +         */
> +        gchar *luid_key =3D g_strdup_printf("%" G_GUINT64_FORMAT,
> +                                          row->InterfaceLuid.Value);
> +        gpointer cached_metric =3D
> g_hash_table_lookup(interface_metric_cache,
> +                                                     luid_key);
> +
> +        if (cached_metric) {
> +            route->metric =3D (int)row->Metric +
> GPOINTER_TO_INT(cached_metric);
> +            g_free(luid_key);
> +        } else {
> +            memset(&ipifrow, 0, sizeof(ipifrow));
> +            InitializeIpInterfaceEntry(&ipifrow);
> +            ipifrow.InterfaceLuid =3D row->InterfaceLuid;
> +            ipifrow.Family =3D row->DestinationPrefix.Prefix.si_family;
> +            if (GetIpInterfaceEntry(&ipifrow) =3D=3D NO_ERROR) {
> +                g_hash_table_insert(interface_metric_cache, luid_key,
> +                                   GINT_TO_POINTER(ipifrow.Metric));
> +                route->metric =3D (int)row->Metric + (int)ipifrow.Metric=
;
> +            } else {
> +                route->metric =3D (int)row->Metric;
> +                g_free(luid_key);
> +            }
> +        }
> +
> +        memset(&ifrow2, 0, sizeof(ifrow2));
> +        ifrow2.InterfaceLuid =3D row->InterfaceLuid;
> +        if (GetIfEntry2(&ifrow2) =3D=3D NO_ERROR) {
> +            route->has_mtu =3D true;
> +            route->mtu =3D (int)ifrow2.Mtu;
> +        }
> +
> +        QAPI_LIST_APPEND(tail, route);
> +        route =3D NULL;
> +    }
> +
> +    FreeMibTable(pIpForwardTable2);
> +    g_free(adptr_addrs);
> +    g_hash_table_destroy(interface_metric_cache);
> +    return head;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 5791b49dde..89ea5485cc 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1879,7 +1879,8 @@
>  ##
>  # @GuestNetworkRoute:
>  #
> -# Route information, currently, only linux supported.
> +# Route information.  Supported on Linux (since 9.1) and Windows
> +# (since 10.3).
>  #
>  # @iface: The destination network or host's egress network interface
>  #     in the routing table
> @@ -1916,7 +1917,7 @@
>  #
>  # @version: IP version (4 or 6)
>  #
> -# Since: 9.1
> +# Since: 9.1 (Linux only); 10.3 (Windows)
>  ##
>  { 'struct': 'GuestNetworkRoute',
>    'data': {'iface': 'str',
> @@ -1936,7 +1937,7 @@
>             '*nexthop': 'str',
>             'version': 'int'
>             },
> -  'if': 'CONFIG_LINUX' }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
>
>  ##
>  # @guest-network-get-route:
> @@ -1945,9 +1946,9 @@
>  #
>  # Returns: List of route info of guest.
>  #
> -# Since: 9.1
> +# Since: 9.1 (Linux only); 10.3 (Windows)
>  ##
>  { 'command': 'guest-network-get-route',
>    'returns': ['GuestNetworkRoute'],
> -  'if': 'CONFIG_LINUX'
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>  }
> --
> 2.51.0
>
>

--00000000000079452a064a8a1ff2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Dec 22, 2025 at 4:41=E2=80=AFPM Elizabeth Ashurov &lt;<a h=
ref=3D"mailto:eashurov@redhat.com">eashurov@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Add Windows implement=
ation of guest-network-get-route command to provide<br>
network routing information on Windows guests.<br>
<br>
Features implemented:<br>
- IPv4 and IPv6 route information retrieval using GetIpForwardTable2<br>
- Human-readable interface names via GetAdaptersAddresses<br>
- Proper route metrics combining route and interface metrics<br>
- MTU information for network interfaces<br>
- Support for destination, gateway, mask, and metric fields for IPv4<br>
- Support for destination, nexthop, and desprefixlen fields for IPv6<br>
<br>
Implementation uses modern Windows IP Helper API (GetIpForwardTable2,<br>
GetIfEntry2).<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 172 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/qapi-schema.json |=C2=A0 11 +--<br>
=C2=A02 files changed, 178 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index acc2c11589..577e00dc65 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2592,3 +2592,175 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)<=
br>
=C2=A0 =C2=A0 =C2=A0ret-&gt;load15m =3D load_avg_15m;<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
+<br>
+/* Helper function to get interface name with fallbacks */<br>
+static char *get_interface_name(const MIB_IPFORWARD_ROW2 *row,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IP_ADAPTER_ADDRESSES *adptr_addrs)<b=
r>
+{<br>
+=C2=A0 =C2=A0 IP_ADAPTER_ADDRESSES *adapter;<br>
+=C2=A0 =C2=A0 char *iface_name =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (adptr_addrs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (adapter =3D adptr_addrs; adapter; adapter=
 =3D adapter-&gt;Next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter-&gt;Luid.Value =3D=
=3D row-&gt;InterfaceLuid.Value) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iface_name =3D gue=
st_wctomb_dup(adapter-&gt;FriendlyName);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!iface_name) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iface_name =3D g_strdup_printf(&quot;if%lu&quo=
t;, row-&gt;InterfaceIndex);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return iface_name;<br>
+}<br>
+<br>
+/* Helper function to fill IPv4 route information */<br>
+static void fill_ipv4_route_info(GuestNetworkRoute *route,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const MIB_IPFORWARD_ROW2 *row)=
<br>
+{<br>
+=C2=A0 =C2=A0 struct sockaddr_in *addr_in;<br>
+=C2=A0 =C2=A0 char addr_str[INET_ADDRSTRLEN];<br>
+<br>
+=C2=A0 =C2=A0 addr_in =3D (struct sockaddr_in *)&amp;row-&gt;DestinationPr=
efix.Prefix;<br>
+=C2=A0 =C2=A0 if (inet_ntop(AF_INET, &amp;addr_in-&gt;sin_addr, addr_str, =
INET_ADDRSTRLEN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;destination =3D g_strdup(addr_str);<=
br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;destination =3D g_strdup(&quot;0.0.0=
.0&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (row-&gt;DestinationPrefix.PrefixLength =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;mask =3D g_strdup(&quot;0.0.0.0&quot=
;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t mask =3D htonl(0xFFFFFFFF &lt;&lt; (3=
2 -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0row-&gt;DestinationPrefix.PrefixLengt=
h));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct in_addr mask_addr =3D { .s_addr =3D mas=
k };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;mask =3D g_strdup(inet_ntoa(mask_add=
r));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 addr_in =3D (struct sockaddr_in *)&amp;row-&gt;NextHop;<br>
+=C2=A0 =C2=A0 if (inet_ntop(AF_INET, &amp;addr_in-&gt;sin_addr, addr_str, =
INET_ADDRSTRLEN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;gateway =3D g_strdup(addr_str);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;gateway =3D g_strdup(&quot;0.0.0.0&q=
uot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 route-&gt;version =3D 4;<br>
+}<br>
+<br>
+/* Helper function to fill IPv6 route information */<br>
+static void fill_ipv6_route_info(GuestNetworkRoute *route,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const MIB_IPFORWARD_ROW2 *row)=
<br>
+{<br>
+=C2=A0 =C2=A0 struct sockaddr_in6 *addr_in6;<br>
+=C2=A0 =C2=A0 char addr_str[INET6_ADDRSTRLEN];<br>
+<br>
+=C2=A0 =C2=A0 addr_in6 =3D (struct sockaddr_in6 *)&amp;row-&gt;Destination=
Prefix.Prefix;<br>
+=C2=A0 =C2=A0 if (inet_ntop(AF_INET6, &amp;addr_in6-&gt;sin6_addr, addr_st=
r, INET6_ADDRSTRLEN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;destination =3D g_strdup(addr_str);<=
br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;destination =3D g_strdup(&quot;::&qu=
ot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 addr_in6 =3D (struct sockaddr_in6 *)&amp;row-&gt;NextHop;<br=
>
+=C2=A0 =C2=A0 if (inet_ntop(AF_INET6, &amp;addr_in6-&gt;sin6_addr, addr_st=
r, INET6_ADDRSTRLEN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;nexthop =3D g_strdup(addr_str);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;nexthop =3D g_strdup(&quot;::&quot;)=
;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 route-&gt;desprefixlen =3D g_strdup_printf(&quot;%u&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
ow-&gt;DestinationPrefix.PrefixLength);<br>
+=C2=A0 =C2=A0 route-&gt;version =3D 6;<br>
+}<br>
+<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestNetworkRouteList *head =3D NULL, **tail =3D &amp;head;<=
br>
+=C2=A0 =C2=A0 PMIB_IPFORWARD_TABLE2 pIpForwardTable2;<br>
+=C2=A0 =C2=A0 DWORD dwRetVal =3D 0;<br>
+=C2=A0 =C2=A0 DWORD i;<br>
+=C2=A0 =C2=A0 PMIB_IPFORWARD_ROW2 row;<br>
+=C2=A0 =C2=A0 GuestNetworkRoute *route;<br>
+=C2=A0 =C2=A0 IP_ADAPTER_ADDRESSES *adptr_addrs;<br>
+=C2=A0 =C2=A0 MIB_IPINTERFACE_ROW ipifrow;<br>
+=C2=A0 =C2=A0 MIB_IF_ROW2 ifrow2;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 GHashTable *interface_metric_cache;<br>
+<br>
+=C2=A0 =C2=A0 dwRetVal =3D GetIpForwardTable2(AF_UNSPEC, &amp;pIpForwardTa=
ble2);<br>
+=C2=A0 =C2=A0 if (dwRetVal !=3D NO_ERROR) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, dwRetVal, &quot;failed =
to get IP routes&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 interface_metric_cache =3D g_hash_table_new_full(g_str_hash,=
 g_str_equal,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free, NULL);<br>
+=C2=A0 =C2=A0 adptr_addrs =3D guest_get_adapters_addresses(&amp;local_err)=
;<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 adptr_addrs =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; pIpForwardTable2-&gt;NumEntries; i++) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 row =3D &amp;pIpForwardTable2-&gt;Table[i];<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (row-&gt;DestinationPrefix.Prefix.si_family=
 =3D=3D AF_INET) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_new0(GuestNetworkRou=
te, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fill_ipv4_route_info(route, row)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (row-&gt;DestinationPrefix.Prefix.si=
_family =3D=3D AF_INET6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_new0(GuestNetworkRou=
te, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fill_ipv6_route_info(route, row)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;iface =3D get_interface_name(row, ad=
ptr_addrs);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Get interface metric for combined rout=
e metric calculation.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Windows calculates effective route met=
ric as route + interface metric.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This matches the values displayed by W=
indows &#39;route print&#39; command.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* See: <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=3D"https://learn.microsoft.com=
/en-us/windows/win32/api/netioapi/ns-netioapi-mib_ipforward_row2" rel=3D"no=
referrer" target=3D"_blank">https://learn.microsoft.com/en-us/windows/win32=
/api/netioapi/ns-netioapi-mib_ipforward_row2</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *luid_key =3D g_strdup_printf(&quot;%&qu=
ot; G_GUINT64_FORMAT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
ow-&gt;InterfaceLuid.Value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer cached_metric =3D g_hash_table_lookup=
(interface_metric_cache,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0luid_key);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cached_metric) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;metric =3D (int)row-&g=
t;Metric + GPOINTER_TO_INT(cached_metric);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(luid_key);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;ipifrow, 0, sizeof(i=
pifrow));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InitializeIpInterfaceEntry(&amp;=
ipifrow);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipifrow.InterfaceLuid =3D row-&g=
t;InterfaceLuid;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ipifrow.Family =3D row-&gt;Desti=
nationPrefix.Prefix.si_family;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetIpInterfaceEntry(&amp;ipi=
frow) =3D=3D NO_ERROR) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_inser=
t(interface_metric_cache, luid_key,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GINT_TO_POINTER(ipifrow=
.Metric));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;metric =
=3D (int)row-&gt;Metric + (int)ipifrow.Metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;metric =
=3D (int)row-&gt;Metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(luid_key);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;ifrow2, 0, sizeof(ifrow2));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ifrow2.InterfaceLuid =3D row-&gt;InterfaceLuid=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetIfEntry2(&amp;ifrow2) =3D=3D NO_ERROR) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;has_mtu =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;mtu =3D (int)ifrow2.Mt=
u;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, route);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 FreeMibTable(pIpForwardTable2);<br>
+=C2=A0 =C2=A0 g_free(adptr_addrs);<br>
+=C2=A0 =C2=A0 g_hash_table_destroy(interface_metric_cache);<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 5791b49dde..89ea5485cc 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1879,7 +1879,8 @@<br>
=C2=A0##<br>
=C2=A0# @GuestNetworkRoute:<br>
=C2=A0#<br>
-# Route information, currently, only linux supported.<br>
+# Route information.=C2=A0 Supported on Linux (since 9.1) and Windows<br>
+# (since 10.3).<br>
=C2=A0#<br>
=C2=A0# @iface: The destination network or host&#39;s egress network interf=
ace<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0in the routing table<br>
@@ -1916,7 +1917,7 @@<br>
=C2=A0#<br>
=C2=A0# @version: IP version (4 or 6)<br>
=C2=A0#<br>
-# Since: 9.1<br>
+# Since: 9.1 (Linux only); 10.3 (Windows)<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestNetworkRoute&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;iface&#39;: &#39;str&#39;,<br>
@@ -1936,7 +1937,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*nexthop&#39;: &#39;str&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;version&#39;: &#39;int&#39;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_WIN32&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-network-get-route:<br>
@@ -1945,9 +1946,9 @@<br>
=C2=A0#<br>
=C2=A0# Returns: List of route info of guest.<br>
=C2=A0#<br>
-# Since: 9.1<br>
+# Since: 9.1 (Linux only); 10.3 (Windows)<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-network-get-route&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestNetworkRoute&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39;<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_WIN32&#39;] }<br>
=C2=A0}<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--00000000000079452a064a8a1ff2--


