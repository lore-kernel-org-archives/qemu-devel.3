Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E066C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrf9-0004zM-9P; Wed, 02 Jul 2025 03:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrf7-0004z7-KK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:13:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrf4-0003Rc-Cs
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:13:44 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60c93c23b08so7771536a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751440420; x=1752045220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dliF6h3QZBZHzwDSkryt4imK2QDkTaEqeoPSNCobyyQ=;
 b=w4mPNcnh+TuG7x0Rifqidy3UXkIwttWw8HMIuO8hErmdOTR0fzHegJwkEGYB+d3LAF
 aMrVp1Nkjze1WDxyJfD4I1Xt4i223jp0u9as5qNL2od3kdbjlKbpR2wPKMD0L3AsmJJ1
 O0dMgW5o9fBDiOEAPZOKLLL1BaNxlorvLUbaiRHU4+rfS9ZvvH362rKiji5NjspbIl0F
 sofcFikFNpa3+5W0/zrri4Puhpkcm1PNgjloOda0TP1gHdJaqJsjR9B8WMM9S3spBTZl
 gtnTvs0SscNkz0JH3KO3L161eUrbohRKqyXIenjXwQBVX4uYaZ3ImL5HkHRFtGmxSwlw
 ULzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751440420; x=1752045220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dliF6h3QZBZHzwDSkryt4imK2QDkTaEqeoPSNCobyyQ=;
 b=WDpdjcsC+g3Nz3vAW6pJ2udMehU5LjradHKfI3gRlgdHPC1t1YmwdxJG32Ey/CJdZm
 siOC//3EBmoGprVSK6TdUSTsw+22G2mfvEsQ8L3JLLgiyBXK6fuVFgVsi26o94Jcw08K
 eV09illJLT4ZdfLE6nZhJe53tkXd1nnZNy4GVCDTrWVzJjBCIHufvtGHNVWCfYsApjN7
 LA+RhS/uU/PcQlnJZgeAqq4AAyPJx5ivMaDCOQaK52R2g8qSNlyyPmID5Jf2m2LIYwzT
 vDK6tW3vyANjTUga33SGtYJS8KD8pLC7jBz18N+bSZu7zGF4PC2Ioj5lhQB1kBK7M/XL
 SxYg==
X-Gm-Message-State: AOJu0YxqX6dqpjK34nXzof/hiCjKFMr7ZpcuDg/F5zGrAksZaHmjSMRQ
 bgWFhAkj+why43WwE25Y/21zXc+Y6KVyCG7EujV3zSCFyld3AGUgwHeHGx5KFMdgwJU=
X-Gm-Gg: ASbGncvelSF1G/8hH9h3fRhoZWBfzrZAYyet/PXCQKS6AFpC7YtdLhBb/cKOKIAf5RZ
 3OXQBxT/wBQG94lKLhaDYWNlueFCH3aSwdKGB8GdAgitzdErfsbMPxkkfot83+wuQlfUTIgb9zA
 PuIMGk1Y1Ljw+PPuLvDU65E8/nucQ+Go6c72LFtyT7XJOgPFpswiEniQKOAYM0FJTecaV/40Wj9
 aGC/Knua6xDy8n0cyV9rxcPzpNTLqFVcE/C+iRro0lo70oOWYJOTsTK7HEjZGxL6v8AX0SGuq/5
 f/KUGxljuG9LsOCHojJ8clEoHhmqBEhJsnt911FCyiatApBStV4hnX15fmC8XVFTErRNPjJmK3u
 qvSEbCaW9v2kvcccK1rjbb8I95jlXpA==
X-Google-Smtp-Source: AGHT+IHIcJSA+sZ5YkVlcdsHN+ByV7uAw0uw7ICHs1SpliDayf+EBvgniFKg5tRE3lqF66k5Q/7j6w==
X-Received: by 2002:a05:6402:2105:b0:607:f431:33fb with SMTP id
 4fb4d7f45d1cf-60e52cb3f45mr1633817a12.3.1751440419561; 
 Wed, 02 Jul 2025 00:13:39 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c831ca445sm8709267a12.54.2025.07.02.00.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 00:13:38 -0700 (PDT)
Message-ID: <d9ab105e-20ad-4ee2-8655-2b89ed3910b8@linaro.org>
Date: Wed, 2 Jul 2025 09:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/68] accel/system: Add 'info accel' on human monitor
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-25-philmd@linaro.org> <878ql7rxxg.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878ql7rxxg.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 2/7/25 06:58, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> 'info accel' dispatches to the AccelOpsClass::get_stats()
>> and get_vcpu_stats() handlers.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Standard question for new HMP commands that don't wrap around QMP
> commands: why is the functionality not useful in QMP?

So far the sole use of this command is to prove the 'split accel'
works by using it in a test:
https://lore.kernel.org/qemu-devel/20250620172751.94231-43-philmd@linaro.org/

Is it worth overloading QAPI and its documentation, and overload
the QMP command set (even if prefixing with experimental / hidden 'x-')?

If so, I don't mind implementing yet another "embedded plain HMP string
to QMP command" in v4, or directly export each debug statistical value
via QAPI.

Regards,

Phil.

