Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3098C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvDi-0004sd-Gj; Fri, 01 Aug 2025 15:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtdZ-0005Bk-Iq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:33:50 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtdY-0004RU-4s
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:33:45 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e8fe55d4facso661450276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069623; x=1754674423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zF19Z8h+ExGMdknNF11FcTQIOL2ERglEh/QqVkXq7sk=;
 b=dPs+SGDZSFDCBEHQVYLZCMbPd2tvydIY7yX5qR04eK2XdF1nBzFCR8y/VG03ovaImj
 3fsu2aSkceJJK45G4uncc7798maJqcuczYzPrkfMtAdrLQdr1vdQlnKMrPbwtWcTAp3u
 uI0i80JwNtEDNaoDN1YCmmYW3z4F+sQDPTelVQkOaeAWElUKyRDr+G8KWHQ1zl4E1Q5w
 6zFGkiKmf0FFjc7rnborXFnZXRhIL3yWg1V1xjQuNTzWDDqjQr425lTrTiVLBKDsj3wD
 KtFk1nwP7+qk48ELGOebciS7CqDNMKhr3gWC1VzH02SpevGRYBWbdmz+o/NCdbeRUVDD
 rQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069623; x=1754674423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zF19Z8h+ExGMdknNF11FcTQIOL2ERglEh/QqVkXq7sk=;
 b=JUZN6TVzfoA/SddtTU+LywF1YzmcVV1W5m5QAWpQYEj3MmT/RxEi/86uP3+ooUcqqF
 a7WcczrV2SxIMRUI/lT33lfGl72KnowS14MEeyQLhLXSWuTOv3ltX5hxox0lBkA4gH0Y
 mOW8qGxM9SLtVgPxLifaE0FMvLTbTyur/nDBy33lz1PLJHI6VB4kXd4weIIz5mfYlGZa
 03Pzvg8tyO8LTvWHTBquY/ZniZPUAJJzs0XcsKxUtMNWef5h8ON/M42RTlhC1e3caI5p
 mAe1UGnfBq5M9m5AMY2PBUcd5oWQJvOP7pm9zvvOAXIG2iIcjSjz98X2s3WPFs4/RxwW
 FKXQ==
X-Gm-Message-State: AOJu0YwHW5MFqv92oriKqLI+Khq/E+h7RkohHxJCgGVKauaAeR4BwUy2
 yAYQGXzu/lC5W4kDLDEcJfi5RRbX+MzLjz5C1w4OrwjBt0nwhK3VrMcrs5mVoMTIAyC63KMiAoC
 KNp2ykeIytIKX71ytgRPrqcLxv2Augch3nFf7SPlOZw==
X-Gm-Gg: ASbGncuns0ml8UdCDsYPIE49tNaYLjmjwAvzCVOJ1WluoWiUu6wfU4WKNAnMdR0GUvy
 EOC3WHYjgKbKfGG0UDzqyx+p0DQe9ooiXmAvriHJiTRD3orRvoW6PgBXdyXI2bWgkuf6DC5WwkO
 +mMWtNjsYdFHZDgjHx20ppeXpajAnjMWZXb6VdHi3yCLpLM9TMFHc5MY9TSBTcGBj1VTmt1EGa+
 azzmcYR
X-Google-Smtp-Source: AGHT+IG0gu3yICDolnKBvNukGTKQAgXSSXNh2FDoVfaIY1pEAta4ijyBMkRgcb38PvMZXqJYjSTUHwwSGBXGepqcLeU=
X-Received: by 2002:a05:690c:708e:b0:712:d70b:45d5 with SMTP id
 00721157ae682-71b7f437748mr6491497b3.33.1754069622842; Fri, 01 Aug 2025
 10:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-38-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:33:31 +0100
X-Gm-Features: Ac12FXycFOiFsVKvQ19368RYBtASQOI1GSAC_MBU0CM16eMaL-rngIoeweFggj0
Message-ID: <CAFEAcA-oSiUHiCxY4v+qfOqU4ZVjjtm+MqE9bwDnzngNizemFw@mail.gmail.com>
Subject: Re: [PATCH 37/89] linux-user/hppa: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Wed, 30 Jul 2025 at 01:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

