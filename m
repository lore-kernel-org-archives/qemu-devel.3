Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4D7C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tZn-0008EG-Gy; Tue, 08 Sep 2026 07:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tZl-0008Dt-G1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:01:17 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tZj-0000xD-U2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:01:17 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-855a66e5b5dso33906737b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788865274; cv=none;
 d=google.com; s=arc-20260327;
 b=RAph5i55dwUO9473ttIFXoPVZrbuWFaIwGycwPqUQjcHS47deD5KnHczLx3qxP0YNz
 oGMN20xpMlOTzmXG0koJhjwPUIeLmTrmKm/1d7BT0ui2jnvmgm/9C98+GLHlmH+epOQi
 jZimAxs6rMXfHpE8os4EO7PLyFjk7hdJGUeastCDtmYTix1mjaS+NHKLp02oQQBeWXQJ
 0D9807I7fUdlcQfqZGVunPMuauUWwPs8r6MU0KuKNkuRS0sR3ySVtIKQTxp6qPKocK8V
 g4QNo65ICL9ap23sz7C+p4yw8uIW9hL0X1q8tYvK0wDOVLP/nbHdcDX9f8e6K8V96qGl
 s/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rLr3Ihk3i+ySxHKRTatouXFLAoY7mX1J9syBaxT0eGQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=VBz1WtBG+Fv+BtUs5cuV6GnyWvZbVALiHUByOHaLBLJ8r5ko7wMX8gcb2I4mj7GxYS
 Iw1Xgtu7ViLWV7V1zQU+Afx8+nFTv9rJPphoXLn58PIkQ6y8owoYPiAyNOejry30C6CK
 xy9LabBc0knrpCavkA4dtdcLT95ILym2hGfpbWHil/tE46qCDrN/KdAeGTdc8SMh4oyZ
 AIT2Xjf17Ui0qzk7c1BoLI2gvHuMOGOf+YnurS0SQOaxxSz/Hyp1809a0CBZcmbLmqHj
 F+/3jyKHVuZqQYDZ2yspIgEhjXedNOe34jnoJqzIPBGcmIch/Hkk7xZ4dTivrEru5+9f
 EDvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788865274; x=1789470074; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rLr3Ihk3i+ySxHKRTatouXFLAoY7mX1J9syBaxT0eGQ=;
 b=i/jcba2WK6DjjCBes52vAwfI8P2k8iMCY95Td+qUFaQzoX8SAslGtzFP2LGPh3M4fQ
 H/tWJLEdkZ+YQh6rx30SUlLFhEIhwTAbr0+YBemvDGoI8NUbdZLPNSSpvxYLMl/9iinL
 BBTzgKJvMwhdj0KAy4l1SiL8e/WB9C6rrJxeWE8MM+3dinZk9fFkxF/p7sBqRPzsNwXJ
 wqw9a9nk8QEFBoOd5VT2i4fLdogI5EQ1vUjqH6EG+8jyWQrWSA/v+uKtVqO3zPHPWbRP
 bLfCotXNvX8WJAbE2mi4tIrg7KGFtmB2M33EJKL+fkuHcVcLNs7ngnWqA1oAhe7Z97dD
 sa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788865274; x=1789470074;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rLr3Ihk3i+ySxHKRTatouXFLAoY7mX1J9syBaxT0eGQ=;
 b=VWMJq+fk2/I4oMGbQoxv1yXQH57X85rFtTYq6e+JFxYB+hw+R49qv5tBCyCQtk7FBP
 ikvi5g6Z2Re8yq4V9aCJNbJmuLuC6cvDPn/7GgpKBuZeQweWYGnjoKJHiBK9o025ic94
 6MAtBGcjlhrxJ8oxplUvO1caesm/mC7Oocw+tbi9yzhxFZmWKmh2q/q0Kuz9uH3MC/Pm
 FXMyFzDhEEWuyyMPrL9KIGUhdZgOCAck63kZ7BNkXp7ynoKRSlCgp583Rxt63bkd/BW4
 PZqFrfrVr/HemD993H2Ca4aCcyEDIZTHrAMQlzOR+d0kiPxXf4M/yvNnvthtWgg+dsy6
 /yUg==
X-Gm-Message-State: AFuF++kzq8s/QdEXrSLlUTZ5B+NaBLxxqLJhWmZ4QeU25s9NTk7WyRga
 CQmWyOHMJDJCZ1tgFizL6hQLM44sEm5W327UhIDZxS8AFOBmINLRMTuGY1O3ncVFRG6kYiP46t9
 R2gCurP9hP/KpQvhr9uL9EYQRsT+uEcsdnjSYADNE4g==
X-Gm-Gg: AYBFou3MGWJx7Y6tcX1L/FULkVXskE8lT5QBILZzD1+/i7Yofjh5BJ2eUcZfeccmqYn
 7EDCDDwxMY/wAIchgZU5Hb22PFMIB6+UAdP0+QS7Ack+SD7ukNURr/FZkS9gailv60EWjDsLEgR
 DmI7dIxJigt6sWcqwa/gchaBmhwrZJavCT3w+yQhkEC/9vrzepE+ZbgKLwopAQE1gGdQrmF7YI3
 C5ulb6vjBjwvGOvzqEGp9XQ9OMUGAbZ1WzveV8+cuM16n4OJpnzpJASQU45WrdNbE8SrB9oYisn
 T2yyKrRM9KF0Jvbisq5eCppRgr3MJ6mOpMkdRxcrAVqwKYrvQNI/otAN6M9FTJENLikaGkqXaxv
 LuaMQ0qxNpLb1cYcSDcS83DMGr/gcng==
X-Received: by 2002:a05:690c:e3e8:b0:870:f53:4ff5 with SMTP id
 00721157ae682-8712a7079e7mr113494967b3.23.1788865274290; Tue, 08 Sep 2026
 04:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-9-richard.henderson@linaro.org>
In-Reply-To: <20260828222639.1432046-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 12:01:02 +0100
X-Gm-Features: AcwNN1WuVVW98iJzwutdyBp3r899daI2gpcjaIX-AkuLv_2hRKl02JrojsbamfM
Message-ID: <CAFEAcA8h_8gD=7Z5y42ynmsLi0YDD5BNBHsQ8h2GobpqTydHmQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] target/arm: Clear PSTATE.UINJ when taking exceptions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 28 Aug 2026 at 23:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Clear UINJ when taking an exception.
> Clear UINJ when exception return is invalid.
>
> In both cases, perform the clear without feature check,
> since the bit is otherwise RES0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

