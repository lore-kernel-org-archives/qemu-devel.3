Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE35CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnWw-00076T-EY; Fri, 15 May 2026 04:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnWm-000730-48
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:04:12 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnWj-0001RU-Ct
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:04:11 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6530287803cso11121455d50.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832248; cv=none;
 d=google.com; s=arc-20240605;
 b=h8mZrC3nSuLrvqfvzCN+T8kffj6aZmMRWo0Io1yVshnNmFlmBhDYVnuPUVE5IqauCD
 8By/U0zwB2kakntzKNRxOkbJ0escr9fTPwi10VJss9nQoKPOBwhMphSsWuZKK7eU1m5m
 2bX0Jmgi1z7Df2ZGXOCaJBn83TblBb+LdzTfJkgQJ0iCSc/PpKI6yc5OaUozUmwRMS4Y
 3K4Howd+c01YO3gVPAue0YXD3YW+0pS2rRmMTZh1ROQJm1JhkpJgfWCjc/F/iODePSUd
 xLBjsin/a2/9m9msWxVrBVWJlvZ/AbmbtHVgoHJl11vbvYpqNGpLyiZ2lCV54cbnLjag
 rmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tAeko3QliCsjSnxHyD7hnmpxbGpB6r/G/Yu1W1e5c44=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=hJSbErqXVvd38e20ewyaBwehTR0r1noKrd1AQadzu2xP5SHcUKk9KDVZMzJYhCMe58
 +Ab7kwmUY5vuIWzS8YV5P9nI21ugM0BSrzknLQLnOBmAHdU1X2r01Vz41c/fZ8vnbS+J
 jD92WhXmLxpKYdtRdLOiteDxEBtHBtlXnA1SJXKlCA+NEjxTTIgZDLuYB1WMOYJcGb/2
 PCa+taK8UgnZVNsAmL6c2+8isW2wBV6QmecWNqFJMhfK9KntGrJ/m93atukMxtLQnIVb
 ogozjacKA5bNAP5I9/1LQd1Ac/9Um6HRD6bXkj0BVKW2pX6SRRg+ZDHjsA2MX7levGRr
 DmhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832248; x=1779437048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAeko3QliCsjSnxHyD7hnmpxbGpB6r/G/Yu1W1e5c44=;
 b=F/kkitSEfcS6TUYOodXhaEh1FqF0GYOKzWcGK0ommTw26h0NIrVW9Wug6SjoXoSvAI
 M4obzIg2HV/GSBCWoUx+AFMkIILgX6ouvohI9OU2RCILJssE+BrEVg8agvNEthzaok1K
 fG8CC291ymOZWIRiXClURNYVKzE2uO5WR5ONYGu09lgfj+GiUGDlFLtAOzS1OL3h+AcX
 gU9BhTT3lEEU3dMXaxT2t/R8ItXglX/nkU36+t4zBecclM9G+orW59WSb49qDNm4tPBC
 w4dC2z7gQR6LLkys+/wJg2sJdzpECYooEf68Afq+dDkAn2hcURqa5jEFSCIv6WYLW8a7
 /prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832248; x=1779437048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tAeko3QliCsjSnxHyD7hnmpxbGpB6r/G/Yu1W1e5c44=;
 b=bG8VFGH/1J69TLYtlpKHQPk9dp/ozBu308SoC4w9rGKv+VndJdi3LzuzvfdoWYZeZz
 b35HsL0prJnm3l6x+nujbuFXHiISH7guvPbaC0O98UOIt1FRQxgXYuaC4BylRtNpC6LV
 K6baI336NM1hN2DZMvqdg4h2YOJ0+eMUkm6qxQ6ymIfjO+Loc+EJlShuwQb4ZOqzbUF2
 tURNahVFRa6wYOqE7GoGGXxJQz5znqY2AajlLVB1P3Fkn1jbBI2xH0Tq+K4k+Q9xPAFz
 jis+PiuHaRgOo2WHF0x2Oq1hriFuh7haO1qQQQ8JfFWlynnXHqFgokgJa7nq+d8hNgII
 YIZg==
X-Gm-Message-State: AOJu0YyQ/t26ZGD65YxSyrxQtQf9kGFI6Bf0l/KMXy5rX8Y/YJYxnAKD
 DAf0WwkG4DNKP0fozrWycCsl3/yGlhz09NxT6a0BilDczxea/bH4ifom86PtoaziK033JM0Yzwz
 mTSYt+Eo9qCZ4Vgv/FXXgrgJBk7L8L9gcH5rZY7hRxw==
X-Gm-Gg: Acq92OHqFr6DQaXrZB5wMTXF+z54REUyDUzeeQ8Rr5TwEPdPuvXOhkM3Mi7quEwi9bC
 MebnVCJHuBZsJhMGvTzdyhgsUbqVEkoBkFMHmsqq6lKtc8X89D6lXgqaK0s5R4YFAPT8PaFAvRv
 Hc4LM9WVRUS3AdolgFaY6/ncq4WrTXCBHccYkLsjz2/0rwRKs6N+8qpsvB06Kr//XnUpW9/9sqT
 gCkH3+w3YSYKeJE4Bnqpbec/UJ1w10+wFg6tKzy3FyISbIMznT1y+58Y7TQbZa8LpoEZhEDOVuB
 O3hD1yC9IdrLOSk4K/douEySaAmS/8esNzWyQlDA6+gzzKXSlu8wnjyv+mkW25Mo+lA=
X-Received: by 2002:a53:d008:0:b0:65c:5329:788e with SMTP id
 956f58d0204a3-65e227bacc0mr2480805d50.32.1778832248002; Fri, 15 May 2026
 01:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-2-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-2-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:03:55 +0100
X-Gm-Features: AVHnY4Ke-tAGlteQHWfYiv4ZYE-rSsNmuu97DIvTD-XkmqgM9rJgTsCezHgFryo
Message-ID: <CAFEAcA92NRy1ePw2nHuGj7B4uzBOzGiPeMsAGjsF6viX+wQxnA@mail.gmail.com>
Subject: Re: [PATCH v6 01/15] hw/timer: Make frequency configurable
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The a9 global timer and arm mp timers rely on the PERIPHCLK as
> their clock source. The current implementation does not take
> that into account. That causes problems for applications assuming
> other frequencies than 1 GHz.
>
> We can now configure frequencies for the a9 global timer and
> arm mp timer. By allowing these values to be set according to
> the application's needs, we ensure that the timers behave
> consistently with the expected system configuration. The SoC
> configures the device correctly.
>
> Information can be found in the Zynq 7000 SoC Technical
> Reference Manual under Timers.
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

