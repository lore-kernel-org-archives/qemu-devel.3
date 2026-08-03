Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543DEC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqozB-0006Lh-BV; Mon, 03 Aug 2026 05:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wqoz9-0006L1-8F; Mon, 03 Aug 2026 05:29:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wqoz6-00038Y-Gg; Mon, 03 Aug 2026 05:29:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6739T7Nr044163
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Aug 2026 18:29:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wL/69n1w7a/LpiRdKQC1edtK0XiimSwMFXJyjvXFOgM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785749348; v=1;
 b=X6J4wG9p8RGTu1/N9Z0X3f5YVNCYISnckOOEQRli1lnqEv4xhP58DlzM7Pl4a/uP
 vm8EY12ZPEbGJocW+2HEJGqVX82y+V4cSh4uS1w31b+LOjHwuHErB+fx1pfemHDk
 lzvVkW9rLNZ3/VCuiQ4vIKorjrKHRMRhi4a9z9zxkgWrnXqfR8E3TPhUVkFRQ/7c
 LBVmqU0ZV4i1lymRQPGm/aJC/msWIfasAw1Cj08UR7Rc/+OJO/b9R3fJsCfwrbxz
 nbjzIT23QC3Y6LXJfeWE/Ufv9xMfylRt4Jx2F+9f8O3TUMejpX7kTeT1Jzd7GXxx
 +sTqByf3KNT1hBpSoxyzSA==
Message-ID: <96477e95-4eed-4d07-abaf-9d3795722f4e@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 3 Aug 2026 18:29:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Unmap DMA regions on reset
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
References: <20260803082158.62998-1-guobin@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260803082158.62998-1-guobin@linux.alibaba.com>
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

On 2026/08/03 17:21, Bin Guo wrote:
> virtio_gpu_reset() freed in-flight commands without unmapping the
> DMA regions acquired by virtqueue_pop().  Call virtqueue_detach_element()
> before g_free() in both drain loops.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3467
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

