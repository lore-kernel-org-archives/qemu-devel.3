Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8BCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeRX-00012G-VH; Fri, 03 Jul 2026 10:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wfeRV-0000pt-JU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:00:33 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wfeRT-0007ju-QA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783087228; x=1783692028; i=deller@gmx.de;
 bh=L+cbhFwPGF5xtU51o6eIJ7xMTCjo8CmrruFh6cMGOjM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sRhYNkDTqAX0VhgsSuvwkHfv9dipP5r2IJ9akvowwJvYNi58/WGf06kBEITYiVI/
 2rVjeyxkGVPohfzZt9LwB9LqEXaOC9/SQbdCQ2NRnS6II2lKEMsb1sVws6yOGzCpD
 AJ0Yx+GpmXWHvfyrxrWu+mBOpr1oh8MV9rk1deEu6VSvUxrQ4lZmM0UyNiOmcQAGH
 61P42Iiw867xpgec9QMpX+0dsyWKi2TVTDJu1h46ujzEoILGV3WSq0kqTBZNmBOt8
 rR0oaFdYl8kYtOng141MAB80W9tRYqkPdTQT2rh4NmemxFBD2MiQ8GJwPn+U1pcdZ
 8XkVMuKlIU+13YHPWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1x0MiO36qy-016SwY; Fri, 03
 Jul 2026 16:00:28 +0200
Message-ID: <4bb3ec72-ba39-4846-ae7c-335121c16c41@gmx.de>
Date: Fri, 3 Jul 2026 16:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/misc/lasi: derive IRR from pending and unmasked
 requests
To: Keith Monahan <keith@techtravels.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-2-keith@techtravels.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260701213359.1855870-2-keith@techtravels.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mKfhJE+ERkd8Sbeaz52sXjPHT0ZrSLris2nin61QSvfxWJeq6ho
 NwoXhVrfirJ+dkqDvWq8MqiCUL/vkWWaFi+kMTyMNWb+VObjKgwU3kX504sOa1oTjoI/X5C
 U1vLO2lZzDsTRwZCHSq9Qpi76m8/oThl640F6+mtt0l+AmqCnmjOjD1MBAuUpugK4arqckm
 lUvhEIkHWVhT212jgZ8ZQ==
UI-OutboundReport: notjunk:1;M01:P0:8vAhkPNbMBQ=;8NspUtg9zeS8CDgMKs1l5G9xtgm
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 7/1/26 23:33, Keith Monahan wrote:
> The LASI interrupt request register (IRR) was latched: set when a source
> asserted and then never cleared or re-evaluated against the mask, so a
> masked or dropped request stayed set forever. The parisc core I/O
> dispatcher reads IRR to find its interrupt source, so the stuck bit was
> returned on every later interrupt as an "unexpected core I/O interrupt".
> On an installed HP-UX system an unacknowledged i82596 LAN interrupt
> latched this way and the flood wedged the boot.
>=20
> Derive IRR as (pending & unmasked) with IPR tracking each source's level=
,
> matching the hardware and the in-tree parisc gsc/lasi driver.
>=20
> Signed-off-by: Keith Monahan <keith@techtravels.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Thanks Keith!
I'll pick it up in my upcoming hppa git tree, so soon you don't need to ca=
rry it
extra. I hope this is OK?

Helge

