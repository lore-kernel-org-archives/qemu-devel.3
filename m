Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEFFCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8raB-0001qT-Fr; Tue, 14 Oct 2025 22:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8ra3-0001q5-IH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:49:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8rZq-0006JR-A3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:49:28 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59F2n486063990
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Oct 2025 11:49:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=gguJc98z35ToVrINbOWa6utCG1k72ZRcJf5CX1dzVvc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760496544; v=1;
 b=Rj+X+RrJYLg71YUWNF9fDTh760YTzWnQv7RZVYaSbz54RmiNChx3v9r7RsyIfh+z
 NZuJOJ25CUacEn479I/Z0h1dW1TOC84w7xyGPYTdzRq7cJ5DhmabKvG1dGZZMH/J
 Abjfx2lDXYsK1Wo7ck7flxNJK4HcwouRTuhSuWUxTSWF6qfwnvV5PymB5xjffc5L
 O4e6Dv3T89+5GKyQZWmGNGTg//bAXn/fAJTooRQSoIJ02So61W8hVtxZkZFhMT7h
 ZowBwBK72wMnQWQ/2DFub2q7ysToNhzo5bs3UAHiIBjZ8/g8RY8nx/znH0hG9beK
 ktXa1c72pXlksOa3uyoWaw==
Message-ID: <7ebab3d3-ee30-499c-b475-a64560eb160a@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 15 Oct 2025 11:49:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] Support per-head resolutions with virtio-gpu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Keesler <ankeesler@google.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251014111234.3190346-2-alex.bennee@linaro.org>
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

On 2025/10/14 20:12, Alex Bennée wrote:
> From: Andrew Keesler <ankeesler@google.com>
> 
> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
> 
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).
> 
>    -display vnc=localhost:0,id=aaa,display=vga,head=0 \
>    -display vnc=localhost:1,id=bbb,display=vga,head=1 \
>    -device '{"driver":"virtio-vga",
>              "max_outputs":2,
>              "id":"vga",
>              "outputs":[
>                {
>                   "name":"AAA",
>                   "xres":111,
>                   "yres":222
>                },
>                {
>                   "name":"BBB",
>                   "xres":333,
>                   "yres":444
>                }
>              ]}'
> 
> Here is the behavior matrix of the current resolution configuration
> surface (xres/yres) with the new resolution configuration surface
> (outputs[i].xres/yres).
> 
> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
> 
> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
> 
> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
> 
> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
> Signed-off-by: Andrew Keesler <ankeesler@google.com>

Nitpick: it is better to have a blank line between Behavior: and 
Signed-off-by: to clarify the beginning of tags.

> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20250902141312.750525-2-ankeesler@google.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   qapi/virtio.json             | 10 ++++++++--
>   hw/display/virtio-gpu-base.c | 10 ++++++++++
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 05295ab6655..0ce789bb22f 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -971,15 +971,21 @@
>   ##
>   # @VirtIOGPUOutput:
>   #
> -# Describes configuration of a VirtIO GPU output.
> +# Describes configuration of a VirtIO GPU output. If both xres and
> +# yres are set, they take precedence over root virtio-gpu
> +# resolution configuration and enable the corresponding output.
>   #
>   # @name: the name of the output
>   #
> +# @xres: horizontal resolution of the output in pixels (since 10.2)
> +#
> +# @yres: vertical resolution of the output in pixels (since 10.2)
> +#
>   # Since: 10.1
>   ##
>   
>   { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>   
>   ##
>   # @DummyVirtioForceArrays:
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 7269477a1c8..6adb5312a40 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>       g->req_state[0].width = g->conf.xres;
>       g->req_state[0].height = g->conf.yres;
>   
> +    for (output_idx = 0, node = g->conf.outputs;
> +         node && output_idx < g->conf.max_outputs;

output_idx < g->conf.max_outputs is redundant as it is already enforced 
with the first for-loop that enumerates outputs.

The condition can be simply removed, but I think merging this loop to 
the earlier loop will make the code a bit more concise.

Aside this redundancy of the code, the logic this patch implements looks 
good to me.

> +         output_idx++, node = node->next) {
> +        if (node->value->has_xres && node->value->has_yres) {
> +            g->enabled_output_bitmask |= (1 << output_idx);
> +            g->req_state[output_idx].width = node->value->xres;
> +            g->req_state[output_idx].height = node->value->yres;
> +        }
> +    }
> +
>       g->hw_ops = &virtio_gpu_ops;
>       for (i = 0; i < g->conf.max_outputs; i++) {
>           g->scanout[i].con =


