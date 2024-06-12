Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BDAC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLvg-0004HU-IT; Wed, 12 Jun 2024 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLvf-0004Go-A0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:14:11 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLvc-0004Ci-JI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:14:10 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 587CC40755E8;
 Wed, 12 Jun 2024 11:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 587CC40755E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718190844;
 bh=ACH8s9CbV5hvduW+DtxfNbRiCtP1HwK4DtH6T9V3G9o=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=pfl+6m3omb4vfzwt/LkqUWI0QOfzII5yrWk/7iD8wk+tTqYWPPShbSD/7s4moLr9u
 ig4r43Ir7D/60mBQI5atFVsEs3+jmBeMrpodgGN3D0pnEGx+7swfrmuzHMpgVEPPK/
 M7aGd3Bq8UWN3ha46q6/XgesH0j+VOQBmxFnJg5c=
Date: Wed, 12 Jun 2024 14:14:04 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <ZmmAq8fbJLuaX4Qg@redhat.com>
Message-ID: <f93dc9e6-55b1-9024-bab3-d31297bef2e7@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1431916619-1718190844=:10393"
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1431916619-1718190844=:10393
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


On Wed, 12 Jun 2024, Daniel P. Berrangé wrote:

> On Wed, Jun 12, 2024 at 01:55:20PM +0300, Alexander Monakov wrote:
> > Hello,
> > 
> > I'm sending straightforward reverts to recent patches that bumped minimum
> > required x86 instruction set to SSE4.2. The older chips did not stop working,
> > and people still test and use new software on older hardware:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=31867
> > 
> > Considering the very minor gains from the baseline raise, I'm honestly not
> > sure why it happened. It seems better to let distributions handle that.
> 
> Indeed distros are opinionated about the x86_64 baseline they want
> to target.
> 
> While RHEL-9 switched to a x86_64-v2 baseline, Fedora has repeatedly
> rejected the idea of moving to an x86_64-v2 baseline, wanting to retain
> full backwards compat. So this assumption in QEMU is preventing the
> distros from satisfying their chosen build target goals.

So, to make sure I parsed that correctly, you're in support of the reverts?

Alexander
--8323328-1431916619-1718190844=:10393--

