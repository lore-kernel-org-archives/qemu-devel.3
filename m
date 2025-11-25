Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C208D0EE08
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvIc-0001o3-28; Tue, 25 Nov 2025 10:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNvIS-0001ly-Gj
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:49:41 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNvIP-0000q0-GI
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764085761; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HvKGh6eq41FfPLBnGUfrJzFyCk8YO99f7ChwxETwZzKvS9grZh5EePIAS92sWdCnwGooGUMB5iPSqPRrOXU6T/j9Ufe2kV6sVF70uzYpg0fZ0Lfkc/A0cb40Rv4ocQ4vV+ka+p2Lw6HtI03hU1C8izaplxQHXfqL5PRZCN2u7qw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764085761;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HilQOjUGaMXhYGjus1DhY7oh6AWfyHf+NeE+geHuWyQ=; 
 b=M4XWk+9tAJMDGxFmpQ8xM87f4d4VNkISe+JCg2cuxBybeRozLdiN7oMGOgUoz9grccRxj1P4pJ2Kc43XUJbKjX5/YMG2CmamK1VGwnozUxc00XM8h29jQ63olCL3+aGC/q8vza/nbvDcEz0exPMiwFsmp9GlOV+aNSzZVOvGUYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764085761; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=HilQOjUGaMXhYGjus1DhY7oh6AWfyHf+NeE+geHuWyQ=;
 b=dJhBO6wNPosrecy0GsQ9oJhdlR1MiG5jMuommf9UMvwjBuE2iGPy144DKWm8gwHy
 +BxwRZ/AfhoeeWXSx7QR68zZ2RJJmhxyGI7RkTdVa7aGyb3e3ELZQCtEVHq9bUnyjk7
 /e0PTsbWrXVlb53qLGBzFeLdq9lRk/lylbF8eqBg=
Received: by mx.zohomail.com with SMTPS id 1764085760227171.305304768861;
 Tue, 25 Nov 2025 07:49:20 -0800 (PST)
Message-ID: <4f9d28c9-fae4-405c-80bc-c3bd8e21acbd@collabora.com>
Date: Tue, 25 Nov 2025 18:49:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/7] virtio-gpu: Make
 virtio_gpu_virgl_unmap_resource_blob() return -1 on error
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-5-dmitry.osipenko@collabora.com>
 <87qztm71qe.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87qztm71qe.fsf@draig.linaro.org>
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

On 11/25/25 15:09, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Make virtio_gpu_virgl_unmap_resource_blob() return -1 for more consistency
>> of error propagation style in the code, adhering to QEMU's devel/style
>> recommendations and preparing code for further code changes utilizing this
>> function.
> I'm not so sure of that. If the function is a pass/fail then we tend to
> prefer using bools in newer code. If you need richer internal error
> reporting then start using your errno defines. If this is user visible
> (i.e. during configuration) then we can make more of Error* and friends.

The current code is a mix of all variants. Will be good to stick with one.

Akihiko, what are your thoughts on the best option for the errors
handling? Would you also prefer bools?

-- 
Best regards,
Dmitry

