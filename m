Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B192ACCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCyt-00021A-Ne; Tue, 04 Nov 2025 04:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGCyr-00020x-5W
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:05:33 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGCyo-0004Cc-DP
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:05:32 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A46BroJ066974
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Nov 2025 15:11:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vJXoNSLq1HP2/YSiFDQmAhvS1vRbsG+ZOiNcFBFkb/I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762236714; v=1;
 b=OXaDK1qhg+fSuWO957UmMDRxdNb5VadtCRDKjJS6fLLBSykQ0X6xJa/J/xCV8Hwn
 Fb+U6ptYGaOnmHwXbZYfATMRQHZBPN9VzsRVyTrjOjXYugLcGaA9UjKHvnzaPrhg
 WfP8XThcEGPFR51g0mT+pvjAioVO5ZX4nwYFNHjkwSe1ZHQnudtblmJHp/QHm8gS
 WkUFnYjuNR+SbaNxTobSRHYR4PwqtcqbAgevx2//ByIfn4bkSO/gFQ+XS36gkyLC
 KEY5L4vmyft85hBwetlTioV/3zwbZ3P2V4XEdDJyId+qhaPEAQ2oJ2aKcghuw6Hs
 h/az0meGXXEJs+N0EVTDeQ==
Message-ID: <43eda65c-be7a-4e3d-86ba-89d2e8af91d6@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 4 Nov 2025 15:11:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/net/e1000e_core: Don't advance desc_offset for
 NULL buffer RX descriptors
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20251103175851.428816-1-peter.maydell@linaro.org>
 <20251103175851.428816-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251103175851.428816-2-peter.maydell@linaro.org>
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

On 2025/11/04 2:58, Peter Maydell wrote:
> In e1000e_write_packet_to_guest() we don't write data for RX descriptors
> where the buffer address is NULL (as required by the i82574 datasheet
> section 7.1.7.2). However, when we do this we still update desc_offset
> by the amount of data we would have written to the RX descriptor if
> it had a valid buffer pointer, resulting in our dropping that data
> entirely. The data sheet is not 100% clear on the subject, but this
> seems unlikely to be the correct behaviour.
> 
> Rearrange the null-descriptor logic so that we don't treat these
> do-nothing descriptors as if we'd really written the data.

Please make a corresponding change for igb too so that the code of these 
two devices will not diverge further.

Regards,
Akihiko Odaki

