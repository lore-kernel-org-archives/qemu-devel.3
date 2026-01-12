Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55268D26D9B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEef-0007pU-5t; Mon, 12 Jan 2026 04:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vfEed-0007oI-7O
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:56:07 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vfEeY-0004eB-Lh
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1768211731; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T+FNYTnkfGetyp7AcQdArYyTEJGlfERrU00NYfX2ucL0laq12kjngkqcp6U/kywEbWuSjeTGM9YIAANc3JxTV7PUUGN3mQJ5tBfnYieTCOyIIedunAVuaNiWg5wn1loO/IQx91k8+/mhqui5Pht4XjDI0ZKC2wL/QtPYUZ+0n6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768211731;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=poTDhedxTlSYKTf/tTu6VdlnRvcDLVQXYdJZk6mt6WY=; 
 b=UvG8vgHqIs0u991KHBvDu83tIEy4YmsH5cSCaSIiG8Ggu9lv+50ZPDR2jBerX0FwcRQuOE/wLQyKdOjcJ4clZ5Q+QieuMC5NRhqrf+s3ejcEev2kEcKcTefJGFsyAJGfYH1UCXoEe/KaV5d6qgw2IP0RVwTAErV2Fj7JDHrFa/E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768211731; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=poTDhedxTlSYKTf/tTu6VdlnRvcDLVQXYdJZk6mt6WY=;
 b=SsT1ND8iDFwpcf9HkNO6iwMyKD14LQYemXlraDSumE0XLEss2NtHMK7N7Aw0IR9r
 4lDyS9Kt1Mz+vwdxGhPmULNvcBBIrQUswrmb5N+5cxokpjdt4KqXDv2uVNJtA8Z8gef
 Ag2FkAJ0iop3SirBD1FOZiYzviLR2YlYWejqZcd4=
Received: by mx.zohomail.com with SMTPS id 1768211730007189.87087599168933;
 Mon, 12 Jan 2026 01:55:30 -0800 (PST)
Message-ID: <a784d955-9f4b-449c-af96-7cde357e6bfd@collabora.com>
Date: Mon, 12 Jan 2026 12:55:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 3/4] virtio-gpu: Destroy virgl resources on
 virtio-gpu reset
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260108061146.95497-1-dmitry.osipenko@collabora.com>
 <20260108061146.95497-4-dmitry.osipenko@collabora.com>
 <a0eda677-55f4-4588-896b-58b7afbee9b4@rsg.ci.i.u-tokyo.ac.jp>
 <a011d47b-c05d-4534-9392-70b30429ccf4@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <a011d47b-c05d-4534-9392-70b30429ccf4@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Akihiko,

On 1/8/26 11:43, Akihiko Odaki wrote:
>>> +bool virtio_gpu_virgl_update_render_state(VirtIOGPU *g)
>>> +{
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>> +
>>> +    switch (gl->renderer_state) {
>>> +    case RS_RESET:
>>> +        if (virtio_gpu_virgl_reset(g)) {
>>> +            return false;
>>> +        }
>>> +        /* fallthrough */
>>> +    case RS_START:
>>> +        if (virtio_gpu_virgl_init(g)) {
>>> +            gl->renderer_state = RS_INIT_FAILED;
>>> +            return false;
>>> +        }
>>> +
>>> +        gl->renderer_state = RS_INITED;
>>> +        break;
>>> +    case RS_INIT_FAILED:
>>> +        return false;
>>> +    case RS_INITED:
>>> +        break;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>>   static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>>>   {
>>>       VirtIOGPU *g = opaque;
>>> +    if (!virtio_gpu_virgl_update_render_state(g)) {
>>> +        return;
>>> +    }
>>> +
> 
> This logic is still faulty. virtio_gpu_virgl_unmap_resource_blob()
> assumes the memory region is still parented when !vmr->finish_unmapping,
> but it may no longer be true. The function can be called for a memory
> region even while its finish_unmapping stays false due to another memory
> region freed earlier.
> 
> To fix this issue, I suggest converting finish_unmapping to an enum that
> represents three states:
> 1. The memory region is still parented.
> 2. The memory region is unparented but
>    virtio_gpu_virgl_hostmem_region_free() has not been called yet.
> 3. virtio_gpu_virgl_hostmem_region_free() has been called.
> 
> Note that the distinction between state 1 and 2 is not present with
> finish_unmapping and a new addition.

Very good catch, will fix in v9. Thanks for the review!

-- 
Best regards,
Dmitry

