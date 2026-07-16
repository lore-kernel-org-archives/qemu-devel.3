Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F11DC43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkF8o-0004j0-Nz; Thu, 16 Jul 2026 02:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkF8j-0004ig-1J
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:00:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkF8f-00070F-0A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:00:08 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66G5xoQ4078615
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2026 14:59:50 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=p3T8H+35Bj0jpdSELxkg4tOieHkEL/tkkbmwQHlMA7A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784181590; v=1;
 b=t0foCETfKHPFAvd6iJhnVHCaodwpQDm/U267aBs9Pjcr6QBCcN6xAKSOqxrWbrs5
 FPIl+dqDMi4DMD0/hgXUalPHPhT9eOlCr6ii5Ek8DYD/sIFR6SfHxUXHbWU7ajaO
 iXqiJj3dMNb+BfEXqRv6/3T7j/UGNerbzEgNU/5F0CNapglngLyyn7Yr+ZCz/Neq
 EHVW8l/iEgkvgQkCjejnoYD4QNFNXbODYE8mBlrPdwymWCap/pA2UlW0/gQwuUzm
 QCkynpVY5iPS0jE1a2Z5yMk4no+/Zy41HMe5EpTTmGJ+P/HF775v8QFyo1/5qEXG
 13dxCK7Y7ubU1y4xhrfHng==
Message-ID: <252d8148-5abe-41ee-afcd-4cbf81fb79da@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Jul 2026 14:59:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] hw/display/virtio-gpu: validate command buffer size in
 submit_3d
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260713125410.105653-1-marcandre.lureau@redhat.com>
Content-Language: en-US
In-Reply-To: <20260713125410.105653-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/13 21:54, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
> g_malloc() without any bounds check. A malicious guest can set this
> field to an arbitrarily large value (up to 4GB), causing an OOM abort
> that crashes the QEMU process.

virtio-gpu-rutabaga has the same problem: it also makes a fatal
guest-sized allocation before copying the payload.

> 
> Validate cs.size against the actual descriptor payload size before
> allocating, rejecting values that exceed what the virtqueue entry
> can carry.

Unfortunately, this check does not bound the allocation. The descriptor
payload length is also controlled by the guest, and descriptors can
alias the same guest-physical range. For example, an indirect descriptor
table can repeat the following entry: addr = A, len = 4 MiB

With 1,023 such entries and one response descriptor, iov_size() reports
4092 MiB even though the entries refer to only 4 MiB of unique guest
memory. A cs.size of nearly 4 GiB still passes the proposed
check and reaches g_malloc().

I surveyed the command formats to find a suitable upper bound, but there
is no common protocol limit:

For virgl, Mesa limtis the complete buffer to 260 KiB.

Venus places commands in shared rings, so current Mesa submits
only small control messages directly; its largest fixed outer command
buffer is 256 bytes.

DRM native contexts are more difficult. MSM, i915, and Asahi request
sizes grow with the number of BO or resource records, while AMDGPU can
aggregate multiple chunks. There is no useful common bound below the
outer 32-bit length, or roughly 4 GiB.

I think QEMU needs a practical policy limit, as it already has
for the number of virtio descriptors. A possible limit is 4 MiB.

For vmalloc-backed command data, Linux creates one scatterlist entry per
page, in addition to the command and response entries. With 4 KiB pages
and QEMU's limit of 1,024 mapped iov entries, the largest such command 
is: 1022 * 4 KiB = 4 MiB - 8 KiB

So the existing Linux/QEMU path already stops reliably carrying larger 
inline commands at roughly 4 MiB.

> 
> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
> Reported-by: admin@fluentlogic.org
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 60c78af06a4..2a07dd2431f 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -601,12 +601,23 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
>                                   struct virtio_gpu_ctrl_command *cmd)
>   {
>       struct virtio_gpu_cmd_submit cs;
> +    size_t iov_len;
>       void *buf;
>       size_t s;
>   
>       VIRTIO_GPU_FILL_CMD(cs);
>       trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
>   
> +    iov_len = iov_size(cmd->elem.out_sg, cmd->elem.out_num);
> +    if (cs.size == 0 || iov_len < sizeof(cs) ||

A zero-length payload is valid for a fence-only submission, and Mesa
Venus emits such submissions, so cs.size == 0 should not be rejected.

Regards,
Akihiko Odaki

> +        cs.size > iov_len - sizeof(cs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: size out of range (%u/%zu)",
> +                      __func__, cs.size, iov_len);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
>       buf = g_malloc(cs.size);
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(cs), buf, cs.size);


