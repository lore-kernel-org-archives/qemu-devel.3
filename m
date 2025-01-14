Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCBFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 12:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfty-00006M-Ls; Tue, 14 Jan 2025 07:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tXftu-0008WC-V0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:20:06 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tXftr-0003AV-LS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 07:20:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1736857189; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Le5Ek+c1PSO+6fgFz8voVcDq620czvpAwC8arKNBjsNWQFcaS2s9zyBiEHuqrhYmJYEMx/OnsJnh4goChy/wcSRSovKgrqWFtVhK2WiLT2gVIEYmsBMwWzjLCeH2oBSktCLLRi/9iDDmb4p0vrOKYyaFEcTUMfptRa6tRgdMoGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736857189;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WXTxPVGNvNWH0K4Uzn9JKLipktixjN0FppWJRRbeNyg=; 
 b=f4t8N3t28il/NBKjSnJk3fFPWAMBfugsbKghgjZDdrjqQAAYqQBLnfLDcRWd3KFKIy9+IIP5n7b0ntcSMHtn33hmTyJwnASM2kClMidqfYr/2HrHbpRB+T/7CdBHlDaZ7DRbQQyX2uxjHbpT4Md3bf5f0H85owJqOrsqI6ej24k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736857189; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=WXTxPVGNvNWH0K4Uzn9JKLipktixjN0FppWJRRbeNyg=;
 b=WFrLTsl1ATTI6OC6LIe5JAZ3Ts1j/c//KEQ3KwXEMNvsr1yl0pObgqJQIWCP3lY2
 xJBZ/yirbDQTTnBYVk4Rh4b+8RGnHr0mo1up9tbSprABUqhKjQPLPco7uqjsyWg0sAv
 nAczYqrKwywvfYp0dq4xdajHCi4SSfrpkev0ZO+w=
Received: by mx.zohomail.com with SMTPS id 1736857186460848.7059697777773;
 Tue, 14 Jan 2025 04:19:46 -0800 (PST)
Message-ID: <9ba719d6-b362-48d2-a875-be4a26a3b709@collabora.com>
Date: Tue, 14 Jan 2025 15:19:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] virtio-gpu: Support asynchronous fencing
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <20241110221838.2241356-5-dmitry.osipenko@collabora.com>
 <87plkqjrx3.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87plkqjrx3.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/25 01:00, Alex Bennée wrote:
...
> This needs to be gated on support from virglrenderer:
> 
>   /display/virtio-gpu-virgl.c
>   ../../hw/display/virtio-gpu-virgl.c: In function ‘virtio_gpu_virgl_process_cmd’:
>   ../../hw/display/virtio-gpu-virgl.c:980:15: error: implicit declaration of function ‘virgl_renderer_context_create_fence’; did you mean ‘virgl_renderer_context_create’? [-Werror=implicit-function-declaration]
>     980 |         ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
>         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |               virgl_renderer_context_create
>   ../../hw/display/virtio-gpu-virgl.c:980:15: error: nested extern declaration of ‘virgl_renderer_context_create_fence’ [-Werror=nested-externs]
>   ../../hw/display/virtio-gpu-virgl.c: At top level:
>   ../../hw/display/virtio-gpu-virgl.c:1088:13: error: ‘virgl_write_context_fence’ defined but not used [-Werror=unused-function]
>    1088 | static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>   ../../hw/display/virtio-gpu-virgl.c:1002:13: error: ‘virtio_gpu_virgl_async_fence_bh’ defined but not used [-Werror=unused-function]
>    1002 | static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors

Good catch, will address in v5. Thanks!

-- 
Best regards,
Dmitry

