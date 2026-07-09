Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2201EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whq3u-0002qK-Ek; Thu, 09 Jul 2026 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whq3s-0002pw-Eg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:49:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whq3r-0004bu-0H
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:49:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso15957885e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783608549; x=1784213349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VoNyHEYIAXEqgfwDn7AlHIfjdHqNnRKBCfNDFXXq6EQ=;
 b=v7s1LtUjS+pM2r9gQQ0Jxn7NM6eS9QrbwPg92NECakgLAgtecPtcnTAQXXCHHr0GJ5
 K2sODUz6eQhzEwEnvNGOVAJluO3iPkP2tZq/ClNbkejpADZ98E8PttuRQfbCBz0LoWvH
 Y+ifZgdxyWWBYpwzJes4HwpXsFyyBZYZ8Xy/PYhpBnv5ljvRreqAThbXmP1gc1vH2lYY
 RgQ8URaDHJ0RHbXdMT2RHyHHwGqY6/8GvS9doPXz+fMBnMP60n3/bZRwi5ZYF9blPTKv
 sze9t+KuUtUThec2P/OwbPU1Smlv2oP9hUJehXWJW0XvRVbbQaPn8ckc5PWDmjZW+ytQ
 qJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608549; x=1784213349;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VoNyHEYIAXEqgfwDn7AlHIfjdHqNnRKBCfNDFXXq6EQ=;
 b=HOQHDJZ9pjEQlw2RAcJPWNm3qZhHKtXdK7/YOsRRL/vyUfBfItKHTebz4ES19P1ADA
 +Gay//+XJRiAFlXtxBcfKlbKseNe9oZD1hYc6VidmS0Rf+TmGlG4h4emsipv2WROd3ko
 25FejotKfoCnoa4GUqbusgnH6u1ZJEdoOfWEbJSEMCcMbtHlNXSOvQxDfrsUiWLRMDrc
 QT2uf8UMAWvZrTEft29XNcNRpzBfpNrBFPW7D3Mw7OGUGb3W7pUCpR9ZmMZT1hpQbFXP
 TtY3FfVIlvhjZpFS4aGgGO0qsmFbSPG+89a5Y0X7cw8xkZMPtHHFGnu8hiLzVynZEZtf
 huoA==
X-Gm-Message-State: AOJu0YxzZ6biD/pxwEH+qmxsZk3nhFGLHy9ScS/qOFbIps3mSmGZMt4/
 UhS/hvsuegE23kEAhEmGsBrX4CTgtFZ1tCEF3A4m6T49G+LeY/EbylLBd/YJpvSv2Zs=
X-Gm-Gg: AfdE7cmnckrCCI5oIJeaShsnyxARXxmP5HZAtLZAKSF2M5TfgFihGaYWtiUxOFtuQfT
 49gd4XmOBbLsgbDRMAke3FLIoLTLOF7VmlIPLt7CrHLrvo/lBidlrHEE/s7V27mPvGCIRT7hnEO
 +saNWOyaEPTptnLoz7ZO7sv6autzohoDDc8vbaJx2RDjSjXyOQ9DB5tVvbRWUAGtOz9LWWms/AP
 i2kDF/iVNQ97FhfPpxGH+2nN5nE6gpkGo//gLWJ9D7nChsg0TtI7ie8FSf1Eg+S+xqLL7iX50NG
 g0DQ0XONJMJN55ThFncOF9cS3YzCAAzIo4n57WtV5xgrMp/M8gWSRls3odT0+tserm2qr+snPkX
 vqgRsMQGIPw0WfzI9NuMAkq8MTeEqio3SN5Za3+XCoqVAmK7RUwkf2g8Z1/1Dm9NtadXra0OJ3n
 YfNWBe+EsbaZ0i
X-Received: by 2002:a05:600c:4e11:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-493ee2bcc04mr24683235e9.35.1783608546706; 
 Thu, 09 Jul 2026 07:49:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb70a677sm62100535e9.8.2026.07.09.07.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:49:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AF6A5F82D;
 Thu, 09 Jul 2026 15:49:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 19/91] tests/tcg/meson.build: add wrapper record_replay
In-Reply-To: <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 6 Jul 2026 15:32:31 -0700")
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 15:49:04 +0100
Message-ID: <87jyr4rzfj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Runs a record and replay test, and make sure the output produced by
> both runs is the same.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

