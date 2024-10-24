Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E42D0BB4A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 00:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3lPw-0002bN-U5; Wed, 23 Oct 2024 20:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t3lPu-0002b9-G0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 20:09:30 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t3lPs-0002pA-4s
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 20:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729728552; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PafJ9G8pz0K5EuoFwG/m2lqy6/SXKrkPs6QZfkscOF95jn2aNRrYUNGPHPdrZpgVXt/kajssecdPqgre0ceYwPY5zbzjW57zoVbmWarBFFd4iPo9+Q20hL76whZijc2jpirinDLeel80nLiQysdorHHzHqnIyjUBMgDissTa0xA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729728552;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Kgo5bTQvBh63pe8d1VgGi3OBQQ1zuzOkN2K07GQrvSw=; 
 b=TS1ZZN9orgEuu21NUIPKTbqfvck8sDOC3LdWR3WszjYSfP1RyHSft+eVJAidcwGOZCD3nSm+7z0r2K1TZzjcKXO9NlAooOH8ml69cYzW5Y2Wm0pNRCPNtn8ecEhVmHrjppy00MBAzTuh1AivIl5Kende45qzKtKgz4O0f3JfFq4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729728552; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Kgo5bTQvBh63pe8d1VgGi3OBQQ1zuzOkN2K07GQrvSw=;
 b=ZCTj39kJ88l4sih2SkkIp2tZVkdJg0c5cjdFDO8jrruI/hLaa86fddTSnJUsalBz
 ++5JEOpE9MQfzEDlp2ng8zRmwRWlUMWm0ukeOaXsdj/nb4iq9iXR2tusPujYB97371Y
 qwZ9J4AHo59Q+2/ekTZCsGu0T6CAm5RiiCiOraD0=
Received: by mx.zohomail.com with SMTPS id 1729728551295499.0876305106515;
 Wed, 23 Oct 2024 17:09:11 -0700 (PDT)
Message-ID: <e444ad67-7527-44f9-9a27-dd8f0ae990dd@collabora.com>
Date: Thu, 24 Oct 2024 03:09:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] virtio-gpu: Support asynchronous fencing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
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
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-6-dmitry.osipenko@collabora.com>
 <2020cf8d-32b8-459a-91d2-59b2464f817a@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2020cf8d-32b8-459a-91d2-59b2464f817a@daynix.com>
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

On 10/23/24 13:04, Akihiko Odaki wrote:
...
>> +        ret = virgl_renderer_context_create_fence(cmd-
>> >cmd_hdr.ctx_id, flags,
>> +                                                  cmd->cmd_hdr.ring_idx,
>> +                                                  cmd-
>> >cmd_hdr.fence_id);
>> +        if (ret)
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: virgl_renderer_context_create_fence
>> error: %s",
>> +                          __func__, strerror(ret));
> 
> This should use: strerror(-ret)

Indeed, here error code should be negative, while for the legacy
virgl_renderer_create_fence() it's positive. Will correct it in v3, add
a clarifying comment and address other comments. Thanks for the review!

-- 
Best regards,
Dmitry

