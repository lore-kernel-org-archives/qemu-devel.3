Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2629BC0219B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 00:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti0Qd-0001ki-TR; Tue, 11 Feb 2025 19:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti0QY-0001jl-P8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 19:16:31 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti0QW-0001eM-HH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 19:16:30 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fbf77b2b64so366949a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739319376; x=1739924176; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2s1zIoa2K3yqE7YH50XE7azdP8QbY8TsH8yDTdJwTk=;
 b=O02KUz+WfduqP2EJCfHWN4blUzYU6cycxjoHKVDpcHYQ3gJtPLRla4PrhAwGEa6trt
 X8NWlCoAMqVTUVk20GR/FC/Go08A0Bk/HIemIjSDdBHb8uSkioJw4NsCG7tjlPnsqgTU
 TMKfJOeGPe5fiHywfKf1yBOh4fdnyHjX5afJljBy908oE5MVMf+Pb9REcCzCdGDk9NW0
 NxVWvBR9fY3fKWvRq0UJi+YGSY5yPRcXuTtEtn/VXACuwczns/kf+zsPRTjQ1KHQAvCM
 GN79Lvo8ITtt2L3WnesEGZvdjaxvLs6kKSEsjM/O2OEoHHryy+4a+4pKIwuPpW9pzbx+
 GGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739319376; x=1739924176;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A2s1zIoa2K3yqE7YH50XE7azdP8QbY8TsH8yDTdJwTk=;
 b=DH6F7MjLkx4Ys64jTjkCLf0DA+DerlBlDWGxJDB2zo4gkAIAd83ceIfxQbExoxOK/g
 Oze50RA3bRUdPmsB71AjYVvFeKX0Dvy3FunjuR8JB84hLQLuW+w6G31sOtPee79K8F8I
 Wo9wGG7FBfWO1W6XuGwZRtXhfBVTrCTGK886atiaz41lWYQk6SM8rOCc+o8B4AxCoRlx
 tfrEDODmyGb8X2U4QwpTAi+9rsgJh+i/OGQM2hWqWTzktru8l+a49nQ8BKDYzFVgnYlG
 NK5THL4R01utV9Q7NM0upNZRR5J2imd0MH19hxLc22ocVYyXE7S+utWxPJ0U5w6v9Crw
 UUUQ==
X-Gm-Message-State: AOJu0YyJGNLVHCV4dCERuvXQOTiRt5bLtZ3Z4kWaXdejyIBLekZ6HGty
 +S6+76MkrCdZ/RstR91yGTjOeTLQzHrM3Z1bSWoEIjahyFaTOa0uZVNMMvTFcHYPTbzVg40tgEF
 L
X-Gm-Gg: ASbGncsdgYDQPx2SBXZiV0pYgB58lfByXjnI99HDAkd+9nZ5Rqm74OAceW8qfoeWIB6
 Yu2ZXlJePYqDnqO9VeaeXkjOouKO24WgJ+rHaVbgP19VNUEAjtsS/2Z9U/ewK+TQmtj/3CpD3A1
 uejpqv4rLF34zpJHgWfSUmB8uLqGeYWoNT7N/6gPSwBwpiG8RAjapff2gMvqBModibDIwBZ4gw7
 uneQSe/VytJ/C3uBNGWQq0OgniWPQXK1lbPYbx2Gav/q3EOAvZ4a2wJ8aQRB61N9ntCgQMX6sGE
 FmNoJSZEecziDEoagmIaHG5ujS0Be2cA5xj8AUdMo1IPcjOiv+cOEKU=
X-Google-Smtp-Source: AGHT+IFIVetMMTj+VDS4A6k2yPMUmwhVClZyN/QDcr4edqqNT0l6EwMHK+WDAz6SF3wJSPYfbmeu/Q==
X-Received: by 2002:a17:90b:5245:b0:2ee:f687:6adb with SMTP id
 98e67ed59e1d1-2fbf5bc1df4mr1510035a91.3.1739319375971; 
 Tue, 11 Feb 2025 16:16:15 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d551sm101204785ad.110.2025.02.11.16.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 16:16:15 -0800 (PST)
Message-ID: <0162223f-9775-47a4-8d85-1ba45e4b4e04@linaro.org>
Date: Tue, 11 Feb 2025 16:16:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, tommy.wu@sifive.com
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Incorrect warnings for riscv64-linuxuser
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

f9653d4eb2c  target/riscv: Add Smrnmi cpu extension
2d8e8259287  target/riscv: Add Smdbltrp ISA extension enable switch

These patches are supposed to be emitting a warning about disabling an extension that 
requires a new OpenSBI image.  But they are also emitting the warning for user-only.

Which means that all linux-user test cases emit nonsense warnings:

$ ./qemu-riscv64 ./tests/tcg/riscv64-linux-user/segfault
Smrnmi is disabled in the 'max' type CPU
Smdbltrp is disabled in the 'max' type CPU


Please fix.


r~

