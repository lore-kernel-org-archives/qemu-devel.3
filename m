Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC37E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWuL-0001XM-Se; Wed, 08 Jan 2025 09:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tVWuK-0001US-1V; Wed, 08 Jan 2025 09:19:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tVWuH-0007d0-KT; Wed, 08 Jan 2025 09:19:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3313C5C4A8D;
 Wed,  8 Jan 2025 14:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16405C4CED3;
 Wed,  8 Jan 2025 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736345974;
 bh=vK1IN5Dyq05umuvO6zGZxlftusRlxJsEsWVxts69M+o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FiuMaGkfk91ZuJ039RrSBrGseGzRiLq/ZP2JeDgcYWM6BXiFhfSUVB0tPmAsIUQe0
 CqKkk5dEn4jJjM3PWwzkOMY9AlESNJ652ekVT4WqJ0My4mwSBb+cxxGF/Xq58ZUwIc
 0U/hhvFqbgzjb0NLM8TtT4C1NxAFuRyzT9lZfTfnWRziy4i8oUE5gle6ccDJTcSLCQ
 gWdiWOJWcE6G5TWPWdkLVNQvrkojxIQYn68tG8ijI3WKcYbyV86Kd4Ip+GmAetxFlF
 2w3kPVyOPzbe6k/IOwIBquaQTSvsMsKURkwS0SEmys0ZMYyOuPMqDOKqt978M8P1aW
 YiikMFVQOYuTQ==
Date: Wed, 8 Jan 2025 15:19:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] Change ghes driver to use HEST-based offsets
Message-ID: <20250108151926.1602394f@foz.lan>
In-Reply-To: <20250108090815-mutt-send-email-mst@kernel.org>
References: <cover.1733327276.git.mchehab+huawei@kernel.org>
 <20250108090815-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Wed, 8 Jan 2025 09:08:51 -0500
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Wed, Dec 04, 2024 at 04:57:54PM +0100, Mauro Carvalho Chehab wrote:
> > This  series was part of the previous PR to add generic error injection
> > support on GHES. It depends on a cleanup patch series sent earlier
> > today:
> > 
> >     https://lore.kernel.org/qemu-devel/cover.1733297707.git.mchehab+huawei@kernel.org/T/#t
> > 
> > It contains the changes of the math used to calculate offsets at HEST table 
> > and hardware_error firmware file. It prepares for the addition of GHES
> > error injection.
> > 
> > The first patch was previously at the cleanup series. It prepares
> > the logic to support multiple sources.
> > 
> > The second patch adds a new firmware file to store HEST address.
> > 
> > The third patch use the new firmware to calculate offsets using
> > HEST table.
> > 
> > Patches 4 and 5 add migration support. They assume that this
> > series will be merged for qemu 9.2 (maybe it is too late for that,
> > as QEMU is now on soft freeze). 
> > 
> > I tested migration using both virt-9.1 and virt-9.2 machines
> > on qemu 9.2.  
> 
> So this needs a rebase to the next release. Thanks!

Sure, I'll do the rebase today.

What about the preparation patch series, from where this one is
placed on the top:

	https://lore.kernel.org/qemu-devel/cover.1733297707.git.mchehab+huawei@kernel.org/T/#m3b56bbe7bd400369f9e38b56faf4e65e64069955

Could you merge it? It should apply cleanly on

	https://gitlab.com/qemu-project/qemu.git master

and it doesn't contain any migration stuff on it.

Thanks,
Mauro

