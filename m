Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017CFC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEsA-0003fw-KL; Wed, 12 Feb 2025 10:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiEs7-0003fT-0n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiEs5-0006dq-7b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739374911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbWHNmQdXi+GwA8HKXpggdGwctsO39u61MSPg1rCwmo=;
 b=SDWiSb6zwHUv1CtdGD0bsYKRx8jS3lhSqd7zeZmAVJhlyXD2kphXstpv3pQFiC9oPWJRuT
 +NY6ud3P3oAgmbhQhV6ydCl1BbU/6KR6Dv2C3vCtFisnbffwpPHMEAYVfp2XBRu+6k3zeG
 Xu1lV1SIkt7/Z0kjXooItA6k3WhTa/s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-GyRWbsvFMgu__SPbkxqh8A-1; Wed, 12 Feb 2025 10:41:50 -0500
X-MC-Unique: GyRWbsvFMgu__SPbkxqh8A-1
X-Mimecast-MFC-AGG-ID: GyRWbsvFMgu__SPbkxqh8A_1739374909
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e451554bc2so23615286d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739374909; x=1739979709;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbWHNmQdXi+GwA8HKXpggdGwctsO39u61MSPg1rCwmo=;
 b=vxUicYYZDcRsQKfa56Tj2hi6Qc55UN1cGtqAHm2XEGTfW3kiS2pvbcz50MP6hUxAF/
 MhquG+/v/g3qPq9rFISvnQotUy2bMQWrqqrhctuWyZUUQUkIOxKZKQK1XRwcsGTQNZcI
 4SIUYdM4GDXBiXMv0NYKXEvCE+wBv/PLhVLIX2w77FAEAbbplMF1AjqxMutwwg9AFS08
 T1waYFIy3yeCNvSgKMdePKN0TdXBDlP1lBkp/ffugFY5lZht8eKHsE0PN4MNmmgOqYTv
 bAdMFTjGSDMzBaQqWa7jENIoAgApY+B2OnDGxWSt/uHFFSbhLLbcOW9N6OF9gdGq9nAU
 +tgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa6BA0nRGXjxk6M5GUj+TosQWMV7hUSCxJussDJpL/9bBZIynSWPCoxZmuhaClsv6I3ZXId/sp+tUb@nongnu.org
X-Gm-Message-State: AOJu0YwmHwSMucxP7W2ktT1tDGPQPpNe5TGs/rsUywwnDIX0OtRkIpoJ
 4eEP2FgY7yQJzROcgxPo5pmz4CiNla0vZNCuHLz9UIcu3tmOD/h31a9KwCuXn0NfyffcUaU+Xtk
 BaUi4GKURDNz/zTNqqGhW3n6X4xpYmdy38hF+n2l/N2wWmpYOMaQa
X-Gm-Gg: ASbGncspZIaz9p+IGpOKS/He4zJSH/W6nPi8hRYbKrwhh90XFtxQwfWLT8y/bWqTd6a
 1f3AT8bhwimjz88cxeZcZ0sHuYHeTOiyQhiuMdkKwtE0gxEqE/624oEEGC4WpWyCEM+WfxfNn0/
 9Of9Zy08l1COS+TBFPePxb1N+XqmFazzEWX4aALTjsdkd/7AlGT7S5nIXXV4IwKtczzD+u82wSI
 tq6N6cU9P12bDQgVjmwW9icqmDMbhOs1hWg2jV19vg6yGYmjowEynqqGEo=
X-Received: by 2002:a05:6214:2a4b:b0:6e4:47b0:8b53 with SMTP id
 6a1803df08f44-6e468042edbmr105181786d6.9.1739374909625; 
 Wed, 12 Feb 2025 07:41:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxd/VnZjZXRna5ZK+VyWQYX55tLRBDY2UOp0tCA82jozS9bRT0qXe4vG58zUIptiICiBgJfA==
X-Received: by 2002:a05:6214:2a4b:b0:6e4:47b0:8b53 with SMTP id
 6a1803df08f44-6e468042edbmr105181556d6.9.1739374909341; 
 Wed, 12 Feb 2025 07:41:49 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e44628d1fbsm71389086d6.112.2025.02.12.07.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:41:48 -0800 (PST)
Date: Wed, 12 Feb 2025 10:41:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
Message-ID: <Z6zBOrzRe1J4hmzm@x1.local>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <Z6y-jdFOCVz8mEXo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6y-jdFOCVz8mEXo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 12, 2025 at 03:30:21PM +0000, Daniel P. Berrangé wrote:
> > diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> > index b82a5d3ad9..cd61d69e10 100644
> > --- a/include/system/os-win32.h
> > +++ b/include/system/os-win32.h
> > @@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
> >      return false;
> >  }
> >  
> > -static inline int os_mlock(void)
> > +static inline int os_mlock(bool on_fault)
> >  {
> > +    (void)on_fault;
> 
> Is this really needed ? Our compiler flags don't enable warnings
> about unused variables.
> 
> If they did, this would not be the way to hide them. Instead you
> would use the "G_GNUC_UNUSED" annotation against the parameter.
> eg
> 
>   static inline int os_mlock(bool on_fault G_GNUC_UNUSED)

To be on the safe side..  I'll try to keep the marker if no one disagrees.
So that's:

diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index cd61d69e10..bc623061d8 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -123,9 +123,8 @@ static inline bool is_daemonized(void)
     return false;
 }
 
-static inline int os_mlock(bool on_fault)
+static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
 {
-    (void)on_fault;
     return -ENOSYS;
 }

> 
> >      return -ENOSYS;
> >  }

-- 
Peter Xu


