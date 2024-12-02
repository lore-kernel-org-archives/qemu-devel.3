Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718D2D78336
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9Iz-000598-Jf; Mon, 02 Dec 2024 11:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9Iy-00058v-AP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:29:48 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tI9Iw-0000ZP-FG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:29:48 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-724f1ce1732so3468299b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733156985; x=1733761785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G0R53tJrtO+F8+fmPzdGSBrJnFqCG5JHD0mMmNusqq0=;
 b=jWOiIbjrpk4RDQlB8OxQjle6BfFFI0gWD3gzC972Xq39tD6Lf2NngMnvrK2RS5kJcM
 RPL+PxrrxxYcmaKmFUlkKFHOjtflgc8gUiY+h+bQwTT0PKaJsDVwnPIduYJMmG8/t/pL
 FpYQfSsG+ubHQtPcJjTJMRtAO1rBcUwuAEA2qFSHBX646GS39Mg9C1iUQfubgJKFnVPf
 UIAJQy4UypJdVFBwCbKb+iMAGfzRKzBHldTKpEAUap37O+ZYRlINOp8VeRYLNEsCmU3D
 Xs9DFGpL8BwOXqeQJWcHsYbA3fcdnc3jZgW9mN4fzogBbuNTprSydJoZnDwXJbNKYwfG
 Ypfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733156985; x=1733761785;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0R53tJrtO+F8+fmPzdGSBrJnFqCG5JHD0mMmNusqq0=;
 b=B16vPvT8lKaeWVFfNTlSieGaUIGLrVU/1g8CWfM9Rnx2bbS7NupuKHKossNzkzTeqK
 SIiMTZMY46qbWMnTstVykFRC2DDp/oxRufXA+Ft5EtfS4XUYG24C05ss4mqeVHFDhtrI
 suWZKo1xtM5td57RUtpnkU0WRkCUrkdjDFq6KC+sw4KUZJ5MBefa39DQdQFGaTFpdyXG
 ezP3tiQuizbH96Js19E9OY75SgLh2sMrbkNSiwGVg1em6Gd7L9v9uWX0rRhO+fNpUQ2q
 qPuHouGcFG74iyYGRt9RwjHFpZzbzlIEJdcyPAH4xtJOYzmBfQEdfCJ2/8QEBgwnqlzv
 yM6Q==
X-Gm-Message-State: AOJu0Yy49AR2N7dSnrGasEuF3iK15VcH0lpFNK7SCg9kd9hqCWmGuPrl
 lAWuqomibKIyonxINx22v9w3lY9v1I0ErGbtcvspQz3kxP1w91SJoMm67YGUaQ==
X-Gm-Gg: ASbGnctus38UOk9lW9EVDsobKluRXwL6gPP28JGhF6lns8yEGjakOTcb491bqltmUqe
 mtLsBxUg+ZRe6WkIRDb7BMO7pbRRN7DcF67LmTM1GEkZuZpAV5RBqDTnIo1rviJvE3ZCjunT/0W
 NytR3fYMoz4OzvbCfvYr8fjB71K/B5Sk9tQHVlxDAt7XllfidC//54QGYsgnLeoXzr0inMxRook
 FM7yw46zP5EV+kq7J2v1SvzA6QxvbLJ7GprcYYRIAkn5hzq750jNNE=
X-Google-Smtp-Source: AGHT+IHBFp8hQ2QzJwXiqANG4VQVkksX4FYvZNiDBdZ0iu+wuNRGK2apd/6uB1BeOab/GWh6eFKODw==
X-Received: by 2002:a05:6a00:1956:b0:71e:4930:162c with SMTP id
 d2e1a72fcca58-7252ffd6fb0mr31353868b3a.6.1733156984494; 
 Mon, 02 Dec 2024 08:29:44 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725418149absm8960373b3a.146.2024.12.02.08.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 08:29:44 -0800 (PST)
Message-ID: <e0b11458-7cd7-4530-8697-e81a7d7a9143@gmail.com>
Date: Tue, 3 Dec 2024 00:29:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tomita Moeko <tomitamoeko@gmail.com>
Subject: Re: [PATCH 1/8] vfio/igd: fix GTT stolen memory size calculation for
 gen 7
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-2-tomitamoeko@gmail.com>
 <20241201221129.03ea9577.alex.williamson@redhat.com>
 <20241201231220.02358a6b.alex.williamson@redhat.com>
Content-Language: en-US
In-Reply-To: <20241201231220.02358a6b.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 12/2/24 14:12, Alex Williamson wrote:
> On Sun, 1 Dec 2024 22:11:29 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Mon,  2 Dec 2024 00:09:31 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> Both intel documentation [1][2] and i915 driver shows GGMS represents
>>> GTT stolen memory size in multiple of 1MB, not 2MB starting from gen 8.
>>>
>>> [1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3rd-gen-core-desktop-vol-2-datasheet.pdf
>>> [2] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
>>>
>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>> ---
>>>  hw/vfio/igd.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>> index 4047f4f071..e40e601026 100644
>>> --- a/hw/vfio/igd.c
>>> +++ b/hw/vfio/igd.c
>>> @@ -268,7 +268,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>>>  
>>>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>>>      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>>> -    if (gen > 6) {
>>> +    if (gen > 7) {
>>>          ggms = 1 << ggms;
>>>      }
>>>  
>>> @@ -678,7 +678,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>>  
>>>      /* Determine the size of stolen memory needed for GTT */
>>>      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
>>> -    if (gen > 6) {
>>> +    if (gen > 7) {
>>>          ggms_mb = 1 << ggms_mb;
>>>      }
>>>    
>>
>> I'd argue this should be rolled into patch 4.  It's not really fixing
>> anything because igd_gen() can't return anything between 6 and 8.  This
>> only allows for several device versions that we currently consider to
>> be gen 6 to align with i915 kernel driver generation by calling them
>> generation 7.  We'd previously lumped them into generation 6 because
>> there's no functional difference we care about here between 6 & 7.
>>
>> In the next patch you replace this '1 << ggms_mb' with '*= 2', which
>> would be equivalent to 'ggms_mb << 1' and matches your description that
>> the increment is doubled.  Is there a separate bug fix that needs to be
>> pulled out here?

Sorry this was a mistake when I composing my patches. At this time,
there was no gen 7, original condition won't cause any issue. It is
more suitable to be included in patch 4. I will drop this one in v2.

>> Also, please send a cover letter for any series longer than a single
>> patch and please configure your tools to thread the series.  Thanks,
> 
> Disregard this latter comment, I just wasn't copied on the cover letter
> and didn't have it in my inbox to root the thread.  Thanks,
> 
> Alex

CC of cover letter is not generated by get_mainainer.pl hook. Sorry for
not checking it before sending, I will manually set correct CC in v2.


