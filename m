Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D490CCE7AAE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 04:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smQuC-0002Ai-NC; Fri, 06 Sep 2024 00:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smQuA-00029e-Ig
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:49:06 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smQu9-0007cj-3x
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:49:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EBEE85C59D7;
 Fri,  6 Sep 2024 04:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873B6C4CEC6;
 Fri,  6 Sep 2024 04:49:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="QW+fRJ4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725598141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZnG4i8+4nrMIcvsCOrhtQX7nA+5P6IoIK8J79TbA84=;
 b=QW+fRJ4rdVfnN9bJtWquOOwt8yk/sofmpfyVsZAUvkyU3+L4DAtVK79tJThbiwaNg5EK80
 UGtvuhdGgo/B3vPsWc/EMvexAee4C4KpUTF8UFTUrpUrzOkDOVr/puB5Eld48PA5JndFa/
 zYBhenabsv9vPUbhE7ZbPFHMdatKF3s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2a9701d1
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 6 Sep 2024 04:48:59 +0000 (UTC)
Date: Fri, 6 Sep 2024 06:48:57 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
Subject: Re: qemu direct kernel boot on LoongArch
Message-ID: <ZtqJuTTR0wdcVXdz@zx2c4.com>
References: <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
 <ZtnGA4mH0I2hdx4N@zx2c4.com>
 <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
 <CAHmME9pPvk4s9JnEPmc9w71hkeHD_1U-fAy0+8MQNmO_9Gh3=g@mail.gmail.com>
 <b11ba2f4-ba4b-40fb-860e-e10e760562fe@t-8ch.de>
 <CAHmME9pjokr=ahBbJA9Ljf8jjOyfyRAk0Qo4YeDYO_gs78GGzg@mail.gmail.com>
 <7311f2fa-2353-48ad-85f5-5eae1f6cb65f@t-8ch.de>
 <bac8575f-1c43-1242-9113-ef7957b50e68@loongson.cn>
 <CAHmME9pEw7_A5fSAooZLM9NGEpRN+05woicq8-qEjMqgBB8DwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9pEw7_A5fSAooZLM9NGEpRN+05woicq8-qEjMqgBB8DwA@mail.gmail.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Sep 06, 2024 at 06:04:25AM +0200, Jason A. Donenfeld wrote:
> On Fri, Sep 6, 2024 at 3:14 AM maobibo <maobibo@loongson.cn> wrote:
> > yeap, will submit a patch to expose ACPI GED pm interface with FDT method.
> 
> Clever trick. Works well.
> 
> >
> > >
> > >> Meanwhile, any idea about adding a second serial to the platform? I've
> > >> been futzing with it for a bit now to no avail.
> > >
> > > No idea, sorry.
> > Will investigate the second serial method.
> 
> Thank you very much.

I did it. I'll send a patch.

