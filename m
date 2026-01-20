Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94599D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viA3F-0001N5-QT; Tue, 20 Jan 2026 06:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viA3D-0001MO-DE
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viA39-0000GT-SM
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768909050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXsAnxQEHE3y/76F1zw300Yl1/m0kQI+scHEhPa3/HI=;
 b=S8z6UXiBiFSD6t5Q9N35eQGzF8m6rJchZC2DS9ehD7zsGmGAtyM7xl4UcTS16bJZDQCyqU
 iSx5mlBFSULDlOB4YLzO5x822cXMHdlSPr7FRiJPx4+EQYVhBoUC3nNkQR+B6Y1Bbb5lcy
 m9+7VfwsgvcARZMP3LWMZJx1O+iyvLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-XuMIQL40Pcy7Zl2FEJBgdA-1; Tue, 20 Jan 2026 06:37:29 -0500
X-MC-Unique: XuMIQL40Pcy7Zl2FEJBgdA-1
X-Mimecast-MFC-AGG-ID: XuMIQL40Pcy7Zl2FEJBgdA_1768909048
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso4502943f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768909048; cv=none;
 d=google.com; s=arc-20240605;
 b=JXR/xk38XBb2kmAcRPH+s186z6cFunw55Yn7i31PWHizrwHdpeOJo+fQWgpfJeC3Wo
 WIdWAEYV3NBd1TLTekAluatg+Wgehs6dcgDhMgIiTnDE9dzk5iwHkNQnm4NiHhz58rFY
 sSeoeyh40WrdThWK7pTRtbv7hFB1fexSx1RYRcc77+SU2G25wcjsC+/cUiiIohC6s73R
 PNzWWPWV089YSr3YUoAixA+lj7sUoVhCyCzsCgPqhXGNyfODvZddvpseKYV2/9+jznX8
 IpR4Uv32MUvrndpfMtGIpLv2X8RTY5ttDq2/y+yBDQAepmUD35KMeg6BzwGuf1as9aul
 X70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lXsAnxQEHE3y/76F1zw300Yl1/m0kQI+scHEhPa3/HI=;
 fh=nzjBS48/fGEvhTwnCEPhQf+fF3B0V83pieQjyOEXTYs=;
 b=KlMwiY/KQWG5lC6A+z69u1BvpSf0+/063nERhD4snGnaIzk8kMnEhrTtbU2B1goNST
 W1q0Lg9dlu1fLTTEQCEdL2SKRNFu1D2hj9XoY80HhW3+9FilOVtg3ZDhre+lwoR/rvff
 CqtEJTWKLPh9bSn2p4RGUdrydbO6amYk2DJSvNbapnHBBc1BsHYf+JoYnFvyqalAO9m6
 cKQBls80Jo9XhMgcdE/JcTyu9hLC5egxylH7z14LxSHd315MXHcVsh2I21DBo2z69Ww/
 oMh8wsBHtZmGP7F+TCEnA/XcRh86AlHe9dz/UlwTJkFvSeecXBZxOViTPTMi7gje92zS
 Fy1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768909048; x=1769513848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXsAnxQEHE3y/76F1zw300Yl1/m0kQI+scHEhPa3/HI=;
 b=q18MOM77IZ10bUZ2F1NNBfdOXrEz9wIqnLtuylczvgUzPWaPQepE1cTzI0g5QK0aOP
 yXtQMghPVSGAthrHkITgZFSgnPQqeh5JpI6kxSZVazyfgomttzKTiVxh1jjxXkgcT3AD
 byzUt+eNkWfLcsG03xGIrwayN/t2eFJ62G7ZlOheTGfor2MDPnYnmzqzTyyiB2mm/XaL
 yESOn0UktFM5pVZ8apZvfE60CdVgfRwaFPsvOwgYe+I07toFS4QOaBxO2by570isEEaa
 4b3yaPc7LHVyI3esEhBxj1QNlpHEAkps+HiX0nswk8OHzl99eTqjfwf+X0bGsm3AOp5t
 ufiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768909048; x=1769513848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXsAnxQEHE3y/76F1zw300Yl1/m0kQI+scHEhPa3/HI=;
 b=JRWHQpWmqtVpFv+8rKdWtPq29goAGRKavtDHS+ECgRtggFW2GAz9ZCHeVh3tBr/1xB
 bkyHcgUzBrHGcv0K8B+N/tu7IxOLlB50GnMPGmyWXUgEP101LWCkOpQ3XQJO091BeOLC
 bFagtFrpJybu64qrGrXIpm0JvmiN+PcO+HZ1RQajDdjQgxBCgoxtCU7jjrEKv9GcSRmP
 Uzhw25MTH47Ziq0fCmNctk0QPZk7KqjIoey2z8hrt28I5yFWrimWNX1hP6Xumz2W3iXQ
 A1SK2GqhgnAnIhgm0qvYw3pr9tFE21076zjFfJmTf7r73Z9Sn5RVeQLVgZY98ZZf5KRH
 DlYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVY/YO8I7KfI1bhmrIokYfXvKvNPNSR4yZaciAbk6vz9A1MzEC2cHAGb9wmQZWNnxsgsMDtJxg4zge@nongnu.org
X-Gm-Message-State: AOJu0YzrQJtmhWFAgdbr0buiFi6HIWiytnO0I3Ta7b09A2ChcOP98nQw
 aBy9fisywMygEZcHfvOIxKPTIiZGQcux+HGenDZ3Qfr5/AAQkcElWmJzg25b7Qp4p1FGMHSRwGv
 +6TIbYRgFKI+12/NfjBzH6OsUVWVmS7k4aTFoymkp+LkzdKvOm1lpXPVevTiQ+EX6R8Fw3uhoPN
 e6vjvZQnxs4Fsdd2TDNcHFaJ9Apn5xuYA=
X-Gm-Gg: AY/fxX5+7ILI/EizemM1uNVv9mI10+VaeWVssGXEJu74oQcDQL9TWadMLo1XvJRlmrW
 yecnkNcsFAYxrSdGjwmUVvAkE17PUPvvjWPm+m5mGGjNnI3Ok4jb96HPV1xjNPHaJ0rUEetxTkm
 8sKCw+mygS7EDOoN9Dtr52+VhIaZqfg6JBO1sfrQooH591BaYEPxo9ikkBEX1G8sNLUwzyuxmfJ
 kkKrLecvVNAwWogNg7nY1b8tjDR23dsTJYBFx5CZVmyuPAwZYyJY50d
X-Received: by 2002:a05:600c:4513:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4801e2fc2e3mr195882095e9.7.1768909047658; 
 Tue, 20 Jan 2026 03:37:27 -0800 (PST)
X-Received: by 2002:a05:600c:4513:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4801e2fc2e3mr195881755e9.7.1768909047288; Tue, 20 Jan 2026
 03:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-5-farosas@suse.de>
 <CAE8KmOw66B0Za=KA=TyxyWMPYSjFK=GBq7XhREevkCO4Vs+HYQ@mail.gmail.com>
 <aW9ixg59R8a90FIs@redhat.com>
In-Reply-To: <aW9ixg59R8a90FIs@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 17:07:10 +0530
X-Gm-Features: AZwV_QjbsdPSxE3pAMz_VGpztWGm4zmiudJqC5HxZmXxa5I0UM2Zw4xazpqVG0c
Message-ID: <CAE8KmOwdfWPkmV87DWGVvHj7=QEYEXoHJOsRV4+SW3M_-PXdCQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] migration: Cleanup TLS handshake hostname passing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

On Tue, 20 Jan 2026 at 16:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Normal default behaviour is that the hostname in the TLS certificate
> MUST be validated against the hostname that is specified by the user
> (or mgmt app) in the migration URI.
>
> The 'tls-hostname' migration parameter is an optional override that
> replaces the hostname from the migration URI, to be used in scenarios
> such as:
>
>  * The URI is a UNIX socket. eg the UNIX socket points to a proxy
>    that is transporting data to the dest in some manner.  There is
>    no way to know the hostname from the URI, so 'tls-hostname' must
>    be provided
>
>  * The URI is pointing to a proxy that forwards to the real host.
>    eg perhaps you setup an SSH tunnel from localhost, to the real
>    target. QEMU must NOT validate the remote TLS cert against
>    'localhost', so 'tls-hostname' must be provided by the user

* I see, got it. Thank you for the explanation.

> Whatever is usd to validate the TLS hostname, must be data that is
> provided by the user in some manner.
>
> TL:DR: always use 'tls-hostname' if it is provided by the user,
> otherwise always use the hostname from the migration URI,
> otherwise do not provide a hostname.

* So when 'tls-hostname' is not defined, it could be set to
's->hostname', then migration_tls_hostname() stays unchanged.

Thank you.
---
  - Prasad


