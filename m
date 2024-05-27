Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163A1C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBNu6-0006ug-Nh; Sun, 26 May 2024 20:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBNu4-0006uW-WB
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:07:53 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBNu3-0004kL-0k
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716768468;
 bh=rLFab+D5QGNQ3bYm0H3qrZBp1aS6L65x4sQJnepfyDw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X1Pl6jt+1KMEhxbamEKkkWnSsBVCTdO76VryseJQlHU4Hp/5soV49jGf09lzoQ4Jn
 WuNS6xEdDFZA8omv9otUO7CvxaLyJhIBcq7f+scEDS27Arel+IzdVar3VTovDJLEVa
 hCl4qHpKhXd29WPiugWkaVqYSGh9CzXzm1+DcmiYGCxu93Ih/RxZdmodzgZ4U9PX3+
 Wba0YqD0NdrbtXtM6PmoA1cNmqveL6+ksTK99/Y56PU1kEb1CfAhYCM+ySpuj2u7cv
 UIPfJh6n+I4vxcTFqA8DEgPaLxHeIYFLqQuaucZl3etES1wzaHhVtkIWmwPPmLJP3U
 jRPW1xNQ4BlFQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7040237810F1;
 Mon, 27 May 2024 00:07:46 +0000 (UTC)
Message-ID: <3f6b52ed-1705-4f91-9c01-334a07eda36d@collabora.com>
Date: Mon, 27 May 2024 03:07:43 +0300
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
 <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com>
 <874jaqi5m0.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <874jaqi5m0.fsf@draig.linaro.org>
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

On 5/22/24 12:00, Alex Bennée wrote:
> I get a boot up with a lot of:
>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed   
>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed   
>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed   
>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed   

Have same problem with GTK and arm64/UEFI. Something is resetting
virtio-gpu device during boot (maybe UEFI fw) and it doesn't work
properly with GTK. I'd expect x86 should have same issue, but don't
recall x86 having it.

-- 
Best regards,
Dmitry


