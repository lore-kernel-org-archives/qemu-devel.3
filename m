Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B7FE87822
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFKZ-0001wu-Su; Tue, 03 Feb 2026 07:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vnFKN-0001se-4B
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:16:20 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vnFKJ-0003JN-SA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:16:18 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 613CF1El088794
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Feb 2026 21:16:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ad3gBoKGRG5Bq20NGv+b002hLbxD/JUh7WCRLHEfdtA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770120967; v=1;
 b=Gw4uvF13VpBxIb+ISnhgsMIus80ZyA2mxwYxxs5+FezkQGFUSxiUSgLGnc1Vltho
 Yxw+i+VxmzbPw4bRSRKObnioHRCuHrY/OuKSHa7fBhUWKMrfcNqSNdjtoy9Ni48W
 uUzqAf0XqJJYu/0s3aM7ZLn/OUN0i42xmPa0WBQSS2EllmefvY8X8+8gdMbIOvSy
 Nv5dRLSc1QMldSWzLesgEbp4ZWNgo4PEg3k3YLsOF4QgqAS0rXJYCdmCow9UPdJY
 XehKDDCQ7uK0dqxo0PR2avkOEysHIqOOBE5Vwy0sAT1xmspIh0B1p86yCGGDYVmk
 kzorn+4pSIYbQXnO4z4S+g==
Message-ID: <3c9c5b16-f4cd-46b8-9596-d7f9260963d6@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Feb 2026 21:15:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] virtio-gpu-dmabuf: Remove rcu_read_lock/unlock
 from virtio_gpu_create_udmabuf()
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-5-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260203073200.848183-5-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/02/03 16:30, Vivek Kasireddy wrote:
> There is no need to wrap the call to qemu_ram_block_from_host() with
> rcu_read_lock/unlock as we already hold a reference to the memory
> region that owns the ram block. Note that, the reference was obtained
> via dma_memory_map() while creating the mapping.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

