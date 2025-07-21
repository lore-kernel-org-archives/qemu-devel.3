Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17355C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udkdK-0000pp-DK; Mon, 21 Jul 2025 03:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udkd6-0000hm-Ff
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udkd4-0006Iu-JB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753081685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CBZRXLWOLsKPGXhZRtOWIC6a00iZo+v1IZa3AEywuI=;
 b=PN2T0K/kQwomHCLhg1FR1HdTmTPoNEHuVdGdgTlk+XVo39E0/W/guz5r+Po+UcZi6DtcU8
 P1e0YaC/SQT+Df2nUfWmYqlYeOwnW+32gXHcV02closJPX4fe+u8IkJLCICUmUvahdn7PD
 gTuSF/2iUPusYI6ADSvC7X83PL5+UEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-1SiAkiBjNBasp2OTvbZmyw-1; Mon, 21 Jul 2025 03:08:02 -0400
X-MC-Unique: 1SiAkiBjNBasp2OTvbZmyw-1
X-Mimecast-MFC-AGG-ID: 1SiAkiBjNBasp2OTvbZmyw_1753081681
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso1739986f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753081681; x=1753686481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CBZRXLWOLsKPGXhZRtOWIC6a00iZo+v1IZa3AEywuI=;
 b=nqX4+o1TthMuRDLSYIsQSvV7ep4Gms2kVjbWeilqCwFODTfHqx3uO9GUScaF5aSdOC
 cqHvW+tlULxEgGSH4wdKocYk9OZTafyMjIELLsOJr8aiODbvPvAi2DqBWLfPiKt0pGw6
 VJB2FQNUXz8AeZdWVZ1406iy7xYmrftWRYhMxwat6n2vTY9DiJ+f2usNiezn5RvMxZuU
 Y/1w1OwGyaSIvF+vZWDRmSLxzB8QP+do5YPnY0DZqxqi5pLUU7YxQhSz+R1j5C2WjAwB
 b/AY9csw+SbQZGa7NQlZP2BkhtJagR8SXYUGT5OEG8RqWfE81PLTktUNDWAAkE675hbY
 E3vw==
X-Gm-Message-State: AOJu0YwD9PP7t3IsraGoVeq3znXdVFy447xkjH9kABkLmpgIwt5/amb8
 mKo0kg+JtsvFmX3BoEwFH+MmaCwmdNF1Geq4VlyqhwFIN7IdJrKp3AWHFn/83dOCN4hABG0w6yM
 +2JZyg7xFQObWo9UMKk3Hs0YWQ7kB/O1zCUPtjIsNGPnqG0zUn8t38/l6
X-Gm-Gg: ASbGncu+Yvq3ZtkMfrma1HPhIuawVdB52hlUlr//GbX94V/TpmU0ygtF096NgMi1u3u
 pRAk7lYb6aKtNqVHkZIjE8kgfd19SFfOXb5CudXGMmXXhhkplQHPgNfFxji7EpJJa+txxyaF5xp
 +NaVGRQqQ96U482kA6avGyUXCD7zU7CzojlQjADmBC4J7J0bLtb6AyBYqBOlVENurG1+ZEDWFOs
 cGblB31Qhg2YqU7oSFR1ERYDB3mOSGwVNPx95EmL6YlXXuspdsVx25stgc6cZHQ/Iy/CpYSoGvL
 A0zChU9WWhBqX3HAA1PkdGJssmQxw3yMcQHQi2770OY4WvSKr4yDydN/H72+SGi2p2gaztsvYRI
 RebonJkuaiDs=
X-Received: by 2002:a05:6000:4284:b0:3a5:39ee:2619 with SMTP id
 ffacd0b85a97d-3b60e51bd54mr14066244f8f.47.1753081681320; 
 Mon, 21 Jul 2025 00:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo/DJD8NEyaXp9Gpoui9VHQwCebx+z61ltMtzeAI8nDPy/yGHwkJkwKtc13+OGc6xs2r9Klg==
X-Received: by 2002:a05:6000:4284:b0:3a5:39ee:2619 with SMTP id
 ffacd0b85a97d-3b60e51bd54mr14066215f8f.47.1753081680846; 
 Mon, 21 Jul 2025 00:08:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2dfe0sm9544865f8f.36.2025.07.21.00.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 00:08:00 -0700 (PDT)
Message-ID: <10982e4b-2b76-401d-8ad1-b4949f655ca7@redhat.com>
Date: Mon, 21 Jul 2025 09:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
 <87seiswtup.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87seiswtup.fsf@pond.sub.org>
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

On 7/19/25 8:57 AM, Markus Armbruster wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
> 
>> Extend the VirtioDeviceFeatures struct with an additional u64
>> to track unknown features in the 64-127 bit range and decode
>> the full virtio features spaces for vhost and virtio devices.
>>
>> Also add entries for the soon-to-be-supported virtio net GSO over
>> UDP features.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]
> 
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index 3b6377cf0d..03c6163cf4 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
> 
> [...]
> 
>> @@ -680,9 +715,10 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>          g_assert_not_reached();
>>      }
>>  
>> -    features->has_unknown_dev_features = bitmap != 0;
>> +    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
>>      if (features->has_unknown_dev_features) {
>> -        features->unknown_dev_features = bitmap;
>> +        features->unknown_dev_features = bitmap[0];
>> +        features->unknown_dev_features2 = bitmap[1];
>>      }
> 
> Why not assign unconditionally?

I stuck with the old/previous code style. I can move to unconditional
assignment in the next revision.

>>      return features;
> 
> [...]
> 
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index 9d652fe4a8..f2e2dd6e97 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -490,14 +490,18 @@
>>  #     unique features)
>>  #
>>  # @unknown-dev-features: Virtio device features bitmap that have not
>> -#     been decoded
>> +#     been decoded (bits 0-63)
>> +#
>> +# @unknown-dev-features2: Virtio device features bitmap that have not
>> +#     been decoded (bits 64-127)
>>  #
>>  # Since: 7.2
>>  ##
>>  { 'struct': 'VirtioDeviceFeatures',
>>    'data': { 'transports': [ 'str' ],
>>              '*dev-features': [ 'str' ],
>> -            '*unknown-dev-features': 'uint64' } }
>> +            '*unknown-dev-features': 'uint64',
>> +            '*unknown-dev-features2': 'uint64' } }
>>  
>>  ##
>>  # @VirtQueueStatus:
> 
> I wish we could simply widen @unknown-dev-features, but we don't have
> uint128, and adding it would risk breaking QMP clients.  64 bit integers
> are already troublesome in JSON.
> 
> Does the example in x-query-virtio-status's doc comment need an update?

Yes, you are right, the output for the 'unknown features' field will
include leading zeros for the high 64 bits.

I will update it in the next revision, thanks!

Paolo


