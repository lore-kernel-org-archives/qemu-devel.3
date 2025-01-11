Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2778FE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 05:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWTmK-0005A7-VC; Sat, 11 Jan 2025 00:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWTmA-00059D-L8
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:11:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWTm6-0004AA-7V
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:11:10 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21634338cfdso17105435ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 21:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736572261; x=1737177061;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFuJF1KReuxRF3mRy9Hhvq66Vzo7aVpYQKTTh2YU67g=;
 b=EPHJWoYvSxzg8s5T1ZOL53YqiIA3Y9vUwlzV2Z0Nv0NweoNgk+krlk7UDp7qSQOKlW
 h4EnWzB1ykiUPuA+VeO+fdWlX4u1mNyY16+wBTKqQIDCZGV+YusiF1Vlan6mltfaj/Uk
 0OBEuAxFgPhvc8UuXjwG5anlTJbixiL7+yoRK00O328yUbfUiN6pXAz1u1yvXKGAQzqq
 anmVsyduy1wnjjUHI/vlZijIOi4khI20i8HVvXzUdxmslhWW+TEDC+QgM0r6L8M69Mtv
 pkWHj5iIELu3ktHoc6/nShLHQOj6mdbc2/EA4hwfGhPcEPyRT/PxaYAHPNqPMdqdMr0c
 45nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736572261; x=1737177061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFuJF1KReuxRF3mRy9Hhvq66Vzo7aVpYQKTTh2YU67g=;
 b=Hq9YjoovXV4pTKON4XTHuw3SopJbBNooMFGIoqYt0M/BeoCZQWYUubPzF3hwOGDGAn
 4a1Lz7V45u6ClY72XDiaQF5u/9LE9PPQfpoO2NOv0vFQbyL/cyk3fSHHtmczS6zvJABo
 U42ChzTfEMJwstTilkjyG5CZZTv55Ll0GMPyprNIjgyV5Wc1JwkQSHWUHH+JT8DJ39Ta
 1vFu62yF3A9KvPRr5IEm93mNW9wMt1M2nWm/OUdIxHMCiLNZTwr6YvcAmEWfaKJSJOCB
 zhjQJA/+pq4ymXxyjfLkMiKFwTng0wdrRbhaLvixzsgHCqCviCg38d6tdFQxelZXoGEE
 k1DA==
X-Gm-Message-State: AOJu0YwOoSrgoIeQpx7UsnnMdqnjSfws6y4y+EYQ9viq4SVsyT/vd5hU
 VqZAV28ijWpUY9/wy5XtggfuaodvyTpF2VyQZE3NZsZ1LJNag9Ph6L7ypF5l3oY=
X-Gm-Gg: ASbGncuX7tSsXs6ulhc0yRC/uMNXBKBET66w0DWfJwmKfdfJJ4CfD/AX/ZEXiL/Iat7
 IjEjBzrf0R/5q6gqN7zrWlIFaHbAmmCwBjdvwKu5JnUP9rml83bIHRKPlF/bff0UQOEVaHJ3ZLM
 Fds6jYZuSGQsqaVT58njTKKjcvKeWj7IVf6gl0x+95czdg7d2jbMUsApwda0iHLiVdr+PISAcz6
 ggUwG+2KDAn99NQ5wYQFcUu+WpHLzUlluBAWRc/1p5mmtzU7YNjLn+KPGBcQsqDfKc=
X-Google-Smtp-Source: AGHT+IFMTivELwrSJeBbuLF1AZOsOJGzLbHrclhXvCHvdL5+sIiSOA2sOawGoCxyr6WbsGj8XgJLGw==
X-Received: by 2002:a17:902:da87:b0:215:9642:4d7a with SMTP id
 d9443c01a7336-21a83da6a40mr209662975ad.0.1736572261469; 
 Fri, 10 Jan 2025 21:11:01 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f2179b6sm20813735ad.115.2025.01.10.21.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 21:11:01 -0800 (PST)
Message-ID: <2cdcba63-00dd-4580-8a84-19f342ccb9c5@daynix.com>
Date: Sat, 11 Jan 2025 14:10:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util/iov: Do not assert offset is in iov
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
 <20240428-iov-v1-1-7b2dd601d80b@daynix.com>
 <07258bb4-bc8f-4b21-a662-402d3164b68a@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <07258bb4-bc8f-4b21-a662-402d3164b68a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

Jason, can you pull this series?

Regards,
Akihiko Odaki

On 2024/05/08 23:51, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 28/4/24 13:11, Akihiko Odaki wrote:
>> iov_from_buf(), iov_to_buf(), iov_memset(), and iov_copy() asserts
>> that the given offset fits in the iov while tolerating the specified
>> number of bytes to operate with to be greater than the size of iov.
>> This is inconsistent so remove the assertions.
>>
>> Asserting the offset fits in the iov makes sense if it is expected that
>> there are other operations that process the content before the offset
>> and the content is processed in order. Under this expectation, the
>> offset should point to the end of bytes that are previously processed
>> and fit in the iov. However, this expectation depends on the details of
>> the caller, and did not hold true at least one case and required code to
>> check iov_size(), which is added with commit 83ddb3dbba2e
>> ("hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()").
>>
>> Adding such a check is inefficient and error-prone. These functions
>> already tolerate the specified number of bytes to operate with to be
>> greater than the size of iov to avoid such checks so remove the
>> assertions to tolerate invalid offset as well. They return the number of
>> bytes they operated with so their callers can still check the returned
>> value to ensure there are sufficient space at the given offset.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/qemu/iov.h | 5 +++--
>>   util/iov.c         | 5 -----
>>   2 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
>> index 63a1c01965d1..33548058d2ee 100644
>> --- a/include/qemu/iov.h
>> +++ b/include/qemu/iov.h
>> @@ -30,7 +30,7 @@ size_t iov_size(const struct iovec *iov, const 
>> unsigned int iov_cnt);
>>    * only part of data will be copied, up to the end of the iovec.
>>    * Number of bytes actually copied will be returned, which is
>>    *  min(bytes, iov_size(iov)-offset)
>> - * `Offset' must point to the inside of iovec.
>> + * Returns 0 when `offset' points to the outside of iovec.
>>    */
>>   size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
>>                            size_t offset, const void *buf, size_t bytes);
>> @@ -66,11 +66,12 @@ iov_to_buf(const struct iovec *iov, const unsigned 
>> int iov_cnt,
>>   /**
>>    * Set data bytes pointed out by iovec `iov' of size `iov_cnt' 
>> elements,
>>    * starting at byte offset `start', to value `fillc', repeating it
>> - * `bytes' number of times.  `Offset' must point to the inside of iovec.
>> + * `bytes' number of times.
>>    * If `bytes' is large enough, only last bytes portion of iovec,
>>    * up to the end of it, will be filled with the specified value.
>>    * Function return actual number of bytes processed, which is
>>    * min(size, iov_size(iov) - offset).
>> + * Returns 0 when `offset' points to the outside of iovec.
>>    */
>>   size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
>>                     size_t offset, int fillc, size_t bytes);
>> diff --git a/util/iov.c b/util/iov.c
>> index 7e73948f5e3d..a523b406b7f8 100644
>> --- a/util/iov.c
>> +++ b/util/iov.c
>> @@ -36,7 +36,6 @@ size_t iov_from_buf_full(const struct iovec *iov, 
>> unsigned int iov_cnt,
>>               offset -= iov[i].iov_len;
>>           }
>>       }
>> -    assert(offset == 0);
>>       return done;
>>   }
>> @@ -55,7 +54,6 @@ size_t iov_to_buf_full(const struct iovec *iov, 
>> const unsigned int iov_cnt,
>>               offset -= iov[i].iov_len;
>>           }
>>       }
>> -    assert(offset == 0);
>>       return done;
>>   }
>> @@ -74,7 +72,6 @@ size_t iov_memset(const struct iovec *iov, const 
>> unsigned int iov_cnt,
>>               offset -= iov[i].iov_len;
>>           }
>>       }
>> -    assert(offset == 0);
>>       return done;
>>   }
>> @@ -266,7 +263,6 @@ unsigned iov_copy(struct iovec *dst_iov, unsigned 
>> int dst_iov_cnt,
>>           bytes -= len;
>>           offset = 0;
>>       }
>> -    assert(offset == 0);
>>       return j;
>>   }
>> @@ -337,7 +333,6 @@ size_t qemu_iovec_concat_iov(QEMUIOVector *dst,
>>               soffset -= src_iov[i].iov_len;
>>           }
>>       }
>> -    assert(soffset == 0); /* offset beyond end of src */
>>       return done;
>>   }
>>


