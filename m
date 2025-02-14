Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0329C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixaB-0003eA-HW; Fri, 14 Feb 2025 10:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tixa9-0003dz-Qf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:26:21 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tixa8-0000gx-0h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:26:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739546772; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SXWPm/Wkz2mWgRLiJk/vbg5jJRBuGpL+8qMbdhzPvywSenPtT/uBJIr20TMrDnpaWOKb8jZjIWlqiMNtStqG5C0fTt0tQeJPc/qbQVkgHPGdAKnVGTfvIrheOOX0eEiHmm0c7nJ6/vGSxq05f2YTRJ4+wNzhl9mKUI8qo3HK09Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739546772;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AtUm2Q6q6TdJOR+h+LFGHNYqGkxytbKOgqxen7dZHRM=; 
 b=irwFtz5/DHdNcEIBMZUbqWWVDMlVMFd+vzp46lekM1BsD7FliW2dgyUtdqt0aJuUEKiG+g0lJ6gyfJm/8VkH0avN34WCTz7FtZ6c1BGut5iP1jQYbUQFeQI+3P6Srbgcn/sC51IZty3VyFP94EiB/Owkl0zcWY8aHl5PIqssZ9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739546772; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=AtUm2Q6q6TdJOR+h+LFGHNYqGkxytbKOgqxen7dZHRM=;
 b=AKNwV7tpNYiN8BHB7geGvDPlrpsp5kI7uOQeYcDqB+MhlhKE/AZGE+V1/RFyJvuI
 DSZbXYrLtCtNhDDbwRR2lHeVwPPUPoos0jhaQt2mMaOcYb/ZMyg9s5OjP6t55Lfi+MW
 YKtxh25UvUEdx/2gf6eEmEfPSwm9IDHR0HJCeT1w=
Received: by mx.zohomail.com with SMTPS id 1739546769779125.19517826859078;
 Fri, 14 Feb 2025 07:26:09 -0800 (PST)
Message-ID: <657183a6-5c0e-4bfd-9b83-1fa98946c330@collabora.com>
Date: Fri, 14 Feb 2025 18:26:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk-gl-area: Remove extra draw call in refresh
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
References: <20250206225304.1739418-1-dongwon.kim@intel.com>
 <878qq8pqmk.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <878qq8pqmk.fsf@draig.linaro.org>
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

On 2/14/25 17:06, Alex Bennée wrote:
> dongwon.kim@intel.com writes:
> 
>> From: Dongwon Kim <dongwon.kim@intel.com>
>>
>> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
>> which causes some guest display corruption when gtk-gl-area
>> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
>> simulataneous accesses on the guest frame buffer by host compositor
>> and the guest.
>>
>> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Reported-by: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> 
> This certainly fixes the corruption I was seeing while testing Dimitry's
> native context patches and doesn't seem to affect the venus test modes.
> 
> So:
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
>> ---
>>  ui/gtk-gl-area.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>> index 2c9a0db425..9f7dc697f2 100644
>> --- a/ui/gtk-gl-area.c
>> +++ b/ui/gtk-gl-area.c
>> @@ -129,7 +129,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>>  
>>      if (vc->gfx.guest_fb.dmabuf &&
>>          qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>> -        gd_gl_area_draw(vc);
>>          return;
>>      }
> 

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

