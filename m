Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D9BE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 16:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX17Q-0004MK-5i; Sun, 12 Jan 2025 11:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX17O-0004M4-5u
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 11:47:18 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX17M-0003AR-Qv
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 11:47:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1736700424; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F8eqNBA5uPWw94rOmPtZ0RjBfu8eZcY+tr8kBiiBNxOYEkqDut5P3ZNf4k2Ywg2apqU8lnISAMvkeoMVoqp88LBI62kTW18t/rfS0AcR35IPWNGQM+wQK/Mt1r4qldLtw8Dl/Fapo6nSFOdeRpQ8XD1Q5U29AqPG72PM2JOVJ0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736700424;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XNeLDW6i/SBj3rIMiqW1QtVTJ4WKPSEBG3UE4A9ScK0=; 
 b=VKcEKrgk/A3wVQSSoNMvnLcOoDYki1I2jsmb6YLBhYbJrQKgGV70ATWL3g4Eyz3SHpcz3n+4QMiKkSpcAwFrqUpzI7tDnIhmVIAIKzvKhi6+q2BP/g8AmcIQv2m5yaacdNJyxS64QnVi4z4rCJ4n1KM89ijeoJwlmURJv9Eq9Bc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736700424; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=XNeLDW6i/SBj3rIMiqW1QtVTJ4WKPSEBG3UE4A9ScK0=;
 b=klT6KYqaCBs8oxi54pSUEIVa4T+V79id8Gvhi/wfqPsFC3T4tCWhsjmwNjr1n+ON
 /dLiPlsPf306iEl1Od4vmp4YMc+J1WMiNLPP9UwRoMDK+biDRYr5cm++cb8DS8i16YK
 /rVfP6rI+LtKxsUzwJotoT7T76B0rV2/h4lMum3Q=
Received: by mx.zohomail.com with SMTPS id 1736700421850274.9927537984696;
 Sun, 12 Jan 2025 08:47:01 -0800 (PST)
Message-ID: <307120fe-c950-42d0-a775-a64d847a3b00@collabora.com>
Date: Sun, 12 Jan 2025 19:46:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
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
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <87ikqm4wmp.fsf@draig.linaro.org> <874j24vwku.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <874j24vwku.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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

On 1/12/25 19:14, Alex Bennée wrote:
> So this goes away with:
> 
>   Linux draig 6.13.0-rc6-ajb-00144-g8c8d54116fa2-dirty #27 SMP PREEMPT_DYNAMIC Fri Jan 10 16:57:29 GMT 2025 x86_64 GNU/Linux
> 
> So I think is an artefact of the PFN page locking failing. I guess
> native context is more prone to issues? It is a bit odd as I have loads
> of memory and I think the intel graphics are unified memory but I don't
> know how you would check.

Native context is about same prone as Venus. For Intel GFX it doesn't
matter much whether it's dGPU or iGPU. i915 driver would use huge pages
for UMA which is affected by the same KVM/PFN issue. In a case of UMA,
you may explicitly disable transparent huge pages to work around the
problem, but this is no necessary anymore using 6.13+ kernel. Glad it
was an easy fix!

-- 
Best regards,
Dmitry

