Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4036BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFu0F-0006FD-LT; Mon, 03 Nov 2025 07:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vFu0A-0006DV-Ku
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:49:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vFtzv-0002yd-Nq
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:49:38 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A3CnIwc034813
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Nov 2025 21:49:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Q3ILHXgrZ6ZT6pYcxFSVFsiMZASUfL8RFJpDFMOCVzc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762174159; v=1;
 b=sOjgyO3MVjpVE4IM1J8ozvBBMatuyuIOosgjvwY1hVtQDBxZjT0xKQQnesDpVNIn
 xIgtChgLQdnlfgufnSr7V/FgynrD9/5f7ALxdxn/QSUD9n6h9R0xCEd/Qmu5fihE
 ksht3+bOF8vsEniu0VevWckjBya5Q4VsKMRj/Ak5CrN37Mxm1HU3V9CkmSGMuvsi
 wslMwSA2om2upnRUm3AQASSu0+ugpZrwKNBVVGEm8EFk6P6nPyNJR/6aSuAHgE1m
 aHpGijnFNPRKsVBwLLbheMjdFtUAEjjkLeRZctwXz6YlLJsm+s/TMU4ecotzlUy4
 R521/x5C5Fv5GRJbCGfgBA==
Message-ID: <5d11cd75-ad86-431a-903e-a50031704c08@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 3 Nov 2025 21:49:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng@tinylab.org>
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
 <baaef09f-444c-42b0-a267-49d2c311d10a@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <baaef09f-444c-42b0-a267-49d2c311d10a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2025/11/03 20:36, Philippe Mathieu-Daudé wrote:
> (Cc'ing Akihiko)
> 
> On 28/10/25 17:00, Peter Maydell wrote:
>> In commits like 969e50b61a28 ("net: Pad short frames to minimum size
>> before sending from SLiRP/TAP") we switched away from requiring
>> network devices to handle short frames to instead having the net core
>> code do the padding of short frames out to the ETH_ZLEN minimum size.
>> We then dropped the code for handling short frames from the network
>> devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
>> Remove the logic of padding short frames in the receive path").
>>
>> This missed one route where the device's receive code can still see a
>> short frame: if the device is in loopback mode and it transmits a
>> short frame via the qemu_receive_packet() function, this will be fed
>> back into its own receive code without being padded.
>>
>> Add the padding logic to qemu_receive_packet().
>>
>> This fixes a buffer overrun which can be triggered in the
>> e1000_receive_iov() logic via the loopback code path.
>>
>> Other devices that use qemu_receive_packet() to implement loopback
>> are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
>> and sungem.
>>
>> Cc: qemu-stable@nongnu.org
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

