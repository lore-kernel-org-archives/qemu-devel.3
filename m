Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECFDC27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 16:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJxj2-0005wK-TK; Wed, 19 Jun 2024 11:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sJxj1-0005vs-Hn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:59:55 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sJxiz-0003SE-Ay
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1718812790;
 bh=EB6H+BstcsfOcX2gTLiIY79xWYgMButY9xgj5uFZ604=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qf//T2r4P4NNyrURmyyEvog1gvU1P9Fa/JYydBtbuQWpDLqoWzd7sUtf8j3cUugyC
 xzKdGP4WwxvFnEIchp8jnKKsmt9um3MwpnroKXNgGkxseNT65YLPwXPIgsol+loFLn
 VeCM3cP7f3kDUiojyzO+O2KC1KHeXwGUZBeodcdMGS39UXIQ3Y14yZfl/2ImiTuhO0
 FeuVgU10NcFrb8JezuAj2wYHqGTZoSzsfJtKrl8x+18a9y3D7oiuRWFZe51YQvx8J9
 kZAA4+sqkdWqsIuWPKJRYFotP5SpC1wD5I1aH2tfZJ/hI0Wv++gQZO167AXsI8a1cw
 0gW4pHYjAz67Q==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1E8F337821A9;
 Wed, 19 Jun 2024 15:59:48 +0000 (UTC)
Message-ID: <06411467-172d-418c-91e9-44961225260a@collabora.com>
Date: Wed, 19 Jun 2024 18:59:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/14] virtio-gpu: Handle resource blob commands
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
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
 <20240616010357.2874662-13-dmitry.osipenko@collabora.com>
 <87frt9c5rp.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87frt9c5rp.fsf@draig.linaro.org>
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

19.06.2024 18:27, Alex Bennée пишет:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>
>> Support BLOB resources creation, mapping and unmapping by calling the
>> new stable virglrenderer 0.10 interface. Only enabled when available and
>> via the blob config. E.g. -device virtio-vga-gl,blob=true
>>
> <snip>
>>  
>>  #if VIRGL_VERSION_MAJOR >= 1
>> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>> +                                           struct virtio_gpu_ctrl_command *cmd)
>> +{
>> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
>> +    g_autofree struct virtio_gpu_virgl_resource *res;
> 
> Newer compilers rightly complain that g_free may be called on an
> uninitialised value (if we early return). Setting to NULL should be
> enough here.

Good catch! GCC 13 doesn't detect it

-- 
Best regards,
Dmitry


