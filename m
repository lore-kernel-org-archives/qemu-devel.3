Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B57C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 04:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVP2-0003kt-Cl; Tue, 02 Jul 2024 00:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVOs-0003ie-7v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 00:46:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVOo-0001RT-84
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 00:45:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3672aec418cso1961452f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 21:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719895548; x=1720500348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hRM5RmiLRODUjzvf+gKjs2NmX8zuEYbR+EOHCXYABk=;
 b=cMeOzdhR2fYqwU8++O43+wa2yfNunWmjAiS970oCzkWo/SjqrsdjdI6gDCvlp89JeA
 LQ0E8z58Op6rk22ezaJQYHyDn6UCkd64Wy+neZV5cPypZMqLML4zOuSDYtIxZdcWd+05
 ivr7yGLPe+2/XzLoqCcfoYXrGxDEQcHpxIRPsQp2H/QUIBGdmBbRjfeEzkKcmrrk3e3z
 tqcKXQkIuv/NWJKSL/Rb58ZqQ12dlttyPC/KdoQ44BSUNS2zK7IuFiKACODI6R6QT/yv
 LQXXVN0FNIPf14lc76D0dUAgGWYHME8cMLiSKisQBzDiWHtEDU6OczSNdD4Kxemn5kBm
 usnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719895548; x=1720500348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hRM5RmiLRODUjzvf+gKjs2NmX8zuEYbR+EOHCXYABk=;
 b=jRyEC5/15y6HeHLFZn1zvWFpbOhSSZ9mC75OhAziFLg74yFi9AfkN2Vx1EKHdMDIsn
 eoFf5VODvGHL6/IGBcNOM6XRxMpYnraT7JkeOYpxaj13Wo1bxA+iuZ4mQBfumiqYYXzb
 lkIedN7PHpS1Wi+fqp1wm3lrQ7YqMBU1mzyTI13vznPAxsOUELQuEZPqb5OmDycSV+km
 J42CFK3+g4n3SEJDvHEj/DsA/ivB5IckXM7P+eEYEFzR+bzHPcKnZg/xgXuNuul1BzKh
 NORfRv7iTRSmGUIpgPif5EsbVJp+8de1n/YpftxF31bdn55NG08GsXU9mZDQq1WAaQzz
 M+MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO/Hv+fdsacO0my+6H/Ax/7Fs1JA6MErokn3XLTDZS6I99GgkQCsX7cXhwyi2U3W7xbqbIVWlTX3wV22YtepAPElUSxis=
X-Gm-Message-State: AOJu0Yx4P9DyoDRbA9l4Vod6+tMCo3S4IpWQboYAxHP5nwiFgubBhPvb
 t0oWV35wtDUCzkpYS/MzVyz1NLkcE/x3hEIRenMlEkFSM9jhKB3ywhZ5cMGAXC0=
X-Google-Smtp-Source: AGHT+IG2l8vaTIMrjH6AXpHM8t7cfmJReTMPXXYXOsRcAiJqVnW+nA1xns0MW1HNbHUEJ5fWW9+glA==
X-Received: by 2002:a5d:5392:0:b0:362:1322:b013 with SMTP id
 ffacd0b85a97d-3677571c4dcmr4777311f8f.47.1719895547568; 
 Mon, 01 Jul 2024 21:45:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12fcsm11906714f8f.48.2024.07.01.21.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 21:45:46 -0700 (PDT)
Message-ID: <1ee6db7a-a99f-44c1-9705-28c5651c7348@linaro.org>
Date: Tue, 2 Jul 2024 06:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Attach default virtio-net devices to the
 /machine/virtual-css-bridge
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240701200108.154271-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240701200108.154271-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 1/7/24 22:01, Thomas Huth wrote:
> The initial virtio-net-ccw devices currently do not have a proper parent
> in the QOM tree, so they show up under /machine/unattached - which is
> somewhat ugly. Let's attach them to /machine/virtual-css-bridge/virtual-css
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



