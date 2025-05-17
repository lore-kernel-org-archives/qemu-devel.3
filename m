Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 05:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGAIJ-0003Cc-3b; Sat, 17 May 2025 01:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uGAIG-0003Bo-Pd
 for qemu-devel@nongnu.org; Sat, 17 May 2025 01:41:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uGAIC-0000Yb-Sq
 for qemu-devel@nongnu.org; Sat, 17 May 2025 01:41:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2458859b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 22:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747460463; x=1748065263;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eysdsAY5PenKd4k9S+cdY1iHGg7gIuIh8qHHWfQQn0Y=;
 b=H+Hx87WksHVSK6nmFq7SHoNpQSVEZJ6i/PltxYcesTmRIaAmnYy7s/Du1rGX2HzOcX
 kfWC3oEKo4S7j2EU624nsqi6LeyJ1uBkvDE9WUkvz370OGF6diVadLFtRauAimcaDm4+
 T98sQc8fR3nT1ZKfBKliOehOjxaxK0OhyWMV96UAu3T9WN9jgTYOZ9RSvG0jK88ZrL5q
 sHB0oJAgeGTpF71EalNfe+mF/Og9dXMZBE91kDOkHm/7K0YfBWOqOTZfIzeVox4NBqrZ
 5IZpsvvaW7d0sneYn8+qF33ggvpW/MubfIEHsYATkOykThcQsleEPV7JhMpaSXpt33Je
 c7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747460463; x=1748065263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eysdsAY5PenKd4k9S+cdY1iHGg7gIuIh8qHHWfQQn0Y=;
 b=N7CdcXqcNPnEp+XhF/zT9Tnr+Eh9t3ZVqv9zfKe7BMrWwcDNV9Di9KqP4cD3GhlMVB
 KEXN2DfqUrDbfdV6rcWMlZZCrQa1mrjQYCubgf7+KPLpFquKpekjOrKwjHaJaFe0wl4d
 vLsH4aWlmCDWuelyR012Psyn8CV8vWphAFwVCK3QNgEFSbdpumKJrfuzmhgL5lwAWJh1
 ReJmLR5WDDs9sc09MSZ5C9ALvTU2pXb0hG7ThTGClzqYQ/xJiwXj2V0fMGc23IpcjuFS
 roDAlFEZalpKejyvTJHbCAH3HrjCcwNnTYKMLwaTJJzPRJp5FLH0DpuGWpHOxYMmPmJc
 H1sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2lAQJRPJ2CMj286cWb16moXzMC/T4XIpE34udPBfvLrJcLoMLVgR7jNS4Nv5l0xA31Lyl4TuFhyyQ@nongnu.org
X-Gm-Message-State: AOJu0YxZjZIfdRNMyhDVmcos48/Oy7B6AU/pAgXm+8qDmXO66kpm+uzO
 h3gggHvCoPAepX+mdRRha241iezxa9hyPIgGP0YGtQIcIgG5CBFZ8hnXaRNtUqXsofU=
X-Gm-Gg: ASbGncvr1os8Z9EY89zM2l/nn5tFY3z7UT9dDwoq2ujF8fbtd/wuVP5yITb2wAzGKHD
 fKj+73N0ZdyGmEncmX4+tLBNWSgBY6p7ktHX4JpV4Y1ZTF9GgWvDOq0s3xx+74l25hd6FqvYBgB
 Yzefe5wgeLwbL5oXDmE2Ja3Pri/ll2Y4kSMxbWdxL8rpRAr8wZ8tas9VA7EWq0f+NWKWSeFtSCF
 NLugIrJemQRmywUkrMjOXBddLUiLjvqH8dBQmuhVztt+L9wS3qnn0MK5RYqHXWbGxnsa1pXrBko
 cVOQAcEeqxmobLvMUQR7P0DyEdajEQ8OVlrQNvL0K3+EO0k0N1kRwExnUQ2zKA==
X-Google-Smtp-Source: AGHT+IEWKusQXbaFknOGcfHtm0iFangE42Py7iOV2PYfFVobwaAF60cSupu7KNxmFqmyZKxwZ4C3KA==
X-Received: by 2002:a05:6a00:3d4d:b0:742:3fb4:f992 with SMTP id
 d2e1a72fcca58-742a97c3f4dmr7793078b3a.10.1747460462746; 
 Fri, 16 May 2025 22:41:02 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970d64fsm2519410b3a.64.2025.05.16.22.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 22:41:02 -0700 (PDT)
Message-ID: <036ed37f-9403-40f3-9c07-4555d666894c@daynix.com>
Date: Sat, 17 May 2025 14:40:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel <qemu-devel@nongnu.org>,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
 <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
 <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
 <12b1dba8-ecb5-4167-841f-0a32256285d5@daynix.com>
 <CABgObfaT6XJTkkQMfQt4bMhXGu7EvTqAv-qf+qStU9cezBwBgQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfaT6XJTkkQMfQt4bMhXGu7EvTqAv-qf+qStU9cezBwBgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/16 23:25, 'Paolo Bonzini' via devel wrote:
> 
> 
> Il ven 16 mag 2025, 08:58 Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> ha scritto:
> 
>     I also found smp_mb__after_rmw() before qemu_futex_wake_all() is no
>     longer necessary. Summing up, I think the code should look like as
>     follows:
> 
>     #ifdef HAVE_FUTEX
> 
> 
> You would still need smp_mb__before_rmw() here.

docs/devel/atomics.rst says:
 > however, according to the C11 memory model that QEMU uses, this order
 > does not propagate to other memory accesses on either side of the
 > read-modify-write operation.  As far as those are concerned, the
 > operation consist of just a load-acquire followed by a store-release.
 > Stores that precede the RMW operation, and loads that follow it, can
 > still be reordered and will happen *in the middle* of the
 > read-modify-write operation!

I think we only need a store-release, which is ensured even by the C11 
read-modify-write operation; we only need to ensure that ev->value is 
set to EV_SET after all stores specified earlier appear.

> 
>           if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
> 
> 
> Removing the qatomic_read() works, but it's more expensive in the case 
> that the event is already set.

Removing the qatomic_read() (while keeping smp_mb()) is more expensive 
in that case indeed, but I'm not so sure if the case is common enough 
that it depreciates the overhead added in the other cases.

I don't know whether the qatomic_read() has improved the performance or 
not, but perhaps it is still a premature optimization.

 > > The barrier before qemu_futex_wake_all(ev) could be unnecessary 
because
> there is probably one in FUTEX_WAKE. But not being able to audit Windows 
> makes me a bit uneasy about it.

With "[PATCH v3 01/10] futex: Check value after qemu_futex_wait()", 
qemu_event_wait() always calls qatomic_load_acquire(&ev->value) or 
qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) before returning, so a 
store-release of ev->value is sufficient to ensure ordering and we don't 
need to rely on qemu_futex_wait() for that.

Regards,
Akihiko Odaki

