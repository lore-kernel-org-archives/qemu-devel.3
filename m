Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B94CC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 22:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfneb-00076d-SS; Wed, 05 Feb 2025 17:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tfneX-00076Q-Kf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:13:50 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tfneR-0001SU-S8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:13:46 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738793605; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iKfu+TwUPAeY91jLjSTTFaATAqNuNQ+SlcUOkYP3ufs5PoquicvYkclBSIxf3rZENbN+67sD3KcJG/+t2Qq4FN4pwxWURb/VaRgbqBr1AiDrP0Ji4jOHoxWdm4BRzNaxiVpma5AOyaJrn3PHQRvRvSmC/RtJtyTOZLB5SqW6XFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738793605;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vb5xYGPMXXnQXSUAtJ6Iy6nemOkIuFGoKTpIt/FqheU=; 
 b=YrI1WN0ZXZbZKSbLCdk5vD990vOnDohsbzgmizOGiRN569JNoN3i47K27FPd/bGLaniiGCTnxUuVlk6LFyy0CyeyRUlrvbtATC5MtR5XF//LdJdrfL8hmXruQLRDYdCAdrLEWUZjfWmopz3ZB44aVgfKAr1NCijXMe925USd3xE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738793605; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vb5xYGPMXXnQXSUAtJ6Iy6nemOkIuFGoKTpIt/FqheU=;
 b=hkkRxzHwbJOW2lvJjdSdk6gy5qj9efdZWBGroKn6A/xx9jH+OJpzCqbhjiIxbn0R
 3d7tBkZfNVpR010HMs1dvlKjoYvlJYWUDrkvBgS0PA2OrBSy/fY09N0GzbOmoa0xdJU
 L54zFtmxftHMqyHF/ZSlTvJ3TdYj4k1Q1vUFeWrw=
Received: by mx.zohomail.com with SMTPS id 1738793602350868.8646493181757;
 Wed, 5 Feb 2025 14:13:22 -0800 (PST)
Message-ID: <9f81a22e-edd1-4525-b97d-3be31057ad26@collabora.com>
Date: Thu, 6 Feb 2025 01:13:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Pau_Monn=C3=A9=2C_Roger?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
 <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
 <878qqmbzb9.fsf@draig.linaro.org>
 <SA1PR11MB6870F6C4479128EA3CBF9543FAF42@SA1PR11MB6870.namprd11.prod.outlook.com>
 <63a991d6-dfb5-4a7d-80d0-4c31673d3251@collabora.com>
 <PH8PR11MB687958C8B4F275CA4D9BD614FAF72@PH8PR11MB6879.namprd11.prod.outlook.com>
 <4250091a-d823-4bcc-89ce-80f3f26f3be4@collabora.com>
Content-Language: en-US
In-Reply-To: <4250091a-d823-4bcc-89ce-80f3f26f3be4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/5/25 23:08, Dmitry Osipenko wrote:
>> Thanks for showing me the video. I will take a look and check what would go wrong here. I kinda understand corruption may happen
>> in some scenario but I don't know what could cause the upside down image. Do you have any idea?? Maybe the frame was temporarily replaced with
>> a mishandled texture that QEMU creates from the surface temporarily but I am not sure..
> No clue. Could be anything. Could be a GTK/Wayland bug, could be an
> obscure QEMU bug. GTK expert wanted here.

Alright, it's bugged with "blob=on", but works with "blob=off". While I
don't see QEMU using blobs. Might be QEMU's bug then.

-- 
Best regards,
Dmitry

