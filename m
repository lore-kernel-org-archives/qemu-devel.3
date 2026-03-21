Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CAE1094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w40JO-0003jd-Mt; Sat, 21 Mar 2026 13:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w40JM-0003jM-EB
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 13:40:32 -0400
Received: from out-177.mta1.migadu.com ([95.215.58.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w40JJ-0007dt-DT
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 13:40:32 -0400
Message-ID: <52bfd375-8d11-4f8e-9d2c-5e3b3da0e8f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1774114817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk39WUP/HA/QX8Vo5Ri80ft5xkJpmyxGEQ1TBUs5OLE=;
 b=j8hBoINppDbBq2obfYiN0ji6t1uTJezTEDmtevbbrCA/JksaW+DpvoUzHEpP4HCx5z1TWn
 dvXqZG0S7O6tT2iXCM/1mWf/3qygrtKxWWIQIMI1I9r1KFLEnTCGc/RG1wmkYVdDSwiLGV
 p00r0gg/tRyejUEnuTBrGN/N2K9cox0=
Date: Sun, 22 Mar 2026 01:39:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, agraf@csgraf.de
References: <20260315163840.30741-1-zenghui.yu@linux.dev>
 <CAFEAcA_kj1eRpjMYDF4b6hD1_P0+PazzdHFfTJFj=Hn231DBGA@mail.gmail.com>
 <7c4ce7f4-7a50-40e3-b80f-e776eaac4984@linux.dev>
 <8D0BCB24-BB1B-40EF-A361-0F79D65600AE@unpredictable.fr>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <8D0BCB24-BB1B-40EF-A361-0F79D65600AE@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.177; envelope-from=zenghui.yu@linux.dev;
 helo=out-177.mta1.migadu.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/22/26 1:26 AM, Mohamed Mediouni wrote:
> 
> > On 21. Mar 2026, at 18:09, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > After hacking KUT to let the guest map a VA to IPA 0x1000000000 (an IPA
> > right after 64GB) and execute an insn on that VA, the guest receives an
> > insn abort with IFSC equals to 0x03 (Hello, AddressSize fault!). We can
> > _infer_ from that that the AddressSize fault is injected internally by
> > hvf.
> 
> Hello,
> 
> As far as I tell:
> 
> If the translation fails at stage-1, the fault is routed by hardware 
> to the guest directly instead of going to the hypervisor.

Oops,, you're right. Sorry for the noise on the AddressSize fault part.

Thanks,
Zenghui

> In the case where it’s not a valid IPA in the first place - instead
> of an unmapped one - the hardware triggers a fault to the guest instead
> of going to the hypervisor.
> 
> If the stage-1 translation is successful but the IPA is valid and not
> mapped, _then_ it gets trapped to the hypervisor, and gets routed to 
> user-space for VMM handling.
> 
> The EC_DATAABORT case happens on MMIO faults but the EC_INSNABORT 
> case is… more speculative for QEMU today.
> 
> I can see cases for doing it for on-demand page mappings in user-space
> though… where you’d map the page and then resume from the same PC.
> 
> With the current model QEMU uses I’d expect not handling EC_INSNABORT
> at all to not result in a functionality gap. 

