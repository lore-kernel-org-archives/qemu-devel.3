Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BC2C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udkWR-0002ol-5F; Mon, 21 Jul 2025 03:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udkWN-0002ll-Im
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udkWE-0005o8-Nq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753081257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvvatMBVPb/tBZEfFhNjWzo6HpCyDeIo99VY4dIfPVs=;
 b=UvaukTEuROVvqVTUW7KyiixkPv8/bvnwllsD79UodBfAqgIvt2smMz/YNLCqHGXpHlaDXL
 h95Tu5F+dOBH8Bvz+623zD7j0I/MfY8Hy0S4zCpc93wnAZUXxRY+gRqot1wktYIkuCyn1K
 NfmOLjLjjaRwqvISrrLBUm1iXZ4N8yg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-rz2wE4qFM8yuAo_sgPRn9A-1; Mon, 21 Jul 2025 03:00:55 -0400
X-MC-Unique: rz2wE4qFM8yuAo_sgPRn9A-1
X-Mimecast-MFC-AGG-ID: rz2wE4qFM8yuAo_sgPRn9A_1753081254
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b39cc43f15so1927326f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753081254; x=1753686054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvvatMBVPb/tBZEfFhNjWzo6HpCyDeIo99VY4dIfPVs=;
 b=xIXWo+Mdo0Yy9L+U4fF+ajEIGjSK7/rm2f7YwOCmuN9VngrJ+KF01IFU2/6vI0dZ/U
 aX+NFry20PkRNd5Pj0AlVGnQuZC9EDxeklAie1U01oZdrcgsZTXOrnkQzb/6eG6BUEDH
 scbYVElyokqAaHbP5GExwq5ei9JVTqmUOnoiL8FVlwyOKEKQryeGQeVjgJsPAnjxVSpk
 XzL6lshG11Ha/ZqDbuM2oW9SLp0I9piqY8yML9Q0snA0mX6V5AD8wlKq5BqxOO0YQi+X
 xGUbNnKfy2uJprm5Ic9DVTqtSa9pL/LmXqxQdr7uadQt/32mSX2RWOWwultaIr1kLKHi
 847Q==
X-Gm-Message-State: AOJu0Yx+KZFt6CueYqYPwN3cbc9UtOx3oH4cHSPDoT8fFIKYGcLzfDoY
 iwbenf8nDcsHiAO1AqgVQPzJ4C4qpFgO+RIAGWbQoBfAJTAoZXHECNZ/WinPkbdISYi6YwNxAih
 IbPV1WrCZUzza7VfA2frf4YqiBf0js0qPiVzsM+SMbMlf2rboT+3yhiDQ
X-Gm-Gg: ASbGnctLYACrCSJXg/10x+49yUa+91JAxB9P4ClMGnlu9PjOBiY0kQ3cDOZRi23Ahun
 a/Zwjc27q7ir8PXvKxhy9Nyt3HY+aaZltmxRgBqFFAsGxiIDMJxq75/HANCaHqJXJfdGDGtztJa
 yeZC5OKgEn4k9m2CxU/FQNdmp6YR+Xkih2hSaokBRviLk9VL6vxVpe/niJ64gjmxAL7KfDL62vV
 Ky/fhh900IxX3xjZ+EaHWJEM3Hw9J4Gk+43iXxNS9VjFIO6jYAe01h83DiEnc73eZSfSVG0ZCzS
 oyYI3RkrC6/dnk85vGtEbfwPJzba+LX90T0t84y17Z26F/PC+8KBO50RLKfYUgPBwmpi4lF6F0U
 AqReay7ljpcw=
X-Received: by 2002:a05:6000:4606:b0:3a5:1240:6802 with SMTP id
 ffacd0b85a97d-3b60e53f7f2mr15038808f8f.57.1753081253819; 
 Mon, 21 Jul 2025 00:00:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBivxUvJDMR4XrtxZl5ReCRsdpEq2TiIfzp4RsbkBb06rGJv4K5lZtedxZyGQEkGmyUSxVFw==
X-Received: by 2002:a05:6000:4606:b0:3a5:1240:6802 with SMTP id
 ffacd0b85a97d-3b60e53f7f2mr15038770f8f.57.1753081253334; 
 Mon, 21 Jul 2025 00:00:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c5e3sm9565018f8f.78.2025.07.21.00.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 00:00:52 -0700 (PDT)
Message-ID: <4ec450fd-1813-43df-a2eb-445602e312c8@redhat.com>
Date: Mon, 21 Jul 2025 09:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
 <3cm3qlpzmsnddedajhdnzgwl5govuott3mnzkeroyaglvfbbn4@devu25bxprfs>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3cm3qlpzmsnddedajhdnzgwl5govuott3mnzkeroyaglvfbbn4@devu25bxprfs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/18/25 4:36 PM, Stefano Garzarella wrote:
> On Fri, Jul 18, 2025 at 10:52:33AM +0200, Paolo Abeni wrote:
>> @@ -1871,6 +1900,20 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>>     return features;
>> }
>>
>> +void vhost_get_features_ex(struct vhost_dev *hdev,
>> +                           const int *feature_bits,
>> +                           uint64_t *features)
>> +{
>> +    const int *bit = feature_bits;
>> +
>> +    while (*bit != VHOST_INVALID_FEATURE_BIT) {
>> +        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
>> +            virtio_clear_feature_ex(features, *bit);
>> +        }
>> +        bit++;
>> +    }
>> +}
>> +
> 
> Can we do something similar of what we do in hw/virtio/virtio.c where
> the old virtio_set_features() use the new virtio_set_features_ex()?
> 
>> void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>>                         uint64_t features)
>> {
>> @@ -1884,6 +1927,18 @@ void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>>     }
>> }
>>
>> +void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
>> +                           const uint64_t *features)
>> +{
>> +    const int *bit = feature_bits;
>> +    while (*bit != VHOST_INVALID_FEATURE_BIT) {
>> +        if (virtio_has_feature_ex(features, *bit)) {
>> +            virtio_add_feature_ex(hdev->acked_features_ex, *bit);
>> +        }
>> +        bit++;
>> +    }
>> +}
>> +
> 
> Ditto.
> 
> Not a strong opinion, but just to reduce code duplication.

The incremental diffstat with such cleanup looks good, so I'll include
that in the next revision, thanks!

Paolo


