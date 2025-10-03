Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F39CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 12:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4fJ7-0008Go-7K; Fri, 03 Oct 2025 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4fJ4-0008GW-IL
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:54:42 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v4fIv-0000mK-ER
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 08:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=HveuNEzCYNZyTQNqO623viwDj8OzelviOOyMq2URvqs=; b=SoYpE0q0Sm+jiTw
 do8PLAFljWdnAOjCZT4zoeyAWIgp8DuqTjfzVaKYuQwbJaxTsaHh+1f5eA8j2DAv1QhrMRRdRtik3
 xChjZLbPn1oydlof5O3bVb7hi/tyqXhmT7xG93AxOS39mzC65jHEftqnSz4pXZs1lRv+oZl4Tl+0Z
 zY=;
Date: Fri, 3 Oct 2025 14:57:02 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 33/33] target/riscv: Make pmp.h target_ulong agnostic
Message-ID: <wd2hrjsjshwazzwwfkuktq6cwlswyuzaii6yi3ac3cy6rbwteb@lrlrgjhzhnco>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-34-anjo@rev.ng>
 <c319d6f0-abad-4576-a0bc-67f3e68bcbd9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c319d6f0-abad-4576-a0bc-67f3e68bcbd9@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 01/10/25, Philippe Mathieu-Daudé wrote:
> On 1/10/25 09:33, Anton Johansson wrote:
> > The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
> > CPUArchState.  CSR declaraions are only used in target/ and are moved to
> 
> Typo "declarations".
> 
> > csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
> > parameter is fixed to 8 bits, similar to previous commits.
> 
> Worth a privilege_mode_t typedef?

I think this makes sense, will add in v3!

