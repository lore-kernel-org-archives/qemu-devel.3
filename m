Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999E1CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 17:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywI8-00038v-QZ; Wed, 17 Sep 2025 13:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uywI6-00037i-Fo
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:50:02 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uywI4-000813-CF
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:50:02 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-32e34f4735eso7771a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758131398; x=1758736198; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfF6FJF7aVw4fyP+XEqDkMslqqLUzT1P73t3TxfoN20=;
 b=YnlxqZZwUZ4dzr6nl3R/8ANRCFlwBzIVyIq+OBKWDA0OYnC869dh6F7XqJyEpYeZ4d
 Z23POZmThkqHCrHx/KoRlwsPiKD3AVw875PWHX0ccheWeVFzyGRQucRs48Fhl1/4pnYJ
 b8LgtnCwB29N9BCm9iTrp7a1YRxLWYD5wmfnpgzPQED/ax7141m4VzXc3yYLomVEVq/o
 CTfaNWYyD6ndMRS1IRPhyYxXSFL9rbl+v/CcR7ZvPmgaFoneAw4FC2TWHP+lHhUcCWOn
 xp6Hzgcsm5RM4SgrCAJ0wctYZ/5qQY5txk4W8sRnoWpDEbqX77myFBPbhyvMCMef7hkV
 WdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758131398; x=1758736198;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NfF6FJF7aVw4fyP+XEqDkMslqqLUzT1P73t3TxfoN20=;
 b=jbDh0qMeFD2gZDSmTlFsJF/vudx2ICGHJrURP+kzv1blKjLFU8BSgBsQ2OiXKvHjRq
 UH1Hl9Oe0w1lR1jkhg9DZwQTw6LyRT3Cq/1db48/DoXpMik9WnXPzABYnROBlyeS99RY
 yf7tkGoAVzCUTHmLTA1qDam17ClGbeMhbFyJZjHYZCf9KBck04Tnwgupj0DskOpKlKRz
 Cf/1dmn9jOK0RGtcJyhIGaMMkGrRBuuLbCWlDnpiTsi99MBp1YzwukTFAlRSFCSyxfMe
 vEUEAxHUZuLztLw4zNjthyzi7kteDxrPWUXX2xMh0pR83+emWrTR/qUSvaT36/TOR192
 mQJg==
X-Gm-Message-State: AOJu0Yy8U1fiLhG6t8wvOUKV3TU+Q/agdNT/u/dKe0RhfvmhPSlfbkNp
 9DZLOs3XDRyMmwX8JMVkDQ0HJe9tBS8Bej9klkd6s80Iq5/Br01b9x/jUkgW3uecR/Q=
X-Gm-Gg: ASbGncu+0f1lk4CDtyVkb9u9vOkS8SxRYTqTa3nckcUJZyoKs0Rd2ChVUL9RAWENfi2
 u58vS5yH7G0VnJ0HkB5aQqfdcSoTjiKh6Tt+5ePNbglEExjvkif7Nc7/sX8syJgvPTw7Sw3mEkA
 EoxZf0Ykb6me05L1cGg3jm1l4F+kicGnmL7REEq9qPD0qsXylmFGDDqrKo8I8G4ZnE5+FqZytTB
 hmmO6UVu6WtFM0OxqBseiodKzd/LdOWPj9HjJBruVRS0Oyuo99slawxxJpYiZjDYrtflL1kDrtz
 Erz7HpGpdEM+8dKu4DQrlnFXK3KrcmnniUqAM2w+UoFhX9HnkLOzXAySpI7gg7wGO6k/aI+S5hj
 m70xdsXNCP2Y4TtQf/VZW5Lq208C+2hSd9lP+
X-Google-Smtp-Source: AGHT+IFUKfQaEXjR3gol1skMnFDyJQs4Alj8FvAgFL8e19KZ2TDvSsfmvag2IyBdicVs3+MVgyfVXw==
X-Received: by 2002:a17:90b:1d44:b0:32e:a59f:b25d with SMTP id
 98e67ed59e1d1-32ee3f79017mr3835690a91.30.1758131398386; 
 Wed, 17 Sep 2025 10:49:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32edd97fe58sm2738931a91.13.2025.09.17.10.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 10:49:58 -0700 (PDT)
Message-ID: <d6b2f2c8-809d-4a94-a18b-2accf10fc5f9@linaro.org>
Date: Wed, 17 Sep 2025 10:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: More check-functional asset download issues
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Hi,

We have

   https://patchew.org/QEMU/20250829142616.2633254-1-berrange@redhat.com/

in master already, but are still seeing up front failures:

   https://gitlab.com/qemu-project/qemu/-/jobs/11391070330
   https://gitlab.com/qemu-project/qemu/-/jobs/11391070366

2025-09-17 17:26:56,222 - qemu-test - INFO - Downloading 
https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/uImage 
to 
/builds/qemu-project/qemu/functional-cache/download/2478187c455d6cca3984e9dfde9c635d824ea16236b85fd6b4809f744706deda...
Traceback (most recent call last):
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 135, in fetch
     with urllib.request.urlopen(self.url) as resp:
   File "/usr/lib64/python3.9/urllib/request.py", line 214, in urlopen
     return opener.open(url, data, timeout)
   File "/usr/lib64/python3.9/urllib/request.py", line 517, in open
     response = self._open(req, data)
   File "/usr/lib64/python3.9/urllib/request.py", line 534, in _open
     result = self._call_chain(self.handle_open, protocol, protocol +
   File "/usr/lib64/python3.9/urllib/request.py", line 494, in _call_chain
     result = func(*args)
   File "/usr/lib64/python3.9/urllib/request.py", line 1389, in https_open
     return self.do_open(http.client.HTTPSConnection, req,
   File "/usr/lib64/python3.9/urllib/request.py", line 1350, in do_open
     r = h.getresponse()
   File "/usr/lib64/python3.9/http/client.py", line 1377, in getresponse
     response.begin()
   File "/usr/lib64/python3.9/http/client.py", line 320, in begin
     version, status, reason = self._read_status()
   File "/usr/lib64/python3.9/http/client.py", line 289, in _read_status
     raise RemoteDisconnected("Remote end closed connection without"
http.client.RemoteDisconnected: Remote end closed connection without response
During handling of the above exception, another exception occurred:
Traceback (most recent call last):
   File "/builds/qemu-project/qemu/tests/functional/ppc64/test_e500.py", line 44, in <module>
     LinuxKernelTest.main()
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/testcase.py", line 251, in main
     Asset.precache_suites(path, cache)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 242, in 
precache_suites
     Asset.precache_suite(tests)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 233, in 
precache_suite
     Asset.precache_suite(test)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 233, in 
precache_suite
     Asset.precache_suite(test)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 235, in 
precache_suite
     Asset.precache_test(test)
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 222, in 
precache_test
     asset.fetch()
   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 184, in fetch
     raise AssetError(self, "Unable to download: %s" % e)
qemu_test.asset.AssetError: 
https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/uImage: 
Unable to download: Remote end closed connection without response
ninja: build stopped: subcommand failed.
make: *** [Makefile:168: run-ninja] Error 1


r~

