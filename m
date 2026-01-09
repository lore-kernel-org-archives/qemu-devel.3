Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98797D16804
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 10:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve9pN-0000gx-9l; Fri, 09 Jan 2026 05:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ve9om-0000IH-Pz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 05:34:15 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ve9ok-0007P2-Bv
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 05:34:08 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so2249174b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 02:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767954843; x=1768559643; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:references:in-reply-to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uyxGW1QuxvTD7JTvzOXFBhleXtHGhZnAbRTJ0iBHdw=;
 b=FdfP++JWcQlb6ZJfE5q9jMESOZ9sd0PxFPWBqNoLF06hJ8G/paeYF4HOT7/sm5IFOL
 xQlAUr/X70d0OQdbql4q2D40F7nmR4wmhdKDJ3vvns1W1wiFm0FPSrp1K1l+YvgLypU0
 wXmmUjuSHyxgXuodoMOR93mOZs6KBLVq+XP6K4dgMS1QLB7hFzM59h5qOpXRpigvRqWe
 AwtQf8TJv/h+d2nAKK+9WM2rVZObErgdgSR6bhKTvnzqrPXyVlNjFoabFhDU0n10+kTs
 xTbEaRLcL/DULSpM6f/ONnZYo4PNmjWdeSNucgdgXA9wd4axrFiQW7CeNGxIbUDYQDfN
 HaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767954843; x=1768559643;
 h=content-transfer-encoding:subject:from:to:references:in-reply-to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+uyxGW1QuxvTD7JTvzOXFBhleXtHGhZnAbRTJ0iBHdw=;
 b=aR2Q6bDHqLhjN2FWFe2QPzGMlihOkTDFsLEcLtAm8FP4lTCl9m85Hq6aYFVqpoQnYq
 wDabkEZEVVmHxPbuKwi1mha/rZxueXlU8pb41b6FGvizOVBVJyhvNxsUZy5v3TTioulf
 maGt6TYMuJMjRk4yD9nPxlJSPJmr4Z7Q9vBq0/n+xg6fCTOiE4R8JLrVsuUSydWe7p9I
 fAvkuj9QN8unpX1RbINYwpjQDJLyugo3Gwsm5l8CraXIKcG3WJHT01vW/NiLq0jT+R7e
 55vklBbFSUb9ai7A87wOl1nqi5kHkag4wvRnYVHeclgiiRuU9fPGCJvsjIeQepHoL7ku
 /nAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpTPPze49SYxQOzYPeCBqcbyVk6gtWqWj5vsQ+CBLaSrI7Rr83R7HxbTlg7uWnaFpk2/LEov7z953T@nongnu.org
X-Gm-Message-State: AOJu0Yysn/y6PpH7Uy5CsoKmcsik9czOCpOwXIPsOm58e85KqDLouyT4
 lb7K4ljM1pDI+kABECioHpNmAVG9XkQ8dilCBbNzyQ1yiTCRr7npmyRK
X-Gm-Gg: AY/fxX5hoPoeg6neCjihMhS785QyMBTwCzx/fH2TKgF55IDoSeceuhvt+Y3jv1cd+lr
 R9cIwsjAFpIO44pQFBQZj7LkUaKJAzbehpEhoIHNVe/DfKlGkOdA5svT968mXOw3TxIUkMaagN0
 4D/uVuEk7hajPIZxa7Bcce0muYPSxsJ7FcrhGdEKfgOc1lr2Q1HTvsXkNcY3tb8QZriKoijFreY
 P+rv5qq5uRKBOwcVa9eeOoOu50geV+hXYQN28nG2vNR7eyt5vXUjFO4zk+tWAdYhPsTf18CXpLR
 REG0sHhJgd6p4Wgs5Iel/8BNmmx15xKimKAk1F42ghJgs+7nVvS6ZLfiSy+IUSZmM0MFWowHVWU
 pRbhkW+odJzbR2FttgBjFkkAJKppOIdT5bDhunMQtza2QWr5EJ3gtJhw+GE9z2aaC/AkoZ3bJ9s
 hvyrU/fEJ7GFPuEOAJsx0AvG9aKelU94nCu3dSLFIy5jF4/SBP/Y/tFHlz0A==
X-Google-Smtp-Source: AGHT+IEqL1gDcsa2tmdBgZjxvJ7OORKLf5isq+A45axiWAc7SEsR33H9G0hZYivd/VChRYQHV15hhA==
X-Received: by 2002:a05:6a00:f9a:b0:7ff:c265:32e7 with SMTP id
 d2e1a72fcca58-81b7e1585a0mr8253994b3a.30.1767954843248; 
 Fri, 09 Jan 2026 02:34:03 -0800 (PST)
Received: from ?IPV6:240d:1a:3b6:8b00:3e6f:1064:5c66:4419?
 ([240d:1a:3b6:8b00:3e6f:1064:5c66:4419])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81ec1b5f927sm633688b3a.46.2026.01.09.02.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 02:34:02 -0800 (PST)
Message-ID: <afa3adb6-a94d-4ed8-b5fb-50071b5d4b22@gmail.com>
Date: Fri, 9 Jan 2026 19:34:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <3b5ddc4e-f631-4412-9fd6-ebbf49c55ab2@redhat.com>
References: <3b5ddc4e-f631-4412-9fd6-ebbf49c55ab2@redhat.com>
To: pbonzini@redhat.com, qemu-devel@nongnu.org
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH 00/50] Remove 32-bit host support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Paolo,

 > > Long has it been threatened, but here we are at last.
 > >
 > > 32-bit host support was deprecated with the 10.0 release, and so
 > > with the 11.0 release we may remove it.  Phil already did some
 > > cleanup in 10.2, removing support for mips32 and ppc32 within tcg.
 >
 > What is the situation with wasm?  If I understand correctly, wasm32
 > really is a 64-bit target from the TCG point of view, because it has
 > 64-bit registers internally (similar to x32).

Currently, wasm32 compilation is treated as a 32bit target with support only
for 32bit guests. 64bit guest support would require additional patches to
TCG, as discussed in the earlier attempt.
(e.g. 
https://patchew.org/QEMU/cover.1747922170.git.ktokunaga.mail@gmail.com/).

As an alternative approach, there is a patch set for 64bit compilation
support using wasm64 target, which doesn't require the additional TCG
patches. QEMU can still run on wasm32 engines (e.g. Safari) by relying on
the Emscripten's feature to lower the output binary to wasm32.

https://patchew.org/QEMU/cover.1767886100.git.ktokunaga.mail@gmail.com/

I've rebased this series on the recent tree yesterday.

Regards,
Kohei



