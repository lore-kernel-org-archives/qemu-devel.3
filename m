Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382DECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLNN-0001pI-Tx; Tue, 04 Nov 2025 13:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGLIM-0003Wz-9s
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGLIK-0007Zv-DF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762279089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hO2ZxDGcAKZ23Ssu3WVWsw3gf9apnZ9oT5yGcKkd1Qk=;
 b=iS99C/pxbCJM6NSL9irEUqS8GPi1FgZJhivy/ntNmcdOqa825mfTO/WvGpeUyJekhyQTo8
 oljTVtnupq2IzsZTTGMv+cy0Jb5Ojat7wAkKaL+3VGSTtn/kIcKTkCOZJ69Nn5eNRoO+V6
 Y6VsLsnsXYtmFj64Ac6gdI3WiUp/V9o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ZrIOKdP1NQGlFSYMJcXLgA-1; Tue, 04 Nov 2025 12:58:08 -0500
X-MC-Unique: ZrIOKdP1NQGlFSYMJcXLgA-1
X-Mimecast-MFC-AGG-ID: ZrIOKdP1NQGlFSYMJcXLgA_1762279087
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b4813c6cbeeso543153066b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762279087; x=1762883887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hO2ZxDGcAKZ23Ssu3WVWsw3gf9apnZ9oT5yGcKkd1Qk=;
 b=n1+o//z7NyUhQgNiK/+xvu2D282YOvqNqGz14vrfq7zvd0E/IdkQgTg4mOx/nqyD2C
 bvbhM+1w+Wyw6D/5zjiqnLmLew6YFDwlX7m4+I8GFpvBf+zB02UwLMK3CWVGWuUTqpzh
 gFIVxbvJChR88inyPsJU87xMiiP/QFh6kKpg6zqfmfzwZxATERMQJ1eB0SZJSdlXspd5
 LSdld/xMFnK4GNZuzaEfC3A+kRpPz8dlOyXY8UrVLnzIk8W7I5SbPnD5VZpOrdm01JFk
 HQywc/P+EcC7xDPxJfeeAiGOwwzA18hVymWaufw3/LJzIR+t3x3zmfQ3w/UXFehiH+sI
 3vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279087; x=1762883887;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hO2ZxDGcAKZ23Ssu3WVWsw3gf9apnZ9oT5yGcKkd1Qk=;
 b=WNByDKA+3mYgDD0b4nhhQ+suuRe3kZWqJ10K+TT9u12cAmsmPrR+q4lNDuyq8tuePm
 CirM0HqN7IjY/pky3NS31lMekaoqIkOSGT7oVlV2kE8hF+AqPnnjEZDuJVZa1HLz5Z/O
 oNm635Y29TpHQ0hS7ks0Tso0C/SnVK4OdF7h5nym/AqthpjY0gzs324tlDisKltEBGQP
 EmKsglGTdatnRHHlcP9/fez1ltRDTd3EG8yRhmkLRdI6np/A5NeRbgKhzdgR6dbyCxT+
 qngtrhpeMgPgqtPTiltVB1BvFp4dYzu8e/mRW6wM2SauAKCCu3s3DrgwMpVHzwUFpOTY
 1j0A==
X-Gm-Message-State: AOJu0Yyt4jkVPk9xZ4MzTmXBbMp7rnxT77fZRTHox31j9mEFlDY/ItM5
 hAxMPqqsxFhlx5FA5pD47GhD7q+Kk2IwLbh8mgI1q+FwG2t9YQJheERm5boPUjyABMuF0AXMfei
 aNhlMhDqRkbiX/SglPtKNvQHb0stZljsH2mdKGNsB4LCT4qQmMppQaBBt
X-Gm-Gg: ASbGnctwo05JLdjQX513lUIuGG5UbNwKo0zxcM7kpHv2NK52TnpTBa34mCyqTAM6UiE
 fir1EuDb0ZpAaKqIQuk0Pe4jCW8ij5o91IDLTqngWT+U3GkDBYsKmvrZ2UiC/eGM72shd6WKaIY
 RU+KyV1XaL8EfyMmrERU51Mj6jd1Vdpby72y0YwU1R2LQ55xyTx3Iqro6N+3oG8rAiOElFqOadm
 Mj8awi2T0Jdo7F6UMSCnzgDbzZVxvMah7VzJ8sPp8F3lMhmWHUnsSNimoE6W519RugBQAzuW3vO
 zTJXeDzm/6Us/IMqj/8juzr4lrbytApkiFS2wIg4AI+kRtHA2LRKC1dbG7I8h5Nu4WBHrNye
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b72655edfabmr1373666b.56.1762279087352; 
 Tue, 04 Nov 2025 09:58:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9kCSGNpSpk5q5qDuT96lHeb8DjD7rNeEdqqO3Ycf1S5xW1IrzUcE/+D81rfvmSgqmxkWs5w==
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b72655edfabmr1372266b.56.1762279087003; 
 Tue, 04 Nov 2025 09:58:07 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.171])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723da0f43dsm268456166b.30.2025.11.04.09.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 09:58:06 -0800 (PST)
Message-ID: <c4004238-eb2f-4862-8ccf-5cf181db01f9@redhat.com>
Date: Tue, 4 Nov 2025 18:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS spring-cleaning
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA9oUfFSFXrN+swbCtr4LV+S+-DuUjdP5miGnSbkCt2ZYA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9oUfFSFXrN+swbCtr4LV+S+-DuUjdP5miGnSbkCt2ZYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/11/2025 18.36, Peter Maydell wrote:
> I just did some analysis of our MAINTAINERS file with the aid of a
> local copy of the public-inbox archive of qemu-devel, and (unless my
> scripting is broken ;-)) of the 258 emails listed in MAINTAINERS,
> 50 have not sent an email to qemu-devel in the last three years.
> 
> Some of that will be things like "the address somebody uses to send
> to the list is not quite the same as the one they have listed", so
> it will need some manual checking, but I think this shows we could
> use a bit of spring-cleaning of the file to remove stale entries.
> 
> I propose to send some (not cc'd the list) emails to these people,
> asking (politely!) if they're still interested in being in the
> MAINTAINERS file, and treating "email bounces", "no" and "no reply
> within a month" as "I'm no longer interested in being cc'd on patches".
> Then we can update the file accordingly.

+1 from my side - sounds like a good idea!

  Thomas


