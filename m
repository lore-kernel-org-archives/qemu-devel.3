Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F85CF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOF4-0004bO-TL; Wed, 07 Jan 2026 02:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vdOEd-0004X3-9I
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:45:44 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vdOEY-0002eu-G9
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:45:36 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6077iXnB056946
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Jan 2026 16:45:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8LqQRAhedECX0k+LVAQkCgtwPmQobEqQdKN8XCQxZu8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1767771921; v=1;
 b=ixKJfGF8IRvN6Hh7ctc9V09huECM11Okvr5gv+kkdg5dBNIOgVWPRN7FQt1rnGmw
 Ux+vYSuKQfG4fElXav7DVlQJB0e7QgTgSROYKQ/KA3eK8JWxltpZuyk5M5Dpe61s
 z5OBb0U131ZraIgSLh/KNltxM8AX7DwDzj6f94DcUQ/Lz/c61Q4P7qWm8X9budiW
 jck3RKYvhKrFHSIGUAxTbqRxKoNz5ORjhzNJ1h91Vf/v2kOJhQgKfQk+EpOOrLNb
 RW5NBYebFzwQUbqX1b/gTkFVr0wbD8HzC13gSMYNmV0hvNcYkGBG2+nMzmHAo/4P
 oe4+YFtqS0vw3/+gPyghbQ==
Message-ID: <aab424e2-a763-4d4a-ab73-62dd9b570b7f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 7 Jan 2026 16:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] virtio-gpu: Add ROCm capability support
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, Ray.Huang@amd.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260107071858.3452614-1-honghuan@amd.com>
 <20260107071858.3452614-4-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260107071858.3452614-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/01/07 16:18, Honglei Huang wrote:
> Add support for ROCm (Radeon Open Compute) capability in virtio-gpu.
> This enables GPU compute workloads using AMD's ROCm platform through
> the virtio-gpu interface.
> 
> Changes include:
> - Add "rocm" property to virtio-gpu-gl device
> - Define VIRTIO_GPU_FLAG_ROCM_ENABLED flag
> - Enable VIRGL_RENDERER_USE_ROCM flag when ROCm is enabled
> - Register VIRTIO_GPU_CAPSET_ROCM (capset 8) capability
> - Add virtio_gpu_rocm_enabled() helper macro
> 
> This allows guests to detect and utilize ROCm capabilities through
> the virtio-gpu device when the feature is enabled.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

