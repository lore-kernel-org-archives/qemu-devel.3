Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A40CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tQC-0007aZ-AQ; Thu, 09 Oct 2025 12:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tQ7-0007aL-A7
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:23:12 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tQ2-00013z-Ck
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:23:10 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so1329187a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760026982; x=1760631782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+0DSHNgEC1h4wkOB3rz80mCmzhQndjNhNpCi/vR6kU=;
 b=Xsb6OAwEofANKJo/D2UjwMXyHWCz+H+bPYV0thBsExyiOZydLHiOx9gSjqebhZRtdR
 1IV9pvseRlHUze+PchXpD6NioD43SuBrWVgY0LHG3MMCI2PoQ40+MeLrLdr1buxqh6nY
 EJYdvpuGRi7FKfYJSBQjhNa6sGcLlPbRVAwH6qUjbtRsbZAuBecuD9Vbpoj77yOSBmQM
 qYfPgLOQakAAPJOO1eSEpC7eWbJNx0NtPLKsi4vdw3ari/eU3k8NbeuRgzxP+N48eUTy
 8Cozn4Gpk8PiAXFaduJlXrM/24uGdSlpqapD/OshyDQRI9MqYMdtoMx+4xhnaRFEDsWg
 82CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760026982; x=1760631782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+0DSHNgEC1h4wkOB3rz80mCmzhQndjNhNpCi/vR6kU=;
 b=QGQjgPV5hgkjCovxWiWC0zr9JZv9qDaDUkiKHkG5ZMGa6Ys8xLoHrjjLWvUlf/KCx3
 5pALc+cOU0JhYEqCz/r+2KwgyeROl199EFGGJIXK9HWrn8EnlvBHAbZct+olp8iPn6gK
 CmOuCmKAMy4cZ4nhW20/2phyBc0Z8LBDQzQB+Uvao/FpBi85Ogk1g+PLvaWh1WM+ws3x
 WX/4hBZe2zH1hsL2X5leVttn6cfisLBajICHYm6AsjWDLjomP4EWgS8jU2PmTRuTgjMq
 3dnctwGjkzZEKTAFEOMMo5AM/EEMHDeoclgxL2QkIHExVzs37A+4BFfIfnMAiTXxl6vj
 7lMw==
X-Gm-Message-State: AOJu0YwwpsBxPBafPtaiE4cP1/9vDM8ix9Pos/2Ee+pijEE8yv/5QhN5
 DzaykFkegbLAKaITtEThDgRIxHvKqDAVrEXaNvekmeHCZCTyMKWPKXFqSyASELiKkpP7BznfqRC
 EJ9shob4=
X-Gm-Gg: ASbGncu3AU+uY4jJmTHE2Z10f46D+EVc7Ct0f2KGWZiMK01llHe/hm+xG1XaVeH6mMd
 ywThhNFdGu+9PRALhtHNQxhZbGnk1Q3eUy12uvzNep0RekWQV7QEunHGY03Ao7T+rq7B0FbL6/z
 e0t0laqn6dHFCmwHzttOo6x6v0LNHC3yVrJs+gn7cIbaJeIAt+3M1Fs1PxRyobrQh2ZApQT/fV1
 L8a4UoWzhQETzjz9M8y82KLxx0JpbPheFxt0UUZ+83CQV9SfAyuHinKXGQAzpxH1ZxBrpqsooEV
 QCuHJUS9nigbb0D3pArVkxwMmooAIseT1y/HL/34GcEHqrMVi5CEtTpJ1kuG0p2VUM6gBjwz19z
 Q7qhwajlwwzkj9ZsFoOPsY3tNYzB7HEqoC24ZtitIvMy0JNyd4M9Zq7a7hcYj44u9
X-Google-Smtp-Source: AGHT+IGEdDZFWSYizLVFgPmP2EMhonKv5PCltaV20ql3RKzC1xiTn3HodTrdwOzBbZT+/YXQ6ScGcA==
X-Received: by 2002:a17:90b:4f8e:b0:339:ef05:3575 with SMTP id
 98e67ed59e1d1-33b513cd915mr11908436a91.26.1760026982056; 
 Thu, 09 Oct 2025 09:23:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61a1d3ffsm303421a91.1.2025.10.09.09.23.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:23:01 -0700 (PDT)
Message-ID: <39cdd946-c454-4195-9036-90b039f44e56@linaro.org>
Date: Thu, 9 Oct 2025 09:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/35] i386 (MSHV, migration) and Rust changes for
 2025-10-09
To: qemu-devel@nongnu.org
References: <20251009075026.505715-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 10/9/25 00:49, Paolo Bonzini wrote:
> The following changes since commit 517e9b4862cc9798b7a24b1935d94c2f96787f12:
> 
>    Merge tag 'qtest-20251001-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2025-10-01 15:03:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to b9ef6198d709f431d893d1b5525cdf7fd7a3e11b:
> 
>    rust: fix path to rust_root_crate.sh (2025-10-09 09:48:35 +0200)
> 
> ----------------------------------------------------------------
> * i386: fix migration issues in 10.1
> * target/i386/mshv: new accelerator
> * rust: use glib-sys-rs
> * rust: fixes for docker tests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

