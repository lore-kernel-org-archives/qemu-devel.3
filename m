Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217E7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSzg-0002De-OY; Thu, 27 Aug 2026 01:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzSze-0002BU-FL; Thu, 27 Aug 2026 01:49:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzSzc-0005r8-Dz; Thu, 27 Aug 2026 01:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787809774; bh=LgqZ6FHHe6gN6TALmSpKwPlRU0R7ePB9tBgd4xqh/fs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=yJwDdAc/5dCd/Hdh45x3kzuMy7/re2FCEsyWwjJZn18Hl9VxdOrQFQ8j3wvUO6ctk
 SXRyj2HTMbWCVcv36CkunxZsYCxeOStOj0AEeSkDGAkBbl4VXplFyJeIXnYjwtJxMg
 zWm8V+3D8vhXrz8kAamgmpocdMCH6veWYdVa6nDskb1EwWPW40W482ZPu9cd103xDn
 hLDIQBCWcYhysRmkihXabAVyHESPt3kU/XoEQs3bwuUsVBHU4aicDOXkQDm8eURfb+
 57vqjHulgF5yC4n3O/WsNhKnkaYc06n75AW0hyk7afoOo1kcVdyWxH4/i/ps3OrTgx
 Vbs7GTkf8lWsA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 777CF1CEFAD;
 Thu, 27 Aug 2026 08:49:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B0EBB418DA6;
 Thu, 27 Aug 2026 08:49:36 +0300 (MSK)
Message-ID: <172a17a4-9438-4536-ba51-a5e649e435d9@tls.msk.ru>
Date: Thu, 27 Aug 2026 08:49:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
To: Joel Stanley <joel@jms.id.au>, nendensu@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, farosas@suse.de, lvivier@redhat.com
References: <20260802113130.7818-1-nendensu@ispras.ru>
 <e350bfda-cd57-4b25-9c72-40585e30a488@tls.msk.ru>
 <a985157941bd10429a3048618e3fb977@ispras.ru>
 <CACPK8XfEQnEqQ923ag8kWXcvBNsxmUKZK_dCdUm-AddD2Mf0dg@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CACPK8XfEQnEqQ923ag8kWXcvBNsxmUKZK_dCdUm-AddD2Mf0dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/27/26 08:18, Joel Stanley wrote:
> On Thu, 27 Aug 2026 at 07:57, <nendensu@ispras.ru> wrote:
>>> I'm picking this patch set for the currently active qemu stable
>>> series (10.0 LTS, 11.0, 11.1).  However, it does not work on
>>> 11.0.x already (it works ok on 11.1.x), the test fails:
> 
>>> Should I pick something else for 11.0 and 10.0 (on 10.0 it fails the
>>> same way),
>>> so the test succeeds, or should I drop this patch set from 11.1.x?

>> Thank you for testing. From my runs it seems that 10.0, 11.0 lack commit
>> 569aa628 (target/riscv: tt-ascalon: Enable Zkr extension), which enables
>> Zkr for tt-ascalon, so reading the seed triggers an assertion in
>> csr_call. Apologies if I`m missing something here. I`m not sure which is
>> better for stable: backporting 569aa628, or skipping the test patch.

Aha.  This is why I'm asking - I don't know much about riscv internals :)

Ivan, there's nothing to apologize about, you did nothing wrong in this
context, - it is just me who does not have knowledge about all these riscv
details, what does it all mean, and which parts are important or not.

> Backporting 569aa628 seems reasonable to me.

I agree it's best to pick up 569aa628 too, this is my initial thought when
I was reading reply from Ivan.

However it has another issue: this commit works fine on 11.0.x, but 10.0.x
pre-dates RISCVCPUDef conversion.

As far as I can see, 569aa628 is about TYPE_RISCV_CPU_TT_ASCALON, and hence
it is 09ef7d97454 "target/riscv: convert TT Ascalon to RISCVCPUDef", so in
10.0.x it becomes:

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bf4855ec02d..5e37cc3645d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -646,6 +646,7 @@ static void rv64_tt_ascalon_cpu_init(Object *obj)
      cpu->cfg.ext_zba = true;
      cpu->cfg.ext_zbb = true;
      cpu->cfg.ext_zbs = true;
+    cpu->cfg.ext_zkr = true;
      cpu->cfg.ext_zkt = true;
      cpu->cfg.ext_zvbb = true;
      cpu->cfg.ext_zvbc = true;

(the RISCVCPUDef conversion made this stuff a bit more difficult
to see in a diff, since now the diff does not show which cpu type
the change belongs to).

With that, it all should work, and I'm picking it up for the
next stable series.

But overall, it looks like it all is a rather niche thing, and
might not really belong to stable series at all (*).  Since we
already spent quite some time on this and resolved all issues,
let's pick it up anyway :)

(*) I mean, all these small fixes together, which should be
either picked up or not, but all together, - 569aa628, this
patch I'm replying to, and the test for it.

Thanks,

/mjt

