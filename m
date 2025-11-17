Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466FFCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxok-0007jw-2b; Mon, 17 Nov 2025 06:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1vKxoh-0007ja-JC; Mon, 17 Nov 2025 06:54:43 -0500
Received: from mlugg.co.uk ([104.238.170.239] helo=mail.mlugg.co.uk)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1vKxof-0005ND-Rb; Mon, 17 Nov 2025 06:54:43 -0500
Received: from ehlo.thunderbird.net
 (4.d.b.5.0.3.8.6.2.e.f.3.f.5.c.9.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:9c5f:3fe2:6830:5bd4])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 99ECE359B5;
 Mon, 17 Nov 2025 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763380478; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FjC2Vzm5uiZsxsZ+JFFLLGCeOawz6hUm7qOD+BY228=;
 b=wzGP57SyDBXibzPNujrn3auzLnKSI+pF6WMOLFIDrmKeGqb9N833fmSjmtNSncmhjMqDpD
 Gbq3RBwPjPbnsRE+cvajUNcaJQeYzrSbZ4PPhDhaQEbuX3J88z0HcUOkTZRoI+Qj2B+ps+
 0RavgrGoUb5ROkTzwXWywhMeC9LFOxo=
Date: Mon, 17 Nov 2025 11:54:37 +0000
From: "mlugg@mlugg.co.uk" <mlugg@mlugg.co.uk>
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
Subject: Re: [PATCH 0/4] linux-user: fix several mremap bugs
User-Agent: K-9 Mail for Android
In-Reply-To: <a794dd06-cf28-4d04-be08-c87796296a72@tls.msk.ru>
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <f495c43b-3d35-4763-853e-4e70428cb666@tls.msk.ru>
 <CAFEAcA_8DbBoQdxRzqedssk6hdKrCNSVrO8i6iK4o5SWrkrNaw@mail.gmail.com>
 <a794dd06-cf28-4d04-be08-c87796296a72@tls.msk.ru>
Message-ID: <5981537F-9EA0-4BE1-BC00-63A626136153@mlugg.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=104.238.170.239; envelope-from=mlugg@mlugg.co.uk;
 helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

(Sorry for top post, replying on mobile=2E)

Ah, yes, I'd kind of forgotten about this; apologies! I'll aim to address =
the feedback and send a new version of the series by the end of today (UTC+=
0)=2E Thanks for the ping!

On 17 November 2025 11:43:49 GMT, Michael Tokarev <mjt@tls=2Emsk=2Eru> wro=
te:
>On 11/17/25 14:42, Peter Maydell wrote:
>> On Mon, 17 Nov 2025 at 08:40, Michael Tokarev <mjt@tls=2Emsk=2Eru> wrot=
e:
>>>=20
>>> A friendly ping?  Has this series been forgotten?
>>> It looks like it should be picked up for 10=2E2 release=2E
>>=20
>> No, there are review comments on the series that need to be
>> addressed before it can be applied=2E
>
>Yes that's what I actually mean, - just used the wrong wording=2E
>What I mean is that this series is better be fixed and applied
>before/for 10=2E2=2E
>
>Thanks,
>
>/mjt

