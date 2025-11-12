Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304DDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBEJ-0007Jb-Cv; Wed, 12 Nov 2025 08:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7m-0004MR-Qz
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:43:04 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7l-0001R1-3J
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:43:02 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b2e9ac45aso540372f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954979; x=1763559779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9ICUTlbA0tmUWzcECPsbgXDdGXb0D2pqbyGVLa4pOo=;
 b=CEyN0qiRU4bOVKkRO/xWBsJP2JH4PH4dVddbpjyhW8WsgxiK9xrq0lCxJQrCz6yjOy
 Wtls1qbp7zUdpV/LZKn8pcoj+2Uk2SOTfSmcvHQbT8AUXRPH5lSJqj3N9GsaZyY3DmXf
 PC2i12UfpqfKbdKodtwzGyig9qQMdzC70XxP8zzVrTGtcTifLc27TU7T19hrohs+Q11V
 2JF2IpKGo75xuAQ7W4P7EPkUjpZgEtsvJk5plxpc/6yBUD5N6B4p6C0/HsZg3InxePfw
 Eo5coLCAo+32wK3e2AyTD5SitjBmz4d2hiPkBcG1HbRnwtSRl9lRbSmmERHS+zBSISX/
 Cf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954979; x=1763559779;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9ICUTlbA0tmUWzcECPsbgXDdGXb0D2pqbyGVLa4pOo=;
 b=s6ab+HkibzK/C75uFh0UKx0UK+B/zFBcdLUdVzUEPJQA082p4cJ1ECCpskS3mNsMWK
 Y2rU+ViKpePRiATddb7UkGEbEP+8eJbS9/TrZ2A3RBICko3ya7x+BjuObmBNFOKpu/wv
 n3NZ/5ePk2c3ybrTl/q2q5Ef0bc4JjSamXHvHjbAaWXe9pVBCXrMkvaXPqDYCDp5kGgw
 AuURTak0lwu//+k8zG0n3Hs6jdB6OcYTHFJZ9eWl/3Yu1gOmxaAPmZu4TvdG/2iazlzI
 UIF4vc3OSVgXIPu8lOP1DeHmlHOMWvRLV6he4jHLCSn3QW5RwPs9uf8aTb0NcPLS8pWl
 miYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTKs3rsuRIXgoVepvN8grccZYfiW1vXXFwbwD/weRKk1W4ALCse8TWAQS0a5mzWSQjDffIipoPysfN@nongnu.org
X-Gm-Message-State: AOJu0YxSCMfnTDZlUCxqPufqdwGr4l5vkf1lv0uIkJ6qXr3dlOx+/dcs
 uuAmiPU18/h88V4hZtCtx29CjtW9g0xIGWKyMOsstlwjSmuts4mZMzpk0zpq+aQYcOQBIoCGxqT
 2iuC1rcQxCQ==
X-Gm-Gg: ASbGncval0ZTcxB8zcZxxMt77hF4en+OlU84ugUogWlmeiU1a2uujOpT2Mmv+JsOgIf
 fBwwg0SPC8x5PXYZ466GYEabHCzbB0znexMhaJ9snt1zOsB4oRiFvQo1bJ13VXmQC5jbP0Z6zPe
 O1kUSec8PW6gpbxC6hGy2LyxnxAORKeQFUvOFjO2f4ISMcUwV1yJn3jjNUp3T1t+bgJsN5jfZRL
 LHvrQEoWlXfKYg2VLTHPaY4dJgolUk+X6Ag/jB0Kg/E7p6FmOE3h1p+pp4Fahc6oYmbnVbyP0PM
 MiUSgwmX3i285gqP+uvt4q80oCveZygOzTiy87/v6C+yMpPHOkrAgJLEy0alrwygHOy708EWJmG
 9fIfF4SwAFridfAoV9WDuQwz2H7T5DnswlTxux5JeqW66bkYjOKS/1TVm8wcfBCbKpAfkupGVqd
 AfKI5D74ZrbBgcztpeh8Kwj9a8x5AfAm6qVyfg3RKs8QjrKg2h
X-Google-Smtp-Source: AGHT+IEt2gdS907V4fTAks1KSby3cp8C0qMTQ5i1/NbcgPt1VyZ7iKswx/AxYtQRQt8ZRkOjCqMh2A==
X-Received: by 2002:a05:6000:2dc8:b0:429:cdd9:807f with SMTP id
 ffacd0b85a97d-42b4bddeeeemr2616690f8f.61.1762954979451; 
 Wed, 12 Nov 2025 05:42:59 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63dfecsm34648215f8f.12.2025.11.12.05.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 05:42:59 -0800 (PST)
Message-ID: <6d5fc070-4756-4d58-ad1e-78bdcfe9db90@linaro.org>
Date: Wed, 12 Nov 2025 14:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/9pfs: Drop unused print_sg helper
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 groug@kaod.org
References: <20251110155424.694664-1-osama.abdelkader@gmail.com>
 <dfbdc47a-6e70-44d6-8e87-eddf5363ff77@linaro.org> <3260517.0rzgI7jUu0@silver>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3260517.0rzgI7jUu0@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/11/25 13:30, Christian Schoenebeck wrote:
> On Wednesday, November 12, 2025 8:03:28 AM CET Philippe Mathieu-Daudé wrote:
>> Hi Osama,
>>
>> On 10/11/25 16:54, Osama Abdelkader wrote:
>>> Remove the print_sg() debug helper and its always-disabled call sites
>>> in v9fs_read() and v9fs_write(). The function was only reachable via
>>> if (0) blocks, so it has been dead code for a long time.
>>>
>>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>>> ---
> 
> TBH low care level for this on my side. It's just passive debug code and the
> suggested change does not change anything on the resulting binary.
> 
> It's not that this debug code is not used at all, but very seldom. Last time I
> personally used it was like 3 years ago.
> 
>>>
>>>    hw/9pfs/9p.c | 20 --------------------
>>>    1 file changed, 20 deletions(-)
>>>
>>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>>> index bc4a016ee3..a8de894f4c 100644
>>> --- a/hw/9pfs/9p.c
>>> +++ b/hw/9pfs/9p.c
>>> @@ -1389,20 +1389,6 @@ static int stat_to_v9stat_dotl(V9fsPDU *pdu, const
>>> struct stat *stbuf,>
>>>        return stat_to_qid(pdu, stbuf, &v9lstat->qid);
>>>    
>>>    }
>>>
>>> -static void print_sg(struct iovec *sg, int cnt)
>>> -{
>>> -    int i;
>>> -
>>> -    printf("sg[%d]: {", cnt);
>>> -    for (i = 0; i < cnt; i++) {
>>> -        if (i) {
>>> -            printf(", ");
>>> -        }
>>> -        printf("(%p, %zd)", sg[i].iov_base, sg[i].iov_len);
>>> -    }
>>> -    printf("}\n");
>>> -}
>>> -
>>>
>>>    /* Will call this only for path name based fid */
>>>    static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
>>>    {
>>>
>>> @@ -2468,9 +2454,6 @@ static void coroutine_fn v9fs_read(void *opaque)
>>>
>>>            do {
>>>            
>>>                qemu_iovec_reset(&qiov);
>>>                qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size -
>>>                count);
>>>
>>> -            if (0) {
>>> -                print_sg(qiov.iov, qiov.niov);
>>
>> Alternatively, consider converting to trace event so we can keep
>> dumping the entries, but select that at runtime (see for conversion
>> example commit 4847c5701a3 "hw/rtc/mc146818rtc: Convert CMOS_DPRINTF
>> into trace events").
> 
> Probably overkill. We have a bunch of trace events where it makes, especially
> for investigating issues on 9p protocol level. But this debug code is usually
> just enabled if you are working on a virtio transport issue or new virtio
> feature and then you are usually working on this source code already.
> 
> But again: no strong opinion about this overall issue whatsoever.

Fine then!

