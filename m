Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E7DC55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrnt-0001x9-5R; Mon, 03 Aug 2026 08:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrno-0001wa-6z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrnm-0002T0-TW
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785760194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmN2Y/7ZeBKHjtIw5m996fudj11ti+C+v1YnO949IzM=;
 b=DJBr2bqaTKk05MDzD04ihIyCY5Q9mF3ML3rAFgPJjKGOeqo6b4qk31CJdwoTFg7PvUdbeq
 Dl+OZUnhaRdkUTcngDkawDTsPcKZ81P80UJGkHaxjtyEB8epxnU+LSoeHnyoYoL1TXZ/DQ
 YwfCZSP5qx9Z7zvI8x1PM4YMQkRlwv4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-rGSJ-EFFMDGkgm93DyavYA-1; Mon, 03 Aug 2026 08:29:43 -0400
X-MC-Unique: rGSJ-EFFMDGkgm93DyavYA-1
X-Mimecast-MFC-AGG-ID: rGSJ-EFFMDGkgm93DyavYA_1785760182
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49554715277so19126685e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785760182; x=1786364982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TmN2Y/7ZeBKHjtIw5m996fudj11ti+C+v1YnO949IzM=;
 b=D5hN7nQTyGKmlv4u9jVcA/gSnkA/E8u11abl8ZkDPLyeg0EOMpiPJ47eTkRISXL6Y/
 +ZuFD1kzhDghaenC/QP2XTUE2ugVrvRQlKzYDyKcwgVjLnQGUuugy9Y39+zwy/7MJrEu
 eEZWsANt2bEnR7QBahzT+sh3HA1Wn8g8uplP9qNBVFC+IwPfXJkfkCRopjqgPnWBHdlY
 l6KkPMbdSuPXntyTMqZu3JwYDABBWdreZcC2mK+MUmQrpBriTR5aF217Apjtvy/fBfK+
 aOVyCBGnwTxKb4UcFTTmT02d4bPmHUh5UaWVXxbBfGCzQ5VUeGkmrl8S9jor3SCGIdBK
 4QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760182; x=1786364982;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TmN2Y/7ZeBKHjtIw5m996fudj11ti+C+v1YnO949IzM=;
 b=XxGdKSgLULDKmxOEhwoQ4MxItPwmTx75vv2/fLfDsGcX7LOLyzs9uyJe89Cg4GXctd
 kFOVbyXcafb2iwprPbKqBN1FtOQ3LsgeFeJHbXP8JgZog9A3OjqAHbeKp4xR0Wb1j9/r
 uxicD/6Z9UJPA/YTuchYrge6pytaEI10VB0/zb8hdJLopcckmakVstfxb3cXJXptIoln
 azp/Hxaq0zoI319u3zCYY2libSoBwPwCDoldpeQl3lPEffZlpS4ZLFJuxM3ebjgVTEGb
 eTGfL9yvSjeLx7IkJtVPsL3M2vDsa6OfDvklxNCmWPN9mTtvmCip0tKjB68y7DBhjyKJ
 hoTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RosFFWtggTcuYr+OtKxK1QprcNBMDbP7HkAuRzxi9p0bYG6cQ5zgJU8ablIBFd3w8yux8U/3X42BxdG@nongnu.org
X-Gm-Message-State: AOJu0Yxc3YB+DuTWJbVFWbhiQ1d1ZDrmgDrg9smugqXME7uAl4Mwp9tb
 bJWm9wH9miIzWS1i3pOsyam3mWEvp8ydMYhKDTWHEFYw4yAfFRNxRJOqD4ilmDwiku9f/TEBuAZ
 D/k9MtshLQJ3QKSguiwgr0wQsfXvpyFF6UWmGtyWhcmArNlnsQfXeoDUk
X-Gm-Gg: AR+sD11A9FWBz8oi+qw4DURTuEurnSJw8YslC9v7prWooJQLYF8fsXDUg6MumXYPRni
 jCMKjc3+EYLjFIkTD7F2esMt6HCdg1dKwwMvricI6reYInxDwHHidAyMP5AqtsT5dljwqhr3nwW
 is1Gomq97hmSOm7mm7uhChb1VFrRu5zaO2vckeGz7YdM6DRos4mIqccZnIWfJzplx1tzEB8mcR5
 Be87iIRMgrnDtyrWZbWJmKXxC0G6njxP7qCsyhlHA543TuyTd6q8yEFC+GPPBHyUmSzO7jylE5a
 9VBUi6DTPDiYfwUmTQC6E5iLWCIBSKOUmiKGuWGtIW8yNEhp8ZExRfeOeyQFX4wl24nwHu6kDGl
 CRzpGM/69mmQ0Hx4o7fqetidDjEH0NlVpbcRSr8gTURfZchjbau87dDgngsTKpMjhuKDW0knNR0
 A8rs4mi5efCozYeIDuw+Y8qQFZ89dCKQ==
X-Received: by 2002:a05:600c:4fc5:b0:495:4e1d:82df with SMTP id
 5b1f17b1804b1-4980f233e12mr221917115e9.10.1785760180150; 
 Mon, 03 Aug 2026 05:29:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:495:4e1d:82df with SMTP id
 5b1f17b1804b1-4980f233e12mr221915055e9.10.1785760179048; 
 Mon, 03 Aug 2026 05:29:39 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b5f0c3sm205973705e9.5.2026.08.03.05.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:29:38 -0700 (PDT)
Message-ID: <e40ea812-8774-46c3-aee6-511c6fbd07cc@redhat.com>
Date: Mon, 3 Aug 2026 14:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/15] vhost-user: add memory_isolation to
 VhostUserState
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-5-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-5-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24.07.26 00:30, Connor Kite wrote:
> Add a memory_isolation bool to the VhostUserState struct. This
> bool is set within vhost_user_init(), which takes a
> memory_isolation bool as an argument.
>
> Refactor all call locations of vhost_user_init to include the new
> argument.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   backends/cryptodev-vhost-user.c     |  2 +-
>   backends/vhost-user.c               |  4 ++--
>   hw/block/vhost-user-blk.c           |  3 ++-
>   hw/display/vhost-user-gpu.c         |  3 ++-
>   hw/scsi/vhost-user-scsi.c           |  3 ++-
>   hw/virtio/vhost-stub.c              |  3 ++-
>   hw/virtio/vhost-user-base.c         |  3 ++-
>   hw/virtio/vhost-user-fs.c           |  3 ++-
>   hw/virtio/vhost-user-scmi.c         |  3 ++-
>   hw/virtio/vhost-user-vsock.c        |  3 ++-
>   hw/virtio/vhost-user.c              |  5 ++++-
>   include/hw/virtio/vhost-user.h      |  6 +++++-
>   include/system/vhost-user-backend.h |  3 ++-
>   net/passt.c                         | 13 ++++++++-----
>   net/vhost-user.c                    |  9 +++++----
>   15 files changed, 43 insertions(+), 23 deletions(-)

[...]

> diff --git a/net/passt.c b/net/passt.c
> index ce80186883..a3021f37ef 100644
> --- a/net/passt.c
> +++ b/net/passt.c

[...]

> @@ -735,14 +738,14 @@ int net_init_passt(const Netdev *netdev, const char *name,
>       s->pidfile = pidfile;
>   
>       if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
> -        bool memory_isolation G_GNUC_UNUSED = false;
> +        bool memory_isolation = false;
>   
>           if (netdev->u.passt.has_memory_isolation &&
> -           netdev->u.passt.memory_isolation) {
> +            netdev->u.passt.memory_isolation) {
>               memory_isolation = true;
>           }

I think this part of the hunk should be squashed into HEAD^.

Hanna

> -        if (net_passt_vhost_user_init(s, errp) == -1) {
> +        if (net_passt_vhost_user_init(s, memory_isolation, errp) == -1) {
>               qemu_del_net_client(nc);
>               return -1;
>           }


