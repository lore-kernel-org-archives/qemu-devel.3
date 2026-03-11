Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A76BFCC9AA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 05:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0C25-0000se-L0; Wed, 11 Mar 2026 01:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0C23-0000sK-N1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:22:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0C21-00077D-H0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:22:55 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62B5LvNg051565
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Mar 2026 14:22:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9E49d38iwUBrmP1kE69pJ+S4dipqphuUO8U3yrBg9I4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1773206568; v=1;
 b=GQ3HxG//b5+BO+sr9tf0dEzQHaAJTaV+kveSWtGWGyDIewGUE4lVaQt65dV6c0MS
 wAPscw4jWM27ImlwV06K9Ico6s0H/odJVNTxRsuLozHyZGsytsaR7/Kd0FfdjNwh
 ZrhLKIJR5fU1ydTVvSC28lEhE1sd7ux+EW6kd3w+IwricSeC3kSrjR11b1jg3ySJ
 NTB//pRJ+j/G1zuoCwneo5A4YSxI47xmJv1TmN3CvuQHym8KPXpO/DNgC/JPS4i/
 1zFqIbo//6o/8pwdjxnVXhshdJViaZ1WyiXySI3k8fi/9d65B7TA1ULdab7FmBxg
 j75HN+n7ECxaCBknvOne5A==
Message-ID: <04fa350a-b181-483b-8cbd-2ba5171174ba@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Mar 2026 14:21:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-11-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260311025340.1335673-11-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 2026/03/11 11:50, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Since, there is no effective way
> to determine where the backing storage is located, we first try to
> create a dmabuf assuming it is in memfd. If that fails, we try to
> create a dmabuf assuming it is in VFIO device region.
> 
> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> backing storage is located in a memfd or not. If it is not, we invoke
> the vfio_device_create_dmabuf_fd() API which identifies the right
> VFIO device and eventually creates a dmabuf fd.
> 
> Note that, for mmapping the dmabuf, we directly call mmap() if the
> dmabuf fd was created via virtio_gpu_create_udmabuf() since we know
> that the udmabuf driver supports mmap(). However, if the dmabuf was
> created via vfio_device_create_dmabuf_fd(), we use the
> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Now I think this patch implements proper handling of all error 
conditions and conforms the convention.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

