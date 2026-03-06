Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72DBFCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfm-0005Ye-OM; Fri, 06 Mar 2026 10:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfa-0004rk-FS
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfX-0002qE-IJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:50 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso8924190d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809246; cv=none;
 d=google.com; s=arc-20240605;
 b=B3KZFXk6vAxZq5I58NIrIDt839ozYrkmfilyfREP5CQhWgHmtPuwByfDcH9JhZhRmB
 QFclwX7fj4xq5aQ6XDTkGY7+xlSweP3UDZqLga5xotrnP5dmWnUMG3RTpPn42mT055bG
 odLllD8sd7o2l4KVAg+QY8wj9hXMPPfhstJGqvxAnl3ATeCX5X01FS8lwUpe0UJV127T
 dh8kSdGnGViDHTBoX4rn9j5MJ19bmsusRta5PM7kr18i8n/DBzDHKClKc13bwQUYIaxw
 aJO8B4tJxbrRSKbzhKah+KV+d10xcrwaYB68oirkOWBi/ygjCskrxTAmVieHVEbEpzhW
 hf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2EwzNl/6u/5OzbC2YiJX0o8vZBFgqAwlgBCgjls9kjI=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=cKP92FgEDJzuf1RPP02ssS/gD8mlCSEeg9jt8j2ATawuZl62CA/kqe2mul4zkB5cut
 Y22sJ3HKRMxO7KI2oJr690E9qP73w30A1K+G2MGshP3LG1WMKtYivTx19/Xz76AKu9/u
 cqKuQVPcBm1UNui50pS4Ak3MVV1YeRF+cV0hPi7F4RZxIwfCxU6kpLAOA7Rzno85ppBg
 s+IuSzkBDrresJO7wWdupVVy9cWOnIRojXg5LK1bb1WaN9BkEdtAB6T2qGJRqAaEuwlN
 JxSWUL6r0lghZ1N06cSlVppwJVRdHhBEkeh+ltH7oVqpkYENUGVZnodYWOWLhj5YBnHt
 0nxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809246; x=1773414046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2EwzNl/6u/5OzbC2YiJX0o8vZBFgqAwlgBCgjls9kjI=;
 b=eD4fW1eBTeok8axNCrlHmlTt6MkrSFq7rjn9zshYHyeJtpPuCHR6oJLT/7ja2ymLEL
 yyl5ac74bcQV2F6r4J7WowIzhlxHK100Gbm0eKxnCMkhxOdL4Ohs3vcetBsV0AphSvf7
 mKZ5W0Hu770I9lqVw/5pBAfyGEDENMQDSI4kNE2E1aFjjTJQDSdacTFOqoCLOit14tyw
 C1+rSVq6kcuhWEXDUiws/VfHKrMjTDI1bysnmfq9f1ZQLPKb7yjRPUccis2f81zgVEBk
 qAMm/Extr4t7uabrpiBmmteTjMQoBgZdNsVOiyqrpLWHT9ad+rRVZtvmmB3jpkq+UuEA
 BNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809246; x=1773414046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EwzNl/6u/5OzbC2YiJX0o8vZBFgqAwlgBCgjls9kjI=;
 b=NuSl0BAIsyzCE0Fuv0hdet/pkMfTwiZ/JoA3sJYPsX91G9MFDauVB2GrGl0sf5jzYN
 WTHVnpe5Cis4AJbwLkOPcPpSnasSQnKn6KCK49DpnJShOSfOgSbSf2QKz0UcO3y5fLgd
 Mn6ZHOIxAsjjBJYkdxt7mp6jhrRMfWtKzzxd6ROFpGJ/fqmjGATXtcPpBgY+idNlP+A+
 GZN+YYZS3XRzhZX3HnyaqzQJ3gQ2Rap3WrUyn+KuUSyHhIIzxR79sdFtAANH4Z6RPQzy
 ZclvsaOGpuiAqFwD6/rt9T9RLHqDWT6sEMTVqeP/kRFOH9OVWtyAJiCRbKbRACk6BIhg
 Rqkw==
X-Gm-Message-State: AOJu0Yym9aHJyVhQ5oU/f8NvY1e/1XGRRjkrPydV4IDHdkeo98CpUu4S
 Yzg2TgKLrSJsq+M9rfO5T00vIQkQWB8EIzkRtda4jOpiWkXQtzR5XsP3Tt79vSDC/dpjsPI+5Iu
 iCkobH1C4uyKKsVmiGwxAK7OSqN9pITC6Je7C2MkTmg==
X-Gm-Gg: ATEYQzxbRt7HHfvwFkOgS+oScz7bbjnQFCnPojNWefjA5aAb6A6olnXfY6cPWvcCcoc
 RvAvePSL1d3NX3GvDpL0BYDbRD13CmBe80sJSWDDAMeCtiSR/eo6swgqNR0OvVxtwUJrHwKHS71
 XBMB/UegBIPko3WEDlgeHlkt+iLHGXq2R5E9MqkTAgnlUY/NS6u/P9qzDeN+3T8zCCMyNW3JXEr
 ZJN4lEdTQOilKNDfnDkoqnmJ4uF5Nfuqa+Eq6jkQL3xD0EdwZY0xvTXVlqq8k+Bs4rHN/Lg5IOa
 3EhxjBxwKyWb9HGL13RnzXet5K/mnUcaxoVCrdkipntv/ep3ry5UHYKwSB0G2FmMZZE=
X-Received: by 2002:a05:690e:444c:b0:64c:a3de:57c2 with SMTP id
 956f58d0204a3-64d14293c4dmr1732380d50.49.1772809244625; Fri, 06 Mar 2026
 07:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 15:00:32 +0000
X-Gm-Features: AaiRm53tYcTKiyf-o4WcGKaKPuev2d7VBnzek_NBngKFaXYYc4chboLw7Ax-1C0
Message-ID: <CAFEAcA_1iE2RKro_pAKMbVPjY7ic=tq_oCOEm7T=9MDa-rnN=Q@mail.gmail.com>
Subject: Re: [PULL 0/6] hw/virtio: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 5 Mar 2026 at 21:07, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:
>
>   Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-hw_virtio_single_binary-20260305
>
> for you to fetch changes up to 187adb4ac6493fdbe4404ef1e35b2629a9564d79:
>
>   hw/virtio/: make all compilation units common (2026-03-05 11:11:01 -0800)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2 0/6] hw/virtio/virtio-access.h: remove target specific code (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-1-philmd@linaro.org
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

