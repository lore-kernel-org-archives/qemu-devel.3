Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCD2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wheC5-00085N-FA; Wed, 08 Jul 2026 22:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wheBf-0007XJ-Um
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:08:29 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wheBd-0007z2-Dk
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:08:26 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664ce3000e6so1321917d50.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 19:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783562903; cv=none;
 d=google.com; s=arc-20260327;
 b=pu6zGczzox0WtMUn37K20bXYnI3/xBhaU23s5TepArK9gWdB8uh6p6G942ovokK6dP
 Re+1qDRpcW0M2W5svS9b+s4DXyh/58vbNGPRgYihZ3xWevKvH4JkaB5bBhqvutAhUNIG
 oii7xnM525E2Z13r+seEC4jelLAJtgnABoIAdfvEQoAgsnMaiybhE2qfp6nFL9cY56Zd
 Qqsjmhq8fsgtxTouhTqBr2NJcXMkZrHV1p9FSdKkCrqMr7gjjEAhzGbx6BMPK6aUzr5j
 UXJxEtbYyhNiQ+sxY73ZybpwpSGkZF9kpoBerbfA+RoSb4axeiPl7cfX/ZMoPMaPU0V6
 UF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=snbydXFuW40Gh4poEDUHI1UONkA95bN3Yg9hISD38XM=;
 fh=vef3zk84tqMEnZhWIcmBaFB6NOsoD5bZoGiOSO+zhsM=;
 b=D5ZO319AxXCUYNN4XTdZ3h/4zuKDrO2zVmVqijHQhTKGJ4DtJPNi+iSW9CfVdzqxMt
 QBaQs9OBmSPaEkiOeMyD0NDCzZrJEF8c3HbSmBZXJNMlo27ytIRPKRf/7NLmQxtZt1W4
 2KMUp8/QO2Wb6AEwQ6JgNGefDdg/dmCs9e+eVc7EALH/2F+UHyrGAz7kNeR6bM0G9kFd
 LEekYR0vUUZjhGkJ1W++oHO+3GliQWlkHFTLQ633oYLwTx6/EpJTt9KleQ/0WTFkLmTs
 vS2B5qOlpH4lBmkxT70wuAFAjUzkxCF9Hg6fJbgaQ159GzAJlXQexKdK6c1yhsQ2mXtT
 JbEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783562903; x=1784167703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=snbydXFuW40Gh4poEDUHI1UONkA95bN3Yg9hISD38XM=;
 b=SM2+7yqd+G9My7ytUhCxFINMPoZIGQRmRLc5/SWD6gQ39hIWmkzVPzg/XrVKSIDNDx
 nfNvZA2kl8QMt+BLzH4av+P6J8lYkvckwTdlkHg0+aRlrdE42WNT9NmGOQ5nFwd54bYK
 UNo0fZp8mFTCkuqHC7brSnAvWkc9HK8VL83K+Uilu1oCJVPJhsGTME90anTFQlcNaRYr
 ZnrdC4HTrdoJJrFHnQT1ZBTDWNdjZRsxhPEPnmCaJYEy+R8mClCLnxRq75BW/uCOqGvP
 /eSyodkya6X/q2eSqBxfcVUdGG0oL3ehR9qjEwdKNj+vbBB9H7vzLYtM9xRqb2ieKs12
 6r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783562903; x=1784167703;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=snbydXFuW40Gh4poEDUHI1UONkA95bN3Yg9hISD38XM=;
 b=R9nPIWRpVW03nnah0vYucy9wgSv+qB/PuooTGeHfH8Oss2Tw8GP3C525jKfZpRWoDE
 8IGnuCK4OqX6SmBx6upMYANM3iE6Yrc7q9Z1SI2Qcd0U8GWZGjYxVDbuMd4ZjsQePRPi
 VcMq+VX7LG8wrZMNLIiGcg/ulg57ccdbM9m+WFin4CmNBBdQX83AM6rUBfyZKWD3+T0x
 0FOdH0DKre9kpFLie+2HHV3p5IspWbSZ+hg2Z/PAAHWJ6xSxQfzfCxe7lzzNBNvwXOzG
 EN0St9ZogF09SbYhsQmzvcZAJ71NRgVDyL0XyJ4HQRmgYZREqBLWV93BCrGO+p2uLzTl
 XC9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPAbgd5sKEozV7AD0sOSel1tL1hfMjtNDuUW4JATWirI5HoSB2HboD42bUd5i9Qer7Dm/+I2HU1tOf@nongnu.org
X-Gm-Message-State: AOJu0YwvMaiZ3RXV1Fby3GyoC0IREuyuoG+jf5lwAbCReofxo9cVgfZc
 z9Zq8WbOHbrLVOPOy1zMCDaKpvDD/h8fju32pJlzkCN8YiZfhjUxx51IsELb84S1177/GP8okgH
 OLes0YktOOv2Hi6J4Ciby+OQzcxkvDHY=
X-Gm-Gg: AfdE7cmXKMHu3vJclOBsxNiHqutVP4KdrWLtt+qy5htX/pWxT7gCZeQOLU/U8Kf5Xj8
 XVnG1T2HT+h/59nGc6MsHEDzmXkiE7W/TbsLEX0uy/r6+TCIfdEiscTc0Bq4lGSouS8kQPzmy2G
 VRNLNoFV4aGS1xw1FmFWlS97j932fVLBn4Z9oZumw8jSCHqJ+oK1dnIeu8zxRNjbAjJFfZUmoG/
 9LESHF3pSNwx5CWhXMwJdvaUEyIEI8dU7t32zEvv8/nFROLcZFNMSxwqwgTAP6h6p2gCk6+WA/u
 sLlDIg==
X-Received: by 2002:a05:690e:1917:b0:664:da95:cf4d with SMTP id
 956f58d0204a3-6679f2cda01mr3740889d50.18.1783562903179; Wed, 08 Jul 2026
 19:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260708111544.1440761-1-clg@redhat.com>
 <20260708111544.1440761-4-clg@redhat.com>
 <CAEUhbmV0Q2xpwVLUxv9NEDbb8pMgnjdChupPngtPvCuFFedv7A@mail.gmail.com>
 <6e33a168-4311-47e8-a153-f364a2c43bf1@kaod.org>
In-Reply-To: <6e33a168-4311-47e8-a153-f364a2c43bf1@kaod.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 9 Jul 2026 10:08:11 +0800
X-Gm-Features: AVVi8CeKBU8zsEgdrd9CL9auslSqxZEHLygkFE3hKG4nlkhLM8jtr3S_ArQNPjY
Message-ID: <CAEUhbmUNmo72DUbx+Kyu0UPxo1-iMFgz2oJw9Vz=zC4U8XFxAA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests/qtest: aspeed_smc: Add Dual Output Read (DOR)
 test coverage
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jul 9, 2026 at 12:43=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 7/8/26 17:32, Bin Meng wrote:
> > On Wed, Jul 8, 2026 at 7:17=E2=80=AFPM C=C3=A9dric Le Goater <clg@redha=
t.com> wrote:
> >>
> >> Add read_page_mem_dor (CTRL_FREADMODE with DOR command and dual data
> >> IO mode) and write_page_dor (user-mode DOR) tests.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> ---
> >>   tests/qtest/aspeed-smc-utils.h |  4 +++
> >>   tests/qtest/aspeed-smc-utils.c | 50 ++++++++++++++++++++++++++++++++=
++
> >>   tests/qtest/aspeed_smc-test.c  | 16 +++++++++++
> >>   tests/qtest/ast2700-smc-test.c |  4 +++
> >>   4 files changed, 74 insertions(+)
> >>
> >> diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-u=
tils.h
> >> index 5a86514caf35..fbfb94e831d8 100644
> >> --- a/tests/qtest/aspeed-smc-utils.h
> >> +++ b/tests/qtest/aspeed-smc-utils.h
> >> @@ -44,6 +44,7 @@
> >>   #define   CTRL_FREADMODE       0x1
> >>   #define   CTRL_WRITEMODE       0x2
> >>   #define   CTRL_USERMODE        0x3
> >> +#define   CTRL_IO_DUAL_DATA     BIT(29)
> >
> > This macro is already defined in aspeed-smc-utils.h:43
>
> I am confused. I only see this CTRL_IO_DUAL_DATA define in
> hw/ssi/aspeed_smc.c.
>

Sorry, my fault. I had a local tree that modified some of these qtests befo=
re.

Regards,
Bin

