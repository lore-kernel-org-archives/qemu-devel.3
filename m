Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A911C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYP5J-0003AA-77; Fri, 09 Feb 2024 06:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP5H-00034S-8f
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:30:19 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP5B-00065B-2J
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:30:18 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56001b47285so1186856a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478211; x=1708083011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ri4mIJKLylno5ut36UFgzwPNY/6AYr7Kmyuxr9TDeU=;
 b=zs8DCv0vTmOg/FXc/HgCQqlCq+nskcq0PkW2bcar9I+EM/uit7x9UrfqMX9DSAXa4t
 CRGhEb71Y/ZIOB7S9bt732A9eaSlwL3zgxK467rm3GNRSNeoNuPo4ASjndDmBFuHoLWi
 DDnIbQSlymgBU87bwwCv+ig2UWx39TndfE+Zo/f2ELo7JDrvYhwZn6vRocVUtDnWjgKY
 vmbL4Y7t1iMOcqI9UK1bJ3+EB8O7oIuWkEErFU4juMK8ow79s6CWtDeDwH14M8OwVL8x
 pjlI2qhmNB6fqJ8snwcZa/iTOo5STa1Fsso/rnlgdoaAqcoBLXKmfXTGMlUjN4OIR4+w
 qzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478211; x=1708083011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ri4mIJKLylno5ut36UFgzwPNY/6AYr7Kmyuxr9TDeU=;
 b=miFWEQaduSzhZMs1p2yTmhuTk+MJO+AajzJX6SzxTbNQHNLFDJeeOI4jORKsGF+7s7
 1q3SiZAxU+lhXhG+qgcKdPHSrG7x0SB08cWRHFG9KfZTFl7XYAu72Axd7J/DmOngT6wT
 vVpkMWINkJdOKSvIc6JsQ3TBGgdIGsiLilhLz3wBodLWNo02U1ywKn0L7sghCnp4ZMzY
 h89n84VuaYNN8/JQT4uGm7ri2ubbeO8fwt9Ovff+O4ViT9w0haZGEVm6V8uU7aq82TdD
 D8tvbyCgHwC9JkXQzeptVJKKHP3RhmM/7k5R7RoX0gw014btjOGysQzdABnCBm+HxPtU
 ktGA==
X-Gm-Message-State: AOJu0Yy+gGeqaGf7VttAQEc93mNsQB+7KhaSokjdY4OdyXj99G+cgSxm
 Gt5j572w99aqjctO46v9/ryZojV779irUGNdTT9zIY2p08d4eIQA2Uxo3PlRr5GyFf5ra/C4Czw
 Mf+kHtf+O6GkAWY+XnSRHjqVcQKODDQiY3GArfg==
X-Google-Smtp-Source: AGHT+IHUpniXvn6D9Mp51N05Y/sOzEKBCLcC3nksSsXZhoCwpMqrcV5GCAh54ffGLH8lri3aaAhzTjAEcCMARg29Y8A=
X-Received: by 2002:a05:6402:356:b0:560:eaa8:9654 with SMTP id
 r22-20020a056402035600b00560eaa89654mr1059211edw.12.1707478211419; Fri, 09
 Feb 2024 03:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-8-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:30:00 +0000
Message-ID: <CAFEAcA9EWzBK68BrKfwRsv761ds6TVf-QPySg9d3jSPm1v_QxQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] hw/sh4/r2d: Realize IDE controller before
 accessing it
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sh4/r2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

