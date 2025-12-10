Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B53D2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 11:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTHvY-0002jt-BO; Wed, 10 Dec 2025 06:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTHvW-0002j0-OJ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 06:00:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTHvR-0003DG-F0
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 06:00:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so56657395e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 03:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765364403; x=1765969203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbvqQiM0Hg7JnJkifPKiEMRMTMpM7V85GonokBLipjg=;
 b=FbkiSHIEpx5T5/XF+Tc1iNfd7tBdsaXniP3pPTxYJz8bnM1o6Ey5cpl2D6Z+/XID/b
 h3P2H17YWG6b6H7SKvqX+WNtVrNb99eKwqWkYej5D5DTttDgdCdqZkjivPbHx2x4p3zu
 KMkIblb+KTaQKUApb4zQhtZ6iIZUxo0l/MhHHtSUxkkEudH1e7xchDRpQVA9Pwb8D+0H
 RRM5hgJ/jHLFVxt7ckeUAWtyF1nOwYrF/pSqnvc70HdS0fuGwDnYkeZlkCEiuTyySN6g
 xuGG4bYEOQyTdiZpAr29xuSFFtB7346eAz2KQSQHDbXaG72D8uIZKHy9bRxJvHkiATAb
 AmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765364403; x=1765969203;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbvqQiM0Hg7JnJkifPKiEMRMTMpM7V85GonokBLipjg=;
 b=H86VRN6or1dtopogah84sgJUGSMTMmuWkvtzJw5012MT1fJ+t2tfI/z20fZ4didP8D
 RfoiizZ6O6UiGdakzGQZ6hv+RxQV/Ny5wED1n9zIvsCUI8frFnrpjOr8qKQmGqGC4nOJ
 H4W8cSUa1aiBLoRH51vudbKwZs6++4wkt/UI3u3EB4edS1GzUVq5RI5LZdklx/xXhJ98
 /+H2MxmWLPkC9m1h0H1O7dpmTYurip7I8n1uwRjG/h37oXqp5yHKgYgGnkKxjYWO1mDB
 sFI3mGJpuDwyZvDpw2O7UG4lgCNPISFUQ33w18xaDpx1MyQrCrGGDgTrPGAYMbp+zNHt
 4Wlg==
X-Gm-Message-State: AOJu0YwEeCfsPzIB0LWmaP4LMfT/FEXJ/JwgZbheKOVC6gYY5jmwjd++
 X8YE/mHrlErKv6pBTXIKw3HUqyd3CyLyvs0wNzg6ARVCqgRlyGfRT6iDBRS/swFp+GI=
X-Gm-Gg: ASbGncvSzPtR4jNZJQ/PzV9PSIYGx58kHwuC86HnbR0d6faxKsBSL5uKNTS812n74zW
 1L8p+oQNn2+AEl0831YHYzLBuvA799MqMdIZT2wZbvedJ/fRwrJCdDqIKnnPveMEcveFf4CrJdM
 2VbaWdhBN0LgzIUYMsIS7SegXCE0ksAEmpkDaKYhAu1lhMml7vM7vVrCElRcIKme+asFxkfXDDf
 cyt7iuCtnjeou7SMjKby/B5SeXw/UPKEnps90Vrp8iqpgEPG6I1AOSFZwlmSEdqkO0A/W2qWTfq
 +09d1fvi9PM2/gPr/wQ8rUyqhYKQj4EEwalfYJinZH8AnmsafnX6eS8i0nx4lPNdk5Z2l2sUSrn
 OmCvxM/1u5SH2aAvvGNcP6CnbjZ3eh5bjm6Zdm/bil6NAV0qqgJGqXWFMkrlucnIVDs0d4w9I1c
 LDkYIZLTpdmyw=
X-Google-Smtp-Source: AGHT+IEIsBYCzOr9ZBGe2j0sEmRavUte89zb2fWI3Exm/V2V++m7yWnf5MptmP5gL2L12n1UP9Fb7Q==
X-Received: by 2002:a05:600c:8183:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47a83848368mr17774345e9.31.1765364403412; 
 Wed, 10 Dec 2025 03:00:03 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d414basm36783385e9.10.2025.12.10.03.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 03:00:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D6E45F814;
 Wed, 10 Dec 2025 11:00:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Jessica Clarke <jrtc27@jrtc27.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>,  qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3] target/arm: handle unaligned PC during tlb probe
In-Reply-To: <836d2623-6b79-4303-a34b-12e72c674822@tls.msk.ru> (Michael
 Tokarev's message of "Wed, 10 Dec 2025 13:14:42 +0300")
References: <20251204203540.1381896-1-alex.bennee@linaro.org>
 <836d2623-6b79-4303-a34b-12e72c674822@tls.msk.ru>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 10 Dec 2025 11:00:02 +0000
Message-ID: <87sedivbyl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 12/4/25 23:35, Alex Benn=C3=A9e wrote:
>> PC alignment faults have priority over instruction aborts and we have
>> code to deal with this in the translation front-ends. However during
>> tb_lookup we can see a potentially faulting probe which doesn't get a
>> MemOp set. If the page isn't available this results in
>> EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).
>> As there is no easy way to set the appropriate MemOp in the
>> instruction fetch probe path lets just detect it in
>> arm_cpu_tlb_fill_align() ahead of the main alignment check. We also
>> teach arm_deliver_fault to deliver the right syndrome for
>> MMU_INST_FETCH alignment issues.
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3233
>> Tested-by: Jessica Clarke <jrtc27@jrtc27.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This feels like a qemu-stable material (for all active stable
> branches).

By all means - its pretty self-contained.

>
> I'm picking it up for 10.0.x and 10.1.x.  Please let me know
> if I shouldn't.
>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

