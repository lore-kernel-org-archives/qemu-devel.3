Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB6EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQsH-000280-6s; Tue, 20 Feb 2024 09:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcPZT-000874-2E; Tue, 20 Feb 2024 07:50:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcPZN-0001jl-8B; Tue, 20 Feb 2024 07:50:00 -0500
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TfJyj50NZz1FKqW;
 Tue, 20 Feb 2024 20:45:01 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 6BC5E14040F;
 Tue, 20 Feb 2024 20:49:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 20:49:51 +0800
Message-ID: <51e60b23-039f-6c88-e141-f14148ec5846@huawei.com>
Date: Tue, 20 Feb 2024 20:49:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH 1/3] target/arm: Implement FEAT_NMI to support
 Non-maskable Interrupt
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240220121752.490665-1-ruanjinjie@huawei.com>
 <20240220121752.490665-2-ruanjinjie@huawei.com>
 <CAFEAcA8jef+ZqSaj7MOwkneuj5aLayA6MZA=-LH+VvcDuFCtZA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8jef+ZqSaj7MOwkneuj5aLayA6MZA=-LH+VvcDuFCtZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Feb 2024 09:13:26 -0500
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/2/20 20:31, Peter Maydell wrote:
> On Tue, 20 Feb 2024 at 12:19, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Enable Non-maskable Interrupt feature.
>>
>> Enable HCRX register feature to support TALLINT read/write.
>>
>> Add support for enable/disable NMI at qemu startup as below:
>>
>>         qemu-system-aarch64 -cpu cortex-a53/a57/a72/a76,nmi=[on/off]
>>
>> Add support for allint read/write as follow:
>>
>>         mrs <xt>, ALLINT        // read allint
>>         msr ALLINT, <xt>        // write allint with imm
>>         msr ALLINT, #<imm>      // write allint with 1 or 0
> 
> Can I ask you to break this patchset down into smaller
> coherent pieces, please? When you write a commit message
> that has this sort of "list of four different things the
> patch does" structure, that's a sign that really it ought to
> be multiple different patches that do one thing each.

Thank you very much! I'll break up the patches so that each one does
only one thing.

> 
> Do we really need the command line option? Mostly we
> don't add that for new CPU features, unless there's a
> strong reason why users might need to turn it off: instead
> we just implement it if the CPU type and/or the board has
> the feature.

Right! Thank you. I'll remove the command line option and just implement
it if the CPU has the feature.

> 
> thanks
> -- PMM

