Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8086CF8862
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5WT-0005Zt-QL; Thu, 20 Nov 2025 09:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vM5WR-0005ZF-Ba
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:20:31 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vM5WP-0004WA-KQ
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:20:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763648410; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bCN5w8qgNGBw0TUoqr9aBIf2zNf00CmXjdMZH7UjuBRHxzZk8k3OsHu2+rsBlXH0MWFt2HtsB7w8Ee/h/LCoj+bUbsHqj6A1JB4tBz3lMDAPXffUf+6kUmFWBBYeWB1IzqmEZo2BtbfctlcTvA+z5Zt/vys3p+oju2OYVqaz77w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763648410;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w5uthRHM4LpgNjaFrP0536GzY9UFJcunFp6zCJkj5us=; 
 b=SRamdLlz35jj95BA+GVLR9sbkzTxIu7RuXW5X+0Qa3Vfnf+xhvYtMKAQLHweikQ+0uIf4myo7Jl+V0aA5Hz2W4/FfOtdvxPK+V3KgA7/+b4gSfSAjMrgIQiSTr7lG11TLQSwiImCzcVRvTF3YTntEAbrNkIWlmYvkQZXvPq4E/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763648409; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=w5uthRHM4LpgNjaFrP0536GzY9UFJcunFp6zCJkj5us=;
 b=hE/1tgQzp6LLf3NPR1DUBaYS48PYSnl1nJZwpM+L4qtA/hp7vPRaPAf097WPZZQj
 78VIsPkPmLYtrBNlodQgfl1e38qdy4ExRrsQvhMMfj2VzYnTQBckh4Uc3UHGZokfkdl
 hiD1CqUUk5cltpXCa/gMAdL7nEZv0hogy73i9UX4=
Received: by mx.zohomail.com with SMTPS id 1763648407545517.968040040091;
 Thu, 20 Nov 2025 06:20:07 -0800 (PST)
Message-ID: <ac28484e-f5f9-42e3-be2b-721e8e4741e1@collabora.com>
Date: Thu, 20 Nov 2025 17:19:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 7/7] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
 <20251120040632.4036204-8-dmitry.osipenko@collabora.com>
 <0d9d5573-8ab8-42b4-ae1f-82e01b4f4fe3@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <0d9d5573-8ab8-42b4-ae1f-82e01b4f4fe3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/20/25 08:14, Akihiko Odaki wrote:
>> +    if (virtio_gpu_hostmem_enabled(b->conf)) {
>> +        map = qemu_ram_mmap(-1, b->conf.hostmem,
>> qemu_real_host_page_size(),
>> +                            0, 0);
> 
> qemu_ram_mmap() shouldn't be called if !defined(CONFIG_WIN32).

Indeed, see now that mmap-alloc.c not compiled for Windows target.
Though, it appears to me that Cygwin provides a compatible mmap()
implementation that supports MAP_FIXED, thus the mapping likely should
work on Windows.

Will re-add !defined(CONFIG_WIN32) and address rest of the comments.
Thanks a lot for the review.

-- 
Best regards,
Dmitry

