Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE254D17132
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 20:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2yvE-0007bF-4T; Mon, 21 Oct 2024 16:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t2yvC-0007at-2d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:22:34 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t2yv9-00056p-UV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:22:33 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id E5027180490
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 22:22:28 +0200 (CEST)
Received: (qmail 20508 invoked by uid 990); 21 Oct 2024 20:22:28 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 21 Oct 2024 22:22:28 +0200
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 20:22:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <960a7d505c64c9c426dd70445d2acd843bd396db@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 3/7] contrib/plugins: add plugin showcasing new
 trap related API
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <97f8c999-c6b1-46d2-aef3-3a81c2156865@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <1a2a379011c3636cfc516a3d246566acf14dd44f.1729355735.git.neither@nut.email>
 <97f8c999-c6b1-46d2-aef3-3a81c2156865@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.258281) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.141718
Received-SPF: pass client-ip=185.26.156.114;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

October 21, 2024 at 8:07 PM, "Pierrick Bouvier" wrote:
> On 10/19/24 09:39, Julian Ganz wrote:
> >  + max_vcpus =3D info->system.max_vcpus;
> >  + traps =3D calloc(max_vcpus, sizeof(TrapCounters));
> >=20
>=20Instead of allocating data for max number of vcpu, you can use a qemu=
_plugin_scoreboard, which was introduced recently, and covers exactly thi=
s need, by providing an array that gets automatically redimensioned when =
a vcpu is added.
>=20
>=20A simple example using it can be found with bb plugin:
> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/plugins/b(=
id, vb.c

Thanks for pointing this out! I scrolled past the scoreboard API at least=
 once without realizing what it was.

Regards,
Julian

