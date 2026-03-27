Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35EF10ED66E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66hu-0005xZ-Ri; Fri, 27 Mar 2026 08:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w66hm-0005wo-4W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:54:26 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w66hj-00012T-HA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:54:25 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so2131858d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 05:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774616062; cv=none;
 d=google.com; s=arc-20240605;
 b=I66qjiebiVRbv7uyRhxJTQw/Yj3MTzkhzJpchewPWDAL6d/URlHJ4H6WlMKoXM9Tw2
 ap3No4HG381xocevEVPR6bo6G2HdZK/zi2hdatS8TPZfYQchLbrGMuvEekxQXIIov3wP
 Ow7uPaivxAS8dkgm8j+GLMNT96zMJJ3Qj/KFDdkKJGiCBt2tfqZyqG3Usn6Dlinui07d
 sC5gG6mUmAhi5A2wFfH9ir8T17pOG5AX+5PyqmmKs7DPTl/FKLDS5wkSWwXteAsgaPO4
 LqRnc2BdDmqpD8YvgbhRT+NCC0cpvRkc/3YEWSDPKfLtPlxE8HRf3CNetqbp09J4ox3Z
 7HiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kzCFKM309Nm5jK3yHzstQFGM7mkWdc7TRJRU68FREYk=;
 fh=i9b00taZvWmeuP8ICDgmYTu097WQUtGk3SraBdL9nps=;
 b=Wba/k2YW9znd2+2C2GxCh2olBS+0W4/z9ShndKrZ35LneKf1qbYHq4T4YgEc1jJ2dS
 9FyGVsNbX3F+Z5HunySzvlVSJZBpUgyBpB/0yhRixHFRUiVcbo+9Pn6lT4tGmBiBzbSw
 Q4C0htMZH3PQRLphZxwuu9G7chMYtGKaNbY90AehbTnojAvZEr3VFFzG+8FTiaojoZ2a
 k4h0gLkKU+oun4mHYAswCh6EPaZsFsR/ovY8rCKCI9Id1bo5wRsaq6u/ERNAKdFDMP8w
 syqLiiFqC7yuk8dZCHtPokoX/W5ltVmFZ//yqmOEIyRBWy6Rzn7shCAMn5HcxaF6lf4u
 57Rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774616062; x=1775220862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kzCFKM309Nm5jK3yHzstQFGM7mkWdc7TRJRU68FREYk=;
 b=j67wFQruIS/ttWsK2sKhKXTz6IZccq3nilruHr7EbbI1nFZOawhfd1nFToSdYi2d6N
 lwE4gY7/WAISvkGpyiCQTrq2VMzo5WGIyVjCU4xCEhYDdiTeFtAUnLD5gJrv5S15YFoH
 y8jIhtrxOl6uRxjSQkq19e4JzBSLVKvIe5yCi12lh/4GafauWlLBnQmn2OjE+K2I879B
 ZWca5jrF+ZyIgOecCcWvEoc6r7ljTHohtoKT+eEHK4744SN6BjgZa8eDEuSzLog4u9cX
 gcf1DK5vE3/PCr2X/tNTyV2FUt5D8I1/lQ3G8fr+RU8I7mvjOOsWgoJsbLYPZx0wFPpB
 SXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774616062; x=1775220862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzCFKM309Nm5jK3yHzstQFGM7mkWdc7TRJRU68FREYk=;
 b=pUM9LKAbI5ORnyhemVKKW+/nlJMQqMWTEydzXRNr5qaOYXjzjsn9+Q2PW4/VhiP2Ze
 OGQ1tAhZ+WM5+DZFtFfD6i8pFOdWDNKZzY5SoTE1louxKw8HnzM81ilhkK1L9g2qLaQm
 BnvcJGNH/EzUQrVTqXzxrba+pcqjT3Q43nMbb48OE+in+EZ+jQ5YaUdE/jF+uBE1PQtD
 rOTItCnHq7DuiGK8ptHIONencMazhVSBR8NjJgqBYHICdTAiy86xEJ4nsvb0aao7cNgU
 MF4j2FnRq1XxMu/xFaKG7LnHLfdcAZcDmPZ4wxvS99T60dzhu+jXEKhmpmAondPa1tMa
 PHdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCiYBZWUdhP3iYpLGUQinsdmaZsp0EqUjkj0SGhLUBAjPx71VQq6kDRZKtZYWOYltJyxXEtbNpM1KY@nongnu.org
X-Gm-Message-State: AOJu0YwIDFQzbashotjr8E51BaV6a3kOQVel0W1Tp6C3RI9GDB2aV+So
 aQoAEcaIsGmUSARU/VUqyS9jqmXUhJ3DItjiawDnekNXx/HxXoT1Gtgu+yYxeT46ZSKibARnkCn
 1LbcJiP2k6LDgV3OpYL6UKMRt8CX2cdYDB+he/TMxDQ==
X-Gm-Gg: ATEYQzzwpuj9XYOUV63dHFnJNJi9TBlVtCx70Os5z2OZwFEdlIsLqS4rxMTLgK0kkj1
 f6Prs7Vm0V78ZeMAC4XJm51mrEB+d3HGVQfn6Qc5bEfOzT7BPYYTjBhty9AEQWlTlKeXtg8poPW
 Z4PB5VzI+eGWypxO5MlrmP5/PMXAeBniP7G4Uq1yeVet7aWzumyJ91Sd+ZomClKYlTWN5kTrmnr
 Uqpv3BM182u9qqWV4yZgjaewe311g1Sraj/xLd1RzPUGUhnwrXUSioTH3hW3DlVlLqyvYGrUXzC
 VMQktEaESuJd90ulgkNvWO12C3fEtPAmMisFmvqNj5DmZIeunCPuH7lbhdfCNo0+xV4=
X-Received: by 2002:a05:690e:b42:b0:64e:b88a:2e9c with SMTP id
 956f58d0204a3-64ff7222b21mr2324216d50.31.1774616061848; Fri, 27 Mar 2026
 05:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260327124136.983955-1-shivangu@linux.ibm.com>
In-Reply-To: <20260327124136.983955-1-shivangu@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 12:54:10 +0000
X-Gm-Features: AQROBzDOA9TkS0FFuDrYvUVOQlPZ08CG4RkcUI7f2HVA9DQY1Y7I4GyzSN60Xt8
Message-ID: <CAFEAcA86otB1+BeQ_Gca7VcF4c+rJ4r9SxwhkTOkCHEAas_KWw@mail.gmail.com>
Subject: Re: [PATCH v2] ppc/pnv: generate dtb after machine initialization is
 complete
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com, 
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 27 Mar 2026 at 12:42, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
>
> Currently, the machine dtb is generated in pnv_init(), before all devices
> are fully initialized. This can result in an incomplete dtb for the system,
> as seen in bug [1].
>
> Fix this by deferring dtb generation until machine initialization is complete,
> using the machine_init_done_notifier hook.
>
> [1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

