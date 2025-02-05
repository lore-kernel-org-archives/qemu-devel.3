Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E94C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfkIM-0000pT-2U; Wed, 05 Feb 2025 13:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tfkIK-0000pG-IZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:38:40 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tfkIG-0003ML-RV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:38:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738780685; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=euUoQ/v8MPJdF4bI6jy0GN610A/5fvt4RNSuyNo9qDkINSwPRAfVVrG7/OVipaGdLbOVyRE/ir48Dwp3yYss8rOHW2JR9YLwnqc4VCNfQRXw6DQnQ2s6fDBvaHUDnVhNoNL21poqPjx2bh+hfVi+S45ZcbVSlso87JT9tjVHEtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738780685;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uD2bROOLjrjM9UAI7X+wjpvuQ5sq1vhxcYtMgNFrFes=; 
 b=fYaKqYfgK5rqTZNt37a4GXYz16J6EWtUQkBL327kslMhoUG9z65fTWu+36nVif4Skbm2e5bDCg2R5x9yJsRoX9zkUDSFZiQA2fF2A5NtT6Q/dPQyHSmZrwQgBH+JWrk5fMrSz1+ek1yjQCLf2FzA48S9DloENUummE9QvDsAQIQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738780685; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uD2bROOLjrjM9UAI7X+wjpvuQ5sq1vhxcYtMgNFrFes=;
 b=h9E/Sxt53jHgGIQIogl70gCavRGQxBGAvL1+alUTatct70pybaYABGdiC2kLXmRQ
 a/m+T+s+DyiiXdQCBrRBFfT7Pl4hq0YgAWx3A56fAZr8lln8YHlnlKng4VbiuBXcVoJ
 oLIeymPb+baoyZilkGuzr3HAKlK5z6SP9ykoDggU=
Received: by mx.zohomail.com with SMTPS id 1738780681688914.4547461864809;
 Wed, 5 Feb 2025 10:38:01 -0800 (PST)
Message-ID: <63a991d6-dfb5-4a7d-80d0-4c31673d3251@collabora.com>
Date: Wed, 5 Feb 2025 21:37:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <SA1PR11MB6870F6C4479128EA3CBF9543FAF42@SA1PR11MB6870.namprd11.prod.outlook.com>
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

On 2/4/25 04:51, Kim, Dongwon wrote:
>> Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
>>
>> "Kim, Dongwon" <dongwon.kim@intel.com> writes:
>>
>>> Hi,
>>>
>>> The commit below could change the timing of drawing by making the
>>> drawing done at refresh cycle instead of via drawing event. So it
>>> looks like either dmabuf or client's framebuffer is being written and
>>> read at the same time. Hey, can you describe how the corruption looks
>>> like? Is it just garbage image with random noise or the actual frame with some
>> defects like tearing...?
>>
>> The terminal gets mirrored upside down and the mouse creates damage as it
>> moves about.
> 
> I am wondering if this is reproducible without virgl and drm native context (like w/
> sw rasterizer on the guest) as well. 

It looks like a problem with redraw areas, see video sample [1].

[1]
https://drive.google.com/file/d/13PN2sFoPsM2ox6_gf9GLXStbsZ27xlLy/view?usp=sharing

It's reproducible without native context with a SW render using '-device
virtio-vga,hostmem=8G,blob=on'

-- 
Best regards,
Dmitry

