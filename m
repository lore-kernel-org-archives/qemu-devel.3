Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CAD10C0E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 11:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Z1h-0003Fa-RS; Sun, 03 Nov 2024 06:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7Z1f-0003F7-Iz
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 06:44:11 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7Z1d-0000rt-M1
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 06:44:11 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso2095820f8f.0
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730634246; x=1731239046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WWpkTwRiyyjRfZFurAtTbBuIXa6/rIcbI84x8UjVMS4=;
 b=ClHrjZhHfNLnKmAb9fJ/o/6Z7eUB5b3jXu0bJPdc9i3nXdqBWhYuoKiuXB5a1nBIob
 CRBGsyK1TKRxMGvr/7tS/bZfaUG5VsqDftkAZx685x9nsL/DAX2B7722vbYD0JZ1UQjl
 3EnptKBdErqUtxNFAxcAuITqgaumL7rW+F9OZ8veI2/q+v6Nq6HKv8zAYsK55L7Wravi
 E0gzOgWlOHHhBndSC6T3Ou6bCv7K662ADRpc8MIijOxuNpt2fV08wj1hkangKtvqFNr2
 0ANdg6AOAnQufjLmzK6CrO90oBEfxeLdHotPhaUTK4unYCAJqs2a30Vx1PSIuYi2geKL
 qQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730634246; x=1731239046;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WWpkTwRiyyjRfZFurAtTbBuIXa6/rIcbI84x8UjVMS4=;
 b=FQEzcQkF4KR0x1/UrN+Dsdy8DZmpT/r7No6u1uJtyoSj4CqKGqjZBA+qGnO7e2bpNS
 cTDUfU2jT99hPsYzxvwEfRIqn91iCVLajNiEiMkB+K7CzjNsoIsU+VSvKKxmPUAbUED1
 PSOrfz1iVtYqyapYA/5oR7hcClEl4pDt4+NrPipbW2tDLT+UFCjodTP9OScTWwEBjTZD
 EsvVYbu5D7K73QmP+0xaLMXoyQ4f+xXXT/oH8Pf/f/vJyNR3NePx+Tk+CgCKm7BvEWF7
 g2QzZ5tGTQ1wwRIWZSmytQ6E2k9t9US1hYlVjKkC9K8u0AXuhZmjuLxgLGjugqBYuQsE
 YrJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1pUhiXIw4vsywqe18mgBvf3meJpVaat3anI7L/8WD1x1xq+SpHoYzn7HUPzePaCCKmh0LkZsZ1CHS@nongnu.org
X-Gm-Message-State: AOJu0YyWDdaBlJZTPgcQqJiA3dMPd0sc11rdMczdAJLOgE6LtOiyg6ho
 2Brtz+q7RAoLdt/RZfoDQFEqHDhtCKTwl1o3LnB3Kjk8xi5TdBP+FP8wymf3SBI=
X-Google-Smtp-Source: AGHT+IH9tEOA4ChHbDsdxIveW4O4fzngVYAwVXM4p/fehYZpUIXtR1oPK0LLq2P8vO33x4roKyghlQ==
X-Received: by 2002:a05:6000:184b:b0:37d:45ad:8394 with SMTP id
 ffacd0b85a97d-381c7a4aecdmr6723606f8f.15.1730634246045; 
 Sun, 03 Nov 2024 03:44:06 -0800 (PST)
Received: from [172.33.63.88] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d473bsm10485654f8f.35.2024.11.03.03.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 03:44:05 -0800 (PST)
Message-ID: <edcd1e2d-7d16-4bc2-92d0-b3ac7ee46f1a@linaro.org>
Date: Sun, 3 Nov 2024 08:40:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ui/input-legacy.c: remove unused legacy
 qemu_add_kbd_event_handler() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 peter.maydell@linaro.org, huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-3-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101201106.1432336-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 1/11/24 17:11, Mark Cave-Ayland wrote:
> Since the last keyboard device has now been converted over to use
> qemu_input_handler_register(), the legacy qemu_add_kbd_event_handler() function
> is now unused and can be removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/ui/console.h |  2 --
>   ui/input-legacy.c    | 37 -------------------------------------
>   2 files changed, 39 deletions(-)

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


