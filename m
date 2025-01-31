Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BB4C02190
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 05:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdjIb-0005fJ-Bw; Fri, 31 Jan 2025 00:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tdjIa-0005fA-KV
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 00:10:36 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tdjIY-0003ID-BU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 00:10:36 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2161eb95317so27133995ad.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 21:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738300233; x=1738905033;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5AEuIBL2MpqAbCSETjlQmOC2W7ELmv7LgDjDwZVJiAM=;
 b=U5YBQp1mdWw9NPdDNYNSjWmixD16GcowpDgcQLkSlI20xC78aBNj3T117fzOHI8IW2
 cn52MPANJanzJKu8M3EEfh/GnNduwFt20JcMdPQwn7rKoGVMaSpnFJf8YiiKL7NOacPX
 ozB0iTqYm4W3IcSDXnGK00tT6FhXkKr161idOJ/s43GQU/8XAeQDJiJeW7yQD/Z/XyDx
 M6VCvIiuaN6eD8tSbcpKlwX8M+4TKi9T5iBHllYL7s71D8FG3RIEvlQkDZCRbhIYkxjW
 XayyLfnat9QKOt9MNg5rOMN+V2WIEdqU1Ya+K5ekbvL4dUc0hvXqgNWNT6NlcFgAmD/e
 uhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738300233; x=1738905033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5AEuIBL2MpqAbCSETjlQmOC2W7ELmv7LgDjDwZVJiAM=;
 b=PsAGnk5gEqxxJEyPUmcPCUT8Z1eWm+1ibGPll/gPollpbeBdbjkZYBcG59SyxW17fR
 TdNvEjWnn+rc6VipXvcyGgs95oFKIDojauEGEJ5h9qkiY19DNtrPNnHjOGFUryBljOsp
 HLjUlzuFs8zXnn+LNV2bIpUojL9n8X02yNWGNj6WFIiFf5/Zg9qcnlu6hU1jtTYOphaw
 d9ydZhxCzgkMK29r9v7oipR/CHuHu4kDYBlJFKQxL2Fpn4C9FojfEF1Y/gpzb4U4Zedg
 bpnkSV27ZfPBwNUET7FCCZDpKzdzWP23rVgPLkT8h0d/gui6el8tG3cT2aODjf2KhrR9
 1n9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgnpfdPrNW+PsGm+ZhXxGAcmFVDNX4PJpwoLO9ITqkJwe8fI1weH3pcVS11e8eceIe+oobtFOUk7N5@nongnu.org
X-Gm-Message-State: AOJu0YxlDXi5NxSIohu06D5WVLbMRBO3sVJYYYuO6t3ERN4YnWYXrWmd
 ku9VnC8EzxATWvYl78YZDDQtlyW+cSd+/EYWHDbcbCnwImLVsQ4KErs7wAIk9B4=
X-Gm-Gg: ASbGncub/8iomRjhjtfREHN1cMmhq4DJ0mxlJL7h5UwLKbegklVBy9IqUXxGrXzglSG
 Z8N/FEtdU5Va73CzRvPQvTZb4unSU3RDtuO9l9Lh+2Zh/2vaJXB4MBSq4O0CocRRE1KE4Y5Po+G
 c8xawSV+a5Q8SzJHqT3zOE0SsZ+roRmU+5E3gPot/iph3exsVE37ocRIGkBI7uZKpoFDP94q//Y
 vCUwhPXRtuhTxOjnl5c0GBo4oNlDOYyqUcGPmQYs9Y17NZMznaT0c/ZX4K5b/6azsnTn5Z/tD+N
 QZm7lp8qXRT95f7zBY9KF2aTHbyf
X-Google-Smtp-Source: AGHT+IEERU4Y46yPMbU8raM379YD/b5udqcqVEsnknx9lXHDT/ie/0QIeIU/54YQkQtrxoQmIg9iVw==
X-Received: by 2002:a05:6a21:458a:b0:1e6:8f10:8ba2 with SMTP id
 adf61e73a8af0-1ed7a462f12mr15978249637.9.1738300232735; 
 Thu, 30 Jan 2025 21:10:32 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6a1ab2fsm2394763b3a.170.2025.01.30.21.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 21:10:32 -0800 (PST)
Message-ID: <bc74db8a-2970-47ab-b0ba-ede783299abc@daynix.com>
Date: Fri, 31 Jan 2025 14:10:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tests/qtest: Make qtest_has_accel() generic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 xen-devel@lists.xenproject.org, Laurent Vivier <lvivier@redhat.com>
References: <20250130103728.536-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250130103728.536-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2025/01/30 19:37, Philippe Mathieu-Daudé wrote:
> (Series fully reviewed)
> 
> Since v1:
> - Use g_strconcat (Akihiko)
> 
> In preparation of running QTests using HVF on Darwin,
> make qtest_has_accel() generic.
> 
> Note, this also allow running other accelerators such
> Xen, WHPX, ...
> 
> Philippe Mathieu-Daudé (2):
>    tests/qtest: Extract qtest_qom_has_concrete_type() helper
>    tests/qtest: Make qtest_has_accel() generic
> 
>   tests/qtest/libqtest.c | 110 +++++++++++++++++++++++------------------
>   1 file changed, 61 insertions(+), 49 deletions(-)
> 

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

