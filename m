Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB9FCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYwV-0005Jj-5z; Fri, 19 Jun 2026 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYwM-0004wQ-8D
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:07:23 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYwK-0004Ee-Cc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:07:21 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66077e90382so2173511d50.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874438; cv=none;
 d=google.com; s=arc-20240605;
 b=LU13313be77dqSkKUa1ZX7K75WraiDilziFea0DhcwNFSZnbUZqeR8Hx22BnF4GtvU
 yh5r9RphaTOx4VCgMwjY7IodBqalz4Zsx52leL0+ydVxl5LB72T36kz4a2XkKNMFKgJE
 sOlVlmI+33oa/goFKlyas9a8jlAeQweNFYIs9JuZmeT8E8isMiwqg1oIXN9DavQAQHb4
 FVIFKnAk6z8RS/zK01d+fn8hKJzMWsVd/vPPklLuDAflWBgQJfaAOSsnpT/EWYIEO5Ll
 R4NndKFuAcISen0VgySP71WSyIiEK1SW4wcGgc/8gmtZsfOjAPu9OEIvU+r152YqkVYI
 tKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rFFKDju4GkbrwpYsMKyIDto5mDULKbew1mWJuXksimI=;
 fh=K2n7H9lWBPWZGFePCRPJmx6uuHtwfavWThxBnJsUDwg=;
 b=Rei1CGILsguQSh7hDu21GbZRQZGlZ14clx61/WFartRNfwOZWsi+/sZX1locG10/2a
 zMRD9hzmQSJFUyOOZmQ9MrYlCrDWMBTbGPVXkIR9m/x/hBRBNZu9mlD+u+vQ+E9FUiKH
 uxnikfWBquAUn5p/lyOZRHzS7vishg4CfaViW3ScT8HNSp08GQOzjGnpIHqHN2n4IWen
 QKWB3DtldADn3K2KvDLtlY/pTxn23T9RXTMK3rUSD/+jFHs+YoEEpBuaUCHIXvzCeK6Q
 zmf+6xSdEZObBp5pQlqNaP4G8Y2yNKMf3rAdzdMD5NDzmx4Izb76DNqpal3OsFosShwi
 JHEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874438; x=1782479238; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFFKDju4GkbrwpYsMKyIDto5mDULKbew1mWJuXksimI=;
 b=w0UfmMrSrJrQiszOyJBf7wqn3iHkIk4R2a47eqgumy3FpF5r2AnrSv+HOkzdGCTsGu
 C9i1D+4xplSQTQm1EH5aW2HoWU3MYMSa7hUy1zt4wPdqi1P5xPSnhXEAleXSRyAPTXOj
 Gr109dsikFTfnKsBjcwjidu8GoH9j4HyukThr+WfgTCibJnnf4dtlgs3pJ+xjpK9yr0b
 gIDoNtQ5Cur+CHxXFV6CYrmnjtYqcXg7ITpoIoxMliJYMRshLoDXk9CCHesa1Xc2NitD
 pntjgftJQ9CqEe0aG2DkvfjVU/ZSdLPoU/iRP8Q8GGJ4KGuLWDcDAouXBCOfKRQhyf6L
 Vwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874438; x=1782479238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rFFKDju4GkbrwpYsMKyIDto5mDULKbew1mWJuXksimI=;
 b=bEhy8ImRTc4kKRsD7GFbvd+pr18pC9PgDlFcleJuBqxjg8B86C3eU4Qcz3WJaJzCaQ
 LEz43mBhKnVA7TChzSwR32EvPbLI0F0TajNpYfp/OToI/mAgWvCbGNuMBA1Nh0M4L9E2
 jpVXDRWWx6sJwBOmRphhFiaRgLPZVJZS0Mhyz2FRFge/KIcSktBxxTtNFZr0X0dJnYhu
 JU12QXlNNUsX9NbQAEsh9+f1KVSYnV/O+GrVPQ9EHBjNPODhMEGIt/m2zU/n7OBIrgv7
 XRFQ/zdqDoUiXRUB7r53UQUD+uQhkpwhDcBI/PE1+JanXV0QTdsudfPuexW/EMGTyI87
 Nllg==
X-Gm-Message-State: AOJu0Yx/INUkSgu+DoiGza2DRyUuwndFn87ZbrBL2B/QMpoVPa06GUTh
 u55qt4GMRm14KpsWwMcrxlg9NLNfT8kVtZttWC65juwvhv3XbgMO6eV9+DmmbkgouLGbriT7LjZ
 tjw1NKH10wGq+VvgALquLXrfcIwzxPfJKv8ngUUmKOkUVbYkv+FyC
X-Gm-Gg: AfdE7ckoAmIJxDryuJIet+5h6kWNwcYTjYKdkGISJ7viimKCN2DwwZa2SUy0nWOdTTI
 vjv6x5nX9fEYokLgNiZAuUzG44Pi2etf3TVXI0I2IvOkYOdF5pk/l6iBWpEYntnFM0XCrGMxC/0
 1MtGkX7p9wTbXsxszex/m+SjRTyV59gqHdNZ9JYnLlF8j9kRS8rVK9D05V59B3uCff4JuqK0Fxn
 MQiQDpF+oCcsCztJ4wR2rFuSfy2wo6OprsXdnqrAcv9s7j32j4fzXNQJDqeAijsvwHRM2EljsKy
 xwK+5ZxvIVR+0OBNu1pXYRc9COAy9FTMESIM66qkdGnSNpVF2QT8Ky7t
X-Received: by 2002:a05:690e:4410:b0:660:3b18:57ea with SMTP id
 956f58d0204a3-662fc7b2f35mr2523557d50.1.1781874438190; Fri, 19 Jun 2026
 06:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260617161406.14705-1-163wangjack@gmail.com>
In-Reply-To: <20260617161406.14705-1-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:07:07 +0100
X-Gm-Features: AVVi8Cd19gW_Ptqpth0Sf-sYIXQ-4KXjfrcnnDk9wu7Kv-x9w7It7d8g-umcD0o
Message-ID: <CAFEAcA8RGC-1k5B_Ex_YHC+w3sV2hLtWTkimt6dSca_OpXfphQ@mail.gmail.com>
Subject: Re: [PATCH v5] hw/timer/imx_epit: Replace DPRINTF with trace events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org, 
 mjt@tls.msk.ru, laurent@vivier.eu, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 17 Jun 2026 at 17:14, jack wang <163wangjack@gmail.com> wrote:
>
> Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
> and DPRINTF macros, replacing them with modern QEMU trace events.
>
> This also removes an empty and meaningless DPRINTF("\n") in the
> imx_epit_realize function.
>
> Signed-off-by: jack wang <163wangjack@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---

Thanks for this patch; I've applied it to target-arm.next, and
it should get into upstream git within a week or so.

-- PMM

