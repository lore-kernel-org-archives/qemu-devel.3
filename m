Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B91CC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 08:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR5eF-0003bf-PO; Mon, 16 Jun 2025 04:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uR5dw-0003Ud-Hq
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:56:40 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uR5dr-0005W0-5m
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:56:40 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-311ef4fb43dso3279197a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750064191; x=1750668991;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C2uHd7v1UByo4lKxNhUb3/p+iFkaDqAFwuEJ5rcw1CA=;
 b=AyWFVcJeBaVH1E2JqGA8txxT1P9TTgU4WyTED2Y6ntnys45Abj0hvowW7txeTAtUhv
 hVnKRPmj2KKclDyF10OSKxUXIBO3B1UpuNI6f49KDsVic1LE4cR+a3cp3Dn4ctRHdGs6
 YTNfxy1JFdQ75lbFIyNScx3/oIBAxwO/2m1jJfQ6gbEvpist+4+rj8AyrPCjE/qPgVUC
 GIyiESvR6bpVooB3MTB8MLYAFhl3NUcyXp5ut1cw/t9wiJ1jffz1sCsG/zPeHZ/K2MDH
 CIBBgdQXNk9UWUUItBeaS3drm0URWb+JO6qsimdxuDlrUbXz+aaJmBy1jBZK1zUqjJq8
 My/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750064191; x=1750668991;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2uHd7v1UByo4lKxNhUb3/p+iFkaDqAFwuEJ5rcw1CA=;
 b=E5yeYfZrPXSVeOJkl7FK9er93Ja0CWW9pvJipMkNqUeR1kVMI7KDB/B82y3ZHf+GQQ
 tdU/VrJV/fjn22HQ/qJwW7BY89MmT/C967c81fIMzvE+m4JYVx2lVYsNrTRHcowYjz59
 tRZMmv+ukew3RE0SsIPAAtmigR4R1qJnM1NXELN7Zi+wZoNRbZBxtIHPpLMYUo0Ge8vq
 6KbuOnyqjpH3zHI3ECVPjPJa8JvbL+aAm3RtEofXVQfL4kL1JaGxqOmpRYz9sHCoXT3f
 MEeMpC8Rs2iUrnExFtra7op4lXNR+LGPSPimy+coy+pedi1rSxyrfmccXJs6I5wRb2kQ
 w6FA==
X-Gm-Message-State: AOJu0Yy/E286vyiaztbrX3kl94vLlSC07uhuH95mNqYBc7OLK2OQaI6J
 zChwiHWdbU39JOZku7Qh58xOrR/c9zhM0XviS4AwcAX0ZlL5DFXOwDbPtKdKZpF4LdY=
X-Gm-Gg: ASbGncvByp5mLm/hY6mBSH0KGjxcKWQyh9JDJHSeMzlKHkPBsbelzvsbcDsN8VXSVLL
 2IFWwBc5Pq3VoAq30TSw9/SpyGd7WzJHkJFxw2GIpC7/fR8VQMkteJyLUXvronx8mMclLuuSVFH
 872e9yV3Y+A6s4Ec/jt/1djyZUxytxaet8YgQ4Z+pGcddXIQSGx0JnpvGJghNeIZNCTYrZxwnOg
 adW0WgbQPslLORFHy70LUAla2QSM9YiBV2VHESKkfXrnur/hq23/e7Chw0fMoRs/gcT2H6ee1wW
 fRxhANe4ouVtWsgdA2lLbKpComwi0jTFcnG22+JAZDNVSVfO/OekYw5VcKKaeEKisHeD4tjcmZM
 UPmcmlYQnw6zrwQPt3fLIlXqL
X-Google-Smtp-Source: AGHT+IET2pUKxhmPf9A8LUa4wnG3bwQGcs3hbTVRxTLNsaQyuBirXx2QczcyoRVzG22+ht2n/vZTVA==
X-Received: by 2002:a17:90b:2243:b0:311:9c9a:58ca with SMTP id
 98e67ed59e1d1-313f1c0355dmr12742408a91.8.1750064190652; 
 Mon, 16 Jun 2025 01:56:30 -0700 (PDT)
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp. [133.11.54.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1c5feebsm9107390a91.41.2025.06.16.01.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 01:56:30 -0700 (PDT)
Message-ID: <eb5a3fc7-b6de-4a16-b841-03478b50d397@daynix.com>
Date: Mon, 16 Jun 2025 17:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] vdpa: Allow VDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com
References: <20250614224422.1595301-1-kshk@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250614224422.1595301-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/15 7:44, Konstantin Shkolnyy wrote:
> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
> "unable to start vhost net: 5: falling back on userspace virtio", and
> VDPA became disabled.

Please add the Fixes: tag to refer the commit; see:
docs/devel/submitting-a-patch.rst

> 
> Convert the VLAN ID to LE before putting it into virtio queue.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   net/vhost-vdpa.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 58d738945d..99c9eb42b9 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1173,9 +1173,10 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
>                                              struct iovec *in_cursor,
>                                              uint16_t vid)
>   {
> +    __le16 vid_le = cpu_to_le16(vid);

docs/devel/style.rst says:
> Don't use Linux kernel internal types like u32, __u32 or __le32.

It's unfortunate that QEMU lacks endian types and a checker for them; 
such a checker could not have caught this particular case, but can catch 
other similar bugs.

Regards,
Akihiko Odaki

>       const struct iovec data = {
> -        .iov_base = &vid,
> -        .iov_len = sizeof(vid),
> +        .iov_base = &vid_le,
> +        .iov_len = sizeof(vid_le),
>       };
>       ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>                                           VIRTIO_NET_CTRL_VLAN,


