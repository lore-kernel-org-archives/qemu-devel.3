Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE047E9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7i2-0006ad-I2; Wed, 25 Feb 2026 00:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vv7i0-0006aL-BJ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vv7hy-0000Do-D6
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771998312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKn5XRBiwMVdACVkaCl23uWqRe5UhyUswUjPxenekEo=;
 b=TPf3ocUfDAy4jwAsVcKJl4Uv4xV2SVN3b65OO596TJ8xk1k1jpEMC+852+VFU3TY37ggQ8
 bXANpglyMytfuQNfATFq6yrllGGqAPwrt2Ib+j7zS6DqqTs85FNKiS8Y6HK3K5oUzJp+6l
 68k8ICGOSRAiIrpYV+sEV5zuEEr0S64=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-1fqhn7B9PpWmo9HEhK7bAw-1; Wed, 25 Feb 2026 00:45:10 -0500
X-MC-Unique: 1fqhn7B9PpWmo9HEhK7bAw-1
X-Mimecast-MFC-AGG-ID: 1fqhn7B9PpWmo9HEhK7bAw_1771998310
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-5ff0eb3ff4cso29304137.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771998310; cv=none;
 d=google.com; s=arc-20240605;
 b=E1B8jBLzSF2ionm2Jo8CjZ3dxb1O9ll32uQmlAHd+bMI3m4ddGvYl0rEJJQzeTkGZ3
 V9S8ADWBbrDWIC8INAGeG8CjiLkzXWr/oLuVhhlb/ay7FleopC0QEKdOibhS0MptSd04
 fhmty/Eh5zvFq2P+Z6iTN4DxCGnZoDJR7Zg+P+d91MeMDwnWX7Wtas9sQisDOtuLGfn3
 IcaUxyzyhRBDVVDRAkTzTwgw/OmfGI5E/JWlT6+7RbMxoyslvVtJTZvTqGwJYidAp6os
 7mIe5CwIoecZFTnGvnbLIliVcDi5lhh7+sKHFWtwFtmZnklq7BDkO4piavsQG4RUT9St
 kULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CKn5XRBiwMVdACVkaCl23uWqRe5UhyUswUjPxenekEo=;
 fh=J1wMMtsO9VCSlRPTqWUaaMyTY3TLpaVYPKZnAUHbFM4=;
 b=DNF92mY2c+v8E3AerkpNV7bQVJbU7NNv2bU4yC+4Nt1dL2zmmx8dB6oGSD0NcyXHVb
 Wntf4EMjYswECqFdrIX+RenHTeu9ielzMZ3eMesONwplbt0EFNxhEzAk5YlFJAEP83Y5
 3bkDLfjkjb1CV8lUj/ebArcqQC2bl6y6uK7GsGgw/zh8nm+FGUp8/Um5Jvs94X8b+qsB
 kb81tybrO2QN1ikN4kps01HRSvSPBPe6+3s7Nd2XqG3yc/kkY6x16/xH4+1pn1x2WRCE
 a4qKumGT61GZuHEe+LF6LUrSYwEvcbYAQEb4psch3cLXcu5wTZKfH3hJZvtr8EZDs8xR
 u6oA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771998310; x=1772603110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKn5XRBiwMVdACVkaCl23uWqRe5UhyUswUjPxenekEo=;
 b=BtDcwxv5n/7AoCw74txmOOcs3P7BIsEcwVuQrghM/eJTnE4rsVZxsfYUb/vc10xgRe
 2KdT0rUDYsceBFPqDswhzz+WNrANgBGXsj9fywgA0lMdQH9CUfgDaXRUXGDxg5o5g6V9
 OdMd2Ame5yWpgIWAZXl6aM1sRea9cbSuLC30BTKPJzFLKmxea+GgIKW2csv8C5T69ts5
 B1Nzo7mui6CAAj5XtERHTXrOxbh3DGUw7oT0aUFhBMnWwEPSH1TDs6mMwSUzfa9TUE40
 KRrOVfqgVCLz23whfHI6w2OJAYLTzZL/hKVVHTf9MGo5mRyqTkHBKQLkTgn2UsevVuv0
 GQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771998310; x=1772603110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKn5XRBiwMVdACVkaCl23uWqRe5UhyUswUjPxenekEo=;
 b=kPcHH5+SzOV5Ztt++dUBoyybsE+Rd/HDbdl7wxwr0rHzZicIUgJ/eEGmzT7r/oHqHx
 ogoCohk4kOvkkJqEYxEwUNzHkEPL1uLGPul9QOMuU7/NsKZ/kOFouRdNe+OPY5O3ElYF
 rTRL23ApyVGPqVjt1aRFbUa1BtJHPM1exemVI+9ol8vXn5f71Vkpa2W+d/+OMy33BkwP
 VAaFz2Lcy+fhQOYwsIibmvgKtKkRkyUhrvcvpEoh+mOvCZOAtdgt5jwJcC1b32FpCU4o
 uRBFVDSQYSJW+GIIr+r4XeJYozKN/YZTd8qPO5fIzAWyoYlcmmqe93ddaUD37EXhZjvZ
 +NtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRxo5mVrNRtS+g9D5WmrSLeX3fy4CuvzzgVqFBDigQiSkn01lo8CCAfk6gBcNhqN5sku18Ko7Rs3bQ@nongnu.org
X-Gm-Message-State: AOJu0YwWt9WCad5Mq6RktIWRvGMIURshgvRUf9h/Y4ifQmcpbJeRL/ij
 3R7MduKM/6UesUffnsdzCYC/6AqhVHq5MREjWJZCm13AVspLubFnaN8XqLBTCnwmvhiVNCNPWnI
 VtexxP17xD3tFZhuDGJaI2YC78eGZqlurj9cfaOAiGIFp9+l3sJrFrGuKx2iglAX5YHKX8/1naj
 Y49EOUWrD91agJFo8cmiuABnIdO+07IPM=
X-Gm-Gg: ATEYQzy3CzdyHXoVbDQpTPI6etSx3bpqxWc+5HH20JusBM0z2LOUn8Bz9quW26AU+YO
 v6TDwcVhwlE1UV8IcYUDUODRzg3USbzOT+SvV2jFcJf+8HFRen2ROShhcw3BpuLuevPRWAhlJgD
 xq9cQ131rWr0lH/I3wJeORaUbduNDPbBNjmQbemuf7nztj7OtkszULWdEite5eeY/9QuSdWxvGg
 dx7jJ4=
X-Received: by 2002:a05:6102:3913:b0:5db:3d11:c8d6 with SMTP id
 ada2fe7eead31-5feb2e63d27mr4635542137.5.1771998309879; 
 Tue, 24 Feb 2026 21:45:09 -0800 (PST)
X-Received: by 2002:a05:6102:3913:b0:5db:3d11:c8d6 with SMTP id
 ada2fe7eead31-5feb2e63d27mr4635535137.5.1771998309503; Tue, 24 Feb 2026
 21:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20260213071042.3733239-1-lulu@redhat.com>
 <CAK3tnvLBSB=sKKwjMai5Pw_AGq8sLzuaQkEoonJ-AaHgn3EwVw@mail.gmail.com>
In-Reply-To: <CAK3tnvLBSB=sKKwjMai5Pw_AGq8sLzuaQkEoonJ-AaHgn3EwVw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 25 Feb 2026 13:44:22 +0800
X-Gm-Features: AaiRm52cPAlVsQxaodvttpaw5WyIyyKO-J5QqbZ4KOpWDll7PaWqHw80wqDANKs
Message-ID: <CACLfguVUOaMJn2nQpbnnh1kxsPTpKhhtuvdQcbe48nt6V1VNPg@mail.gmail.com>
Subject: Re: [RFC 0/5] net/filter-redirector: Add AF_PACKET support for
 vhost-net
To: Zhang Chen <zhangckid@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On Sat, Feb 14, 2026 at 11:05=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> w=
rote:
>
> On Fri, Feb 13, 2026 at 3:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > This series extends filter-redirector to support vhost-net backends by
> > introducing AF_PACKET based packet capture and injection.
> >
>
> Very happy to see this series~
>
thanks :)
> > TODO
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > This series introduces basic support for filter-redirector, enabling
> > simple mirroring of VM1's ingress traffic to VM2's mirror port.
> > Additional functionality including filter_buffer and other filter featu=
res
> > will be added in following versions.
> >
> > Example Usage
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Primary VM (mirror incoming packets to secondary via chardev socket):
> >
> >   -netdev tap,id=3Dnet0,vhost=3Don,...
> >   -chardev socket,id=3Dmirror0,host=3D...,port=3D...,server=3Don,wait=
=3Doff
> >   -object filter-redirector,id=3Dvm1redir,netdev=3Dnet0,in_netdev=3Dnet=
0,outdev=3Dmirror0
> >
> > Secondary VM (receive mirrored packets):
> >
> >   -chardev socket,id=3Dred0,host=3D...,port=3D...,reconnect-ms=3D1000
> >   -object filter-redirector,id=3Dvm2redir,netdev=3Dnet0,indev=3Dred0,ou=
t_netdev=3Dnet0
>
> Whether the receive side need the same setup the  "-netdev
> tap,id=3Dnet0,vhost=3Don" or not?
>
> Thanks
> Chen
>
Hi Chen,

Yes, the receive side still requires the -netdev tap,id=3Dnet0,vhost=3Don
setup. I will make this clearer in the next version of the series.

Best regards,
Cindy Lu
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> > - Tested with vhost=3Don/off TAP netdev on x86_64
> >
> > Cindy Lu (5):
> >   net/filter: Allow redirector on vhost backends
> >   net/filter-redirector: add in/out_netdev properties
> >   net/filter-redirector: Add AF_PACKET sockets initialization
> >   net/filter-redirector: add AF_PACKET redirect datapath
> >   qapi: add in/out_netdev to filter-redirector
> >
> >  net/filter-mirror.c | 460 +++++++++++++++++++++++++++++++++++++++++---
> >  net/filter.c        |   6 +-
> >  qapi/qom.json       |  19 +-
> >  3 files changed, 459 insertions(+), 26 deletions(-)
> >
> > --
> > 2.52.0
> >
>


