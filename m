Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388FCCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArGs-0002do-Hz; Mon, 20 Oct 2025 10:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArGO-0002QI-Bs
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:53:35 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArGI-0004fa-JE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:53:29 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7847f4265e3so20149537b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972004; x=1761576804; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nwGLomjMQMrKU6bWnrSP9A8/aZz5iNPKaiFUFnEYuK8=;
 b=ZEDFwkS51HSKDB286InYepIHWQMp+eXCiM8eTG4yiODHSwqW76n3wI2dJ27Y5dLqge
 3oVixD/cpo24TIiaHxj/eGWMTc47xVR4FSGpWo6Qa6oRs88EGUHyH6K0KYaQrnnXAvbx
 isxUNvGVI0Tdzb0mM+xFJj8JvcW6cP09MoGuZO5CSaT9Yxhi+Vyf5hRqAbNKHYOVGFrY
 4t/4ZGgNWfmkxvtFjR4kphuGmZSncGHOJaSvcRxbt79YJrflzDKSixvYJWI5y6+4FDrA
 ZVpSaJ+wUCp0m1rLyx7AVQci7LH8jCm3TTW80G+KcWah381DPz0uHf7u2j4ULqhk8XBY
 P/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972004; x=1761576804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nwGLomjMQMrKU6bWnrSP9A8/aZz5iNPKaiFUFnEYuK8=;
 b=F67SAygRAAA/eLrPyUbrNKLTLGJ1W6crmSrVklCScjsN1c0lwb0Sg4foASCw6TKH/M
 TLcZBpOEnox7mCrxpmGGV56fEq3lWSckEFB6Hs4jF2hhRM+olU59tOntV72i0n8137Qr
 y8zeupu/swNiUCJjP2BLn/OXU8fa70R8VD7mTOAlwuMOluBvWqa1JmrgpCHhZw9nuI6l
 hQYdceajXgbQb25Mt80zpbIiljRcQJ3AdSohUPHn9ugopu4dMqfgBv7jQUiGB0JWe77z
 unWRo+1DmY3IVpeIVZWAeL9P68UPpDIuu3v/ir+LByb/n2eAKexJsHJi/+GOJndZORQf
 xyCQ==
X-Gm-Message-State: AOJu0Yw+LEtjcrBKNHrUDF/PlBqJh7fcJvEd3OW71uz/xRKFy/t8O4Ey
 ZSz+agph2zQuvzhISiM56lZoc8c8bsNXmf+ByyA9e/EEFSBHRUmJDybNVEiVQNT+m7OHX2pfWyl
 qivIRNfJu/cL2f6/f3yOIVZspxZDlLCWzA1cOCgv9Qg==
X-Gm-Gg: ASbGncuq7A+8h+wdrAI9i5nmsxHHNpavYyCZ60SahEhSN/VVcT3xJJxjk+HWxM+c2nq
 n3b3RCRkMz2pT1Iyul9Lf0qzod77w417A550CVCp1LX2UT/F5nx+Gsbd4j36ulYfYLCNEpyBHAN
 pVpylcbf8oKZ7aodZyLETSKO/ftcEDa2VqDgF0QDnXg3Jh9vs/1j5aMgxTEHLvB+t2VG5QByRb0
 ueDnTu/ITOpcou2J0XJTqrDmkv1IVuAGLSxpbhopAYufgzbhhRIXhja+r0xrQ==
X-Google-Smtp-Source: AGHT+IFk7ru9DibFhHgu0PTmdqaEZ6lt7baHnNp6NeUOQDxIHYQUH5/PxQ35S5yAHE55lwkxtOVw9xYTi0pfW4KVQXE=
X-Received: by 2002:a05:690e:4294:10b0:63c:daf9:bf21 with SMTP id
 956f58d0204a3-63e1619a19cmr9992302d50.24.1760972004078; Mon, 20 Oct 2025
 07:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-36-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:53:11 +0100
X-Gm-Features: AS18NWDNRnszK8FOdccPhodhtdOZ1_TYFSc0g7pviMCx8ryZgsYtKgvSBanGg7w
Message-ID: <CAFEAcA-G0n-Qv5K5-=XP71oL2Bzk7TNE25-UAE-VXmgYRcaW-w@mail.gmail.com>
Subject: Re: [PATCH v2 35/37] target/arm: Implement TLBIP VA{L}E2{IS,OS}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
>  target/arm/tcg/tlb-insns.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

