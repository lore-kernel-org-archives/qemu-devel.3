Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A045DEDA685
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRPA-0008Vu-S8; Tue, 03 Mar 2026 10:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRP7-0008NN-QN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:11:23 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRP6-0004SY-FF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:11:21 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79827d28fc4so52137677b3.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550677; cv=none;
 d=google.com; s=arc-20240605;
 b=XEtnGigr8/7GJuDx7Hc4IeKWKpfLlWYZRdfTMmIPxfjs7h/j0+Dfc2dB66mviKL8cC
 cUjkmY12H+3tSsBYb6zinXvVMicdSk/UJrGoC2rzd6BdtsoZ0NlVUC7kQuGn3zgQwBZV
 1XCd+WpQDvmDEeebhmTGYs3mR7KnyPz9wN+nhm88rXV3zxzAVX81biCzRsnPmwVPuO0/
 i2cgv9UkrifNU0EnbjesxVxbCbsspeYHroZ9KSnGv0q6mFwUui7Z7WjdIbVnJFUOcdPH
 NPrka9Zgu7p86sxtJTDdavKt7gnxWlIORtBkKMt+zZrehBiUvCU84xQganPF+ZhBDQYu
 eTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nle2FLO5QO+OJp8DMg93RBHmiBQ5xMqtYMT81rPyudw=;
 fh=QePcMu7rYdgCPVUoerjehduXDNutrNUwXnWrL1mvWYQ=;
 b=CnadpIRq25rbYflWZh4KhDQM3qSt/UHWxlaB/sQ4qDFZDfKxMntjD/2VUYB0PRFpwA
 4veAQqnKowk/3dxzLVaU30GtjN5p3cSBpn8PWH5Thse9SrS68TbdYhunC0BqBp1Dhuqv
 Zo64dTqOqiR0vQtwWkfqj/IKB89f4r/xAVIXLZ35v8iOvcL3pCFk2Gyz0ceryO1pkDK6
 Q9gJ5x/cNJnJa5MhXJCCdQeU3HhbtqSORcld6CRv6zThJrvroyPb6LlvjGkuQNCbcpkA
 TTMK//GDqHAClz61jpwN3TUa0EHgYSs6aGWNjAH3QSX9k/PAXD/wvCk4M7ZPNBqXSAWW
 jiiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772550677; x=1773155477; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nle2FLO5QO+OJp8DMg93RBHmiBQ5xMqtYMT81rPyudw=;
 b=KjLWpL+Gv2wgoN0GyQr/RNYD3DJvm1ubEArgp03Fx8TH6C6v0CKIwsWAoOVLw9XagM
 lWXyvDKR+kUBzphhGVoKOawgZh0ZvGGwxyu1NoZV8L8QXl+H05aiVOKUhhZXY5FX33Og
 bV0xN9lPrarVHEyF1bGZ8rm8Dx2ctdu0JBy+AfFaNLa/9HL12IB8H5DZ4E45rm7qPVXV
 /OvQX+SFcuk/bWItQY+tvbpRQE9Dm7pQUXMtzMiPxIk06qaoBhR0DorhaEqvYkHa0JKS
 fGuS4WpKDycwtR5xCiOIQvlfsgrI2lzAPH7OIrQ7tQxBL5YfTqogvUr4O/FkeBIWYTK7
 iEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550677; x=1773155477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nle2FLO5QO+OJp8DMg93RBHmiBQ5xMqtYMT81rPyudw=;
 b=YGUb6ntEup/LPCH5jpO9aRlF5aUkU4qeH9bRSnzqW7OUnrCpF6J2DqKyn0s6nyxXF8
 C1RfiPZm3frkX0jC6k7YP0hFF9oVMR9gWevIijpRJKOmFt9JkEYC3WsHeLxKGlCI3zw5
 FgOBKmntB1A6NE8vHZ58+wQ8WtYwKIsCITPPIRNVkgFrmigWhSGGtiFXOmAVZHv0euS+
 sYU0EX62cGZlvCKdPUqYZvFXz2ioPfg9wcEg34Amoyq1/JtuB7Ow3/fAci8/Yk5T/3wK
 Sflab7CuPioFSnAtPDsyta0k8zn3+DpCf2rdSDIcH1j42/3vKoAibIY91EBw6Q5E5goO
 YHYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbw927N2zQgB2DnlELpMcEnOFP1KKkgye98XPboIw2LSxbmtWh1/5bZ2YbHzCim6Tex1yAXVdw/2mW@nongnu.org
X-Gm-Message-State: AOJu0YyNA6LkKWykzgEX4Q0LUeeP1ZcdAFl+l1DVdfgaG4PlR3wXxv1K
 lUfiwSuhbhbo7Jm6jnBRQZ4GtdpA4ql31VdI48LPRizPX2nD44NyyrS9CUNEU58ZhcK88Wu4hgd
 e//9/jIDX0XXJrIJY+cIvJ7oqm4HcqFIPbsvm9WCjuOzokLqRbjSN
X-Gm-Gg: ATEYQzy2UhGdAUnbkmtocl4Ecu7P7XMqyYQrmfUwkjm2q/SIXz1GgelFtYpXAydTAqX
 npD+xKjq8jTloajnQKI0/JrzlvplnDyaTmpAsj8OleEJnRkNS/uC5Fijqb6tRGvNPjWjJvyKM9Q
 6L3qPJdWIyGo7/by3sXtkibCXTzhffRsP4XyPXp4C7S4b1qkJAgYl/0mvgG4/YqBHu3oOmv2/lj
 nsRNzCb/RRePWEN6C5txLs4Zqzg4npArS+lh2hPdEUqC2OTcvTiXCmix2DuycKMsEFgsRIg3ByB
 iz9r9caa2Kpu0JUXU/qJ0sMzh49jZyuiK4ZjJNyXXaTjSiza9cloekqFFu1vGX9Mhl8=
X-Received: by 2002:a53:ecd5:0:b0:649:bbf4:121b with SMTP id
 956f58d0204a3-64cc201e459mr10769416d50.2.1772550677379; Tue, 03 Mar 2026
 07:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20260303143928.1747116-1-eric.auger@redhat.com>
 <20260303143928.1747116-7-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 15:11:06 +0000
X-Gm-Features: AaiRm51vq65CRQcdJKlm7jyFix0xSuaq8lAWEH7xJZvPzSjzPYE_-mUfYAEafAg
Message-ID: <CAFEAcA9BviMjiKKLRPWKgzFST2YeaijaGQvMPFYhfcqRwtM38w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] target/arm/machine: Trace all register mismatches
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 3 Mar 2026 at 14:39, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment, cpu_post_load() exists with error on the first

"exits"

> catch of unexpected register in the incoming stream. Let the code
> go further and trace all the issues before exiting.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/machine.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

