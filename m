Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AEECFC274
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0chy-0002zU-Gs; Tue, 15 Oct 2024 04:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0chw-0002u7-53
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:15:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0cht-00038T-HP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:15:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43140cadeaaso2802225e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728980104; x=1729584904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEtOYcbYKu5I/zwpGbPz5dlzegutmAQrTDkuyibb+Lw=;
 b=ELgkIytYo7j/Ci1k05loTk4eE9CK8dejErrUFsEnOerWJs/U/DjwjaEVTeMZkOTWek
 vwMw8+P5R+TY128kkXDYdVMi1YlJyDV/1y1alI4bIrMC4BHfVlHkSI63Yny7pyNNeTs2
 e8GZZ13dJenBVQEMIsM+5o4RmT/2nUNkaP/RtKngSiFPtH7jiAyb5m+kyZYod9AkxysO
 wkZJ4y3XLfCVXUmXOK+AL3xjNl/W3hjLNvZPMhsSMFUrioJX4MoWx0POuehX2+aYOUck
 bO/T8GwF+1jglAmDAFUJpBUwb/OGNFGsM1n/65AiXRN4TmwzZk8uXRDNzlM7zL7SHr4y
 G7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728980104; x=1729584904;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tEtOYcbYKu5I/zwpGbPz5dlzegutmAQrTDkuyibb+Lw=;
 b=n19qdd/891hnud5RypUR0402yjQTtFKHhL1Yc1RrbkqQPnVEJUY90snj+W/mOnBpLz
 CVURLNy/c1bDEnSbpfZhbArjWuXbvRSWOQS0+FvGhlcsS9wQ1n+eFx4Zacr7w6kMwFap
 EwtIokLbluIRqlnVko9noc9SLBbA3YRHIn5B2kn/Trcq4vdQvMvRh9kIprgxOTYcNfgg
 iQ7TUSk3nM0yBAlaCmn3CR7jOnbk+F5pOUE8oodOO+lPQNcTu/f7wZt+NBZ/yofYj2Nf
 Hfcg8IjJejjb5qIu/D4JXulZ+FsFj9HwqmTRHAZq1uol0Xvn69Y60DhPCiEOIVQUfcAF
 yz7w==
X-Gm-Message-State: AOJu0Yy8/hK+QhRhKVINj74BWPxSMpSXbi7WD+pdgU2wxxV6GW8yCD7L
 lOv8NNLGWikJSX/uA70JyhXrdKjVnb64bJkOOp//oar+xbUAG6tPHAYAcpvW0vg=
X-Google-Smtp-Source: AGHT+IHWIYrV0EaWZnP2Bb0MRhRHJhScnO3Imml7invBO/FpmQ/TnXQH7CqYYT/DkuCcZiJ3ITMjbQ==
X-Received: by 2002:a05:600c:3555:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-4311df56158mr110398595e9.31.1728980103624; 
 Tue, 15 Oct 2024 01:15:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55e0b2sm10396615e9.4.2024.10.15.01.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 01:15:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 350575F753;
 Tue, 15 Oct 2024 09:15:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 2/3] target/i386: Use probe_access_full_mmu in
 ptw_translate
In-Reply-To: <20241013184733.1423747-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 13 Oct 2024 11:47:32 -0700")
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
 <20241013184733.1423747-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 15 Oct 2024 09:15:02 +0100
Message-ID: <87cyk1aik9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> The probe_access_full_mmu function was designed for this purpose,
> and does not report the memory operation event to plugins.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument mem=
ory ops")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

