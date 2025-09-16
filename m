Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1E0CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYy8-0006Lx-23; Tue, 16 Sep 2025 12:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyYy0-0006GS-8t
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:55:44 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyYxy-0007Yk-Bo
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:55:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7761b83fd01so4027984b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758041740; x=1758646540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+QjKZyGjCb3MN36kEbgasSIbCOxnuFaPqUzO030KLaI=;
 b=hBN2ntWccXwaENktd/ltpfMH//PTtzmkh9RvcX0m2/sZS0H2y871fH7tDW4McTsOsv
 2tPyOCXAu7oEtyg/z+yDohzRKgx9/AGONlWwGi8VYV+fp1EjLMZKDoJMuBnIvap4t9c1
 NWZDkivXGDQd78az8JgONI5jOApSoEvuK6g47TTCm9gBqnFAhMWuPuHrMgA0VbktZ734
 RG6q3dzo2ZEZM/nvFm/MgtWP+Q/U1YAKGcVIBC7io5e/4UZqOS4gbiXlhibw9hEoVWFc
 S67o+HNwOs8Olna/VlvZTJlCOzmsOq8Iyg7ZicOqV4I7w4XJZYpdqtFY4D8C1i8DQr7T
 O6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758041740; x=1758646540;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+QjKZyGjCb3MN36kEbgasSIbCOxnuFaPqUzO030KLaI=;
 b=EOq8Lt0+UG3dXbUTTxjWPkGc0Uw8ez5mcGToHmVyu4oBnRjIPNfrwzZhYJ7B5QJUiI
 fDtMv2I3QWHnh+8XJBFLaPwuBvyddzDqFRBOfM08jN9G94oBvsneBSDeqqS3foP0DwDo
 kVPMhvSERBpFo/N5J+QmIzm3znoHEQPEXDQFOeKi3Hx4vMojEKO4s3xZW3pRU91rrZEJ
 VuVpjd04PrPocIU0Tn+EKZn1qIe0u0D+3LKpck6gFcOqOFW4/ciPbp6i/wXzKK9pbZ6O
 wazTxT+ypScPgPAORWeoCA6fl/cLz0qWMedxo2r1q11WYtnTUfBeRh/6FgDkdQ2crCJQ
 2qVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZBPsLvuXVrPrDlhv6AsLmhSYSJYsTgbUE5OlShfHNMMQuD1jKUaEAXeF5iF0col5J5Hsrr8+OHhG3@nongnu.org
X-Gm-Message-State: AOJu0Yyy9t01dps2zMpuBtshrJB9YP6tWelx1IXWnBikBnKk/rmkrz2k
 Y/CKdPZoiSynsy2/foAtes0kS8TpDcjLRecl9p/eT3NlVSYAlldfv+Z3RU80FMHqXMs=
X-Gm-Gg: ASbGncv3QXINti4UtgxkR2/kFAe9E8DZibIvb468GMehJBW40IyLtqpYI1+1C7GDcix
 Y7uvYYIbS7OSZGn+ucIv4qJuOBNOmVJmtPu1wlDfOsX5KefpAHVktUIexdGv1gWQ5WlHMP7Sj5H
 WAK7FCS5a+THh2jD1kmvw5iff8cGOAlyjrsjw8kdSr35lGs2QhslNM7vyuBNRJ4EMoDfeD4r6Iw
 eEAnt2q+mZnWLG1uXTCTGbcyF5yUfPM3kcompNDN8cCjQdQE31NaisaD/iBPKlJLEbGdci7A8nM
 1MdOCNRbKmqYBLF9R8UPCM0X3deurwKsq51MM1VOg5I8AFNGQr1KGzLi/bAmymynsOoqaQ7+shA
 QTXdcjV2SuGAABB+ZwFElbUJlvKdFVihuQBNQ
X-Google-Smtp-Source: AGHT+IGsM7Ql5eCEVW/0SXjb37VbkeKQfIjMTGmH04l+AMdz9pBHpJpx8C9edgqBFRGNNYXy7zw3NA==
X-Received: by 2002:a05:6a00:4601:b0:772:43a9:d587 with SMTP id
 d2e1a72fcca58-77612167539mr16307210b3a.20.1758041740069; 
 Tue, 16 Sep 2025 09:55:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607b18ec7sm17000303b3a.54.2025.09.16.09.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 09:55:39 -0700 (PDT)
Message-ID: <8ebea8ef-42b9-4e8a-b0dd-9e0bb3bccdef@linaro.org>
Date: Tue, 16 Sep 2025 09:55:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20250915185509.340022-1-richard.henderson@linaro.org>
 <a6108491-9e0e-45df-9448-45de99e373a0@linaro.org>
 <8865c3ad-341a-446e-ba29-e4c9f6bab514@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8865c3ad-341a-446e-ba29-e4c9f6bab514@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/15/25 22:18, Thomas Huth wrote:
> On 16/09/2025 03.38, Richard Henderson wrote:
>> On 9/15/25 11:55, Richard Henderson wrote:
>>> Startup of libgcrypt locks a small pool of pages -- by default 16k.
>>> Testing for zero locked pages is isn't correct, while testing for
>>> 32k is a decent compromise.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   tests/functional/x86_64/test_memlock.py | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/ x86_64/ 
>>> test_memlock.py
>>> index 2b515ff979..81bce80b0c 100755
>>> --- a/tests/functional/x86_64/test_memlock.py
>>> +++ b/tests/functional/x86_64/test_memlock.py
>>> @@ -37,7 +37,8 @@ def test_memlock_off(self):
>>>           status = self.get_process_status_values(self.vm.get_pid())
>>> -        self.assertTrue(status['VmLck'] == 0)
>>> +        # libgcrypt may mlock a few pages
>>> +        self.assertTrue(status['VmLck'] < 32)
>>>       def test_memlock_on(self):
>>>           self.common_vm_setup_with_memlock('on')
>>
>> I wonder if I should have chosen 64k, which might be one 64k page...
> 
> It's a x86 test, so we should not have to worry about 64k pages there, I hope?

Fair enough, though it does beg the question of why it's an x86-specific test.  Don't all 
host architectures support memory locking?

r~

