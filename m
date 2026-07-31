Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA6C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprMr-0007r6-Ah; Fri, 31 Jul 2026 13:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprMp-0007oo-UD
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:49:55 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprMo-0008SK-HP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:49:55 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-667971437d6so1625486d50.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785520193; cv=none;
 d=google.com; s=arc-20260327;
 b=bx6vXURKgzh5qojYXsI3p1kqnQl0TFzNS/07HoH1DLiXcjacnwvLZv9fonTGHkeG3s
 s/6QTWAwZS1nEv5EEEEgy6ZffVAnAKQ2++C/LHqKaVzBX53fePhjDGtLP5gPZUWtyPYB
 FKsq/nNW+A0zBG+1uCBM0K+ZEVwRpv50QIpna7ImLIaJ0cv3XumrZFeSq3gVgpo+JY1Q
 JlIVNYkRGviHIh/IIfTJWIetsTmPtiEHKM+Cukuu0cYFTTBZrrpOZtAMFdnaahju3PyZ
 5eq6VOds04F7RMmFXFgy3zvNnzvIB8mHgq0MezTb5Ulk7I5fTaTyd675CySKP9v1v+Np
 A+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KAY7xaZof6hH24L7wXujUquBCBGGch5CCXJK4qBU+K0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XB5v2Gz4yapnxffhnJvHn0r3w6lKIJwAQP0n2OW48DxmoeHmIytiK7adOZU0iOaAkI
 ojJCqnbuKRTXMjE7yB2MOJ157UMfo3iXyBS7EbjbCp7Top0JaVdFggdYz2Y2mToJ49Ks
 ldNrbLoOrxs2+mrKQ3RyEGKhu119FbP2QAAdu5jpVvKmjEnncQJelR6utbBSHwxQ2ORg
 8Q2MlOTe8vGOWV7Riuo7mV6FtZ4mR1hIJMX1U3roYX/JeWNePjZ3z5cAYEq5JJB05HCn
 8q2oGlPJjmoREyfiKp+xX2VdxUIub+BKM1IQtz/SrMfZRDJbfR1B/2PtCfrn29kMwg6P
 9nig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785520193; x=1786124993; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KAY7xaZof6hH24L7wXujUquBCBGGch5CCXJK4qBU+K0=;
 b=Bth268t3MZOb/4wjHFxMMB3NHlId5ryRQMhWvbuaRqZljbvSuZNa1pr6Cm0lYC6CCa
 wb0f4WnSrH1NLFQbCikPcmCdB//GNfLruzT02tQ2Dnyx6HZ57dgEXj/D+85wusGug+Kj
 lJHph2r9/MLEX53Fdlqcg3rUkYWqrGjss2Ecp9RW8puOh24A0UBgf1yPGCBZpMIYXK0H
 yqgvMF+G8fL/Ts3FowujUF/9gg55/gTZlgdQpXMqMaAU7rTFxcRzG8tGeSi8cVCNi/3I
 6dxgED5i5MnahsT7Xfpc4tus9wFXzun4uwS+P1RrGRhVeaXC5xiPx53P31jspiddwI0j
 xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785520193; x=1786124993;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KAY7xaZof6hH24L7wXujUquBCBGGch5CCXJK4qBU+K0=;
 b=d0WeprFdKGwK1zNyHe0uWh1SSlMn/NcHS20lZ5LRlODS7hJwPENpLjzVA0DuqSAP6E
 zDLiEVlC3LIJXyhrwDZTbMUYnvug6zhiU0wwk0IVRoJEMM1Vz23ozUvOx6K6GDICou+x
 kDDa7E0qrl3ONn1uYxGzwWo3QnoqttBvronQdGXkHOlBo2eeV78YK/UDJRLotY+saj8V
 BCeaO1EFEIVzQxSn6I/TvHZkbCX7hrymoMcBt7Oc2c2eWPpIgYJEbhHQhzpg/DMWwrJk
 NCghpBx29Xuw8eaZa96lIq5mwshio/HgU6E50QU8SqR5J85AAg5IJOhnp/cFDmBJghxH
 k/6g==
X-Gm-Message-State: AOJu0YzgD3hSxOZekj5CA5quh2ga1+6d8EDELBF17WNhENzllwI3ZigI
 v2J2LnoYSYuTv+j7aCIdfYhKfDIX7/WIxayFeoAGn0XXoTxpgh2FigNw2oDsAYfvCqddSqWvKSQ
 X2VsqNdYBBYYawLOgSHcnzQpBs2LKmslz+mUfO3dOhc+hsyXIIh0k
X-Gm-Gg: AR+sD11NAXM8UuEv6UDvncvNFslaEOsf/j+bB3eFvmM9XahTQgLBooCH7ZhXphS4CzS
 D+rvB/hzK/22WmuIUVvw0aSrsJEkgvnECl5ZyUBACbpM4aMNlhksBqkBVwKTGL3AbqDEILpGYll
 S0KkKs/tQZGJNya1k17XgGzuhWHoWx35E3L+l5LccSrEK1ckp6J9olL8rwUlGVi3haca7E2N/oY
 FvJcJY3uIWOcxdD57SIUKxDdjZXSj/D2gtnGBw8i++TPiHau6xjB+Nx6/3sOgjA+LpS7dnxcxQZ
 7N5ai+NVZwcueDnesYZMzcumkir4mX3NihOjMJm6SC51JiJEqVDVUnKpYMDGsovlgtZB9WKy/Hb
 D0Y9KlBvSIQ3L9SGitoaa5qXZHS45
X-Received: by 2002:a53:c90c:0:b0:668:9567:db70 with SMTP id
 956f58d0204a3-6694f1db7e0mr869863d50.40.1785520193357; Fri, 31 Jul 2026
 10:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260724031123.76597-1-richard.henderson@linaro.org>
 <20260724031123.76597-7-richard.henderson@linaro.org>
In-Reply-To: <20260724031123.76597-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:49:41 +0100
X-Gm-Features: AUfX_mzKTaZ2MfzVyUe4FTJaxNyPXtUP6kSrImfLgw-LBuiOW7ePM4_zc4_gTOQ
Message-ID: <CAFEAcA8KUCzKjQ5+s4-Gtt4N79uyjzsMOWEsdeWAU6_WUmBq9Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] target/arm: Enable FEAT_IDTE3 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 24 Jul 2026 at 04:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

