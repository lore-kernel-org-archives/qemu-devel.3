Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02EFD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 07:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi6Ci-0004Pg-PR; Tue, 20 Jan 2026 02:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi6C6-0003rO-NN
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 02:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi6C1-0000zK-1m
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 02:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768894223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0PBuvIlcLYg1kpd7FAniEBJq45wPKvBhegecXBiksYk=;
 b=Dp1hE+ycZA+llpirw1rvlVC6c6du8HOZrQL6JBjXTpA8HpoG7rwBUjqSz/yW9Hb89ix5c2
 kTC5wq1ic1ZlXWQpq/60vmRlASgvlkpNYeOWXoFQ4X/hSVWoJCX+XZh+k6B0UiHuhe3jCD
 oGuaBllWfxnmy4pvBA3AuCG9Pj2cMDg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-f8T5XQEjM-ObiOJvjhfqMQ-1; Tue, 20 Jan 2026 02:30:21 -0500
X-MC-Unique: f8T5XQEjM-ObiOJvjhfqMQ-1
X-Mimecast-MFC-AGG-ID: f8T5XQEjM-ObiOJvjhfqMQ_1768894220
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso3368234f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 23:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768894220; x=1769499020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0PBuvIlcLYg1kpd7FAniEBJq45wPKvBhegecXBiksYk=;
 b=R6UkA0lvQKNRWXgU4lguC7Lb0uCUvASiwL9lPH3/AtFPoEfGnjkEgj7cIy7klV5mhD
 It0YVADmBfRV76dgGLoeumxVfxUTKEdZPENTzE+Hcv/BgLiOLngFWJFZjabKQXO8Htb6
 rZMXkBMeXpvSDm7X7nKVEnMjpXnrcXncLFsa8djg9vdqaXMEygOoKsoQBLnoQz4S7UXH
 Fv1ZxVA8vvcJFSZpcxltT0JVCPoatYppdmsNlv9jotpCcavPzc5bh/1Ydj6SYURPZQR+
 AAowxZdtO1Cq5IGWtgnwBbISaxIC2cCJZ3nQIH49PTtbBRwIlqhQWcVjLsF7VLiHVY9X
 vfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768894220; x=1769499020;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PBuvIlcLYg1kpd7FAniEBJq45wPKvBhegecXBiksYk=;
 b=S7ww0ayaLtDnPRWIekncQhIBKWK/kYdgvRII2Imnslf/hHHtWWMmhJoZwZ5uPlNGkJ
 zAcd2pAOul9tH3N9eK1P3HFwaviT+M+RM891eBmOM92/Q+Hj4Tfa011zF1LyvZv3kVG3
 CervmAqEcC/e2a+jjAOIL86HXm2Ui6aQofmRrFiJqhwgmfQjLL2CgUAnSzzR0UZlyYR9
 /Wr3EMyjdOKkl4zpE5k1vbsVRC+1+6a8gbaNUS3K8Y/TKoe7zcZP3BzfT9dmITcB6VU+
 EPQIQv2KcQu0Kv9gy2b0CEBUTJYY158ZQzJ0q2Y/rGyfYbfyV9pnwo9P9lUAyW34Wb4r
 X6jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHvhyG6EJIno53OStcfQrX0Id6wXPelI1fwyGiVSLfyjMpk8LyGgTc+N057kkxFC5y99DWMkxOQqMH@nongnu.org
X-Gm-Message-State: AOJu0YzMs4v+bg306uFLfLhUuHw+WZUQGqb86NL0MvHrKPlQsdYAVLmw
 Fr/1zYGzApuemD56xbrXFKhMqDdck+Kep1eIgWwetFUk48vfNlqYgYURifn5BkZ+8YwFolfv6Wx
 WNtak/n2sZ7NdBB/3EWBtaN/tX8EQK0X0DfvnCehxsCQXj5djLvIVOxVG
X-Gm-Gg: AY/fxX6ZxkpcWG1B1y/ljkKB2Xrr3hWS3h1bfh14Dj4GcQd8Ud/A59eK8erOIAOt/BI
 muhjhmhPIa8YA9TtDRLnvYj49xCEopJpltmmsvFTwsMTkDzdXKJO11pFIUdrTccjQSxH6CaXU0Q
 FNzcgZZN7uQdwD3POClngdedHC1CXJClMd9Q4XOw/x48AzWkq2heqH9jYiM6FLHXqJVyxf7yS4l
 ImsIrtmvQjQQ02Sc4Whcvr/PQcY0zTuoarz5VB0q9LrRd4nTImlkPQygV1tG2AkrYLSeO68fKq7
 3O/V2YUOQSzmfFp6NJORnXhzP81NpNVvM74Hd9J6TsH0URfd276ZCvZRlPjlKHRQi53jagwdvlu
 lY5zqX8H+I4dauh+BXopMUcl1fwy9CkSiNwI=
X-Received: by 2002:a05:600c:1c28:b0:480:1b1a:5526 with SMTP id
 5b1f17b1804b1-4801e30fd2cmr206222495e9.16.1768894220197; 
 Mon, 19 Jan 2026 23:30:20 -0800 (PST)
X-Received: by 2002:a05:600c:1c28:b0:480:1b1a:5526 with SMTP id
 5b1f17b1804b1-4801e30fd2cmr206222025e9.16.1768894219743; 
 Mon, 19 Jan 2026 23:30:19 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8d77besm238281435e9.14.2026.01.19.23.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 23:30:19 -0800 (PST)
Message-ID: <8f5b50f9-6d52-45cf-a567-5745f99461f4@redhat.com>
Date: Tue, 20 Jan 2026 08:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/23] virtio-ccw: virtio_ccw_set_guest_notifier(): fix
 failure path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:virtio-ccw" <qemu-s390x@nongnu.org>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-8-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260119185228.203296-8-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/01/2026 19.52, Vladimir Sementsov-Ogievskiy wrote:
> We leak notifier initialization on that failure path. Let's
> cleanup it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/s390x/virtio-ccw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 6855e20d09..ba55bf4fe9 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1038,6 +1038,7 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
>               if (r) {
>                   virtio_queue_set_guest_notifier_fd_handler(vq, false,
>                                                              with_irqfd);
> +                event_notifier_cleanup(notifier);
>                   return r;
>               }
>           }

Reviewed-by: Thomas Huth <thuth@redhat.com>


