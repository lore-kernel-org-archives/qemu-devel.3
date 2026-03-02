Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A01E9B36D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1yV-0006m9-MQ; Mon, 02 Mar 2026 07:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx1yU-0006lO-7m
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:02:10 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx1yR-0000hC-Sm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:02:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772452908; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TTu75sq9I5G3rZMHg5z6/OE8HzkU7X2S0nLJ8W8ogM3BWDJRVoy/zkCPHoWet8eVUSIckDz6nYb8rB7BMzvjrayRvEpUHz3T+g3XNnMRg0H4W/S8ENNctznPdGydFIMfxPgUF3Uc1NmJZ0Gnp+mkSy1Jt2db7z8l5O7vB8mVvCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772452908;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zmAzSxxbZG8JaW/hZ4IGCvV/4RIyeQn62agP5AAb74s=; 
 b=TzxQ4s15unZm6YsK3SgmN6knitJSqmBqFyTVi38CyhwoVn5C8N3K6daNfwKd5Dv3v8c5Mgi+gpMSdA76A8RANnsBtKJ//NpN6s2XgsjbTJtrimliBj6T0xldp50VrzHO5te90e5+iB7IOqDJQRa+aKZkRnPCBSNeu3/zXPlmsSU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772452908; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=zmAzSxxbZG8JaW/hZ4IGCvV/4RIyeQn62agP5AAb74s=;
 b=FXimWOBfXb4nX8bW/yKI8trOLJGpLMXmFTHGTK5nx2RJTFeAvZs9NdcEAVnI0RXS
 RK57d8CtmC9YvHwSmf8vTMGGhy/q45vel764rjQTZXjRLoHoscL9xog6SPXRW285VCr
 r6LVYmPC37T4AC6Xns1J3HGcOAc7mOLzFLWUfiEw=
Received: by mx.zohomail.com with SMTPS id 1772452906687743.5413320330107;
 Mon, 2 Mar 2026 04:01:46 -0800 (PST)
Message-ID: <9be98e8d-6b3a-438b-9153-f4dc806158a0@collabora.com>
Date: Mon, 2 Mar 2026 15:01:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/21] ui/gtk: Restore original context after new
 context creation
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
 <20260301204838.596994-3-dmitry.osipenko@collabora.com>
 <ea2b4664-fa77-4ea5-abac-bee42f98c8c6@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <ea2b4664-fa77-4ea5-abac-bee42f98c8c6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/2/26 08:58, Akihiko Odaki wrote:
> On 2026/03/02 5:48, Dmitry Osipenko wrote:
>> Get currently bound GL context when creating new GL context and restore
>> it after the creation for consistency with behavior expected by
>> virglrenderer
>> that assumes context-creation doesn't switch context.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   ui/gtk-egl.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>> index 0dbb429958e5..be769bcbfbb1 100644
>> --- a/ui/gtk-egl.c
>> +++ b/ui/gtk-egl.c
>> @@ -218,10 +218,17 @@ QEMUGLContext gd_egl_create_context(DisplayGLCtx
>> *dgc,
>>                                       QEMUGLParams *params)
>>   {
>>       VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
>> +    QEMUGLContext ctx, current_context = eglGetCurrentContext();
>>         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>>                      vc->gfx.esurface, vc->gfx.ectx);
>> -    return qemu_egl_create_context(dgc, params);
>> +
>> +    ctx = qemu_egl_create_context(dgc, params);
> 
> I think it's better to change qemu_egl_create_context() not to require
> eglMakeCurrent().

Ack

-- 
Best regards,
Dmitry

