Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074B9EDA6A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSxv-0006PJ-8Y; Tue, 03 Mar 2026 11:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vxSxo-0006Oc-Jc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:51:16 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vxSxm-0008Dm-GK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:51:16 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso990920785a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772556673; x=1773161473;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YuljHJCwgnM/MgZCT52VRQf7EwrmIbExP/h+/BPmqdo=;
 b=qtDNDJShs3db9TolaEJYdWCr3z2Nr4uu/jduvvH57K0D0PBHANvhzjMVBuyaBdLHHK
 ZqIfeGr0jeXVxnkzfqd8obNp06ZNR29EJUdslwZNAAt5Il7j9rqm49NxzwQhXXcDnGMM
 ss2DkPJTV9jwbXak/l9n3jn7AxxnHAJr0qrbsDFIuZ/bWHhO/QUnalU4BPb/jzk4VX4h
 7REeXdV6UcRGfaA5PMBJe6FbeYJkQ6wcm3nBOaprzDAToIfEgC7aP5Hb4AmEmigbkNOV
 YASNTJKPnREwKPOrf14k6augaBjKsKSjZK1Y87p2kd1DqY28VywDvqffiqKMMGjz9Exe
 Yg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772556673; x=1773161473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YuljHJCwgnM/MgZCT52VRQf7EwrmIbExP/h+/BPmqdo=;
 b=KO9scPFjiIGia/+U7Y9E22rrFoHr3hXMNyk/e3CyjU6tuJ7b7hz4f0Ofr8kkbyat46
 9ZLb6bbc6PVlycdd+4vuzWbUvxpV/1eqWME/+LpWYWmRwog4+iJ7Wmtx/hw7oTsoUFg6
 Bk5Yx6aqftWYwket8oX2JKKEFAoP9ZsM6Q6npFyN63RmRkvIwkPI89u/pbMgZplZlOm/
 zlkduG1T2vGyabmtWdalOvwJ47fJ0Ty7uTRWGShEFRVXPw//cxUOzatoxrmGbxpqOU3A
 az8+8nEwMOxFPg5UM34JXh4muhCeui+SucgEKgQPtPiEfl3JTM8mCF9OGHqgrMUDlKJb
 6Lcg==
X-Gm-Message-State: AOJu0Yy/QbkMmhzLMXGwUbJmpcpJolILMH8Md45W47DnxJV/4kfgQyJT
 xIxZk37Vs/+QE8Jynfkv58utiwplf/MDOtXGDQdoGA84pG2O1lbYEe7Pv7ydNGeW3OQ=
X-Gm-Gg: ATEYQzyH+wCl2BjerN52jrtoTVQ8MU6Y5PL48IcmZjHMcPllJEZha+3oBcI1NCgfBhw
 iRC97Kt0opxJ6TwMXQw/Qm6ohA+tMDVNZHFHYYZhB8iOMHD1x4BmG21PvNn2M+iFIIu9XUgtL3E
 Vl1Z32QbA+4NDhPprMsOY19fs5/8YWoqTHcxoy6oLNDPbauPJWdgVlcnbkB2YgJcDCTWH1GfalI
 w8BsZ/HTtK3nyW/KExa1O8WM+MHMJ7sJ4CJVhMqeVqV75UcqlLQLVIUdFUP0SdEqWvGXDM8ihqy
 mkDcrcMgtwHiKKo7UnXoGpF2fEYb3ZNITwv6flv3GCB0d+hcRAVMNZLTqKBdHvwGBSEC0zztQOr
 275YFMXO9E5RTddw1wh0swJBxGSXSHj9PDoOHgQxS4YF2mfeoIBXlyZTgJPr9gyQTc5e7M/SYPI
 3GcvObAJXH3VOONauszleQ8sgeL7syOEZcFIGEl5S9sSUrSDT28IROs30hYixwBkM6RRQh89OHU
 kokpDTX
X-Received: by 2002:a05:620a:4014:b0:8c9:f4eb:ac71 with SMTP id
 af79cd13be357-8cbc8dc49a7mr1726747985a.10.1772556672714; 
 Tue, 03 Mar 2026 08:51:12 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899e53a16c0sm80399996d6.35.2026.03.03.08.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 08:51:11 -0800 (PST)
Message-ID: <287ca341-13a4-4c8c-8bb2-e78dc019c7dc@kernel.dk>
Date: Tue, 3 Mar 2026 09:51:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/2] io_uring fixes
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 qemu-stable@nongnu.org
References: <20260213143225.161043-1-axboe@kernel.dk>
 <3ba732d8-8e33-4bf3-af39-00360c39b940@proxmox.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3ba732d8-8e33-4bf3-af39-00360c39b940@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=axboe@kernel.dk; helo=mail-qk1-x730.google.com
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

On 3/3/26 4:52 AM, Fiona Ebner wrote:
> Am 13.02.26 um 3:33 PM schrieb Jens Axboe:
>> Hi,
>>
>> Patch 1 here is the real meat of this, patch 2 is just a slight
>> improvement. For patch 1, it can literally yield a 50-80x improvement
>> on the io_uring side for idle systems, where ppoll() ends up sleeping
>> for 500 msec while there's IO to submit! I noticed this running the
>> io_uring regression tests in a vm, where I use a variety of block
>> devices for some of the tests. They would often randomly time out on
>> AHCI devices, while running them on a virtio-blk or nvme device would
>> finish in one second or so. I then wrote a reproducer to try and grok
>> this and had claude dive into this, which helped me better grasp the
>> various event loops.
>>
>> Please take a look and tell me what you think. Some variant of patch 1
>> should definitely be considered, but let me know if this is the right
>> approach. I can easily test anything.
>>
>> Also note - this seems to trigger more easily or consistently on
>> aarch64, which is where I run most of my local/immediate testing.
>>
>>  util/fdmon-io_uring.c | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>
> 
> CC-ing qemu-stable since this affects the 10.2 branch. The fixes are
> already applied to master as
> 
> 2ae361ef1d aio-posix: notify main loop when SQEs are queued
> 961fcc0f22 fdmon-io_uring: check CQ ring directly in gsource_check

Yes please, would be nice for them to hit the stable release(s) as
well. Thanks Fiona!

-- 
Jens Axboe


