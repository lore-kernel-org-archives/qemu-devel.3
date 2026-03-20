Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC8108B8E3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WXu-0003tL-N7; Fri, 20 Mar 2026 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w3WXs-0003nE-OM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w3WXr-0005q5-Ap
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774000409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g0i+eazWBJJCbRzeHxe2h56ko1/cENdsnIx1zZWfy2Q=;
 b=NmU1SNSG6np5lRO/yz4SK8+zUre+dvQk1XuzFqVzE4bApYuIzi4E9IAFqj849iX1yChHiG
 A3If+2VwpUg8xiNtkp8Kqbn4PQPdAxJ0CVedcqNTwwtmzMzDyaMG6c3hIXFByyJx7t2Nli
 zKjSJTUvBvfxCUm2GxJTanyCQtmxXCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-P0-JoSt-PQm7Watrle2meQ-1; Fri, 20 Mar 2026 05:53:28 -0400
X-MC-Unique: P0-JoSt-PQm7Watrle2meQ-1
X-Mimecast-MFC-AGG-ID: P0-JoSt-PQm7Watrle2meQ_1774000407
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so1411353f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774000407; x=1774605207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g0i+eazWBJJCbRzeHxe2h56ko1/cENdsnIx1zZWfy2Q=;
 b=gXD1HT/fVRrqR3E5N2SS/mY3g+exyKq1QTgKnx05Ul4Aq39azNyJZeWTKlLN4Vokyg
 ifUkK0E6PUl7aBHeBc6yoJHf6mtLxolNEvspMSyYwcZAX2JrrW/h6ixxHvaeDfWl7k7X
 LfdqrL/jIsraew8yuX2Eaz0Xwt3IcvdfR7dyVW3BYF3/QLs102VNc0U9XK6i4mxArA5P
 2+aeerHFL3Pz6pQduweqwDjnOh3pC9CbvU/viiccF5mU8qAdbFMRl+2zfqfAhhsyFM9F
 zgIvn3jhPj+6Yd+nHSa0mA9rm3tTTgdD2GKzJuI5Q8VOrcGMpN9F+LPabwM4qNentZQb
 kiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774000407; x=1774605207;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0i+eazWBJJCbRzeHxe2h56ko1/cENdsnIx1zZWfy2Q=;
 b=YMy13TEVU/5qTwTKWv0pePtKMqrXk7RLsxzqZmB9+zTL2AOfX5f2nKOXcIZvGqt2Xe
 Jm0WobZgtcvf8wYjMwVszVIG/ebXQttyGTMZDHXZTgoZSDQoU7wkcC/aQ1r970o/P6Dd
 MYeOPC3hxZtkghErhfrfuSleS/rLbb+ojescxPWdx2Zr0eoTYeafmtmlWMwsSuTSWHsc
 vJjWOyf/RxCCSpNAQ9vvvggTOhjps674ASqL98KnFOJmSvXOurVSE7LkE7ZeVJWxzQL/
 7DU8IUht0cYScx59y/tDg8HEJ4ER+Li0H+9+8hpVGiF/E3GlI/ptzcUikIDbI/eqHwKQ
 xmEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsNy7XX57t2/Cp/YA3YKvqLnL9RTLRN/8ZlJn/x/bu8kv6lUhThpcCU6tmVuTdgwXERTL5ITPig3Te@nongnu.org
X-Gm-Message-State: AOJu0YzBC0e/lTanfvdq9Y3H1gPorU9oxX1jhIkeit2JGe0EGCuFtp+C
 oMsPB7CuNEHvr43pkd9Dt5qHAX2D3Hy5HC/5lXamNW92a0VV0uba47l+hTXSGer2KxSJtnOfGkx
 3Lpmn1Rt0lEED8+3f3V45w6t2jgq13nIEyibcFlYrlTOGFfbtn/u1kvva
X-Gm-Gg: ATEYQzxhJMpw5x+Psxlc/ukuKupj7zg224adAcEjwhAwGxE0RdoCWPe3p+wT6J0pYnu
 cV137CzZ1d0xasdkhW2HbXZR3FFLaZEabUC0ZzjRRAY9eotarvO5rOLq71aT4jTMkTPcy2iFr0z
 7oadmMUhIc7TUlP1YAaS0IhDuaY5Kx6v2l37C0Asad+wJkr0/bP4p7Tjto/G/C0pN+wJoRi6Xs0
 aKfvUkpNq51tTKdRFsfrbwHlbcDX/TKXur5T+eArE9Em+h8W3lOg2DlWh6Camov/cf3ibNhT+GX
 eECrX3x/QxKoWoWGUwgeMOqI+E0DCVTiV+c96yUEkKdQwA7Kr2CMdfv/jCxXLnAZ3qv3MPbt4hC
 xTqewhY4HSLngIqtyMA==
X-Received: by 2002:a05:600c:c167:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-486ff024f53mr35860815e9.16.1774000406836; 
 Fri, 20 Mar 2026 02:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-486ff024f53mr35860345e9.16.1774000406337; 
 Fri, 20 Mar 2026 02:53:26 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.47]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe889652sm19743515e9.2.2026.03.20.02.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 02:53:25 -0700 (PDT)
Message-ID: <c9239002-1847-48c4-b643-8a50941c88c9@redhat.com>
Date: Fri, 20 Mar 2026 10:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] qom/object: cache ObjectPropertyFlags in
 ObjectProperty
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-3-zhao1.liu@intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260210032348.987549-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 10/02/2026 04.23, Zhao Liu wrote:
> Introduce a 'flags' field in the ObjectProperty structure to store
> property-specific behavior modifiers.
> 
> Currently, ObjectPropertyFlags (READ/WRITE) are only used for property
> creation (e.g., initialize accessors for pointer properties).
> 
> By caching these flags directly in ObjectProperty, we can:
> 1. Preserve the initial access intent (read/write) of the property.
>     * the READ/WRITE flags cached in ObjectProperty have no effect for
>       now, but they may be useful for cases need write-once, if needed.
> 
> 2. Reuse existing ObjectPropertyFlags and provide a foundation for
>     future flags (e.g., to track if a property was explicitly set by
>     external user).
> 
> To avoid "incomplete type" error, move ObjectPropertyFlags before
> ObjectProperty definition, and polish the comment of ObjectPropertyFlags
> to clarify how READ/WRITE flags work for general properties.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   include/qom/object.h | 34 +++++++++++++++++++++++++---------
>   qom/object.c         | 16 +++++++++++++++-
>   2 files changed, 40 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


