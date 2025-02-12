Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3D1C021A2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 02:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti2mD-0004Fq-NL; Tue, 11 Feb 2025 21:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1ti2m9-0004FD-Ae
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 21:46:58 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1ti2m7-0003oO-CN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 21:46:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739328393; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DnBUcccNt6MjDzM1/FpwGyrJ3Lam12Mqs0bwyiNuLuXPdFXd4QQ5bFbDFIkSqX6A1H9571tocsvtEPJOcDSzXKbfAPGZ4cGB1c4s9pAf2//OHdTokcVNv1CzGbkn54kmTXx2TBBVbdRetGnornemrhT1SAOOSl4gQSmvKU+FBG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739328393;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QvKZn7iLsZ0zA/EnBMnxBfp4etfy2pKRUcGyBmm0EPY=; 
 b=KszjctUUp8t4bo4whc9JFz2F5KjG+F2IrDkrnJevmVeY9pr709S6Eho5gRqP4Fmt5osKHZIlWrAFKNt5/pT3nHn9bycw3mpTCDw03Zek3y3COP+bl9E7f35jjkQvMQW7eSSFWnimDd+XzeCK8x9A6tELkE14puq2tOV/wBkOwRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739328393; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=QvKZn7iLsZ0zA/EnBMnxBfp4etfy2pKRUcGyBmm0EPY=;
 b=GXoP9ouSBEHiQ7CBnKBwZoY5uYB0rd2ctu8JzSIUgyEpntNoQ3QuSOdfChaL2jMY
 uvw7bQiRaQ/hLFE2nuMDrKMn/7CyA9FBZRvmjmcff36wjezr+9TLkKdjkA8GAu1Os0+
 q1zl3KSt2jluOK7CzQ2QLZXraYz549OfIuCRfhTo=
Received: by mx.zohomail.com with SMTPS id 1739328390923754.8557959027769;
 Tue, 11 Feb 2025 18:46:30 -0800 (PST)
Message-ID: <6db636f8-18f6-4461-9d95-cac7590acd15@collabora.com>
Date: Wed, 12 Feb 2025 05:46:23 +0300
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
 <9f81a22e-edd1-4525-b97d-3be31057ad26@collabora.com>
Content-Language: en-US
In-Reply-To: <9f81a22e-edd1-4525-b97d-3be31057ad26@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/6/25 01:13, Dmitry Osipenko wrote:
> On 2/5/25 23:08, Dmitry Osipenko wrote:
>>> Thanks for showing me the video. I will take a look and check what would go wrong here. I kinda understand corruption may happen
>>> in some scenario but I don't know what could cause the upside down image. Do you have any idea?? Maybe the frame was temporarily replaced with
>>> a mishandled texture that QEMU creates from the surface temporarily but I am not sure..
>> No clue. Could be anything. Could be a GTK/Wayland bug, could be an
>> obscure QEMU bug. GTK expert wanted here.
> 
> Alright, it's bugged with "blob=on", but works with "blob=off". While I
> don't see QEMU using blobs. Might be QEMU's bug then.
> 

Looked further at it. So QEMU was using blobs with "blob=on" and I was
looking at a wrong place. Then I found that setting y0_top=true for
dmabuf makes display to show upside down, but there is no rendering bug
with it. Something redraws display with y0_top=true, while it should be
y0_top=false. I couldn't figure out how it's related to the offending
change.

I also noticed that QEMU checks Wayland presence in
early_gtk_display_init() and doesn't use EGL callbacks that are used for
X11 display, but the y0_top logic looks the same. Interestingly, Windows
should be using same display code paths as Wayland, but I don't have
ability to test Windows.

If nobody will be able to fix the bug soon, at least reverting the
Wayland part will be good to do.

-- 
Best regards,
Dmitry

