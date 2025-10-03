Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4712CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 13:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4fsP-0007tM-0d; Fri, 03 Oct 2025 09:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4fsK-0007sr-BM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:31:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4fs6-0003DE-Jz
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:31:08 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-339c9bf3492so444218a91.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759498244; x=1760103044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GGUFXm2DbRRKSiVdsT9a9dQwJgyQUoVjDCX8pENCzG0=;
 b=cN4+mpeArOR8ZXSuxq3Xr5h1GG7f9T6WPTHnH34p1XlSDTYSTZA1XpUnJRcU1D8FhA
 7VTiuvX7RPpwKwvVY/95VAQu1sWiR/CUN9jMD5e1Dagv0cZEiz7goXnUdnMi8v/MyQ8C
 XQpxXyigohxK6SeoN/BwZ48rOp1Y3GOFdTwSumb7PqFdVIYvB57sCfbCWRobNUA/AwZu
 aKqZvlq81E9Qs4pwXopgCWRCW15QglLAq9gj6CwVm3eC3uVwCI0pZi7Hr3/qqYwpxUwz
 +0lqJZOkV2DfEh/riQYMysiCDEjKspUpk2BUWz5I++uEf5mGYROukhWSEox8PrIfSQwX
 N3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759498244; x=1760103044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GGUFXm2DbRRKSiVdsT9a9dQwJgyQUoVjDCX8pENCzG0=;
 b=QiuqcsWmwBBpjgWsQdeyVl0KjWxp2v/uZYEC75mpfP99ONMNlKZ+EALr0KF903AMND
 lOB8mzdjC7lgEv7FHiXc296QeeEwKbrLhqkqZ4GH79bvPT4MZ8dvfLMnDcQwDMRWBw0d
 8ZT9KoTN2FKh2rexRzPFPzVXYKecvV5i4Pid4D2/eIoLCc/msASYX4rBN3oz+crIXLe2
 qdC0COOA2MHn5A0Km21qXsbTss8Asywm2X2x30j9tjtToW+ywn7cFkN5PE3Y9PUOcPxu
 ggsYRCiYaMQdr8IQ1s7VR/WQuenGmq06AE42ea7YFvVPoHGu0PludCy96zptTFM6ddHU
 orzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpbOCjrmZkVLCQcWT2jpjQFP+6dnLLbiaw7JEZ9hKK71NHHbU0o+9NqJeMyyuBx3KBPtfpAZOPfoh2@nongnu.org
X-Gm-Message-State: AOJu0YwAx3+m5D5NW7QFK1wGvJliAxWhg/AF3uGt94q/W52byfxgHcLt
 zAyGedoqexYl53g+QLGt6SNG7HlL/6lOUWq5jfSgmKHvwCaPvZAvNNAt/C83qS5DFEQ=
X-Gm-Gg: ASbGncsdPGO/v+O7gkcuAr1xoD9mGU9oVM7Zze/5QVC3vxMBu6kwasB1nd6Pnfn1XTd
 LNd4WN+IVnG1MTSDfkkakAJ8yGKz0dLixkK8WAbHUSiZp4DGw6XvM7VMbv07N0Sclrhqe5ZYcvq
 BITQWfy3dkNlCCwumXIrgwKSxvyWBJ4SA7a7oqi7RlKQ6dO9AjTB9RlXhpQkRM1oFqp+3GhvBch
 HoQSHZDw/B1R987sA+AEDrXzLvOqmjkt3kUjl14pF/gyses7f/RRimq3dVijWgPcUiVkiqdelrF
 vRfLC7Q7QYmfDFtK6o2MSZrUr3FlJthRTSQmfOyaGmKfw75l7ZKXgDCzX/QvWNrWtdbcfGhvgUw
 HZnJsJSAuZH3Z0eR8+Mjuj/H9+8vdur9i2ez4kJ035Shlzfgfsl+1le7IYBoWtOwMVi4lYGigzg
 ==
X-Google-Smtp-Source: AGHT+IEhX2Mytx5+xFX5JIbffMSu7j1batDPiC+XWi2feJpYvjE2bmBot8y8DV9oyDG99KYjBUdxtw==
X-Received: by 2002:a17:90b:3bcc:b0:32e:e150:8937 with SMTP id
 98e67ed59e1d1-339c2724b7emr4304320a91.6.1759498244505; 
 Fri, 03 Oct 2025 06:30:44 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.59.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099afa5fdsm4733502a12.15.2025.10.03.06.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 06:30:43 -0700 (PDT)
Message-ID: <bb7801f1-67d3-47d7-b5bd-39b1113ea9e0@linaro.org>
Date: Fri, 3 Oct 2025 10:30:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <b5cb30d8-65a2-4bf7-b66f-5bfe61e19835@redhat.com>
 <8fb3351e-f1a1-4a1e-9650-33f0d4ee6d44@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <8fb3351e-f1a1-4a1e-9650-33f0d4ee6d44@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1032.google.com
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

Hi Thomas,

On 10/2/25 14:52, Thomas Huth wrote:
> On 02/10/2025 18.53, Thomas Huth wrote:
>> On 02/10/2025 04.04, Gustavo Romero wrote:
>>> The goal of this series is to remove Avocado as a dependency for running
>>> the reverse_debugging functional test.
>>>
>>> After several rounds of discussions about v1 and v2, and experiments
>>> done by Daniel and Thomas (thanks for all the experiments and comments
>>> so far), I've taken a new approach and moved away from using a runner
>>> for GDB. The changes, I believe, are much simpler now.
>>
>>   Hi Gustavo,
>>
>> unfortunately, this still seems to be broken on Fedora. After applying your series, I get:
>>
>> stderr:
>> Traceback (most recent call last):
>>    File "/home/thuth/devel/qemu/tests/functional/reverse_debugging.py", line 100, in reverse_debugging
>>      self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
>>      ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>    File "/usr/lib64/python3.13/unittest/case.py", line 156, in skip_wrapper
>>      raise SkipTest(reason)
>> unittest.case.SkipTest: Missing env var(s): QEMU_TEST_GDB
> 
> Looks like it's required to explicitly use the --gdb=... parameter of configure to make it work, and it does not work without that paramter? Could you please have a look whether it works without --gdb with the auto-detected gdb for you?

Yes, it works without passing --gdb on Ubuntu. I'm checking it on Fedora.

But at least have you got the test skipped properly (displayed on Meson as skipped) since QEMU_TEST_GDB is missing?


Cheers,
Gustavo

