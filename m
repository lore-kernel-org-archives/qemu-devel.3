Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A1CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSs7-0001Hu-NY; Mon, 25 Aug 2025 04:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqSs4-0001Hd-8L
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqSs0-0003Hi-Ej
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756111679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LZhDeaFmkmFdMrfJs1e//348wCej8LAPBG+IDrvkMNs=;
 b=JWzreRS3V2tUclBxPJJcIE/Qzs8YMmDDS2mLTN56UueN6LpjmaHTUKztJWU8ZfwUOMlC0+
 e7vrrfMkaLGdQWyc9rHJ8rTQ6RyJHaLOuV9dVEl06vxe+Myx5peeBzAfb+4c9m8yPaiADN
 2hXB3o/WGUh6thyl8ukRSWbnUiFHTJg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-oV3_tVKfOn61_2TPlQckkw-1; Mon, 25 Aug 2025 04:47:55 -0400
X-MC-Unique: oV3_tVKfOn61_2TPlQckkw-1
X-Mimecast-MFC-AGG-ID: oV3_tVKfOn61_2TPlQckkw_1756111675
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c630eea496so1465811f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 01:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756111674; x=1756716474;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZhDeaFmkmFdMrfJs1e//348wCej8LAPBG+IDrvkMNs=;
 b=xBIVBkRV4HQnIA/gVqgJ/zIyM0IiERUbK+9cC8FQs3TZ4gdaIiUJO3DgAWul4ulz4u
 x2RexphY089QOZeZj/2P4OW8of/0poFYinaxpMv3A0V54XXSxbszHs9mcTbO0SQdj3tv
 mw6h1j0rau6KSXpcFKDf/tsxf0ARdYfRd0/pfJXltn0GONzC8qHTTdC/oo3euCFx3FVj
 9DMDbKKx6kmguGIFX/y3G+u+MQMPxU7XiFNV03DbYO7c1kccCtkT2UXPZP9wJTFG1ebI
 LAPJhYijxmNl81MV7Y0GIE/r7WEpvdotyvrgWYp6wMYgJc9C5LHNdYTSp+Ig/WUQEZFs
 rbGA==
X-Gm-Message-State: AOJu0YzPc9nwj8Zue6YLr5L4gzBev0PBLc2FRf0d3V0y7wJnAidHl4Xp
 wTh4PBtOX5iiiDihGWTb3WogTU1nuAFxakyP/zhyeu5QpPZHOGhd7As2sfTsslnPEb121E6UkiN
 8gUW30btyIZA4YMVsoKG2uZG27uD4Kwd1F42vUhN6c3ZxGV7nBDZZIrzm
X-Gm-Gg: ASbGncvoZTphd4ykH/GJJ5ws1hff8dXjZ38WOSx/1gNg2AKsdK30oNnDVyAXL8x45qm
 Ly1JCZvCeJM1mnkPcUQ05/eEb/M8VM4hwJ2n6gWY7ojuWCeLIM4icpPgLHHXddJCsgzACZLunBf
 T4ZqHsdCPvhPveTk+ut3DWbyL432t4NXPmi18sDSuiS3Q7rV2nkI42rk419D681bGVXwKikx28J
 AEiLMiIv5YXAU5IFm9F76zp3u/VsdLVnzmuzOCBr+J3pww8edQubh+9w995cwKZ2d1JnL9zh3rT
 InF6ItpitJ53e/xCkO0isqp2SaOmTyxa+DifChdEzQP4gqcxVSEfC3fsGZ9Zka3qq7wbOeIfz6U
 v7JU=
X-Received: by 2002:a05:6000:2388:b0:3ca:6a35:140a with SMTP id
 ffacd0b85a97d-3ca6a351747mr569333f8f.26.1756111674520; 
 Mon, 25 Aug 2025 01:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC6xhXpMX9ad9/D4h8vLJlxRnImKPqxrnjK7QZR4ntXfFRqQ3751UAoqg92NsU0dRGuVyT4g==
X-Received: by 2002:a05:6000:2388:b0:3ca:6a35:140a with SMTP id
 ffacd0b85a97d-3ca6a351747mr569310f8f.26.1756111674062; 
 Mon, 25 Aug 2025 01:47:54 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70ef566dcsm10590922f8f.24.2025.08.25.01.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 01:47:53 -0700 (PDT)
Message-ID: <b60a9e7e-6f79-442d-8a4c-2acfbbf0688b@redhat.com>
Date: Mon, 25 Aug 2025 10:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Use more fine-grained locking when
 looking for free ports
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250821094735.804210-1-thuth@redhat.com>
 <CAAjaMXYt4UBS-2wB2OiSCE_DA77STWAjWvPdv=NtEGsUoSyFPA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXYt4UBS-2wB2OiSCE_DA77STWAjWvPdv=NtEGsUoSyFPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 25/08/2025 09.30, Manos Pitsidianakis wrote:
> On Thu, Aug 21, 2025 at 12:49 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Currently, we have one lock that is held while a test is looking for
>> free ports. However, we are also using different ranges for looking
>> for free ports nowadays (PORTS_START is based on the PID of the process),
>> so instead of using only one lock, we should rather use a lock per
>> range instead. This should help to allow running more tests in parallel.
>>
>> While we're at it, also create the lock files without executable bit
>> (mode is 0o777 by default).
>>
> 
> (Unrelated to this patch but the file itself)
> 
> Hm. AF_INET supports binding to port 0 to connect to any available
> port (see man 7 ip). Is this not portable?

No clue ... but in that case, we'd need to go back to only use one lock for 
all tests that are running in parallel, so it might cause some more contention?

  Thomas



