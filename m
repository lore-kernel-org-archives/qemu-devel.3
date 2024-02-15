Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A865BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 23:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ralIf-0006r0-JG; Thu, 15 Feb 2024 18:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1ralIe-0006qq-7m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 18:37:52 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1ralIb-0008CP-Vk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 18:37:51 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 4A03E40B2786;
 Thu, 15 Feb 2024 23:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4A03E40B2786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708040266;
 bh=DztajrB+m5ErEtF9hQbiEUPOsoufJ29QLMWxwyoP744=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Iyuj6JvEANBHygZGOlfGTfnZ5u1qSh1MKhJVKOcrNB5ymxPekCIanVEVQ2Bnjwlaw
 O13lhJ3VMFcmmG14OZikVlSVBVnLv+NijV3bZsLw18Olm5ZDJOLyLowxW8CyM1GHfi
 i/sYcfoY3/vz6lx6sfPo12FPKz14h7PhzmyaEgRc=
Date: Fri, 16 Feb 2024 02:37:46 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
In-Reply-To: <2d211317-873e-43c6-a246-bd8bf84f048b@linaro.org>
Message-ID: <aa9996fb-a5f8-25aa-96dd-48e4797967e1@ispras.ru>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
 <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
 <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
 <2d211317-873e-43c6-a246-bd8bf84f048b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


On Thu, 15 Feb 2024, Richard Henderson wrote:

> > Converting a 4.4 GiB Windows 10 image to qcow2. It was mentioned in v1 and
> > v2,
> > are you saying they did not reach your inbox?
> > https://lore.kernel.org/qemu-devel/20231013155856.21475-1-mmromanov@ispras.ru/
> > https://lore.kernel.org/qemu-devel/20231027143704.7060-1-mmromanov@ispras.ru/
> 
> I'm saying that this is not a reproducible description of methodology.
> 
> With master, so with neither of our changes:
> 
> I tried converting an 80G win7 image that I happened to have lying about, I
> see buffer_zero_avx2 with only 3.03% perf overhead.  Then I tried truncating
> the image to 16G to see if having the entire image in ram would help -- not
> yet, still only 3.4% perf overhead.  Finally, I truncated the image to 4G and
> saw 2.9% overhead.
> 
> So... help be out here.  I would like to be able to see results that are at
> least vaguely similar.

Ah, I guess you might be running at low perf_event_paranoid setting that
allows unprivileged sampling of kernel events? In our submissions the
percentage was for perf_event_paranoid=2, i.e. relative to Qemu only,
excluding kernel time under syscalls.

Retrieve IE11.Win7.VirtualBox.zip from
https://archive.org/details/ie11.win7.virtualbox
and use

  unzip -p IE11.Win7.VirtualBox.zip | tar xv

to extract 'IE11 - Win7-disk001.vmdk'.

(Mikhail used a different image when preparing the patch)

On this image, I get 70% in buffer_zero_sse2 on a Sandy Bridge running

  qemu-img convert 'IE11 - Win7-disk001.vmdk' -O qcow2 /tmp/t.qcow2

user:kernel time is about 0.15:2.3, so 70% relative to user time does
roughly correspond to single-digits percentage relative to (user+kernel) time.

(which does tell us that qemu-img is doing I/O inefficiently, it shouldn't
need two seconds to read a fully cached 5 Gigabyte file)

Alexander

