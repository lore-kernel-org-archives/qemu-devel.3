Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E92C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vb0-00077n-Au; Tue, 08 Sep 2026 09:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3vay-000779-4O
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:10:40 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3vaw-00005x-IV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:10:39 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-861145fc841so36976797b3.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788873037; cv=none;
 d=google.com; s=arc-20260327;
 b=dgPoc9HRc8GLzNvttoEYsUvm7qvXxyF01lqsh9fgWX7iB7yhLN75vcWmsJwGuHEau9
 ToDcIM0WV8G4AIS0CU7AnaNBkekr+JOTex6bvWLzJgJQo/uAWw7F4hNOy3w0CCU8osmy
 c+Y6q5q8QGhlMcLuNTe3MzbnMnr16qeW6s++c4t0C0OdHr3kwNaAdjaEfmzQ0WpX13mp
 r7q6T3bWnZIoYMCnwpePWfzxjSt3YuUgoFPsqq6RdCEc3EUeG4C4fXvQB97Ce+CME2yV
 mlwDiWr1iUGdjpCBazkUPWRO6dpciTTITcwIpeG5BGjeATb1oqreG148dfogQeFbWRHa
 aliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jzq7JG1nyZnFATiQ44B2hcRJMT2iriPWKyEcqp4jvw4=;
 fh=gicmf1zLCz5mLo37/slHRwiGNwG9FuwwhzHTeCt9t94=;
 b=Tt+tP6EhITGq0drCyW1ht4DLfTgJ4iAYAWtV4S/E0tn99TGJr8/iHUwX/48BSlEI5G
 VnSyKkyjBunldARcX2des/oSsXp7Yp/gigEq50gzYQ84k6SgoMA0lP9hSHfsednXiTHc
 nW4DMvVxEl0qE3BUgOmZse99q0OUb9CAau81W2B9omql2xEsQjl1t/J3afVA0DPpZtdT
 V8vNa+/c1fpUStPe4NEdEen+D5sZAV+LhuG0Lpc+EwVzurbA4XKqdQQH+nsZZZVBIQlJ
 pLBuGfP8i5+JckhzKFFGkke06S2wl0m52/6a74Ju3INrRD+ibW/eowAKwqTrIpjsVSON
 Xb/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788873037; x=1789477837; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jzq7JG1nyZnFATiQ44B2hcRJMT2iriPWKyEcqp4jvw4=;
 b=ZFW7Z4rDGRjTbxTFHoZVHfy83RZljzNplRjxZ3lYyG9bVRIZYUDdK6/0wjSjy1y6Xp
 vjo1uzKP6i7AT8pBIQkNJJYnJy7Yu9KBgaaW9GX5hh0l124v5wWZT0PBL2OyFl49mhXS
 zt6zp8a1kdVK/mz7v5UCgO4lmcYbdla2iL+zXUaNSrkvnMP4ZY86GtIHGh+x58cfbi59
 lgeD5LvICYKPfFuGhIaiIFxd1LViaNJb23AYa3bVAdHmFZK+vBD7FBWKwsfTA7wklN2J
 8z+Tmtqj7O9fVAv4AceHvWV4KsHeARN6nltqgrrO2AIeGQR3etbEs7hv1uPUjI+5thji
 9q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788873037; x=1789477837;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jzq7JG1nyZnFATiQ44B2hcRJMT2iriPWKyEcqp4jvw4=;
 b=gnW1S5EN0JPZN/3H2xIKfuj3ZkJzLTF+tCHeGIY8vMRPDPTuUZRNrm2XRvWFtw+NvZ
 E6FICcLZnueYONLt/xYwe/pcj8Qut5WEl4WI5cflV/VrR1zcvoC+JMHM8j+veP5ZCqT9
 Q4VoPXhPPMVI3NVDxYTPkA9fqPuEuIOMp0eZ+9bTJz+lTmnNpI6u24lXN4sWz+lLP7jS
 WGFRAcmW5qjD8QGQh0O+E248sPlZdv6tNSd73/kYmt+f37SvxDb8W0l/+GrlgLPllFET
 HMl3Zi4yKllaOZT6HUM2LRnCRToVtV4pg6IcOvXVPTavBoTxeLNXcEBGZ9tgJKanr5Wk
 d/kw==
X-Gm-Message-State: AFuF++kFZ+AJ21h1tecsWdHKGRXAiDBnkx0D1xhtZmhsNF01co+hMq/1
 eUUN0yaZb0QjTE4pAm2Fn2ht53k00awLK5vc74+oi1jxsM7WpY5rk+pwi5GEhzsCxc7Lg2kyL8+
 /6vyNvhgvINrHTt/ZNcBYMclqnVvQDkuZ56/dJ+LBEA==
X-Gm-Gg: AYBFou3MCcx3J802mJuT+Dz+5wgusdWcNYKT2Svbk+s3OvifnTJ9ufeoRSBFQeeaOXO
 Yhd5vMOqqKPVI9jw8qKEBQkQTstDPxZ9LTO2fSuiSoJWava32by1x7hMZfnfT14RXNyuIIDBd/a
 P2P468l+a8ZP7WbqXEMrqxRC6tPiIcBQE1fseVgHFBiknurGbduYtHC7qt3T85DZC8P07Lk4ebj
 m3faRxVVsH5ai8TZLThX+0N+Ev2rBr7DVmlDVeZRINh1BCQu6P/xXVha6yxnNXod9OYIGweBo8/
 sa9PtDuG8zudb6HwMbmWyA4bqOaaVvhjVUb7e1LEuMRTAV77WLWlqWwgb12oTOgoy53nOdsb0O3
 oc6jlKI6k/mKZOcs4WB0iiyWERI4Z
X-Received: by 2002:a05:690c:89:b0:872:2d6c:9397 with SMTP id
 00721157ae682-8722d6c9c6amr103395627b3.18.1788873037004; Tue, 08 Sep 2026
 06:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-allwinner-gpio-v2-0-f0ebcb07302e@gmail.com>
 <20260829-allwinner-gpio-v2-2-f0ebcb07302e@gmail.com>
In-Reply-To: <20260829-allwinner-gpio-v2-2-f0ebcb07302e@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 14:10:25 +0100
X-Gm-Features: AcwNN1X5goXjpAWtx2LMNz0RMITNrR0m01e5mPYu2CcG7eVpxMLZMhZbY9rWzQQ
Message-ID: <CAFEAcA_xakujJSnsq=+PhLeWZPKVE=egfDa5xJwKMe9Jp8YyNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/arm: Add GPIO to Allwinner A10 model
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sat, 29 Aug 2026 at 13:56, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> The Allwinner A10 GPIO is added to the Allwinner A10
> description, so it is available when Cubieboard is emulated.
>
> Update the documentation for Cubieboard to indicate GPIO availability.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> ---
>  docs/system/arm/cubieboard.rst | 1 +
>  hw/arm/Kconfig                 | 1 +
>  hw/arm/allwinner-a10.c         | 8 ++++++++
>  include/hw/arm/allwinner-a10.h | 2 ++
>  4 files changed, 12 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

