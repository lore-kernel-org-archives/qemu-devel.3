Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D4CCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYUB-0007Ee-85; Mon, 08 Jun 2026 07:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWYU8-0007Dz-UA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWYU7-0002M3-I9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780919378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nOKj6M8CSTnl6pAYzX0TPbwwLGEsJWrKv5PxQLm/gFQ=;
 b=UKrVnPhF3K2f8SDexsorSsA7O83DEirr05SVPHsICwwWMknL5MsM/tcrA+CQB80OmO5S/c
 D9UAmadIzLEi02QrS3EUr23bh1HEHwDXlj2tj9NdEz9O++iZLZOdh7p56uhmT2VnrRyOao
 d/Dmra8e4DLt97mi9Qd8q1ZT6N6LfIU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-UL5RYG9bPTGyfKwDPvH7Mw-1; Mon, 08 Jun 2026 07:49:32 -0400
X-MC-Unique: UL5RYG9bPTGyfKwDPvH7Mw-1
X-Mimecast-MFC-AGG-ID: UL5RYG9bPTGyfKwDPvH7Mw_1780919371
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490cc1ae292so10818355e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780919371; x=1781524171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nOKj6M8CSTnl6pAYzX0TPbwwLGEsJWrKv5PxQLm/gFQ=;
 b=A4bg0F2biFJYDemt2rt/5cWiDhp1YgqEjVZJZWDeOcNKWhIFQKEYq4qPguQeanRLYu
 SN2ST4siXQ5TGvVdO16ADbkLOuqu2zzwjTyUibhRywgyUBc+Hz9X64dUcQ6fyiflKIb4
 Cr/qZ+NeYUe/LCgySPglNtUoGXfiX6g2gRx0Eu44LFjG6haqO/lMDX5FHk6peeUctZCq
 hdc768FWSqVlcAdYoevbbI1sv89MH/mHTBt9RFArG9siCIw6v46pYcM5SGYTsBRurnyV
 SZ1f1yoU6GXw+uwi4cRtRoZV/YOCnAB7ECFVX5E4nBmaBD/puNQB+GxF/ykM8KdBL1vo
 1whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780919371; x=1781524171;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOKj6M8CSTnl6pAYzX0TPbwwLGEsJWrKv5PxQLm/gFQ=;
 b=Bsan7I6EsUzxRkJuG3LS7Xa7HamuJ4l1T0nTxvUBoK78JCPsltjGc28qPT+kzmA+L5
 +OunwtHqER/U6xsdiSjvAkeTQUeZgd7FBEAoRiNeH7/Ds4HDxieEvxC9rotWkh7Ns+zF
 pvgh4IG2mA/kCOYNjvbaV50ymiQzmgNsYHQqi54yL9xEAqO0y0R3AjfecLziLDCjV0lR
 Faqhgm0I0WInJNkTQMyr3h+WxQLFsSDVK/+m8Ek/IORqWjVhpZbVoNP/gFcnELj8asAd
 9cSmVy32OmJU+CmI4uqymuFTejNcSqitAL/TTTVANxktu76Xk2a3O96rLtxaFwlwEbrn
 Q4qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RIwdZeOgprw8KbXIwCy11JUVWp9d4EnTv/ncawH+O+CSoQSxA9yk9BXZc0m3g4QVNaLdZWutbWLKa@nongnu.org
X-Gm-Message-State: AOJu0YygSz+GjMnZm1hkXoU9S7ZsSIbHASfdyklL40dopHotGF7d47W7
 MxFkw0wpZ8rtdDokO390hSUbNml1Z+Qe1Kavk41MA+HiwM3653Qt30wN3XX3OwZ1hzCtPax0ERj
 5tHzGXwOE6ue3vC8ybE9wP0sh6/299DsAqWpyf/Xwmyrr4ZTi8VJPxhv0
X-Gm-Gg: Acq92OGz5+BNn4iHuosktZKC8Q3ByzALz4Zn9T2Qaf1S6AMVI9Vcpzl7BQnGhaNeX2B
 5y2+lBYB7Xp1Y5Zo59fHDjxOng8wS3LFSA6+02aTebVefMzmpE0WqDiwK4vql1Q7CVQ7m1vR4vO
 z+MeZXZWy4S4fpKPKocSY4ZBL2NWqVyQ3A+G2l0iLcsVXdSVJAAclAA/7pXjLT7BqGTu79e2844
 wNCxLVsq+aRTZX4syRisAh+7xJ1o65IEHi+g/J6tXj/tn0qNr+5MqJspuniErLP9xGdNzu4/ZgB
 8j7yUutW4jbKaZJgVPwSwTfH6jbLcUQvDJNaVsKDEw4VsYzfB2MqpQUZJTwV6YZmDEDRXRfTg7M
 I4/EZx8tS+NlzhksWtQEiZOhAaipoxg==
X-Received: by 2002:a05:600c:83cf:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490c2cc3103mr190011585e9.5.1780919370942; 
 Mon, 08 Jun 2026 04:49:30 -0700 (PDT)
X-Received: by 2002:a05:600c:83cf:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490c2cc3103mr190011275e9.5.1780919370607; 
 Mon, 08 Jun 2026 04:49:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2c9ebeesm227096175e9.0.2026.06.08.04.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 04:49:29 -0700 (PDT)
Message-ID: <daaab4f1-2ddb-4189-b705-2be3907d1e77@redhat.com>
Date: Mon, 8 Jun 2026 13:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 30/32] tests/functional/s390x: Add secure IPL
 functional test
To: Eric Farman <farman@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-31-zycai@linux.ibm.com>
 <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 03/06/2026 20.50, Eric Farman wrote:
> On Tue, 2026-05-05 at 16:19 -0400, Zhuoying Cai wrote:
>> Add functional test for secure IPL.
...
>> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
>> new file mode 100755
>> index 0000000000..0980daace1
>> --- /dev/null
>> +++ b/tests/functional/s390x/test_secure_ipl.py
>> @@ -0,0 +1,148 @@
>> +#!/usr/bin/env python3
>> +#
>> +# s390x Secure IPL functional test: validates secure-boot verification results
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> A general comment, you'll need some form of docstring for the entire file, and any classes/methods
> defined later on.

Yes, please make sure that the "pylint" does not complain about your file 
(minimum is "pylint --rcfile tests/functional/pylintrc ...", better is 
without the rc file).

  Thanks,
   Thomas


