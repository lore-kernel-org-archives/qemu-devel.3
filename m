Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0685DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 07:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwGYg-0000b3-6e; Mon, 15 Apr 2024 03:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rwGYe-0000ah-2Y
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 03:15:16 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rwGYa-0008KP-JN
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 03:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713165308;
 bh=PTlQdHQLJLv+Sdz+RvQLu1j7eh9uwYDuwn/Amodv3v4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JUwdRg+T7S9wdawfb41bdJjhr5xVDaKubrnx26Ghf2leHwm9xWADD/QBFiAtENGoL
 0dzjxCgJ+L48fmHjy2MLZhzA+Q1rBtOTt9G0G7uDIcj/9uNPty49KVt/Welju3BSdr
 GXZweCzx8YxNpuIFwYJ6qaTXsut9JsElSHN4GAqCcjKWLNhmtcRTn6TluTU0PpNhYw
 2M1ReSYPGdIRKL15Udxp73pKio+Ub4RKwbj6HvKT7Uc/R8FbN4pPIhTDHNrMIlbUU9
 +zk7NnJEGCV74evkqQMTpAj9GR5Az2sWwws1YTKRWiwb4vkUqH1cbZybUlegxiodPY
 eOgdRf2Y1fxdA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D9E3937810F1;
 Mon, 15 Apr 2024 07:15:06 +0000 (UTC)
Message-ID: <e3fee578-8c0e-4841-9dcf-0b1e99c5deeb@collabora.com>
Date: Mon, 15 Apr 2024 10:15:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Support blob memory and venus on qemu
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <ZhixfZ93e3htVMGs@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ZhixfZ93e3htVMGs@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/12/24 06:58, Huang Rui wrote:
> On Thu, Apr 11, 2024 at 06:19:52PM +0800, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series enables Vulkan Venus context support on virtio-gpu.
>> Upstreaming of Venus to Qemu was originally started by Antonio Caggiano,
>> later Huang Rui continued the effort. I'm now taking it over because
>> Rui will be busy for awhile and he asked me to do so.
>>
> 
> Thanks Dmitry! :-)
> Please go ahead and it's important implementation which is not only on
> venus but also on virtio native context.

Thanks, Rui! Native context will come after the Venus, we should keep
patches separated logically, otherwise could be difficult to review
them. For nctx there are things needs to be addressed in our WIP patches
before proceeding to upstreaming. My plan is to land Venus patcheset
first, preparing nctx in the meantime.

-- 
Best regards,
Dmitry


