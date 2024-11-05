Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D02D1BDDE
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 07:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ECw-0003nj-TM; Tue, 05 Nov 2024 02:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8ECv-0003mv-EB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:42:33 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8ECs-0000f5-P3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:42:33 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c7edf2872so47280615ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 23:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730792549; x=1731397349;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t004Mig/roh02b9IX2ZJ7uYz2DaHvJEDJhdSeQa99Ag=;
 b=zJOsAcfifHHN2Wz/AuFc+ULGyFj5LtHXONn4n01I6C07XO82wXXKt0ROVV3BYXi39g
 UEYbmnIMd/wWhFklDTRIi9pRAE6QZjAnPrzCsauMPImTBb3NznRiPU4zqfijc4atAQ0F
 8bH7byXmuN4UIt+MeOIgV95e/mSpwouOFV06zZgav8Vc/+QNoVrFBbmnphAVcAVkz3lD
 ay7acTCzzXlCmDdYZGnxOgKHOaNqvgs4YEDTg403TMimoU0lUTw0YowhNdmb5I+2vB+6
 ydINZSBDvVVrdMVK5OxLup9phvbai4GxOAOVYHej2LIhkKV2t6NDf9bElzFSumS9T1/X
 9irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730792549; x=1731397349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t004Mig/roh02b9IX2ZJ7uYz2DaHvJEDJhdSeQa99Ag=;
 b=P/qnbXvEc4S1rALcBWdWPsRSRCxDFJQCK2K17PXNvucA2v5vyIvwtjDF8bU/SeIcy6
 DhaVR1EkL7MgDT6n0F/Dj/5Y9I9VTloUqPwq7qctVx6bXu0QlphOKzosn1IdJKeztFRh
 Fed5pUpqrq0hYI3VrP1ESmiWAOxwr3h6Ak5e+N7Y7F24HfC9AS8+fnQLdl0EFwmINUE7
 jVZHFd/BwXXJF6/GMmcj1xQmm/n6ajEuSiLj4ugwbT5RB3WOuSxLeByeE2A9ATe3kq7A
 sPYps799gviNM2ZipZpesa3UlVbzf5HlkcS7ipDO5fyessRv46eEjGl2Wd8RzCuWyBl7
 gWug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW71SdBH0kigtYL07xQRvxi2HdfsfKL55Ttj+2NjqoIuLLdsKhAAh15V4E63Y/k7UzNijxdmCaVe8b9@nongnu.org
X-Gm-Message-State: AOJu0Yxclk3UadeD7zJH3wJYZWkEcU8wn4WRsMaCkhNZ3Qwv9bkz10gb
 mLyVyWiFWmgO29BJ0T+y+FHgn3x4IWZWqkS8Q1rIAmChPfkSWcVS0hNtBv20tac=
X-Google-Smtp-Source: AGHT+IHiGFc5UIFVVqGRmTAIVzMM1Daaqgps5y5tfbkQvwem98SLygTqjR7WanTS/bMKTmdrg2TcWQ==
X-Received: by 2002:a17:902:ec8e:b0:211:2fb2:6a6 with SMTP id
 d9443c01a7336-2112fb206e3mr171647015ad.24.1730792548794; 
 Mon, 04 Nov 2024 23:42:28 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057c0ed3sm72994185ad.216.2024.11.04.23.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 23:42:27 -0800 (PST)
Message-ID: <ae7a360d-dd36-4e12-9a60-2946f758616e@daynix.com>
Date: Tue, 5 Nov 2024 16:42:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/26] hw/net/fsl_etsec/miim: Reuse MII constants
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
 <20241103133412.73536-16-shentey@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241103133412.73536-16-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/03 22:34, Bernhard Beschow wrote:
> Instead of defining redundant constants and using magic numbers reuse the
> existing MII constants.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> cc: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

