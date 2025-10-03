Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841B9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 18:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4k5l-00087e-Dm; Fri, 03 Oct 2025 14:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1v4k5h-000816-0k
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 14:01:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1v4k5S-0003xT-5j
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 14:01:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7811d363caaso395646b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759514449; x=1760119249; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KdA46S4XWYo3OY9PpNfkkUoNsKbhP/c8cQLeAEyNTU=;
 b=fGEtyK2creHJ/n/L0wALdBscaSM9Knv+mj16q7tJK+EKtG8gVsj2mj5lCY6xoJjDc1
 N/96masXkAPRdUuq52WGR6Htn23pug50gmxo9nRa/gtNnS5Xk+DXISJ8q07n5BdB/Jp8
 t3TTIDEPAYhKv8TDJM7KIktbXjIBt7ognli9DZn8I9SaykvsqVt8AKvAHP0ghHHOK9vS
 k+NFpWkriD5hONRpbcr3zeQ82jt72upMx14Q+h7iXuRy6J0S2g9PAR/K686XrcjgX0Vk
 Dn3TdnyqJStVV9gPl1kSIzqtRGJXcpgURNyvzI5SHnBbD7SJfJIvSOkKWHGhj/M7Iaor
 cFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759514449; x=1760119249;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7KdA46S4XWYo3OY9PpNfkkUoNsKbhP/c8cQLeAEyNTU=;
 b=RFgXpAEhcmHlL7lXfUFpxDca/sl5MtRgKBujPtQSn2WxrLLNHruVqFuPsud1ia3vOZ
 sKE5OgPf2PT9zeNO3Xnc0GGSFLEdwf4YLV37jVIGHQyEntsLF2kg7fEOFuh0F8SEBalL
 ZSkyEzLTsBhE4B29+HxziDuQeXqiynYBkGIjXfRxAjfhkSuIk7d+EdVrzGHFR2rZ2wpM
 CtNU21pOniPEcwXMepKAhLmtRl2X7dvv6Uaq6Om+ji+Bnz0gUQoVlFd0+vU2OV+k2yEt
 clqTXE3WWNkXaM2D1QAwxdZ26oEd6Ludir0Zmi2TGnUcZ3HL0ZuGyqGQkGrRyx1SrxxY
 hx6w==
X-Gm-Message-State: AOJu0Yw5SUd+Hd4khy64TqhHmmW8iW+ojBmr6vTR6sj14ilAsfQx6vpr
 g8LqYkznFk86/5lBGQiQxds3gwPQQydbWSDejiQlX3BGCMtK7UFWnJxr
X-Gm-Gg: ASbGnctOdxjSgpaU8cnrShMyzGCQ6uogIqxEwHs7Xm/KlowfQLWfhRDg/WEmXbVel6c
 GTYVI/TMxXIb8HdnAJwy0K3eJhuWoZl+3d70zDdhE8tammswAkU+nSlPZBKuzgwxpfV9B0fTqh8
 FHtdaXmg6vR+UyX4mMHWj96fRIXRsR3Wn8bCCOFwZNRKYF0uMTUo+JXUNF9EYY6zLcCvNG+0HH8
 BoOVeK0YWZUm7qtvlkFBZDHy5d5W8lsvyNe/z3sLXBsNE5olxmTPXfS74QDR0FJm9MK+VeP34OC
 ypiP/rqtgl1qQEHLjGq3B/61RzAel6YZ+HT68kyQDDTwELqQtKFQtC1+RVumt3FnDn/pgUOcXLJ
 /nAcolQB/6Nt/DIOHPeiixIlSsz+K0hOslotqh/dFz4xiG4oXcvs7GqTb
X-Google-Smtp-Source: AGHT+IFm5nWZ418GEFlb7pxbm2wCPDn361A4ui9I+sOrgUd6kY6pp3XCs6p4xOhM8FyTYQCOv8uGTw==
X-Received: by 2002:a05:6300:8807:b0:326:9ee:74f6 with SMTP id
 adf61e73a8af0-32b6213eeaamr2930274637.8.1759514448910; 
 Fri, 03 Oct 2025 11:00:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b0206e50esm5399311b3a.62.2025.10.03.11.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 11:00:48 -0700 (PDT)
Message-ID: <dc2a1732-5e85-4616-8304-28d00e83df35@gmail.com>
Date: Fri, 3 Oct 2025 11:00:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <rth7680@gmail.com>
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: alpine docker configuration fails rust tests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=rth7680@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hiya,

Our Alpine docker image isn't quite right, and fails testing for rust:

> Detecting compiler via: `rustc --target x86_64-unknown-linux-musl --version` -> 0
> stdout:
> rustc 1.83.0 (90b35a623 2024-11-26) (Alpine Linux 1.83.0-r0)
> -----------
> -----------
> Called: `rustc --target x86_64-unknown-linux-musl -C linker=cc -C link-arg=-m64 -o 
> /tmp/qemu-test/build/meson-private/rusttest.exe 
> /tmp/qemu-test/build/meson-private/sanity.rs` -> 1
> stderr:
> error[E0463]: can't find crate for `std`
>   |
>   = note: the `x86_64-unknown-linux-musl` target may not be installed
>   = help: consider downloading the target with `rustup target add x86_64-unknown-linux-musl`
>
> error: aborting due to 1 previous error

But what's even more annoying is that --disable-rust doesn't suppress this check.

Thanks in advance,

r~


