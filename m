Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D232FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBaG-0003qk-JI; Tue, 09 Apr 2024 09:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1ruBaA-0003qG-N6
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:32:15 -0400
Received: from new-mail.astralinux.ru ([51.250.53.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1ruBa8-0007CU-Ok
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:32:14 -0400
Received: from [10.177.20.58] (unknown [10.177.20.58])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VDRhR2TzGzqSP6;
 Tue,  9 Apr 2024 16:32:07 +0300 (MSK)
Message-ID: <5263ef36-0b82-48fe-a351-b557ead15b01@astralinux.ru>
Date: Tue, 9 Apr 2024 16:31:27 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] hw/dma: prevent overflow in soc_dma_set_request
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>,
 sdl.qemu@linuxtesting.org
References: <20240409115301.21829-1-abelova@astralinux.ru>
 <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
Content-Language: ru
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepvdegleehkeejueehledvhffhuefhieejudevvdejtdeukefghffgveegteeikeeunecukfhppedutddrudejjedrvddtrdehkeenucfrrghrrghmpehhvghloheplgdutddrudejjedrvddtrdehkegnpdhinhgvthepuddtrddujeejrddvtddrheekmeegjeeluddtpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhhrohhgghesghhmrghilhdrtghomhdprhgtphhtthhopehsughlrdhqvghmuheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB;
 Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12586520,
 Updated: 2024-Apr-09 11:29:40 UTC]
Received-SPF: pass client-ip=51.250.53.164; envelope-from=abelova@astralinux.ru;
 helo=new-mail.astralinux.ru
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



09/04/24 15:02, Peter Maydell пишет:
> On Tue, 9 Apr 2024 at 12:54, Anastasia Belova <abelova@astralinux.ru> wrote:
>> ch->num can reach values up to 31. Add casting to
>> a larger type before performing left shift to
>> prevent integer overflow.
> If ch->num can only reach up to 31, then 1 << ch->num
> is fine, because QEMU can assume that integers are 32 bits,
> and we compile with -fwrapv so there isn't a problem with
> shifting into the sign bit.

Right, thanks for your comments.
I didn't know about this flag before. It became more clear for me now.

Thanks,
Anastasia Belova



