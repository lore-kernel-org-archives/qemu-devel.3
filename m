Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45B8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKgD-0005BM-GF; Tue, 04 Nov 2025 12:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKg3-00055B-Lp
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:18:42 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKg0-0008Oe-5p
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:18:39 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so4866666b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762276709; x=1762881509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHdmdazXI12j/p9HCzPD6NwJ3C9waOah2X0YeNtGq4M=;
 b=ukOt/U/JJBqon6xRy1lDaxl09esB0BF6rhSa50i2McbN7G5FWEuSJY+BufsWX5PXna
 iiscBM/QI41qSxHUDMv+OCM5jZN9dmRnMIfC7DXCr4YhssFXjoTIH5PGdyNLV6uS6b74
 CvnLZ1FG894SbhAlnoqEGST+N1p460PwJ9Bh3BuO67ubIwoXc7jd42vaMqQTFi7A3rsA
 z2w3yvbOmYTPElKfxPDpa7WhlujzNK7bnrdFEYJCUH4zGcYXdPiOWTUbNk6gbvmgNHEn
 iLtgjXDlrUmUxDgDGL6gYoYPO73mQEuarWbbJvVkDuorHJtHGgzK7CjS7dmt0Oy0GSgC
 ZPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762276709; x=1762881509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHdmdazXI12j/p9HCzPD6NwJ3C9waOah2X0YeNtGq4M=;
 b=j3vF9KiDlAZWcwybORC1adjT7tzOyKxGH24KykrbeLbS4l/PI763KlYZT8t7e8QtD8
 aYweYsurxPmyr5VTDTlql5bM8u/7JiCE+yVlz3sxSKRhFbOhL9I8RYaBZzalIaWopHhR
 lpx4ODWaLU6268V6K3wYTWyc29bjs+BRJj11EoQD6vMvtvyU2SfLLSHysrz2eEDRe3ib
 g+p7M+yiu9X0S3lisZleYJGbkeQGx9krghR9KfFCTESQ72/VBlxnPBbxdU+lD/H2hxO8
 DalDZHx3/H2J7nMZrSIRR+HIexea9+N/P2hlCCg+ENWGM3q4MbiNnTSIWxwSLjsJdsRz
 thEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPv6fvZNE7RGTKvHrjS16vcGwtw76SlY7gDZSIDXpOJBOcGqq61lDDYBwAq5H2XBP+Zu1YqvmdP675@nongnu.org
X-Gm-Message-State: AOJu0YxA3PlSGpQ3QmaJJVhuG8tCXDojAlHnaChD+zOsQQgA73v2Tc3+
 3F5HU3NrJyBxTD53g/pUtqUC82Dbl/3lcnV9c/zYupWMNUL6D8EuVoSwY7RhON3nrmw=
X-Gm-Gg: ASbGncvY6XdhBFnXuN2euQV0NW0QoAhxukRnQHYqSE3PVSAcyeEtt6ABNXyFuZkQ7Ba
 k4qV+aRdiKf5QW02gaoGK+2ibBX8QMJaIs4wmtV6NedA4h07Tl6lmiy8MlDJoZu+JTq6dOr0bgs
 yEtJf9KcjzjC1sGjsrRP2lHo/4l910+rQZ+EUbdn3uorn/NA3qcAl/CS0wBj2+1jQIWW7GYD4L/
 BWppa8Lr/luKe3hMSHgrgVuo5MIzhIgnY6NWH+Q0rrF7hg7DWTQsjhLyR4vFjQR8nt9cwI/8Rcj
 K5J6q0Tw8HM8e7UGUy3oOAdKKZSutNLwJZWHETyshAWSFLBZLdbN5paZUDeLugs3zPVQEjbXp41
 7qJYRzNjdFGUysjDMOLxGuxIxwQO1fDMvvXNUyOBxh/GOpaiaTeis3mDCDh+PTByLeOasrkD1IV
 sReSnSKmUD9MMt5VKE5hI=
X-Google-Smtp-Source: AGHT+IEj95ymzoTeG0RFz44DkVYkppyVWLZAwu2K8O8AOZ9ha0z5CiMa6DqS3lMvkNXthytKPUjMYw==
X-Received: by 2002:a17:906:4fcf:b0:b70:aa3e:3b60 with SMTP id
 a640c23a62f3a-b7217a69377mr394594666b.27.1762276709371; 
 Tue, 04 Nov 2025 09:18:29 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a711dcsm2489438a12.29.2025.11.04.09.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 09:18:28 -0800 (PST)
Message-ID: <b38ee8cc-8d9a-4398-b6df-3857a0994d0c@linaro.org>
Date: Tue, 4 Nov 2025 18:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1 5/6] scripts: Add helper script to generate eMMC
 block device images
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <60f265e0b2bea18fe6ef41742600a7e933e3c47f.1762261430.git.jan.kiszka@siemens.com>
 <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
 <8884e7f9-eff4-4bbd-be5e-9d6d2012ff6c@linaro.org>
 <c3bfb192-aad0-4fcb-a787-78f3a2d19695@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c3bfb192-aad0-4fcb-a787-78f3a2d19695@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 4/11/25 18:00, Jan Kiszka wrote:
> On 04.11.25 17:27, Philippe Mathieu-Daudé wrote:
>> On 4/11/25 15:45, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> As an eMMC block device image may consist of more than just the user
>>> data partition, provide a helper script that can compose the image from
>>> boot partitions, an RPMB partition and the user data image. The script
>>> also does the required size validation and/or rounding.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---


>> Still:
>>
>> $ dash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
>                                                           ^^
> User error ;-). This must be just "...:2M".

Per the doc:

+.. code-block:: console
+
+    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img

(I'll update it)

> 
>> Invalid value '2MB' specified for /dev/zero image size.
>> scripts/mkemmc.sh: 170: [: Illegal number:
>> Creating eMMC image
>>    Boot partition 1 and 2:   128K each
>> scripts/mkemmc.sh: 192: [: Illegal number:
>>    User data:                4 bytes
>>
>> $ bash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
>> Invalid value '2MB' specified for /dev/zero image size.
>> scripts/mkemmc.sh: line 170: [: : integer expression expected
>> Creating eMMC image
>>    Boot partition 1 and 2:   128K each
>> scripts/mkemmc.sh: line 192: [: : integer expression expected
>>    User data:                4 bytes
>>
>> But now the file is generated :)
> 
> ...which is actually a bug as well: We are not terminating the script
> inside the process_size function when calling "exit" there. Deviates
> from the behavior under Linux. Sigh.
If you have a diff I can test & squash.

