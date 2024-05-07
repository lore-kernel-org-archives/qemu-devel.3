Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05836C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NDo-0003uk-Hu; Tue, 07 May 2024 11:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s4NDk-0003r2-RK
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:59:13 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s4NDj-0007Vm-1C
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:59:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a599c55055dso803044666b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715097548; x=1715702348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SgCZTEeTBOoi/SPD8Wfc5lhOnVR8z97PtohI89xYftg=;
 b=xxIOYHbXBIbkyC9a8+Epc3tp5lWZ1DGnLoERm0S4VVe5lk8wZIk51p3FNI5F8C+oSq
 mH3VQWrKdyZjEAiXPJ0LGwk3pWsvNnQNRCICXBs2n9fNEh7LziyeOIDdA5Q4aVmOsMS9
 H1hUS08Z4FWZrwrhShMW+cVTwPRLYwXblZoXkqjPGLPsNom4cu3p/zTWOLgG8Mp+diRp
 GgIo/dd2Hh1dzOfqQHD7q/EYigOF46u7MW6AFFg3AvUw9wJZfNTtBilvzI923oDDo3So
 tvCmykzj62yqqAGlCdTiVDCej2oeAHFs0oepCgAEi47G4FbOwhDbyv5TEGQ0LstyAdSp
 BurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715097548; x=1715702348;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgCZTEeTBOoi/SPD8Wfc5lhOnVR8z97PtohI89xYftg=;
 b=epd0mNCGfYAUr96LURuVx64tQ5b5zyjKDq7uPyzAU4G0S9dy7G1FitqBbFri0g0H05
 TmEqFRu78kufyVTVk2VQXocGdPJdVor60i5IawQvl1PlPrRjJyjspzsETvYe+1f4riAC
 qgGw/WJ2qpDUxmoYQQZmlQcdgccf+j0FFuL0MNvNtzpUworMzy9FAiKGVmlkEQ5pR3Am
 OR0+LQbZVdx/2SKBNTo5be7WC0udzKmadhCjL6Z2exoRbEjjtVFxceZFMEQ8FOjL45xN
 l6m8olbfN3zZly3HGPlkb+kxBTGW9/15r9uRsgVOASPybJfhc8VmAsxH1H5MNe5BeC14
 IUjA==
X-Gm-Message-State: AOJu0Yx4smnwa6hBX7fFOIM26JCs+ZrIZNaE7VbFxfbBME6mpHT0x0ti
 Ku2rajK8W65LaUekL5TLsVZcLWcZmW1EgogohBBIOaanHoKsRJdjvRA9OtMZuXhLEucPCNljxZy
 c
X-Google-Smtp-Source: AGHT+IHhlNtRgVEzWHIfVmNnHMLzPlHxYwgkIROQalCFpxJPwYABrimdJ28aVTYOytD4gKQhw4qEkw==
X-Received: by 2002:a50:8ad5:0:b0:56c:d47:e403 with SMTP id
 4fb4d7f45d1cf-5731da69886mr89276a12.28.1715097547588; 
 Tue, 07 May 2024 08:59:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w3-20020aa7dcc3000000b0057204902580sm6455725edu.48.2024.05.07.08.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 08:59:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DFD35F87D;
 Tue,  7 May 2024 16:59:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] sh4: select correct components for no-board build
In-Reply-To: <20240507145138.270825-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 7 May 2024 16:51:38 +0200")
References: <20240507145138.270825-1-pbonzini@redhat.com>
Date: Tue, 07 May 2024 16:59:05 +0100
Message-ID: <878r0lhauu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

