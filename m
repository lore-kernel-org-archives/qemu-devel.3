Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45807C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqs03-0006TV-2U; Mon, 03 Aug 2026 08:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrzn-0006R1-Hu
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrzm-0004nQ-3x
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785760936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MD5L2RI6FXBTDArIKOWoWQi83VBLigF6a+njSU+nb0s=;
 b=PFunkW8HPbkVNwjhHsbsjbKgpU8d0xi0weQ8XShC+HyEuf0U2/RWfFwqVzQsWZWm6ZgV0G
 owMual5fJKDUvoTa64x6FvcYUd3oVmuCbCuMkl5kg4FD0bW6oEzv//wklIqrRpS2u2Dpxl
 7lw3EHwBTJRpH/xaXBNgBEYNFPrCEp4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-nmfmxWYjM_u3iiOHvjcYbg-1; Mon, 03 Aug 2026 08:42:03 -0400
X-MC-Unique: nmfmxWYjM_u3iiOHvjcYbg-1
X-Mimecast-MFC-AGG-ID: nmfmxWYjM_u3iiOHvjcYbg_1785760922
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b2a24ae6deso1921704e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785760922; x=1786365722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MD5L2RI6FXBTDArIKOWoWQi83VBLigF6a+njSU+nb0s=;
 b=b0ycRUZbwB7rrJhkD2W9w8gDIwzTbJCUvnD6DcVe5F6MPIOH+g34u7dAHsmOMYKeBt
 tK4O3wrC616PltqDpX8p01afuXGfkWmjB9J9uY+xOO/RAdPEhyOeP9C9V1MLunnJUq5T
 1YewArVpMocSgmsunahdHu+Ma2urrRWHmxDXkSMjbkLV9wt3pZzlEElmrf87sx6cSW0d
 nvWeUWY68Q5e4F3+aiwYlciBP+ReV0dPvb9S6+C6NaD6F6SNxSYcF8v7o0r4WDaMtF9H
 Dtpe3TiwtRfO59ONVTm+t3wMZO2MJoK8mr1MjAAU8J+RyuZorHtujOlVx12zH6Eu2BAh
 xHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760922; x=1786365722;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MD5L2RI6FXBTDArIKOWoWQi83VBLigF6a+njSU+nb0s=;
 b=Q4EvvUvF6R/h+iQgw9ouzniiDIRAolujKr8ElxUmUq0C26jLzPF9Ip4E/NmzbrTeGz
 eChIfoMEqyN6QrnykoFGGed/Ex1XJcoOZ0lEMavkvZnL8KrkJN1Tjvns47YSuEvDk2vN
 VAAIJwpAHOUgsG61zwW+QFapic+9EO7i8y+4RYRUhKW9476BseAL9kIZOinJg/G2tzDw
 DEUuh+wzhyhjjTq0jK83Eooqp/peGQbcZEP4q8R8pVqIweHo2iRkaPX7SWUUSOknAQVj
 inQ7vmGftDHA84u/3LGOPS0iysbLVf2+iSsgNAynopNlPLw7TPCh8WbdgZfY8XnH2J85
 s0PA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8EVu7xtERM10NJ5C39geYHxox0VY+B4Hb1RJVdMb29BVb3fA1XSxzeyYBwqO03FpiiCta6Fc4F5Xp@nongnu.org
X-Gm-Message-State: AOJu0YxHltrJeqtzMCJ4BD58ZpmyqP4ysF4IgjcKN1Yhu2eQ9zi0Ozgi
 UBx569K0aej/UQ+Z3dOD2KZZR8TgHEI1NHU04ghp+hJ0hr8gcrBof4jDxdierkj6cgoFMKZ/NEE
 ooJpdlBN9LStmYMRw5PDlFn9ehKranQwd+MaIgJUIKm6jhqyQEi+PyJCO
X-Gm-Gg: AR+sD131WjSyJWdCKR5qGpz9CW71X9Cbs1tegxD3BhhTtUtmAhkj6zC2HEx7FAa02v/
 7WLJrragQfldkyc2+fHJGrM+yF3pxmTapu3UOkWMeVgp9o0vazwKgms5yt4MDqGPLJv6x80F7RC
 6Nyy1sPpZ0FjBq+rD3K+cPLXTusEl+2eWUG9oJ/e4PBuPQ3ApNXG9uX8eV77PEEbqtXkMVcK1h8
 uO+h2AaHJktgMdhB5lngCqST72u6M8Ms1mpoN9EqjJMr5DXQXZzSWikMUHKEnBSR2yh9vsnmXq3
 x2ki3WjVaCMIH/M5W8nPYpQYIZV4T+L6+NRI3cUQJQ8nR2HUL4wwNlngeRDGPYDyxATSf/V0aVK
 OBFhwEJMv28QViOAQVZmkrxByznOj7sST7SNCiHMb5c/kDUtQtTm+qGnlNGpI9B9vzjuqi9kflQ
 Rpl3aH2gV1TayAEf1URKqLQ1ph8mkZTg==
X-Received: by 2002:ac2:4c53:0:b0:5b2:e956:b459 with SMTP id
 2adb3069b0e04-5b2e956b575mr1077181e87.12.1785760922308; 
 Mon, 03 Aug 2026 05:42:02 -0700 (PDT)
X-Received: by 2002:ac2:4c53:0:b0:5b2:e956:b459 with SMTP id
 2adb3069b0e04-5b2e956b575mr1077168e87.12.1785760921925; 
 Mon, 03 Aug 2026 05:42:01 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e245653csm2066246e87.72.2026.08.03.05.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:42:01 -0700 (PDT)
Message-ID: <39200a6f-8241-4033-ba7a-5c9bbbdc8ff1@redhat.com>
Date: Mon, 3 Aug 2026 14:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/15] hw/virtio/vhost-shadow-virtqueue: used handler
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
 <20260723-vhost-user-isolated-memory-v1-8-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-8-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 24.07.26 00:30, Connor Kite wrote:
> Adds a handler callback to shadow virtqueues in order to enable
> non-default processing of used vring elements from the device.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c |  4 ++++
>   hw/virtio/vhost-shadow-virtqueue.h | 14 ++++++++++++++
>   2 files changed, 18 insertions(+)

The avail handler replaces `vhost_svq_add_element()`. I find it a bit 
unintuitive that this handler does not replace `virtqueue_fill()`, i.e. 
that it is not a “mirror” of the avail handler; that the avail handler 
actually handles avail elements, whereas the used handler is “just” a 
callback on each used element. Was that intentional? (If so, I think the 
comment should be explicit about this choice.)

Hanna


