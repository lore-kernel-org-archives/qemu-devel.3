Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C20C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeSa-0001ta-8P; Fri, 03 Jul 2026 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfeSY-0001t9-7M
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfeSU-0008Ef-Qo
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783087293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ut9WNz3rk5Is2DBn8GolJnYJYtiL5WqBkLU4CGW0YFU=;
 b=Vr7Mf99/HjCPczk3PFTxZj69QnC3r1jlbM3yycuGqi3V42s0NLInKUQ5CzB5RFnzr7UwRe
 AeJ39LZJnHHm7X1PhzjIifYu5sHHJgtliTpz7uVoF02Q6sf1O9TPQi1L9XQUFUeij3hRPC
 nzwJj5WGD80ubarnbq1cQH0ayAa9Ef0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-XImEk6Z8PtK8Q-Gfsf5cwQ-1; Fri, 03 Jul 2026 10:01:31 -0400
X-MC-Unique: XImEk6Z8PtK8Q-Gfsf5cwQ-1
X-Mimecast-MFC-AGG-ID: XImEk6Z8PtK8Q-Gfsf5cwQ_1783087290
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493caa3c54eso5980475e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783087290; x=1783692090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ut9WNz3rk5Is2DBn8GolJnYJYtiL5WqBkLU4CGW0YFU=;
 b=GptDC944h1QqLc0HcA5dOD2FlfCFv1jC26LPo6eZPNMT91kp66xMZhRNqks83LBl+d
 8zEet/9gylChws0ueLG3XNbB2tunLbkWlT3zQiamn7J+qqfCOvaqnWAORqHnqz7/8EDT
 4v2HzmIihref0LNInPiRP5zc55qzGHABK2y9LMHn/esMlSjSzCq0zJfmNnCYlVsa+Jj9
 s2MVcBVU6pqGcMhXWLPX7N+M3D9dta6SceDkL29J+3p0TVGWvWd/MDUD2hd0PbdQiSok
 mVwJBv+gH8tjxj2DslAHoRTgW0VrVOjn5QJantzkcajGP3kTD8FUUV8saplJTuEwCLN3
 pQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783087290; x=1783692090;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut9WNz3rk5Is2DBn8GolJnYJYtiL5WqBkLU4CGW0YFU=;
 b=fKBLvRXL8FDp0xrEevv9IadSneo4QIl0yTBgFl01VQskKk+Jhfb+1I+znXtfalMXYE
 bK2snRxaI5t9dUQWQzfV4AIO2heU0RNGrQYMwmhOUHo1mTbUmRv3+Wuqo8sucOSbLOSQ
 sYKQMNjmg+KXcKtL+HRcPw8Rx3TOGESx7pnLY1LWPz6bKVdjBX5si2IC0Rt/Gy0gI+b+
 DGwMYrQL52Ba68wKY+tIVmaUcuGHW3+ZI5XsLmbC73l7KNxSx2DFCQ17YlLrZ8rmH0Pp
 9JL6bkyqnVbGYR5RZoZWDYkGl5oKnzYykJ/o2wGhhVdyPuzCiOv1yVYsEgqsWHqArUfS
 Yr5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JEDdVnHCOPh6wIVoqp8cpK+h21CszItNR28Y54jLTUEhLX5F0cgz1lX3qCRaKMkx8YeOZv0TXYFym@nongnu.org
X-Gm-Message-State: AOJu0Yz2kmyYkcl1jTNDeco8c7alfESzNNAGPO7fVwSGDpRkbN0yBYR/
 /W7GUKl96hbpfVSSMwqwMLcXKCz5Oo1c7hNMOzG8IXs3f8Lgfdo7cuSe8FIwl8uCGWSHnFOEKy9
 XFuVlQ0Y9QqCLxGN05RpAKk9U+NyUpAiqKk/lUh5cvRcKDl/lV3GGLC7g
X-Gm-Gg: AfdE7cmYIfthiDZr7CdEwf3ACzoEMIeEcoirn/usGhxCiHVHw97e/mJaC6ltawOMV5K
 xyKiSSeeH94ObQjGnAqrVzPoy76QzVdm/ROh2fvIJCeZqL6T2/ByZQOEm4sIUJh7P5BMMpATmc4
 2+bPGXVzHqVc8XQbwnvZjvok19YeU0M9t6lrnnDd4OnIlMn2aeqDMcBdHJWJzgSuolCLYlYofUk
 UnNcGSO2es+lhObHu4/tBBzlhMWg9LE9fkKHg4VWshjfkQaaK5t1Fs7wastNIbbDWhQ8OKKLobm
 yFh5mT8M+2+BmaczZZ1Gr/1LAuZ7yDzceAdFtD5J+hd5u0zJfeg63S0AYxsMk/qW3wESB99Q4HR
 utHU/yLM+Cm62DONzLpNc7xoctFG+8je/mmn7MQWSCgFwVUfYaQ==
X-Received: by 2002:a05:600c:8716:b0:490:c024:2ec8 with SMTP id
 5b1f17b1804b1-493d0de258amr611645e9.0.1783087290238; 
 Fri, 03 Jul 2026 07:01:30 -0700 (PDT)
X-Received: by 2002:a05:600c:8716:b0:490:c024:2ec8 with SMTP id
 5b1f17b1804b1-493d0de258amr611185e9.0.1783087289688; 
 Fri, 03 Jul 2026 07:01:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636e9e9sm129906675e9.2.2026.07.03.07.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 07:01:29 -0700 (PDT)
Message-ID: <9ea28269-924d-4996-a886-73f14cd31bee@redhat.com>
Date: Fri, 3 Jul 2026 16:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
 <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
 <df58c2d0-cc0c-43c2-9dd3-ea0614de7d72@redhat.com>
 <e7bd3ab2-2eca-44d6-8a18-29cdbcb57768@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e7bd3ab2-2eca-44d6-8a18-29cdbcb57768@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>> The culprit appears to be patch 3:
>>
>>   migration: Run final save_query_pending at switchover
>>
>> I can reproduce the issue consistently with:
>>
>> while [ 1 ]; do
>>     QTEST_QEMU_BINARY=./build/qemu-system-s390x \
>>         ./build/tests/qtest/migration-test \
>>         --full -p /s390x/migration/colo/plain/secondary_failover_checkpoint || break
>> done
>>
>> The patch you proposed seems to fix the issue.
>>
>> Could you send it as a follow-up patch? 
> 
> To make sure I get it straight, you suggest to merge your pull request 

The merge request won't be merged as is. It's broken and I will
have to resend with a fix or without this series.

> and then send a separate fix patch for that with a proper Fixes tag, right?

We either handle the breakage with an extra patch like you proposed,
which has to be sent and reviewed, or :

>> if Peter, Fabiano, Lukas
>> would prefer it to be integrated in the appropriate place, it
>> could be included in v5.
We can address this in a v5 respin of the series by fixing it
where it belongs: in patch 3. I think that's the right place,
since bisect breaks at that point.

Let's see what Peter and Fabiano think.


Thanks,

C.


