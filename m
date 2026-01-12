Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D483DC9EC6B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFtE-0005gO-5Y; Mon, 12 Jan 2026 06:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfFtB-0005f4-QP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfFtA-00087p-27
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768216510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cpsls3/aWNrmHtV3kEL17p2tzSu97JLiy3SXzlxXjfQ=;
 b=QoZpa19mcMEFZLHh7DCt45OmB175CQunf6+UIB/sw59gyRrJfnZHFfCkAXQo6UNr1bLqzC
 79wjxkad/CrCmrB+pmpTLETNXERqXVPEEbIBOKAOk6kGT/6gxrQVdqz5epr9fgkxUBPSko
 nKuO96WBGxA2UQdYwlQ0vI9dGfNBF4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Z2U2uvWkN6OypYw8jzcWmw-1; Mon, 12 Jan 2026 06:15:09 -0500
X-MC-Unique: Z2U2uvWkN6OypYw8jzcWmw-1
X-Mimecast-MFC-AGG-ID: Z2U2uvWkN6OypYw8jzcWmw_1768216508
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so3582963f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 03:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768216508; x=1768821308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cpsls3/aWNrmHtV3kEL17p2tzSu97JLiy3SXzlxXjfQ=;
 b=oHl9MUWFDrtoLP2vGVYUQHeGfHD/MoXm88npplrhBiTBuuLy/hVnx3o5DigTi6M3L8
 M1dwpbOzYw0Tn5Vm+PqTiiustSTkTlczbr7ZWbvsG/+X5rsdxpr2Gf3fbW+c6sWT56iJ
 Zcbmr1K6SsD8z8l9HwCA8/+0nhhu0l0EJ8ZBFOtxyrwtQx0zJVIbLLp692e2Wkcle0R8
 IlVMAZOJEs6DpNteTrvP7tC8kLtNon8S6+QkUA1DcayzX6xOTqIsSHVUtFvhm9du+Ssh
 iLg+LIEH/ZkkxiXyMCDG+MBiwEbHoKIzLcIEpgFH/6OxGIiMuS3xmTjQazdjUfl8jw5f
 iqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768216508; x=1768821308;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpsls3/aWNrmHtV3kEL17p2tzSu97JLiy3SXzlxXjfQ=;
 b=tJMyTwqBddKB0Ss4kdRzIwC+oLFeYZvjHq2/zgQBE2vQqGRwop0jKSk6O5f6aVrRVV
 Hfs7vph5kyhAHqtr8qbjVtSpW+1CeEYI1Xs2CXLfJConJ0pASmuUr60OxRYBPZlK1tid
 lHSWKDOmdUHWx6+4e51QipuXgZEztPjo1Ay5ZrokWrTcWs06IZuO8XdHoxDg6LguZrTD
 jS9pdvtYIes7YFFn328ouB1zWJPDg5q9PWi78sQgRiY7C41Tf0cSlT16uVhJ8lOcP3na
 44d2iXNGh46ba2fEiKR4wyqxDCmY/MPWxPK8p5ZyZxnm+zFw/5f/vRQNzjsFH1/668Xm
 laxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyLssxrnd+X24QHuntXsSLJJZZhlTz4utOFD5HUR9Owl4zWlwKW+83LbiLwgxR4J0Tu3OQbnxZyo4h@nongnu.org
X-Gm-Message-State: AOJu0YxuJ4Iol73JyyXVnSa63aMT9VcrU3Fme+ahoAxar4zm3UZhGUQh
 wZdTP90JsC3MquHrVKmlt2YQRmaNo7+GLeVD2GB8hR1q0VKIvNFc8DXB3hy9jVfm8c4QL+pljnD
 6tYgOjoho+8iRcjUhN5z4uyUwmfAB76YSLa1qbs67OZQriAA/g94Xs03q
X-Gm-Gg: AY/fxX7Mc6oIyrs0VeeOHsQyOGt7sA9EWRIqZ2lv9LB5K/bX7VxX/W6og+aiOrj0umX
 Ta4YPBJN0FCKU18qkaDibEaOK8hNdQuvsOtLmSITPhJboIk3+r5DBj2FRKWfezt29Vij/0++M06
 WuymJwfRebQZ9Fy+z7EQS6llta5ZPUKYsy8ozTsSUpQIPOrWJMWmtfnUyVOhWoMxlbZm1E3oVax
 1uk9K0nKByijj8Q55Ut8XaN35hG/Co+/YZbvMQsSNcOA9Ph9Lyjj3u2RKaYH0sIaf9a5bcRfrx7
 CK7v2tavRvkF2u4/7n03pE7IlHAGNfhFNyfRYncCvNiaKTEvtDNX4x6ceitALbgHfBCK2Ejb0In
 jnEWHm/c=
X-Received: by 2002:a5d:5f47:0:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-432c379d1c0mr22436983f8f.38.1768216507877; 
 Mon, 12 Jan 2026 03:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsK0E0lUo2BrzF+kYtawSibi+nPnLGWROWMqlFIs7FUdx0ux5HK0hp6k8gcC+PwXfaCF8nzQ==
X-Received: by 2002:a5d:5f47:0:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-432c379d1c0mr22436944f8f.38.1768216507409; 
 Mon, 12 Jan 2026 03:15:07 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee243sm38180200f8f.31.2026.01.12.03.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 03:15:06 -0800 (PST)
Message-ID: <1a857ac7-ca7b-4c70-9f17-83b304feadb0@redhat.com>
Date: Mon, 12 Jan 2026 12:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target/s390x: Fix infinite loop during replay
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
References: <20251201215514.1751994-1-iii@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251201215514.1751994-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 01/12/2025 22.49, Ilya Leoshkevich wrote:
> Hi,
> 
> Here is my attempt to fix [1] based on the discussion in [2].
> 
> I'm sending this as an RFC, because I have definitely misunderstood a
> thing or two about record-replay, missed some timer bookkeeping
> intricacies, and haven't split arch-dependent and independent parts
> into different patches.
> 
> This survives "make check" and "make check-tcg" with the test from [2],
> both with and without extra load in background.
> 
> Please let me know what you think about the approach.
...
> diff --git a/stubs/async-run-on-cpu.c b/stubs/async-run-on-cpu.c
> new file mode 100644
> index 00000000000..adf1867ad21
> --- /dev/null
> +++ b/stubs/async-run-on-cpu.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +
> +void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
> +{
> +    abort();
> +}
> diff --git a/stubs/cpus-queue.c b/stubs/cpus-queue.c
> new file mode 100644
> index 00000000000..fd678f42969
> --- /dev/null
> +++ b/stubs/cpus-queue.c
> @@ -0,0 +1,4 @@
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +
> +CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);

FYI, I'll add a "SPDX-License-Identifier: GPL-2.0-or-later" to the new stubs 
files to avoid an error with checkpatch.pl here. Please let me know if you'd 
rather use another license identifier instead.

  Thomas


