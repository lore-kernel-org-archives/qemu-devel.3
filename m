Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E711C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1JA-0002Bn-DV; Thu, 07 Aug 2025 10:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uk1J8-0002B5-1H
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:09:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uk1J4-0003Bw-FR
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:09:25 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 577E9C20001621
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 7 Aug 2025 23:09:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KXJ/VPXkbp5FDzsJJIBMHEhlPz63v7PSZ4VycQrQalc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754575752; v=1;
 b=muiJyDJzODf9FJzt41lfdhpi4TBMNDdP3549d9DXRlkiO3EpsH/KAz918ZebBBqk
 PVWwnboIY2e7MRiqz+Umih0opax/cIWxHUJH5fJyGeX/WBglhvN3k2VGjwvcgDFt
 lZEycnmISfjfJBEtSo10/LEVmw2I1kKsMuRLgFMM+WIN1k42fjIuziG1sCWlo3SV
 CBk1ThOr3IwreIYYupwMuUhnlw+JogwDcIerav374TxMGBrFSuDPgEqt1wlGVitI
 8NMPoBOM9tlahaOk0DHpE1cJ+MClUycHzueZXXENCbEYK87XixfMOkSjMu5HDLQF
 4Yfu36vJBUVrwo0ogkeGjA==
Message-ID: <49f106e2-2c57-4926-a0da-4ed4c8ae2816@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 7 Aug 2025 23:09:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing
 after MSI-X enable
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20250807110806.409065-1-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250807110806.409065-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/07 20:08, Laurent Vivier wrote:
> A race condition between guest driver actions and QEMU timers can lead
> to an assertion failure when the guest switches the e1000e from legacy
> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
> RDTR) is active, but the guest enables MSI-X before the timer fires,
> the pending interrupt cause can trigger an assert in
> e1000e_intmgr_collect_delayed_causes().
> 
> This patch removes the assertion and executes the code that clears the
> pending legacy causes. This change is safe and introduces no unintended
> behavioral side effects, as it only alters a state that previously led
> to termination.
> 
> - when core->delayed_causes == 0 the function was already a no-op and
>    remains so.
> 
> - when core->delayed_causes != 0 the function would previously
>    crash due to the assertion failure. The patch now defines a safe
>    outcome by clearing the cause and returning. Since behavior after
>    the assertion never existed, this simply corrects the crash.

This description is better than my comment written in haste. Thank you 
for taking care of this.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



