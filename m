Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F80AC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62bP-0006av-Jh; Mon, 14 Sep 2026 05:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x62bK-0006an-64
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x62bH-0003bL-UW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789376622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuG/G1VTsKxc9ojkZza2NFggEEKywNjB2BpIlUIM9D0=;
 b=dEtNrgbRc0+C84u5c+YXeaAS2fDsi5erXc2rmrUpClZwFnZGQx+Uhu5jSe7o/AfagUfN74
 x+MbQgNRaqEd1W6pRuZ2ZgNIIWrFeRQVj4l18Y8o5p6/HdXWpPOZVA5FfggAE2jk6hlSvJ
 f+4ju/bnCJkRAJ7p2ZWcPLnxlhj54WE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-yC32JF21MtmSSzTw7qgeiQ-1; Mon, 14 Sep 2026 05:03:39 -0400
X-MC-Unique: yC32JF21MtmSSzTw7qgeiQ-1
X-Mimecast-MFC-AGG-ID: yC32JF21MtmSSzTw7qgeiQ_1789376618
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486fab65b35so729860f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789376618; x=1789981418; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RuG/G1VTsKxc9ojkZza2NFggEEKywNjB2BpIlUIM9D0=;
 b=sm9Qtz1DyL/LFRUk+u7eZN8owoq4nQJ5Kp2o0QmK7z8HwU77OCdnVOFAeEFSqG1PFI
 FUBudaptjIfZrrDMSbyvY5dgQPA4LC8BsgPTuk1uEQ1isjEFUoBpLG1KMawnBn+C+Hp0
 +b/0a3ZE/M5gwM5F7Xk2d74WAsTdQlII8jS2gM2mqbHyNInLbkhQTAQtE7pN5yGM+sDb
 s9uZlTwzttRWhU+behbUHo5bRJPcgqy86d7BGBEdF71r6CO01DIpBjTcoK5+/qCo6dQn
 gbr3vdC5ZE/epKNAF9zwu/TjVa8wEQMpwZjIRzyRZV2sd7dCTwndT3PPQeVXhcsPfWUh
 RkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376618; x=1789981418;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RuG/G1VTsKxc9ojkZza2NFggEEKywNjB2BpIlUIM9D0=;
 b=TTx3WNLwEVna+vAVm3B59oQ+c+eeuIvae89mps0CIJVD/y/bv+9YZwoyMKjEcHpX4e
 Y+xYOOM+HUbCnyqCngHal5N+8wFElHCf5Rj6eGcFAPZdVyoUBuR5o0RmPIb5DtfTo7XD
 c9CUBTvAXplglHRLHUGAImHOgtwBmV++gEOdQDMd5itQYC+5JBRsp41UXuPZIeqF4OcD
 +TFcAlYCr2DGkKwg7Sd+kNaiWtIi8JtD/2iiAYK/WAZ8Cj1558BfK5wbaJRqSDwnrhLq
 RA5QCpU3cG5lGvCwS0eE4wlgzYMiss7v+GSEvUG67fM60jUv5Oz81kioaGah7WdzKzLW
 vHOg==
X-Gm-Message-State: AFuF++kryBgtH6UW18o0ecXj8MGoiYJr3asTocPdqXbJinuY7uPQ6Tff
 GCwOQdkAIrfiKFaWuEwo7mY7ENHrGQP8NjJJi4Sw6nLObwqciHmHHRjHYLIikczaaRYy577Gc6U
 8b2HRp46D+JfxGLW9Q3NnQNLOVk0pNgnEX4GuKuzMGYWy2mHmEGLdP6fe
X-Gm-Gg: AYBFou3EcaLLY6jUJipNZTuTw4zsCFmXEBu20a1FYMRIq1aHOMA94Md/L35OkATCN8e
 bUVF2SR+EAlqim9a+mPQxXcbl6qfc2hihdbVrLbwjKhw11Nfu8orJBgMYwvXSWX04AMHD7HBrQE
 NXS3RGEgVfa3PQI9JfEA8ArZw1y3MVUCaxMA5pNtigW/eP6IWIdkALiSeqK3McsNHQUxmaNL3yE
 VNgzpsz4MoEnuWIisliw3HfMb97XT4J/VUgkBMgmRPXZtdAtehiBy4Thkug8qcTeQU/DYYkHeZQ
 DdtVam17V3VbvcixwadF167EU+Rt83t28mHb4hVE8dY6J47fAKaGjeN3IOOxwTB0mI8kGW1PIQo
 zITuPnYtd/EUUzO+1hON9tAXIEbrRpucvaGmXWY7+WDnVmA==
X-Received: by 2002:a5d:5f8e:0:b0:485:8a46:b3ce with SMTP id
 ffacd0b85a97d-48702b8316dmr1434160f8f.54.1789376618432; 
 Mon, 14 Sep 2026 02:03:38 -0700 (PDT)
X-Received: by 2002:a5d:5f8e:0:b0:485:8a46:b3ce with SMTP id
 ffacd0b85a97d-48702b8316dmr1434106f8f.54.1789376617887; 
 Mon, 14 Sep 2026 02:03:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25267014f8f.9.2026.09.14.02.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:03:37 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:03:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 05/10] vhost-vsock: preserve vhost FD during CPR
Message-ID: <aqe3npSbJDwkeng9@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
 <ap7Gc_L0gYkAaZiV@sgarzare-redhat>
 <fc5bf943-68d3-4768-bf9e-cef14c81a0e4@virtuozzo.com>
 <aqOu-wrcPrqSpHl0@sgarzare-redhat>
 <1d7c8444-a566-48ae-8c62-4a5e1adf3528@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1d7c8444-a566-48ae-8c62-4a5e1adf3528@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 11, 2026 at 07:35:31PM +0300, Andrey Drobyshev wrote:
>On 9/11/26 10:37 AM, Stefano Garzarella wrote:
>> On Wed, Sep 09, 2026 at 07:59:55PM +0300, Andrey Drobyshev wrote:
>>> On 9/7/26 5:55 PM, Stefano Garzarella wrote:
>>>> On Thu, Aug 20, 2026 at 02:39:50PM +0300, Andrey Drobyshev wrote:
>>>>> During CPR (checkpoint-restore) migration the guest keeps running on the
>>>>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>>>>> we should reuse the FD from the source.  The FD is saved in the CPR
>>>>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>>>>> target via cpr_find_fd().
>>>>>
>>>>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
>>>>
>>>> mm, are we sure the device ID is unique?
>>>>
>>>> I just tried this whitout receiving any error:
>>>> qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=vsock0 \
>>>>      -object memory-backend-memfd,id=vsock0,size=512M \
>>>>      -device vhost-vsock-pci,id=vsock0,guest-cid=3
>>>>
>>>> Stefano
>>> You're right, that seems to be the a real issue.  In fact there's even a
>>> UAF bug IIUC, stemming from the fact that we: 1) provide key destroy
>>> function when creating the CPR hash table; 2) use same CprFd for both
>>> key and value.
>>>
>>> That means that when we have several devices supporting CPR with
>>> repeating IDs, we do:
>>>
>>>  g_hash_table_insert(table, fd1, fd1);    // table has fd1 -> fd1
>>>  g_hash_table_insert(table, fd2, fd2);    // table has fd1 -> fd2
>>>
>>> Here fd1 and fd2 have same hash of course. According to GLib docs [1],
>>> value is renewed in this case, but the new key is destroyed and the 
>>> old
>>> one is used.  As a result, fd2 is freed.
>>>
>>> And, mind you, this all happens long before actual CPR, cause the
>>> devices with CPR support usually call cpr_save_fd() somewhere in
>>> .realize().  Thus we get memory corruption right at boot time, plus
>>> subsequent CPR will likely crash.
>>>
>>> In these circumstances I'd personally prefer just asserting on repeating
>>> key somewhere in cpr_fd_hash_insert().  The only downside is that it'll
>>> crash when booting 2 CPR supporting devices having identical IDs, even
>>> if the user isn't going to perform CPR.  I'd say it's acceptable, what
>>> do you think?
>>
>> I'd prefer an error if possible.
>>
>> That said, can we append a prefix to the key (e.g. `vhost-vsock`)?
>> In this way we reduce the chance to have a conflict. Of course the user
>> can still assign `vhost-vsock-something` to the memory backend and
>> `something` to the vhost-vsock device, but yeah xD
>>
>> Thanks,
>> Stefano
>>
>
>If you mean erroring out directly at startup whenever we encounter a
>duplicate CPR key, with a clear error message instead of abort/crash - I
>agree that it's a better solution.

Yep.

> That'll likely require changing the
>CPR FD saving API, but shouldn't be too intrusive.  As for the prefix -
>once we forbid duplicate keys entirely, there's no need for it.

Agree, but not sure if this break some user that re-use the same id for 
devices in different "namespaces" that will boot, but collide when doing 
CPR. That said, no strong opinion here, maybe I'm overthinking.

Stefano


