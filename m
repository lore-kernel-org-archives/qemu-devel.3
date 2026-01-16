Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A388DD489A3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjZc-0002ZY-46; Fri, 16 Jan 2026 08:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vgjZU-0002Qd-KP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:09:03 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vgjZS-0002zY-Sk
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:09:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1768568918; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VnDf8yFd7p3+lPO9SEsmf8BonGtCB3nHeYmJwBUK4tZtc3etaxj+4xB/OiCpV8PyuHkTOiehl2Cn0+jQ8mQV+UNgwBzvKboA8bFUVR9ooQfz41StsEMvKqdKssf3gaHOrQrZgBUVrQfJ47a+t5cD+CDqmLPNLTdwYNKIfVU0fYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768568918;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KCFYT5PvyUafB/sHw2NaJWzaN2UYwXqRSWevyGcLC8o=; 
 b=MpFYAO9odIGioxAuPxcaTxh6tPRDAVNVRaLzFyP9LBWTXTEgK4UAwiWEd9keVLh1a3FElbv8jh6KzoB4lWUc+egJMDNrssqRUPWzF191ecDZEMl+9cKk4dGTEnJhPyeZE0hSP/pY/PPEUuIbFF52ij4hxVR7c5c7AAK9lFrmZVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768568918; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=KCFYT5PvyUafB/sHw2NaJWzaN2UYwXqRSWevyGcLC8o=;
 b=d1FFpiXLBdm3f/5xlakJCpJ01LqPcFe/QR7ac6hwafn11Z0z1Do+PzYzmAFVCw9W
 fxAQHOPr0NoJFOjAZrMiFYAKMS2qHDCv3VMsa+tx9aWt+mrusKhRLQvNKamIRM+vUNF
 3HE+Xpxi42qJR7CLu+rg5o13YRssTZ1+WXtELuy4=
Received: by mx.zohomail.com with SMTPS id 1768568916002988.3019253208564;
 Fri, 16 Jan 2026 05:08:36 -0800 (PST)
Message-ID: <a00c0a85-be88-449f-bdde-0f49ebc0a7f9@collabora.com>
Date: Fri, 16 Jan 2026 16:08:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/5] virtio-gpu: Destroy virgl resources on
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
References: <20260112225246.3526313-1-dmitry.osipenko@collabora.com>
 <20260112225246.3526313-5-dmitry.osipenko@collabora.com>
 <98a2cbaa-582d-43bf-b59a-7a0e75c486d5@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <98a2cbaa-582d-43bf-b59a-7a0e75c486d5@rsg.ci.i.u-tokyo.ac.jp>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/13/26 07:47, Akihiko Odaki wrote:
>> +void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
>> +                                       struct
>> virtio_gpu_simple_resource *base,
>> +                                       Error **errp)
> 
> An error reporting rule described in include/qapi/error.h requires
> functions that use Error to return a value indicating success or failure.
> 
> For this particular case, I think it can simply return what
> virtio_gpu_virgl_resource_unref() returns, without having errp.

The error reporting arg is added here because resource_destroy()
callback of VirtIOGPUClass requires it:

```
vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
```

The include/qapi/error.h says "Whenever practical, also return a value
that indicates success / failure". Hence, the returned value is optional.

I don't quite see how errp can be avoided.

Perhaps you're meaning to add virtio_gpu_gl_resource_destroy() that will
be local to virtio-gpu-gl.c. Will change this in v10, otherwise please
clarify more your suggestion.

Thanks for the review.

-- 
Best regards,
Dmitry

