Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB2C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 19:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGNop-0007wb-O0; Sun, 09 Jun 2024 15:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sGNoo-0007wO-RH
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 15:03:06 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sGNon-0006FV-1B
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 15:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717959781;
 bh=vyY6JCTNzStpm0dJ2D3XTOWlcS30yIhXLqyc4K1ovzI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n8EfYxJO0Wc5RNWSJ8YrPdg6Bn79dQ2+ujlwv62zUO96eCpqt40R3O+JBBj0bHW9w
 8H4w0PS+BZBvM653ZkUhvfLZAWabX4VN5sjqBx/+42A+7QSy5swOVistHCoe5T7y5s
 cEFLc1wTvO+f6e9y00CJR2UIqTwRy/0/+ZA+1KD1N24ihKodAgS+V34GcQuUpLxX1f
 jGqhxPqOoTPPnACna5n8YXzGNAzK+5fH11bkUohAlDsb7e+C3aAR1FNcN+O62aUBjF
 7Hyr72DLjHg+5k1Gp6TGas9SFua+ydL+PNeJ1cp8YDn4A2QA60j9UX7vKg1nA6wkqF
 7iyYD48sUkQmA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3F62E3780C1F;
 Sun,  9 Jun 2024 19:02:59 +0000 (UTC)
Message-ID: <70a2368c-2ed5-4035-a278-5d8a16c406ba@collabora.com>
Date: Sun, 9 Jun 2024 22:02:56 +0300
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <24afb7f8-f091-4405-917e-ee7bb0a1e2b8@daynix.com>
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

On 6/3/24 08:44, Akihiko Odaki wrote:
> On 2024/06/03 14:26, Dmitry Osipenko wrote:
>> On 6/2/24 08:34, Akihiko Odaki wrote:
>>>> +typedef enum {
>>>> +    RS_START,       /* starting state */
>>>> +    RS_INIT_FAILED, /* failed initialisation */
>>>
>>> Is the distinction between RS_START and RS_INIT_FAILED really necessary?
>>
>> The state stays in RS_INIT_FAILED once was failed until virtio-gpu is
>> reset, re-initializing virglrenderer isn't allowed in this state.
> 
> Can you elaborate more? Why isn't re-initializing allowed?

In practice, if virglrenderer initialization failed once, it will fail
second time. Otherwise we will be retrying to init endlessly because
guest won't stop sending virgl commands even if they all are timing out.
Each initialization failure produces a error msg.

-- 
Best regards,
Dmitry


