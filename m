Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F784C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvW5-0003iX-3W; Fri, 01 Aug 2025 15:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtqO-0001ku-SK
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:03 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtqN-00070K-9W
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:00 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70a57a8ffc3so20686437b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070417; x=1754675217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ei8Toeq134xJtNgY9ICqJLDII3ZCsIUU/JmRrjmUlU=;
 b=YWE0z2j3wWrxOaONbdOuAoNInR3g2Xq9woE6ZXn/F9ovhsD7qVZOXUsBiaWlhy5TZL
 EwT5A8O4vxPEMxqNopfpEw9+DoMm6JT1V+2yQwbXzU4W2e42i6HqvPyXxnFRUCnnkuA4
 p3PzY6EvgW/8702hjEwh7BDZAo1ByUsSxsZA+owbamy0wdJFzYPLjkKYG8PuoRAh8spf
 dfhxvIzrLDIK93TwehXBAsUbvzBzAfNaNNaK5nvQ4HOG9GefYu6JfS7KYDO/0LcLd9p4
 XXsQCa4KiRYAozPW5fR7OwMPAxx1K82jnci/6AqfLGJQL+cuX7J6MvA3/0WYn1kc9V2i
 YpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070417; x=1754675217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ei8Toeq134xJtNgY9ICqJLDII3ZCsIUU/JmRrjmUlU=;
 b=YapQqRqy30bXno6VvUpOoeG1J8ZzNxx2nr2gB/ZMFQ9r9lxxxHLtY5arrS1nmnIonp
 AbSXmwHaXUKBYWsJBXrNZcGIJVpjFltfj0ek6SzdhubiB+ccRJAfzH5zLbOoc4rU+dpK
 EeKERywlMtRYo0RO1zd5qH7U88m26MzbUwB3SQGm/5s4PpG2t+79yl2Mm/X4A79YmuJx
 t5ND2vQsWJ50w/+emBkrkmffYhfLdWCx/IB8cxgU0pXNBLEZUvPH9y862vh6RiITUjdj
 GzYScxihn2Gn0Hrb/Z1iiXsneASbjORGutKVkAu4QEVCDOEVaZgG301tR/716SNTrKQl
 gG8g==
X-Gm-Message-State: AOJu0Yxlr4Y8qmWioyylXMB9luwwv+EIQJ38erNV+0BH9/vKGmzsLxjV
 xR4EvxnGfjhfQmfInKlDiIN+ZwyJqW4q++9ISiKzhFM/Y63vtNz4ikBpizcuccPmfE0slu1pteE
 G07Td5ckgUrKb4c5zVj1z5vaNn4BQPtMxf7XE4vTo2FlW4zR5r7ml
X-Gm-Gg: ASbGncvurRVvt/GPn6TRCCcWfL/3FkZ01bTIhEzNATMhaYkDSz6x27ymkoNUCNJE2aH
 xwZ4PaQiyr8/g+5+tJyfibKeckHnu96jAdxzIyF+jZIFfQVyu8aW+km7hO8npQQ8691ggoiLL9i
 tOXxo0vXRURtVaf09TAMp0BfnboC6lP+AFO0qDl91FKuYvykoHqyjQopyTIAzm/gQYzVh7Ed504
 1Zx1bt4
X-Google-Smtp-Source: AGHT+IG3dnlV5BPyOQ5Bh4f+zaHyerAY1PhDkUcT+xYB3rrF7IyRcDQgHTW7VBUUszTc/B/z0/NdoyY4DEePv/YThjg=
X-Received: by 2002:a05:690c:6891:b0:71b:6aa6:6031 with SMTP id
 00721157ae682-71b7f85e287mr6797987b3.37.1754070416945; Fri, 01 Aug 2025
 10:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-45-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:46:45 +0100
X-Gm-Features: Ac12FXw9jcHlCQW6_AQRD61HYc3-FN0OiotRnmXm9-ymbZR63hb2VLt2ctogk4s
Message-ID: <CAFEAcA9c+O+cp+H3GiYEw8nMscV=MhZOcEjN-15jzDnXbsS9+w@mail.gmail.com>
Subject: Re: [PATCH 44/89] linux-user/aarch64: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                     | 16 +---------------
>  linux-user/aarch64/target_coredump.c.inc | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
>  create mode 100644 linux-user/aarch64/target_coredump.c.inc
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

