Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839B7C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 19:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thvYI-00053z-Ln; Tue, 11 Feb 2025 14:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thvYB-00051m-TH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:04:04 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thvY9-0002fK-K0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:04:03 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439566c991dso5201795e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 11:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739300639; x=1739905439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GBCq46vjoUlQfpjKU7V8oqPcjKvleGbSpv5SUzOOkZ4=;
 b=ktPVLQY9dAZujMMmGZRmgh7wMVUU7MQg8ZEN97ZhlPK49k8TUozXt32q8DjFqwp3rY
 F6FwlVxHcKZQDT6LZyLGuxEUV81cjExUGf3ZpQYQMyinkDavlF4gmz7VsLeJ3GDAvI82
 IJEmubml0uoDeBzP/Ht9c6gtvAvel2pGEzlwnkz4fXoWsT20OC3DLqJ2n/WXlOk4P/RL
 ATnAHsXGNBqrgDK9UC50ad2atvjzcbsdkRf/r4kVeBuXCoWJyEpdKibeGC8oTORn+jok
 gZrcFfSXPpHGy//QOUSNTvsT71lSQjazdaBoJNSDBwbs/KqnTMlhFfKwDqxJnLnQkKCA
 AwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739300639; x=1739905439;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GBCq46vjoUlQfpjKU7V8oqPcjKvleGbSpv5SUzOOkZ4=;
 b=SvVL760cPXF0daJOaSwriHlcqfuSy3bERU1EfMqeD4EpTocJPJ/muVP6u9unAbUDqs
 aAkTdRLeypyqwXQNcbMkCQJeYj+7/lFIpFhGHHW6joxAkubAXiyIO5dlnSifxOOU4/Fm
 U3xJUp/2MFc6dn0XhHm6+Xz2Bi2NoIQubA5o++MxrzNIzbRJ2Equky9IsPjbXKnAAChc
 3XeJbTIhiJcNmIXREaJa9h63yv0PaaoMGnnCuZ4Cuz0ScSeUaXYAcZz8wQCU5eQW/dyD
 TyGQ3oW+ok+fcQNQ/Otqdy/Zmm5DY/j/2PEzVzSO1DZGAKRyGuvjCWBNY8CHa4iBaR7L
 adOQ==
X-Gm-Message-State: AOJu0YyvCd8JX3Ewnj74j39bE2AhJ/+6Z+z+KEQ7tSIKeuDIaLUtiZB+
 FSsKPq45900iheCc4UdeINPfAt7ETEghFPwrOO2t27DS98n9lz4lcPihzYTx/AI=
X-Gm-Gg: ASbGncuNEAzkPrGn7qHFxwea4uohLSZBR9K9bWLd+XOasN3wV8XkFfo/6Qttal1d8/u
 /7d/vb/F8YgyQI91ULgpLTgKEvqULO+katxfdbfVZV7AeFA0dpl8z1nXu3cZ0WuGfwJaZPsaJJz
 bx51eJ3Tgp52nMDNeQ+ZoC7rhmhw6Vd1yNrIarqx6+v/yzaUa8WKFYu9wfWnb8ruUSupezeB7cs
 VlTQABKvHz0uLNxg40rSn12TUyzv0dvOVAWpJXFJxFmDY5/TVFxtnFXlim/U24OORQVgMQ8BzbZ
 1wS3v6A3462rCvc+T1eGd92UCw+vwUedh4BSUEyqKati6EoZfYxak4ll8VM=
X-Google-Smtp-Source: AGHT+IHOAFkJtEhXlZzWzXjTHVC89I/irqytrvIYeVhnfDlHRr2EKUlPE3RZjdXBzoAzRQWZfHxFJw==
X-Received: by 2002:a05:600c:1d97:b0:436:e3ea:4447 with SMTP id
 5b1f17b1804b1-439581cbbb8mr3884005e9.30.1739300639177; 
 Tue, 11 Feb 2025 11:03:59 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da96502sm189706295e9.1.2025.02.11.11.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 11:03:58 -0800 (PST)
Message-ID: <39314f09-268f-48b8-add5-95366c254f81@linaro.org>
Date: Tue, 11 Feb 2025 20:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
Content-Language: en-US
In-Reply-To: <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/2/25 19:53, Philippe Mathieu-Daudé wrote:
> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
>> On 11/2/25 19:26, Stefan Hajnoczi wrote:
>>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
>>> <philmd@linaro.org> wrote:
>>>>
>>>> The following changes since commit 
>>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>>>
>>>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/ 
>>>> armbru into staging (2025-02-10 10:47:31 -0500)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>>>
>>>> for you to fetch changes up to 
>>>> 1078a376932cc1d1c501ee3643fef329da6a189a:
>>>>
>>>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo 
>>>> (2025-02-10 21:30:44 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Misc HW patches
>>>>
>>>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>>>> - Make various Xilinx devices endianness configurable (Philippe)
>>>> - Remove magic number in APIC (Phil)
>>>> - Disable thread-level cache topology (Zhao)
>>>> - Xen QOM style cleanups (Bernhard)
>>>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>>>> - Invert logic of machine no_sdcard flag (Philippe)
>>>> - Housekeeping in MicroBlaze functional tests (Philippe)
>>>
>>> Please take a look at this CI failure:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
>>
>> Hmm I can not reproduce locally this error:
>>
>>    Exception: Asset cache is invalid and downloads disabled
> 
> OK, I could reproduce by blowing my cache away.
> 
> The problem seems in the "tests/functional: Have microblaze tests
> inherit common parent class" patch, which does:
> 
> -class MicroblazeelMachine(QemuSystemTest):
> +class MicroblazeLittleEndianMachine(MicroblazeMachine):
> 
> I presume, since MicroblazeLittleEndianMachine is no more a direct
> child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
> downloaded.

Well, apparently related to network failure:

INFO:qemu-test:Downloading 
http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz to 
/Users/philmd/.cache/qemu/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
ERROR:qemu-test:Unable to download 
http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz: HTTP 
Error 403: Forbidden

$ curl -v http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
 > GET /2023/download/day13.tar.gz HTTP/1.1
< HTTP/1.1 301 Moved Permanently
< Location: https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz

Using:

-- >8 --
diff --git a/tests/functional/test_microblaze_s3adsp1800.py 
b/tests/functional/test_microblaze_s3adsp1800.py
index 177c8a685bc..949e627c84a 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -24,3 +24,3 @@ class MicroblazeMachine(QemuSystemTest):
      ASSET_IMAGE_LE = Asset(
-        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+ 
('https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
  
'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
---

I still get:

INFO:qemu-test:Downloading 
https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz to 
/Users/philmd/.cache/qemu/download/b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...

However:

$ curl --http1.0 -v 
https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
 > GET /2023/download/day13.tar.gz HTTP/1.0
< HTTP/1.0 200 OK
< Content-Length: 4752277
< Content-Type: application/gzip

So I'm confused...

> 
>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368/artifacts/ 
>> external_file/build/tests/functional/microblazeel/ 
>> test_microblazeel_s3adsp1800.MicroblazeLittleEndianMachine.test_microblaze_s3adsp1800_legacy_le/base.log content is:
>>
>>    2025-02-11 16:24:55,525 - DEBUG: Extract /builds/qemu-project/qemu/ 
>> functional-cache/download/ 
>> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
>> format=Nonesub_dir=None member=None
>>
>> which is correct:
>>
>> $ sha256sum day13.tar.gz
>> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
>> day13.tar.gz
>>
>> Did you restart the job to see if it is a network issue?
>>
>> Regards,
>>
>> Phil.
> 


