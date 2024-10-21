Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C40D1713B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2zXy-0001tU-UA; Mon, 21 Oct 2024 17:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t2zXs-0001qN-5o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:02:32 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t2zXp-0000wS-9y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:02:31 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id E68DB18031D
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 23:02:20 +0200 (CEST)
Received: (qmail 15217 invoked by uid 990); 21 Oct 2024 21:02:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 21 Oct 2024 23:02:20 +0200
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 21:02:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
In-Reply-To: <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1)
X-Rspamd-Score: -0.1
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Pierrick,

October 21, 2024 at 8:00 PM, "Pierrick Bouvier" wrote:
> I agree it would be useful. Beyond the scope of this series, it would b=
e=20
>=20nice if we could add a control flow related API instead of asking to=
=20
>=20plugins to do it themselves.
>=20
>=20If we would provide something like this, is there still a value to ad=
d=20
>=20an API to detect interrupt/exceptions/traps events?
>=20
>=20Note: It's not a critic against what you sent, just an open question =
on=20
>=20*why* it's useful to access this QEMU implementation related informat=
ion=20
>=20vs something more generic.

The motivation for this API is a plugin that simulates a RISC-V tracing
unit (and produces a trace). For that we actually also needed to
track the "regular" control flow, i.e. find out whether a branch was
taken or where a jump went. That wasn't hard, especially considering
that the TCG API already gives you (more or less) basic blocks. Still,
we ended up tracing every instruction because that made some of the logic
much simpler and easier to reason about.

We realized that we need a trap API because they:
* can occur at any time/point of execusion
* usually come with additional effects such as mode changes.

Helpers for discerning whether an instruction is a jump, a branch
instruction or something else would certainly be helpful if you wanted
cross-platform control flow tracing of some sort, but afaik given such
helpers you would just need to check the last instruction in a
translation block and check where the PC goes after that. Additional
callbacks for specifically this situation strike me as a bit
excessive.

But I could be wrong about that.

Regards,
Julian

