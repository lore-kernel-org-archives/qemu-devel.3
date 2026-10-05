Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F302FCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfr1-0001To-3G; Mon, 05 Oct 2026 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfpj-0006D9-9p
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:22:11 -0400
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfph-0001SQ-KB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:22:11 -0400
Received: by mail-yx2-x0d.google.com with SMTP id
 00721157ae682-8aef5f85003so6504087b3.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791195728; cv=none;
 d=google.com; s=arc-20260327;
 b=s929F7I13H70dEs9SKbGG5OPZrnlarLyJTqVbDwX1utyS9gStohvfiJeAkMFdZVJ2f
 tV1sWscDNX+BiayZXqbBj9cmlYUebglyL4j4Cp4jlTeim+vmX5gUT77i73hOcLgeonFL
 zCqK+aHD1kIzKXE0ab7bsjTCaCiiL90rHLWFeeoq2XKf7CD941aO5gQF2ZPXxGJS7JE/
 b3XMP9tpE3Evvxtxqdd2htjXiO1r9y9b+ySJPUeX7n/0qp3blC9DVGShPYhvrOJbzD7c
 PZT6lxtCuqRMUF+3ebOuytUfkbUTYJQze3O9oSiGdrgQZmzsq8xsvcdSnJPwgzMrQsh2
 M5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sqWtUnPJUFRrz3Q7YgFC/UguLabWTP65yRRQnW0kLBI=;
 fh=fYbink0dv2K5JH7y7l0ooFc+Kby/5lHeieI3AgvMwzs=;
 b=OSgojuY7Uko3KW1glVKXk9qHlItQSn3nKpsnvnFOBxmGXzKDkZ4Ae0xAH2vLXrlvCc
 4erDiozb0k5LldArXniPgaC9haQmUC9qi2xZXi42Vx3CRDY8LuBrfyRkrkxsMMr6ZUq8
 2ocPi3YfoKSGwoWY9Jj1zmHBM28s4AX/jLKFLxMNaup/X7d2DYAHaMFeODSiFeMaS6Z1
 t2SNzplDFQzexcjdhGSvG5K/PcpAb3B+IEUy7p1+QzCX+RdQUusjrDTBrJhcji7/1PAD
 PgrEreYRklvaPYOAd7kSAkBvkb3iiR1UzJsZ4bCF2/ubAT5UMEE7XloMfS5z/2cRR1Kt
 TkMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791195728; x=1791800528; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sqWtUnPJUFRrz3Q7YgFC/UguLabWTP65yRRQnW0kLBI=;
 b=Gi801J2lhW/f9GWR44wTD1Ro8mMRbEFt6ZK5Obyy5V/qBNLb4SoDv4fy8+1fY2Jar/
 j+yOGzKSluacsnCditlbO1/+1eaAtY0U25pSHNDBFI/Xgbc1SJS3jANz735mz4JIFFqv
 m6UmCVERDT9N21RuU9MGXguOhfAZm3BkJYeRnD0Mm28jStH7Aost1EjBvUvgqk9liH1r
 6ngVBJH1g8lXYR8Ej8XZwXqPnn6Ua6jeQb4CS0wC9KJifJ7W3Y+mcjRkQv3q8ZbTIOYt
 b+xiZQf49b9KguKrIxJhq7cn8nSH0Cqg1vjey0LqzcNyNeO+r37M2xaMxnBJhFhO68mu
 fPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195728; x=1791800528;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sqWtUnPJUFRrz3Q7YgFC/UguLabWTP65yRRQnW0kLBI=;
 b=JTZlhum1DschR/86jTT5gGF4sMzZ85H7BdXTH9Ovq0D/ZzPGqunzTPB3VubzPMqAkF
 nFgNznhNIiPEaFSsJDA7eD/pyiMPRRYXLM5Oti4E8UV0GRIOxefLO3apwtqbLKFSzJ/z
 BPYl8IImSjIH/Hbj0SxCfAphul7MSRZ+5sMVgO3L7tNR2+qNODtozWS0+3tCKFLcmWma
 h0oxqyLK306OT9HS2cQC1eyGWv25qq6qtql3ZbYT5pqDeceYMlwb1bYq9zuOBu3kw7r7
 kCIeISufcAZ75jTpHl7NvQb19MSLu/eAHLrEt+v3MUcXH5CU8NEV0U2Ph5BhoOyhzjwr
 k5Ag==
X-Gm-Message-State: AFq9FYJGBMPlviRq2cKn4nc/SGcAz0jcfg54jZJCNYu1AjKqZCWm7GVX
 DcDye/ldf9B/XFnCVZp+Mrj1L/Cg8i6DuDeQtlE7IwebpjdgArQYGVuuMNk7/wPhUCeeTWhbe44
 cp8+EDfdszL+qZkAT4Q420zHZM5xWjKJNWS/J6g8Bfw==
X-Gm-Gg: AYBFou35BjMCUAj8BJ+jwcQKcYWoyqSOrbnlg6OlPR8tFuc/ZKEZwE26JOYVK8nkMBw
 d2HnCvawBpsoAHqUcVbPDBSQScIemVay5G230B+N4fJoadQP2M2WEX44qOXfTUxhumxEkwUD3rU
 xBX92f4nUW/ngoViOid8xger1HAPaBG1O6VlrNgfqtZMSRkG95AlhDICteYeKhRbsYRKYLo2pgN
 JpUQ+aBIQS2rR95/VYZkIP8E7scGVXSTFjlkQW9whbf0gu9u1dgeuNFKRDxfNlpP3C7zK+WH3Yj
 e8bisaZ6tHwgXFAV4BGfEhyGBn1betObPSIL/oEJ8K4Xb4Ez4hvtjdAgSyyHhyUnXuEMJ8/901V
 INikLj10XUE0V+iPcWYtyhLNo7cH6b1Iu61T8oEY=
X-Received: by 2002:a05:690c:e0d0:20b0:87d:b776:c659 with SMTP id
 00721157ae682-8ae392b69fbmr32255737b3.11.1791195728187; Mon, 05 Oct 2026
 03:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-3-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 11:21:56 +0100
X-Gm-Features: AclHuK82AhiTED4Taf48DHXN3-rU8axogLreps_k5XYFoTPGqJkm_1q9xHVTNTk
Message-ID: <CAFEAcA-agZs6r50+grUT22CFRKARwU9Ad9nPY7EOs_scN7aV+w@mail.gmail.com>
Subject: Re: [PATCH v3 02/31] hw/watchdog/wdt_imx2: Fix handling of write one
 once WCR bits
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0d.google.com
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

On Mon, 5 Oct 2026 at 11:18, Bernhard Beschow <shentey@gmail.com> wrote:
>
> In locked state, the WDE and WDT bits of the WCR register are one and
> need to be preserved when written. At the moment, the logic is reversed
> such that all but the locked bits are preserved in locked state. Fix
> that.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
> support")
> cc: qemu-stable
> Reported-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

