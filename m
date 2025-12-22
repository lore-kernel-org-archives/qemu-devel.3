Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D998ED711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 08:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXbOa-00015z-9s; Mon, 22 Dec 2025 03:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXbOU-00014f-PT
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 03:35:54 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXbOT-0000j0-8f
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 03:35:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso37990535e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 00:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766392552; x=1766997352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UyTqbgDkjQVekylmGLMrwabdQy9mfI7IUPxFYRV3enk=;
 b=RHFdG8Ea1tvFPmBo1uXZiymabdDesDD3ry2xhcTfIKCfPNZrzUCdaOgCQ72SX6x7uL
 3Z0XowONm9S0PoeLaLDSxpOcN3iVb3ChUT8RkClnqq3b0MxwWIj/Cf03Y2uaBtvCcCo2
 zCS4c46yj6iDIjVWIobPehDNM6v3q6dCK6vTeTBjl57xYfcFvmuniPsBxJbi3LEclf3J
 86uz3Lt5xWr8jCHhxkBwtfOqiw6fUTwDaqy3I2NU2+a+cGLBQ35fm53bQ9Z2CNFr1hSZ
 YleCZIn7qA2RQRIbX08kfW7Oe2Fsi1U2o3dhaKMAvWe56OgoD5n5cKO/pCVfLw7TP+US
 qpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766392552; x=1766997352;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UyTqbgDkjQVekylmGLMrwabdQy9mfI7IUPxFYRV3enk=;
 b=qyefW0rMP5Pja1KMDhESOOW3Hsu3qxXXL7hxuS2cS9ptewcY5mTLpKwSA+IJyd/U7P
 hugSIps5NNKwf9EalY+LRXHVFzDyPnUB5a9zeSLuZAr7W0jDQdqGQrEp3XycTkTHPPwq
 BODB9xQvHd1rLw3Kl/jtjUubl96wkWnttHrNNRZL4M12Tzualcl+xe4m7K5/FtcNQ/lv
 ZsPmng37NbyCyr3HvUO9HsjxTahrl6AoGlU0IlpT7HKlKZp8xifTFy4+uLbWLfhHadmK
 tCAwTqUBc4FDjz+FYDQdekEAxp16STS1aery/0C+JkCJVC8MFSX9hPThGIXMw1M0fbud
 Bn3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOiUGejqixstH26Eiq5q2/kKmsQYQF76IQlaUG3a8eiDocZhq/hN9l0rkY5qjJUU3+7w9XcjMBK7Cb@nongnu.org
X-Gm-Message-State: AOJu0YzDdHNCGDD/uQvu3XWE+JMJhWrREVWWRSb13GzX0aauLvNiErjM
 nhKsGCQy2xMiLSIWLLudWcLhbVR8dX7IjsUi7sKAww/2S99vIHBcvODCOfwtyrC+Xo0=
X-Gm-Gg: AY/fxX4mJ1xsJ5M92UbOmwitXteFBM2lbqZmMZtW7PxEd5afBp+9WswneCIp6iQsWp3
 23RlmKm/FZ6psuNOudlWiW1GcMgKmE1EljRJSwcNTsg6MXv+EEti2JXODl54MecHnx4XCt8V0Kx
 45fZrMk0Dw4c2lPtiSbfbRPRqM1vpL0SqjM9VMGKyeUbZiJAUsBGi76NA39jYc5ORiAv+jiRzZe
 HRTGnJNyhM89O2pfadNBpaBI2fqcZ1PVLzPdfMA5ox4dpCM77DptfjeyNH75e4YdT0QTO4r0fH6
 pnnGnZDNyOC711liRmTCiy0Ql7dqMZs/EjzywgGGgE7rFIxb21EwcTk1LS+A4l8od8Br7dBajun
 TTNSsacJd3ZLGOGfoEJ5SjwQfnUvLUJLlBsJLVOGMOxcAea8gywY3YpN3qrHpaqA0s0ymsbORw5
 N8Nkiv0LR8ybfvl0VjNsWo/KP+wbkWV7YRXTAx3L13mumN3cnbLW4a8g==
X-Google-Smtp-Source: AGHT+IGnlVwf9WSN3zteCQN5ORftJt2NEoX0HOr/dGnNsteNLxUQJ+lnOZ+Mh8TXHgWTcmil6dggkg==
X-Received: by 2002:a05:600c:64c7:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-47d2950b309mr42615375e9.31.1766392551612; 
 Mon, 22 Dec 2025 00:35:51 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a5486dsm92551145e9.9.2025.12.22.00.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 00:35:51 -0800 (PST)
Message-ID: <9e07d4e0-c407-448c-ac5c-10d153a1a11a@linaro.org>
Date: Mon, 22 Dec 2025 09:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
 <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
 <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
 <f23ec136-5b6f-45b2-a6f1-1668e58a4030@linux.ibm.com>
 <e219df64-1712-4ace-8358-d825de26fc1a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e219df64-1712-4ace-8358-d825de26fc1a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/12/25 09:17, Cédric Le Goater wrote:
> Hello Farhan,
> 
> On 12/19/25 18:30, Farhan Ali wrote:
>>
>> On 12/19/2025 8:30 AM, Cédric Le Goater wrote:
>>> On 12/19/25 17:21, Philippe Mathieu-Daudé wrote:
>>>> On 19/12/25 15:51, Cédric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>> On 12/17/25 19:42, Farhan Ali wrote:
>>>>>> The VFIO pread/pwrite functions use little-endian data format.
>>>>>> When enabling the Bus Master bit, the value must be correctly 
>>>>>> converted
>>>>>> from the CPU's native endianess to little-endian format.
>>>>>
>>>>> How did you find the issue ?
>>>>
>>>> I presumed using VFIO on s390x hosts...
>>>
>>> yes. I have been using a nvme drive for over 2y in an s390x VM and never
>>> saw any issue.
>>>
>>> C.
>>>
>> Hi Cedric,
>>
>> I have recently been experimenting with QEMU NVMe userspace driver and 
>> PCI instructions from userspace [1]. On some of our test systems I 
>> noticed the driver being hung. After some investigation we realized it 
>> was due to this issue.
> 
> Do you think you could provide a test case for it ?
> 
> Also, I think the LE conversion should be done in routines
> qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config().

These config routines take a void buffer, so have no clue of endianness
size.

Maybe we want intermediary qemu_vfio_pci_ld16_config() and
qemu_vfio_pci_st16_config() helpers?

