Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DDBC25B74
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 00:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ZRK-0005kv-31; Tue, 21 May 2024 20:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s9ZRI-0005k4-GX
 for qemu-devel@nongnu.org; Tue, 21 May 2024 20:02:40 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s9ZRG-0005jv-LL
 for qemu-devel@nongnu.org; Tue, 21 May 2024 20:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716336155;
 bh=QQ8QeBvXKuTmupvqEAW1VpzvAE6BdX8t+qc639EsOiE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VZXkD4CRw2jq2g7DKf4uvarm1+JTaBH/TzE5x6WaG9r10IFH4r+dglhfLzpC0qEde
 /wHevRtd4HNokMbgqwOAos/q+gB0i69pjLUx9NB+Vcrf8dWFOV7dmU+vSswshEzsax
 0xz5mbxB349Qa3gmWHfC21KMuC21zaml4GBPowpSoybr161TAzaYhv1ChB/hJJzb7G
 6evpvQyC6j63uf7ZADJ2QSmHQko4WR43D0xjAlhL41Pcb6AnWwJTFWPSON50u9Cgth
 SaGvIhn1aVtjJe15wJsUJGeBQB2a/uGLtsMGlnXViNLHm5eTZlKY9MszkYJaePGzRX
 +ZZKy5hdx1ZDg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 281EB378214D;
 Wed, 22 May 2024 00:02:33 +0000 (UTC)
Message-ID: <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com>
Date: Wed, 22 May 2024 03:02:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/13] Support blob memory and venus on qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <87o78zi9wb.fsf@draig.linaro.org> <87jzjni569.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87jzjni569.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/21/24 17:57, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>
>>> Hello,
>>>
>>> This series enables Vulkan Venus context support on virtio-gpu.
>>>
>>> All virglrender and almost all Linux kernel prerequisite changes
>>> needed by Venus are already in upstream. For kernel there is a pending
>>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>>> from Qemu.
>>>
>>> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/
>>>
>>> You'll need to use recent Mesa version containing patch that removes
>>> dependency on cross-device feature from Venus that isn't supported by
>>> Qemu [2].
>>>
>>> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987befae78b6ccbb7ae242b
>>>
>>> Example Qemu cmdline that enables Venus:
>>>
>>>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,venus=true \
>>>       -machine q35,accel=kvm,memory-backend=mem1 \
>>>       -object memory-backend-memfd,id=mem1,size=8G -m 8G
>>
>> What is the correct device for non-x86 guests? We have virtio-gpu-gl-pci
>> but when doing that I get:
>>
>>   -device virtio-gpu-gl-pci,hostmem=4G,blob=true,venus=true
>>   qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=4G,blob=true,venus=true: opengl is not available
>>
>> According to 37f86af087 (virtio-gpu: move virgl realize + properties):
>>
>>   Drop the virgl property, the virtio-gpu-gl-device has virgl enabled no
>>   matter what.  Just use virtio-gpu-device instead if you don't want
>>   enable virgl and opengl.  This simplifies the logic and reduces the test
>>   matrix.
>>
>> but that's not a good solution because that needs virtio-mmio and there
>> are reasons to have a PCI device (for one thing no ambiguity about
>> discovery).
> 
> Oops my mistake forgetting:
> 
>   --display gtk,gl=on
> 
> Although I do see a lot of eglMakeContext failures.

Please post the full Qemu cmdline you're using

-- 
Best regards,
Dmitry


