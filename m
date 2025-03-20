Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C0C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvA2E-00087w-EY; Thu, 20 Mar 2025 03:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvA25-0007xJ-TO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:09:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvA24-0006Wj-7K
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:09:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so10131795e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742454574; x=1743059374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ZLyBlDMyQlgqDV6uPJNb9HIoPbEBla3hQLiDPbRusA=;
 b=bROpN1cfoNT8rnSYUcY7zVYPznFJtBTIrP4WLcaEF/1U5YF3OJ7PDVVEhb4GK3TsJh
 J67U4Mp3caZowQUuLbL3vn2RohmRP7eKhCVIeZ8g4QiczArgBNIrnOQkidEm4OxlGeuI
 oSlELXiEDC6uGwZnQBuzyyAaUUwjXhijr+DxXP27DGCSPVtwBpL9OaySd5QeqySH6ugA
 54WDkisvZ4NiHhTEpxfQUMwuFNX5OliyuA7uX0YKjtIEF1HHO7Qdh+5VFyxvIFwuS39m
 eKgF0yJWCMBSXGhC/PNLOrYUbMGUKSTZ9gEwjMgssf+E4N4KpzQpK758YYb3Gr6sojNW
 vxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742454574; x=1743059374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZLyBlDMyQlgqDV6uPJNb9HIoPbEBla3hQLiDPbRusA=;
 b=S5s+Yt1ZE83eu+P74ceTawe4u8dhWp8b4YT2lTO9S7IuW3FPW8OhT8Q5oGxfT0ztCl
 AjL5J1UtlH0BRvCpMB618C3IUBlP5p86N6of6ZLbH+abK6cTW2wBIabq8LZl2XYny6s/
 vVCE/vfXRcnBEg3xa47R6RwE+247PaxTlFMtahPQYfAxOOKmzcfR7EgB9uk5MRlplcCZ
 lC5GL6njuyLaWHjjoyH7Bz00Mr3gL59UGqloy1wRYNdapBaFNqV9bsEhkE70o2HwZtqE
 AixsZkIQqivQwdXspFbGb+gcNpoig5RV9ScknJ1Rk0mfUrm34PZXBG2HOzKjK7JXEiRa
 dE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHeNQnXUC7xuTFTa2spt3zUua0qOxbQ9msHH/HhQi8BWbdyXUc5KWmHWC3H0kPlqk7Z5sUtsggWqvG@nongnu.org
X-Gm-Message-State: AOJu0YzncOSS4YP642ru75tm7YGHpLt5b43/q1pb+b7cISzc8RLEFQAk
 envH0ecQsE+R1GhD4giyEZQ4BoVoanfE+sS7M89xVm0C1YoSJGQvlAUWg4Xlbsc=
X-Gm-Gg: ASbGncunE3LNd1KOs4WUv806qEwmJFh24tnIaSMKBNoASxgzL3A19ASzadBFW9mltE6
 SdUXNFvhVfVrzU6hOYhYlb8pc4tRw1s8sya5qCNp8qUDC0xe626rbw2Tgf98Zk7jd+bd+GazcZs
 0d91we7n2oyLoqmYAZHJ7jGdA67Y35g1UT7/RjAfwhVwmXLuErPr14tcR+Eu3Bwf3e0NjapB5dS
 bcTO8kRv9BHJhHREAsh2sfhKaBKFp11nJSnPGKXUGi3HmVchkb0n5Y310uWUXMbLh4hTWHiE08H
 MCkR0yZG9iIQJgkv5vpMUd/UpVJoec6BSm+1PF8EENkGfQ8q2v4Mbykr8KkKyBwx692MbSSGMFN
 grDoI0gyO8Ivh
X-Google-Smtp-Source: AGHT+IGvlP5S7xHLPzO6ycdt9LsCQsi1xc+qpkSeBZx+zfG4W388TfEr27oGs6RXFanujJWTA7KdZQ==
X-Received: by 2002:a05:600c:cc:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-43d4915e6bemr17966175e9.3.1742454574503; 
 Thu, 20 Mar 2025 00:09:34 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c4f9d59dsm23009737f8f.0.2025.03.20.00.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:09:34 -0700 (PDT)
Message-ID: <1d109799-c8d1-412f-b829-ad223d691511@linaro.org>
Date: Thu, 20 Mar 2025 08:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] include/gdbstub: fix include guard in commands.h
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319182255.3096731-2-alex.bennee@linaro.org>
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

On 19/3/25 19:22, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/gdbstub/commands.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


