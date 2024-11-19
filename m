Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DFCD4417F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQvg-0005Rc-MN; Tue, 19 Nov 2024 11:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDQvb-0005RB-1k
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:18:12 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDQvZ-0007ru-II
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:18:10 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cefa22e9d5so1418400a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732033087; x=1732637887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8X5theURMRh33B2obybFX32YPbHA93428Ftk/CDV834=;
 b=A9xq3TmeTbGLTADlg27RsQ5WEtPOudmMT0LK+cB9zbfn2ioLbw8pXMXGZhWlzCLTgK
 ycvlq46xCbXPvyR4LZDUCpqvN+tdjbuoE/iBQ+kt1JxM4iUmPkKjjtcZg8WDVqI5cM3E
 rrUdWuw9Y01NcpJCqfWhMNmbXjCEh7JLyOlbey7VR8sEqyfLXaw4R278O43D92oj2UvU
 iKxKMib0F0hG2/AGJ2vtAWxg+KnD7XmFckpZGlMGoIjfi9LqlFDKtZiian33EO7iVBmV
 maorRs0jbcbi6C6SGIlhV989tYuELBkPvTCk84mEdwQSt16SWnboSJXzU/8sFSLvnJd8
 ssNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732033087; x=1732637887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X5theURMRh33B2obybFX32YPbHA93428Ftk/CDV834=;
 b=gvhHkXGFuMrpEPH5dNfZfzY00otwVcap+7NQRv/DWUWVo74uwQXaIgpHl46nR+OLU4
 vkzBXD1H3ztMV5jLWT75k4BtOp0/Xhbns1AP7jDgce7vFPaydgm+u5H4z8FuLuG+4P8M
 2wDvnXo1qUk6bS7TvTC+wnPdBLA0leQBxChj6nA/l9PFkIUkDV+LSnRB10C8es5yhYl7
 Vb5wXR5K3OigjJjHMlqOt2D9Enj62nGdNHlAfuL2T6+pENFauuCeVzRNI1oDPEdh7+xH
 VKCT0q4pk6PZqNPBuKTPkzyWWxnZOLQa2Xd5Sdm6PkNI07mk9G5uq+6VdFa6hwHmPUaO
 GoOA==
X-Gm-Message-State: AOJu0Yxpg8Ytkq3LOo/KNgVaTTF1fty/ikU3Df1UaQC/qA0Tsf2SquuY
 1qyG4eSK9Cx8sIcaJXmpqiiv2wAMWL8IBPZM1xJb70pvWEiL4QL0HZMW7Q4sZ1+K+Y2d+9aI6DO
 OMh2On7CnAIll7hlVtgGDL443/CjdTr84gUyzqg==
X-Google-Smtp-Source: AGHT+IEV1RKE7jz9DpsErXNvka/9hyAzDt/Rmq7ekxbU0BtYTS0FOLgQVS9o51th0g+fgbZwRXfg8S+gMzi6vsGwHnQ=
X-Received: by 2002:a05:6402:5109:b0:5cf:c97c:821b with SMTP id
 4fb4d7f45d1cf-5cfc97c860fmr6297436a12.23.1732033087429; Tue, 19 Nov 2024
 08:18:07 -0800 (PST)
MIME-Version: 1.0
References: <ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev>
 <gODCf5hAzTYfCYRLXtbPw4av6ynWG2Dry9O3v18w7iwM2a2uZQwQ02kHyHHAeLuKr8yRKdREq_QT29fEo4sScB2CvammMOz_ubrg4hCBhjQ=@szczek.dev>
In-Reply-To: <gODCf5hAzTYfCYRLXtbPw4av6ynWG2Dry9O3v18w7iwM2a2uZQwQ02kHyHHAeLuKr8yRKdREq_QT29fEo4sScB2CvammMOz_ubrg4hCBhjQ=@szczek.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 16:17:56 +0000
Message-ID: <CAFEAcA-rBDOy0iR2_GkRB4GioW3bnL+1kmy53PTH1AMptzJz5A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386/pc: Remove vmport value assertion
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 16 Sept 2024 at 15:18, Kamil Szcz=C4=99k <kamil@szczek.dev> wrote:
>
> On Wednesday, August 21st, 2024 at 01:11, Kamil Szcz=C4=99k <kamil@szczek=
.dev> wrote:
> > There is no need for this assertion here, as we only use vmport value
> > for equality/inequality checks. This was originally prompted by the
> > following Coverity report:
> >  >>> CID 1559533: Integer handling issues (CONSTANT_EXPRESSION_RESULT)
> >  >>> "pcms->vmport >=3D 0" is always true regardless of the values of
> >  >>> its operands. This occurs as the logical first operand of "&&".
> >
> > Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
> > Reported-By: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Hi, just checking in to see if this needs any additional work.

No, it's fine -- looks like we just failed to pick up the
patch. Sorry about that. We'll get it into 9.2.

thanks
-- PMM

