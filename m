Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C604FC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0QNB-0001gj-4F; Thu, 03 Apr 2025 15:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0QNA-0001gb-0S
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:37:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0QN7-0005HC-9a
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:37:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so13827045e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743709023; x=1744313823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iw7o1l6EX8Y24QagulapS9anktq+wi+PgML/ekb7Y0Y=;
 b=cdOwRhmxi8eSKMN9wR5EYPYH42T21s3TapANUjlSbnY3vIZm66rtLkuosKwzCkws9G
 1r8x3lc9spjVlPUcfCZu1KDEPEh8kS45tgsOp7w9ASKmQIiavPDIR6j4IRXaa2Sz3Ib1
 L9BVO4zzjk3MAWQH1tuyU2uaWQFEaiGdio+Hl7+Bdn8OOKrO2wCl8zspRdBn+YhA78RT
 r0rL6d1hWcwAnNgqSTrIDUzqvkatG3kx2h5oyVz5q4MN2XTOVQbrImDNNJ/Yxu5U14GH
 hboStU9cojjOBy9B0HWpvPIEnd6OwIrGjPDbq3lduiFyWIx2GSgn8AwCykc5M6BRmFkN
 zXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743709023; x=1744313823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iw7o1l6EX8Y24QagulapS9anktq+wi+PgML/ekb7Y0Y=;
 b=ZYx5bx9ayRhVZI2780tY/2xGrrOqXozkAl6A1ciBkfXBszWG/G0nsdIZ1ofszNlB/9
 maPDTLwYTCXqf8DfSR7hR177nzMchl6YwwxyP99khSEZGMdGwLzIqHwEjy+V39I3PQHq
 n1aEtP38Ye67jF7y4R1FYF3cnVWGoilj4r4D0c7XYSCNrCXYIUCiC1OkSTuUi/NHaw7K
 5JLlcshaUWKRRxylZogHTfyNfwyk9OpxsPptvkemNhQGFHurzA9ZQ/4psvhJ4rPq03iT
 72aTBMHiD4Z6KNrsDi7Ye6aE1USlZTz3fYrsnRefgkXZUtv31qmhGrO7aYZ9ePKw8emn
 t8Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFxdGJuTXA/VQ3PYkryj6+gU3j+Y98Ynre4IWohI98FImCbRRZMWoOqO2kMeE93Xyj1KzRsHbVFgzP@nongnu.org
X-Gm-Message-State: AOJu0YxmAMB8n88Wns/vEMWEzC4DaULDsw8aIOHipcv/U8/hRzddbU3q
 Cen7dgJ99EKYSL7ed+8Xh1ppk0kO/wnDSeEDGR7AJJ8ecd5Xd13bJjrdCAzoDm4=
X-Gm-Gg: ASbGncsmO6Gw2ZCiiS2b0konQEETYb5PBQN3x77dL23fQViPq7RzEukL7zvIEODcWk7
 GyIRmMUKd+KcunJzGBDVzoNquE+pDeQRKOTdPzbo6L0MFMaPHOhCAhTDq1lAY0dN6t/csUYYFTQ
 0sUm+RU0u/3Z/g8eyKTgVVF4x1r1zNhJRqOfSKFbp3DRZsZjDST5sHSjw3Wie7K4L/AyQWliAqL
 vzcml7DHWqXR7dqCNKBMtxFnNTU+OVERCrJZcJd4dS60fYYXLRugVpLayjQdA+Cwryf2hT96oQa
 BjGo3KBJzKnc7lc18n/X2gDuwp8aWSsleGPUbAxSlMIIbeL8I1e9tyx39FXzqxSh/2EQAQj9Mrq
 ZWE6zY/FuultFmIKHVg==
X-Google-Smtp-Source: AGHT+IFfuM3eDe7OpAupR3FR5md1d6yfeJ/I1NVNIkLo7x/RVNBSa3bV3qeD/tNjk2FalTAAnu0wkQ==
X-Received: by 2002:a7b:c84e:0:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-43ebefb7c20mr45533205e9.13.1743709023086; 
 Thu, 03 Apr 2025 12:37:03 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7064sm2637128f8f.34.2025.04.03.12.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 12:37:02 -0700 (PDT)
Message-ID: <aabb0497-016a-4cdf-9098-dbbaa92b781d@linaro.org>
Date: Thu, 3 Apr 2025 21:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org,
 Valentin David <valentin.david@canonical.com>
Cc: thuth@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
 <CAO8sHckT2Ko8TTJjzUsX0znafaL_4jp97QCtSxoZDnHow0bEAQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAO8sHckT2Ko8TTJjzUsX0znafaL_4jp97QCtSxoZDnHow0bEAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Daan,

On 3/4/25 21:29, Daan De Meyer wrote:
> Hi,
> 
> Unless I'm missing something, I don't think the patch has been merged
> yet. Any chance it might have been missed?

I have it tagged, as sensible enough, in case nobody else takes it.
IIRC it was sent the same day I posted my latest pull request, so
it'd go in the next one, due before next Tuesday. Also I was hoping I
could get feedback from Valentin.

> 
> Cheers,
> 
> Daan
> 
> On Sun, 23 Mar 2025 at 22:36, Daan De Meyer <daan.j.demeyer@gmail.com> wrote:
>>
>> We have to make sure the array of bytes read from the path= file
>> is null-terminated, otherwise we run into a buffer overrun later on.
>>
>> Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
>>
>> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> ---
>>   hw/smbios/smbios.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index 02a09eb9cd..ad4cd6721e 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
>>               g_byte_array_append(data, (guint8 *)buf, ret);
>>           }
>>
>> +        buf[0] = '\0';
>> +        g_byte_array_append(data, (guint8 *)buf, 1);
>> +
>>           qemu_close(fd);
>>
>>           *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
>> --
>> 2.49.0
>>
> 


