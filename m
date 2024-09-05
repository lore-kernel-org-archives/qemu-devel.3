Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DC7CD5BCB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 14:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smDs7-0008Ig-V9; Thu, 05 Sep 2024 10:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smDs6-0008HZ-75
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:54:06 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1smDs4-0007CI-Hn
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:54:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DD4F0A44CCE;
 Thu,  5 Sep 2024 14:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118C1C4CEC3;
 Thu,  5 Sep 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="VfKp9dlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725548038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d92FhpwTdsHtj9SKBvdRleCOsJEdB2224ZWblx6x7fk=;
 b=VfKp9dlVoWj6aWx45NPCkHZY080e7bIeugru54ndRgluhEXNtJi50bNOaNs6EUTPyQ0wmb
 ukLH+dxAE1aotYy1FHbW8a+Ef9cAsW9ib4uN/uK+yiY/kf6GJB1nRNWEyCHFjqRCcHw1zo
 IjSll8NIZnDO0ouaXDYnUs+/zBghz1A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c05a5307
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 5 Sep 2024 14:53:58 +0000 (UTC)
Date: Thu, 5 Sep 2024 16:53:55 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: maobibo <maobibo@loongson.cn>, loongarch@lists.linux.dev,
 qemu-devel@nongnu.org, xry111@xry111.site
Subject: Re: qemu direct kernel boot on LoongArch
Message-ID: <ZtnGA4mH0I2hdx4N@zx2c4.com>
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Sep 05, 2024 at 07:25:05AM +0200, Thomas Weißschuh wrote:
> On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
> > On Thu, Sep 5, 2024 at 5:45 AM maobibo <maobibo@loongson.cn> wrote:
> > >
> > > Jason,
> > >
> > > With the latest qemu 9.1 version, elf format booting is supported.
> > 
> > Thanks, I just figured this out too, about 4 minutes ago. Excellent.
> > And the 1G minimum ram limit is gone too.
> > 
> > Now working on how to trigger resets.
> 
> With "reset" do you mean normal (non-panic) system shutdown/poweroff?
> Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
> that in a cross-architecture way.

What I mean is that I need for userspace calling `reboot(RB_AUTOBOOT);`
to actually result in QEMU being told to reboot the system. Sounds like
that's not possible (yet?) in 9.1?

The last hurdle I'm having, in addition to that one, is getting the
second serial port working. The kernel test suite that I'm running in CI
for /dev/urandom development and wireguard development does `-serial
stdio -serial chardev:result`, where the first serial is the normal
output for logging, and the second one is the test result, so I can get
that from the VM via a clean channel. This works well on other
architectures, but on loongarch, it's failing to open /dev/ttyS1 the
same way that it can open /dev/ttyS0.

