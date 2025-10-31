Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7E2CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnjq-0000QK-FI; Fri, 31 Oct 2025 07:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnjX-0008NS-Kk
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnjL-0006Jo-EY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYI0jWq2juM8beFOA03yWNMGeNMGHrfTC4YnhR8fRZc=;
 b=WHA08jBItIqPkypAClA3yv5IumWiEuIBnil+hT8DnF8WA0sBlibYxThc+YO9VbzCxWcCnD
 hHAFwde27s5b+7x1M2oiUSKHb9dd45uKvyRvFkEKw4on6yIQvXBw4kM9OUWIAhSabhPl+y
 eK42p2V60HHmykpSQ3Jka5wgZycUta4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-JayM_rPgMW6lgH-Fynq0KA-1; Fri, 31 Oct 2025 07:55:36 -0400
X-MC-Unique: JayM_rPgMW6lgH-Fynq0KA-1
X-Mimecast-MFC-AGG-ID: JayM_rPgMW6lgH-Fynq0KA_1761911735
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b707e595229so30301966b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911734; x=1762516534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XYI0jWq2juM8beFOA03yWNMGeNMGHrfTC4YnhR8fRZc=;
 b=jljh0egen7Ch9CLc2popykESMckqmekV8Ql+/rrJb2AW31y61GohrTmsEHp9S0MMxm
 RmdmTfJwkanmZ3/JpxdSPSz2TDInwm1BOafGcrFjkb5KIaGf78+rByZNPJtC2Fs1FnGu
 3HsATM70cx3TIKJ4FBSVbISkSA57b9oEiBgXuqc0QRux6rgja8bPVsYdLuBvwuUB/0ko
 B1tyDfIA/YkKa+cmY669rd66mTb5BCiHiSeGZ62+QGmNKAF34F/4ADsJRWJlqIDdeShQ
 plx9XkDKPKEQhYWkzgWd4z1schtrWHd2oD6qdb5vroyoogP5gtc+Pq6E4Op8bVWg5qm+
 n4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfLUBVi++35UgXAe00TB0mckkLwpHXEG0w6xgDCHDtUmhxgvsNMdd9WycbHWwibzvBS6CXtmIijTTE@nongnu.org
X-Gm-Message-State: AOJu0YzAcmNfv/9cy6VopU7w3CrLCoESIdNGPjWamWUN1ezZ+ZhMdkiu
 jI+E/OQzqMbCW5XjyWmZ2T66QvAsRmQ5xPqMqOG2KPxasrn2DBsvsHOyTs2cUre0GnE3oAHddRD
 sXcw6MMWWyJK7j0FJK7NR2dbdzMvZJtri2PgMXzDkX17RbDM/dOtsG7oXWI5bZZmt
X-Gm-Gg: ASbGncvHX8r0ud8R8rtcWJUCwRbfrj6J/+G0Hzpum8//vxbVdBpyY+aw1eLUr7ryyR4
 Y1vNxiYhE8yvk76jpqx86stKzoZzmV8dZbvolZedXzPd9ELAIlK+b3jDLwsOXUCrZpQySZG/VH6
 SbIt8R2reIp+uZB/ZzI9J1L+pwoJQZ7JzNo+NZJM+Je5QNhdsMfREbeKecPg3RT7Y62bsuilxaz
 ociOd2rAIFyHWGeQ32Pn0F7jSJmCG6gCBB35jovjHobLnyOFarbHTbAD3PHZOyFwecbxZ7QkdzV
 qqVXWt+XYlq5Yfadx6rtUx640AMHTwVi4+g3WSkXB7/0Puot+g80ZTeMo15y9TAQ6bAJiccaKN/
 hXfxCQAPiBttTwUVolGRszN46T8S7iEDEDZzkarvO7ibRe4tW+PA/T1OsYUCYhuLmhdxU8hUOBd
 shNq6mvo6xmQ4Hpx/prxTEyUKjqlz0
X-Received: by 2002:a17:907:d23:b0:b04:c373:2833 with SMTP id
 a640c23a62f3a-b70704c3db5mr312047566b.32.1761911734225; 
 Fri, 31 Oct 2025 04:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9wiRQctIOiI+sgv+VRspDISo6k6zk74bKvuRRQvK1ow8Hf4oyfqlFV0j/GwjWYBsMwlPR/w==
X-Received: by 2002:a17:907:d23:b0:b04:c373:2833 with SMTP id
 a640c23a62f3a-b70704c3db5mr312045166b.32.1761911733833; 
 Fri, 31 Oct 2025 04:55:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c3da56sm157048366b.39.2025.10.31.04.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:55:32 -0700 (PDT)
Message-ID: <1ae7adb0-ba11-4b0a-baaf-135431895417@redhat.com>
Date: Fri, 31 Oct 2025 12:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/21] fuse: Process requests in coroutines
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-16-hreitz@redhat.com> <aPjTv2Mf1ToeFqHT@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aPjTv2Mf1ToeFqHT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22.10.25 14:53, Kevin Wolf wrote:
> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>> Make fuse_process_request() a coroutine_fn (fuse_co_process_request())
>> and have read_from_fuse_fd() launch it inside of a newly created
>> coroutine instead of running it synchronously.  This way, we can process
>> requests in parallel.
>>
>> These are the benchmark results, compared to (a) the original results
>> with libfuse, and (b) the results after switching away from libfuse
>> (i.e. before this patch):
>>
>> file:                  (vs. libfuse / vs. no libfuse)
>>    read:
>>      seq aio:   120.6k ±1.1k (+ 53 % / + 58 %)
>>      rand aio:  113.3k ±5.9k (+188 % / +325 %)
>>      seq sync:   52.4k ±0.4k (+ 61 % / + 10 %)
>>      rand sync:  10.4k ±0.4k (+  6 % / +  3 %)
>>    write:
>>      seq aio:    79.8k ±0.8k (+ 29 % / + 37 %)
>>      rand aio:   79.0k ±0.6k (+ 29 % / + 36 %)
>>      seq sync:   41.5k ±0.3k (+ 49 % / + 15 %)
>>      rand sync:  41.4k ±0.2k (+ 50 % / + 15 %)
>> null:
>>    read:
>>      seq aio:   266.1k ±1.5k (+ 24 % / -  1 %)
>>      rand aio:  264.1k ±2.5k (+ 24 % / ±  0 %)
>>      seq sync:  135.6k ±3.2k (+ 50 % / +  1 %)
>>      rand sync: 134.7k ±3.0k (+ 50 % / +  2 %)
>>    write:
>>      seq aio:   281.0k ±1.8k (+ 38 % / +  2 %)
>>      rand aio:  288.1k ±6.1k (+ 43 % / +  6 %)
>>      seq sync:  142.2k ±3.1k (+ 65 % / +  9 %)
>>      rand sync: 141.1k ±2.9k (+ 66 % / + 11 %)
>>
>> So for non-AIO cases (and the null driver, which does not yield), there
>> is little change; but for file AIO, results greatly improve, resolving
>> the performance issue we saw before (when switching away from libfuse).
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/export/fuse.c | 194 ++++++++++++++++++++++++++------------------
>>   1 file changed, 113 insertions(+), 81 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 8ea590ba67..0648b5bc7d 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -27,6 +27,7 @@
>>   #include "block/qapi.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-commands-block.h"
>> +#include "qemu/coroutine.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/main-loop.h"
>>   #include "system/block-backend.h"
>> @@ -86,6 +87,12 @@ typedef struct FuseExport {
>>       gid_t st_gid;
>>   } FuseExport;
>>   
>> +/* Parameters to the request processing coroutine */
>> +typedef struct FuseRequestCoParam {
>> +    FuseExport *exp;
>> +    int got_request;
>> +} FuseRequestCoParam;
> This type is unused.

Ha, true.  Thanks.

Hanna


