Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B10E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 08:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqLf-0004Zj-E7; Sat, 07 Dec 2024 03:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqLd-0004Z6-Ca; Sat, 07 Dec 2024 03:39:33 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqLb-0008MM-Uu; Sat, 07 Dec 2024 03:39:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D68A4A4042B;
 Sat,  7 Dec 2024 08:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F830C4CECD;
 Sat,  7 Dec 2024 08:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733560770;
 bh=5/pUUungQ8NgDYyXV69cVH1mhMQviRIiv82xmjhsv8Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=q0aRBymLLvkn7rpU7sHaKpPTbGSp7brUEOpZ+lM3xFLznQBE1CPRNcggMoMTHMHYk
 a0WxS1DuPP2uMWnEvsFz3Sxi/lBFNGu/4X18volPeA+xfeNA6szsffVYP2Ihb60Z3h
 /Q+Px8YsWA6akm1fX/WpeVXE5+9na3LcjKxMKltM3RnT0fS7NmAY0WKFe9yMbssVOn
 RgD1/dkGqzmOMP8NydhXGZsq+4+An267qUuEYkamqMUdcCVPge6224btqcR1QbdmaE
 cLDE2fLOxt09JXry6/bE1sqDsrOdog0vrJccUMIc0gxPOyWpdz1h3Jjug6hYazgOo1
 /GsdPgkQ45P+g==
Date: Sat, 7 Dec 2024 09:39:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, John Snow
 <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Michael
 Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/31] Prepare GHES driver to support error injection
Message-ID: <20241207093922.1efa02ec@foz.lan>
In-Reply-To: <87wmgc2f48.fsf@pond.sub.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
 <87frn03tun.fsf@pond.sub.org> <87wmgc2f48.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Sat, 07 Dec 2024 07:15:19 +0100
Markus Armbruster <armbru@redhat.com> escreveu:

> Markus Armbruster <armbru@redhat.com> writes:
> 
> > This is v10, right?  
> 
> Scratch that, the cover letter explains: "As agreed duing v10 review,
> I'll be splitting the big patch series into separate pull requests,
> starting with the cleanup series.  This is the first patch set,
> containing only such preparation patches."

Please scratch this series. It seems I picked the wrong git range,
sending a lot more patches than intended.

> However, it doesn't apply for me.  What's your base?

That's weird. Despite my mistake, the series is based on v9.2.0-rc3 
(which was identical to master last time I rebased).

Should it be based against some other branch?

Thanks,
Mauro

