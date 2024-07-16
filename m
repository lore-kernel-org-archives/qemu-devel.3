Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F193C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTe5Y-0003Ld-4F; Tue, 16 Jul 2024 05:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sTe5R-0003JE-Gp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:03:06 -0400
Received: from smtpout01-ext2.partage.renater.fr ([194.254.240.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simon.Hamelin@grenoble-inp.org>)
 id 1sTe5P-0000hd-Ls
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:03:05 -0400
Received: from zmtaauth05.partage.renater.fr (zmtaauth05.partage.renater.fr
 [194.254.240.27])
 by smtpout10.partage.renater.fr (Postfix) with ESMTP id CCC9C63C90;
 Tue, 16 Jul 2024 11:02:50 +0200 (CEST)
Received: from zmtaauth05.partage.renater.fr (localhost [127.0.0.1])
 by zmtaauth05.partage.renater.fr (Postfix) with ESMTPS id 8EE10200DC;
 Tue, 16 Jul 2024 11:02:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmtaauth05.partage.renater.fr (Postfix) with ESMTP id 7B67F201F9;
 Tue, 16 Jul 2024 11:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth05.partage.renater.fr 7B67F201F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
 s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1721120542;
 bh=WB8uX7VshZX8TQ0upnmN3iTdgugu9Fx+mHxWiOS1p9A=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=eGo8iTAk0m4GEOGFH7wR5d79SOP3zBpTXQ1dYJnfDaM0eHuPDQhGZLiybsvRJtjkP
 5ph6oA2BIU1kg3XDATglAPToCSqbbREVkLkTwbEyzA/kSrpWrYJsl6GduzlwE50xvC
 0SBAqRdaHOiCciqdRNDSGzsdVIH+6/7gn+mUywcfEocGE02qr8xn8+Lz8lIELwRAvd
 NLDKS/wxLJD1grq3c09nGUm/FQ3DgJij2l0zCiPf3FPgAruJ8ZqhnC1BrDNLUByjqS
 JodS5T1yl3yU7JnkldIwyrvA9+DDViECqjt6r2ryV00aW8cHI0RHNu4aBL5H9rjjBW
 UOhEqwvZGV7Rw==
Received: from zmtaauth05.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth05.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EHgxgg1zmMuY; Tue, 16 Jul 2024 11:02:22 +0200 (CEST)
Received: from 188.231.11.184 (unknown [194.254.241.251])
 by zmtaauth05.partage.renater.fr (Postfix) with ESMTPA id 0BC3F200DC;
 Tue, 16 Jul 2024 11:02:21 +0200 (CEST)
Message-ID: <b964ae7b-6ae4-43a4-b886-70e8e9875f58@grenoble-inp.org>
Date: Tue, 16 Jul 2024 11:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
 <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
 <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
 <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
 <4967cfde-65d0-46ac-8956-a23eb9836e90@linaro.org>
Content-Language: en-US
From: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>
In-Reply-To: <4967cfde-65d0-46ac-8956-a23eb9836e90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.8 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepufhimhhonhcujfgrmhgvlhhinhcuoefuihhmohhnrdfjrghmvghlihhnsehgrhgvnhhosghlvgdqihhnphdrohhrgheqnecuggftrfgrthhtvghrnhepfefhjeektddtvdffgfdtieelgeeigeevtddtuefgfeelhfdutdfftddtleegleeunecukfhppeduleegrddvheegrddvgedurddvhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdehuddphhgvlhhopedukeekrddvfedurdduuddrudekgedpmhgrihhlfhhrohhmpefuihhmohhnrdfjrghmvghlihhnsehgrhgvnhhosghlvgdqihhnphdrohhrghdpnhgspghrtghpthhtohepjedprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegvrhgunhgrgigvsegtrhgrnhhsrdhorhhgpdhrtghpthhtohepmhgrrdhmrghnughouhhrrhesghhm
 rghilhdrtghomhdprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgh
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=194.254.240.33;
 envelope-from=Simon.Hamelin@grenoble-inp.org;
 helo=smtpout01-ext2.partage.renater.fr
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_HELO_IP_MISMATCH=2.368, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 7/16/24 01:08, Pierrick Bouvier wrote:
> On 7/15/24 01:09, Simon Hamelin wrote:
>> Hello Pierrick,
>>
>>> Could you share a bit more information on the final goal, if possible=
?
>>> Is that used for fuzzing binaries, security analysis, or other things=
?
>>
>> I'm currently using this plugin for security analysis purposes.
>> Basically my goal is to simulate fault injection using QEMU. To do so
>> I'm using this plugin along with another plugin that skips an
>> instruction at a given address. With this plugin I'm able to see how t=
he
>> program reacts to the fault and stop it with a custom return code.
>> Basically there are 4 cases:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - The fault does not disrupt the program and =
it reaches the expected
>> address.
>> =C2=A0=C2=A0=C2=A0=C2=A0 - The fault disrupt the program and it reache=
s an unexpected address
>> known as the "target" address.
>> =C2=A0=C2=A0=C2=A0=C2=A0 - The fault disrupt the program in such a way=
 that it executes a lot
>> of instructions without reaching the expected address, this situation =
is
>> known as a "timeout".
>> =C2=A0=C2=A0=C2=A0=C2=A0 - The fault crashes the guest, causing it to =
reach an error handler
>> address.
>>
>=20
> Thanks for sharing this, it's an interesting use case.
>=20
> How did you implement instruction skipping?
> Is that based on current API, or do you have a QEMU fork?
>=20

I had to extend the current API to support writing guest registers,=20
specifically I'm skipping instructions by writing to the PC register. To=20
do this I use the set_pc function of the CPUClass struct. This requires=20
a bit of a hack to make the TCG react to the PC change as it's normal=20
behavior is to execute the entire TB and ignore the PC change. To make=20
the TCG react to this modification the only way I've found is to leave=20
it midway it's execution using the `cpu_loop_exit` function.


