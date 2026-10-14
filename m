Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A92CCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuis-0003v5-6C; Wed, 14 Oct 2026 04:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuip-0003ux-1v
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuim-000513-Jj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEtVA4noRtU6AurqpIJAE8olAdH8GjqriVHgruKxIPg=;
 b=g7A2s5FE+XmBOfqG6yLZLuo2Ys6gA1z1swIViYQ1EYTx8S1dOZRFMatwPvD1fA1oAssiDb
 n9PLBtmE+5kAjpzSWOC/Lu7GOdpInfNHr754gcLcyZL3Rlr4c+pKcEjMly+sqHfi6QLzCy
 TppT+4Oez6h9byXHamuZ1kbMA8c9Zyg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-HVmb_ehPPC-AbpuZMid-8g-1; Wed, 14 Oct 2026 08:52:22 +0000
X-MC-Unique: HVmb_ehPPC-AbpuZMid-8g-1
X-Mimecast-MFC-AGG-ID: HVmb_ehPPC-AbpuZMid-8g_1791967941
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so155092f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791967941; x=1792572741; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AEtVA4noRtU6AurqpIJAE8olAdH8GjqriVHgruKxIPg=;
 b=l65usk3wwWOim9M/WQtOD8RZE16RKer/0dR6qAMU0KtxWPrB/wrZblFnpQGbd6zXPJ
 V2JNYvXQBicNGuc4RT13SrUrluL4INK9Obzf+lhxXY8onB5irgU7zZU2qU5rWPp2t2rd
 fLAAUADFxrqv6af8HqcBFmIlzfjA3CRQ5CHegZHV1O8PnckpMvRTuPTE9j2Wx1Z01C/f
 hBv1ppXXr03zwBoKpm+f3Rro1AdLgkZQQm3UHgNxgc8b+llJwP4hQBqtikItOyCvYfDG
 65a6NINe+5b0hs5G9kpSV7XuUv3ETyAIKohCTr78NGnQoDcy1eQQk3o9gnPtL8Xm8rN3
 LQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791967941; x=1792572741;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AEtVA4noRtU6AurqpIJAE8olAdH8GjqriVHgruKxIPg=;
 b=ioYZ75cjniYXPVTWRtkelhnLPjnSLioHohk2/DGgo/CVyGMih9ieh/VGpL9cVJHSlg
 zhqviRraYAHVyjaF2PTk1H7RnAMTSWF3/6ZU1Z7ka3xAJ9CcJFssfoh1QOc9d+N0oos4
 cPY6y1o9x/n8DcvmlhWSWOFHIGBvBwksPzyuaw2vPB9nLxoMcrQVIbnrfHNcWJOubP2H
 f6Hx6R/hY47cmWj7drhSJfE4LTtic+YuVUQV/Sy0x4UP0jbVOvocjhiGCtAKTqckUepB
 GsOGQJMpAqeGAIo6J9Htr4YeR3PGvObDP+JK72G5zcOc23Og/3GH905Gc/Yjy1nybDos
 y9Ag==
X-Gm-Message-State: AFq9FYKlHIaX/YlYXE8EiX3H2e2qsusodgJzuO0Okrk8+s1od9LEu2yz
 vPgHiKtBrFICF3DQy6rpAdZFyGsGsACcEHGJ0QDDjlJzLHqPurZ7kuoh2cVNBaCX9JWUosLmshJ
 Nrit7YI2PSH0DKq64NNnm9HajfSHVqCf79H/QMY5o/SZEOkTxwvaIommJ
X-Gm-Gg: AYBFou1IHnERIP+ULU//nGe9NFND4NZO2GdZBwexGuPGyKunvlUxQAL0bFSaXy0zU8H
 rlAiMFvPBrPJCBFv1AsDZ5wKZsQlSH06iiBuf58tcLL6yCUHxJcqTmW/QiD+zlYrsbfjLs02bye
 kD3YRpaKq5itjYaGaAGphSpve//ICkeBVqMpkhYEhbYMYSVm8KS654GVTkElp0QLC6mBLJbw8te
 hHBPxvfBV+TCwldZy5RTxzKvirAzROTN3wPeReH3l2P198WNOA4XLLwKpNMsJWNks6juKYwKPok
 JJgRPGvUFj7xu+1gvZ++L41UAnevsSMnACDQVDgozpBbxEuGffOidWw9K/TSq97PQr9+ZTNt56H
 6vNfc3g==
X-Received: by 2002:a05:6000:1789:b0:48d:cbfb:d7b with SMTP id
 ffacd0b85a97d-48dcbfb0f48mr21313165f8f.5.1791967940866; 
 Wed, 14 Oct 2026 01:52:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1789:b0:48d:cbfb:d7b with SMTP id
 ffacd0b85a97d-48dcbfb0f48mr21313117f8f.5.1791967940415; 
 Wed, 14 Oct 2026 01:52:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.168.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaad1sm10235809f8f.17.2026.10.14.01.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 01:52:19 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:52:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 bchaney@akamai.com, mst@redhat.com, maciej.szmigiero@oracle.com, 
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
Subject: Re: [PATCH v16 18/22] vhost: release ownership on exit
Message-ID: <as9CsYcaJ7CBrpLO@sgarzare-redhat>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-18-36c38bd15ffc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-18-36c38bd15ffc@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 12, 2026 at 01:28:26PM +0300, Andrey Drobyshev wrote:
>A CPR target that has taken the device ownership in post_load() doesn't
>always reach vhost_dev_cleanup(): a target which has loaded the state
>but hasn't been started yet, e.g. one started with -S, may be quit
>normally, with the source being resumed instead.  Devices aren't
>unrealized on quit, so the ownership stays with the dead process.  The
>source still holds the FD, so the kernel never releases the device, and
>the source can't take it back after being resumed -> SET_OWNER fails
>with EBUSY.
>
>Add an exit notifier to each vhost_dev, registered for its lifetime,
>that releases the ownership if still held.  This covers every orderly
>exit.  A target killed with SIGKILL or crashing still leaves the device
>unrecoverable.
>
>Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 20 ++++++++++++++++++++
> include/hw/virtio/vhost.h |  2 ++
> 2 files changed, 22 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


