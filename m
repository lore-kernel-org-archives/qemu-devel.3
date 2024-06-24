Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56559C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcNQ-00041R-AC; Mon, 24 Jun 2024 01:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcNM-0003y4-8L
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:36:24 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcNK-0005UA-Mc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:36:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c7dd4586afso3095282a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207381; x=1719812181;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6owLCSe6BBCkMd1NWEllzZetRY1hre26/jlQgj8oghQ=;
 b=bURBBr/zWGq3ePQaYrGC3faYXbm9pWPMNxVdSzObV9qeop+0pX0aKaEJY06Q0zkTPx
 14HVIyCy+CTubb953tc3s0nRYI9GdYvR3KOGu5YPkV6lHh5wn/HnpcgRnUvn7mty7bsY
 4/0aQimJm9ZYSdzVtE91BH6tlK+0Q33+ohCBad5VvmJlG1FS18JxjvqDkpzCTwU6Q1a7
 Aab0uPlBBNly9ZQqxjpwpS5bSIVeq5Vcjl/nmS3R14hRO4RatvJMnPx5Mjee+RUepcoq
 Zm/ntKHyMQO2OFre+dDJyhmftaWMKsirkzovnbyBVBI4PrcoYw9/ci8bG+ElVRFtGfiv
 lZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207381; x=1719812181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6owLCSe6BBCkMd1NWEllzZetRY1hre26/jlQgj8oghQ=;
 b=jOvUErC1F5o3IZZAhsfaswylfdpm1LEgoBguCLOjqTJr80DlQxzHYaPz2wkqSoZiZl
 gcDRSwz5kxUz6rHjL+GHLj+nv6jrboZtl7W0GNQsi/erk+NuTJX/4P2ds2LBV6GlfMXr
 TFFYCFJEzKjwBI1Gl22nMljWinWgjse+z8fTkvaVg5XI8f0WDTNLq6kzWFXN2C+/2GTf
 9eO3yw1jOwiAijtxExWLLxFhGCMpiqqcAsJ0vy5Rhk614Q3dBy1UO4QQkke1/HopogjP
 R367GRin4cai43q6Y8MOe6tfS60zlkOUylQL6HXuMpBXCSCP+M8+lQxs8vk+hBQ6tBiC
 9b7A==
X-Gm-Message-State: AOJu0YzvHFrNoJBJfnK9tUOvA6NKC9tOtNREgcx3zpxlPlg0/nNy1jCG
 xJBrVzMg/ws0sCHmr+f5oOB3oZQEdFoXr233ZznTMxxvSDIv4t2Ctoy/NnONvbE=
X-Google-Smtp-Source: AGHT+IEU/kVRrShRYYTRctglPUb/fEzG6ZKmUxflsPd9v2lnzIJt/lyzfCAnI8uK0xAynrKLnAEGvQ==
X-Received: by 2002:a17:90b:38c5:b0:2c8:50cc:8571 with SMTP id
 98e67ed59e1d1-2c8581e7076mr3440068a91.22.1719207381339; 
 Sun, 23 Jun 2024 22:36:21 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c81eaf92b2sm5609893a91.40.2024.06.23.22.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:36:21 -0700 (PDT)
Message-ID: <44d485ae-fd84-4df2-acef-83b9f58dbf0f@daynix.com>
Date: Mon, 24 Jun 2024 14:36:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/13] virtio-gpu: Unrealize GL device
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
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
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-6-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-6-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/24 0:23, Dmitry Osipenko wrote:
> Even though GL GPU doesn't support hotplugging today, free virgl
> resources when GL device is unrealized. For consistency.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com

