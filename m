Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9D8CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGK5N-000407-Ev; Tue, 04 Nov 2025 11:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGK5M-0003zy-18
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGK5K-0000sm-9m
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762274441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QUsmwg4nRQ8td1cMNj+lgIl9gQwLQZbyyN7kKdJr8mQ=;
 b=AmUbB6ICwJtEiTl0nvd421q+yQ/CS+sZi5eA6j+cWXzULVMTbuX5+8v1bc9AqV5ZpiywV3
 zJ7ad0sKEo8MwrPf3WaScIqEP9Z/8ySPBkVOL+wmpTHyWMc0p6Y19Al3d9QZ/WAXf30QEb
 /LgeBfXj6CFHUCt3FcGwIR30X8rhCss=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-FiPdK004NziL6LQ10I0s0w-1; Tue, 04 Nov 2025 11:40:40 -0500
X-MC-Unique: FiPdK004NziL6LQ10I0s0w-1
X-Mimecast-MFC-AGG-ID: FiPdK004NziL6LQ10I0s0w_1762274439
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c19b5e61so4054836f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762274439; x=1762879239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QUsmwg4nRQ8td1cMNj+lgIl9gQwLQZbyyN7kKdJr8mQ=;
 b=VP8y/YwlaNw+AqtKFgaK2Zc9/dzNSlkwTvJL3YwpMtRUZ2tUVaXrTxu9eMmuSDe0A5
 eIvvZ3qTSt1zxYqws1BmeU5Ti6XHdwodqa3TvO6i+ph5Ya2tHVPqC1C6iiTssbT0CkzZ
 SCjUXsxi9YPg8pHmjvGUlIkEaKItsuG3fpNwZISC86HviuvYhiS19h0PU++Ic76OcMq4
 yYasG2LrdKmNozy1xBfrVKwicr8mSUQ/g9a0A3rOT0gby49Kn1ZDCsyStbDA3EkhjIvi
 aCtjaJcX6RhnNo3ZebG5PmU+RD0wvPtA+YAGrSWywtwXBDfh95HoYfNct3U++UdQlgHS
 OK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274439; x=1762879239;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QUsmwg4nRQ8td1cMNj+lgIl9gQwLQZbyyN7kKdJr8mQ=;
 b=KMmF3mgZVmxE2gDE5iG8JRAlOyjFXkzuNsebN3fsmMTSorvET9wihcTHtzBfLHJY++
 fzEoOBuyjW6bWanuW9qP24Kffl3W5lDCsacME9jlFvg7Lx6DS5wKoHgkyDjQKaf92qHc
 uqYR9ZIiAOiGezKBngz2OaKSnuL6K0TUbncwiR/YUEHBOa01fRq/hWQ8/4mAnF7dcB0L
 H1dHB25WtCWKs+C6+fKQabIKIb86Pf2T8BQMIyPpylooTwZifqUR/sQoOIY141XJMBze
 OK6HAkVNwYb8Rxi+VuVQIU+C3HR9MJuuGuyrr5Ly4UojGK9cvDye87e4rT5gVDjxySlO
 69rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzle8P9KV8f3yJ+Xu7OLeSg5ozWcZvxvK7JE170LfeHbHrQjfNC5t/bURL5h+aGvvsGCVzEu7QPIiH@nongnu.org
X-Gm-Message-State: AOJu0YwIqIbg/0w1B+/+EzDCuyYz9XGB946dw46eq+OvYgYI88uKaveg
 NZiAZimAG+Gj6m9Bbz8jBUf2hNaP62aScZelyJTZsteOSTnEwNusM68VGagI/Oam+7mVVoVz+Sz
 REkrkw0oHKwQ0SW94ra/576FSiQXETr3dF1Qf8QGL19j3yHAabhAJGxWg+novFUdX
X-Gm-Gg: ASbGncvl5X55GlGcHc3iRsqvC/X3PNqq1JpzYogyMxgR4PPhGphWZsyiQ2APgVyK3ng
 pzgFMCAt8x4xCgdJ+wPckBxbHS00ui36UJ89E+uwhk5B6I+4vr9ofDzlmwnTwdDHqY0YGWpXFjy
 Uz5nQXKCp9ZAlApTmIjt9OntEc3o6pF7B6IidCKzIK8veusz1YuHqgYX5bhOwKZi6dsjNChzei7
 Nxycr6hXxpZ6nOolYeQSaUy5nR0gKMSkBXQxcgd8TMHsVQSTRH2dVUM1LEv1B9FPBp0KFcnnxbH
 j0nhZidCsggD8rT3x5dB8wrjq/q8+CySmwlwQCxl/bJuCljIojqn1lSS3aCKUevXbJymvo630Iw
 2gjjT8d6hEIqtx94/no2YOmJ+akVzSP3002F7/Q==
X-Received: by 2002:a05:6000:4305:b0:429:cacf:1082 with SMTP id
 ffacd0b85a97d-429cacf1303mr9332949f8f.57.1762274438750; 
 Tue, 04 Nov 2025 08:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxFk0PcF+sxQZ4LqVfTHRmizcRYrCxqCAPSmaQV6wCtR5pbF8lwIwiWK1DCcH9niY9cWIPcw==
X-Received: by 2002:a05:6000:4305:b0:429:cacf:1082 with SMTP id
 ffacd0b85a97d-429cacf1303mr9332926f8f.57.1762274438342; 
 Tue, 04 Nov 2025 08:40:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f9c7esm5111902f8f.35.2025.11.04.08.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:40:37 -0800 (PST)
Message-ID: <d99cfc64-2211-4a7a-8539-f95ce833f3f7@redhat.com>
Date: Tue, 4 Nov 2025 17:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] vfio: Clean up includes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251104160943.751997-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/4/25 17:09, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git vfio hw/vfio hw/vfio-user
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/vfio-user/container.h | 1 -
>   hw/vfio-user/device.h    | 1 -
>   hw/vfio/pci-quirks.h     | 1 -
>   hw/vfio-user/container.c | 2 +-
>   hw/vfio-user/pci.c       | 2 +-
>   hw/vfio/ap.c             | 1 -
>   hw/vfio/container.c      | 2 +-
>   hw/vfio/cpr-legacy.c     | 2 +-
>   8 files changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



