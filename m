Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B928C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqsDs-0002Uz-76; Mon, 03 Aug 2026 08:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqsDe-0002UW-Pz
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqsDZ-0006n9-Mm
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785761789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/DmcwM+Uh6OE4okcJAw3UWbpV7nfREwvzmcz3XNS5k=;
 b=ix96NkelpsrsazaTaKHh+ZbHqWi6E7niVbN0OIbV9Z56byENl1ONQZcN9sMe9gkABTBS7f
 q9MEH/O3r/2tRRndwan5kK+EPnHAOIZDFVuFwMj3E4Z3ZNZTbttJKrmi058MjOlGxDwDQl
 neajrfhe/lVeUjm7VkQw7F+ePWswlYA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-74LDcC9GP3Oh62odwRKUig-1; Mon, 03 Aug 2026 08:56:28 -0400
X-MC-Unique: 74LDcC9GP3Oh62odwRKUig-1
X-Mimecast-MFC-AGG-ID: 74LDcC9GP3Oh62odwRKUig_1785761787
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso15328135e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785761787; x=1786366587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j/DmcwM+Uh6OE4okcJAw3UWbpV7nfREwvzmcz3XNS5k=;
 b=roRajMllr1WAbFLt66O5flqO6yZbV0H9nKCYlyljUX+beXX1WUzW9X175RAvkI/2g4
 q1mqOt8aPAzQsI8WJeJjKGvx5bboBJoX2v3gdmwaju4mfEBr9JaN8NCAR4TRqxyCf/k9
 6vy1xrPtaAO7rEeoM8KmfDKZ50FTFlyNR0Co1LdiXwt4KNGIBW46kylIj/LtOgvkRQAW
 uc5Rp7BSTd0plrGs16SHXTixbd0ADzsiXfc2Ra3T1PZ6oK5qofJxk+7SwKFMPq3s80U+
 7820gHIsGTWChJjjvlMrR5Qlpt+Fx4YECkcPRy6IWCWATdWZUhuXbPkd8nMPTmXi4wp0
 758Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761787; x=1786366587;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j/DmcwM+Uh6OE4okcJAw3UWbpV7nfREwvzmcz3XNS5k=;
 b=iK8nRtfTPt1Ux6yl8ueFYjMHBKFF4kFLOgsp4I0XoEVo7UNRmxXkxOPjTjotSQoFaV
 HcXdNAZf56tGp7pAyj46olrnx7wtybKG/+L6kCjXp7ChclMoIwiRMie/zX2fw0BSzaAa
 ow57+ucUZZnQ/suEhdMiQ00dXOH9ofDoXxgLEMQ/qnSUwxKjnrplUcmd1fsS7HT+hjM+
 VO13J6mET/3jq8cHZnIfEE/UZSE46gcU6yDzCnfOLOwFKLpaWLPF/VlqzMdaNof0JnA5
 6Ee9qaSoC/A/9v/8yXpJcKhWnOgK3LiP6/NueZik9obHNhykjJ07YtXz6ZY+CgYMi1Ju
 9/Jw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rovx1TxDDqdsblmlMxh3VsmeuB6dE5525sZCbMCxJ8vOd7zqGtjS2yJ12vdr9pX3VatXlSX3tCiG7L7@nongnu.org
X-Gm-Message-State: AOJu0YyW+edd9Non96uXtf6rOp8IJx7NLb0NhrarOEMNh9bru5VJ7oD/
 EB+K04UAnkAFOQlp3vkyILdPZHRrh+GGrrihTnhLQOzUvASzhLFRBqWSavF1e1+VEOTxOxoHXd3
 DwEqwsOj7GpdgY44bnRyB6bmBs5ftVnzjJUNbKo/Ur5nSEBxXk4M+yyr7
X-Gm-Gg: AR+sD11Hj8sd6t7Yu3iNnihZ0kouY672OQHS0HEa3I1/x0WIvOHjM2+ZHQk2cJneqvO
 R+RKTxhjUBL1o135zjuVfKEQ9St8w1Tg+zCZBy5eaxr9WPweAMYdKTxsB/WBoSLLvBhM3r2Ut9d
 OvOX811UFRj1XQCd6fp3jK7quuScW1jH5FYvgnQhwIFICjG6EcQx5+drR+JHTCP8IsWp+ZBcc3h
 Xwt9NXfteqQ6WdTVv6oq8I1BlEw3qmilMlU6RzXKhInDi4gRatvQnJbv/MxfmgRs8jOlgd7PQJM
 trdhyh5iayJ1EAFgxzBiRHpSL4EjUgtOW8R9V4l34/FyWKy8eomXLNTLuyyZoTCf1T7On1+93D9
 4+lWq78b1VMKTTC2rfLhtgumY0e+EnjpvskNtdixQKrIffk4wcAdGaH2EDGldqECVOHHBhKOfaX
 8sOhsRiOIADQMW4kXdS9r0qHipgWmkRA==
X-Received: by 2002:a05:600c:a4d:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-4980c693eaemr230430325e9.19.1785761787503; 
 Mon, 03 Aug 2026 05:56:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a4d:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-4980c693eaemr230429425e9.19.1785761787086; 
 Mon, 03 Aug 2026 05:56:27 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458ab61sm33503288f8f.25.2026.08.03.05.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:56:26 -0700 (PDT)
Message-ID: <ba6158dd-7b7b-4457-9256-497ab60a27d3@redhat.com>
Date: Mon, 3 Aug 2026 14:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/15] hw/virtio/vhost-shadow-virtqueue: range
 boundary in translation
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
 <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 24.07.26 00:30, Connor Kite wrote:
> iova-tree expects inclusive range sizing when maps are allocated or searched.
> Currently, svqs use exclusive sizing when searching their
> vhost-iova-tree for a match to the region to be translated.  This could
> lead to errors if the region to be translated is at the edge of an iova
> region.
>
> Fix this by reducing `needle.size` by 1 in
> vhost_svq_translate_addr to bring then it line with DMAMap and iova-tree
> convention.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 9e3c359f50..20e5c7d2f1 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -104,14 +104,14 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>               /* Search the GPA->IOVA tree */
>               needle = (DMAMap) {
>                   .translated_addr = gpas[i],
> -                .size = iovec[i].iov_len,
> +                .size = iovec[i].iov_len - 1,  /* Inclusive */
>               };
>               map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>           } else {
>               /* Search the IOVA->HVA tree */
>               needle = (DMAMap) {
>                   .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
> -                .size = iovec[i].iov_len,
> +                .size = iovec[i].iov_len - 1, /* Inclusive */
>               };
>               map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>           }

It’s not immediately obvious what is ensuring that `iov_len` can never 
be 0. Sure, it would be wrong and makes no sense, but that is why I 
think an `assert(iovec[i].iov_len > 0)` would be appropriate.

(Looks like `virtqueue_map_desc()` is what rejects zero length, but that 
is not really local to this code path, so not immediately obvious.)

Hanna


