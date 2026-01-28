Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A0D35669
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 04:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkxD0-0001nQ-Vu; Tue, 27 Jan 2026 23:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkxCw-0001kr-6D
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 23:31:10 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkxCq-0007nL-Ad
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 23:31:08 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60S4Uf1A001206
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 28 Jan 2026 13:30:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=t8jtmIKHhce1tBd4zdvRBX9x9by8EtUiMbFM/BLWxqY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769574657; v=1;
 b=tXaUla+aIdG8jmAoEsAC1lPsFnFnjIbADIQMwTwAGqqm0VWZ3yZSppjWu2YTZ3iH
 2i1fShupY/nA3fsjaTQPW9TCGVviwkkecPIC5rxv52XK9LEV2xphAKLfCag4KQj9
 vdf/QTMXvvaCxj/6u/+/rq7MxtTKKvuV2BO6SokjE1FO88eiIPwqKRPYqf6oBC17
 1h/u2j9WkfCKpbe7rnL+ik8i3qkwio8blCOqNvl+zHnjghTf2iLeA9iy8zFGLfI7
 bSPjVd2jWafDd4znlRtYooFhL0cSsph/Gs8Cfy//VEM1UX9ngO1aF1gMTBZNeitd
 IOD5f+2qcAGbFHaZxC3jow==
Message-ID: <17790d75-c0f3-41b5-9bb5-a7b47aa29548@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 28 Jan 2026 13:30:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rutabaga: improve error handling, fix potential crash
 during init
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260127122400.100384-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260127122400.100384-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/01/27 21:24, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When virtio_gpu_rutabaga_get_num_capsets() returns 0, virtio_init()
> isn't called and the device later crashes during realize.
> ==72545==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x556ad6f7ba9e bp 0x7ffe6958f810 sp 0x7ffe6958f7e0 T0)
> ==72545==The signal is caused by a READ memory access.
> ==72545==Hint: address points to the zero page.
> #0 0x556ad6f7ba9e in virtio_memory_listener_commit ../hw/virtio/virtio.c:4034
> #1 0x556ad6a24c96 in listener_add_address_space ../system/memory.c:3128
> #2 0x556ad6a25d15 in memory_listener_register ../system/memory.c:3216
> #3 0x556ad6f7bf11 in virtio_device_realize ../hw/virtio/virtio.c:4075
> 
> Rework error handling of the function to set Error appropriately. 0
> capset may be ok now.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

