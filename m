Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9B3D3F094
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8ah-0002Zg-VZ; Wed, 28 Jan 2026 11:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1vl8aZ-0002WE-R3
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1vl8aX-0003TY-Bi
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769618415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOU6wKZC5NxdlAzC8hawq5J8MVpTFpREl0fOrUkvZAA=;
 b=bSOb0/JogduL7MOkPDf89+U+nW1sEeWuMkcAO6t7OZHQpRxUui69FsZ83J220nZdV1aLem
 XgQKeWjmctRSFXDiFbD+XbI4ywzar0nP5c8peD1ulDgWyLC+l9t72yhWuPAShN6WgW5sj1
 k1L6UUoWehkHydD68/4U5YiFBn4YnMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-1R1oWAsNMRyD8fTUwIlRRA-1; Wed, 28 Jan 2026 11:39:06 -0500
X-MC-Unique: 1R1oWAsNMRyD8fTUwIlRRA-1
X-Mimecast-MFC-AGG-ID: 1R1oWAsNMRyD8fTUwIlRRA_1769618345
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so132015e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769618345; x=1770223145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EOU6wKZC5NxdlAzC8hawq5J8MVpTFpREl0fOrUkvZAA=;
 b=j1QVRPZj9zS/3YBWk8Up6RsucwWMNZbBwIysAxooDPC2sgxic51wGla9fXkwkOlMNf
 FdOyXKMWFja4/fEruOKh6KOC1WelqP/y+iGmWH2e/A8FNYib7UzcEQ+UXTY1bSFmG7OK
 OrguYR1ni1zquzcI9xrr/KfZsq6MzGg3tp61UphZC5qKWKToD5nud9KO7cxcloFApVzv
 sAnpxzQ2LTAmG1QzVS7I5bcoc2IqnIA3fqh3ca1PgX7oi05UKaaEVb1L2EHdlCPpbekZ
 +WaqqNwvzKaZmqi0DzeRirUkEcrsuUAhkGMTGRPQ8U4K1eE7YwsFzgjINsuAwkBteZmZ
 z2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769618345; x=1770223145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EOU6wKZC5NxdlAzC8hawq5J8MVpTFpREl0fOrUkvZAA=;
 b=MextR08XecpMGm23PMJ0brJhbXZA4bo85XesmbOf9chaFM0TAlr4l4lqww1CgeoF34
 S3GRN5Woc0YIqP+n+NE3sS5LGp5QcIa6TRQb8D7F8m81rBCKBXG/ckEP7oXTPp1PVg7A
 JGay4Wu9vJt6El6KGvQdE1hoRQTSE898DEVFphgZTxnTrLhp1N5eCfKege5q7mJ+KW7S
 inyrxlb9EvMEtfQjZwHpKBXts475n6g5xWoEkBYbN1/hHkWM1CYBQ4KRKEAZ77c/P0ri
 s+sfqqCsfXBAqouIX4leHF1Cy0pybamCpPTHZfAQbZrkad4GtZ4c7NPQdDRewBBQFZEJ
 eQ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIiCEJVJxd5RthjMfWRaigzvkMUQj7UGVHhN1S0KT4gL3+/10VUkNfwkF6GcBepWdu5bs/aYFbz2np@nongnu.org
X-Gm-Message-State: AOJu0YwJY+UrmunoSUjn16bIRM0uiA2unb1Wu/mUJxkSqYf+ZBta87yj
 sBj8oTYpusg3XQcaO1TqxtSEwRdeso2kmPLcPmQbS/PK4j2gMsmAa+sY5YKhssgZMBNSbTeF1vs
 lMRfNLe1z9RBWQujaN1zFyXta43WTSdTJbRjtkKc56EIgDsWgQQbP1IEF
X-Gm-Gg: AZuq6aIVfYYhYZ2UimkZckrmOjdrzSjCdpMEuqu5fPsraFEoHdnmqg/rlcsBQaA7eqY
 XVUN/Crkt0u3BYpqHGNBfSjue/i4uNWUj6LrBrL7f6PqB3ZgU89Zxwy6J1SzBkp8b/QX+oCOWLx
 c8KhrBEd7iRffVmbKLsAyXg921o+lRQ8ayzwT+yp2aBLIH42YOevZ6AdhwjEiKr9+N34DQiEVGO
 ReQIoQQ8SXxwR2qDugFkF8E8DW2hsZaDYzltP5ob+eq7HZ+h3ZsU703VOhbFFVFnTvQ0xIqjG1Y
 l0bTIW3Lz52DdnAgQYwn5tbeYsWkenYxXYTrDgezpf4Sg9haxH6MTnHyi7Uu0y/GgoPVXnJf/tf
 3Nye3hPiKTbZb
X-Received: by 2002:a05:600c:3b1a:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-48069c601bcmr66690405e9.33.1769618345065; 
 Wed, 28 Jan 2026 08:39:05 -0800 (PST)
X-Received: by 2002:a05:600c:3b1a:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-48069c601bcmr66690185e9.33.1769618344611; 
 Wed, 28 Jan 2026 08:39:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d255fc8sm6718215e9.0.2026.01.28.08.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:39:04 -0800 (PST)
Message-ID: <7727d378-db7e-464f-89a3-c5e10c605fb5@redhat.com>
Date: Wed, 28 Jan 2026 17:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmp: Fix a typo for GSO over UDP features
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20260128162428.2669768-1-lvivier@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260128162428.2669768-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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



On 1/28/26 5:24 PM, Laurent Vivier wrote:
> The description of VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM feature
> was missing the _CSUM.
> 
> Fixes: a76f5b795cab ("qmp: update virtio features map to support extended features")
> Cc: pabeni@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/virtio/virtio-qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 968299fda0c9..45ca40ca50f8 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -329,7 +329,7 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>              "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>              "UDP tunnel packets"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
> -            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM: Driver can receive GSO over "
>              "UDP tunnel packets requiring checksum offload for the outer "
>              "header"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

Side note, I lost track of this patch:

https://patchew.org/QEMU/745e4b9ff93b27b4464d039d2ca24a9020f2c32f.1760103753.git.pabeni@redhat.com/

which would address the above and prevent similar errors in the future.
AFAICS is sitting in patchew since 3m. Should I consider that one dropped?

/P


