Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F0DCEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLPMd-0007dv-I8; Tue, 18 Nov 2025 12:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vLPMV-0007cB-VF
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vLPMU-0007aW-2v
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763486365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gwWe7l3hq80W4gg9CqHx5LL4WzS4y9HtAhcGxpMRhU=;
 b=bKNKsCOiS2Znrm0AX+VX3hMeYF+cYDbKDyz73ovZt0f5yB6VaOAGEO+dSpuHr9J4NuFYGf
 toOkkBSXsQQ4TBsISdYdTiP3wxMmkd176ZzgAVHx3YNHd3cw9kMn6eRnJkj8ltqxcpt1IG
 ZhNBlao9ojvMcrL7za+G/uccJUaCgCY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-DIlMMGR6MPCnNIzMfPQFKg-1; Tue, 18 Nov 2025 12:19:10 -0500
X-MC-Unique: DIlMMGR6MPCnNIzMfPQFKg-1
X-Mimecast-MFC-AGG-ID: DIlMMGR6MPCnNIzMfPQFKg_1763486349
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-640c4609713so8615389a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763486349; x=1764091149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8gwWe7l3hq80W4gg9CqHx5LL4WzS4y9HtAhcGxpMRhU=;
 b=ouzhNY2YAwtLGKdxAEFaD0uKjtJkGrN3NnfYuypPxdypezXNlnqVxRKXTcu2QjoxLs
 PoEL8VJFHUHd8O0ehm4IsWTOZeWxuH830K7wS8ijZc+tdqjaAK17lk6OoPAtMgkZKtef
 eiRj9/gwJKc5Y9m6StiYZmV6Pd9DihNMMcaQ6/r4nXjhVLUtnQYQ/F3B8QdUPoxV32GF
 AqLHzUtIp0WMh4jpTB3t9erBep9jIcF0OcDNgS9dNkCXKPwl/v0JhxaFhlPcCBkR/IhS
 Gf2hs+6M9SYM/1ufmVDEvroSa+54A5eojFDdzAhUyPft9uObfxq2YRX6+MddddVCgjwj
 ZKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763486349; x=1764091149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gwWe7l3hq80W4gg9CqHx5LL4WzS4y9HtAhcGxpMRhU=;
 b=hyvdyrmKuJ4hLl0LO77N5IAbUPRcXA371a2Wt86o91/aI8g3Ka0B/kgPgtmrZQf03i
 LVTh/54JLjWaa5WdLvcA5bbBr/PX9haTraaNLDl5/pazMbYe24HqK++fC7OFcdTH0qWF
 uEJEeAkrw1LRBqOQjlPWHy3a/xZLS9MqNoFev/KwabYIvolyIg+7ncKWT0AMEUmsZfWC
 k+1bU8hAywCifTWgNx79Us2BNZ8K7i3L+AQL24H2sOxFuojqrAStZtleN99FGiyHdysH
 qSd6xuLbM7AJ3mTG67E23P8rK8VLApyv4YDI77UeR+JmFfFejLYJNg+X5Q9C1Va751ty
 PXiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW3D99IvK7bQefYUZT76CccrP79WitenEz/6fhaxLS4nSA3vksWmuUFSbjThZ8sHxl2iJtJ/815JLy@nongnu.org
X-Gm-Message-State: AOJu0YzW/1BxsyZUBz1VV/pO7OhwxSTTWOMl5363fehkT5YnYLCnVdtq
 g5AG0M7ycFYcshNhZIGlhl4+NGuiAYJEIfv9yx8RMyTrEaVN16m9ESeI7ONCatvpydAt/UGkO1f
 l1aHDwAhiI0Hf78FAxpPoXevaXzcoUHkNbJmTAREVycdRwPuyYoN/vnil
X-Gm-Gg: ASbGnctHzt1gXuVkwONxM8NzFv+8LuFie6L4mzJ6yiVJMmHe9rW55uIt1iVEVpx3rVs
 D5qXxopnyG/j5J31IZmLJuOB+WS4yYXKbcavylr0f3lryDLTBMABfoe59w5RCE7RCfjkfx6VseQ
 cZURIYlnS0PRJLw0RY24qUvm6ePmKbKJ+V+HAh8UPVcfPubUQdGTMWC4EVv4ZZ2ngIIZgRHrf1D
 qkKklpKUabwuN2n1KRS0XYlB+PRO++7Z38uxVIGI5JBRfJVaoG0/LuaRiSjqSkIm2ron/vVdgjq
 1z8ShHKYdpQIZsMT+5EvqjRjwFg0Gy4SodjUjDo04cyIDmG/W9rHJIp2Q6c9ArYUnSP8ydlGKLR
 /hir8z77Bqa3y7bdssNTdfxMnqZ2TbdfO90q48YKYnGqFNOC3ukWr2qBhXAoAy+VMZHdXEFB7NI
 2eZqyVRHfFSLaZ1eOEhyjzwN1IzVXMHLAArliyE9g=
X-Received: by 2002:a05:6402:27d0:b0:640:d061:e6b1 with SMTP id
 4fb4d7f45d1cf-64350e1df7cmr16688383a12.10.1763486348617; 
 Tue, 18 Nov 2025 09:19:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExbKjH8XJoUM2hYZqa3Kdgidq8Y9mIV1GQ6698xrpXNU18FJNA66p1QkpRj3+jc/o3W2exdQ==
X-Received: by 2002:a05:6402:27d0:b0:640:d061:e6b1 with SMTP id
 4fb4d7f45d1cf-64350e1df7cmr16688356a12.10.1763486348222; 
 Tue, 18 Nov 2025 09:19:08 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1f76:905c:29a8:188b:2aad?
 (p200300cfd7171f76905c29a8188b2aad.dip0.t-ipconnect.de.
 [2003:cf:d717:1f76:905c:29a8:188b:2aad])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a49806csm13107868a12.18.2025.11.18.09.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 09:19:06 -0800 (PST)
Message-ID: <71efff01-5353-4d50-9779-51cd1e813d4d@redhat.com>
Date: Tue, 18 Nov 2025 18:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/19] qcow2: Fix cache_clean_timer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-13-hreitz@redhat.com> <aRs2OSuFy0HyW4EU@redhat.com>
 <7a3dc3f2-cded-4e2f-a914-938acd52576f@redhat.com>
 <aRyniMgeFyZMcU6q@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aRyniMgeFyZMcU6q@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18.11.25 18:06, Kevin Wolf wrote:
> Am 18.11.2025 um 12:01 hat Hanna Czenczek geschrieben:
>> On 17.11.25 15:50, Kevin Wolf wrote:
>>> Am 10.11.2025 um 16:48 hat Hanna Czenczek geschrieben:
>>>> +/* s_locked specifies whether s->lock is held or not */
>>>>    static void qcow2_update_options_commit(BlockDriverState *bs,
>>>> -                                        Qcow2ReopenState *r)
>>>> +                                        Qcow2ReopenState *r,
>>>> +                                        bool s_locked)
>>>>    {
>>>>        BDRVQcow2State *s = bs->opaque;
>>>>        int i;
>>>> +    /*
>>>> +     * We need to stop the cache-clean-timer before destroying the metadata
>>>> +     * table caches
>>>> +     */
>>>> +    if (s_locked) {
>>>> +        cache_clean_timer_co_locked_del_and_wait(bs);
>>>> +    } else {
>>>> +        cache_clean_timer_del_and_wait(bs);
>>>> +    }
>>>> +
>>>>        if (s->l2_table_cache) {
>>>>            qcow2_cache_destroy(s->l2_table_cache);
>>>>        }
>>>> @@ -1228,6 +1312,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>>>>        }
>>>>        s->l2_table_cache = r->l2_table_cache;
>>>>        s->refcount_block_cache = r->refcount_block_cache;
>>>> +
>>>> +    s->cache_clean_interval = r->cache_clean_interval;
>>>> +    cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
>>>> +
>>>>        s->l2_slice_size = r->l2_slice_size;
>>>>        s->overlap_check = r->overlap_check;
>>>> @@ -1239,12 +1327,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>>>>        s->discard_no_unref = r->discard_no_unref;
>>>> -    if (s->cache_clean_interval != r->cache_clean_interval) {
>>>> -        cache_clean_timer_del(bs);
>>>> -        s->cache_clean_interval = r->cache_clean_interval;
>>>> -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
>>>> -    }
>>>> -
>>>>        qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
>>>>        s->crypto_opts = r->crypto_opts;
>>>>    }
>>> Is there any specific reason why you move cache_clean_timer_init()
>>> earlier? I don't see an actual problem with the code as it is after this
>>> change, but s->l2_slice_size is related to the cache in a way, so it
>>> would feel safer if the cache cleaner were only started once all the
>>> settings are updated and not only those that it actually happens to
>>> access at the moment.
>> Oh.  I don’t think there’s a good reason.  I think it makes sense to keep
>> the set-up in the old place.  Can you do that in your tree?
> Yes, I changed it back and applied the series to my block branch.
> Thanks.

Thanks a lot!

Hanna


