Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D00C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzQO-0005Y6-81; Mon, 17 Aug 2026 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzQB-0005Vr-Qx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:38:48 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzQ9-0000QU-Uj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:38:43 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66c5101a984so2599638d50.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786981120; cv=none;
 d=google.com; s=arc-20260327;
 b=Sa8TYYDrH76tNH0gYGL70OxBoll5CEqtokYrIHAmb8ewftS1fp635+PwjNzsp0T7Rv
 W+TIvAzE/cPPp2WUxpaQN0IUOGMZ5RopKALLR2yRI2fyW6Yov7jipHbnkcbehBvWVxfv
 pZD2vRcTffG1yUx7p6VdKzAjx5KJVhaLyboydlXKcnerhSAmVjEYoUU9/5ZGUlRkGrvy
 8HvhVilGpo1cYkkDElrq6DOl5h3XRLm5V3rEmQRkp33TT3VI8aCMu23/FBNtKfBT6aqN
 sZVLpLzdvjuRrOb9i5ZUa6eeg391UW6bZFq/R18UOntemiYNHsl3EVEts7VDBHF9PGjK
 PgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dTGABPubG33espNLne7rRiXwrTKCCeyueuBOeukfXk4=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=SKJgZJ5axxC6TXANkvYpJxm7pQR9bGrzp0cmGS9rPpa/vP7u7pdC4Id0C5NmiwwdKo
 tjPwa/SnWAYAum2C+iCrN419GOzQo7LDfTcJ3ZLIiEYz1Fouf9CRCHmGS5732/HTbOLN
 p5y383EU7jO1HKDAmr7gnpCDNNaI64r+soKesyNRm+RUcOxY4+QgiktDA7J+GxeRweuc
 dFTS8vJdkf5BqBsvK70s+G95reC6daCj8ru/tNumn6m9mjn7J4GJkCimbX0/63GUjSy2
 rBUQ6SuPAZuvJwaPIfr7fqMeU7tMLbR/PH5LgPhJYO74CLd7PdyX43ivUAG6P+iJ8iJ+
 L3Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786981120; x=1787585920; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dTGABPubG33espNLne7rRiXwrTKCCeyueuBOeukfXk4=;
 b=UhR/LpbKq4xgmUxxjiAXRYn+ZvAXg3QRPaqBe5iscBtJ3qQ2thwMLfdJTmFUOw8j+U
 Mnr69Xz1MPC6ubRdazLNkZPJbxvZhmx/+ZLJWJSZ/pdXVXf7kmYPxc5LWm2Z1Mbk3jSi
 +rl33g8m2a8iI/qsqE/mFC6edDFlzYNcb/M/3/ierAxYunPMMQ+76tb/pixklaw3t7tx
 48bvTLiq17l2SOIFS0tqpyiuciZdHc0t1oI+5qO1GrkKsQf5mToE/4ZO3+NgsV98lHwW
 T92yw29plA/n+9kOZ19g5YP1QJ7Y43HXCvkqQ37e5IeyvmZQO75OVs3M9Pv6UTQiE1BN
 /s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981120; x=1787585920;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dTGABPubG33espNLne7rRiXwrTKCCeyueuBOeukfXk4=;
 b=qKEaq2zwMdYDWxtaWxUIYWjvD3/SbRNAxImo2Q7F223ueaFY0+pMJ3QSfTHE6pqW4t
 4B82L6j7f4Rq/qIYZzVoRzkPnHpw+xqTzWpdpAx9kQS+Zli9L17+mX/2vMWbqdH1wDRK
 X3151EXPLBKCngrXYLhlmEbW0366qDoYc6ZFuzIhfHMk8rqq1WsEUjicclhzEUQeA2it
 TPPO1qLy4kGTH4x9m++coJQshT9dVQfaP4ehU5+9ui/SbWJd+Mz74bcdLDET/2gh3tvk
 t1fkze1B7VOGtceWef/lN5GAOr8okTzcEGYY7D4yX3x4t14G03z5lJ6qBge13cAWGS1g
 /Tsg==
X-Gm-Message-State: AOJu0Ywk5qfkHHcEjIUca+lCUpx1Z2Ho3C/1utAqxS/kr/ZgqW4mavXl
 1pGvndKsfaX9CnbLWvfRfV6sV2cA1Szspk9EWPe9Qpph2/PyV85i/x+QJW73lz7+DbWSANfPySn
 gfpGGs3TM41IrAJ3k/9F9gr7SgTg8NDhmagWBJKQDBQ==
X-Gm-Gg: AR+sD13O20p3vQpxjfE8hOWdUZYED5890eI/QExXirLYVPckAgoodRPb80dhIXyk+Q4
 bxBe7Fe6nA1h4AbWDKvS1q3o/n4O+3NFD7aJSMvXPSxp3/B0pmEZ4vG25biZjAWpg9prL5/dAAD
 TjqCyVzjOT+T6NoW40RRA+FkGNW9j5zDjTukI5oo4ECwSHE48f4+K3Ax5XLk0czk1+9QEXyDcuC
 DhqBghqaxFmf5gQSBsFalK6T0dXkTDrPJE9TL7H9xqWR8c7db3D6Mu3W+7Irk9j1H+EOgRvvWtJ
 g0Xu+bFnQfC1++wVIP0PmBmRWXopY0nFArabM6SX7dQyrbqdh+8DD+sBRtncGwmOFtTeGFKc57D
 4oiH243u/EwCO0Ns6oEOdXss3B4+e
X-Received: by 2002:a05:690e:140e:b0:668:180c:bf6a with SMTP id
 956f58d0204a3-66c72d1fefbmr8150772d50.37.1786981119661; Mon, 17 Aug 2026
 08:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-7-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-7-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:38:27 +0100
X-Gm-Features: AcwNN1U_yGaInUv0xPhw5ad1BoLRurUWHJbZhBgwCoPcfCFkm3OBLNtDaLkO5JM
Message-ID: <CAFEAcA87J51jytkagf8-aqhc2Ac=xbjuEwBHY=y85fNSk6QSmA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] hw/misc/iotkit-secctl.c: use GNU C case ranges
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Replace case fall throughs with case ranges when register addresses
> are continous.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
> v1 -> v2
>         Make long case statemens consistent with other iotkit files

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

