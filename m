Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE550CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxUQ-0008L9-Bz; Mon, 17 Nov 2025 06:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxUO-0008Ki-HW
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:33:44 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxUM-0000sx-Qt
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:33:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763379201; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ii3wpSLRXw1eBVuFKZJxfmQE5WHtsmNwEKlKwYUDTTiE541F1uOG8f/rK3oDgcFBcJyG3CLC1xdgsNY3gDmegMW7VslwSTNZ45nxptRgawN9yA9fDJaSzrUvtFWc8auVWWpFiMxoAJYEz8ZWmvtRK9GgZ9zQmxZumcfwo1WEm1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763379201;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=q45g+dHm5yhQ+73kApiChcOVqQR9ydC3kOFlaGMf/9g=; 
 b=klSSY9WvoqFlsd1KiTT9scXC5K1Hw+J74LAJSyZwMsbJQhVVILdLCarT+/768vd2J+EnyDa9Mx0+TGaGtP7nWLDwk2Z6/WMunWTw6t7AgqKD6nJ1egfDpmWKkURMrVdQSv9+XN2/EgZNc+w0hkZTJqozUfEi3eYOb4+8inuFhnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763379201; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=q45g+dHm5yhQ+73kApiChcOVqQR9ydC3kOFlaGMf/9g=;
 b=BtlDWlNGqPKM7EHzRdFoo/90dOtvjCJMsiRrRYkivrRU2Rgzmo/Mi+MjAe4xCa5B
 oA2UhVMM8ez/r/5KYPBfS/wvnNSW8R9v6Bwp8a7kHTDQrck7bYh+UhkgkPVqU/0iMIB
 H4ug2WydpPdFs+CPOToks85Cr2i1GY1LLnNXpJqA=
Received: by mx.zohomail.com with SMTPS id 176337919834018.834618143864873;
 Mon, 17 Nov 2025 03:33:18 -0800 (PST)
Message-ID: <80d17f01-621b-48d9-82b3-75d42416a526@collabora.com>
Date: Mon, 17 Nov 2025 14:33:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] virtio-gpu: Support mapping hostmem blobs with
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
References: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
 <20251116141427.2325372-3-dmitry.osipenko@collabora.com>
 <75560c73-2b86-46a6-ad91-cc4a6de92e13@rsg.ci.i.u-tokyo.ac.jp>
 <09a59805-e2e3-42b5-93ac-cf866272a7c1@rsg.ci.i.u-tokyo.ac.jp>
 <a8d15805-5b9b-495b-8e4b-05b6f77ccf39@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <a8d15805-5b9b-495b-8e4b-05b6f77ccf39@rsg.ci.i.u-tokyo.ac.jp>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/17/25 06:03, Akihiko Odaki wrote:
> Sorry for sending a reply again. I keep missing some code...

Thanks a lot for the review. All comments look reasonable, will address
in v3.

-- 
Best regards,
Dmitry

