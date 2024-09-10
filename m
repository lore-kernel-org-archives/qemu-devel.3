Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40044ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snvQA-0004mN-53; Tue, 10 Sep 2024 03:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1snvQ5-0004lg-UJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1snvQ4-000335-7U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725953770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJq6jRpQrCnyFHBQ1NUT8MFPHHAoPp+TLtHiNl/gZIM=;
 b=Rvu5jbyC8FnqrSolhtdpAoAeRSjt6tgkQZExVgNvv0hRPey9pCMorx2fxRf3cTeEl+rNOM
 OnKUDq7Ir9n6LbnIcWQVJIMa69fwLF7hFEsYvtY3ZqWSrut6m9ggEfGDsfmK/WkPV/ggZ3
 Whry44UC7oW849MXMTQ/01gyLqpR33I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-P7lJb1pcM3u219NowNAQ2g-1; Tue, 10 Sep 2024 03:36:08 -0400
X-MC-Unique: P7lJb1pcM3u219NowNAQ2g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c44e58a9so2760925f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725953767; x=1726558567;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UJq6jRpQrCnyFHBQ1NUT8MFPHHAoPp+TLtHiNl/gZIM=;
 b=A843wOKKWdeYSH2bWQ5oy+MaS6oG9aFcVd71YrkdhTStlxxW9apLIggDFFIqM73Oqn
 mBAXn4MhwSLPgxYF5Zz2znaRk5VAaPe9g7ejZL2S8+WZ7d95LUJeI9U9HXR2mNifkGk9
 R720ow+D6eLQZbEejjT9Mg/Bd9aLzXV8qqC6Uo4SqAVcI5HrqbZUDDXAputJAcvizAgH
 jS7+me1om9yQVkQ9ILB2lhCbfVD0Xe2+C7PSRKiz3iAbbRsl+sWzi52gTMB/hTNLv/n0
 WycdRnx8a/1DOQa3DTzMbgARYGPOs/zMLVfxc1Y6x+pYU68YolAKS30o0Q8tFKPnqO5F
 rGnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd1WkrVki0Gj5XIwaIWjHGIUMwvn1WbRwjZz77+8RjsvomltWf/w5ANX5bPsN1lozhr/88u3i/T0Wj@nongnu.org
X-Gm-Message-State: AOJu0Yz2ldyHbmI1g3AQ3iR4NJpQR9uuCiDgY/piJMc5qhMywvrT+vNM
 lJZy2/7XzMVHafUqEr8yaGSeQRgQftIi1resHHINcFedYNaplQ5hZGUVbIxaoc+GETdnAMLLuBs
 H+apuE/hWh15AoTUfe78G+0YP25nfpMSkT4k2EF65jCKxByMLzgcB4TcGGZTy64A=
X-Received: by 2002:adf:fe11:0:b0:374:c8cc:1bb1 with SMTP id
 ffacd0b85a97d-37889674944mr9244057f8f.39.1725953767506; 
 Tue, 10 Sep 2024 00:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnLnajCzM0O5UMwiSyLklSU88AXgilY2zrq1dfWn7ZgAdHKTsjP7X4Y+K0UVrKogq4h2Cvng==
X-Received: by 2002:adf:fe11:0:b0:374:c8cc:1bb1 with SMTP id
 ffacd0b85a97d-37889674944mr9244038f8f.39.1725953766974; 
 Tue, 10 Sep 2024 00:36:06 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de262sm8039404f8f.112.2024.09.10.00.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:36:06 -0700 (PDT)
Message-ID: <b04d662f-0ec1-4c93-a67a-d0e77df271cd@redhat.com>
Date: Tue, 10 Sep 2024 09:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-functional skipUnless failure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <5f193fa1-89ec-4424-b6fd-c7ae1a4beedf@linaro.org>
 <4942adc4-68f5-4d26-acfc-f47f531c9c43@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4942adc4-68f5-4d26-acfc-f47f531c9c43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/09/2024 08.41, Philippe Mathieu-Daudé wrote:
> On 10/9/24 05:58, Richard Henderson wrote:
>> [rth@cfarm120 bld]$ make check-functional
>> [1/2] Generating tests/functional/func-precache-m68k-m68k_nextcube with a 
>> custom command (wrapped by meson to set env)
>> FAILED: tests/functional/m68k-m68k_nextcube.tstamp
>> env 
>> QEMU_TEST_PRECACHE=/home/rth/qemu/bld/tests/functional/m68k-m68k_nextcube.tstamp PYTHONPATH=/home/rth/qemu/src/python:/home/rth/qemu/src/tests/functional /home/rth/qemu/bld/pyvenv/bin/python3 /home/rth/qemu/src/tests/functional/test_m68k_nextcube.py
>> Traceback (most recent call last):
>>    File "/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py", line 
>> 25, in <module>
>>      class NextCubeMachine(QemuSystemTest):
>>    File "/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py", line 
>> 60, in NextCubeMachine
>>      @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
>>    File "/home/rth/qemu/src/tests/functional/qemu_test/tesseract.py", line 
>> 16, in tesseract_available
>>      (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
>>    File "/home/rth/qemu/src/tests/functional/qemu_test/cmd.py", line 69, 
>> in run_cmd
>>      subp = subprocess.Popen(args,
>>    File "/usr/lib64/python3.9/subprocess.py", line 951, in __init__
>>      self._execute_child(args, executable, preexec_fn, close_fds,
>>    File "/usr/lib64/python3.9/subprocess.py", line 1837, in _execute_child
>>      raise child_exception_type(errno_num, err_msg, err_filename)
>> FileNotFoundError: [Errno 2] No such file or directory: 'tesseract'
>>
>>
>> On this host, tesseract is not available.
>> But skipUnless is not skipping, but erroring out.

Ouch, it's a stupid mistake that I made while converting the test: has_cmd 
returns a list, not a boolean value. This should fix the bug:

diff --git a/tests/functional/qemu_test/tesseract.py 
b/tests/functional/qemu_test/tesseract.py
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -11,7 +11,8 @@
  from . import has_cmd, run_cmd

  def tesseract_available(expected_version):
-    if not has_cmd('tesseract'):
+    (has_tesseract, errmsg) = has_cmd('tesseract')
+    if not has_tesseract:
          return False
      (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
      if ret:

I'll send it out as a proper patch ASAP.

> While looking at this, I'm surprised to notice has_cmd() actually
> *runs* the command by calling run_cmd(). I'd have expected it solely
> checks for binary presence and RX perms, avoiding unexpected side
> effects.

It uses "which" to search for the binary ... that could be done better for 
sure (especially since "which" might not be available on all systems), but 
it already was done this way in the Avocado tests, so at least that's not a 
regression.

  Thomas


