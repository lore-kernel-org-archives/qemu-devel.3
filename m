Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68285C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHDG-0004M5-Sx; Wed, 12 Feb 2025 13:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiHDE-0004Hf-Ux
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:11:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiHDD-0003IB-9p
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:11:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dd0dc2226so4121548f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383909; x=1739988709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fqppiBd5nMBTUuGcb+ikkZizddku8LgTX7pa9/dVEN8=;
 b=yXEsxSBnRozTiUheKPRVHNXyNdi+ywueFaYK0xRlzpyLkc36G7+FFKpjXjSuKe6FzF
 Kw03dlSj49Lx6fqFbDxIPQoG73WgZ3ggLWv27y55LjIL0EMDZKzYaXRt9SVS3gpnmCWJ
 JLwcnUVWbtbKSdVQ9q63Eglj4GAPnyNksnRhMqADlOzaq1wEwb5fSIzTTBwi0wJi8I4J
 Lw2fk56QWgtx49sip/pFwGYJgpcT3M8hR9jhQqH4vkXmRKW37XhuMTVBSjgTyTfUJgJJ
 HbebJpXwAdhvwgTnSw8zmW3t07iXYskKAM/XxH3DQbJq88wbumtF7o+XeqMHhRHlQBTw
 SauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383909; x=1739988709;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqppiBd5nMBTUuGcb+ikkZizddku8LgTX7pa9/dVEN8=;
 b=F7RLsZNTBzxPlsx7AtJiHhijwocyaAcAed/kXTjcV/DkV7WN9y1afyxVpIold1jn7I
 PhJwuKslH2DT8il4x1ELekfg5w+1U/S/gu1+Kyw2rQ+OKquR25SZbKceYf/3zacm201r
 bogjBir8tV8xy6jqt9VYayvxxWoEEMBrKb5uSsVhdOTuMP6FFhZwxRQVnQXcehxfYA0K
 2kP47K/iI2LGXL6Ht/Cbn5C7nbEDcUPRS0RzTln100iveqRxqRZSKNAYV1nPMQvOl3i8
 L3R5SXDygDMooNi6OHNZWyuEmSskt4cYckvTfA8f3gyNfkJLOuvKHMKr7hvcV7pkvREo
 /oHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW93PQAZ5nMlTDBcoICJ+pnElF/IkiYWQ/Mp/q/KJzcmWrVpTHpleobh7NG5OaMrLt0VWMHVTqT5lIG@nongnu.org
X-Gm-Message-State: AOJu0YxOHSBoSVLDSmYLfBQE61OJUp2tNuPAVVQZSujGv41XA10LA75s
 I+u7X9jmWE898hGQYi2KqMsn2CoadheHepA6WaCJuO+Q3IE1aS5ZqStnE5CfKqw=
X-Gm-Gg: ASbGncvQNQXjB8A9tVdhJFHhSZYkQziyLAR4+o6pgECD7RHkQ6s+suqTDNPzGFttCRu
 erWjOYh+dLOoChq+Mh1nmmpi+UmmaUEgP4bwIcM1zFb8ICHzC4gWsrhfCq1XIX6TVa/dTiqBjXz
 JYkl0B4UmH4Mfl3B8M5TX+SZbkURudUu5fyuJ5LMmllyj4U6+C5h59/HJ1b5oznjleQEFVQ6tod
 qoSGWV5nXxYzGNc8+wca8bLoDqUGqUcFRxP/YwnILAWcHB66KB08A1IsqheYN478ZnyQSHPSyXT
 9srZT5HUTChoBYC3N8726D1bNCCdGKl1XBDJlp+UESrbqjLZAGcC2Yi+ivMiUCzB
X-Google-Smtp-Source: AGHT+IG6vEpXDfhY6l3y66qI0wFVflw/TVyvPctJkOUHWUct3V7D6JEpRUzukXio5LWr6Uy5U0FaAg==
X-Received: by 2002:a5d:64a6:0:b0:38d:e707:f312 with SMTP id
 ffacd0b85a97d-38dea2e95f9mr3795989f8f.46.1739383908909; 
 Wed, 12 Feb 2025 10:11:48 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38ddaf333c5sm10219225f8f.36.2025.02.12.10.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:11:47 -0800 (PST)
Message-ID: <7a07090c-78d4-4d5a-9d8e-56fa41db06cc@linaro.org>
Date: Wed, 12 Feb 2025 19:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212164923.1971538-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/2/25 17:49, Konstantin Shkolnyy wrote:
> VDPA didn't work on a big-endian machine due to missing/incorrect
> CPU<->LE data format conversions.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in v2: Change desc_next[] from LE format to "CPU".
> 
>   hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)


> @@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>       smp_mb();
>   
>       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> -        uint16_t avail_event = *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]);
> +        uint16_t avail_event = le16_to_cpu(
> +                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));

Nitpicking, sometimes using the ld/st API is cleaner (here lduw_le_p).

>           needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
>       } else {
> -        needs_kick = !(svq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
> +        needs_kick =
> +                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
>       }


