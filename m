Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F89CC0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 15:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tebjm-0007OB-76; Sun, 02 Feb 2025 10:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tebjk-0007Nr-OY
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 10:18:16 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tebjj-0005Dg-1w
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 10:18:16 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738509477; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W7LSqBagwBS3HAGzuu4QwcYaxIwoczSnakvNcxw5ILO8sxF2Jj64SsgjM6ZFIOH1vrB33pDXhb2nK3BXFsw8IdSkLQm6DQig76PSUZjfZq3ZhQe+z8HQDh2esd8TD49+/vd/Ry94J8Cxl5ABXVkjQmaTvJ/1B8gIxl7T7/VM+G8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738509477;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3hsrI6mRMzydWNm3uEhatMh6v0cZiFMmQcKjF74DpiU=; 
 b=ho/+W9KhJm0YnETDEB63VX6f+FW9CmJRD++ae7HaYlQqQ/NZi2LT+E9dpTsElZvG6KDm5rfp9XibOIdveBhgroi+PVqRU5+UQXfJTSKuGq/I1FGYq3mpoYh4BkAtHgrHIK6wWH1IIj9LSg3+Zd2SY5TFNDrBX5oulWPTlFjQVgI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738509477; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3hsrI6mRMzydWNm3uEhatMh6v0cZiFMmQcKjF74DpiU=;
 b=SOd3IcqHiMHox1KvfY59X2ywtACVCXVSmhIEuUDxIaoQ5AQQV/tBdWdy5g8qmtfd
 uJqgkb3+u7Yw6Z/m99qRpsJRkFT3oE/0Fao2pOn3AGQGMfWifBV3bl/iMcEHJ/B+8ap
 qUxVk5ODRQYmUFIBAkvqfPdxye7RtK4HSv1bnRb8=
Received: by mx.zohomail.com with SMTPS id 1738509471008785.3601730436333;
 Sun, 2 Feb 2025 07:17:51 -0800 (PST)
Message-ID: <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
Date: Sun, 2 Feb 2025 18:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
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
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87cyg844fr.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 1/27/25 19:17, Alex Bennée wrote:
...
> I'm still seeing corruption with -display gtk,gl=on on my x86 system
> BTW. I would like to understand if that is a problem with QEMU, GTK or
> something else in the stack before we merge.

I reproduced the display mirroring/corruption issue and bisected it to
the following commit. The problem only happens when QEMU/GTK uses
Wayland display directly, while previously I was running QEMU with
XWayland that doesn't have the problem. Why this change breaks dmabuf
displaying with Wayland/GTK is unclear. Reverting commit fixes the bug.

+Dongwon Kim +Vivek Kasireddy

commit 77bf310084dad38b3a2badf01766c659056f1cf2
Author: Dongwon Kim <dongwon.kim@intel.com>
Date:   Fri Apr 26 15:50:59 2024 -0700

    ui/gtk: Draw guest frame at refresh cycle

    Draw routine needs to be manually invoked in the next refresh
    if there is a scanout blob from the guest. This is to prevent
    a situation where there is a scheduled draw event but it won't
    happen bacause the window is currently in inactive state
    (minimized or tabified). If draw is not done for a long time,
    gl_block timeout and/or fence timeout (on the guest) will happen
    eventually.

    v2: Use gd_gl_area_draw(vc) in gtk-gl-area.c

    Suggested-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
    Cc: Gerd Hoffmann <kraxel@redhat.com>
    Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
    Cc: Daniel P. Berrangé <berrange@redhat.com>
    Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
    Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
    Message-Id: <20240426225059.3871283-1-dongwon.kim@intel.com>

-- 
Best regards,
Dmitry

