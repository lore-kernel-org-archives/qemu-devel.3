Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90DFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zDa-00021W-H5; Tue, 23 Sep 2025 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zDJ-0001tu-AY
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:21:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zD3-0002Hc-4x
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:21:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fae12so1866661f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758619273; x=1759224073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LaCcTWq7dqacN2WUtQbUOSwELaF/SeAUDWl8NSdL2lA=;
 b=kApYs3Oe9XaTvkYpaP/UnDRF5HPCVE3VCAqB0N1k9F5BAgQc546G3NBEwedyi48Ehs
 7+b6SloGYrKT7x/UYVhY74+Yq2rryMl/p+m+guhYSgtonUW5xfuUGYIoxheZXXPGwppn
 A2NyDhZdJtuFJDJaJKjPgdsaDzOikZPXW41qDOGsUlZ05/5SRxqTd6ASqJrjTb7V03jf
 RZLtY6MXM9KnkvpzX/N5kf4W42qh5GyDixXLyJsXRQI/fH0y+IcQbSvEq9kJin4rPVSw
 6D/yYfxgUmtM86h//cnwAFjA6NxSkMcmMF1Mnei/QHR2PKdzMJKeJb3+HDv73RreWpxF
 XG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619273; x=1759224073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaCcTWq7dqacN2WUtQbUOSwELaF/SeAUDWl8NSdL2lA=;
 b=bfgGdoFPyS1DFQvACZGRXdESJOuxGbXtLCR1E+y1KP8FUfxmPeIdHdi+qv1I7+HZWr
 oli5Xgp1WWFt7Vw7DVuzDvNDlPDLkkxrtRZMx4IMOQUfgotLraF0FxQowRus4DuTWDV4
 KUPIhpxS/T4FnZ6K/sWbA8o1gzL2rUpDfPbE9Sz5YsDsCHM1GlKZjN2qCkAVoecv11Z2
 mVHao4RN+bjzdlDSmuuWm8I5RiLDQ+aIPIn4nAPxLrECaCAgux0EWUpuAs4XHztf+OE3
 r9my48jBEZEwKWptD63j8CP+FveqA8HrvKXkF6cGm1ZZl01o0bUhy3tIF7h5nBolqAVG
 6ciQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVC/EUR5AGbtQ5ny0LS07k+OMzTFdboey1ODgnzrav2c1wzM7FvyWZSiO4iij4ZM1kl1v79ay9xeBD@nongnu.org
X-Gm-Message-State: AOJu0YwYMVMKQ2/fMPYwPamQf7loIyaLCZm8pmCTdsMkOcxt5CO0WU85
 zrh/mGc52CybMZMihBu42OlSXg75MHgHz1aFUJWjP0l/RO27dzNbqVBnbZVtI06DeIQ=
X-Gm-Gg: ASbGncsnQBjhNJ1VTTWYq1kkxW9/s5lJzOMrbuDlyAcRkSfj8HfKf41y1iJ5Nrx8SqU
 guAE6+5rEtt119ABV1bTdnUJkp1yBCozVcHLhW/5AEdlby4byy/DoSiyoyKiux9EySlR5dLCCXh
 kOAhV8NJd2hiV/Kqmu3ZLwD3sYtwKIEbLUSxM3pTzMR3PFTqMDUFvH0pWhvVcQJ8ht5U/01b64o
 YgiAAstOezpFelvqcaKGHneQHQbKD/FwmhNH6lt+pyTE6QgMNEq07tSejOTBSHn1h5BXJdCAQHo
 UXlPNO8LPR+89YJjg5/R6C5wZGNnRX8v1Psl4J2pu3VOgnFJjRrDUMJ13rJW+gXZRreBcMd7mZp
 oslwrc/+P/CIhkG5x63DhersynFgcaV0j7lzSwNpcisuwdcXRhQ66k/S4z4dDjd+gcUhHRjPEPO
 86
X-Google-Smtp-Source: AGHT+IG49Mi4M73XV5gPN5d6AXzhNqokc/d6PGcfdHlzwwrWQc0Gs+UEq2UAvFCGFDR9v7XtuEmr5w==
X-Received: by 2002:a05:6000:2385:b0:3ee:1368:a8e9 with SMTP id
 ffacd0b85a97d-405c46c22ddmr1414232f8f.17.1758619272883; 
 Tue, 23 Sep 2025 02:21:12 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139122cb5sm271596965e9.8.2025.09.23.02.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:21:12 -0700 (PDT)
Message-ID: <ac958743-7bf4-47c9-b386-3b3f70b69149@linaro.org>
Date: Tue, 23 Sep 2025 11:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] ui/dbus: Clean up dbus_update_gl_cb() error
 checking
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, vsementsov@yandex-team.ru
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-11-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923091000.3180122-11-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 23/9/25 11:09, Markus Armbruster wrote:
>  From GLib "Rules for use of GError":
> 
>      A GError* must be initialized to NULL before passing its address
>      to a function that can report errors.
> 
> dbus_update_gl_cb() seemingly violates this rule: it passes &err to
> qemu_dbus_display1_listener_call_update_dmabuf_finish() and to
> qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish()
> without clearing it in between.  Harmless, because the first call is
> guarded by #ifdef CONFIG_GBM, the second by #ifdef WIN32, and the two
> are mutually exclusive.  I think.
> 
> Clean this up to be obviously correct.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


