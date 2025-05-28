Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A3BC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK7Uo-0003lQ-8s; Tue, 27 May 2025 23:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uK7Um-0003l7-9s
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:30:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uK7Uk-0005HQ-DF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:30:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-232059c0b50so34455725ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748403020; x=1749007820;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NigIgNOlkNGkpxclfR4AgQ+TnVmaAhtTHOhKfV1ebzE=;
 b=1RQhjvIXbfOa43CLPqpMv6+9OCuH0YGoGPr6xT9VjjvnA74BJHjeKg53RnpfDlEbOr
 3bHT7IyffczGVVIoYvTUJiQRO0ArDqJeGwKh8qmg6DjSuf9zslAcbVhUH98oYuOp46V3
 qT4EcInOl01bdQgad/ldyfBt4kCDfVyD9bjDhCvVOf2vnksIcUVo7NvKyTr0IgN/Pf7E
 +UYhTnIE5xpi/9uC4FZvWK9LkttOgzPmPHXCRIXeGhsyAqY4Kzub3oTR7EECNPAcSH8N
 nFRn+PM4Uf7oT0mjsTc7hh8pmldMU8D51xtwo924jrVndGioCa4RXVxbNU3xg2aUGmu5
 7LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748403020; x=1749007820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NigIgNOlkNGkpxclfR4AgQ+TnVmaAhtTHOhKfV1ebzE=;
 b=isCMlb4/DSudvhhBl1+WaCX91opCGIlOtZbFRNJmhZBap04b3hdeTR6axOrMdeejk8
 acMfZw7nrJ0U1aGafc9iOMsLlHgW9OX8UxUjlyMDNMuQQnb+vrX8hSfhacN39GgeWx77
 wkRiSzHU5sseDwlNs/8AHWNC3GjT0nrcps5Bate6jVkKUb1/CK4TDCqdN9OT+sTxtcAs
 I3gdQ/C2/9uAC6OgsEVqUKFQ8vRlzDjtX1LeRbQcNxuNqWFKoqgUDHh9bb/U+7CcfKui
 qSxjjUJ+JmKDUNrJslgvce1mCX0vvGIyqjP7mq6KIhUpWHGLVlKeMaqXDM5oeQScnJw/
 3tjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgjgfic1ezuwAj5F2kreETiz1RFq4+Ywi4xtoyitesbalDolFa/nxflelUw+CdRtpThrCQ0vUXS1S2@nongnu.org
X-Gm-Message-State: AOJu0YzSzk155QJo1pHAfxDXT7B/ts0uL4NqFpi32EqtRBDv7DYxEgG/
 k+3EU+HaJs5CzTw2i9v/9+tKsogS8ruF7Nd6GCjvMgAL/aCZpMgZ9jQYeuzRaCdtKn7MpnIyikK
 kc0M3
X-Gm-Gg: ASbGncvYg8ZWj9Zxpudat1HD9+7eJzs7hE3WCNB/Gdr6HswIIYcKYqQyF+gbdF3u5nv
 b2xBMxY0gyUrYdruKJDvOnmaiEfvZUr2vBH66weL1l6AO/NZuv1zcbA8drHEh26nEKZKF2i5R2C
 3q4e+8xJ3QHLamSxevNqRAozeMaTZP/jRr/tJRK15HCikWVSovNFZviNJbbYWmYeiYRxnDIBkKb
 nKNfww9Ru2GiK0+yuCi7riatwf2XnM13QQ8pJfFAGM3GsO9YRjEqOgR49rs5eaiVbSVH2QjymzV
 HOMuIerMaRE7IUuP29raA0eouTAdafwXBl9FWTqCtQQ1QExpzwXt4wsw5SuTEg==
X-Google-Smtp-Source: AGHT+IF8VeDAJqhzlIj3gRGOOwy9aeFJacSDaL/RyFDxk2AhnVsMmC66f8rQUdgrp8Vjb2tqT8mYvw==
X-Received: by 2002:a17:902:efd5:b0:234:a139:11ec with SMTP id
 d9443c01a7336-234a1391521mr41394995ad.20.1748403020553; 
 Tue, 27 May 2025 20:30:20 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234d2fd24a8sm2015515ad.7.2025.05.27.20.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 20:30:20 -0700 (PDT)
Message-ID: <f510a84d-8f3b-46a5-914c-98e9bb44c8d9@daynix.com>
Date: Wed, 28 May 2025 12:30:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Improve futex usage
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <aDR_J5iYsSlBTDJm@x1.local> <ceac6afc-a300-4ca8-a14e-7f60b31b75a0@daynix.com>
 <aDXCI2Xo3sNM27DG@x1.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <aDXCI2Xo3sNM27DG@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/27 22:46, Peter Xu wrote:
> On Tue, May 27, 2025 at 11:09:08AM +0900, Akihiko Odaki wrote:
>> On 2025/05/26 23:48, Peter Xu wrote:
>>> On Mon, May 26, 2025 at 02:29:10PM +0900, Akihiko Odaki wrote:
>>>> Akihiko Odaki (11):
>>>>         futex: Check value after qemu_futex_wait()
>>>>         futex: Support Windows
>>>>         qemu-thread: Remove qatomic_read() in qemu_event_set()
>>>>         qemu-thread: Replace __linux__ with CONFIG_LINUX
>>>>         qemu-thread: Avoid futex abstraction for non-Linux
>>>>         qemu-thread: Use futex for QemuEvent on Windows
>>>>         qemu-thread: Use futex if available for QemuLockCnt
>>>>         migration: Replace QemuSemaphore with QemuEvent
>>>>         migration/colo: Replace QemuSemaphore with QemuEvent
>>>>         migration/postcopy: Replace QemuSemaphore with QemuEvent
>>>
>>> In case it makes things easier.. I queued the three migration patches;
>>> AFAIU they look like standalone to go even without prior patches, meanwhile
>>> it shouldn't be an issue if they're queued in two pulls.
>>>
>>> I am still not sure whether patch 1 is needed at all, but I'll leave that
>>> to others to decide.
>>
>> The migration patches shouldn't be applied before patches "futex: Check
>> value after qemu_futex_wait()" and "qemu-thread: Avoid futex abstraction for
>> non-Linux" as they fix QemuEvent. Merging migration patches earlier can
>> trigger bugs just like one we faced with hw/display/apple-gfx*
> 
> I didn't see anything like it mentioned in either cover letter or the
> apple-gfx patch.  Could you provide a pointer?
The previous email had a URL at the bottom:
https://lore.kernel.org/qemu-devel/a8b4472c-8741-4f80-87e5-b406c56d1acd@daynix.com/

This thread discussed a bug of QemuEvent and reached to a conclusion to 
use QemuSemaphore instead to avoid it. This patch series intends to fix it.

Regards,
Akihiko Odaki

