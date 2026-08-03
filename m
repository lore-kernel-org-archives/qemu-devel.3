Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDF2C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqruW-00040n-JS; Mon, 03 Aug 2026 08:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqruU-00040O-OA
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqruR-0003im-Kc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785760605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxHISWqf5pgrRXOkzRFXQxsDfQ2sN0hwCWX8wTNkvq0=;
 b=PJ8C4Qhyap3ieqt+3G2H3yvPCR3j7V0IFLsSTEFypjpy5yhsXwFsbKbvgROGrsYbVQEU37
 x3ev0RFpu+0y6MtmmTzTBd/VpNZzQ9eKa7YPOdrn141f5jTtBRV8p1wT1U2kUaS+Avit0W
 3mGJ4KMhQD34qQ/NkDahnOWLuvDcTKg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-qp2n1A4IM52sb_76IM2CPg-1; Mon, 03 Aug 2026 08:36:44 -0400
X-MC-Unique: qp2n1A4IM52sb_76IM2CPg-1
X-Mimecast-MFC-AGG-ID: qp2n1A4IM52sb_76IM2CPg_1785760603
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b015ed1b78so2035111e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785760603; x=1786365403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PxHISWqf5pgrRXOkzRFXQxsDfQ2sN0hwCWX8wTNkvq0=;
 b=j8FqrrYhWIiDIaAgBURLQRvV+4QyZvjHWQwV7+Dz0SMlKfU8fmknGvt1NmTZKWPhS/
 /fsYtjRUNuBj4KtspP+61GzLdqYXiEyvYGl68RnRNkS1k0+JmnoC8OGj7nyjZYQcDO4C
 xFXnN8w+GjIDLqogI+nR52mpXHnjyiwWQkqMtMjK//iT4ipG877a16PpjnKTCGiXctMS
 5Wfmldi5Erbzm3dByxPSJwkVCeP3kvIPqHYoHaPAME5bNVEQA0H5HCyr17C+zFkgbrQ8
 PN4xcqhh6WFTa05q9J14p3A5bPUxohOeKIIANhzHEUeRNHjpQceNM3S7OEdTSPLUO8Yf
 XDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760603; x=1786365403;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxHISWqf5pgrRXOkzRFXQxsDfQ2sN0hwCWX8wTNkvq0=;
 b=SAGT03A0f4HedWRsrbJqI3JlN0CqBjX6u2hMhtk9teL+0LRYcTGHmWKdpySLfTdAOO
 rPzzVStyNqlTpa08Ce2tOM5prJAmCsz592JmT3yIuQg9so/ZnVSdq6iZENeDr9nsBWVE
 b3tPAIi/tg5PymukREizPuubJTC37hyYsC+q29ExFLoStCgMNkdGLDEMbqoaFaIVZdGo
 aPqqFLGteo+VjsL89zYkEJVc/H4kkSoSpNKVNiEQK/QYVzS2Lcej769MYC5Jopz9PJUi
 dtroHJgy1PMj1xNRhBSz8g5zyxX/Dz6s+4a2gU47qRr2Ym73QfHkr04uWc4XyfrqbK+l
 QUKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTwF7j061imFZqItHsSA2Vi7t1Se2M8VksrdUSlBm6oTRTP4UkqSeJ2VTaXRump3QBWjnxI1emAsrY@nongnu.org
X-Gm-Message-State: AOJu0YyUmV6mcEtmhXi07Ar3qOXK9WzrbSTYTXmnLzXERIlXMh+PixaW
 aQWffBL3FR5IdfAe63sarwd1+LBcsV2EpVme2PvRSJC6nZo22HeYpNekU6XpkbHsQGee8aPSWux
 sVxzejE4OdetBgFDBnWgECcFO+IsCopTTsORNMFOhygkArXZWjDdbUowE
X-Gm-Gg: AR+sD138IS6Ec10tvoc8EmOk5GBfVYe+b9Uz6faDVQBzWc9cSpZ6qh0N0EdImcXX239
 4K+Ph++9qMX4c797AX6U+/pk+0rV2QXJcMc3HziPzS3y0jkiAIvhYir5TC22p3FdxFyLShz3/bV
 fN3FkkH4C5twwYGGAKZW30iHghdPHcJnd4o2pTX+NQWYQijjn3Bz1DJMH+z7qjrk5bxLdxFjSlP
 uGBQLW/99Thdot+y8tHRddZEuTtWIXdgmXTOm/PwxRENuDq/Fl6VDWAmRsufrU8DjvqMU+6jx8c
 BsEI3+71PuoA9HEqiJakX85yQHcOvsn4+hrPZpOjWazLzL8VkLKXdzsRbLhWQtbiJjLMB46cRhm
 kn0btyVvA3+7H1vGbZ4bdt48552b3s77BWN4/8k56vtZKkg5sbnkUMWCgFeuhVjB5gB5iFIhm+H
 s7ml2t4Fu7ZdScZ9WJl2lEhPCXccua3A==
X-Received: by 2002:a05:6512:b93:b0:5b0:1af0:2a2a with SMTP id
 2adb3069b0e04-5b2e4f922e2mr2093323e87.61.1785760602591; 
 Mon, 03 Aug 2026 05:36:42 -0700 (PDT)
X-Received: by 2002:a05:6512:b93:b0:5b0:1af0:2a2a with SMTP id
 2adb3069b0e04-5b2e4f922e2mr2093300e87.61.1785760602082; 
 Mon, 03 Aug 2026 05:36:42 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e2441e8asm1970073e87.44.2026.08.03.05.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:36:41 -0700 (PDT)
Message-ID: <f7776822-106c-47d0-ada9-fab75f68c76d@redhat.com>
Date: Mon, 3 Aug 2026 14:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/15] util/iova-tree: g_tree_foreach wrapper
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
 <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
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
> Add a wrapper to iova-tree to call g_tree_foreach.  Provies a means to
> execute some function on each node of the iova-tree.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   include/qemu/iova-tree.h | 13 +++++++++++++
>   util/iova-tree.c         |  5 +++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> index 14e82a22d5..4d77f4dc57 100644
> --- a/include/qemu/iova-tree.h
> +++ b/include/qemu/iova-tree.h
> @@ -161,4 +161,17 @@ int iova_tree_alloc_map(IOVATree *tree, DMAMap *map, hwaddr iova_begin,
>    */
>   void iova_tree_destroy(IOVATree *tree);
>   
> +/**
> + * iova_tree_foreach:
> + *
> + * @tree: the iova tree to traverse
> + * @func: the function called at every node. A true return value ends traversal

Can you document roughly what the function looks like? Because the type 
(`GTraverseFunc`) is not defined in qemu. I know it has a boolean as a 
return type, and that one argument of it is going to be `gpointer data`, 
but surely it will also take a tree element.

Hanna

> + * @data: an argument passed to func
> + *
> + * Wrapper to call g_tree_foreach on underlying g_tree
> + *
> + * Return: None
> + */
> +void iova_tree_foreach(IOVATree *tree, GTraverseFunc func, gpointer data);
> +
>   #endif


