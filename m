Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514D0CD5BCB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smE2o-0001lA-Dz; Thu, 05 Sep 2024 11:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1smE2m-0001jr-9U
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:05:08 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1smE2k-0000fH-4V
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1725548701; bh=1RtpgcPhEEYYwXcKrUAWQ3EjVVph3Z2nVQEfKOTbS1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U9ec/p2m2zWsVi6ZcrHFfHBJxd3khBMSOt54rVmMDNp9UJUo4AtTRCE0LXBVAbAwo
 dseUtqWYWnSxy8SJf/bjW6ef4CZN/uirDKs1xSMXBAFDS+O6xEULjkPt8VF6bkM2F8
 r1voyy7IOUjXWxLLRqVBxTySbV5g4Flfi1pLA/1I=
Date: Thu, 5 Sep 2024 17:05:00 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: maobibo <maobibo@loongson.cn>, loongarch@lists.linux.dev, 
 qemu-devel@nongnu.org, xry111@xry111.site
Subject: Re: qemu direct kernel boot on LoongArch
Message-ID: <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
 <ZtnGA4mH0I2hdx4N@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtnGA4mH0I2hdx4N@zx2c4.com>
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024-09-05 16:53:55+0000, Jason A. Donenfeld wrote:
> On Thu, Sep 05, 2024 at 07:25:05AM +0200, Thomas Weißschuh wrote:
> > On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
> > > On Thu, Sep 5, 2024 at 5:45 AM maobibo <maobibo@loongson.cn> wrote:
> > > >
> > > > Jason,
> > > >
> > > > With the latest qemu 9.1 version, elf format booting is supported.
> > > 
> > > Thanks, I just figured this out too, about 4 minutes ago. Excellent.
> > > And the 1G minimum ram limit is gone too.
> > > 
> > > Now working on how to trigger resets.
> > 
> > With "reset" do you mean normal (non-panic) system shutdown/poweroff?
> > Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
> > that in a cross-architecture way.
> 
> What I mean is that I need for userspace calling `reboot(RB_AUTOBOOT);`
> to actually result in QEMU being told to reboot the system. Sounds like
> that's not possible (yet?) in 9.1?

With reboot(RB_POWER_OFF) this is indeed the exact usecase for pvpanic
shutdown support. Reboot is not supported, but maybe -action
shutdown=reboot works and is enough. It would also be trivial to extend
pvpanic for reboot support.

Use -device pvpanic-pci for QEMU and CONFIG_PVPANIC_PCI=y for Linux.
(That should work for most architectures)

