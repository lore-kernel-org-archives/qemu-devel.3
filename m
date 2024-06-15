Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D59C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 22:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIcFe-0000kZ-AF; Sat, 15 Jun 2024 18:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIcFc-0000kH-Qk
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 18:52:00 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIcFb-000796-33
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 18:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1718491913;
 bh=Rd2dLGNW63FQc47opRkwSGewfZU386ES4krZxwTrWe8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YgfX8G4+RmBzBgKYQIcG92mrjawvJgJT6xpyrj8kNGF1wrRX9IW5w665ldDF3lm8Y
 KHbBpCuyY00BjHMRfHPm3pbr4k0K/brOrFkx9EZGr/UXtr5n8Wndho7ftRhofq4/J+
 x4+t3Rlg9XyLxl368KQjKc+ZWxCzWieYF56U2tW+d2OQ/h+aoqfMz5kIBNfzfovpfk
 UZnRsZHLR7UqeSObQ7BP0xQ2CfqJ2/X8wfnSAvnmyMq0UWhvY8lDCWiaP3BjYebwPM
 lYw2AR2VlBR5p3Q6h1fMBoijNTRb0qnQRnwO15QmK57A38Gwrtfue1h53vtxa2vp9o
 7mIIjEzW5K2yA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6229B3780575;
 Sat, 15 Jun 2024 22:51:51 +0000 (UTC)
Message-ID: <13d8722c-dc70-468e-940a-b938c84d9a4e@collabora.com>
Date: Sun, 16 Jun 2024 01:51:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
 <c9891c82-b139-49cb-9f94-52a96cc20eea@daynix.com>
 <c2a4c684-24d8-4a3d-bed0-9b711b00b169@collabora.com>
 <24afb7f8-f091-4405-917e-ee7bb0a1e2b8@daynix.com>
 <70a2368c-2ed5-4035-a278-5d8a16c406ba@collabora.com>
 <802327b2-f166-49b5-b063-f642bb78111f@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <802327b2-f166-49b5-b063-f642bb78111f@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
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

On 6/10/24 06:38, Akihiko Odaki wrote:
> On 2024/06/10 4:02, Dmitry Osipenko wrote:
>> On 6/3/24 08:44, Akihiko Odaki wrote:
>>> On 2024/06/03 14:26, Dmitry Osipenko wrote:
>>>> On 6/2/24 08:34, Akihiko Odaki wrote:
>>>>>> +typedef enum {
>>>>>> +    RS_START,       /* starting state */
>>>>>> +    RS_INIT_FAILED, /* failed initialisation */
>>>>>
>>>>> Is the distinction between RS_START and RS_INIT_FAILED really
>>>>> necessary?
>>>>
>>>> The state stays in RS_INIT_FAILED once was failed until virtio-gpu is
>>>> reset, re-initializing virglrenderer isn't allowed in this state.
>>>
>>> Can you elaborate more? Why isn't re-initializing allowed?
>>
>> In practice, if virglrenderer initialization failed once, it will fail
>> second time. Otherwise we will be retrying to init endlessly because
>> guest won't stop sending virgl commands even if they all are timing out.
>> Each initialization failure produces a error msg.
>>
> I see.
> 
> A better solution is to add a new function to GraphicHwOps to call back
> after initializating the displays and before starting the guest. You can
> do virgl initialization in such a function, and exit(1) if the
> initialization fails because the guest has not started yet, saving this
> enum. I don't require you to make such a change however; this is not a
> regression of your patches so you have no obligation to fix it.

I'll keep this idea for a follow up patch, thanks! It will take me some
extra time to look through the display code, making sure that callback
is added properly and nothing is missed.

-- 
Best regards,
Dmitry


