Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA43FFD8765
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ToI-0005vf-8L; Tue, 17 Mar 2026 08:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2ToG-0005v4-E2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2ToD-00062Y-F5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773751564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iezUfwNVEg/KZbzVwYaQ/w38ks3iYzMrqRROPv4CKKI=;
 b=h54D4efnVYj9Y9qxvL7lQvwX74dU4+klHRVH53VQLTFakMvwPSdpsUZPwXJkbefrf7d3rL
 19KtyYPcWRlfvfkPoGysHroBNxA2s5NxOqD72XToN5jQA16vYEr3JRFCA4QIwX2RHuDzPE
 ZBeiAPvNTMqoGv+L21ALxN/z024uiro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-lZzmg_-MM3iSj3xq43RYLw-1; Tue, 17 Mar 2026 08:46:03 -0400
X-MC-Unique: lZzmg_-MM3iSj3xq43RYLw-1
X-Mimecast-MFC-AGG-ID: lZzmg_-MM3iSj3xq43RYLw_1773751562
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485fb873e57so5362295e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773751561; x=1774356361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iezUfwNVEg/KZbzVwYaQ/w38ks3iYzMrqRROPv4CKKI=;
 b=EEpCg3S9WyF4h18kyFSOTLwI1dSj7ISBcO/kaSUvzpY6Un4gI7RSbNHYwPApwKt930
 RVwYYaa5qvNewS98RYv2NIs+0qsu8rlNyj3+FdnG9ph60/vKGIg0IJv2P6mMO2ex/OMJ
 YYXJlFiUqSDIL7EXtRWF4WWaamEqm9gehR7Wttmx48XRk3KURHLqxd/Hc19q92KJwwAT
 QO9MOXSV2GCNSe8q2c0qD9pxV0+sgwTG2t+HODiSX2Ij9h4K0+5ruRT1b0BJ6S04cl34
 tODMO2xAuPlqBE7DauzT/7km/G1Lc31lp38ZtNZmzhcf3F/ELVwnFW93tanIeqEv+RBD
 XJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773751561; x=1774356361;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iezUfwNVEg/KZbzVwYaQ/w38ks3iYzMrqRROPv4CKKI=;
 b=d3gwns+YfMo5ss4Q8b7lfz/8PgySIDx5CJqqUWDTgPHTdb/nz/TaHmUqqB9Txa7ykB
 UUggapEFvJlxmiNDn5LJs639GTC8cq+vCOGbQFJCZsyaJMGPwrwTq0vRgUHMZbdzky1V
 sRy6dwtnhzN8yCb5MgOoZO61ZlW6RJD2pA6Co0JRzm3CTC4po7z7ucAsZbyxHxenbFgi
 Mwq6BstSlm6aQpDbVrkHssgXSZJNKn/QWW1if7XwZlSaB35hf1sfBVzo74K079hdIwyb
 QVak2LBS+gmFGpCaNlqZVnyiL+oijQy8VZKD0tfPtQfWL71uL1sY0xG+wc5w8UlOBxGU
 86LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7rbsI5wlG+hkTYHxUy1GshmNZWc8ooyaEUpOzJ452m9cW632aKiAVHr8bhg540ar2STxquVAwVKZL@nongnu.org
X-Gm-Message-State: AOJu0Yz4IkoBTQbLee1IQSDBC/076/Wuv/njk9/v60+rjpDoN0HgVS92
 9URtzsVeXcL8sKTq+UPvJyxFLTsufI/uLm19o6uROplofjcoSl7tDlyiddHunSKoAK0him+GC3m
 KPEGOmJpFZENYz3OItnPmEp6kFuKkS7omzD0ET7ze5DwA83s7XXlphpzp5GPY5qUC
X-Gm-Gg: ATEYQzxuxxJ6GByCQ2jo0ypTNxRkrFil2wBckVgYrqUqOO95FAmy7rAon+U/UGHZAyC
 r3dGwzWC5o85Jbi5flM5Koi1WraoAW6HfYB/az1mBy+X+Sh+calFbP7mjQNAgosO9s1Ylg0WfR+
 hV144XZVFk/YUddGE3MoRZVxeexVDCLzppqhaH2jWtWgMzwJpyjLXE5DQslbC1P8JFT0e8QeT43
 px2wxKnx+r3pLmtH6kf+N5U0ZmbmHNio0KW72IIb2i7qY9DozhHezq3f1MJWpmLbF5OAztOOXmq
 XR60PCYkQU16BzL2y5DTvamzq7f0o0ZQ02jHxQRow+Pti5SsIjHMxuiuk974lcd5EBoRWdsrhYw
 737sT7w4ovNe2ndeM8YB+/+JToIBxzjB2CZGj+Cg09hJfxzgPta0ebgizQP9q
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-485566cfacbmr297717345e9.7.1773751561220; 
 Tue, 17 Mar 2026 05:46:01 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-485566cfacbmr297716555e9.7.1773751560664; 
 Tue, 17 Mar 2026 05:46:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b46b41e93sm13425959f8f.2.2026.03.17.05.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 05:46:00 -0700 (PDT)
Message-ID: <09aad32b-baf8-41b9-863f-acbc3a16581d@redhat.com>
Date: Tue, 17 Mar 2026 13:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/arm-cpu-features: Fix thinko in
 g_strdup_printf() call
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260317111121.2062455-1-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260317111121.2062455-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/17/26 12:11, Peter Maydell wrote:
> In commit 62272f9f8891 we changed some uses of fixed char arrays
> to call g_strdup_printf() instead. In one place I made a silly
> error where in changing
>    sprintf(name, "fmt string", ...)
> to
>    name = g_strdup_printf("fmt string", ...)
> I forgot to delete "name" from the argument list.
> 
> Luckily Coverity spotted this (as CID 1645771) because at this
> point "name" is NULL and passing g_strdup_printf() a NULL first
> argument is not valid.
> 
> We didn't notice the mistake in testing or CI because this bit of
> code is only run if on an AArch64 host with KVM and SVE available.
> 
> Correct the error by removing the stray function argument.
> 
> Fixes: 62272f9f8891 ("tests/qtest/arm-cpu-features: Use g_strdup_printf() instead of char arrays")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/arm-cpu-features.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> index 5444e4d40b..bbdd89a81d 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -612,7 +612,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>                * we need at least one vector length enabled.
>                */
>               vq = __builtin_ffsll(vls);
> -            name = g_strdup_printf(name, "sve%u", vq * 128);
> +            name = g_strdup_printf("sve%u", vq * 128);
>               error = g_strdup_printf("cannot disable %s", name);
>               assert_error(qts, "host", error, "{ %s: false }", name);
>               g_free(error);

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


