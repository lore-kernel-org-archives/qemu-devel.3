Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9748DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubha3-0004Wh-Li; Tue, 15 Jul 2025 11:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubhBi-0000d3-Da
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubhBc-0007nC-PN
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752591794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NEcmyYJ1+pYMzHiqkewyZ9RXIuw6PY3YFi/7lYWIPnU=;
 b=egMxMQaig2ICSroDrHlm2/cegGw5Cov/QiCCgnW12sxKx/6Wam4A/+JynMT1NFAqBElf+c
 SOkm5Nb3mjyAjMJeoLuUX6AgFW5X+IDsWh6SoV+UhIIjcPQ/1AwlkqKJC02DGSfZZCx/XO
 NkPUt9nyhFSd0Z7amwnmEg/gI2tFqD4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-eU6YugVTPeuUGIV8jeLo8Q-1; Tue, 15 Jul 2025 11:03:13 -0400
X-MC-Unique: eU6YugVTPeuUGIV8jeLo8Q-1
X-Mimecast-MFC-AGG-ID: eU6YugVTPeuUGIV8jeLo8Q_1752591792
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561bc2f477so14394965e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752591792; x=1753196592;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEcmyYJ1+pYMzHiqkewyZ9RXIuw6PY3YFi/7lYWIPnU=;
 b=OSDpFbU3OdzRIxYBCdqY9Zqw9DYB/9OjzsbKLIgDFKDipZClfXfDpKLiDpl7QhY19e
 +tTh59vabMcrmO3CnrfJyNl2RiHBGDz8qVxewSBTOz6/3IVl0gAYEHWMOuo6UB4DDjNF
 EsfhD4xzS4EHXkQuTYMlJankjk6x/EAKQm6i4alv7hyBuSyaXvQq/xsyZ6JedbsjeZyd
 q0Fd5EtdCUPLXOQzmSEj1jF/oGrkz1h1LmGlaDlwnUEgai51rT8g7apbo2AeVFvyHZOW
 r1nZDZ3TEBMmbtUwm+N6eiGUhkzAvi2353ACX2ESj9WCtydGFlxsJja3rxrvepsWR3sy
 EBSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM+AUMhi2KzZKwpiDDNWbhECMQ/mW8dFW9kRZ+WhW24MxMcm4250rLjB9RHUzua5USUCzRpPzDNWjm@nongnu.org
X-Gm-Message-State: AOJu0YyQWgdiNLollw83C4Jr6+A8SVCHCRyhrCBa6oyfRegwaEwsu9HC
 0uAQz81P+vsYOSMHjlzIlmRnaU88iuZIu25uZ/OIP+dip/UGa/tc47OH9yKbbmJWFmj+Z3IqY4O
 MlRj9HhHiNUwFgt/qvsqrgFkPgQlz+0gWiy0EifSnigd0zbUhndslJ/Ey
X-Gm-Gg: ASbGnctXkqT9rfwlqSG7Qw2XVgAPAX9UuzOS75z4i/asr1ZBP4EwU54CC1SLLi6508W
 cfj/Mzi9q3ZzqYzk1NC/4DQcNI9GQbIeYIp8wtvT1B2bFOUqedbGyCrJafXoK6XIJG+Vzcj2wis
 0NEPN/md2OiNVlKbLj6JitLJkOvdA/Qvex21C5I+Q24Zak4JmwksmjyfzWEoF7jsZT8tQ09rGpZ
 8BnYFaeuzHO/FvmkdXZ3KDwJ1xIcLD/ZYZ68tXoCTYwkqYvE8Qs31Vfd6vY3jdgnJnvGMVgXFYN
 JMl8DH9lB6kGazhjLgUF7ZCnz7KeEVIw3ay7gOl5OG19Tu5o6/MNjsyTqrAWtpTmsn/pPiyc8lo
 gnmJB
X-Received: by 2002:a05:600c:5387:b0:456:76c:84f2 with SMTP id
 5b1f17b1804b1-456076c88c8mr141520775e9.30.1752591790104; 
 Tue, 15 Jul 2025 08:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWHVs0ewH7mnRtJ3Oc+duBF/nyTyCH/yUsud/Lqy898l5foJB7OVNkv8gG5/yVT0Sn5kN6EQ==
X-Received: by 2002:a05:600c:5387:b0:456:76c:84f2 with SMTP id
 5b1f17b1804b1-456076c88c8mr141520255e9.30.1752591789408; 
 Tue, 15 Jul 2025 08:03:09 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-130.pools.arcor-ip.net.
 [47.64.115.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560ceb130fsm99940955e9.26.2025.07.15.08.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:03:08 -0700 (PDT)
Message-ID: <97439ae2-5d37-49c2-a9d4-ff2d6aefee3b@redhat.com>
Date: Tue, 15 Jul 2025 17:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] functional: ensure sockets and files are closed
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman
 <jag.raman@oracle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-10-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250715143023.1851000-10-berrange@redhat.com>
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

On 15/07/2025 16.30, Daniel P. Berrangé wrote:
> The multiprocess and virtio_gpu tests open sockets but then forget
> to close them, which triggers resource leak warnings
> 
> The virtio_gpu test also fails to close a log file it opens.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_multiprocess.py | 3 +++
>   tests/functional/test_virtio_gpu.py   | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/tests/functional/test_multiprocess.py b/tests/functional/test_multiprocess.py
> index 751cf10e63..92d5207b0e 100755
> --- a/tests/functional/test_multiprocess.py
> +++ b/tests/functional/test_multiprocess.py
> @@ -83,6 +83,9 @@ def do_test(self, kernel_asset, initrd_asset,
>                                             'cat /sys/bus/pci/devices/*/uevent',
>                                             'PCI_ID=1000:0012')
>   
> +        proxy_sock.close()
> +        remote_sock.close()
> +
>       def test_multiprocess(self):
>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>           if self.arch == 'x86_64':
> diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
> index 81c9156d63..be96de24da 100755
> --- a/tests/functional/test_virtio_gpu.py
> +++ b/tests/functional/test_virtio_gpu.py
> @@ -108,6 +108,7 @@ def test_vhost_user_vga_virgl(self):
>               shell=False,
>               close_fds=False,
>           )
> +        self._vug_log_file.close()

Maybe cleaner to close it at the end of the function?

  Thomas


>           self.vm.set_console()
>           self.vm.add_args("-cpu", "host")
> @@ -135,6 +136,7 @@ def test_vhost_user_vga_virgl(self):
>                                             "features: +virgl +edid")
>           self.vm.shutdown()
>           qemu_sock.close()
> +        vug_sock.close()
>           vugp.terminate()
>           vugp.wait()
>   


