Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B9FC27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 19:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGNri-0000kD-Kj; Sun, 09 Jun 2024 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sGNrg-0000hZ-Fg
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 15:06:04 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sGNre-0006vN-M5
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 15:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717959961;
 bh=dLc8V9KYljGpQZml3Sr28BLa3Yi0F1apaSQp9eBOz+0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bbOvyccO01tqblterYPo3AzB+lnVzzdAx3KRd5AQ5Q0KJivw8garrGjvlvncZrY63
 gBsR5c3WyfW5yr4d48BebX5sizo6y8r/bgqM/W+dgsIyXdLPblgCSDV7yMdum21SA+
 JwrmqP7DTsXxEjyB65b47Ve7sP+pp5mc6EI0K5+4arXYVUy3BvSGfgybxKpqBA6+lA
 DyeYd+G1Jn3Ul5NvimWpLxOJyq/hu11Iia7MLcFCyM+qT73cIAgDp+mNFG8/kP/ymQ
 KFyB514FOz98AB5e3u4Dj0kz0CD2b8Spljj8LRWqC2HVGl6XqpZAwCpkbGJbgVFCEV
 TymSyX8H0CDzw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B1403780C1F;
 Sun,  9 Jun 2024 19:05:59 +0000 (UTC)
Message-ID: <e0cd69c0-f82c-4772-9169-5645360d9af7@collabora.com>
Date: Sun, 9 Jun 2024 22:05:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
 <CAJ+F1CLW3fSE+UVwqXepwipJrK77EJfSqvepFXZUwecNdwmTwQ@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJ+F1CLW3fSE+UVwqXepwipJrK77EJfSqvepFXZUwecNdwmTwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/24 17:21, Marc-André Lureau wrote:
>> @@ -65,13 +70,21 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice
>> *vdev, VirtQueue *vq)
>>          return;
>>      }
>>
>> -    if (!gl->renderer_inited) {
>> -        virtio_gpu_virgl_init(g);
>> -        gl->renderer_inited = true;
>> -    }
>> -    if (gl->renderer_reset) {
>> -        gl->renderer_reset = false;
>> +    switch (gl->renderer_state) {
>> +    case RS_RESET:
>>          virtio_gpu_virgl_reset(g);
>> +        /* fallthrough */
>> +    case RS_START:
>> +        if (virtio_gpu_virgl_init(g)) {
>> +            gl->renderer_state = RS_INIT_FAILED;
>> +        } else {
>> +            gl->renderer_state = RS_INITED;
>> +        }
>> +        break;
>> +    case RS_INIT_FAILED:
>> +        return;
>> +    case RS_INITED:
>> +        break;
>>      }
>>
>>
> This still lets it go through the cmd processing after setting
> gl->renderer_state = RS_INIT_FAILED, the first time.

Good catch, thanks!

-- 
Best regards,
Dmitry


