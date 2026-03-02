Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95DDE9B36D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1wp-0005yY-Bc; Mon, 02 Mar 2026 07:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx1wk-0005tE-T3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:00:23 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx1wi-0000aL-NY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:00:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772452778; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PUgfgo7PpL3FYatocPFeU2x3Hayy4ammU+7wxFTa3kmiBBskW5s4qLHSsWyXusEUgyO2ajCYwHcpBs7T9vs3RusgvKQm2pSyIUoKgk+EMXM9rwdYxycISVtnxOVGDB6pKF9VJc2raMWwpp6wqSzesHZYV0Bm4AumH0dV/XkIFgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772452778;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RY+SMFcidu41xylU8aRf6XGKNbIW9Urs3TPJCGe9ASE=; 
 b=gjJqgJOrhAKlBWBzrm04EoWk28YELW9dJcjAzOgMltUa9bcLEvEo2Pp8asXBLNnB2Uvz/D/Syu8VPQ1xUYpiVid8r5NhnTmIED0pr58skLhtjX/J58i/IQyDp/f53iP8/SNepn3D8ODLrZ9LQiGrGLH7PTRZOekdIXqH+3gBe7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772452778; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=RY+SMFcidu41xylU8aRf6XGKNbIW9Urs3TPJCGe9ASE=;
 b=iNX2zlOjej2XcU0EKiT1Oc03A/S4wIByOaVa2WiQAqIN+lvhI7ugvtGQA1J3QoPv
 j4jCAKwqvuldRuxMZyscFlJIwp1ku2xgT+JNc0kUBI/m58HmKB2S8hfv/EkcImxMKo8
 gABYXnG8DUW5/arpMWjXqUpAvqcjEB38HJ8T27ak=
Received: by mx.zohomail.com with SMTPS id 1772452775778259.9340348509427;
 Mon, 2 Mar 2026 03:59:35 -0800 (PST)
Message-ID: <d8078eb8-86e0-46e5-8843-f29f78034a0b@collabora.com>
Date: Mon, 2 Mar 2026 14:59:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 10/21] virtio-gpu: Bounce virtio_gpu_ctrl_bh() to
 main-loop thread
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
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
 <20260301204838.596994-11-dmitry.osipenko@collabora.com>
 <87bcde7a-1052-45ec-9d09-78bf875c2d46@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87bcde7a-1052-45ec-9d09-78bf875c2d46@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/2/26 08:57, Akihiko Odaki wrote:
> On 2026/03/02 5:48, Dmitry Osipenko wrote:
>> QEMU's display GL core is tied to main-loop thread and virtio-gpu
>> interacts with display while processing GPU commands.
>> virtio_gpu_ctrl_bh()
>> works in generic AIO context that can be processed from vCPU thread,
>> while
>> GL and UI toolkits are bound to the main-loop thread. Bounce the ctrl-bh
>> execution if running from a thread other than main to fix the problem.
> 
> I think you can make use of iohandler_get_aio_context() instead of
> bouncing.

Indeed, thanks for the suggestion.

Also noticed that virtio-gpu uses qemu_in_vcpu_thread() for the
virtio-gpu reset BH, but IIUC the BH still may be invoked from vCPU
unless BH is tied to iohandler context.

The same problem should affect the virtio-gpu cursor BH.

Will move all these BH's to use iohandler context.

-- 
Best regards,
Dmitry

