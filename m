Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B92FD875F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TgM-0003l6-4s; Tue, 17 Mar 2026 08:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2TgI-0003cx-0P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2TgE-0003ZC-Sm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773751069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSQ6bJvuIxl/uFLBcQ3FrfoPi2RL7SvB7DNlsD2RMpI=;
 b=aI+k3oISqZiTQhilDKbw4uRf0SVkaPoC/NCwgATKZ399T4kyM7TKxvx81DAGg5QDFErXrx
 1hAKCaKc4SMg/YpNxxPA+20iwShcrqz/Ieptu1nyyRwwGvACwioUZT3Y5k0lwdUinhMOzn
 rmtlOncZIFeeGqUotZWdEB4zBekxKE8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-ncttu0EyNEqD1smVvDN2YQ-1; Tue, 17 Mar 2026 08:37:48 -0400
X-MC-Unique: ncttu0EyNEqD1smVvDN2YQ-1
X-Mimecast-MFC-AGG-ID: ncttu0EyNEqD1smVvDN2YQ_1773751067
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485fb873e57so5296165e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773751066; x=1774355866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSQ6bJvuIxl/uFLBcQ3FrfoPi2RL7SvB7DNlsD2RMpI=;
 b=Hh7FmILY7W2+jym+uxrvlZNx/PbktgxawJhnFVMsMp2OGvNQq2xMrficp5mpSzuMhc
 t23voC79LuoR3l22dM3A4xACPK7MVLmJlEKnzswxS4XGhZPylBbM1sjt/C0RgaKzkRY6
 HxyaUeLUPABAQx3DCED0yRAh2QRkncT5f2p01O0E1Kxl8l/U5Rdlj+CM4iuvKMtmW3je
 m1uIusxxC2vUtaTQa2e5Tbc/ZOFdtspzlLa7ujsxtSx/SMDmBmeppX2gt/Q2r4eG2aCg
 TzmjZkEgpMfoXfEubZJ1DZcplkxBfLDEC1LWgxpQlkskdJiSg4MH4lpHRb36Q3l8bAhD
 +j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773751066; x=1774355866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sSQ6bJvuIxl/uFLBcQ3FrfoPi2RL7SvB7DNlsD2RMpI=;
 b=FKEtiYaf388k6cV+2oHsCQ884vaJAiLtic15y1eC/6YX0Vdbli5C0yapbLld1DOwp8
 Amai/DJOqWmASxW3qjdCJS7EOUo60kzDODaI2A8QYkvD6VGODlDaaw2sPCNz5LDHwx+c
 tdv2fRSVy1AnXqMYY1Sw8ExbRZrgGCoGXhyqPLdVFc0gK5v9iXUtJvlCGEuUo98STpKz
 YkVP/vyJFXRCXVqjdlYzQFIUSezd/1f9W6RdsqArgRoOKtIWlJn+gZpF4JDd/Z1Iz6jO
 jZRlDZA9C3h3OZYitgpdQfyK7MyLL3eBa9TuKFkuL5Sb4evCD2N0ztVbkZooQPzM77Hf
 VmGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxl4crNrS+OtMBHjg/Lj4excPZGto7/FFnuqoRGfbqZH6e2gIzsAefa/hRgjOsZ/BQCl3Q4GFvkYGp@nongnu.org
X-Gm-Message-State: AOJu0Yx8QB0hPrCGd+Ue97ZUJ4TbPLNyaOmIWNOwLrmXW0TOFlGQ6qJn
 TqxDb1TlR8tNXEAjWWcLH17xrzVs0EcHK0J3yYuf6vwlN7eyYb6mIXcUp6hsr/Um/sEKO///tsN
 UX2ysm4fTeb7FocTQhMkELZMjfhGCLrQZMbQMaVUNYu7dMzX0NmwaEIRWK1Wg1UUU
X-Gm-Gg: ATEYQzwz/tpCVG3846kjnqbcin+PkVRnlX6IlhvC509rRralJS07z7vHnZsy2xu1yuP
 EmHvZRKtuHLT0e6HLBv6df2bISNztacui7U+uEftSgF3r2G9eCHnwz9j9+R7BJaQCvNX5otugsW
 89tWjydnTUsRKA9nJAdGGDTHMTnTCfHUAeBlPR1VBN6+bahp7MaOiWOR9shczdtiKmUAsm4Bchu
 WxlYFRouxvbQXEZiyjlmaWSOntvrkYaTPDKi1B0lv+ruofjADIBI6HGzwbL3x4pMk3CM0Fo/1Jx
 ulNh8uQePyLacPNy1Ix1AbgtFPvuHjGKDh3V6maFb+KqZq+gDagHRIX5AJmm250+T7qNy2N7Wwg
 5slvmjftAcIWQRvHg0z/1tVLdOsYFT/vc1UjarI4jQljcdEdMf2Ndr3eQahU9iqw+yEYH3PQGA9
 183b8Ij93cxJ3JrbRJveYZL1/81xZZhrizRsQ7BfFnRlbADRsj
X-Received: by 2002:a05:600c:1388:b0:485:2fd9:3d4a with SMTP id
 5b1f17b1804b1-4855670283cmr276591965e9.22.1773751066586; 
 Tue, 17 Mar 2026 05:37:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1388:b0:485:2fd9:3d4a with SMTP id
 5b1f17b1804b1-4855670283cmr276591365e9.22.1773751066104; 
 Tue, 17 Mar 2026 05:37:46 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d0a8:3481:d976:420:4561?
 (p200300cfd737d0a83481d97604204561.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a8:3481:d976:420:4561])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563f8c23sm206433365e9.1.2026.03.17.05.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 05:37:44 -0700 (PDT)
Message-ID: <80882a7e-2c12-4658-bb3d-cc91d780c808@redhat.com>
Date: Tue, 17 Mar 2026 13:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] block/mirror: fix assertion failure upon duplicate
 complete for job using 'replaces'
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, qemu-stable@nongnu.org
References: <20260311145717.668492-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260311145717.668492-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11.03.26 15:54, Fiona Ebner wrote:
> If s->replace_blocker was already set by an earlier invocation of
> mirror_complete(), then there will be an assertion failure when
> error_setg() is called for it a second time. The bdrv_ref() operation
> should only be done a single time too.
>
> I thought about using an early return with an error, but that might
> break existing users that (accidentally) issue duplicate
> 'job-complete' without using 'replaces'.
>
> A paused job does not accept the 'complete' verb, so using an
> externally throttled node was the best I could come up with for the
> test.
>
> Fiona Ebner (3):
>    block/mirror: fix assertion failure upon duplicate complete for job
>      using 'replaces'

Thanks, I’ve applied this patch 1 to my block branch (for rc0):

https://gitlab.com/hreitz/qemu/-/commits/block

Better to have the code in earlier, and add the test later.

Hanna


