Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9154C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkVk1-0007a0-1v; Tue, 18 Feb 2025 17:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkVjz-0007Zs-Qk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkVjx-0008Sc-ON
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739916412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhGTagA8Bni0qxTNoasDGULEzESbL2KSfpwSU2W1+T0=;
 b=RoCo+9XSSp5MgKgBl3Mw7USvLqdRX9U1WczyAZyATW2m/XtB5eODPUxdIlTKfoPjPOeei1
 m/sz5psNrMF2uzxeNP0cYW3LVP971xQH8gK3n16BEbcPF8l0pJmonIq1gM1LAF3DYBItFf
 65p3P0AxBlVRLXYEySWQXv94ZK83HiE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-pHjaLwwMMQm4CQ0Dgm1Ceg-1; Tue, 18 Feb 2025 17:06:47 -0500
X-MC-Unique: pHjaLwwMMQm4CQ0Dgm1Ceg-1
X-Mimecast-MFC-AGG-ID: pHjaLwwMMQm4CQ0Dgm1Ceg_1739916407
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-47207b66f3eso10497801cf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739916407; x=1740521207;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhGTagA8Bni0qxTNoasDGULEzESbL2KSfpwSU2W1+T0=;
 b=SPKgxNeeszHzMJ2CtZR767OsePmk0GnqLGEVRVrvrYYCUtSI1CmU/u3q008TyrR3nT
 uFNp5fPT1crGndyEMsZGJsZXNiv2wmvLLVhijYTxL/kpTulxbQddW2W8/AV1MOdCkWfx
 2D065yx8Qs+fvXWkA4+hlpoe814iY6tGz5mGecnk2nyS1FXJFWov0lf3tWGPQyTCO9fC
 cRvC9IMd4RcDNDWDJ6d/abtXzDfS+lNsfVynmetLM4A/8rYfimiQ0UU5zngvTi6SQtua
 AIOFNqcee1LK0rW2vTBWsYim70+5+BQns7zzY5gW9PDL8FSrk5sqlf1EySedjCeqt2pd
 xj8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUORzCkchxphHrBJ/i6CoZH1kI1O4Hh2HDBTqPBjnDay+UalhqqGOqfzH7wB39d7DOFpNgfXb5sO5zg@nongnu.org
X-Gm-Message-State: AOJu0YwQ4z129P956L1xv9wLw/Pb/C84QFWszfVX3Plt5GbsWa0U4Ni1
 Libbr9nPoM1uIVEUeY0E+XAkEYYun+AJSuZphlfc8AnrXrlHJKaNJ1/fy004gR8OW/isOgHkfiN
 czxSshrcprfiWQC5ec3Z16w1c2KG1Svd4TePPCCvNmtVxTCG1h0WM
X-Gm-Gg: ASbGncuT9FpU/1muk+vqPKupRKHqx9/JdXrtDfyuyI52eycD6kIn4UnOVDrBzxvZAfo
 YfDypPvl54zoNew+LezidsABty3SNukO7flMYC8On3oYNCKX2sIpo0I5bkPxpAZmOWgipovk9Ki
 BRqwBohGvT6wD1GCuAkWhA+f5HXz657MYzpwGdotWBe8VcFgMsfgzlSWcjIrB+v9XefxKEM2AmI
 H6xpG+GfPx2mrgMJTMk4kZECBW/h++a6VJOMpzgs+pCmAVaoEB2vWyZ4QQ=
X-Received: by 2002:a05:6214:27e2:b0:6e6:684f:7f6f with SMTP id
 6a1803df08f44-6e66cc7fe37mr223604936d6.7.1739916407278; 
 Tue, 18 Feb 2025 14:06:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd5t5ZzPMGn+mWbgT6EQaCEhUPDINLeQlySHTs4HSHEJdkgiYc9f5AHjrgrG482rD5Q56FPg==
X-Received: by 2002:a05:6214:27e2:b0:6e6:684f:7f6f with SMTP id
 6a1803df08f44-6e66cc7fe37mr223604686d6.7.1739916406944; 
 Tue, 18 Feb 2025 14:06:46 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65daff4a8sm68121406d6.97.2025.02.18.14.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 14:06:46 -0800 (PST)
Date: Tue, 18 Feb 2025 17:06:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL v2 11/14] os: add an ability to lock memory on_fault
Message-ID: <Z7UEdN0ogdi4u4rC@x1.local>
References: <20250212173823.214429-1-peterx@redhat.com>
 <20250212173823.214429-3-peterx@redhat.com>
 <Z6ze_muL8OkkuAFr@redhat.com> <Z6zg3jr4IUiIdHKG@x1.local>
 <Z6zicnbD1RRYfC3R@redhat.com> <Z60TvzQZQW3j4tiY@x1.local>
 <Z7S3D_JYdayPhVVd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7S3D_JYdayPhVVd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Feb 18, 2025 at 04:36:31PM +0000, Daniel P. Berrangé wrote:
> Yes, or actually turn on the warning about unused params and mark
> the rest. It is initially noisey, but IME does end up flagging
> real problems periodically. Anyway, given we're inconsistent already
> there's no need to respin this series.

Thanks, Dan.

Stefan, I hope this PR can still be picked up.  If I need a repost, please
let me know!

-- 
Peter Xu


