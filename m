Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7331C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 09:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh408-0006sS-2s; Thu, 22 Aug 2024 05:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh406-0006rx-Ui
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:21:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh405-0006Ye-1o
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:21:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso3795385e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724318457; x=1724923257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FZfdiXhvcwlzdSTHp01PJ2kMFQ3CJnhSYaycbwm8VDo=;
 b=yoiSXwqje2HV9TKHaLPToH1pgxuRlVX4AMbqVudCtD/lfppgqbrBr3FG7UsHH31Y/E
 UoL5wg9Tc5YGQGPF1g4lnNjNzQYS9M89mHH5ypagKOal555ZBIN6gz6UcSqcCa8iorwi
 Zctu6n2l/Bv5m013tpyivYDoBSd9kwlDjkCyzbKtivUphBcQ2EPAHgAUxPCv7JRyaxjB
 vz+GKjU21ZOHshJntaN7DhQcvsxenB5R7Nk6vmcJsmJst7eAiHSQjV30n4f/UjrgPzD6
 7rGnwUQIfg6exc342HdrcSCCKx20RtzjAJjv0Dp2WEkcwH6s/uNlOiLTYZWTMdvUcXsG
 fWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724318457; x=1724923257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZfdiXhvcwlzdSTHp01PJ2kMFQ3CJnhSYaycbwm8VDo=;
 b=X/GAIoTUEn+B7b8KtwCf2HhbdCEA8UchfcaplQySCDSFMkQ/Gf0d3QPHiOQoTTF8+e
 1/3O4Gz9D/cl5s9P/KAUDg49Yh3TyOWgamRzIQf5fVDibUcF/3Pre5LvZzGevT70FYHv
 taF+iQ/jFcuB2hqAMGx562eUr7/aeCb/Em7qZawEfjgmVkTYRjKh3fEk6g0Yy5Z707El
 ozVgfVRpAJdwFeXqvuoR50vXmzNdR1gnLZYCsfK+GwOm6n61Z7VvhsC/LV5sPhQjQeIn
 Uxnxspdf1kuvhIzfB+5hGWSle3LPs9YMUOdM5LOMXKvZqHqskNRGi4++v9nWxlN2xU9K
 93iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnNukU9y+Df/aC3nZHXzEAMlcLHa02gzFoeZE3+7xnVVV6vqNV/lGUYMpO4M+LCNHI1I+vSOhD9rlE@nongnu.org
X-Gm-Message-State: AOJu0Ywu8e1122B0laZBHmUm1TQd710I+cALm3e9gbhlxZkA3eG+0VDM
 lfMMZ5nSvwlcN3Ij3VHyQwfKlwikR6aR0VKPScn0tpPxu903DwohfOn8FCdOZHw=
X-Google-Smtp-Source: AGHT+IECG1uJWnD8nJeXumiQxL3QwvzBOn9Rw2G6pIvSmHBleSvFA3cB1qUFjNDaa6NJrSgIaZHeTg==
X-Received: by 2002:a05:600c:45cb:b0:428:6f4:57ff with SMTP id
 5b1f17b1804b1-42abd26477bmr30268295e9.35.1724318457015; 
 Thu, 22 Aug 2024 02:20:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac517f9basm17485765e9.39.2024.08.22.02.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 02:20:56 -0700 (PDT)
Message-ID: <078e3e35-fbef-43aa-b80c-448140a5a0bc@linaro.org>
Date: Thu, 22 Aug 2024 11:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Allow running user-mode tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20240821153836.67987-1-philmd@linaro.org>
 <0e7e30cf-bd67-4d21-9ee9-b6ab77b8e35f@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e7e30cf-bd67-4d21-9ee9-b6ab77b8e35f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/8/24 09:21, Thomas Huth wrote:
> On 21/08/2024 17.38, Philippe Mathieu-Daudé wrote:
>> Commit 816d4201ea ("tests/avocado: Move LinuxTest related
>> code into a separate file") removed the Avocado 'process'
>> import which is used by the QemuUserTest class, restore it.
>>
>> Fixes: 816d4201ea ("tests/avocado: Move LinuxTest ...")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Unfortunately the single linux-user test is not run on CI,
>> and I haven't ran it manually since too long...:
>> https://gitlab.com/qemu-project/qemu/-/issues/2525
>> ---
>>   tests/avocado/avocado_qemu/__init__.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/avocado/avocado_qemu/__init__.py 
>> b/tests/avocado/avocado_qemu/__init__.py
>> index ef935614cf..0d57addfea 100644
>> --- a/tests/avocado/avocado_qemu/__init__.py
>> +++ b/tests/avocado/avocado_qemu/__init__.py
>> @@ -17,7 +17,7 @@
>>   import uuid
>>   import avocado
>> -from avocado.utils import ssh
>> +from avocado.utils import process, ssh
>>   from avocado.utils.path import find_command
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> ... but is the test itself still working for you? When I run it, I get:
> 
>   ...
>   (074/281) 
> tests/avocado/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64eb_kernel3_2_0: SKIP: Test might timeout
>   (075/281) 
> tests/avocado/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0: SKIP: Test might timeout
>   (076/281) tests/avocado/load_bflt.py:LoadBFLT.test_stm32: ERROR: 
> Command './qemu-arm  /bin/busybox ' failed.\nstdout: b''\nstderr: 
> b''\nadditional_info: None (0.06 s)
> Interrupting job (failfast).
> 
> Seem like self.workdir is not set here??

No clue why... This used to work.

Why self.workdir is indeed not set, this kludge makes it work:

---
diff --git a/tests/avocado/load_bflt.py b/tests/avocado/load_bflt.py
index bb50cec1ee..264489ee25 100644
--- a/tests/avocado/load_bflt.py
+++ b/tests/avocado/load_bflt.py
@@ -41,7 +41,7 @@ def test_stm32(self):
                        'Stm32_mini_rootfs.cpio.bz2')
          rootfs_hash = '9f065e6ba40cce7411ba757f924f30fcc57951e6'
          rootfs_path_bz2 = self.fetch_asset(rootfs_url, 
asset_hash=rootfs_hash)
-        busybox_path = os.path.join(self.workdir, "/bin/busybox")
+        busybox_path = os.path.join(self.workdir, "bin/busybox")

          self.extract_cpio(rootfs_path_bz2)

---

Fetching asset from tests/avocado/load_bflt.py:LoadBFLT.test_stm32
JOB ID     : 020d317281b042f46ad99013530d29df0f1d7eb7
JOB LOG    : tests/results/job-2024-08-22T10.17-020d317/job.log
  (1/1) tests/avocado/load_bflt.py:LoadBFLT.test_stm32: PASS (0.09 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | 
CANCEL 0
JOB TIME   : 0.62 s

So I'll add that and call it a day.

Thanks!

