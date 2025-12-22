Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D80AE6ADEF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmfW-00075E-9D; Mon, 22 Dec 2025 15:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmfU-00074z-HU
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:38:13 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmfP-0007Ly-Ol
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766435878; x=1767040678; i=deller@gmx.de;
 bh=T0OUMMsyWW/42q3lqAS5zVnDzIh3I+tathqEsBUMiSI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gHLCk7XuLt0cIupiCNEXjvfFPU476RuYt0nMt+9ZLcdoRIg2/9cQc198Ca1DT0o7
 iSPK4yXEjS4I/bH1fEvUvZKOsk133vw48hjFGnSEh4MAhaRaWM/SQiLghbdxkiAf4
 0B4C50xYNzYr3R+eu36ozAUJAoOvWwLGjqbtWJc4FqGG7Y4bZvfHNjQLcatIZMmbH
 bmUBUIdcbpyKDkn+P2xoNmVY3U2flc2bAEgfeO6S1cGyjb2Hq7NO9xEJO7kdIDB6w
 3X0QxQ4aPHSVSVBRNNvVbCSjJp2vZjtjYw0cfONGFv0QFrkvHrLXAonFBslMl3pfS
 gCppkJN/zMBSvpcBjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1w9sJH1nn3-00eez7; Mon, 22
 Dec 2025 21:37:58 +0100
Message-ID: <a999bcae-1ea7-491e-8650-1ef065af6725@gmx.de>
Date: Mon, 22 Dec 2025 21:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] scsi:ncr710: Fix interrupt related register handing
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-4-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-4-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Q5wbcncVMKIfD4bvA5jSVMfxT3YajFGIAzUBVK1g/8h8+3DhC4
 YBF5eyXlbqm8Vjnrouugg1T/2NsJg67w++j/zyrP+PI3hlizRLvuDaF/gmGF1rH8eoq9q5z
 MXMZtXpMJt3YfMC/cPt4bmtTu2RtMe1ERiFEqXUUgqxGW9t3q+mIk46Om1rl4XrAoAb4rYy
 LLLEX7BofcsDgFarTZKCA==
UI-OutboundReport: notjunk:1;M01:P0:6X3h1uuec4w=;qzVmsH4l7bxPBs4T7ACDfmeQzmz
 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
 jvj8GqMU=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> - Mask DFE bit in ncr710_update_irq()
> - Remove manual ISTAT_DIP clearing, let ncr710_update_irq()
>    handle it consistently
> - Fix SSTAT0 read to clear unconditionally when non zero
> - Fix SSTAT2 read was returning DSTAT instead
> - Preserve DFE status bit when clearing DSTAT
>=20
> These fixes ensure proper interrupt signaling and status
> register behavior during SCSI operations.
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>

Tested-by: Helge Deller <deller@gmx.de>

