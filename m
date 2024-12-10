Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F61E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 13:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL0Cn-0005y8-JS; Tue, 10 Dec 2024 08:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0Cl-0005xw-Pw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 08:23:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0Ck-0001kC-3Z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 08:23:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso60160905e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 05:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733836988; x=1734441788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rSwfECw1HRJO1kdHWBYXyzdU//dlJB0pg0gdADzsEok=;
 b=obG7y/uNreIOtrHYkxbchgd7dObMQHZR1xCB9Yx7tewLVIqC0vXLNTxjt9Xi7Sd71f
 OoiIBbvUYp3QuSuqGyva8WfZojBU6dhNeqzDGgf4bkR3Ah6lqWpyjUILidpJEWaVdrvB
 78N14S63wNV6pniVovuIM9j2NuxmtwI9AFA+o4HaFlha2enumWmhiAcHJXnF/bkzRL0Z
 pQl713CfcQp5AZHvqpORsZaBjDDs7SR4bES0gBw3TqkhYHr9cOOEfomXmD0A4JIXcUPv
 4JvchHVWbaUpWIiF+CeZiTWkldABynT3x1NzYLHbQa4X9WuWyITyWVjRzXUN/r/FK3iq
 2B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733836988; x=1734441788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSwfECw1HRJO1kdHWBYXyzdU//dlJB0pg0gdADzsEok=;
 b=BsjUCpvb9UPOGndNXlhuV/If7S9MHv/Ub0WXUhLMGTTiLUxL7ZNhVNCJo25AYnJO0C
 5ibXVLgqGu8dD8AjfNcrdXvXq4+fVavRdjaE48jedtclEJP0fEJ20h9kYdw8VTOwcURi
 qwpjCe/vrQGPZtayFrkaz6a+7NcLziNdB2vsqWc7MD1UqWRmvmdo5VPFCK5BBYCmkze5
 KYkVtSAGKiSusCTNwUJ52gkrP1YYcmPDEynD9Bq3mkUOH8IkAqwx8A4NO1HMHpQoy2Jh
 K8s3TlJEcgQJhaoVXpnDDspS5bSG79fUrfdKA0+tqRePSmC9ROZJKkNn11hPIIW/4PF3
 fyqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHQpHSid1vzFjwTfoWA9B9nB7JOwG4Znpb0fZG6SbBugvKEinKO6Q5kDJY+cYS6vrGtMlckB17Qs1K@nongnu.org
X-Gm-Message-State: AOJu0YzCXJyteLSCGpTfIYQsSwrnY3MYCHGtSzgoT6yjsNS7jSW77Y0g
 ODwCgNgu77JvtOdAoUPQ8T6MLNSPOVstsdhisFcaHtN/jB/aITmPPibzalYaMIc=
X-Gm-Gg: ASbGncsQPrPw9UQj7BKM7DIWochZwk+ITIsdPu/O3TSdEtU6KyJvH4sS0rE3lisDwAD
 tAyVOg1IWROsAF8E+knvzm8YZQgEjadYGwGEz+jK6MunJ5wHg5g/Sh3SFSvVn/Xg4z1N4dLk4zi
 6xxCxSXU7naTsPQPDXnFUC913yyNGlu1ZRKLeY7bYyeMhHQ3qJJlwbxZn/9BoiOQJkVL94o+Fso
 nHRrECn4IXJbUsdWzk8/WyfMAtP4PEuB5hE/0mZPvStnumFXs64G02xq8YY1G2ULuKtzXDSDDsF
 Tud6No3eOfU/mEnYdhW0tk8D
X-Google-Smtp-Source: AGHT+IEBo7npa6DIBWE6DE/b0pr9W1e7WRq/58Nln3YbFdX/FD4vhSWfSRjZ7t4K1krBYmdwhOtrGQ==
X-Received: by 2002:a5d:6d89:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-3862b3ea28bmr10560205f8f.55.1733836988015; 
 Tue, 10 Dec 2024 05:23:08 -0800 (PST)
Received: from [192.168.224.213] (223.132.22.93.rev.sfr.net. [93.22.132.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38636c919e5sm9946241f8f.18.2024.12.10.05.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 05:23:07 -0800 (PST)
Message-ID: <ad2e35bd-ac8f-4987-b970-f0e8de90acc3@linaro.org>
Date: Tue, 10 Dec 2024 14:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert the intel_iommu avocado test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20241210125639.101033-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241210125639.101033-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/12/24 13:56, Thomas Huth wrote:
> Convert the intel_iommu test to the new functional framework.
> This test needs some changes since we neither support the old 'LinuxTest'
> class in the functional framework yet, nor a way to use SSH for running
> commands in the guest. So we now directly download a Fedora kernel and
> initrd and set up the serial console for executing the commands and for
> looking for the results. Instead of configuring the cloud image via
> cloud-init, we now simply mount the file system manually from an initrd
> rescue shell.
> 
> While the old test was exercising the network with a "dnf install"
> command (which is not the best option for the CI since this depends
> on third party servers), the new code is now setting up a little
> HTTP server in the guest and transfers a file from the guest to the
> host instead.
> 
> The test should now run much faster and more reliable (since we
> don't depend on the third party servers for "dnf install" anymore),
> so we can also drop the @skipUnless decorator now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2:
>   - Download the cloud image qcow2 and use it as file system
>     to exercise the virtio-block device
>   - Instead of removing the "dnf install", transfer a file
>     via virtio-net to the host
>   - This needs find_free_port() now:
>   Based-on: <20241204071911.664057-1-thuth@redhat.com>
> 
>   MAINTAINERS                          |   1 +
>   tests/avocado/intel_iommu.py         | 122 -------------------
>   tests/functional/meson.build         |   2 +
>   tests/functional/test_intel_iommu.py | 176 +++++++++++++++++++++++++++
>   4 files changed, 179 insertions(+), 122 deletions(-)
>   delete mode 100644 tests/avocado/intel_iommu.py
>   create mode 100755 tests/functional/test_intel_iommu.py


> +        # Check virtio-net via HTTP:
> +        exec_command_and_wait_for_pattern(self, 'dhclient eth0', prompt)
> +        exec_command_and_wait_for_pattern(self,
> +                                    'python3 -m http.server 8080 & sleep 1',
> +                                    'Serving HTTP on 0.0.0.0 port 8080')
> +        hl = hashlib.sha256()
> +        url = f'http://localhost:{freeport}{filename}'
> +        self.log.info(f'Downloading {url} ...')
> +        with urllib.request.urlopen(url) as response:
> +            while True:
> +                chunk = response.read(1 << 20)
> +                if not chunk:
> +                    break
> +                hl.update(chunk)
> +
> +        digest = hl.hexdigest()
> +        self.log.info(f'sha256sum of download is {digest}.')
> +        self.assertEqual(digest, hashsum)

Nice :)

