Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717A6D46BE0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 18:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlA4X-0007yH-CX; Wed, 28 Jan 2026 13:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlA47-0007sq-D7
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 13:14:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlA43-0002n3-H0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 13:14:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso971985e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 10:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769624090; x=1770228890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRcUh7PURIcQwzuyI23M4BSLo5kjaU/4yRKy2aKy23c=;
 b=CVNWK+NBzBzVu58wS+AJgHS1agaPVNnPQyOiI0CZaXPUPMKbL/RTbotFg13QL6PVYM
 tncWOm6apX83KkQsB1SNBcSbTZ7Z4zSBbGHZR863i6NmBGH+3dZBAEvSej+1kR2ADiUJ
 rRFQ2tUvd16LV+PGo0mRShOMgISKcZfAgqCHhQL2CvRyR+zRulsnSdIjOHk10SGd/Zlh
 H9RRTxyYsCcWPKy8cctgVNsfLO2vTIrGlPH5CBTtN6SvyzaL8DK1AfvGD1jXAnSNuzxX
 Wto5GyS+W4M2F6Z0fhglC5n+/+Kq9UmxNwyvBjZPvbRmo4AIxf9ClM0Nh6AdYxqOfc1k
 unGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769624090; x=1770228890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DRcUh7PURIcQwzuyI23M4BSLo5kjaU/4yRKy2aKy23c=;
 b=uSPmVkdFFCS5Mt2UBvVJytQIaNHmmP8QrsqKwJda30/dwrIPrHjvNLyreA4kuUWbXe
 tkwllxBr2nQxfLfXp0zconP3CwNrCA/umTM9/o4d2S79MJZwTRQrw5Q5KMnrf3FEuHvp
 SKbmlftRCR05esIh+JzvOiig/Y/9+fQvZLPGydU5ssGQViBuXS5UEKJxNiCsAbLh2GNg
 c2QvKpQR+vZJfKCKvvJns+bxDxOHKcMiPESc/vxr79+I3Q24Hgu/j7K6tFjVRW3XsgUX
 VEwOXLq6RpCURx4YfDigYCG0yt1I3JdN7biQiliFrdLFSpi4yOLdrm+ITG1HcFVm3eAJ
 ijGQ==
X-Gm-Message-State: AOJu0Yw+O+fQDMIEiQCWMzjfAA6LMhkYeNqcHb8xtRUAb5NG7nixe2Cl
 eZIyhtzF3CsrgGscTWT3j3I38kDpLupvL3REGDgkGjIwHaHs+W6WIfxIAKbxujzllCw=
X-Gm-Gg: AZuq6aJ0hyvfDBTe0/1Q39RCoTrxSw2D+mo6N36UBo8rloZFyMZ8C/6/0ruAkGMldrB
 UguPYNvLh4ubgr+svSrZfTx55UHM6sLGdgwtKfN5BHSh7YrDnHy10sUfbI+noQwrnCtf1LKnHCw
 kVqJdUbIGyQP8nPF+sKhomN9FWV29l9QBKeREYOMwmUDKMI/0WZmAjQ4At5C6m5fQy6hsVWcgoD
 BVD4Ivdo+VatOuegJsd/wNBWv38XRKR35VVZyOfuzPSb8W8yRKc+dQwSY2CkVNQTyVB3fwTh3TM
 A+KB0BPQgjesn2V95wBrbdXk1yMl5ElOO81fsCkkKSb3Oigu+Z9iuKVs9dIhHgzIoCUOlGnbJQi
 BjH7Goko8Ik+wI6C0MMeS3+upldI/wNACOkOM1Ueaf2wIaO/1eS3qTOE0KzgGOo/UVQoXPU2KSU
 BERTLMo5sGJcLI2tjK0m0xMsfRU1FBhkmyrQiZSDCDepjrWnoTraCfzg==
X-Received: by 2002:a05:600c:8208:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-48069bfa957mr79894055e9.3.1769624089834; 
 Wed, 28 Jan 2026 10:14:49 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce564f9sm82659925e9.14.2026.01.28.10.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 10:14:49 -0800 (PST)
Message-ID: <2448d9d2-fe73-4099-8724-fac68d2533d0@linaro.org>
Date: Wed, 28 Jan 2026 19:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: migrate sbsa_ref test images
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
 <20260128105839.3487840-3-alex.bennee@linaro.org>
 <CAFEAcA_sT6pGhXPpgaEqkJOVuAj3e1KMz_AP6-MZ6YP41YvoRQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_sT6pGhXPpgaEqkJOVuAj3e1KMz_AP6-MZ6YP41YvoRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/1/26 17:25, Peter Maydell wrote:
> On Wed, 28 Jan 2026 at 10:58, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> As the builds in codelinaro.org are going away migrate the binaries to
>> share.linaro.org. As the hotlinks don't encode the filename we need to
>> explicitly tell uncompress how to handle the files.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
>> @@ -54,15 +54,11 @@ class Aarch64SbsarefMachine(QemuSystemTest):
>>
>>       timeout = 180
>>
>> -    ASSET_FLASH0 = Asset(
>> -        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
>> -         '20241122-189881/edk2/SBSA_FLASH0.fd.xz'),
>> -        '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
>> +    ASSET_FLASH0 = Asset('https://share.linaro.org/downloadFile?id=kyoMLGC9zXa4oA7',
>> +                         '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
>>
>> -    ASSET_FLASH1 = Asset(
>> -        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
>> -         '20241122-189881/edk2/SBSA_FLASH1.fd.xz'),
>> -        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
>> +    ASSET_FLASH1 = Asset('https://share.linaro.org/downloadFile?id=Dj1HRXnDnKtU6Nj',
>> +                         'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
> 
> Is there really no way to have a human readable filename here? I know what
> edk2/SBSA_FLASH1.fd.xz is; I have no idea what
> f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc is
> going to be.

https://share.linaro.org/downloadFile?id=kyoMLGC9zXa4oA7&filename=edk2/SBSA_FLASH1.fd.xz 
works for me.

> 
> If we can't have useful filenames, can we have comments saying what
> the filenames
> would be if we could have them?
> 
> thanks
> -- PMM


