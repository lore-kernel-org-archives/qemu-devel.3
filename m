Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F2BC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgOe-0005LE-Jj; Tue, 19 Mar 2024 16:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgOc-0005Kx-HF
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:49:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgOb-0003jz-1g
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:49:18 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56ba6e3c3e8so636016a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710881355; x=1711486155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLPTdxlzmER5M5Sc/XJz4f03vupPruuUGYQF9p+kgAU=;
 b=y0YLaXrTQVaGZnj0SM4CbBQ0gXjb5hh2SNpy5VzCxLwTRkX3u5nPqxM2twE2o3iLyb
 Jn5TShrquHuZZ7fvE8PM3Hemc3g8KtV3jniOLfe846Zn9yV594keU03bWQnC3IlFuBp7
 ekgFxk+tFGvANoYmRpJ+DeQou+Lcs6b63WfcLSLgArLdjp/BQ6s016FO75sGHztnL5Us
 EI6sLPndzpYvChNjF3cP50Yx7OLyYasymAXtEJ2olYV2hFmSdymG9eYXdB6ZbaMl3UGy
 eSkJ8ORjtpQfdFjET5UMHTwVD3DWilFlcRb5gcOPiYAOOV0XgsP93ReN0CYJ/8ZeDfy3
 zUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710881355; x=1711486155;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLPTdxlzmER5M5Sc/XJz4f03vupPruuUGYQF9p+kgAU=;
 b=unzqwJWDlxPKuQJNCZdYRpHS50PXF0iJFSMW8kd4HR+oLmzctaOeRvNpzrLRB8unHu
 1LCAIaJzXCLSjJntkb1YQJeyD9Uxv3nF29qYmOfUYdFisRaF9pwioUpRw+464hteAf3i
 t3Yp0wP2Rjd4LkLqMPbImVDJaqfyEaAQSeE5+dG3TTVSo/d+p3kF5tQD2/tiOWy25Zh0
 HeZr1Un4ARYv54Xj+o1w2D30zaP/tybsV8vywfgADfo64XEvf9CpzzuTcF9lS34PO6qm
 IG1fEFyQJQ6Cw1lzPG5haBJp1ihSAECgMfW1gGmIuQ4HvfL3QnuVPR0jWfaVSVqQvta8
 ncmQ==
X-Gm-Message-State: AOJu0Yy41uI8ZVUA+OvYljAOvRtYSIDc+DAig8ugKybao62SE7N/5dUP
 fPeQ76p9jCDgzUryqj2M+52uBK4UIID5WxAkVBe50pHUhAeCUfZfZYV+6hiL4+w=
X-Google-Smtp-Source: AGHT+IGW6eVzb6HIpt/JzpzM7kPH4XHTTuAJP8Nr8ILztaUO/6V/QV34ttaNr/dFDdKufuiPigIklw==
X-Received: by 2002:a05:6402:5414:b0:568:a438:3642 with SMTP id
 ev20-20020a056402541400b00568a4383642mr53287edb.2.1710881355000; 
 Tue, 19 Mar 2024 13:49:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e11-20020a50a68b000000b005667a11b951sm6429820edc.86.2024.03.19.13.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 13:49:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A22C5F785;
 Tue, 19 Mar 2024 20:49:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 12/24] savevm: Fix load_snapshot error path crash
In-Reply-To: <20240318154621.2361161-13-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:09 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-13-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 20:49:14 +0000
Message-ID: <87il1i2bhx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nicholas Piggin <npiggin@gmail.com> writes:

> An error path missed setting *errp, which can cause a NULL deref.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

