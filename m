Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13209CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yLz-0004zg-D2; Thu, 09 Oct 2025 17:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yLx-0004zS-48
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:39:14 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yLv-0007XH-BL
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:39:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso1087043f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760045949; x=1760650749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1E0zB6gV37eEjQ8vKCHH5nXp2ej9uZwa0kAlYyLpYY=;
 b=GYENS38x/092JpqbRvAFAdg1yG9Po7n6bZV+0diy9LxnTNXKd7d3j5brDh+FuHPahj
 UBqUNc/1Yjo03+SydeBhGnBTyp501NIvB8Q4sukHCHpRuqLpvWkkVT8MXGvC0GaASIFt
 AJ/rtBGHDkfiXkkD/5tezHW8LtEF7EfeBlmuRCZ+N9ko2wU2PB04TsU+R29/XmcaT2gc
 5rOtUku6YKUXS2Rh/IRbwJXGrUMnJpcmWyy+jnlSY3S3McFg79hOsNSTe0rp+abWHHO+
 mYyjNQ5oT+9rII7B86ncLV7FMUS8eOEaz822O0BAiZlnTAZj+CQesL0BRPeG86CQNGfF
 DKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045949; x=1760650749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1E0zB6gV37eEjQ8vKCHH5nXp2ej9uZwa0kAlYyLpYY=;
 b=u0JyfchCcFJrwkK00xAPwQlCwcro1T34D1LQhPmyq8mdVO7aGRS6fgGg57m1C/yvd6
 QlcW0h0lecgEwwBsAZSyl4kq5njv6k3jr2UAnzNBA1GnXNJg478lt6Fil63N9/t8TEn4
 6fRS+YVbqz1lABeIPv1ptvM5Dzu8yrhOVM6Aah4qIhXHfHDBCjDwbrIMJjZk6iMvWl/E
 9glHpainISenNZOwLWH09Cbb//kskuRpfIdgHRI3Q3qgp+aJvmKe6LOqwHYQp0a2TcfZ
 d3OUOPQ4Xg4+cFMbH8DVSVnPMdI8mMI/kh8ekuoXKAw7b1mMJxHHFMR+Hhp592eaQ+ja
 2Z9w==
X-Gm-Message-State: AOJu0YxgLWLUkMlYqXpf1+VipjiBhb7XxKvjWbGm3uwDgjVrLWpNK4L6
 Y4Ht6mBks+90NBr3WVdm0g8avCbbdu9D4tK7q0tpOnZ1IbNuyOO+A0i76JtgKwtjFqmN1GbvKq5
 Q24koCTCVsvHk/hZ0hK8L226P+G4jrI0=
X-Gm-Gg: ASbGncs5URKk4DirNKlqWtauVoXp5TZVuzDkAAL936FIWn/lXP76q9UboT6wogZadmq
 rPsRBBBAcjlWqDr2Ea3i2r+BxmQqfT2yGkEiw0rudETMv7Ru+IcLa2KhVgO1BGUhsJtVf5gx0oM
 bWY/AVIn6wgs0MSXHKtOq09woU5bgv8c/2lJxKr8bVDGSXMTit98CYzJswHKEFoRwxD6nswzxrQ
 /6Les+GxF8VXEEZqsvRlstW/KXAHbbJPCXtNMPDyi23KvrZvPnR1oCnBha/0aI=
X-Google-Smtp-Source: AGHT+IEZJ4odJ8Zsyb/SKpml2cJnq+FSrgkAWrpiWV575TG9Vk1RlJKpPn/GpEYd2Cykp8Y5emy6yqbCOsAUD9+u6NY=
X-Received: by 2002:a05:6000:22c7:b0:425:8546:6870 with SMTP id
 ffacd0b85a97d-42667177d60mr5777300f8f.21.1760045949250; Thu, 09 Oct 2025
 14:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
 <20251009195943.438454-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20251009195943.438454-4-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Oct 2025 15:38:56 -0600
X-Gm-Features: AS18NWBNFMSk-wYSWGRzyUW5qxDK7ySBWoZBj1tjyiHB-ucLsZc2g22M0k1KgIs
Message-ID: <CAATN3Np32O0sJK+g_2rznqWXKSzLYrBz=voOwxcDAMX_jyrHOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] linux-user/hexagon: Use an array for GPRs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-wr1-x432.google.com
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

On Thu, Oct 9, 2025 at 1:59=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> Link: https://lore.kernel.org/qemu-devel/023e01dc389c$faf84320$f0e8c960$@=
gmail.com/
> Suggested-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/signal.c | 79 ++++---------------------------------
>  1 file changed, 7 insertions(+), 72 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

