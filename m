Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D228C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhwy-0007tK-CW; Tue, 15 Jul 2025 11:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubhMZ-0001Gr-2T
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubhMW-0004EF-A0
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752592470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iyHbJ+SpNG0r7Tm/XzRMXRrs2ibOafzZhWnGGCPXemA=;
 b=dVfgK3wvYE0rn13xpAb6qqqrB3gNaZDSqPvRmSm8vk3sXr8vUCkBL1iCspTMQcouufyxlo
 rmu9L0BYVe/i55jm0G410QrJOv9Fh3RIGSjefTmaUCw/GB4nNBUVsU0LwwMXIn+7UYzoj/
 NnbW9gQaSwst2MwmC4Wx9PJgfmfxnFQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-AQgKbTVLOoeIAjhoKNfQtg-1; Tue, 15 Jul 2025 11:14:29 -0400
X-MC-Unique: AQgKbTVLOoeIAjhoKNfQtg-1
X-Mimecast-MFC-AGG-ID: AQgKbTVLOoeIAjhoKNfQtg_1752592468
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so3346652f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752592468; x=1753197268;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iyHbJ+SpNG0r7Tm/XzRMXRrs2ibOafzZhWnGGCPXemA=;
 b=hWvPbPNrFc7CmiNZ36W80w3tPn7tDQSCZk4c+piElCfb/6BUx/nc4IWcVhFX4BflqO
 CKrv1DOgbvcnRhG1IcskLHWA+KDMGFbwKCpYXSCnJNI5BEPIwnPVA8HrvDBJY+HN+VAB
 jLusg79tFP9cJ1//PKnFhIWNL1+HhfFDDBkrwwLActObqcB/2wns+bdgiPY8aQpKgKUn
 HbpyfYcJUXilw0alUGVP+fY/LJFE0EVLfqSUNVdbkPvXgJHjJ6bPA3k6ukCoW8zpeyZV
 1N6OkuZoOCPYA/+8fHUdalie2GD3wbOqtlwDIr/pHDd3P/djSeIOpCR/0sUTXNnfNS8d
 KBkg==
X-Gm-Message-State: AOJu0Yxzwj6yuNpxTQwjFibxHgJSCzPzjIi2ibApMKkc/eXcp0aYDc7j
 QfRyMB/dipPfuHnN6m2ct+A4XsCfLz4tNgGX2gQdFySSQoBYz+b2rbOFnZy3021/u+HKJ8mTwlS
 jy7XJNOaGfO06YT/jFpyZZ8GJ6LrR4Y/6kbLxFeHK9rkYcl4A/X4cd38u
X-Gm-Gg: ASbGnct2D0v7IroxeEpieZpe3PjnBdX/jSs2fF1Vuz1VA7VnqCVEEEh370nrHaIcGhV
 SDpRLYH3DKql2lI8dn4JneGh1tBKDNsX1Go3TMcsCixtqLTEvB+Q9lGBCfLm2zp4yM9maL8Z1t4
 XHz+jN5Ixqyum3eL5V8S8rPD21GPUpenwbjO/RKNtYtcz4HO67DywhvExeKXhfoFqoVb+QQxjaW
 VJ4hLPf5E2rBaEZ+SjDT7NInNeRHZtBrv8HUFOd89+8R8sR4Ipn4nctPsy2P/aTUWPDLw3zULA2
 Sr7H2U19icGXsvVR+jBtja/viqe2E4MM0QjR24E2MLtGmFOtmvMl0szRmIbBaZuSkJFiajexv97
 YKGnM
X-Received: by 2002:a05:6000:460a:b0:3a6:e1e7:2a88 with SMTP id
 ffacd0b85a97d-3b5f2e3b83fmr11590875f8f.57.1752592467649; 
 Tue, 15 Jul 2025 08:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHRREjq9NHbvRWPlOveulEqA2YLLAyNngVE38WmQYTmjtRJtayVIyLp0VohPiT6inm6CjHMQ==
X-Received: by 2002:a05:6000:460a:b0:3a6:e1e7:2a88 with SMTP id
 ffacd0b85a97d-3b5f2e3b83fmr11590858f8f.57.1752592467197; 
 Tue, 15 Jul 2025 08:14:27 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-130.pools.arcor-ip.net.
 [47.64.115.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456278ab486sm18236765e9.1.2025.07.15.08.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:14:26 -0700 (PDT)
Message-ID: <29f3e9c2-edae-446e-b7ca-05df89c2e5dc@redhat.com>
Date: Tue, 15 Jul 2025 17:14:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] functional: ensure sockets and files are closed
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Cleber Rosa
 <crosa@redhat.com>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-10-berrange@redhat.com>
 <97439ae2-5d37-49c2-a9d4-ff2d6aefee3b@redhat.com>
 <aHZvye9EfVjsvDj2@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aHZvye9EfVjsvDj2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/07/2025 17.12, Daniel P. Berrangé wrote:
> On Tue, Jul 15, 2025 at 05:03:07PM +0200, Thomas Huth wrote:
>> On 15/07/2025 16.30, Daniel P. Berrangé wrote:
>>> The multiprocess and virtio_gpu tests open sockets but then forget
>>> to close them, which triggers resource leak warnings
>>>
>>> The virtio_gpu test also fails to close a log file it opens.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/test_multiprocess.py | 3 +++
>>>    tests/functional/test_virtio_gpu.py   | 2 ++
>>>    2 files changed, 5 insertions(+)
>>>
>>> diff --git a/tests/functional/test_multiprocess.py b/tests/functional/test_multiprocess.py
>>> index 751cf10e63..92d5207b0e 100755
>>> --- a/tests/functional/test_multiprocess.py
>>> +++ b/tests/functional/test_multiprocess.py
>>> @@ -83,6 +83,9 @@ def do_test(self, kernel_asset, initrd_asset,
>>>                                              'cat /sys/bus/pci/devices/*/uevent',
>>>                                              'PCI_ID=1000:0012')
>>> +        proxy_sock.close()
>>> +        remote_sock.close()
>>> +
>>>        def test_multiprocess(self):
>>>            kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>>>            if self.arch == 'x86_64':
>>> diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
>>> index 81c9156d63..be96de24da 100755
>>> --- a/tests/functional/test_virtio_gpu.py
>>> +++ b/tests/functional/test_virtio_gpu.py
>>> @@ -108,6 +108,7 @@ def test_vhost_user_vga_virgl(self):
>>>                shell=False,
>>>                close_fds=False,
>>>            )
>>> +        self._vug_log_file.close()
>>
>> Maybe cleaner to close it at the end of the function?
> 
> This was the last place it was needed - just out of sight in the context
> of the diff the file is passed to Popen() which connects it to stderr.
> So nothing in this test may access the file after this point to avoid
> concurent overlapping writes to the same file.

Ok, makes sense now.

Reviewed-by: Thomas Huth <thuth@redhat.com>


