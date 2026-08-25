Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E644C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylyD-0003hQ-C0; Tue, 25 Aug 2026 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylyC-0003hI-L8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:53:20 -0400
Received: from nx84.node01.secure-mailgate.com ([89.22.108.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylyB-0001dw-3B
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:53:20 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wyly7-00BwLV-ON; Tue, 25 Aug 2026 09:53:16 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787644395;
 bh=oI5oob7mOO8n7M2C0ZtKlrcQtvvRSCypxTY7UignYO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MpDsFJDW3ixX9IsgQOX8unMTHVCNeoUaqg5tYy49JoCauIgSGslsGOGQ3jyCFwwIc
 mFMSUsSe4eKQFEn1ECjXCQ7IgqwTIK45rtEZJuwzE2AV5+Oiwt5nBtctoQ7Lh02GkE
 nJoRvXKJKrKCDj94J0ty9d6Sl+Wqz3KjS9l9B6Ok=
Received: from Zeuss.fritz.box (p57b2f393.dip0.t-ipconnect.de [87.178.243.147])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 8F8B8280D5C;
 Tue, 25 Aug 2026 09:53:14 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Christian Quante <christian@quante.one>, qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/input/ps2: answer unknown mouse commands with a resend
Date: Tue, 25 Aug 2026 09:52:50 +0200
Message-ID: <20260825075254.34963-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <919f33b8-5bb5-4d52-a616-05446ba0c2fb@rsg.ci.i.u-tokyo.ac.jp>
References: <20260823071529.16389-1-christian@quante.one>
 <d8529087-6950-45c1-b7a6-74ab80a10e25@rsg.ci.i.u-tokyo.ac.jp>
 <919f33b8-5bb5-4d52-a616-05446ba0c2fb@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178764439524.4158589.9134735991233237785@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV+hGCGUAP/IHwgbnhkxISr8/hYATUsAuBi
 Ss2+r+Yc1Cu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4aNTXTMlluPLo4Fm6X4hPWkS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMxqKIdDR6RVaf4xWSq5/wwdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNy9exdvhLPuiw2USEENU6UB8GnZ/gfHrn7QVmGVHZvj/CQeAzNbFDwG/GCY70jyw
 jDnWVUDR+c6ihbT+Pmkgu8dKTnmZuN/XgpugWxfxnwJ/qtmELPnFuzvKMLz+iUfCtfJQrpttlz3e
 aTvSxT28zqN6ApSDP9fLIJcrwFeou+Cx+zcdijFnYDwIvvgDwGlGNltqz//gVodr2Bbrpa11KQ1X
 60pfttRUJPEpY+dD8D1vIveD1kaqoOX9s49As8Lf9rIL5hu6PBBmQVXJOgy40oaNgxLGDo2IfSff
 yLpMY4GiERnEqbM7eXcjjx1NgqwoSQEiRQv+PVjjwa+Z5RFCOMSo3Wzle3zs24yfrwncN9jnrJpR
 1fkgawBqrJAecnrgmBTWM43Zy6rUJ+XPVw5rQN3HYZi/RQSVvjLZ9073r2ThsSxXvtcBnutXV2hR
 cyZeMt5qC3RC37WOfcNnA2gZY0tsDJ5OpGajzK+y6qnu2TRmCgWkeniwaIPiNK/dtWTwcPdjzQ6Y
 C7Heg3Xf7O1TOd4AR3bnyxZNhM1OcgqdW/wVtHH2Jl8eCsKWVs21EHNFpMlWjZB6knaS17WqHqbx
 /jMW8tb2W587s0xiEnMbqDovxKrS24UQEiEcX0sIf20P9Z24W5FAMBlV4QRE+Zyl9in1H/aAwarQ
 pYDOYx/6JtUO0Mqlhs6pmFPCFjhhN7CA6xKgoHAnJs1I5c9E1S43mq3kM3Qwxv7D9C3QH5nA6BrC
 GpdIe+N1TqSjWPuDI4o4oSgbUYstBS2wVr+z782L/itpmtBVV8AcwDEGcp3bMIDG5wlpy6uLmsAa
 TUOwBUuWxQ==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.84; envelope-from=christian@quante.one;
 helo=nx84.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Akihiko,

thanks for reading it that closely.

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> With no response, __ps2_command() in libps2 returns -EIO. With this
> patch, two 0xfe responses instead make it return -EPROTO. The two cases
> therefore do not return the same error.

Correct, and the sentence claiming otherwise was wrong. ps2_do_sendbyte()
stops at -EAGAIN once the resends have used up max_attempts, and
__ps2_command() maps that to -EPROTO on its way out so the resend does
not leak to callers.

The traces show the same split from the device side: without the patch
each unknown command is written once -- nothing comes back, ps2dev->nak
stays 1, -EIO -- and with it twice, because 0xFE makes libps2 retry once
before it gives up.

v2 says -EIO -> -EPROTO and drops the "same error" claim.

> Commit 06b3611fc2a3 ("ps2: reject unknown commands, instead of
> blindly accepting them") changed unknown keyboard commands from ACK
> to Resend in 2016, so this behavior is ten years old, not twenty.

Corrected, and v2 cites the commit instead of counting decades.

> I suggest dropping the final sentence.
>
> Additionally, it would be better to ensure the inline rationale is
> documented consistently across both the mouse and keyboard paths.

Dropped -- and the sentence before it as well. It described the silence
this patch removes, which reads oddly right next to the code that no
longer produces it, and the commit message makes that point already.
What is left is the sentence that says why a resend rather than an ACK,
which is the part a reader cannot derive from the line below it. The
keyboard path gets that same comment as patch 2 of v2, which keeps
patch 1 a pure fix for stable.

> Also, let's add Cc: qemu-stable@nongnu.org

Added.

One thing the re-measuring turned up: Linux runs into two unknown
commands during mouse detection, not one. The ALPS probe sends 0xEC,
which ps2_write_mouse() only answers while the mouse is in wrap mode,
and the TrackPoint probe sends 0xE1. Each costs a 200 ms reply timeout,
which is what the ~430 ms consist of. v2 says so.

Christian

