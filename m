Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33346C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGSp-0007oE-Vc; Wed, 31 Jul 2024 17:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGSm-0007lc-Sc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:02:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGSl-0008Eu-8a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:02:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428163f7635so39123375e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722459741; x=1723064541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TWa/d8sBb5qBc99DmU1vNEo5fOaSLn9wOwoILGuaWe8=;
 b=hQYk0IXPM9rXrhAnL0cfEtJWQINGFuQLOL//TdQk3xM5rWme9x74//UBS/tzx97oTe
 Y+385zejy4jNEClLmR0UmCw8wlk8Q5eLqWF33pC24NkjdTWjfZK5Jv05hl7O1ieSCKfJ
 FSzdmmQMhk2m9WxzOLX2KfwcU6/Xgd3g8NOmF/qGjRoq09kmwEY/BhltZnZzxzsFGtEW
 GABD1cYfW77ITwpDxeY8bSx9VipMd7FbIUtStxqeYV96SbzV4/EJukiL6OK5su1hF8ss
 rdYnaJk56NL44Jq1zOHVpiNuTwkmQF4pxx6mFET33AxW7htjHYozjVjNTQ9sfLhtOCXG
 bLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722459741; x=1723064541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TWa/d8sBb5qBc99DmU1vNEo5fOaSLn9wOwoILGuaWe8=;
 b=SBEw8m8y7cw5VkfrC10omZvyYms6Z7TI8QdgZrGPX/ABSp8FHo9zWUw3S5PK6ybdmT
 XIYPFmlA49SYY2D0oyWrFGtlgZsn4NTkWlwRaUVD47jG/3rQLUgLcnDAmSxZ6mKifU7l
 doaFLI1eGcZXu3di0Lg28rnhJNCJKkqVbQN2akE2PfpAjLK7aEuStx/UTJdYvBWnTuKJ
 OCzOlGRuyxVeBzY938sZj/I6xCGdN6u3EBckgvbqLwccykIcCccK++3OMYNXkWgJf1h5
 2JFeN5lAPscQmobG7d8Ejf9dY1bo/bPLnr/0Wfy7DP7ES8CyZBAPY4oHdQWJz9BHkos0
 JJSA==
X-Gm-Message-State: AOJu0YykYneAVOXpj/uTiiLSrIlwnhNFuMKWgrjw6CJk62mszkGs+BR4
 RPWE+hRKbAbNmJNrSd31lTW/Uqyjh1KAldiKt2o+7IHi4Q8jiA5/tb/4g98wXBE=
X-Google-Smtp-Source: AGHT+IHa7BA3qTQ6dswN3jvXlWlB9x3IBq+25jBRKojE2ESuC2XpaxhdoPW+yDr29Rk/DT3zAvdRHA==
X-Received: by 2002:a05:600c:19ce:b0:426:5546:71a with SMTP id
 5b1f17b1804b1-428a99e08ccmr3827145e9.2.1722459741498; 
 Wed, 31 Jul 2024 14:02:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282babaaa8sm33471265e9.24.2024.07.31.14.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:02:21 -0700 (PDT)
Message-ID: <6504c60d-e9b1-4f59-836d-ed65739a6034@linaro.org>
Date: Wed, 31 Jul 2024 23:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] hw/ide/pci.c: Remove dead code from
 bmdma_prepare_buf()
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-7-peter.maydell@linaro.org>
 <ZqpUgb1Y74-N9q0_@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZqpUgb1Y74-N9q0_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 31/7/24 17:13, Kevin Wolf wrote:
> Am 31.07.2024 um 16:36 hat Peter Maydell geschrieben:
>> Coverity notes that the code at the end of the loop in
>> bmdma_prepare_buf() is unreachable.  This is because in commit
>> 9fbf0fa81fca8f527 ("ide: remove hardcoded 2GiB transactional limit")
>> we removed the only codepath in the loop which could "break" out of
>> it, but didn't notice that this meant we should also remove the code
>> at the end of the loop.
>>
>> Remove the dead code.
>>
>> Resolves: Coverity CID 1547772
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/ide/pci.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>> index 4675d079a17..f2cb500a94f 100644
>> --- a/hw/ide/pci.c
>> +++ b/hw/ide/pci.c
>> @@ -266,10 +266,6 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
>>               s->io_buffer_size += l;
>>           }
>>       }
>> -
>> -    qemu_sglist_destroy(&s->sg);
>> -    s->io_buffer_size = 0;
>> -    return -1;
>>   }
> 
> Should we put a g_assert_not_reached() here instead to make it easier
> for the reader to understand how this function works?

Or break and keep returning at EOF:

-- >8 --
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 4675d079a1..8386c4fe42 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -237,7 +237,7 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, 
int32_t limit)
              /* end of table (with a fail safe of one page) */
              if (bm->cur_prd_last ||
                  (bm->cur_addr - bm->addr) >= BMDMA_PAGE_SIZE) {
-                return s->sg.size;
+                break;
              }
              pci_dma_read(pci_dev, bm->cur_addr, &prd, 8);
              bm->cur_addr += 8;
@@ -267,9 +267,7 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, 
int32_t limit)
          }
      }

-    qemu_sglist_destroy(&s->sg);
-    s->io_buffer_size = 0;
-    return -1;
+    return s->sg.size;
  }

---

> 
> Either way:
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


