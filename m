Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32428C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUl1z-00065j-HJ; Tue, 30 Jan 2024 05:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUl1t-0005yH-6d
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:07:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUl1q-0003f3-So
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:07:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so17143355e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609260; x=1707214060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrBGU+qDa/6KJNKxM+pthgM0a/T7J2ZKOG1Ii2mKor8=;
 b=Q6lymYYutoxsT7jU67LF8MAOzjSEFHqZYsdXXpbsessVS/woRe+hPZFDbhaLmif5Ho
 h1lONmYXFdHOZ5ZXaKe6z3Ojl+OjaRd60uj09CthXuZYbWbx7EDtAR1OrHtG50q8r6c9
 0ynGQ/M8AkA07x31lO0A8QTjkGar+z4H7nhvdIgb02a8w7bn96abQ0IjNUH964Axk1ZE
 ELvoyOP/UP0oCmoDhhMFVB6v2rotxnpeAOXZNwyldJ74bnB3EfXadpdEPJ1zs7n7xuv+
 NcXqH9iFbrI9NB551QFAcpeVxpYGohKsGlp6UZGokYKJtCuXfBM78dhgTmHgek0NT6Zs
 PFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609260; x=1707214060;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xrBGU+qDa/6KJNKxM+pthgM0a/T7J2ZKOG1Ii2mKor8=;
 b=SRFmHKx2iSZvHfdJLsLb2nGp4ubpL9iqQnGecbiZ81WRIWHU0sCLafwSpqXz4qGjgv
 4zRJFCW+e1McH6CqGQwT8XskKIBW+wNBcQzxknQJlm0AhLDlB0DfL3TtdZ4odv9dSw4/
 Ec+aUVHqlW/POmszPyk2R+Z090nNwzCGKVAAKcgsKsM6nc9IEkpONDC5lZiKFOWyXwFF
 jTJRKslZ4wl0B2LycxzrWECVuJCeo+iRhjYbN/JOiQRxX29cxPkahBFgB1vd8FMDIi8U
 5F2eGDcGT3R24rr40o48Gsa+DiGrqp3BtlMKc8Lb+YPtDBESb4EcVDFEWQxpgd/7OI69
 I/rg==
X-Gm-Message-State: AOJu0YzZvdrZGrSQAZXcGcTeZbMpwzsJKViPW9Lk0cCQ1i6Mw/TIEDJZ
 FHfsutE3QJ+u94bq2eFAmLsaVzVh4fu+86AmqMfPkd8bnvE3wF8V03boX6sfYr8=
X-Google-Smtp-Source: AGHT+IES4a1D5D/9PcTpQY4/2BqtkiUs1Bf3okY6vJmhQUyyk2+tOC1WoIESqOxxrhdVtU+DIcQgzQ==
X-Received: by 2002:a05:600c:4f92:b0:40e:6650:b883 with SMTP id
 n18-20020a05600c4f9200b0040e6650b883mr6403716wmq.18.1706609260100; 
 Tue, 30 Jan 2024 02:07:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 je16-20020a05600c1f9000b0040ec66021a7sm12753644wmb.1.2024.01.30.02.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:07:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BEC85F9D3;
 Tue, 30 Jan 2024 10:07:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 peter.maydell@linaro.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,  Anthony Perard
 <anthony.perard@citrix.com>,  Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 6/6] hw/xen: convert stderr prints to error/warn reports
In-Reply-To: <42a8953553cf68e8bacada966f93af4fbce45919.1706544115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 29 Jan 2024 18:09:42 +0200")
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
 <42a8953553cf68e8bacada966f93af4fbce45919.1706544115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 10:07:39 +0000
Message-ID: <87zfwnp21g.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> According to the QEMU Coding Style document:
>
>> Do not use printf(), fprintf() or monitor_printf(). Instead, use
>> error_report() or error_vreport() from error-report.h. This ensures the
>> error is reported in the right place (current monitor or stderr), and in
>> a uniform format.
>> Use error_printf() & friends to print additional information.
>
> This commit changes fprintfs that report warnings and errors to the
> appropriate report functions.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

