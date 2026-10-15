Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C12CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHQuk-0006Mh-3y; Thu, 15 Oct 2026 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xHQui-0006MO-Sf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:14:53 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xHQug-0007AU-IY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:14:52 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-30b6dad2382so13418358eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792091688; cv=none;
 d=google.com; s=arc-20260327;
 b=PFcxCk1Y/ihy3KxIlFzAkf6mapvjPaDDQY/gQvak14CluSkYtlLLqn7CtbW43lQgYn
 lGLxay3Vcx+lQJOmrwd9wdq+h/t9gw2loNf40nXCLoNQWxoRVWfbsr0rbv5aG2KgQV0/
 ytiXK/fDRMq3I1SDwg7zyAxMq9dDvYY7E6Y/maLGvYRvccqz4/s86uDBFxnXTvoMvVeQ
 8HPBsA2c1OzXTGgIedomCRAbG5AF6sYwBPO4CKZtfzVgX/apiyLgAHz1GOgl+RTHS+5I
 ctY0Fb+KPM5HyH5QyClbwH2168Mxqq0pFSN+mJUlq5d8HVYZs6GGvVkEcUVEV3xgNKP3
 9V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oqZKOQ7scxayXpdJUuGzys0xmR33SwXk4OFXWyxLQD8=;
 fh=mvAGnUzP+ayZVJCqXKjO3Y8aHRol7/UNMyFCRl8ZK6g=;
 b=oaZBX1bZcZbR0fcG1Svmx0k5S5qXTZK0JNcE1Cp0GmQISrJOfR4vpbyFu3k2QTyn4a
 7ncMzi3ylSZZ4haJT/a599nJy54jUBnwagK5ofNBTGt91cIYb1Q35HpSIfxwovlvRbg1
 YdmGUtCV61nwkCjr4xDY7b0nlTlFzF50LWOH2FNLS7y2yKlWyv9MqEHA/QUTQf1UUu83
 pBu70J9GeAW8KBm9i8oaX8gO9f7AjEVEJpD8a/KLtitYDyTN5S7XPIBvZthFWKowu+Ei
 3IpvUJtj8Gcu5KKTdUpl0MKu3dqL7nulqE1aMY91jzXVPSbw1PktyynsEIMbX63afwFP
 8Zpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792091688; x=1792696488; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oqZKOQ7scxayXpdJUuGzys0xmR33SwXk4OFXWyxLQD8=;
 b=LwLQ/uQR4FPaSCT7vifa8HarW71G/b+ItZRfFSkAGtqRkYD6orbMp+IEGPVl1WXMru
 Wum+77eyBjXwWRpVDb3noueWY9BJQK1eYI5ugY7MfnemTomGO5bLnlN0GV3gexAx8aUd
 w5TGVOv+V+MmbNiU4RUEIf6iF0QBB4oXwfe+7avAjRvhv/WDCd91hssVhK3ivH+mYOMp
 3p9Zjs4TM0zqmamozAEPdZ9v9vYL4uegXLq3EoaydPCC9Pgr45XMEIj/i1Z4vbIDqrri
 fWfoTEqcnYde+OYQ1T7rZZPrJrgWjDl/Rx4LMTg5zMJ/2SIz4SQ8T+0bJmnGkJfztGAe
 J3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792091688; x=1792696488;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oqZKOQ7scxayXpdJUuGzys0xmR33SwXk4OFXWyxLQD8=;
 b=2wBcwwRd4ohiWhIsBeHoFvTkGufraAXcAzFlJks5Y2xTvnmGX+mZzjGo0OeAn2tR8V
 obuhieQi48BcnB3NNh0UNTcv4U+EVVY6TwpPi2jbc5yHV0PDYUQXbtEtOyPeEP6LPBLT
 LLzwyh60JDhWoQ0gJBATfLtS3JdEmMe28OwaEYBmelMwpOXKbKG+BvZi310wfui7oBZG
 Y2z6GzM5VESiYv4oLxNdNSPYFO/OMPiN4+To0C8xrOb6viY765gaNRxXRU9Qrd/nKeHK
 wgxUWgwOcJCOnEFk00R1X9tfvWGqKzdBoqxl6T2Ci6Tp2eeUonZsFQefgqMYM0xYHHBV
 51kw==
X-Gm-Message-State: AFq9FYIUsh8feDXire60/PVlQ0T/IlNn9Lqgc1GsAQ+iASNQBPTPBRnL
 ddRn5ZI+Fil4RBmKXhlGQISK6cbCS+MuNDzSqEH2NjC24HZLYDZZf5IrxisJAf6L9QjwGptO/HQ
 PfVqQpbfcJiDHVgb+NLisA9xuopL+N0s=
X-Gm-Gg: AYBFou2OxZ1g5QELJ+5Ytd0CnCV3kyJ1ZBCAK+2oudMfg0JGVDOrccxUdX1Vi4FlNt+
 XqW5MyK7/OFPm2lc4Te34ZFH2B/rU5CbTIxYBvQUKgz6j+Ttqrm8XwsIo2HvBPkYPObTDO9X5Bl
 oAP2P1uuQvE7rvAPraGM652tJY0EfDEI8jJrcWsqK7CoJVga5igO7sPImrOV80reXipVXi+vm7D
 shvQZcvmBzi38gYqa/bQwX0Cq/IcWYfw4FWyd1JZhZdICMz6hRnFxR8jYbhCO/I6TfkhLVEmDS2
 MshcKB2WJOuynWq3lMGVK0qDhFaiDpkBkqjnHgIxjIi6vTu4p7nBEe/AS5n8N62o6kN31YwV2SV
 7hapWrc7fvK4uzQ==
X-Received: by 2002:a05:7300:fa04:b0:35d:187c:72cc with SMTP id
 5a478bee46e88-35d187c7b9cmr9087678eec.23.1792091688270; Thu, 15 Oct 2026
 12:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-vmnet-host-address-v2-1-6de517697453@gmail.com>
In-Reply-To: <20261001-vmnet-host-address-v2-1-6de517697453@gmail.com>
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 15 Oct 2026 21:14:36 +0200
X-Gm-Features: AclHuK8zAj1_OChrui6Z_6c7zR_qJlRyvx1SXxZbQP9eNiHQ3NLFWTX3sWT-Eo8
Message-ID: <CAOX+r598N6MWMd2z7EqpLkNm9sogTO52dkb251PJvmu_aC6UDQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/vmnet: Add host address options for vmnet-host
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007c034f065de5dc05"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=timpambor@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007c034f065de5dc05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

gentle ping

On Thu, Oct 1, 2026 at 11:17=E2=80=AFPM Tim Pambor <timpambor@gmail.com> wr=
ote:

> When a vmnet-host interface is added to an isolated network via
> 'net-uuid', vmnet does not provide DHCP, and the host side of the
> bridge gets no address, so the host cannot talk to guests on that
> network without manually assigning an IP address to the bridge
> interface after QEMU has started.
>
> vmnet provides the vmnet_host_ip_address_key,
> vmnet_host_subnet_mask_key and vmnet_host_ipv6_address_key
> properties to assign addresses to the host interface in this case.
> Expose them as the 'host-ip-address', 'host-subnet-mask' and
> 'host-ipv6-address' options of the vmnet-host backend.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
> Changes in v2:
> - Fixed spelling in the commit message
> - Link to v1:
> https://lore.kernel.org/qemu-devel/20260927-vmnet-host-address-v1-1-6feb7=
4f727c5@gmail.com
> ---
>  net/vmnet-host.c | 35 +++++++++++++++++++++++++++++++++++
>  qapi/net.json    | 15 ++++++++++++++-
>  qemu-options.hx  |  6 +++++-
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/net/vmnet-host.c b/net/vmnet-host.c
> index 49fb25c224..8ed7ee9d41 100644
> --- a/net/vmnet-host.c
> +++ b/net/vmnet-host.c
> @@ -41,6 +41,26 @@ static bool validate_options(const Netdev *netdev,
> Error **errp)
>          return false;
>      }
>
> +    if ((options->host_ip_address || options->host_subnet_mask) &&
> +        !(options->host_ip_address && options->host_subnet_mask)) {
> +        error_setg(errp,
> +                   "'host-ip-address' and 'host-subnet-mask' "
> +                   "should be provided together");
> +        return false;
> +    }
> +
> +    if (options->host_ip_address && !options->net_uuid) {
> +        error_setg(errp,
> +                   "'host-ip-address' requires 'net-uuid' to be
> specified");
> +        return false;
> +    }
> +
> +    if (options->host_ipv6_address && !options->net_uuid) {
> +        error_setg(errp,
> +                   "'host-ipv6-address' requires 'net-uuid' to be
> specified");
> +        return false;
> +    }
> +
>      return true;
>  }
>
> @@ -77,6 +97,21 @@ static xpc_object_t build_if_desc(const Netdev *netdev=
)
>                                    options->subnet_mask);
>      }
>
> +    if (options->host_ip_address) {
> +        xpc_dictionary_set_string(if_desc,
> +                                  vmnet_host_ip_address_key,
> +                                  options->host_ip_address);
> +        xpc_dictionary_set_string(if_desc,
> +                                  vmnet_host_subnet_mask_key,
> +                                  options->host_subnet_mask);
> +    }
> +
> +    if (options->host_ipv6_address) {
> +        xpc_dictionary_set_string(if_desc,
> +                                  vmnet_host_ipv6_address_key,
> +                                  options->host_ipv6_address);
> +    }
> +
>      return if_desc;
>  }
>
> diff --git a/qapi/net.json b/qapi/net.json
> index b46af1fdc9..38b43d20ed 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -795,6 +795,16 @@
>  #     is allowed only with other interfaces added to this network
>  #     identified by the UUID.  Requires at least macOS Big Sur 11.0.
>  #
> +# @host-ip-address: The IPv4 address to set on the host side of the
> +#     interface.  Only applicable when @net-uuid is also specified.
> +#     Must be specified along with @host-subnet-mask.
> +#
> +# @host-subnet-mask: The IPv4 subnet mask to set on the host side of
> +#     the interface.  Must be specified along with @host-ip-address.
> +#
> +# @host-ipv6-address: The IPv6 address to set on the host side of the
> +#     interface.  Only applicable when @net-uuid is also specified.
> +#
>  # Since: 7.1
>  ##
>  { 'struct': 'NetdevVmnetHostOptions',
> @@ -803,7 +813,10 @@
>      '*end-address':   'str',
>      '*subnet-mask':   'str',
>      '*isolated':      'bool',
> -    '*net-uuid':      'str' },
> +    '*net-uuid':      'str',
> +    '*host-ip-address': 'str',
> +    '*host-subnet-mask': 'str',
> +    '*host-ipv6-address': 'str' },
>    'if': 'CONFIG_VMNET' }
>
>  ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2f6863180b..9e250ad196 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3137,11 +3137,15 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>  #ifdef CONFIG_VMNET
>      "-netdev vmnet-host,id=3Dstr[,isolated=3Don|off][,net-uuid=3Duuid]\n=
"
>      "         [,start-address=3Daddr,end-address=3Daddr,subnet-mask=3Dma=
sk]\n"
> +    "
>  [,host-ip-address=3Daddr,host-subnet-mask=3Dmask][,host-ipv6-address=3Da=
ddr]\n"
>      "                configure a vmnet network backend in host mode with
> ID 'str',\n"
>      "                isolate this interface from others with
> 'isolated',\n"
>      "                configure the address range and choose a subnet
> mask,\n"
>      "                specify network UUID 'uuid' to disable DHCP and
> interact with\n"
> -    "                vmnet-host interfaces within this isolated network\=
n"
> +    "                vmnet-host interfaces within this isolated
> network,\n"
> +    "                set the host-side IPv4 address and subnet mask on
> an\n"
> +    "                isolated network with 'host-ip-address' and
> 'host-subnet-mask',\n"
> +    "                set the host-side IPv6 address with
> 'host-ipv6-address'\n"
>      "-netdev vmnet-shared,id=3Dstr[,isolated=3Don|off][,nat66-prefix=3Da=
ddr]\n"
>      "         [,start-address=3Daddr,end-address=3Daddr,subnet-mask=3Dma=
sk]\n"
>      "                configure a vmnet network backend in shared mode
> with ID 'str',\n"
>
> ---
> base-commit: efa3b9d5ac8024078225e1ab434411fdfe53b457
> change-id: 20260927-vmnet-host-address-47ff5d9adcbb
>
> Best regards,
> --
> Tim Pambor <timpambor@gmail.com>
>
>

--0000000000007c034f065de5dc05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>gentle ping</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Thu, Oct 1, 2026 at 11:17=E2=80=AFPM Tim Pambor &lt;<a href=3D"=
mailto:timpambor@gmail.com">timpambor@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">When a vmnet-host interface =
is added to an isolated network via<br>
&#39;net-uuid&#39;, vmnet does not provide DHCP, and the host side of the<b=
r>
bridge gets no address, so the host cannot talk to guests on that<br>
network without manually assigning an IP address to the bridge<br>
interface after QEMU has started.<br>
<br>
vmnet provides the vmnet_host_ip_address_key,<br>
vmnet_host_subnet_mask_key and vmnet_host_ipv6_address_key<br>
properties to assign addresses to the host interface in this case.<br>
Expose them as the &#39;host-ip-address&#39;, &#39;host-subnet-mask&#39; an=
d<br>
&#39;host-ipv6-address&#39; options of the vmnet-host backend.<br>
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
Signed-off-by: Tim Pambor &lt;<a href=3D"mailto:timpambor@gmail.com" target=
=3D"_blank">timpambor@gmail.com</a>&gt;<br>
---<br>
Changes in v2:<br>
- Fixed spelling in the commit message<br>
- Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260927-vmnet-=
host-address-v1-1-6feb74f727c5@gmail.com" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/qemu-devel/20260927-vmnet-host-address-v1-1-6fe=
b74f727c5@gmail.com</a><br>
---<br>
=C2=A0net/vmnet-host.c | 35 +++++++++++++++++++++++++++++++++++<br>
=C2=A0qapi/net.json=C2=A0 =C2=A0 | 15 ++++++++++++++-<br>
=C2=A0qemu-options.hx=C2=A0 |=C2=A0 6 +++++-<br>
=C2=A03 files changed, 54 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/net/vmnet-host.c b/net/vmnet-host.c<br>
index 49fb25c224..8ed7ee9d41 100644<br>
--- a/net/vmnet-host.c<br>
+++ b/net/vmnet-host.c<br>
@@ -41,6 +41,26 @@ static bool validate_options(const Netdev *netdev, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if ((options-&gt;host_ip_address || options-&gt;host_subnet_=
mask) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(options-&gt;host_ip_address &amp;&amp; optio=
ns-&gt;host_subnet_mask)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;&#39;host-ip-address&#39; and &#39;host-subnet-mask&#39; &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;should be provided together&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (options-&gt;host_ip_address &amp;&amp; !options-&gt;net_=
uuid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;&#39;host-ip-address&#39; requires &#39;net-uuid&#39; to be specified&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (options-&gt;host_ipv6_address &amp;&amp; !options-&gt;ne=
t_uuid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;&#39;host-ipv6-address&#39; requires &#39;net-uuid&#39; to be specified&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
@@ -77,6 +97,21 @@ static xpc_object_t build_if_desc(const Netdev *netdev)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;subnet_mask=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (options-&gt;host_ip_address) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 xpc_dictionary_set_string(if_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmnet_host_ip_address_key,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;host_ip_address);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 xpc_dictionary_set_string(if_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmnet_host_subnet_mask_key,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;host_subnet_mask)=
;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (options-&gt;host_ipv6_address) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 xpc_dictionary_set_string(if_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmnet_host_ipv6_address_key,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;host_ipv6_address=
);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return if_desc;<br>
=C2=A0}<br>
<br>
diff --git a/qapi/net.json b/qapi/net.json<br>
index b46af1fdc9..38b43d20ed 100644<br>
--- a/qapi/net.json<br>
+++ b/qapi/net.json<br>
@@ -795,6 +795,16 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0is allowed only with other interfaces added to t=
his network<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0identified by the UUID.=C2=A0 Requires at least =
macOS Big Sur 11.0.<br>
=C2=A0#<br>
+# @host-ip-address: The IPv4 address to set on the host side of the<br>
+#=C2=A0 =C2=A0 =C2=A0interface.=C2=A0 Only applicable when @net-uuid is al=
so specified.<br>
+#=C2=A0 =C2=A0 =C2=A0Must be specified along with @host-subnet-mask.<br>
+#<br>
+# @host-subnet-mask: The IPv4 subnet mask to set on the host side of<br>
+#=C2=A0 =C2=A0 =C2=A0the interface.=C2=A0 Must be specified along with @ho=
st-ip-address.<br>
+#<br>
+# @host-ipv6-address: The IPv6 address to set on the host side of the<br>
+#=C2=A0 =C2=A0 =C2=A0interface.=C2=A0 Only applicable when @net-uuid is al=
so specified.<br>
+#<br>
=C2=A0# Since: 7.1<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;NetdevVmnetHostOptions&#39;,<br>
@@ -803,7 +813,10 @@<br>
=C2=A0 =C2=A0 =C2=A0&#39;*end-address&#39;:=C2=A0 =C2=A0&#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;*subnet-mask&#39;:=C2=A0 =C2=A0&#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;*isolated&#39;:=C2=A0 =C2=A0 =C2=A0 &#39;bool&#39;=
,<br>
-=C2=A0 =C2=A0 &#39;*net-uuid&#39;:=C2=A0 =C2=A0 =C2=A0 &#39;str&#39; },<br=
>
+=C2=A0 =C2=A0 &#39;*net-uuid&#39;:=C2=A0 =C2=A0 =C2=A0 &#39;str&#39;,<br>
+=C2=A0 =C2=A0 &#39;*host-ip-address&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 &#39;*host-subnet-mask&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 &#39;*host-ipv6-address&#39;: &#39;str&#39; },<br>
=C2=A0 =C2=A0&#39;if&#39;: &#39;CONFIG_VMNET&#39; }<br>
<br>
=C2=A0##<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 2f6863180b..9e250ad196 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -3137,11 +3137,15 @@ DEF(&quot;netdev&quot;, HAS_ARG, QEMU_OPTION_netdev=
,<br>
=C2=A0#ifdef CONFIG_VMNET<br>
=C2=A0 =C2=A0 =C2=A0&quot;-netdev vmnet-host,id=3Dstr[,isolated=3Don|off][,=
net-uuid=3Duuid]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,start-address=
=3Daddr,end-address=3Daddr,subnet-mask=3Dmask]\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,host-ip-address=3D=
addr,host-subnet-mask=3Dmask][,host-ipv6-address=3Daddr]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 configure a vmnet network backend in host mode with ID &#39;str&#39;=
,\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 isolate this interface from others with &#39;isolated&#39;,\n&quot;<=
br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 configure the address range and choose a subnet mask,\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 specify network UUID &#39;uuid&#39; to disable DHCP and interact wit=
h\n&quot;<br>
-=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vmnet-host interfaces within this isolated network\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 vmnet-host interfaces within this isolated network,\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 set the host-side IPv4 address and subnet mask on an\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 isolated network with &#39;host-ip-address&#39; and &#39;host-subnet-ma=
sk&#39;,\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 set the host-side IPv6 address with &#39;host-ipv6-address&#39;\n&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0&quot;-netdev vmnet-shared,id=3Dstr[,isolated=3Don|off]=
[,nat66-prefix=3Daddr]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[,start-address=
=3Daddr,end-address=3Daddr,subnet-mask=3Dmask]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 configure a vmnet network backend in shared mode with ID &#39;str&#3=
9;,\n&quot;<br>
<br>
---<br>
base-commit: efa3b9d5ac8024078225e1ab434411fdfe53b457<br>
change-id: 20260927-vmnet-host-address-47ff5d9adcbb<br>
<br>
Best regards,<br>
--=C2=A0 <br>
Tim Pambor &lt;<a href=3D"mailto:timpambor@gmail.com" target=3D"_blank">tim=
pambor@gmail.com</a>&gt;<br>
<br>
</blockquote></div></div>

--0000000000007c034f065de5dc05--

