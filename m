Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FEEC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZ8A-0006jW-Of; Thu, 15 Feb 2024 05:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raZ88-0006iV-FX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:38:12 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raZ86-0004MU-OI
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:38:11 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso1109694a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707993489; x=1708598289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAgLWWhpsYnuKcbs+qV32uEp/+I9i315cGj5ltW31Zc=;
 b=ySFL6RI6QnncEGvfkC/IQmSsvdsSGZm+5aqq++TNl6Niq/gwmXUZhBt5IRShCGMVOJ
 f97cDZwNZJ7PBDXcDTB7w6a1JdoZo42Xk6PdnF8TJVhpKJGmb0xmEG++Wq3IZzFlpeGU
 A6GSyi+TY8N4GMgyYZ0nTk5iV0+/WIb0atpo6XKp/gaOIpxdCAF0tdK76AZM2ziePc5e
 4r7OWyLPXlMzzWMfhgaYKYe8dUpEBIcwXAekeE25Ds8UPw5JHqITZnv8RHAQXiu9ipAN
 vA1ntCoR6Sj3EXMq+XzFaC0X8Dn6+Z0f2cl6QMmZ0SEJ8ykcdGLDQEtz3HeMYE9JkbdU
 KKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707993489; x=1708598289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAgLWWhpsYnuKcbs+qV32uEp/+I9i315cGj5ltW31Zc=;
 b=IvDGdvAD2BbvPyCfzqc1Fad98CGsRHg2YWkTm6M+VpJDgWVIQNVfrJW9Yu+AA3dya8
 weN+uhKf7itHWLavpIvWnnePT6lFbIMv7RLoHDLbTAJGgLx84CUdISRh297OHIL2rles
 jk+4uinBVCpU15h3nrwtcv2xdLpCRNpPTE/UFVLYcjUlcM/JSSM+fuqSZy0BByETGYBy
 h36n2HKwj0GsQA7qHQIEfLqLyIPxgz8loXNseGcrriNNCrrzLz5+x2kK2GeP0Q4MytDf
 KDgsGd1cpNJskdDRJhMDQ3vzMrVautFxaq++Wh9T9P7d7omyFasFBlDryvqlcADBsDd0
 UP/A==
X-Gm-Message-State: AOJu0Yxgg/ptFrk/XVKhogyAE+MuyABPa5LzYu3E9TtgP5g8HJyXSwTJ
 hI5rMOR69Akf08X/VeHC9VtopFvZbRuOvHbaTCzJ2t/l1Wf1I2Ai+cXLAlwDixGbPwEHOn52/gj
 5jATILYNtQj5fmndylSKBjxBR5RdQnaOwBb3mKzrY3DSxm6EL
X-Google-Smtp-Source: AGHT+IGuZLN3ynu/eR2qMLnqgbf8EBBm3Q3I5G9nBLIVKxfwwelYQEu/d4dSUbkQ1Wb6KpPsJXQnHJxJrUBVYFUaGyM=
X-Received: by 2002:a05:6402:148d:b0:561:dd88:efde with SMTP id
 e13-20020a056402148d00b00561dd88efdemr1079519edv.27.1707993489235; Thu, 15
 Feb 2024 02:38:09 -0800 (PST)
MIME-Version: 1.0
References: <tencent_29796A8EF3E655396E27566AC5CE1103A509@qq.com>
In-Reply-To: <tencent_29796A8EF3E655396E27566AC5CE1103A509@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 10:37:57 +0000
Message-ID: <CAFEAcA8grC+Mi9LcNPPXqJUCVNp1a6PcEWX0nUDsOe14ARgwbw@mail.gmail.com>
Subject: Re: Assessment of the difficulty in porting CPU architecture for qemu
To: =?UTF-8?B?5pa5?= <1584389042@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 17 Nov 2023 at 07:35, =E6=96=B9 <1584389042@qq.com> wrote:
>
>  Hello everyone! I am working on implementing a tool to assess the comple=
xity of CPU architecture porting. It primarily focuses on RISC-V architectu=
re porting. In fact, the tool may have an average estimate of various archi=
tecture porting efforts.My focus is on the overall workload and difficulty =
of transplantation in the past and future,even if a project has already bee=
n ported.As part of my dataset, I have collected the **qemu** project. **I =
would like to gather community opinions to support my assessment. I appreci=
ate your help and response!** Based on scanning tools, the porting complexi=
ty is determined to be high, with a significant amount of code related to t=
he CPU architecture in the project.

You should be careful here to distinguish the code in QEMU
which is related to handling RISC-V as a *guest* architecture
(i.e. one which QEMU emulates) from the code which is related
to handling RISC-V as a *host* architecture. For purposes of
"porting QEMU to a RISC-V host", only the latter complexity counts.
The former we would have to do anyway, even if QEMU only ever
ran on x86-64 machines. You should check whether your scanner
has correctly figured this out.

-- PMM

