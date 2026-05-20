Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E44DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPcce-0008KF-M1; Wed, 20 May 2026 04:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPccL-0008E1-MJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPccJ-0008Cd-Fv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779266965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r9dG+XdyiWuOmAaN+EbNOJQCV8HWFrfD0lm7Tq9Vpak=;
 b=J0xfeCOxcz5UvCf1GxpPhJdlJD1u+scZh5VIQofTDej+MFFdRKhTReOJmGopj0iF3L/irn
 NVnZPXNHMBEuCapzLD5R+ZKpbc4x/YFu84eWGyeJyDs8awtaCjDFv58k0yjJuoeNhOhF5W
 xw+6nPSGCIgSKchRXkvq+pp92iq/XJc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-oD82037SPaezCvhIlawUeA-1; Wed, 20 May 2026 04:49:23 -0400
X-MC-Unique: oD82037SPaezCvhIlawUeA-1
X-Mimecast-MFC-AGG-ID: oD82037SPaezCvhIlawUeA_1779266962
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e55c44ac1so3707789f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779266962; x=1779871762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=r9dG+XdyiWuOmAaN+EbNOJQCV8HWFrfD0lm7Tq9Vpak=;
 b=J/gStiBuk6OXgm7mwhl1fp3sPwpEl9iAGLlhbjYWMl0Mbnk0CT8ALUj8KICsm633BZ
 wi49M+Q+V5VCocXgVuVkPUhNfe6ucoJl4VCB7lpsHrkRiSkGTzNYciar+gA/UPjMPI6J
 xrJQm0abu1Qwz8lryVKeZoZuWapcCceHqEkWKLqqZLs1+Q+WOzPEvQ6WYaIa06pKlRFn
 Zrgi0AzRRVobjETdJHUmxCCzr7mTC5mDtGalNKMUVL5yj7yoJ0WPXCo8UnVAKDdnaRxB
 yBeT/GJsjyYboLK0e3GDRsz3i3Jw3nQtgmTVi7s5/jVHN6llsmg/L3/nNwLSp/WdZy22
 ZCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779266962; x=1779871762;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9dG+XdyiWuOmAaN+EbNOJQCV8HWFrfD0lm7Tq9Vpak=;
 b=WzhZAwimijnsH7/ou4HBp4kd8xp1TsHSm4l9MG+XpxKqInlUO9JNZf9ktNspw0pARP
 JX9Et+sUqqKFXqOzolLejxl95uQS+lnJTpXXNClClBIvgk7Ed9XE/tj4cXraOwYn+FNu
 IfOhOlu2cnvk6RGM/oUY+qx/73yDQ5BHEjAO6iL95Txt2o+BiiysSYTSYAimbyCmQ5nL
 kG/JbRLcijqWuU48muSHLa8sqXUTlWjzGOnIIXre4eAI1cMfZ3NKoUaOQYZTrzUiWiE8
 RmcxTQ8cILtZPTbwft1IdMLAbcFHuKpowiBnyuXk9IJ5IeObsPXa4CkFzG30l7L4wNBZ
 WERg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bnr9NwyYRRfCr5Qypk6fgDwU9Y6tJHDZE+nLCkjHASDCNNYRNrw2ndO6BE0tzVq9uOuo5RRcB/2B/@nongnu.org
X-Gm-Message-State: AOJu0Yx4C3FQJDnzwt6B9MGQ8RmLTfjG1uaqFLhb+qyHbuB5Tz/EnpXT
 TP6Gu/oZdyyldp5DdaZKx/NJvoEJPORkTEBht2dav7E5kEHgIMmQCyc57wC8QP2/+bRVGDf21vJ
 dDMMRghGitx1WJXGOkgmUexCNKT59/6hnWBVLTzRmWnqKREVugcFIL33t
X-Gm-Gg: Acq92OF9CASZAFIGFoGJ6ihbwa8DoXgpJtp18eIQoN/nG/6noTyD9FH/5lbxCE/cym1
 PG900J5Whfi3eh2njMTfEo0clB3Dk9cjy+q/XjErMmisVwij2/CxbXLw6QURmtbf8GDW5Whut0E
 wQuZQ9aSSktOEtO/+Bp17uDK9jsiXGVS8FDToLPWX1FCpXBCDoM/OsNliS9sv6JZSEvp5HaU/AV
 4cus4ljLHWu1EIaS+F5YEEaVriFy5HSlQ1X7fk/nSzr5sZV9Alti2R0lDheqrsou0eaWCzItq6T
 uvD5tOYqEclLvUPtAKyHin2b3DVeoTAPcQ90xNJPhYInX4fLK+Rr2ViKZ3Owq7zB4VCE0/QggUL
 K7S6dmHp7awTaa8L7vuHhTs6vfz3e1s9ow+0Gi0OYBpmUxKJ5fPidFzNC2c/6gFTVWZVXDds=
X-Received: by 2002:a05:600c:8184:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48fe60ed790mr344987285e9.12.1779266961811; 
 Wed, 20 May 2026 01:49:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48fe60ed790mr344986885e9.12.1779266961317; 
 Wed, 20 May 2026 01:49:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab2896bsm129686905e9.4.2026.05.20.01.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 01:49:20 -0700 (PDT)
Message-ID: <7ce88fad-1277-4512-be01-4a9fafd5e3d8@redhat.com>
Date: Wed, 20 May 2026 10:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: use a valid object ID for iothread
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20260520082459.1132051-2-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260520082459.1132051-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/20/26 10:25, Daniel P. Berrangé wrote:
> The objectg_new_with_propv/props methods failed to validate that the
> QOM "id" was well formed. This allowed the vfio-user code to use an
> invalid ID of "VFIO user" (space is not permitted) in its internal
> code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/vfio-user/proxy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 314dfd23d8..3d0d72e8b7 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -933,7 +933,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>       qemu_cond_init(&proxy->close_cv);
>   
>       if (vfio_user_iothread == NULL) {
> -        vfio_user_iothread = iothread_create("VFIO user", errp);
> +        vfio_user_iothread = iothread_create("vfio-user", errp);
>       }
>   
>       proxy->ctx = iothread_get_aio_context(vfio_user_iothread);

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


