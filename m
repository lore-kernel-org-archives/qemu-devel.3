Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C97D4400A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4YF-0000XU-J1; Mon, 18 Nov 2024 11:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tD4Y5-0000WL-L8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:24:25 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tD4Y3-0002vF-4t
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:24:24 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731947051; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YLQCVjuBmD8QDasDnZ/XM4VG6tMt/jWMm4MVwWwLKQsHnT09OnIKuZXWDfkgu07oUi8Kf2yeZ4oW8U1BzMKHLoxHMrfoTS/NJ8qmApwBAINCitKZP1itBO1CqCbGSJV1OCJGVeeA8HbV/CKt10KZLFrMvAaiBIicpTAMHCwP4yI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731947051;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GiqXzAVIC74Ts4HzRULTv77Sds77o4CkKHetI+jViU4=; 
 b=QOQpTIi+hgiikWQgX0wl/Sqe6Qmsd9rhS9qI7J7uqcVwY6d0hnjp7lM3csbadBeomGgElVoqCKEon4CM1KSu9Gsjq7afKhENE54HU+hf6DMnaXUHWsQpj9tuW/oFMtmvszBgC3M8F1PWxzy+uQ/cNGqIrfNb8o/eHMlRGQojs1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731947051; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=GiqXzAVIC74Ts4HzRULTv77Sds77o4CkKHetI+jViU4=;
 b=IP75Yg9O5q/R9gT6hahekCQF0CuYOyA4z3vWzGBvWy6l+GiSCT2l+STQNvLbAmiE
 nVNYgsRjfeZZCelc/4ujVIos14kDy1DyXl8yzGI2YlzrG2kj1wQJGn4Zd0gk1+rWtFd
 +B1HQx9sL4NHQ4kZCS0VaWVd6mYVJP23fAhazOOg=
Received: by mx.zohomail.com with SMTPS id 1731947049329245.67443580649194;
 Mon, 18 Nov 2024 08:24:09 -0800 (PST)
Message-ID: <1984069f-6deb-44d5-b3e9-0312ffcc3a1c@collabora.com>
Date: Mon, 18 Nov 2024 19:24:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ui/sdl2: Don't disable scanout when display is
 refreshed
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
 <20241006234353.3201037-2-dmitry.osipenko@collabora.com>
 <6ae662db-fba6-43a5-8be9-8de01dd4f476@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <6ae662db-fba6-43a5-8be9-8de01dd4f476@daynix.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/7/24 21:15, Akihiko Odaki wrote:
> On 2024/10/07 8:43, Dmitry Osipenko wrote:
>> Display refreshment is invoked by a timer and it erroneously disables
>> the active scanout if it happens to be invoked after scanout has been
>> enabled. This offending scanout-disable race condition with a timer
>> can be easily hit when Qemu runs with a disabled vsync by using SDL or
>> GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
>> content shouldn't disable the active display. Fix it by keeping the
>> scanout's state unchanged when display is redrawn.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> ---
>>   ui/sdl2-gl.c | 1 -
>>   1 file changed, 1 deletion(-)

Is anyone willing to apply this patchset? Maybe Alex? Thanks in advance!

-- 
Best regards,
Dmitry

