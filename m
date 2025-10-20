Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7686ACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApCr-0004t6-G9; Mon, 20 Oct 2025 08:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApCo-0004sd-4u
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:41:42 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApCl-0001Mb-S5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:41:41 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-73b4e3d0756so47874717b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760964098; x=1761568898; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PW65LhS1X6Ec177D/Y4bYc12+jOSUfnDfv/L8UlPQuo=;
 b=seB5eaMv/bl2+vMbpT6wBsUlYzQaZhltL/KGYarExRpjXswAOSOnqAyteXylsofdyX
 vx2TTfm6kvITyFeskuZrF9KBffaaW+d1kIboCUov6No405cbP37DtmvYdnIVbc8M119E
 zvC0SPd7Eh2qSyXvo68maFsH9OORW8FBLnMrQDgQdEOZgtL9O6+BY87NgNgPZHTnxxPm
 yANKPYR5tz7e2xidG9w9u6H5uhH+NaS0s65HIA+aODO3akS8pGN77s3x+0WtUvNr3/Hn
 XlCME6KsaAMozN+o+wxoVYovR7FsLbPouMcOuYdvx2PxuVz5PSK4x9g9nyikV+v35A34
 Tkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760964098; x=1761568898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PW65LhS1X6Ec177D/Y4bYc12+jOSUfnDfv/L8UlPQuo=;
 b=lFo70/mjvXrIqxcP+IqhJWwsIasIM40DX+Hpob0kV7x21zUgJRXbO65qoTaPGVOKd9
 cEkWXJeMf73lJDTgauzdYz7MTavWRFhZbLJrndGA/NJ5QYy2INFO2sPXcghtWJpE5CfG
 QzDcNav0GvQABtNH28j+1vPKgotbc7U6aAtERrJhUWHAvXZCJfM93dlp/NrRASdg+aF3
 5KpNc9c5o3xWycAcYVrCW3NQrra4uivc6gFEOrfTBVdwCWMh7Yl633tKJBMdXrsbDPCX
 7XAyRBAG1khaA5KLWywNxKeidD+s/V35C6K88jAPbeaAi7gqCrvYHD+KqDVg2BhmBhxY
 O6cA==
X-Gm-Message-State: AOJu0YwFFM4lmVZQqufzBrp1BeaUKzhnca4Iww+ny7owdBt2eWm9ZRT8
 mCAy8MmVrFTpCxK/T5wwbqoGSS4osvTBeJAFmH06IGVEzmTTnsR9FU52VC8GbveJXzqmuBaQfo+
 jAe+WrEj6Ym1domvlnT11aBXI/DYL7q686zyHONrk7Q==
X-Gm-Gg: ASbGnct6dlvQ2JaecY2MhalMlTXTjb4yHcNIhvEpblK0ntV6+u78ES3XBnanUk0bp1A
 DI5jFbmzNOZPz/mZN3sthy3JbcyTbPiDi2j+5geTjla7Mk4uFIsPGTExvgp6XqEcQIQKkYGm8yJ
 xYA8HAdq012DiyzHsv0vIZsaLUdZXLzh8jqr9OYQ/6yThCG/8Gu+K55bvPHXrU1T/EEV/j3PKmh
 UuAiryFo4KAkpmQ5M8iAAyMO53R9wtlDTZzH8QcHxJX/UUbeD1HhZRmg98aOg==
X-Google-Smtp-Source: AGHT+IGjb2wT4a9okBYL7Ycm/UGOZ4cT5cqiTpOitPQJ2SEAPOijQYiz9sUV8cTHYaOAfZ0AscQ57USyY/lVIqvIpRQ=
X-Received: by 2002:a05:690e:1483:b0:63e:2906:e7f7 with SMTP id
 956f58d0204a3-63e2906ef1fmr6269550d50.8.1760964098088; Mon, 20 Oct 2025
 05:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-16-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 13:41:26 +0100
X-Gm-Features: AS18NWDKNyW8_yAq6MvaNA8dVB5NJnzJfY17NelQWIMp1erE5nUpPb9mQU-jfvo
Message-ID: <CAFEAcA_c7xk51H5cwvYJa2vUKBT9NJMg2_qVSz3nAGXVYK1+3Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/37] migration: Add vmstate_info_int128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 14 Oct 2025 at 21:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/migration/vmstate.h |  1 +
>  migration/vmstate-types.c   | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

