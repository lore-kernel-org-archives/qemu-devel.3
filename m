Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D97BE6C617
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOOW-0002wF-5N; Tue, 03 Dec 2024 03:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIOOU-0002vo-72
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:36:30 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIOOS-0004ZD-O3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:36:29 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id AE6CD180445
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2024 09:36:25 +0100 (CET)
Received: (qmail 22918 invoked by uid 990); 3 Dec 2024 08:36:25 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 03 Dec 2024 09:36:25 +0100
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 08:36:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <b4c01153c63444c11c81d70bb2588fb09fcee925@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 00/11] tcg-plugins: add hooks for discontinuities
To: qemu-devel@nongnu.org
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.691828) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.791828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=lXAIEgzLl6mcBe5xaBlygup4nKSGfgCVL++yWC+a5qM=;
 b=VeyDrM/XETO5W/KyPkon7pDO5d1i805Z3p5FLJOBVwfxszshyyY56V/zRqc4U9qok1IFp8EcUI
 vlasoBsWBBI95hKLqRNxW9xGCXXIvpfsEo4fBlwbOon+QuOEUheJKo0qPmKpKaiMGg+Cc010xgBC
 M48dGihcCrtkz8LuDpnbfgYc/xX3VTB66OSqn5ibfgpNQaty1SGVS2mVOmWoOLnuVHJeNxhP+QXV
 YWkUpBvNZtc08yMW9XxMdTarWjpVy9eFQIS32+N/0xcq8X2FBTL2Och2Yd2o0D/j4hK4LNTf39O6
 9F43jhHVNblHmkDg6HgJrN51mCj7tfqsLGKCG/BdBhVbFVxsIoV454Wn4nPmw65PLbgQ5s+MjrHH
 dxFS0b6DE02bDLx8Ogzx6RSmli8iRSpMuFBV/V5EK0pDBERSZD9FwBaf0/E36pfyMm1yPvtse/rb
 jaXy8pAdAsLqliSMR/77BbSekBA2r3Dd7AR+ONdwMZNX6TIL9IQpTRVgBRrqfYC2QZ6w49b7vRfo
 zH0tFVeXn+s60eTZaHGhGCFx+zkJemPwv5aAZhKL9JuIkYJvY+5ANgwUjqIDGWh5GwtWfTKTgUQr
 phuOoD7Byh99L5oqFEi8ummsYPi16nbQzPHD5TnYJCqmBNHYOhYYlhKBo/83lo++9hH98RN9Jo0U
 4=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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

Hi,

I just realized that I forgot to run the checkpatch script on the
patches again before sending and did not include the Sign-Off. Sorry
about that.

Regards,
Julian Ganz

