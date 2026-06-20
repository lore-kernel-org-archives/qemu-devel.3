Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310BACD98F2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 02:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wala0-0008Fa-23; Fri, 19 Jun 2026 22:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1walQO-0007mV-85
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 22:27:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1walQK-0001eP-Om
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 22:27:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c6d4851142so21484065ad.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 19:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781922426; cv=none;
 d=google.com; s=arc-20240605;
 b=F3Dx26RICRRLz3P4Df1+imwTSNeZqRoY431j87RtHKq8YeaamnVIHAYVO/I1aMa2Jt
 oF/UNc5WCdIYda+6kvNGXw7vm2CdJmkYrjuwVa8A0vaZqWuU3OqjARkgyw+VnDBbhZSe
 9BfpMD9wAqb7vyWrnF+pjpG6o9gG/kJ6lEIFL8FyLQVyArmILw/0XCBfIRYxhXVLVEsl
 67KHoQMWK5DYtcURbn99I7vEJaZwmN2MqgAlL71VmV5zwKa1hcxAjSb18tb/ADMZIJ7y
 EzEEfxmhkk0gZJ9e4crYZ1O5Jkd69U0M5KQr/VVQntPwNu0WumSISeslm/9A6zR4LprO
 N79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i8A8G9CbWowml7SYN3JR2VtFTwO71xTzHmLepJ3CKY0=;
 fh=tChWmEYzjNiE2nQuOWKQCmsYiesBT8hJmZNJMxAXoz0=;
 b=Ip8acSiOdr50/YsGacUsU6tNiHhQZ8TnNpNLmmp8qnFoneIyB/Plj4ls9Ez1b0+trv
 hJwbVrpTWhSpfG2+ATOVGCD8cvFFqwodi4m10q6nmQS5xXNoobaxsGsLySGwvFPpStTQ
 pAu+zkwlyeqy3jOh2KNs5FqNF4wl0Y8wBEWZDXuebinrCaV6qzQYKQK5ACuFjGkut0Rh
 tt2zIK3oYoHiCX8riiqHFdcMgwVvEzxon3ohBFFwSCC0IgGs4pe7hVFoFYNId9CvfDym
 8uZ7caecbNBDEW9/LoSO1j1CTqd2rWKrrMVUkYDGRHSy2XV8PjxGZZyr7LJvY3r2YiC9
 iPrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781922426; x=1782527226;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i8A8G9CbWowml7SYN3JR2VtFTwO71xTzHmLepJ3CKY0=;
 b=FIQJTAggO0obv7YD+mrKWlPTcSRfLuOQg+RGyJ+32g+gYSO0cP01uKDNfacCdZW2hP
 8rRLCnoJkmpMAOzRSjSSOTo4uaYlixNnW1lm2gJUOhdiz8W7olTl/AHTHivSRree+u7+
 5EFyUCP0S4Mqsru09YUE4th8WLKLbuV+AAGsBiVxqelDieBpaM2kYWISrhzeqRp9E1Ce
 jobXgytqLM2dK/2XY1bpJuPj9N0LCYvsrO+ywNcZ8UpI1pF2oupxWR9gl+WUfR8dmxii
 yga+SjzaMGid7jFuIIxAdKpDkp2Nzwx8ryx3EmSzpzkUBKepVYv60pvQ5cwEPC9hTILV
 5UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922426; x=1782527226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8A8G9CbWowml7SYN3JR2VtFTwO71xTzHmLepJ3CKY0=;
 b=XM+ZBf2IiR/1a10aP7abvyHfyzwk7IOGG3Exz4kLXwomnBwG7vLPSDKzcjbnkdBEf+
 bEPXq/pByqK0ZJb+AdWmNn1zt6nWjMn4K5y1gkGUIEEyYUS2yFY25U7/2VcPF6h5PZTG
 NGX8UN4y/+2fHcNp+z7mt58mNIV5G6rHOmjWn4EAFSuwczNcGShx8op71dw75MjAZSxk
 rBF6VdTRxSKUA9CItTdIJ2hj2Lj5hJ4RwrlUazi69TclqIijmF7Nc3469KRtv8WCYnmL
 nmjzYHjoh/Pu4FPvElK2LgwICMbJi8S6W1ue8n886AqgiXILXyEOHltMZlLdshF/CXUc
 GP8A==
X-Gm-Message-State: AOJu0Yx5q6ATkGdqK7hUthEEkh7QwlgxZyIiOlHh4Qa11vEDZoyGOPAn
 YhFydSZULfDwmC+PnHWutMRv+Y/7eo/tJ2rURvPmuo2OACNQ5yQsuh8jCVCy9e/3ECvAzplUtr9
 Fa3VXE3mkt51vyojIYeM7zMcnYEd6iKCDHa5EkGclIg==
X-Gm-Gg: AfdE7cnV5K3C6pqff703DBGdyoo9+Z9nXZsK8TRym2Q+NyRnUD55O2FdeKTqOkyXZH8
 vat3CRwVEps8y7jYmJ8N0R3qawOZ/IKrEdwd2QRG0JOY77VPCJPhntTazmj6g9ApSZbavXOJH+V
 1HSJ4K7icgNe7q5ZWji4HJvNwXh8o4DXjUhBmyV4EpTLqvI4BRms3IYp5WiANM1v/0TNWXtBWs5
 6bWqmhM4+0EnJU5cWiahxmNv3SUY9Zv6Aa77t3NTfME1YW6snRPVt3kFoxfAJWxH6z0AS1hxQ==
X-Received: by 2002:a17:902:f610:b0:2c6:829b:b0c2 with SMTP id
 d9443c01a7336-2c7195b4a1emr50074875ad.11.1781922425851; Fri, 19 Jun 2026
 19:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-13-6c16fe448301@bsdimp.com>
 <05842e0f-5c9b-4820-8c43-78ca3d596e0c@oss.qualcomm.com>
In-Reply-To: <05842e0f-5c9b-4820-8c43-78ca3d596e0c@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 19 Jun 2026 22:26:54 -0400
X-Gm-Features: AVVi8CcjONVjRaPgSDdGFYHSguIKsglzJSr-P_e1NvJPq2yrZvOA4us1cv6Svf0
Message-ID: <CANCZdfq6nD8LRV4DzZTwmbScPXx2y1Vzk=LBbmfQzKa0g9mosA@mail.gmail.com>
Subject: Re: [PATCH v2 13/37] bsd-user: Add do_bsd_getsockopt
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000035e3d30654a62519"
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000035e3d30654a62519
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:28=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add the getsockopt(2) implementation handling SOL_SOCKET, IPPROTO_TCP,
> > IPPROTO_IP, and IPPROTO_IPV6 levels with proper target-to-host option
> > name translation.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/os-socket.h | 284
> +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 284 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.=
h
> > index 897a1f4d2f..f8521780c1 100644
> > --- a/bsd-user/freebsd/os-socket.h
> > +++ b/bsd-user/freebsd/os-socket.h
> > @@ -399,5 +399,289 @@ unimplemented:
> >      return ret;
> >  }
> >
> > +/* getsockopt(2) */
> > +static inline abi_long do_bsd_getsockopt(int sockfd, int level, int
> optname,
> > +        abi_ulong optval_addr, abi_ulong optlen)
> > +{
> > +    abi_long ret;
> > +    int len, val;
> > +    socklen_t lv;
> > +    void *p;
> > +
> > +    switch (level) {
> > +    case TARGET_SOL_SOCKET:
> > +        level =3D SOL_SOCKET;
> > +        switch (optname) {
> > +
> > +        /* These don't just return a single integer */
> > +        case TARGET_SO_LINGER:
> > +        case TARGET_SO_RCVTIMEO:
> > +        case TARGET_SO_SNDTIMEO:
> > +        case TARGET_SO_ACCEPTFILTER:
> > +            goto unimplemented;
> > +
> > +        /* Options with 'int' argument.  */
> > +        case TARGET_SO_DEBUG:
> > +            optname =3D SO_DEBUG;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_REUSEADDR:
> > +            optname =3D SO_REUSEADDR;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_REUSEPORT:
> > +            optname =3D SO_REUSEPORT;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_TYPE:
> > +            optname =3D SO_TYPE;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_ERROR:
> > +            optname =3D SO_ERROR;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_DONTROUTE:
> > +            optname =3D SO_DONTROUTE;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_BROADCAST:
> > +            optname =3D SO_BROADCAST;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_SNDBUF:
> > +            optname =3D SO_SNDBUF;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_RCVBUF:
> > +            optname =3D SO_RCVBUF;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_KEEPALIVE:
> > +            optname =3D SO_KEEPALIVE;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_OOBINLINE:
> > +            optname =3D SO_OOBINLINE;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_TIMESTAMP:
> > +            optname =3D SO_TIMESTAMP;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_RCVLOWAT:
> > +            optname =3D SO_RCVLOWAT;
> > +            goto int_case;
> > +
> > +        case TARGET_SO_LISTENINCQLEN:
> > +            optname =3D SO_LISTENINCQLEN;
> > +            goto int_case;
> > +
>
> This duplicates what there is in previous patch.
> We should add a target_to_host_sockopt that takes care of this.
>

I've actually reimplemented this more fundamentally. I fixed the annotation=
s
that the FreeBSD source code so that I can make a table of the options
so I can automatically do all this. There may be a few regresions in what
I've done, but they should be easy to fix later.

Warner


> > +        default:
> > +int_case:
> > +            if (get_user_u32(len, optlen)) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            if (len < 0) {
> > +                return -TARGET_EINVAL;
> > +            }
> > +            lv =3D sizeof(lv);
> > +            ret =3D get_errno(getsockopt(sockfd, level, optname, &val,
> &lv));
> > +            if (ret < 0) {
> > +                return ret;
> > +            }
> > +            if (len > lv) {
> > +                len =3D lv;
> > +            }
> > +            if (len =3D=3D 4) {
> > +                if (put_user_u32(val, optval_addr)) {
> > +                    return -TARGET_EFAULT;
> > +                }
> > +            } else {
> > +                if (put_user_u8(val, optval_addr)) {
> > +                    return -TARGET_EFAULT;
> > +                }
> > +            }
> > +            if (put_user_u32(len, optlen)) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            break;
> > +
> > +        }
> > +        break;
> > +
> > +    case IPPROTO_TCP:
> > +        /* TCP options all take an 'int' value. */
> > +        goto int_case;
> > +
> > +    case IPPROTO_IP:
> > +        switch (optname) {
> > +        case IP_OPTIONS:
> > +            if (get_user_u32(len, optlen)) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            lv =3D (socklen_t)len;
> > +            p =3D lock_user(VERIFY_WRITE, optval_addr, len, 0);
> > +            if (p =3D=3D NULL) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            ret =3D get_errno(getsockopt(sockfd, level, optname, p, &l=
v));
> > +            unlock_user(p, optval_addr, len);
> > +            if (put_user_u32(lv, optlen)) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            break;
> > +        case IP_HDRINCL:
> > +        case IP_TOS:
> > +        case IP_TTL:
> > +        case IP_RECVOPTS:
> > +        case IP_RECVRETOPTS:
> > +        case IP_RECVDSTADDR:
> > +
> > +        case IP_RETOPTS:
> > +#if defined(IP_RECVTOS)
> > +        case IP_RECVTOS:
> > +#endif
> > +        case IP_MULTICAST_TTL:
> > +        case IP_MULTICAST_LOOP:
> > +        case IP_PORTRANGE:
> > +        case IP_IPSEC_POLICY:
> > +        case IP_ONESBCAST:
> > +        case IP_BINDANY:
> > +            if (get_user_u32(len, optlen)) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            if (len < 0) {
> > +                return -TARGET_EINVAL;
> > +            }
> > +            lv =3D sizeof(lv);
> > +            ret =3D get_errno(getsockopt(sockfd, level, optname,
> > +                &val, &lv));
> > +            if (ret < 0) {
> > +                return ret;
> > +            }
> > +            if (len < sizeof(int) && len > 0 && val >=3D 0 &&
> > +                val < 255) {
> > +                len =3D 1;
> > +                if (put_user_u32(len, optlen) ||
> > +                        put_user_u8(val, optval_addr)) {
> > +                    return -TARGET_EFAULT;
> > +                }
> > +            } else {
> > +                if (len > sizeof(int)) {
> > +                    len =3D sizeof(int);
> > +                }
> > +                if (put_user_u32(len, optlen) ||
> > +                        put_user_u32(val, optval_addr)) {
> > +                    return -TARGET_EFAULT;
> > +                }
> > +            }
> > +            break;
> > +
> > +        default:
> > +            goto unimplemented;
> > +        }
> > +        break;
> > +
> > +    case IPPROTO_IPV6:
> > +        switch (optname) {
> > +        case IPV6_UNICAST_HOPS:     /* int; IP6 hops */
> > +        case IPV6_MULTICAST_IF:     /* u_int; set/get IP6 multicast
> i/f  */
> > +        case IPV6_MULTICAST_HOPS:   /* int; set/get IP6 multicast hops
> */
> > +        case IPV6_MULTICAST_LOOP:   /* u_int; set/get IP6 multicast
> loopback */
> > +        case IPV6_PORTRANGE:        /* int; range to choose for unspec
> port */
> > +        case IPV6_CHECKSUM:         /* int; checksum offset for raw
> socket */
> > +        case IPV6_V6ONLY:           /* bool; make AF_INET6 sockets v6
> only */
> > +        case IPV6_RECVPKTINFO:      /* bool; recv if, dst addr */
> > +        case IPV6_RECVHOPLIMIT:     /* bool; recv hop limit */
> > +        case IPV6_RECVRTHDR:        /* bool; recv routing header */
> > +        case IPV6_RECVHOPOPTS:      /* bool; recv hop-by-hop option */
> > +        case IPV6_RECVDSTOPTS:      /* bool; recv dst option after
> rthdr */
> > +        case IPV6_USE_MIN_MTU:      /* bool; send packets at the
> minimum MTU */
> > +        case IPV6_RECVPATHMTU:      /* bool; notify an according MTU *=
/
> > +        case IPV6_HOPLIMIT:         /* int; send hop limit */
> > +        case IPV6_RECVTCLASS:       /* bool; recv traffic class values
> */
> > +        case IPV6_AUTOFLOWLABEL:    /* bool; attach flowlabel
> automagically */
> > +        case IPV6_TCLASS:           /* int; send traffic class value *=
/
> > +        case IPV6_DONTFRAG:         /* bool; disable IPv6 fragmentatio=
n
> */
> > +        case IPV6_PREFER_TEMPADDR:  /* int; prefer temporary addresses
> */
> > +        case IPV6_BINDANY:          /* bool: allow bind to any address
> */
> > +#ifdef IPV6_BINDMULTI
> > +        case IPV6_BINDMULTI:        /* bool; allow multibind to same
> addr/port*/
> > +#endif /* IPV6_BINDMULTI */
> > +#ifdef IPV6_RSS_LISTEN_BUCKET
> > +        case IPV6_RSS_LISTEN_BUCKET: /* int; set RSS listen bucket */
> > +#endif /* IPV6_RSS_LISTEN_BUCKET */
> > +#ifdef IPV6_FLOWID
> > +        case IPV6_FLOWID:           /* int; flowid of given socket */
> > +#endif /* IPV6_FLOWID */
> > +#ifdef IPV6_FLOWTYPE
> > +        case IPV6_FLOWTYPE:         /* int; flowtype of given socket *=
/
> > +#endif /* IPV6_FLOWTYPE */
> > +#ifdef IPV6_RSSBUCKETID
> > +        case IPV6_RSSBUCKETID:      /* int; RSS bucket ID of given
> socket */
> > +#endif /* IPV6_RSSBUCKETID */
> > +            if (get_user_u32(len, optlen)) {
> > +                return -TARGET_EFAULT;
> > +            }
> > +            if (len < 0) {
> > +                return -TARGET_EINVAL;
> > +            }
> > +            lv =3D sizeof(lv);
> > +            ret =3D get_errno(getsockopt(sockfd, level, optname,
> > +                &val, &lv));
> > +            if (ret < 0) {
> > +                return ret;
> > +            }
> > +            if (len < sizeof(int) && len > 0 && val >=3D 0 &&
> > +                val < 255) {
> > +                len =3D 1;
> > +                if (put_user_u32(len, optlen) ||
> > +                        put_user_u8(val, optval_addr)) {
> > +                    return -TARGET_EFAULT;
> > +                }
> > +            } else {
> > +                if (len > sizeof(int)) {
> > +                    len =3D sizeof(int);
> > +                }
> > +                if (put_user_u32(len, optlen) ||
> > +                        put_user_u32(val, optval_addr)) {
> > +                    return -TARGET_EFAULT;
> > +                }
> > +            }
> > +            break;
> > +
> > +        case IPV6_JOIN_GROUP:   /* ipv6_mreq; join a group membership =
*/
> > +        case IPV6_LEAVE_GROUP:  /* ipv6_mreq; leave a group membership
> */
> > +        case ICMP6_FILTER:      /* icmp6_filter; icmp6 filter */
> > +        case IPV6_IPSEC_POLICY: /* struct; get/set security policy */
> > +        case IPV6_FW_ADD:       /* add a firewall rule to chain */
> > +        case IPV6_FW_DEL:       /* delete a firewall rule from chain *=
/
> > +        case IPV6_FW_FLUSH:     /* flush firewall rule chain */
> > +        case IPV6_FW_ZERO:      /* clear single/all firewall counter(s=
)
> */
> > +        case IPV6_FW_GET:       /* get entire firewall rule chain */
> > +        case IPV6_RTHDRDSTOPTS: /* ip6_dest; send dst option before
> rthdr */
> > +        case IPV6_PATHMTU:      /* mtuinfo; get the current path MTU *=
/
> > +        case IPV6_PKTINFO:      /* in6_pktinfo; send if, src addr */
> > +        case IPV6_NEXTHOP:      /* sockaddr; next hop addr */
> > +        case IPV6_HOPOPTS:      /* ip6_hbh; send hop-by-hop option */
> > +        case IPV6_DSTOPTS:      /* ip6_dest; send dst option befor
> rthdr */
> > +        case IPV6_RTHDR:        /* ip6_rthdr; send routing header */
> > +        case IPV6_MSFILTER:     /* struct __msfilterreq; */
> > +        default:
> > +            goto unimplemented;
> > +        }
> > +        break;
> > +
> > +    default:
> > +unimplemented:
> > +        gemu_log("getsockopt level=3D%d optname=3D%d not yet supported=
\n",
> > +            level, optname);
> > +        ret =3D -TARGET_EOPNOTSUPP;
> > +        break;
> > +    }
> > +    return ret;
> > +}
> > +
> >
> >  #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
> >
>
>

--00000000000035e3d30654a62519
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 7:28=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add the getsockopt(2) implementation handling SOL_SOCKET, IPPROTO_TCP,=
<br>
&gt; IPPROTO_IP, and IPPROTO_IPV6 levels with proper target-to-host option<=
br>
&gt; name translation.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/os-socket.h | 284 +++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 1 file changed, 284 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket=
.h<br>
&gt; index 897a1f4d2f..f8521780c1 100644<br>
&gt; --- a/bsd-user/freebsd/os-socket.h<br>
&gt; +++ b/bsd-user/freebsd/os-socket.h<br>
&gt; @@ -399,5 +399,289 @@ unimplemented:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/* getsockopt(2) */<br>
&gt; +static inline abi_long do_bsd_getsockopt(int sockfd, int level, int o=
ptname,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong optval_addr, abi_ulong optlen)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 int len, val;<br>
&gt; +=C2=A0 =C2=A0 socklen_t lv;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (level) {<br>
&gt; +=C2=A0 =C2=A0 case TARGET_SOL_SOCKET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 level =3D SOL_SOCKET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (optname) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* These don&#39;t just return a single i=
nteger */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_LINGER:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_RCVTIMEO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_SNDTIMEO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_ACCEPTFILTER:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unimplemented;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Options with &#39;int&#39; argument.=
=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_DEBUG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_DEBUG;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_REUSEADDR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_REUSEADDR;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_REUSEPORT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_REUSEPORT;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TYPE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_TYPE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_ERROR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_ERROR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_DONTROUTE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_DONTROUTE;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_BROADCAST:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_BROADCAST;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_SNDBUF:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_SNDBUF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_RCVBUF:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_RCVBUF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_KEEPALIVE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_KEEPALIVE;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_OOBINLINE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_OOBINLINE;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_TIMESTAMP;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_RCVLOWAT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_RCVLOWAT;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_LISTENINCQLEN:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_LISTENINCQLE=
N;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
<br>
This duplicates what there is in previous patch.<br>
We should add a target_to_host_sockopt that takes care of this.<br></blockq=
uote><div><br></div><div>I&#39;ve actually reimplemented this more fundamen=
tally. I fixed the annotations</div><div>that the FreeBSD source code so th=
at I can make a table of the options</div><div>so I can automatically do al=
l this. There may be a few regresions in what</div><div>I&#39;ve done, but =
they should be easy to fix later.</div><div><br></div><div>Warner</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +int_case:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_u32(len, optle=
n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lv =3D sizeof(lv);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(getsockop=
t(sockfd, level, optname, &amp;val, &amp;lv));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &gt; lv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D lv;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len =3D=3D 4) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_=
u32(val, optval_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_=
u8(val, optval_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_u32(len, optle=
n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPPROTO_TCP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TCP options all take an &#39;int&#39; =
value. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPPROTO_IP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (optname) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_OPTIONS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_u32(len, optle=
n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lv =3D (socklen_t)len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D lock_user(VERIFY_WRIT=
E, optval_addr, len, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(getsockop=
t(sockfd, level, optname, p, &amp;lv));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(p, optval_addr,=
 len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_u32(lv, optlen=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_HDRINCL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_TOS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_TTL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_RECVOPTS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_RECVRETOPTS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_RECVDSTADDR:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_RETOPTS:<br>
&gt; +#if defined(IP_RECVTOS)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_RECVTOS:<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_MULTICAST_TTL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_MULTICAST_LOOP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_PORTRANGE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_IPSEC_POLICY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_ONESBCAST:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_BINDANY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_u32(len, optle=
n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lv =3D sizeof(lv);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(getsockop=
t(sockfd, level, optname,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;val, &am=
p;lv));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; sizeof(int) &a=
mp;&amp; len &gt; 0 &amp;&amp; val &gt;=3D 0 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &lt; 255)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D 1;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_=
u32(len, optlen) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 put_user_u8(val, optval_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &gt; =
sizeof(int)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 len =3D sizeof(int);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_=
u32(len, optlen) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 put_user_u32(val, optval_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unimplemented;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case IPPROTO_IPV6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (optname) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_UNICAST_HOPS:=C2=A0 =C2=A0 =C2=
=A0/* int; IP6 hops */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MULTICAST_IF:=C2=A0 =C2=A0 =C2=
=A0/* u_int; set/get IP6 multicast i/f=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MULTICAST_HOPS:=C2=A0 =C2=A0/* =
int; set/get IP6 multicast hops */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MULTICAST_LOOP:=C2=A0 =C2=A0/* =
u_int; set/get IP6 multicast loopback */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_PORTRANGE:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* int; range to choose for unspec port */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_CHECKSUM:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* int; checksum offset for raw socket */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_V6ONLY:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* bool; make AF_INET6 sockets v6 only */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVPKTINFO:=C2=A0 =C2=A0 =C2=
=A0 /* bool; recv if, dst addr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVHOPLIMIT:=C2=A0 =C2=A0 =C2=
=A0/* bool; recv hop limit */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVRTHDR:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* bool; recv routing header */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVHOPOPTS:=C2=A0 =C2=A0 =C2=
=A0 /* bool; recv hop-by-hop option */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVDSTOPTS:=C2=A0 =C2=A0 =C2=
=A0 /* bool; recv dst option after rthdr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_USE_MIN_MTU:=C2=A0 =C2=A0 =C2=
=A0 /* bool; send packets at the minimum MTU */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVPATHMTU:=C2=A0 =C2=A0 =C2=
=A0 /* bool; notify an according MTU */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_HOPLIMIT:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* int; send hop limit */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVTCLASS:=C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* bool; recv traffic class values */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_AUTOFLOWLABEL:=C2=A0 =C2=A0 /* =
bool; attach flowlabel automagically */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_TCLASS:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* int; send traffic class value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_DONTFRAG:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* bool; disable IPv6 fragmentation */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_PREFER_TEMPADDR:=C2=A0 /* int; =
prefer temporary addresses */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_BINDANY:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* bool: allow bind to any address */<br>
&gt; +#ifdef IPV6_BINDMULTI<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_BINDMULTI:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* bool; allow multibind to same addr/port*/<br>
&gt; +#endif /* IPV6_BINDMULTI */<br>
&gt; +#ifdef IPV6_RSS_LISTEN_BUCKET<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RSS_LISTEN_BUCKET: /* int; set =
RSS listen bucket */<br>
&gt; +#endif /* IPV6_RSS_LISTEN_BUCKET */<br>
&gt; +#ifdef IPV6_FLOWID<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FLOWID:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* int; flowid of given socket */<br>
&gt; +#endif /* IPV6_FLOWID */<br>
&gt; +#ifdef IPV6_FLOWTYPE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FLOWTYPE:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* int; flowtype of given socket */<br>
&gt; +#endif /* IPV6_FLOWTYPE */<br>
&gt; +#ifdef IPV6_RSSBUCKETID<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RSSBUCKETID:=C2=A0 =C2=A0 =C2=
=A0 /* int; RSS bucket ID of given socket */<br>
&gt; +#endif /* IPV6_RSSBUCKETID */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_u32(len, optle=
n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGE=
T_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lv =3D sizeof(lv);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(getsockop=
t(sockfd, level, optname,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;val, &am=
p;lv));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; sizeof(int) &a=
mp;&amp; len &gt; 0 &amp;&amp; val &gt;=3D 0 &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val &lt; 255)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D 1;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_=
u32(len, optlen) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 put_user_u8(val, optval_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &gt; =
sizeof(int)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 len =3D sizeof(int);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (put_user_=
u32(len, optlen) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 put_user_u32(val, optval_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_JOIN_GROUP:=C2=A0 =C2=A0/* ipv6=
_mreq; join a group membership */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_LEAVE_GROUP:=C2=A0 /* ipv6_mreq=
; leave a group membership */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ICMP6_FILTER:=C2=A0 =C2=A0 =C2=A0 /*=
 icmp6_filter; icmp6 filter */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_IPSEC_POLICY: /* struct; get/se=
t security policy */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FW_ADD:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* add a firewall rule to chain */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FW_DEL:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* delete a firewall rule from chain */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FW_FLUSH:=C2=A0 =C2=A0 =C2=A0/*=
 flush firewall rule chain */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FW_ZERO:=C2=A0 =C2=A0 =C2=A0 /*=
 clear single/all firewall counter(s) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FW_GET:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* get entire firewall rule chain */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RTHDRDSTOPTS: /* ip6_dest; send=
 dst option before rthdr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_PATHMTU:=C2=A0 =C2=A0 =C2=A0 /*=
 mtuinfo; get the current path MTU */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_PKTINFO:=C2=A0 =C2=A0 =C2=A0 /*=
 in6_pktinfo; send if, src addr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_NEXTHOP:=C2=A0 =C2=A0 =C2=A0 /*=
 sockaddr; next hop addr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_HOPOPTS:=C2=A0 =C2=A0 =C2=A0 /*=
 ip6_hbh; send hop-by-hop option */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_DSTOPTS:=C2=A0 =C2=A0 =C2=A0 /*=
 ip6_dest; send dst option befor rthdr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RTHDR:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* ip6_rthdr; send routing header */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MSFILTER:=C2=A0 =C2=A0 =C2=A0/*=
 struct __msfilterreq; */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unimplemented;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +unimplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;getsockopt level=3D%d optn=
ame=3D%d not yet supported\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 level, optname);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -TARGET_EOPNOTSUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000035e3d30654a62519--

