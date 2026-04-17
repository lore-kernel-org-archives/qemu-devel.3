Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE79F43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgGD-0007iO-4E; Fri, 17 Apr 2026 06:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDgGA-0007ht-5A
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:17:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDgG6-0001Y2-8l
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:17:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so5669905e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776421028; x=1777025828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1Au4VXp5HGXPE7mfkFPmEAGjjhqXU7oh6A12OK6f/o=;
 b=fDm/VjDNMjpvf5Ue7gf43NKb+kuV7uyiSgTDBlsntgfok6SqsXqnnNEZqMUcgtMLNI
 1EGrhOALEsuG9yXU5M/NREGOUddtw4iLPM7ABCCFjnLWROn9cfzDCo7d7syhc+iF4bAf
 R4MrJgULuOmYNHeOcmj2iKMQEkvsWbfYo+vL8SffyAjxg8186ejzwt2tofev7JGO1gd6
 Rl7PE0vov9LK6O8KujfDe0Xre2y4L94AtweFuSsAtNAD+XI2DfBZN+OFXXFOCCXjxcuc
 hz487p3V2w2FTll2f1Q/PLWWj6T5cTKxi6On1tm0p/6MTCBUEsqXjn2iKaUGbUBgAxF/
 F3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421028; x=1777025828;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a1Au4VXp5HGXPE7mfkFPmEAGjjhqXU7oh6A12OK6f/o=;
 b=O0pnSsyG1nUp+ZMkTcAo3ZJ5pPAxYkSw/RdK1fGZLmUMINBLf2F4g27JcBz4D/R8Kp
 u3s/OkDxyFTFXYnRGXL/vndbdFfnwM7HFWtqpiUV+8S/hw3fBo9xkbNYAWprYyXWIR+y
 YUjqzN9UtArNr+LR5Gd79X2wZdPiJD6GT12Tyl7R93FhWnaejXz5l+UPS67ZgZMvqkyi
 cYOCvO9jADAemyBh34V9egfnvUSzwSctWtDtJwuBkRwdkNAv2h4C8riY0Bc90T23MQwH
 7p5xpcB19oZ0JwvXZoLYhJr2q6z73Vg4TBW4N7e9BLXFRrglRlE2Q4Neinsl4QaVIOB5
 rS2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m71NeCnFdyzxKgcl/2BGPWDTNDRJSCgvOSI9rd7/NAx5zJ63son6+LYi6XXXIfxlCcfGZiuExu9kF@nongnu.org
X-Gm-Message-State: AOJu0YznyK0LHco3/GefuhH8jbCtPiB2WJonNURXD7sGZ3QfJ35xaNeV
 qAR1lM2VaPM7Wd4oBIDzpkBcs8HCyHzwhBw7iOXyDqFcmHhDofE408gRYaaYjs1qNzs=
X-Gm-Gg: AeBDieuZs6mCuX7XCqh7a9NQlrteE3tSYWpelT9SRMj4gwvqWQPcgImiaTLizU/RiDo
 6cCQWUpesHv4wLnLIaWUy4AcvjrRCKSbhrW2QghGibbXHaKkUDWf8BPm8dpnDFhK4ar9Q0LTJSp
 xM6fBH7xi1bwYH4ttiwrk3+z1EUeIe2jla6OXUihY/yEoDvqSHwkU0ucw/EIV2WA54faj2yH19D
 xhlIGChr60GQI8K7X8IHr78vd7VDcXaKaK6gFuSwpY3eczCnL7qhfKVcKhhTpX4r9Bi67MSf0El
 rJ1QtZF34mADIDemCWCguYhyG6C4IfKO5+hkCseSmK8tUVSO5/wq65gk7mx61J2pE0lufWngxdn
 LCqLgialYVJ0OXTNkKwP9nltSm9PfcEuGWtY18Ds2c/jW+3z7hOSHr3UM80j0koKJlHiiMMF8yW
 sZoWh6Mg+z+VQsN+VO2AdTAfp/cm1lHILJNw==
X-Received: by 2002:a05:600c:c09c:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-488fb88c647mr20342775e9.6.1776421027680; 
 Fri, 17 Apr 2026 03:17:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc16f784sm29200475e9.1.2026.04.17.03.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:17:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A04B5F94F;
 Fri, 17 Apr 2026 11:17:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>
Subject: Re: [PATCH] hw/arm, hw/ppc: Remove unnecessary audio.h includes
 from board code
In-Reply-To: <20260417093805.1076954-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 17 Apr 2026 10:38:05 +0100")
References: <20260417093805.1076954-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 11:17:06 +0100
Message-ID: <87fr4tsxgd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Some boards (mostly arm, but also ppc/prep) include audio.h, but they
> don't need anything from it.  Drop the unnecessary include lines.
>
> These seem to have been introduced with commits 2b16397264a8e,
> b8ab0303de, which added the machine-default audiodev handling, but as
> far as I can tell they were unecessary right from the start, as the
> machine_add_audiodev_property() function has always been in boards.h.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

