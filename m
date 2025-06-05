Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D65C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN5iS-00053j-LP; Thu, 05 Jun 2025 04:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uN5iQ-000539-V4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uN5iP-0008Nu-GN
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749111163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sf/uKny7bYfSudOqJxZvLz7zbEURioNqRfAuPX7WCUQ=;
 b=hg/ChUQQhKIY8aHApYJYYe5G5ZVe2rGFA8E1IZLE1A8UpxYWQl1AEd2aw6fkJqUlSlT6As
 hpGL1X7RAKoljm1TwOESwxz3RNyHJrJ3hbFOGqoHyisoD6NjfsjPWI9uJUstJPx2Z4fmHm
 1wvOWlYhz/3tgwcaUtYngR4zOsvuwjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-fjjYa6elMACrVufDhuPu0w-1; Thu, 05 Jun 2025 04:12:42 -0400
X-MC-Unique: fjjYa6elMACrVufDhuPu0w-1
X-Mimecast-MFC-AGG-ID: fjjYa6elMACrVufDhuPu0w_1749111161
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so435681f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 01:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749111161; x=1749715961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sf/uKny7bYfSudOqJxZvLz7zbEURioNqRfAuPX7WCUQ=;
 b=LO97LHkWi5z3dmcwuC/IU8Pzem61TRERvro9sHB8dC56LWd1nNkrCiM9lnlETwPNAd
 rRAbWi6+oRFhPnAOQTuynK3N0t+PGE9ixVe2BwiPQb1fv/AGm8KL1g7+k/QQShs217Vx
 3/Fmg8bkktVny9ukEmalX/Ol3VT5rFln4c8TaPNSN47Xm/iCFv/w4hNoT0VnWe2qc3it
 SYXcj1XoohhSOSXgeglqmn2XWvlCH9/bOWnDIG9lI71N7rYnSGjHdAB5JOIz/WIxEkAR
 oDbHT/7QJJnfSnNx2OuDXEyM01XjLe8/hZkFHeoOCDPE7bCj/DUZyN0GtRXf6mUecgrh
 HzKg==
X-Gm-Message-State: AOJu0YxYB/+VBbNqEIHYa5ff/HlgM8Evp9K2tMVa7HVuh20fJ2JuC0+q
 3IQO5bpI/xEvNLwL+ROkymeC2k4bhe8f+jN/55ZAzziPDw3HR+02Kp3tPHVEEb1moJNyHpVsA4C
 8rLrk85CSPDWGIfPJSnq2UF6lWm0KSLIf9QCJjMQllDtBbTE2ew8Hc/1f
X-Gm-Gg: ASbGncuvK6XgqbJrRnXtTDxkqNwduunbvB6Q4+mmJwe4rWuC+dHxGEArzjFBz+8dbAy
 ZC5L5vFhBjnmHb+geuhLSOirZJEp0Qicjk33Fr+COYrFlFLeLlN/Sn9i0eGc9B6HxXAXGECyvLg
 Io5AOtWJSY5BDuG6qCR204BmmIrsZC0ubQh7M6ll49UWjWlXscsPre6E41zxd554hQLTgttuFSQ
 CHQbURRqWAiMOrEKYqZG95Ctp/xPORNzMkoxivGwXTyahFJwSkXlrkuGlDrBOx3bd7cJrl7+df1
 qCEDbn90pdY9SbN6YgtKxUaaTbbc2/IdWCqJ3cFfOWYDLUkpxbMkGljoGO2uUuKmrzz3BZeUSqX
 iZvP9Yd7LVQ3N0JMgZ7W6OtqPo19sU3afS20Z8g==
X-Received: by 2002:a05:6000:430c:b0:3a3:648d:aa84 with SMTP id
 ffacd0b85a97d-3a51d9244abmr5391815f8f.5.1749111160810; 
 Thu, 05 Jun 2025 01:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0hwAhiNK7cHe1jDveyk+fGd7qocOgxUcaJaCVSeLs8/NxEmCVaJTaLGnKCBaDmJ67XjH6Fw==
X-Received: by 2002:a05:6000:430c:b0:3a3:648d:aa84 with SMTP id
 ffacd0b85a97d-3a51d9244abmr5391789f8f.5.1749111160440; 
 Thu, 05 Jun 2025 01:12:40 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f394:e0c:f42c:49cf:c8d5?
 (p200300cfd700f3940e0cf42c49cfc8d5.dip0.t-ipconnect.de.
 [2003:cf:d700:f394:e0c:f42c:49cf:c8d5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a526f4c808sm1625329f8f.28.2025.06.05.01.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:12:39 -0700 (PDT)
Message-ID: <5d753c13-850f-4d42-977d-2f6c8c38b36e@redhat.com>
Date: Thu, 5 Jun 2025 10:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/21] fuse: Process requests in coroutines
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-16-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250604132813.359438-16-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04.06.25 15:28, Hanna Czenczek wrote:
> Make fuse_process_request() a coroutine_fn (fuse_co_process_request())
> and have read_from_fuse_fd() launch it inside of a newly created
> coroutine instead of running it synchronously.  This way, we can process
> requests in parallel.
>
> These are the benchmark results, compared to (a) the original results
> with libfuse, and (b) the results after switching away from libfuse
> (i.e. before this patch):
>
> file:                  (vs. libfuse / vs. no libfuse)
>    read:
>      seq aio:   120.6k ±1.1k (+ 53 % / + 58 %)
>      rand aio:  113.3k ±5.9k (+188 % / +325 %)
>      seq sync:   52.4k ±0.4k (+ 61 % / + 10 %)
>      rand sync:  10.4k ±0.4k (+  6 % / +  3 %)
>    write:
>      seq aio:    79.8k ±0.8k (+ 29 % / + 37 %)
>      rand aio:   79.0k ±0.6k (+ 29 % / + 36 %)
>      seq sync:   41.5k ±0.3k (+ 49 % / + 15 %)
>      rand sync:  41.4k ±0.2k (+ 50 % / + 15 %)
> null:
>    read:
>      seq aio:   266.1k ±1.5k (+ 24 % / -  1 %)
>      rand aio:  264.1k ±2.5k (+ 24 % / ±  0 %)
>      seq sync:  135.6k ±3.2k (+ 50 % / +  1 %)
>      rand sync: 134.7k ±3.0k (+ 50 % / +  2 %)
>    write:
>      seq aio:   281.0k ±1.8k (+ 38 % / +  2 %)
>      rand aio:  288.1k ±6.1k (+ 43 % / +  6 %)
>      seq sync:  142.2k ±3.1k (+ 65 % / +  9 %)
>      rand sync: 141.1k ±2.9k (+ 66 % / + 11 %)
>
> So for non-AIO cases (and the null driver, which does not yield), there
> is little change; but for file AIO, results greatly improve, resolving
> the performance issue we saw before (when switching away from libfuse).
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Sorry, I should have dropped the R-b :/

There are non-trivial changes to this patch from v1.

Hanna

> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   block/export/fuse.c | 194 ++++++++++++++++++++++++++------------------
>   1 file changed, 113 insertions(+), 81 deletions(-)


