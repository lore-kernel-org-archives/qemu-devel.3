Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8903C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3q5d-0007id-RV; Tue, 08 Sep 2026 03:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3q5a-0007iV-R3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:17:54 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3q5X-0006v0-P8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:17:54 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6887HeL6000189
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 16:17:40 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=64I2Kop2rHmEg6PBM8xWL0Aqx7cRdYlZt4Eq6KNMjGM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788851860; v=1;
 b=l9gZrO20k2lJZUTH8FPHN47bapuqzeOuJpM5UWFhuSwm2Or+4mxnLLnQ0Q9VH6/O
 qtX9YK0yepZR7rb6awDUtmRr7UZDLgTzHu+vEwoycQIrYjp2z3I1JfYBKWCxQgWu
 VAurb7+81ZBn5Pop5LJv/vN2Y2fXOWr31G4iDZjFu/fcu1FO+8L30vjxcxscXS/I
 e8HbIQpdQOvzY228rpXMcP1APAeEci+EXFemE8Vr9Eiwj+c+iyjgFF1rvKCgghgz
 kzAgdDtT7zixjhQ/+zPOijrnmAsUUgfdXIzba+YkbvT20XF5YRO2GO/Ru9/g67Ir
 j9Yfk0MY+wM1+P/u0Z9b9A==
Message-ID: <17689f1b-ff7a-4d08-9444-22201228bdb5@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 8 Sep 2026 16:17:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] runstate: separate forced and regular shutdown
 requests
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
 <20260904205749.510493-6-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904205749.510493-6-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2026/09/05 5:57, Vladimir Sementsov-Ogievskiy wrote:
> QMP quit, host signals and UI shutdown requests force QEMU to exit
> by setting shutdown_action to SHUTDOWN_ACTION_POWEROFF.
> 
> This can race with guest shutdown processing. With -no-shutdown,
> consider the following sequence:
> 
> 1. Management sends system_powerdown, then sends SIGTERM after
>     waiting for the guest to shut down.
> 2. QEMU starts processing a guest shutdown request.
> 3. SIGTERM arrives after qemu_kill_report(), while QEMU is sending
>     the guest SHUTDOWN event.
> 4. The signal handler changes shutdown_action to POWEROFF, so QEMU
>     exits instead of pausing.
> 
> Management receives SHUTDOWN with guest=true, but QEMU exits despite
> -no-shutdown, without reporting a host SHUTDOWN event or printing
> the signal diagnostic.
> 
> Store forced and regular shutdown requests separately, and decide
> whether to exit based on the request being processed. Leave
> shutdown_action under user control. A forced request arriving while
> a regular request is being processed remains pending for the next
> main loop iteration.
> 
> Keep qemu_shutdown_requested() checking both kinds of requests for
> its Xen caller.
> 
> There is no need to clear shutdown_force_requested with qatomic_xchg():
> processing a forced shutdown request always exits the main loop.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

