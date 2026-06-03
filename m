Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B635CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUhX0-0001sX-EK; Wed, 03 Jun 2026 05:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUhWw-0001sF-Mc
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUhWu-0005s4-UR
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780477492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAaJMLzG2mctD1z2/ag4tmcQSgff6KP9uCpYi97ZxsU=;
 b=W4GqJ6XdcsbPBWLJYIYCSqiQHkZdkmr44P88OD7a7ftmZBGK7xOhMeGt84mbcTW2Ccs/rX
 cjgiwI8hkXaSOOc3KJTGR57P2SoTShCpYew8ZZogau2NBV8NgmqiJ5VWndrojTLRtyWmXd
 YF/E0cU0PVnbAk8kCzWLPaVjC4PBvfk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-4cGplEf6PAunCEt48JridQ-1; Wed, 03 Jun 2026 05:04:50 -0400
X-MC-Unique: 4cGplEf6PAunCEt48JridQ-1
X-Mimecast-MFC-AGG-ID: 4cGplEf6PAunCEt48JridQ_1780477489
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef3aeeb41so3017961f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780477489; x=1781082289; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JAaJMLzG2mctD1z2/ag4tmcQSgff6KP9uCpYi97ZxsU=;
 b=nQN5FW7ZKoEW+HXj3fYXIAeeSRaj8XQy68WI5/O5bszdVPFt02wIxz6YcQFSBy2hQD
 lJnV9beNskMzk4Mke4YJij+MPFOVGYOc9ztr+HPUyC10xwpcDi5I/cmyh9qqL+gojkod
 UO8MiIZy8S0AbzG/uVELf1pC/zZNO9ETbhbi7YijlpuhLIJ9K7KGjHdf0ciMve8xDi3A
 cpkt6N7SLWQNVLGrFfs2OWTzYh4ytJ86QeQIwvGOeJ1Afks90krngyRZw/Vk733Cl36F
 l9dkOAu88Lerbrxje0oIEyrIHBukDgFDWW85OvfbSo9TXt42HwCNFZipcgdgVzqnM9N3
 e6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780477489; x=1781082289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAaJMLzG2mctD1z2/ag4tmcQSgff6KP9uCpYi97ZxsU=;
 b=dcKI6NQpsQU5nz9n6eLfnQQQG7KKYpY/a4VOXrgEtPHnb0eZIeKD8dJ2MVq/EvZ0fW
 2PI5vvCG04rTG/qQgjpsQG63OV/wwxREeeT3CrEoOQGrMqyo/M4G7OD0lU+WVb+C2MvF
 lNuU3bC39K+GkMGOwCKxmN5pP/GTwKAJYn5m1qhSX4/rxwE2ipXYC3dXa84MJ+vgBulB
 t5Y7bHMthTPx+ZoNfTohXsk6qj/IcQgF7ero2G+OxFWdidDaJiE/bYocEKlltNdALkfa
 oJFvcow4/RIvGrD1gaeoqqur2lml++9t7RjRoeR7y7netxKaWmVFEkp9KeriIUynQjcF
 bWvA==
X-Gm-Message-State: AOJu0YxuMPRwozuhpGZfFhKii9P4JzHpBH0VjlD+zrSjBw2964E5JRoM
 sUFZI81PoI0EPwgeZz5pRLOSaowqEOVbrmH63bRbLtpLO8KiMXoGGtLiBA26e+NV3upDYAUtJlg
 J/KDfugDWaOjCngEdM5gd9If0j0RJ26zHK/Lz8thmhiTxSbdn3Jmd7TKx
X-Gm-Gg: Acq92OF58sW2sEiEADz5bswkXOptOn6tSKTg3u0vbGv81hf+UXh2coZLnh3GaSUGE1p
 odNQI/2ob16QSxZJWwKI+FY0Ea3SmftkeOENWdQ/lLmcN8PEbkwIjdzcG4EwBiAwsQKq1oLKRJ/
 sveKR7+0G8/lSmFcfSpN9aY3ohVBlrQiSxOptc+3nm78+IXOsinBEAtuBpnV1vZy29k3DeeayS0
 tRPveLi9Jng6gvo5VAngMSuOPCSXqYX765mX3ZXOMLIQU0y8kt3GXvS9GKhKvVQu+nN2sixo1BT
 5lBcE1kA0mCT6LJa9/TJ5a7VmI/HXrDQTb4dnt/GDY711c8NGuZDq17NWeal/+d4xdrV5x59PNN
 NW5wD7JQ6fXZ2WJhaOE4z2q4L8rarPU0i+E05pQ==
X-Received: by 2002:a05:600c:871a:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-490b5d3fd8amr41710425e9.12.1780477489504; 
 Wed, 03 Jun 2026 02:04:49 -0700 (PDT)
X-Received: by 2002:a05:600c:871a:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-490b5d3fd8amr41709685e9.12.1780477489011; 
 Wed, 03 Jun 2026 02:04:49 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.118.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7a273e3sm21745225e9.0.2026.06.03.02.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 02:04:48 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:04:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 hreitz@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 gmaglione@redhat.com, Jorge Moreira <jemoreira@google.com>
Subject: Re: [PATCH v2 1/3] vhost-user.rst: clarify when rings are started
Message-ID: <ah_t8NHf4pYDPO9c@sgarzare-redhat>
References: <20260519191548.335082-1-stefanha@redhat.com>
 <20260519191548.335082-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519191548.335082-2-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19, 2026 at 03:15:46PM -0400, Stefan Hajnoczi wrote:
>Jorge Moreira <jemoreira@google.com> pointed out that the ring state
>machine is underspecified. In the discussion that followed, we
>discovered that the spec says one thing and implementations do something
>else. This patch updates the spec to reflect how things are actually
>implemented across widely-used front-ends and back-ends including QEMU,
>crosvm, rust-vmm, and DPDK. Do this while taking care not to make any
>other existing implementations non-compliant by changing the sepc.

s/sepc/spec

>
>The spec says rings are started when a kick is received but the
>implementations actually start rings when VHOST_USER_SET_VRING_KICK is
>received.
>
>Reconcile this as follows:
>- Clarify that a ring can be stopped and then started again. The
>  back-end must resume processing available requests when the ring is
>  restarted.
>- Update the spec to say rings are started when
>  VHOST_USER_SET_VRING_KICK is received.
>- Ensure compatibility by saying front-ends SHOULD inject a kick in case
>  the back-end strictly implemented the old spec.
>- Avoid future back-end dependencies on injected kicks by saying that
>  back-ends SHOULD NOT expect a kick to start rings.
>
>This way implementors have clarity on how things work while still
>allowing compatibility for existing implementations.
>
>Reported-by: Jorge Moreira <jemoreira@google.com>
>Cc: "Michael S . Tsirkin" <mst@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> docs/interop/vhost-user.rst | 26 ++++++++++++++++++++------
> 1 file changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


