Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8820C44533
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBG4-0003om-Tk; Tue, 21 Jul 2026 10:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmBG2-0003o2-Bh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:15:42 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmBG1-0005bj-1E
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:15:42 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so10844736a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784643339; cv=none;
 d=google.com; s=arc-20260327;
 b=dpOmGBVWKFCf3Ooc8OK89udLVFtY2uMR+EhkVUut+ANStwbp5M7Rd9XdSA4X2RtKZC
 gfgJ6YcQ8O/OWT8v8X4padLW196OdE3cJKYDu4DOoMuXWUNEQPw1HqRSiqTPgg7GJ26t
 FzPn85WupGOsH+phd/cON5Zt90M+OEiAqQzFVltVu8seSdbAslu241wR7IigCQv9kyvl
 wfSE0xNdI3qLvgCC5CgppDmIUMCvmULqW5Rapa78q6o0P8xPlxqBG36Xh8CBzIDkQwwa
 LC3m3G/E3MhOSx/M7Qc5afYkmu6dQ22PJfcQXlQKDlRdNbsGUN9XJt1hXsRad+abxBze
 Qh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=100Z00vDmtwxa5ab4JZ8kSceEYy2ju4u+hp1NtZNopY=;
 fh=YoLpMh5YadSd1SUFRuzOwiR+EAmVcwfqZdaYDd98lIk=;
 b=kdaSIUXAojFa59D+Fvqrwissitm3g+jfRccXJEtW1H0H6lye+R37cP2AmJH8bAej9s
 /ZNx4jS52sTaVtumnf4J5+R6mG/5l6hoPv4JD2sr4hC5xIugsQoWPuYObSn+r1QjHkAF
 dYMJHuTngYFTEGlj3thXTQR3uDSO09V0/WnZEpq5JwnxgSPkKnf5aIdJwJe2CPSzh/4Z
 OccwxjL9/dG5nYxEjmaJ6EeqfmkugSKLwARDdQ6toaUgCWS6Hc2N7iJJGG9dHTSXzRm3
 KJ6Vy0GUTKCQtKPL5fVO7ba9RWRVd/hNgwSrEBH68ALpYnNiKJu4c69Dglg9vue6Uhau
 8xvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784643339; x=1785248139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=100Z00vDmtwxa5ab4JZ8kSceEYy2ju4u+hp1NtZNopY=;
 b=oSYV3HKIRbyKTOwIxzyiAXBACGzPXelHybI87viqRfZbDg4/Lrawn2y+FGSHb0YEm5
 g55TfrZ4/7Q9mZxj9KCyIMUC3k+jiFe9Ld/5bVlF8T38mnPaihx7vSyzL5Q9ibYXcSmc
 rxrInpJrJhNbSmMa/7ktvakMZ8ac77ku6TPxENbPkK0qNlWey37x3PHu20W06/YJDRW6
 CoSKUjqBM8Iqj1xjLwa2OtekrwdTywTMobR/WEiVOJgNWHTTxQHvNj90kxGoTldVmOQy
 +db9fZDW1CYksgKDh1Cld/BJzCj90XHZ8y5Gu+39oLtxhBI+sNKOi1uXJUtwmr6VTc1h
 1pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784643339; x=1785248139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=100Z00vDmtwxa5ab4JZ8kSceEYy2ju4u+hp1NtZNopY=;
 b=nEO3ddDn/jcYlMi1LjsL//+PcNqDnG7dBqqcaUhF5FkdaopDsYY2ZtNoyQMHBO/64x
 a5ItmbrwHQ4zQ+GfTJs4nJj09SwFvRMhfMvYg/+ukdKysReNxT4AguAayw7dwPLnehRd
 ci7tQCMq3BymZz8nIPY3euWhgtteFE33ujEAqEAa7W87YIfHeHK0yLBElf0nGLkUqcpm
 oFE3ulJFtOn9ts4to5q3iskA9IL8+YMdJGWnSulmzLgJ3QyuXqDJSzIhA2lfSlLoYj4D
 0hV71jsMmvhWYv4kret1NolFe1+mY16OT2UKONLv3zMDaSqv3iMd6cJrjIj5Pfi8rq7B
 +5/Q==
X-Gm-Message-State: AOJu0YwBvyJh+xYIXgkMpXWMZJul/2qJaVJrBM9C2LekNWcltwCYkc8d
 01Ecu1u4k1GztVDsJPid7gztRjfNAA2Qjd1hfBUiZrVKP0uyDdyC5wUXtaEW9mpcbsPml5yZ8xS
 jDNQa1WsO8cGaKW5yHqewHqtfDDEwsqI=
X-Gm-Gg: AR+sD11V7My4iAqZZEjNuvZ3vb70Oat9d1A8REUqsulOB8cNO5YEHI61k/EGD1aJlc6
 jYVBFJ9MJFCA6Qi96wf1y2W2QtUuUN38egTM6IoHSBuJTFxeZYRoERvW8rTqzIGe7qRppDmCGiR
 sq2pgVEOoyx7ghTULwmc1rSd4p9ZMZnDuTmGQaAQcuo0Nr71wie7JWZm9MR1QVrTys4lRGGpYmX
 39qKyinqx47EK8xvTEiGocU5I9FpqlLpb3ICPoQDgJSZOVfRE9CltJB4A/DZb72rQZ/Uatnn+sc
 HQyORFwYIuPTvmQHVYYd
X-Received: by 2002:a17:90b:3ccd:b0:38e:11ba:992e with SMTP id
 98e67ed59e1d1-38e4b57dd07mr18400948a91.35.1784643339150; Tue, 21 Jul 2026
 07:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260720180459.2542918-1-alex.bennee@linaro.org>
In-Reply-To: <20260720180459.2542918-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 21 Jul 2026 10:15:24 -0400
X-Gm-Features: AUfX_myQ-ec4gzi5PnSUJxLMeFE0Y6tqbuQ6qwQTpw3zuJwUmdJYgdFcUtEWy2Y
Message-ID: <CAJSP0QXzpQpUXZ1gzWUauO-AWw=FAxKDtpGfLt35x7tR38BHzw@mail.gmail.com>
Subject: Re: [PATCH v2] gitlab: remove gdb from MacOS jobs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jul 20, 2026 at 2:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> The gdb jobs fail on CI and although I can't replicate locally on the
> machine I have access to it definitely fixes it for the gitlab CI
> machines.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Merged, thanks!

Stefan

