Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC46C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqs6O-00008e-3P; Mon, 03 Aug 2026 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqs6B-00007U-W8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqs68-0005l2-Gc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785761330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EylLULFFNIyW9QFwnCcRwYfOQ+N8tY2o7WCX2WWXMfM=;
 b=Xm9fDrRRTP7oxCW2sClgCJHvSoLxA1yUKrk0ZJ79FaPXOSXACO+lkQLTctcZyhfXHCxFz0
 aIhfUyWT0rhCFPADwlHQtSFrXEeBL3u0N8CbQjM4d5DsZqMNTK/Lo7yN7fLXChErULEVRz
 JmFs6GwZfHgJv8Vtn6PC2cEE5Dmshrg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-iNb016dUM7uiLM12gmr_BQ-1; Mon, 03 Aug 2026 08:48:39 -0400
X-MC-Unique: iNb016dUM7uiLM12gmr_BQ-1
X-Mimecast-MFC-AGG-ID: iNb016dUM7uiLM12gmr_BQ_1785761318
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47fd4ee0ac0so2563170f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785761318; x=1786366118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EylLULFFNIyW9QFwnCcRwYfOQ+N8tY2o7WCX2WWXMfM=;
 b=tQ3R8CfzsT+EnBEsbNSOVjcar21by8tmp2vJoHxKJ4OcFdghDF/BsL4i2lj4mqVS0j
 hCmiKFnDAZRih4AVMR9HOWct4txMNxF8WOrBFltObvs7S1GVHvGFy1Nz2JV58HQYeesA
 pInXwYenBUNKtZB+/Yt5EISs0BOlreKa0gwWT8Z9pAbCKiZMM2mIcs6KchkhpEgnwWVY
 14E2lqQ7tbKhmgRwR0CgI/DxgeEJjc8k6chpjnwMfqlRcp1zoK0l0WJbPZxK1gBYrgJI
 BPXewraySA0x9UkX7BSBerWnHZ5FK6ntD6s+rH2P9Sv3rlXUWH9ByCIK9ZfZXrJertYD
 6Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761318; x=1786366118;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EylLULFFNIyW9QFwnCcRwYfOQ+N8tY2o7WCX2WWXMfM=;
 b=hJGhrqSdlaD9Hp2nvf/K/+0IGbEP7LQZN6/CDlW+eUgkzrb9Ox/n26R7bFb1VasKPB
 NddJWRTEKYqQQqp0MkPiyXpXgGWMV9U8edvRyUa9UK1rZwuCMkvbqbC9ErJoeJLM3Iod
 VI8rxWRAZ0UeZd1Z3GkIwcAsTc1LY1HWpBYmoO05NJwGqCD9sNhEVwlU+LY1O/GVekce
 96uuSGgv8WxKop/zVQ8sk88oASLeI92G7ZgS7bbYVgWlpNlKFc/BfFu4DbfjnufpXYDR
 JMck7w+T3v9Tq+3GaA70seMjhS4dfk3lFgKpImkBJD02c7pQvXx8+bUpqxmaiOJyCv0O
 rJYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZo4qLB1XYPFIagaKWsb6Wl36Omhu2qtKf68zqiQ/IjTfb+hHJhkyz/piEIWmjWr3irbjpaQ/8Kwi+@nongnu.org
X-Gm-Message-State: AOJu0YwRWDoeQx7jcvqSoBGv3ZZwlZotZaLiQ8/sVll2Gr9AXw1FKnXB
 RgZOCog9NPuj05LqfkWGpMWaN3LuYg6brWJD6RniRnaHFWaohEyjRUn1ByxOAYaQO0x489ZtXy3
 WpcCRzhD9GGVQ43VWzxp5f1SpVFgnrqoVDWl/y8hhpj5D7258m3xDoYBR
X-Gm-Gg: AR+sD12tpsjodlLbDCqQxD43a85Z41Q4B8n6O8y2llggWNA+7pMiExMlktW28yPxx03
 KkS1X1ntc23Z2UreNhDI5BSP7izpDk3MaHzFoZNrXDE9YDhT9hSCnasyuOtSccs5z9WbI/TYt5I
 YDfcCSsmm1iNlsl0EYsv3TWUOQHzPUJE7PO8PjbvLwdu5WfKSeqz3xj57pTyUUzVSb+B8dwix4L
 Z92Z5DS0WtvnSQvyYLYXmB1Co4tZlnxHaesB74JyfRPn6WZhmidVgiqHeRYK+zJB3HSb8wyCAhm
 euqlBWjzhXIGvZ5oJ9r2P8pOoffz8XhwDm73z/SJFTt2Ot34rZm0DtTr0a9MA8wmgLifdo82tp5
 k799EzhmwleNMgveb8y7oXIKv2zFwd9ISJsHEoT+alcdF+KaZsB1gJeUhAFlCZ24CSVHgCf+dZu
 GInZTUPUxfFwbF14ILTq09WF9+vUToDQ==
X-Received: by 2002:a05:6000:2c10:b0:47f:7e7d:eb0 with SMTP id
 ffacd0b85a97d-47fd72a8788mr24185970f8f.19.1785761317874; 
 Mon, 03 Aug 2026 05:48:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2c10:b0:47f:7e7d:eb0 with SMTP id
 ffacd0b85a97d-47fd72a8788mr24185894f8f.19.1785761317540; 
 Mon, 03 Aug 2026 05:48:37 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4068fb7sm33919027f8f.0.2026.08.03.05.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:48:36 -0700 (PDT)
Message-ID: <3fa5a8c6-a803-4b28-a45c-26a71dd99b7d@redhat.com>
Date: Mon, 3 Aug 2026 14:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
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
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> By default svq vrings are placed in an anonymous memory map. As svqs
> will be leveraged to enable memory isolation in vhost-user, it is useful
> to be able to place the vrings in a shared isolation memory region.
>
> Adds the option to specify vring placement by providing a vring base
> address before starting the svq.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 22 +++++++++++++++-------
>   hw/virtio/vhost-shadow-virtqueue.h |  3 +++
>   2 files changed, 18 insertions(+), 7 deletions(-)

I would go beyond Stefan and say that I do really ask for explicit 
bounds checking on the area.

Besides that, `vhost_svq_stop()` still always calls `munmap()` on `desc` 
and `used` and that must absolutely not be done in case a fixed location 
was provided.

Also, it would be nicer to have a function to set the base address 
instead of having to modify the svq object directly.

Hanna


