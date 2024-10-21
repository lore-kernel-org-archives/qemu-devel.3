Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AA3D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2hIe-0007O6-PS; Sun, 20 Oct 2024 21:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t2hId-0007Ny-2N
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 21:33:35 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t2hIa-0006cf-SK
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 21:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729474399; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JT1vigzz1a0dkQF1ec17mN1/7BcAkR1ksM7+yCx8b1GyEvH9zMC1JNhN9K/213/HhDUD6ZzYCfPpM3GQgnDyKrg8QoBpdP8XxUWJ2Do4ROqxlnUibJUAyLOkiXZRNyySTafxiKCV3pjQwXSp9xxhZT47SmfwHwk+n+0gDSrii9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729474399;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Bn9L4cw6nmjmUBjGHiJafbNgNUiNyMYJgvU9xWTerU4=; 
 b=cTNJ6qQ8PwV2AeiEpfLnQNg1PhKl1dSDgDF0VrNAfeq8xfCO4GXdqTonUUVgtvOERsHehaho/Tt+QpMnTVD0CKpMRtKJRFQtioP9Cl0TatvLQN2rQcfqIZnGYIFDTfoLO9SSj1E8EbNIOQ/D/Sef8yfMz+DDanTXJtzHkuR9SR4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729474399; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Bn9L4cw6nmjmUBjGHiJafbNgNUiNyMYJgvU9xWTerU4=;
 b=ITnK7XqT4RJt500aKH1LAZGTrDvKu9OJ/nLrl70vcdpnZGpTBm4S8uhZATnmzg6o
 XvLOJ1gR2XX24565Qor60CX0rkKeW7H8glyjvv4KNgw4s7+XvI5GxSkkox/pwV2WpQr
 RYs2cBLGwiv9OdVOOheisS0MtgwJ2FZ+M4jVh9aI=
Received: by mx.zohomail.com with SMTPS id 1729474398809783.3277928801351;
 Sun, 20 Oct 2024 18:33:18 -0700 (PDT)
Message-ID: <80b0dfe7-ad00-4ef5-a7a3-fbd196c6b5ab@collabora.com>
Date: Mon, 21 Oct 2024 04:33:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] virtio-gpu: Support DRM native context
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
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
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-7-dmitry.osipenko@collabora.com>
 <897267cd-4502-48f9-8cab-87cd83770cb6@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <897267cd-4502-48f9-8cab-87cd83770cb6@daynix.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/18/24 08:33, Akihiko Odaki wrote:
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 0d1de7dc398c..cfd4ed8a104f 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1521,6 +1521,21 @@ void virtio_gpu_device_realize(DeviceState
>> *qdev, Error **errp)
>>   #endif
>>       }
>>   +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
>> +#ifdef VIRGL_VERSION_MAJOR
> 
> This ifdef is unnecessary.

The VIRGL_VERSION_MAJOR is defined only when virtio-gpu is built with
enabled virgl support. It's necessary to have the ifdef, otherwise
you'll get a build failure when compiling QEMU with disabled virgl support.

-- 
Best regards,
Dmitry

