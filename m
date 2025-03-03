Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9908C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 06:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tozW4-00031L-N7; Mon, 03 Mar 2025 01:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tozVf-0002vG-3t
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 01:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tozVa-0004Yp-36
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 01:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740984151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9AWzZ7OlOQVKn3Klga/es9roLEybECVBNPz9G6WBynk=;
 b=TLWD6JoBb8AN5R2E2kYpu2RRzXnzD0BtmH/S3oZf55eItlyaccOGQVtEIDF1UWhR7Qr+2O
 RtTwEOkiZscVV7dNlTQy9BdBxTUJGs7hl3YuQSJ6WaI7JB2Tt+KxLnLSqnmfvtI2nU9ziw
 MIBd/T3mj4rev9JnKMGivgycv6scwdI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-hpS-03X9OgaDV63JB-XgZQ-1; Mon, 03 Mar 2025 01:42:29 -0500
X-MC-Unique: hpS-03X9OgaDV63JB-XgZQ-1
X-Mimecast-MFC-AGG-ID: hpS-03X9OgaDV63JB-XgZQ_1740984149
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abf68178603so137892366b.0
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 22:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740984148; x=1741588948;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AWzZ7OlOQVKn3Klga/es9roLEybECVBNPz9G6WBynk=;
 b=ugJt7t+Vuej0YNKdJFVtsYPHgWG7YuP1XXOS1TL+fzM1L9/DDAyvVAIb2vs8u4OZpQ
 H3uxGkxfqLsNzmNOvVo/uPuLs9h8JIka0KUAjzCwmXytz9jgszODIFLNp+xekZR6v5s1
 G68LLr7HsAj/p4ytFTtlHioRlg/Wd6u0hXiHLkYzee/SKNRB6e+9Z0ADmdsjgIgX5YVs
 11PeHP3qeh/mO3ofm7q5wpjnID9F89Uoo4LIXSW2z4tGHGpHC73x5i4UHjbv7TiLvc8c
 HWq6eHXw0A65wKaYO3qFwRWbLAE3znR5xPocz7MLUB3HJeiEkoLbXBdzOZdxXAbZ7urp
 2qpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYiGmMe22GdVEDRpI6FeIFewlRM3Z/yg+2qpp1Bv2BjprNKmRmlb8Q5aQZ60TxBgOJfXnfEYKld/4@nongnu.org
X-Gm-Message-State: AOJu0Yw6AOrw9bEOp8TzeN/SMonE5/B/6m4mlcN4udGNQJ5KOda+1wCy
 DNjZIqT7RN8fASsyXzb1ern8XJs5kQHmrpuEsIqa+4RNbiAO0BrHbHm+IOJfPAM4UJ8eoNeVnfo
 e7Hpp8YCtH1HsxcxwS0kSrmNCFnx1JsGGgc0MnulKyT6LqBtBO9yR
X-Gm-Gg: ASbGncvA+kvAI4Mcc26pnZA+Bi1gV6QLL4wIpWx4XvWhjXnQwCvzyDDuvH7Dik0QSmG
 FzEFe20hAKsKiSVmuTf7vd9BbF2o9P8Wuk1a4U0bsbNg4FWkTGIkMPpZp0CnqFSFqth48b/0+vd
 y1pk9uLxBLfxJ1Vty+wnYa7Qi6Ys6fVfXxd/HlBIjYNPMoqfeUintdxjv7LFyLoZav3lpy64NJg
 Ud0kUVJbvHo/JsM1DZJj+w0rMgIfBUJTxoOgPdDZosr3sqlL8M9t5j3JXnVaK5M7ii5DMZKWTsa
 q2kCc4l3/7F79xotOH1UpfhmCU0igX/TdgdH3lV8mUEfBQejrOlojg==
X-Received: by 2002:a17:907:c27:b0:abf:6372:5151 with SMTP id
 a640c23a62f3a-abf63725c11mr647644066b.21.1740984148651; 
 Sun, 02 Mar 2025 22:42:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm535eKaLNcFIE3qsEAYQIv2vSZqTx8LH026AAyijdGSjUnu1jYQOdFkwjm4b7ayryfgdUuQ==
X-Received: by 2002:a17:907:c27:b0:abf:6372:5151 with SMTP id
 a640c23a62f3a-abf63725c11mr647641866b.21.1740984148309; 
 Sun, 02 Mar 2025 22:42:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf744820c3sm188490366b.31.2025.03.02.22.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Mar 2025 22:42:26 -0800 (PST)
Message-ID: <b64bc541-e23c-4a41-aaf5-bdd1ab16c69d@redhat.com>
Date: Mon, 3 Mar 2025 07:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] vfio/migration: Multifd device state transfer
 support - VFIOStateBuffer(s)
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <96303daed289e9c7a3261590027d18e425ea07c2.1739994627.git.maciej.szmigiero@oracle.com>
 <9bc9f288-6db5-4229-9a16-7e8842604c55@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9bc9f288-6db5-4229-9a16-7e8842604c55@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/2/25 14:00, Avihai Horon wrote:
> 
> On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Add VFIOStateBuffer(s) types and the associated methods.
>>
>> These store received device state buffers and config state waiting to get
>> loaded into the device.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration-multifd.c | 54 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 0c3185a26242..760b110a39b9 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -29,3 +29,57 @@ typedef struct VFIODeviceStatePacket {
>>       uint32_t flags;
>>       uint8_t data[0];
>>   } QEMU_PACKED VFIODeviceStatePacket;
>> +
>> +/* type safety */
>> +typedef struct VFIOStateBuffers {
>> +    GArray *array;
>> +} VFIOStateBuffers;
>> +
>> +typedef struct VFIOStateBuffer {
>> +    bool is_present;
>> +    char *data;
>> +    size_t len;
>> +} VFIOStateBuffer;
>> +
>> +static void vfio_state_buffer_clear(gpointer data)
>> +{
>> +    VFIOStateBuffer *lb = data;
>> +
>> +    if (!lb->is_present) {
>> +        return;
>> +    }
>> +
>> +    g_clear_pointer(&lb->data, g_free);
>> +    lb->is_present = false;
>> +}
>> +
>> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
>> +{
>> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
>> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
>> +}
>> +
>> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
>> +{
>> +    g_clear_pointer(&bufs->array, g_array_unref);
>> +}
>> +
>> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
>> +{
>> +    assert(bufs->array);
>> +}
>> +
>> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
>> +{
>> +    return bufs->array->len;
>> +}
>> +
>> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
>> +{
>> +    g_array_set_size(bufs->array, size);
>> +}
>> +
>> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>> +{
>> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>> +}
> 
> This patch breaks compilation as non of the functions are used, e.g.: error: ‘vfio_state_buffers_init’ defined but not used I can think of three options to solve it: 1. Move these functions to their own file and export them, e.g., hw/vfio/state-buffer.{c,h}. But this seems like an overkill for such a small API. 2. Add __attribute__((unused)) tags and remove them in patch #26 where the functions are actually used. A bit ugly. 

>
> 3. Squash this patch into patch #26. I prefer option 3 as this is a small API closely related to patch #26 (and patch #26 will still remain rather small).

I vote for option 3 too.

vfio_state_buffers_init is only called once, it's 2 lines,
it could be merged in vfio_multifd_new() too.


Thanks,

C.


