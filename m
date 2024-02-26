Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D86BC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redmn-00048M-3P; Mon, 26 Feb 2024 11:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redmj-00044P-Qy
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:24:59 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redmg-0001IS-7x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:24:57 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so3128157a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964692; x=1709569492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QWK/x+n65Ya6ddEAD/ARo1Y0xXgsCF/MLY528U2ZJak=;
 b=fTrsY1CSNAv8NmP/n8mcNc/pKfZxyd7c7FzjVhrnQVRryp8T3c5frZ2k6o3tMxVFTf
 MkMmsbbHIoETEcAzQXlAYrUPs2m4g1crJehI+DSp5F9j6bUPgR+59/Kg15X7EJrOvzVk
 WFlQQvj4ND3Trl7AfJGt9DmQxluqVMICxfo1neDuHCP+twGmSM5vuXrJl6VSfbk6a3tR
 5H7OTiRJ3n7XcwSS5hs51MJzp4n7UKjLUrmyYOo7ss9xTzaKTMfTFJVnaMXz+BJ4WwZ4
 COmhSu4Nq8HHHRcr9kzFAtrxc9sJmQaku6e0f0BMfIHVJdd0Ov3q5MlR9yC0nT5YADI8
 8BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964692; x=1709569492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QWK/x+n65Ya6ddEAD/ARo1Y0xXgsCF/MLY528U2ZJak=;
 b=fSTJeqsL09ui6G8bAdQqlHsDlbs7Zrj+/fBz2iZZ1DN+oLRlZQM1a72ODsaKzvBzYA
 lQz4TSClmSoD6csYuljoMoD9dy2Zcrxe3ncDw2AgXL/AD6g9n+vOkIc401ceqOQcd8Rs
 X9j/2TuTHG/sY0eZeN6g2YlFdGEN2B5NG4pp3jX05uekkGOnFYdB7YW0Y55DOSZp/g/m
 lIGSS+6LBE8Gth10JSC8aPqn4H2nXxza+tFEmVGvPYJRN6fKnrx7OFsPFcejgNU+tfOu
 fQaXWJ5TCBXHiLbdzrxI3PfVf6Tjqn+gqf+aEY7xnDqOWaFhyRYG6tzvLXMeZYFwE6O0
 cQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHoPh2mjfIhuWc2M/bntBworWUJ0L+fdNX8xj2HobfTvLpM7Uk659lnT5h3whb1/p/zyQllbB2EXj5UpH+1pCIGYdx/6I=
X-Gm-Message-State: AOJu0YzNR5BjuAQK6TKpL3I3k/C2WCq3N13iOUzrNt6SuHGVFuGhWYq8
 KO9qPAjDDTAi9Yu8dcV/ggwn4hPKCpL0+594OZVSuuSpXRQ8R06CTliNfV9vRgutYH4NRTzyW2K
 mit3tQwS+dXZifxcRy2WmF3YHFrZ5l6e4tRyuzA==
X-Google-Smtp-Source: AGHT+IGlduWPmAHugonfF1YhR1rEdiOcc8MxpTC1UQFFaCBKHygNLSyLCdMEBDbgv1GMZuS7oQ9n32pKxhtz99nX1kw=
X-Received: by 2002:aa7:c419:0:b0:565:a000:ec93 with SMTP id
 j25-20020aa7c419000000b00565a000ec93mr4073136edq.20.1708964691933; Mon, 26
 Feb 2024 08:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-38-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-38-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:24:41 +0000
Message-ID: <CAFEAcA8WkH6092rugK_30O7o9fkiqX=TeHw6TJ3T=5AfG8A9yg@mail.gmail.com>
Subject: Re: [PATCH v6 37/41] Add mailbox property tests. Part 2
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 26 Feb 2024 at 00:07, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mbox-property-test.c | 196 ++++++++++++++++++++++-
>  1 file changed, 195 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

