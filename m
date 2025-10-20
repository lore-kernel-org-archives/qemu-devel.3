Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA3ECCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwEX-0008Mk-Pf; Mon, 20 Oct 2025 16:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwE5-0008CY-SV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:11:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwE2-0002TA-Rj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:11:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so328839f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760991084; x=1761595884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BOC8KHQT5zdlkcCN6BWQC4klzoLQxyO82TNfKseWIAc=;
 b=IbEcmTFq6SUUM8Z3XdWu/ysRhFWyZunb4VGW/JLvW1p6UYyraTH/7VrWpZk4qSRBe3
 wgmciUZs6q3VjYegsTobiRZrSmHcW/VxPZljT4QVAFBJnhCdPq/gT5Vq0adfsR2gRh5n
 4k64MRAi0jRdryfMyTqLON0qPmGUlQxW5cLzuPQif54Lbvh677qM6M+aOKjsNQJw1w98
 kOOA8+VFoz7+Gi7uwrPOk2KJAEC54snQGTlnH7xKfao/VGSfed3d5JkaxprrgLZLw7iZ
 +yREm4VkObbYoVfhMHFdYUwOuFboVvALN0Bum5TAtfGXTdX0C3pim6A6OSFolyY9eqj8
 Zwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991084; x=1761595884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BOC8KHQT5zdlkcCN6BWQC4klzoLQxyO82TNfKseWIAc=;
 b=ZRDetoBK8epen8IX9m0mw6kenI0zvH9qjTf6wk71DJMQAK6sVaJJvKofdOb6VCu8jD
 kXtCS64z6ynCJZ2HMDTB8U6WdGYrwYv7voh/FyQdcJzmGkwnmi67/EKShwn8F/znPDbg
 Vx2g87RUWBHrX4P9bbsVQm752BJl+Yg8fIBlAs2KxM6jNCCrO+GzR3n/TqGh2rpHD+M5
 RaaYbIiOXaFJIt8Xi9sCZRqTrbTI43maLfJgbuX2x2RioRbwLK4IlldB+KIFYr5W1p5f
 8nzWDc9Rj3Pv1IjW0WhgoTkF0mDHRokD88r5NqIthAMvkyE6TFu9ayykeLWqCZqJLVRA
 xAaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuXUgCMvccvpht0dB7ZOPX0nRpvaLKZTv2Uew0Nk4T2eQOIRVQXSFU0zTIORWuWX+V855FK1QgrVaK@nongnu.org
X-Gm-Message-State: AOJu0Yz3WL8Mfv3lj70kqYDY5TJHBx05C3vtaZjh4R+i1DwSs4w7RobW
 zAn3E12VgxRmMdKu4R8mRgPRTprY3L3JUoPPuZJppwlN4EPDX972VgpogP2AjtHco+E=
X-Gm-Gg: ASbGncuUSHXDY1VFr16hGabys7Ddf2dM5OdvJtefagtLpxwo21AlIwTyo+YjgJtbL3x
 yGyzeUw9aLNjKLnmQiqpGQb4RFSmSehf3yTXQgn8bogH/UG8Ovkt+VXkIA8HIw3PIFz7THLoflJ
 Z+LOQwDA2hRN4z3deGGW+GNiDMf8y0pcC5Hg6ar0gj4NW0E97Kaqjwi4BxDu1bVaUpQcmxPRfsD
 RRvSqx97gSi3WY7VdBukfUWT0+1MiJSkVL8JTeADTLxjgtpJuZRspoMUJbZ99X8wfFRm+HXxEae
 lyPsC2NbWpWMbIhmX2F7ImDKszoZsoO3uiGBv+3QoW6Dl5YENRKs+SD2UZ6TxP39gzD3SKoTgTs
 qNgq7xs4UFM20F6RScXWmMLHRv7+qRXN0hvd8xd9NoriGfTY4l36SLBvNpS/RIz/PxSrPzSFglk
 EJihrBnjs5s9nVqO1aUcSRAQsZl4p3H7wyjheIsXqTfQnaguZLT+w6aQ==
X-Google-Smtp-Source: AGHT+IGlQit8jxcVermT3Q3KqVwTt/gJVpp0fGqe/gGpdTsTpMenj6k695GicqExOZtqsoDkwoun8w==
X-Received: by 2002:a05:6000:2010:b0:426:ff7c:86e4 with SMTP id
 ffacd0b85a97d-42704d8df97mr9521343f8f.19.1760991083917; 
 Mon, 20 Oct 2025 13:11:23 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fdfsm16692563f8f.40.2025.10.20.13.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:11:23 -0700 (PDT)
Message-ID: <dbb84bf7-2a5c-4c16-9dad-46669ad9b998@linaro.org>
Date: Mon, 20 Oct 2025 22:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing machine name in the Alpha section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20251020140425.45003-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020140425.45003-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 20/10/25 16:04, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Without a machine name here, get_maintainers.pl uses the "-----..."
> separator for describing what the maintainer is taking care of:
> 
>   $ scripts/get_maintainer.pl -f hw/alpha/dp264.c
>   Richard Henderson <richard.henderson@linaro.org> (maintainer:--------------)
>   qemu-devel@nongnu.org (open list:All patches CC here)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks.

