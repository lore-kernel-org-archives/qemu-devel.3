Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA792C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virPH-000401-OD; Thu, 22 Jan 2026 04:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1virPE-0003yw-CS
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:55:13 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1virPD-0002Cs-0I
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:55:12 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b872f1c31f1so103143766b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769075708; cv=none;
 d=google.com; s=arc-20240605;
 b=eCEIJ9gx8qKLnQwwxJ1Mf7ruw6SPg5gHFsqkiTWcMBtDh3hrT7cqP48kELQfQZwxVr
 6pHi6NRPRca6ksQ9wc93tgzdNNyKiQ/OuL6oVDR0JrFWyHtjQtkw6VsTmi8r01xeUrIu
 zquK4s7GgtOD0/MDIw1tG586K46phrHQip1kurwsnZgxrTIBgYewBvywqpWEwPDfHALF
 UBJPf5Oc62+0kdHDEo6d+YxWZRwLthZ1Kgk4tFPIxJGD04YE3AgPqs3t+L56O/ruXJqz
 CXNQLEZ70Zd/aHdrCNFe/UZy6WlxfdN7gHH2jjgIlTfj1HFFrZJOsBKL5faQ9Il/wNAc
 61XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cmfzJuPidM61aoDzzD6t34UXjmzOth5MQSi+I7BnTEM=;
 fh=WYTfeVTlXkWInFaTRpb0ctYEWZ6u1YwuD50fq9x5swA=;
 b=M622enmc4nWlIWT7RkSd9Q384CvX+PEst7HQ/zPiQtxGLAjJz7DD/NcbENLDK3x9RQ
 JSwAJSaHtYZ5SQBwur5hegyfR3fP+bF/zjMPgzDTJhJW8XYkpIjESQp7GqUJW0W0t6lh
 ZikbSQ9QN1u1+ixOg/erb+5RMZv8bDFagNYLmtqOm+O0xYtPiEsNOyuIIJXFsZ8T01Nz
 jtEr6f8RiwLlTiGIGCIjTz7QFP3pig30Yh/R6y7FKVlrNSEzLv0CcpY7IKyyoEfLM9B1
 VVBKHdWQs0RhUVD4KkEYHl66ygmOUBQgkBDM1NtmfANzhUXsxtUNhSzSRrRsFC3Bcrvu
 Y0kQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769075708; x=1769680508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmfzJuPidM61aoDzzD6t34UXjmzOth5MQSi+I7BnTEM=;
 b=SVfWIctGk0l1YfMPTMjn9fojwBaCb6yEICEMAS3HPoXGehJ/05IX7u2dcXKrn6q0mK
 7aT1S8F5toQMKVn95mwKqB158AJDFHZpcfYdaXwIcNSGrG1DKO4L/8fli8Wr9DVvO8QB
 xLnGIg+Y+qLOi3Ot6pL0QeqldH6vju1AzxKGkNcwds3dMmzxxL741tiYmXKjgmH11k8A
 TgDRM9BMi3C6IAK5YFzt6YPxiuR5oVVtC+hy7qoKLfAvoeUeMlyT5LCnRRhAyErQrFjp
 ca2HTn2t5NqnByg4k6GaXGQxnN59HW/IAlSgNrnGKG9uYXub8MSqr3ivK/gI+6pyqIA+
 YaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769075708; x=1769680508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmfzJuPidM61aoDzzD6t34UXjmzOth5MQSi+I7BnTEM=;
 b=Hue/xsc271AQulXyAylD/lebscehh+qOjwmEt/tFhrFsVhDQ/hS5M8JnTowJtb8hsD
 BtErAF6+0Ppi9YApLUv9jmiNXU6nRE1h+j+2hXhD0PohN4scAYkPvQZcLGdahM7F1ijP
 g+z/UccC/B8qSeGMbMdIogyOvsDi6QsvLIIaGeMgHaSd/8UviuBsujeR+MxajcEQFwhS
 CyHsehOAM5bCUV87uhYGkbU6UGO3s7HHees2/7YI1GCQGaeO2CGd02KCxRdIoimGlLgN
 wdd4VtNUZMA7FPzsWa4CGzU0Z6nWWxAFtkVnuK1djp4UEmaxjXmyp43X7Xe1h8LTjAnR
 mVng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWauLMtnJ8gYl0f189fnBishe4wkVJjdVOl/z+E/QTa4lJ3nogCxJyH2WqLoaS6/ywfrEw26CzvlLTp@nongnu.org
X-Gm-Message-State: AOJu0YxNbD29t9gEfDqctBkgNfpSzMnIfQZy1mE/Ootoj7FYiWzlM9Y6
 3wUNViaeinIY+qqRoLPpR+3ELKrwfv3MbKog5W6jfKw/uT8JtsC8Y1XKyoADHs7cGtfJtVk/Ggo
 DJaR42cDupjqsAuxXA8zY5RR52QwFhAM=
X-Gm-Gg: AZuq6aJdBpLaQPsBB9FCWZ4L1R+cxpIKq7LcxHeoKTf6/mu6HXhEXFRh0i8WYEIDUCt
 uDyXqCD3pm364SaNgV9P5N1UFPfH2H7fHq0mE4s5iRbLpRd63nVD4Z+Bgyp3bdvbY9A4HFaIroT
 i4BjNzX0uBNNUKzgivevuHLSeiUFoGg4CIVFt9dOLpJPzcqXR3TbtBRywplawUDPU4T4TtMx8z5
 7icgu0z5NTxK4zqwTk8mNR6PvYnrxwTCqZ8HVN29qGNVX0VY4pDLMvYZx+KwiAL20uYhoI=
X-Received: by 2002:a17:907:6e8c:b0:b87:3041:f1cf with SMTP id
 a640c23a62f3a-b880069e81bmr566757366b.49.1769075707728; Thu, 22 Jan 2026
 01:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-1-ab521777fa51@web.de>
 <aW-8L6f-CMu8iMHx@x1.local>
In-Reply-To: <aW-8L6f-CMu8iMHx@x1.local>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 22 Jan 2026 17:54:31 +0800
X-Gm-Features: AZwV_QhzfcfsVsY2KeZ34Mif1qsRckB26rz2tS3hIds0LF1IB1yYdHmULqtRBO0
Message-ID: <CAK3tnvK_sk6nT_hVnU4MXBW-mciw_bDbXAFB_O=ji-06WVZjpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jan 21, 2026 at 1:32=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Sat, Jan 17, 2026 at 03:09:08PM +0100, Lukas Straub wrote:
> > I am ready to maintain it.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> --
> Peter Xu
>

