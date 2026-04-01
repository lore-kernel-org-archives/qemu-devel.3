Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0635A10F931A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 02:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7l8G-0008AQ-8m; Tue, 31 Mar 2026 22:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w7l8D-00089h-UK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w7l8B-0003i5-SL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775009788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7Z6BeXDqeloNLrA68vfCRm9cKw9oWj1NwuleHUqRbo=;
 b=ZMch+N8KUuYnw6tjIcOtGnaTbkoFsqq7Y8aQiltVSG4iwe5f6gbsQiBxHp8d+kA4RtnXdd
 n2OOJe2niGpAzt+Bjs6gKNUF85LBWU3pF27CBrriW2RGb3BWlM23e8fyGbaMezsAHPjBzO
 acflwC80ZwFYOuvWXacuqNwOEgH6vAI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-L2xyReWpNyWdLufTVYixoQ-1; Tue, 31 Mar 2026 22:16:27 -0400
X-MC-Unique: L2xyReWpNyWdLufTVYixoQ-1
X-Mimecast-MFC-AGG-ID: L2xyReWpNyWdLufTVYixoQ_1775009786
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d96923dd2so4120254a91.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 19:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775009785; cv=none;
 d=google.com; s=arc-20240605;
 b=lZozPQv/JO6Wo9Oe8IyfHxFVUbd+SI9mgY0i2WtNy4V0CvjXwz8TtkJS8duSq1MLaF
 Iuv63xsgLoEScqPJr0SoB4yldSH0X2zRuul7mQyf8p8aA+gr63DsgMa/OE7iPvrH+R+c
 nwD+3kMGE5KenFarhAGf3+qgaSsBTXddkjzdGgEy+6jAPg00393XnRDbB1cxjbxXmucq
 hlWW1teY/Aeio4nJ8BZv8/WrjULN5iwwjS4+spPB0bim9llmVvoHe0o/f7iNKEo2Q5wC
 tL/XDGUm5oYTWdgTja1QkgfFLoiNju/NQqoR+T+EoMK3MwATCPN0wLvRbk0Gt3Zbm/iK
 bhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t7Z6BeXDqeloNLrA68vfCRm9cKw9oWj1NwuleHUqRbo=;
 fh=tpcfcJuMAWL5z53zFlZFkXK+/+6MRK4WyOv3giIXcTc=;
 b=S9s3j+EfJ2t/V3aQC4a9b7YN3WfLFNoIHfw0ISgn2a2FJs9g1ltfve9UoSpGI7rm9y
 bT/66PVNhVcNgyIoeSQpyQynPHa+290u3pxCylkovS6pmjuk4wVqghCpJDVDF68qtI5W
 2GoD+7qK3VyCeDd3gyb5BAVnMiHOxenYuorWqZmd3HEDuDKMeurrapbTOPelYZpwsje6
 oJUsOjzO9hj2AAbrUWbYFbzq/IpBY32yMlxNLeUheaIJymGPwDQ3oKwtzbnGUNJYBpPy
 INiYYfaSSb6NlgS6reoySRoKufMWUbGdjr4PqkNwhhrQmSKE8TutF2+2ycqoN9rWQ8p1
 rBSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775009785; x=1775614585; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7Z6BeXDqeloNLrA68vfCRm9cKw9oWj1NwuleHUqRbo=;
 b=ALxxoQiJKEms03Bpor6TLtPCGoHS4Drh11/4LQ3k/geNZYuyT+FgkxGzd4VleCmqsc
 S0B1gLcf99digclZWBUL7HSFArF6k+VGxQwcN5Qn2AzipZicl9YTzWPqkY61MX7JRkNU
 T/eFQHwbPQ+Mz8qrfVjAac+STf+WrSpFy2tw4oiYFt5jSnNn5XJRiBUTfDnOAdnm0LIh
 kgwQj/AH6RzA0OYJ6ew8jVzSgX6WOoyPM3ZaGckw08PAVzFXHqqk/O78fM4siF1rioy7
 7Cp1PY8iFpXykeOwNG3LFwjectjHklMZLvrw6hRSKEzudBbJwdHQU2g73BBtaO09/m7N
 2Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775009785; x=1775614585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t7Z6BeXDqeloNLrA68vfCRm9cKw9oWj1NwuleHUqRbo=;
 b=ALUna64lFjfEmtETVbO2NJw3niaxr2wDacrWdA4J/hPX7a3dPjFL+ZYB3OSrqZSgbL
 5jxKy/SJd35Sp+31MDuZLC4ouFQ91rKQLz3pSTaS2hv6SFs0DN7AeO9e09rQiAdlC5Nv
 Wf8Amaj9hFnrn7e8rZF18wdEqySPKGWAhrrI8qqvKtwRZijBk0ddHckO/R+g051tFfnC
 gGpHaeuM5zQSDqWWygesR4FPSJK+r2kLXGFYOrJoZVyPyAIARdQ6tMUdnzjop9Bcp5N1
 3m9JUhE5By+3/gIcb/m9hg3S7a+nTI1tYEE8mOLYz/MAqa3+1mhxmtxtSYL54oDKCOsp
 y/3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSXIGPByHIXG9Hl5/8UHyEJA08I+53zSM5Pe1oStEQTEQsVbovoNnD5jxgds59ilVbO4EYi2DxL3GO@nongnu.org
X-Gm-Message-State: AOJu0YwIABQtm8Fwp0ntKXhZP0cl4vf8pNBl3HXnOPADPJGGb0v6PbA8
 22SGL0RcI6h9zMwXobhbauToVq6NbZiDO1pKSns2MarTilH+s8tFJBj8KIjB4Dg3knE6ISHX7ev
 XO3+Xsi9AMab+SqaP/dqK+l938Wn4BvaqWEbeTVltVPT1h/jbUjYOX3ZjuVUODlDGM5GHQxaLEU
 d69+cbQvolMKLU5AQuM0buPRAMGB1F29681HfaFzY=
X-Gm-Gg: ATEYQzxpFKMyVDW6q6a+TP6aZonsJp8PnbT/IRig3oc2UbYTJFiSeIH25qVbva1Bwu1
 fb0wVM7PKFMGTZQW2eaBcdLpQBc3qDkgBdZmDmgC2tDJ2q7qLkzujn9VbZSLhLXW8rX++F7n6Pe
 lArUDBaBF5P0vuPPWgSWqjH21Qv43QSBfG2AxOy2DfUbxpVA/tsnNoItR9BLiIasBvEyGpglSuq
 1sdHDw=
X-Received: by 2002:a05:6a20:918b:b0:39b:8dcb:f36d with SMTP id
 adf61e73a8af0-39ef7685d8cmr1637551637.35.1775009785200; 
 Tue, 31 Mar 2026 19:16:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:918b:b0:39b:8dcb:f36d with SMTP id
 adf61e73a8af0-39ef7685d8cmr1637516637.35.1775009784655; Tue, 31 Mar 2026
 19:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260330090944.1008027-1-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Apr 2026 10:16:13 +0800
X-Gm-Features: AQROBzBhW2nWnvipxvxem1wu-YJoj-u6rfkd1NFb25Hq56BWFGZMR55-84DLKp4
Message-ID: <CACGkMEvAVEYzw29h8BZLz3BD859pKmCkYG8xdowdpUrNv05gQQ@mail.gmail.com>
Subject: Re: [RFC v3 0/7] net/filter: Add AF_PACKET support for vhost-net
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 jmarcin@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On Mon, Mar 30, 2026 at 5:09=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Hi, All
>
> This series adds AF_PACKET-based capture and injection datapath
> support for the vhost TAP device in filter
>
> Example Usage(not change with exist upstream code)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Primary VM (mirror incoming packets to secondary via chardev socket):
>
>   -netdev tap,id=3Dnet0,vhost=3Don,...
>   -chardev socket,id=3Dmirror0,host=3D...,port=3D...,server=3Don,wait=3Do=
ff
>   -object filter-redirector,id=3Dvm1redir,netdev=3Dnet0,outdev=3Dmirror0.=
..
>
> Secondary VM (receive mirrored packets):
>
>   -netdev tap,id=3Dnet0,vhost=3Don,...
>   -chardev socket,id=3Dred0,host=3D...,port=3D...,reconnect-ms=3D..

Is this for packet socket?

>   -object filter-buffer,id=3Dswbuf,netdev=3Dnet0,queue=3Dtx,interval=3D10=
00000,status=3Doff.....
>   -object filter-redirector,id=3Dr1,netdev=3Dnet0,queue=3Dtx,indev=3Dred0=
,status=3Doff,enable_when
>   _stopped=3Dtrue.... \
>
> changset
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> change in v2:
> 1. add support for filter-buffer
> 2. remove the in_netdev and out_netdev for AF_PACKET bind port, now only =
use netdev
> when the vhost=3Don start use AF_PACKET to capture and inject, when use v=
host=3Doff will use
> the existing code
> 3. add CAP_NET_RAW check
> 4. address the comment
>
> change in v3:
> 1. reuse the exist Capture/inject process
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> - Tested with vhost=3Don/off TAP device on x86_64
>
> known issue:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. compilation should be disabled on non-Linux platforms.will fix in next=
 version.
> 2. Sometimes the secondary VM receives duplicate packets. will fix this i=
n next version.
>
>
> Cindy Lu (7):
>   net/filter-mirror: keep mirroring while stopped
>   virtio-net: keep tap read polling disabled while vhost owns RX
>   net/filter-redirector: add AF_PACKET netdev setup helpers
>   net/filter-redirector: add AF_PACKET capture path
>   net/filter-redirector: add AF_PACKET inject path
>   net/filter: allow filters on vhost TAP backends
>   net/filter-redirector: check CAP_NET_RAW before creating AF_PACKET
>
>  hw/net/virtio-net.c  |  12 +-
>  include/net/filter.h |   6 +
>  include/net/net.h    |   6 +
>  net/filter-mirror.c  | 379 ++++++++++++++++++++++++++++++++++++++++++-
>  net/filter.c         |  17 +-
>  net/net.c            |  10 +-
>  6 files changed, 417 insertions(+), 13 deletions(-)
>
> --
> 2.52.0
>

Thanks


