Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A35106FD84
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vf9-0004D0-FK; Fri, 13 Mar 2026 02:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w0vf6-0004Cf-9r
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w0vf3-0004Ze-26
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773381969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhzV9RMU0DOo8cMzQc4kn8JYBVbKDci0wwGdUszBslI=;
 b=Q0hYyYBJPniYdzNWYpA6LgZ8WW6yorywPRn8Iz1/RaBfMlXAlY8/a7oB/4mCdPVgbECsTU
 Ey+1tYD3NnJd/QYJT7qkkeyKstTJrDI57EhCZjDy/kWiUwH3NkfPBAWFQp8kbx1aUvPA5D
 q87CbLxwBNiy9VTIi1dNs8C5PvG5nLI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-QY4gOgErPI-MXP4536WchQ-1; Fri, 13 Mar 2026 02:06:08 -0400
X-MC-Unique: QY4gOgErPI-MXP4536WchQ-1
X-Mimecast-MFC-AGG-ID: QY4gOgErPI-MXP4536WchQ_1773381967
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c709551ec08so7752329a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381967; cv=none;
 d=google.com; s=arc-20240605;
 b=PDGuKn5wpW1+MNhsIsgdR8t73b7LKx4p71wy6J/X0G1S/0NdxoQm35BOltRty/Nomy
 3Xh62DZGss8Yldsu2S18Fe2ipM3XIoCNQesUO/VOZtqMqNEkmnRSxY20daTxqf+/B7lx
 C23KI7uMWlQKFcNV2z5dNQstEMLhvtbbQz03zBFsHoNv7h6ItIfgujchEr6dnBvKg4uF
 +7Mp8FZKISM5Z89zFBNYSD6q0GmjhffxzsIthrBGiS2inNrKgyS6GFAEREZCt6q2WgUs
 fmNl6HHoz+Xp/djQNxwkXedJCxjJA5roFOCpEAhTI45LxmNruyxKcDkXuMt7NMFHeKMN
 jf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lhzV9RMU0DOo8cMzQc4kn8JYBVbKDci0wwGdUszBslI=;
 fh=VwT28jWmeA+ns0OgpQBdaCKyaTC2rbcdKL8aDCyMELE=;
 b=ftI25aFJBVg6qlN9O9K3E4JB47vDIO8smP1qwP3/TIezpCDPyvJ2Ri+125mcTO0cuM
 WADjT2+UENlFtOePOMVlpyS01cS9xqr72X6bd1lp5dF5ETvpOkKKoUzV98iTzG746Po8
 zf+jlrf+QvFr+i55A/ZDoZNAZSOdpp/j5FZfBtvC7r4fELJW8aG2DzTdk6r+s9V1ldeF
 B2sWE9WPDTt2xVVpnyzg+bgSCSnIeL8VzlZwoBf/AutRFVSRH2obHtohfhAwkLd/r2qo
 oLycTpXLeGR67QnNf6y2n4jiEIpNcYdG/5gpSZHIOqRZQxNSJC5RImrTd0yftZR1GaMO
 fp2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773381967; x=1773986767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhzV9RMU0DOo8cMzQc4kn8JYBVbKDci0wwGdUszBslI=;
 b=otuV6OKl9WOt0de3ORmdkjRDfvGmdtVOGPky7QXzD3SyXFRa7TzoCN7PJ1jiRFfYJ2
 62e25rLUHUEmVhE2+3gHOdzEhcrQjKCEqo4R0l1IJPGTMWZve7138URAqXnqPlyk1/gQ
 9+klTsV6EzuEHJPYkJEXEPvaI+oVEequR0ItfVZHRJdgdp4yiJRgp1sfOyhariGfyHkB
 eIOts2zXdUIobq5dIelgmw3P0VB+N47RFRNbupQ+R0OFEx14e1x+hXSGr72gB4wdBv0Z
 a0OuIuF+m6At1BNH5scXqY0b1e+Nm5eMtyzGJkpOy5I2saeacgq6UIKDZMpjTyBT3ezQ
 kVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773381967; x=1773986767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lhzV9RMU0DOo8cMzQc4kn8JYBVbKDci0wwGdUszBslI=;
 b=TvrLMbdQIOiqnQySCWpRBZqeqOyjEBfm00VbLROXnKrsHB+j0hOW3nmNfAX60jdaJS
 bEVZyAky6FmLSxc6I6l6mudP48l4wPSdUMon7uIoUQGBlLuzdvkgfU6K+GBJe1ZiI/JO
 nsb4Y+A8ykxF5+aLJ70ZNe4jxlk8Wg90ZPbLEF8I7noNSnM4TxOnUkwfnTFfjt6xYzqx
 hv48OmJGjTgbWF+5x9kJwr9nyT8rZDMdBjgMi2NGeGM6DkglVl/pJBFjvVx+RPNGD9Yn
 gee0VviWgWlQHegAX34ETbzZdIpQs2knuPYgQ7o2dhNV0g/wkctHluz1CWRp+nfLxjdJ
 ecqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO0U9aX9tVajkrIeeW8kyd+FNyX5wMkp7M6Ou0GV4sO+aF6vK1o0cowQdN1xTxfm0HCigTRuX1IWfE@nongnu.org
X-Gm-Message-State: AOJu0YzTjQ1hGeR3eb+jcLKzB0V8N8tRUhS7iBZZlpIYrJWBNjku0R3X
 KoTNfjpp9D6VAgV6nvKdk0pENisVV/vY7kwwa4oZ65BIlN/CDMD2O/TgI4A9CiaVL+Y6Ynfxj3T
 SGjMbV8YOCehVyq82Gvr9Ugl9ORpaoXdj3Y7Sd7z+zq4n/B/z8oTnM5nUK9Siy9QEFObSANV9FT
 FIUVgr4IAbPqUskBGSoIyi4RXa2EaIqtY=
X-Gm-Gg: ATEYQzwoTpLhJA4qIixa1TdjCj7WL16D+HbxnKhym+q8Vjfw8dT5UtDNTSQi4Yf9vK+
 AyIOL80uYztDuBX0w6euvll4r3z9gOrMv3CAqI//FTGCQMMgnD8biSHeHv10Mlu/44ePCVEu+W9
 iAjOkeZ4wE/Jv087IIBE25UGIL8R55IZOMakVmCqQHMezJuBTdN9VnyxNF2gRkH8kmJzOIuxlnO
 BI=
X-Received: by 2002:a05:6a00:b47:b0:827:34c2:87f5 with SMTP id
 d2e1a72fcca58-82a1970453cmr1996075b3a.8.1773381966985; 
 Thu, 12 Mar 2026 23:06:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:b47:b0:827:34c2:87f5 with SMTP id
 d2e1a72fcca58-82a1970453cmr1996051b3a.8.1773381966452; Thu, 12 Mar 2026
 23:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260312071415.1836655-1-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 14:05:54 +0800
X-Gm-Features: AaiRm52JbLuwp9YdHR8zO9PM6b1t-ST5GGmm9BzcEgSyFOC08tDmU_DzIvRon40
Message-ID: <CACGkMEs5ggeUW5wzUkyppfc35B+dAr5RdnJ9RmypKHTVSBKwVw@mail.gmail.com>
Subject: Re: [RFC v2 0/9] net/filter-redirector: Add AF_PACKET support for
 vhost-net
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 jmarcin@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Thu, Mar 12, 2026 at 3:14=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Hi, All
>
> This series adds an AF_PACKET support for vhost tap
> device in filter-redirector/filter-buffer.when the vhost=3Don will use
> AF_PACKET to capture and inject,
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
>   -object filter-buffer,id=3Dswbuf,netdev=3Dnet0,queue=3Dtx,interval=3D10=
00000,status=3Doff.....
>   -object filter-redirector,id=3Dr1,netdev=3Dnet0,queue=3Dtx,indev=3Dred0=
,status=3Doff,enable_when
>   _stopped=3Dtrue.... \
>
> TODO
> =3D=3D=3D=3D=3D=3D=3D
> This series still based on tap device. The vhost-vdpa support is on going=
,will send soon
>

Thanks for the series. But I think I still have the same question as
v1. Any reason to tightly coupled packet socket into the netfilter.
Couldn'y we reuse chardev for that?

Thanks

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
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> - Tested with vhost=3Don/off TAP netdev on x86_64
>
> Cindy Lu (9):
>   net/filter: allow redirector on vhost TAP backends
>   net/filter-redirector: add role helpers for AF_PACKET paths
>   net/filter-redirector: add AF_PACKET socket setup and input handler
>   net/filter-redirector: add send helpers and netdev counters
>   net/filter-redirector: route chardev and AF_PACKET receive paths
>   net/filter: Add support for filter-buffer
>   virtio-net: keep tap read polling disabled while vhost owns RX
>   virtio-net: handle short vnet headers on replay RX
>   net/filter-redirector: check CAP_NET_RAW before creating AF_PACKET
>
>  hw/net/virtio-net.c |  66 +++++-
>  include/net/queue.h |   5 +
>  net/filter-mirror.c | 493 ++++++++++++++++++++++++++++++++++++++++++--
>  net/filter.c        |  16 +-
>  4 files changed, 551 insertions(+), 29 deletions(-)
>
> --
> 2.52.0
>


