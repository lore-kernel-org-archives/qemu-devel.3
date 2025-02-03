Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EF5C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texDc-0000Yl-GA; Mon, 03 Feb 2025 09:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texDa-0000YQ-UB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:30 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texDZ-0007xd-9J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:30 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so10869465a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738592067; x=1739196867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGqWfDgljKeh4GC/7tXzwPRzXR2SvJ9aVTr5jmzGPj8=;
 b=YfByOsxEXIaNrQnl/1BAxL8jidl537E/FLAn5OQdSmgDWpq/Pd1S7/ceLy5pjS7tGf
 h5G/c/LmNXGVzXWXl7/iq4MOuADoWWV2WM4ph5ong2Xj8WRAm7GgFeWRtf6Z0Txc9mMG
 gy2HVSWbDz3jJOHSe8y0c23FXXFf4R2+KF1nYLsZsfAUlk+QUWdNaSUELZZg70aDxL/6
 4d8eu4/AeQVhENT3p2aJmaPPriSzh+Zde0oPtGWywRV+j4twfrZVFr4WvAmtrsvpxe/3
 8LMwiSgJUlhdTGjX8hCls01+FB67+gU2yRcC6G1FpNajMvrMWtHZi3K8DwPhK5KQTBD5
 OVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738592067; x=1739196867;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGqWfDgljKeh4GC/7tXzwPRzXR2SvJ9aVTr5jmzGPj8=;
 b=XRZevi8h+OfnzZy9zFkxQ1yBRUlFQyIPGmz+82zVj3At7/SB+AUWan9uMVIAAUyihO
 6SdLQ8e5DPb3RONoua8gdJymni8tSpv+tWmkJhj8SEoZ8s7o2iqcQ1RDMEmjmwEuSdbY
 NTMAwbNRYdovcrQPTDWcbo22TE3absiwkMWIc+2uhW5C0WC8K1MxXKv9PDrXG7WbaPMO
 S0G63DJTcwQWWuzlqJLRWcRQn4gm1CnVcU8RzkxIIlU26LX+WutJyl9WdJF4Ax2vSvbw
 C5CcYIMXcMGojJoLxmwp611hHLi/ltDIDDtkSvKIzGbjU4yQkWs0DFNKsDurcICV2k8x
 VL1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS4dETMKb3pJ5GxAxCwbwlt5Kcopy1VZNy1ZqGU34TAlssA3ItYLc7RyfVkMVTQbt6a1PEWPX4mB/N@nongnu.org
X-Gm-Message-State: AOJu0YwQTzqLkXIjmKvByvWs+Ud27pzIaBMMlgeiGR8K7nVB47n0LNoJ
 k6uaKhVY7Szc1ynbBtInO8Rfjgg+XqaZfZ0nHW6u4mPfsTT4qkokubVVWbYuyWZMy+xuX3tU2Xx
 nDeg=
X-Gm-Gg: ASbGncuEgRfSZATulCKgxGClvEID0M4wt1E8Rux85s363NuxoGzMOsJmwl/5Uk9tBqk
 iXsHX4bWRe6lbqO/errR13B4/+GirorW/uOga6yxWcPoF9Fg+bNKiEiUW1dQzyUM2JWZOxuHE3N
 JJE7GOFvPkWZKg2f89Q12vcK3wpCevu2eOdlGRthTS/i5g/j4w8axXsMDNcA+no5IWrploSL2Xy
 regwdql4awDXienB62nYqqXa1VJxSMvCDbA56JTm3K5SmMuVKNpTNE+teCjZzP/KZpimbPe1F/S
 47e+nPp9DoHtBD1Jpw==
X-Google-Smtp-Source: AGHT+IHCN7yF8Y8cthwA0dF1Ceecj0oVtREkGZT5N1jHB8w30i0kMLUT63EW06lbKHxFjb61st9CFw==
X-Received: by 2002:a17:907:7284:b0:ab3:7723:941a with SMTP id
 a640c23a62f3a-ab6f73fa284mr1597356166b.6.1738592067243; 
 Mon, 03 Feb 2025 06:14:27 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc72404537sm7830490a12.35.2025.02.03.06.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:14:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5487F5F8BF;
 Mon,  3 Feb 2025 14:14:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julia <midnight@trainwit.ch>
Cc: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org,  qemu-riscv@nongnu.org
Subject: Re: [PATCH 1/1] target/riscv: log guest errors when reserved bits
 are set in PTEs
In-Reply-To: <8149beba-66b1-4707-93f1-083b8bc5ece0@app.fastmail.com> (Julia's
 message of "Mon, 03 Feb 2025 18:12:21 +1100")
References: <20250202051505.1846933-1-midnight@trainwit.ch>
 <20250202051505.1846933-2-midnight@trainwit.ch>
 <b76bf940-ff55-4619-a9ae-fa65c47e864f@ventanamicro.com>
 <8149beba-66b1-4707-93f1-083b8bc5ece0@app.fastmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 14:14:25 +0000
Message-ID: <87pljzazem.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Julia <midnight@trainwit.ch> writes:

>> This happens because 'pte' is a 'target_ulong' type that, for riscv32, w=
ill be
>> interpreted as uint32_t while the FMT being used is PRIx64.
>>
>> You can fix it by using TARGET_FMT_lx instead of PRIx64:
>>
>
> I've sent a follow-up patch fixing these build errors, it builds on 32 & =
64 bit on my system. Cheers=20
>
> As for the Signed-off-by, I'd rather not, and the contributing guide
> does not require it.

It absolutely does, as listed in the minimal checklist:

  https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#id30

>
> Regards,
> Julia

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

