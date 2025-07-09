Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3644EC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSq3-0006Mx-RR; Wed, 09 Jul 2025 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSnJ-0004M5-Vr
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:17:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSnI-0002Kf-Am
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:16:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453749af004so27293945e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752059814; x=1752664614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ogiCXSiyJ9hseHDDZ62+Sib8BcSkm5yrkMIaGTrJtyA=;
 b=LzlXAnzXD7q2rN2xILvX9fhDzo7SeSD14oeWW0lZUkh9UulPXqDITIaZNFrZDG8iNr
 29mnsaCxycS2HJHeEaRw4+RbAwKRnZ0txL20DW1dr/Ra8aeVe9PUs306wiclNVWH3ADT
 YUdhThJD73ZOPs6lRlEdWRz7LIgcHjCpQPZsn1Dbq5wMypEJHkVxJrl8QLYUdTrGGPMF
 YTCUVgf0g6kOeH0CaLGDC80v3ytXmCBYOI4fcnhn6w4SPG0jct26SGYR4ZR2m3x43ZJT
 mr6uf3uX1Dc4cMJb16+XcTAJwae3ZBAAaD4DJhE9V/M3YFpOse0Nz1zXYqefTegV/wJk
 AyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752059814; x=1752664614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ogiCXSiyJ9hseHDDZ62+Sib8BcSkm5yrkMIaGTrJtyA=;
 b=fxlbNcFkQXyUYjpuvFWOoFhlmTD3zF4GMcHg//9enH878AZiLcB/Sj3ZTIKgvQ98St
 GlduOBHqX4xLOKzqHNb7KSB/89GBFCqfYs953wpDhGvskE0eQ9h7+zdAdld3X91BL+bg
 s/qBwRVd/QhZLXbNvP7cKoyB/Da6ZSjq0odVhjMBQcs+/NHaio2cO7584Je1kCy+AsNW
 UP/dZ10EoqHtytTREmk3/t/qlQD3UYNl+djmim+GPatQZ5UQYVtT6QaPCq3O6xLwRqR8
 pBM/WQzBV3CCBGN8FJkNFYJ6C4xjAdM/vS8/ziXBnBcgwrButT6o8XJAJy/c6LN08Kdj
 uu+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnsm/k9XSJ3HR4/mJXPlX54T6xYYgaMi2BSEDV8bNuhmvO/PqG8+buQc+1ap+e35PiFjVSEfom3+kx@nongnu.org
X-Gm-Message-State: AOJu0YytBIZtSjvd4ketEHNd5JNZNlifK64xq3Q3UfHtkYn8app10BfI
 BApdoFgUFB2kRoK/IJW8FV156Av2YfU6V+LbNQUHRNYJ7BFe3yzj2nQIl8aQUia6IoZ+Lb9dzD1
 HeuLV
X-Gm-Gg: ASbGncsPwYEzG7BsB9a4mr+RaA8MBPvD32+XPefMWSMAlkML0boAU02TaYtiCfeUFS2
 fo1YEqGMop5NTRqvsRv6DEei5V5AOEx8hHXqhE02Izfd7tbtflUTFt4tXhM4N8ZaBZXg9N7H5W+
 nA78wawEGMLVbn2ibipwRQvmnyeKosDtyXifNuSEVcy/WzvCKC34x/nnCtzY2XxvplFlUnm0tv+
 E6IYzQsg1o7bgSrNE3DlKo0XUWjBJydBskw6+4jdk6owgcS4mMToEC06SDnBJEs3i7KR2Maff8S
 365BANZdtsnV/0MiTGvHRDshAsZQ29OfCr1pZKZ20B+vw/dtggx5DfFd9/fmgc/o2Ch1yQE3U+L
 b2eHFJOiNdOqR1mt5xNwo2B/iNa0IRkJbC57JWI0t
X-Google-Smtp-Source: AGHT+IEbe1gfE39v8w11N2YnIvUlf5FcIsdCqP1o2SVgxpZcGXkH9v4eDgi+GHQ2gpuVO58BXDuqDQ==
X-Received: by 2002:a05:600c:620b:b0:453:9b7:c214 with SMTP id
 5b1f17b1804b1-454d53f20a9mr17897765e9.29.1752059813846; 
 Wed, 09 Jul 2025 04:16:53 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032e9esm19778795e9.3.2025.07.09.04.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:16:53 -0700 (PDT)
Message-ID: <a515b6ad-b10d-4a78-9960-f75f3189adaf@linaro.org>
Date: Wed, 9 Jul 2025 13:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] esp.c: only allow ESP commands permitted in the
 current mode
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <30d03eef-c0d8-4864-87d9-a3674d8f64a1@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <30d03eef-c0d8-4864-87d9-a3674d8f64a1@ilande.co.uk>
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

Hi Mark,

On 9/7/25 09:50, Mark Cave-Ayland wrote:
> On 18/06/2025 07:12, Mark Cave-Ayland wrote:
> 
>> This series contains a few minor tidy-ups along with an implementation 
>> of the
>> logic to only allow ESP commands permitted in the current mode. The 
>> motivation
>> is to fix GitLab issue #2464 which causes Windows NT MIPS to 
>> bluescreen on
>> boot.
>>
>> Patches 1 to 5 are simple tidy-ups from investigating the issue. Patch 
>> 6 adds
>> a new asc_mode variable to indicate the current ESP mode, whilst patch 
>> 7 implements
>> the feature which fixes GitLab issue #2464.
>>
>> Note: this series is being reposted as both the SeaBIOS and SeaBIOS 
>> hppa binaries
>> currently distributed with QEMU have now been fixed so that they do 
>> not use an
>> illegal ESP command sequence.


>> Mark Cave-Ayland (7):

>>    esp.c: add asc_mode property to indicate the current ESP mode
>>    esp.c: only allow ESP commands permitted in the current asc_mode
>>
>>   hw/scsi/esp.c         | 94 +++++++++++++++++++++++++++++++++++++------
>>   hw/scsi/trace-events  |  1 +
>>   include/hw/scsi/esp.h | 15 ++++++-
>>   3 files changed, 96 insertions(+), 14 deletions(-)
> 
> Ping?

I reviewed 1-5 but don't have sufficient knowledge for 6-7 so
will defer these to Paolo.

Regards,

Phil.

