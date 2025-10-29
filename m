Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C104CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0MW-0006YI-Oj; Wed, 29 Oct 2025 03:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE0MV-0006Y9-Hl
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE0MM-0005VZ-FO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761721957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V7EuQ/QORi9lHyL+ZtakFK14Q1nPGKOITfCyqqZEZ+E=;
 b=BIMwNRGHVCzdDUivXApkTec+Xiwuw7lnZzTYbjQ1qPZsdmL/eIpAqNY0k3nXpMuIFkk0wo
 jyaeAstVStNn7bBc0AmH9SQBZBnipeWhkWc29G0l8hXPqiM60yme6Wixaf2PMtfx5mSdnL
 BT8qf3PJBj44HqhL4n5adc6xfCv2N6A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-o17r5RR-NXuc9D2LyqkB5Q-1; Wed, 29 Oct 2025 03:12:34 -0400
X-MC-Unique: o17r5RR-NXuc9D2LyqkB5Q-1
X-Mimecast-MFC-AGG-ID: o17r5RR-NXuc9D2LyqkB5Q_1761721953
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-428566218c6so3157422f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761721953; x=1762326753;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7EuQ/QORi9lHyL+ZtakFK14Q1nPGKOITfCyqqZEZ+E=;
 b=KinBl33aIFY/G0dPxKrqC8G+lSgNZSyowuaLGpLG7WqF5JDoeKczZGRv6VgmvKrT7H
 wDIO/wlK6IDJhKNIbskDUXLcNilrwHFCfsPe/ImHGrXIdjSqQvVBmr4AQMNQ3J1SPz2y
 sjO91hN5vi34YfHQ09fO0KBv2Il5rUrtUwvKdc3uCs/wDZvJBsbC8ENDb84KpZCOslww
 OLQRNlUZPPvtnbRTCofOqMEJeST4O8AqH6b+hE/HjwFPI63oPgeGfNrPRnFMg71A7Zkj
 PEWF9HjeSQXpEzEr1KZV81YCDGwAzpp7dIw4KICKWa7iNtnWTcuvOyBceapBttp3gfCV
 7JVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB46WJDdvidO4HkdVBXfDncEQSs4kHVHCOw+JtUcBFXhz3iI6hpR0PZPwrv8wzhkIwWobJPZYR5rhM@nongnu.org
X-Gm-Message-State: AOJu0YyWhslDwTtQM2Y/fWmQxpQws9cbWcuZLYyKXbx1QeXVsESZyO8R
 7ElTWwWhEX7D1yMIcprM/NGDjWrpd9E03PLhAVCXeaiQA1MkBaFf5KU45Ax/WCP0ZwEeBLmuTrT
 m5u1MFfUz17XiFgLe3axNlvtytByc7DyX+u6Ja86Pg81YB3+TENeS/7c1
X-Gm-Gg: ASbGncvamLYNi1NAqleG3IUGcBtNw+Iny957e5Xb5ID6e65xd3zHtiWZdE8miiTQjwo
 eikscymxngUXf3LOa5927HrDsGmA9SKhSufxWbh5dxc5qDnPeEqCMB6XJUzqPidq0hcUgiHRvqZ
 LsAfeLh5R1nJ7kBeQ9sThZ639hW0E6xt/1wLnXnZn/UBLOjwLtFDzi2mYMJ88nPWNgvxA9/7KHQ
 gj8qLcUr/jWAgOHCFFZuRy5ikwagtFwb5ySg+lTeUO67+32bV6Pgm60dclcBT+5ggXvih9OCyw9
 TgAQuI30ppNw98ZYS5cfbHYLjZqGFWDdJBFClR6NXk4OMhcO201S0Hyef8kBTTVRnRHMttI=
X-Received: by 2002:a05:6000:2203:b0:429:957b:ee72 with SMTP id
 ffacd0b85a97d-429aefbefbamr1324914f8f.53.1761721952983; 
 Wed, 29 Oct 2025 00:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhZP8tej5Nms8HH1sJGEu+lcFBcRWE8K0eBxvLtshfKmqljqk0PYquKMWd6p6U5XgRK0i3sg==
X-Received: by 2002:a05:6000:2203:b0:429:957b:ee72 with SMTP id
 ffacd0b85a97d-429aefbefbamr1324890f8f.53.1761721952545; 
 Wed, 29 Oct 2025 00:12:32 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b22sm24268674f8f.9.2025.10.29.00.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:12:32 -0700 (PDT)
Message-ID: <c87f0929-a38c-425d-bfb6-d2985b908124@redhat.com>
Date: Wed, 29 Oct 2025 08:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: include the lower level QMP log
 messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251028182651.873256-1-berrange@redhat.com>
 <20251028182651.873256-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028182651.873256-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 28/10/2025 19.26, Daniel P. Berrangé wrote:
> We've seen a GitLab CI timeout failure in the test_pseries.py test,
> where it appears likely that the test has hung in a self.qmp('quit')
> call, but we don't have conclusive proof. Adding the QMP log category
> to what we capture should help us diagnose this, at the cost of the
> base.log file becoming significantly more verbose. The previous
> commit to include the logger category name and function should at
> least help understanding the more verbose logs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 6fc6e1ac0a..5ab84ce674 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -225,6 +225,9 @@ def setUp(self):
>           self.machinelog = logging.getLogger('qemu.machine')
>           self.machinelog.setLevel(logging.DEBUG)
>           self.machinelog.addHandler(self._log_fh)
> +        self.qmplog = logging.getLogger('qemu.qmp')
> +        self.qmplog.setLevel(logging.DEBUG)
> +        self.qmplog.addHandler(self._log_fh)
>   
>           if not self.assets_available():
>               self.skipTest('One or more assets is not available')
> @@ -235,6 +238,7 @@ def tearDown(self):
>           if self.socketdir is not None:
>               shutil.rmtree(self.socketdir.name)
>               self.socketdir = None
> +        self.qmplog.removeHandler(self._log_fh)
>           self.machinelog.removeHandler(self._log_fh)
>           self.log.removeHandler(self._log_fh)
>           self._log_fh.close()

  Hi,

I tested this patch, and now I'm seeing Python stack traces in the base.log, 
like this:

2025-10-29 07:22:45,264 - DEBUG: qemu.qmp.protocol.default._bh_loop_forever 
Task.Reader: failure:
   | Traceback (most recent call last):
   |   File "../python/qemu/qmp/protocol.py", line 914, in _bh_loop_forever
   |     await async_fn()
   |   File "../python/qemu/qmp/protocol.py", line 952, in _bh_recv_message
   |     msg = await self._recv()
   |           ^^^^^^^^^^^^^^^^^^
   |   File "../python/qemu/qmp/protocol.py", line 1053, in _recv
   |     message = await self._do_recv()
   |               ^^^^^^^^^^^^^^^^^^^^^
   |   File "../python/qemu/qmp/qmp_client.py", line 459, in _do_recv
   |     msg_bytes = await self._readline()
   |                 ^^^^^^^^^^^^^^^^^^^^^^
   |   File "../python/qemu/qmp/protocol.py", line 1021, in _readline
   |     raise EOFError
   | EOFError

If if it's harmless, I think that's very confusing for the casual user when 
trying to debug a problem. Can we avoid these?

Or maybe rather log the qmp stuff into a separate file, e.g. qmp.log ?

  Thomas


