Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09917E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlvl-0000pS-Fk; Thu, 12 Dec 2024 11:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLlvi-0000h6-E6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLlvg-00074w-HE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734020443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkvnkppCx6tbbC8aHRrLgMvt6jfBJeBX+Th/KxtTygY=;
 b=VYMk/dyrjvNwWBGsUw2nJMLPGl+Sp3nYh80Zs2Uw1GzO5xP4dTqLUFlyipqfUYVqR3xkmv
 SWMcMfAfs5nf8xgGOwbuP7algIpDXTnBX19aAza4GGutvQEgfoe+gzvcjyX1k7rrR2Mc4b
 alldeGv6q1fk9K3HCJ/Y2ANMHiL6KnU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-2NMtalV9Pt-KNfHYU6n7ng-1; Thu, 12 Dec 2024 11:20:42 -0500
X-MC-Unique: 2NMtalV9Pt-KNfHYU6n7ng-1
X-Mimecast-MFC-AGG-ID: 2NMtalV9Pt-KNfHYU6n7ng
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e1b036e9so79819985a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734020442; x=1734625242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkvnkppCx6tbbC8aHRrLgMvt6jfBJeBX+Th/KxtTygY=;
 b=elP1RMMHG1Sh/cy8jlmUKY0mMUNvZ8b7wEDJmYaXhKjKb1tYJwsemZm1kKAF4sJHK4
 89FWgZrR1WBti9+eO4/pRISKYUCWQDk2CzdnK0p0LZljBaTh7QHYD06qn4Lmx/ESkh9Q
 4oj8BcF7YuyIP6FLmJGfV3DsPov1ZtkOguT57yk3Y3YNNXG4UsrbBORwyRafESYFBk08
 SnCKKEeerBCMYxeZqyJaOq3mQJHZC4MgbCoGjFx4Zl3za+ELpoTaGgy7EXEcWM5xV4zi
 0he3EScO+ju0guvabNe4gT6l3x3Cb6kqaacoicubwpcZxiSykQbEZ9lSkDtQk6kgO+Y5
 KVCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJRMMq02xQk4HRebDhlaHUhECnPcsBHmPpIUWibdMj67N3sHSifx9I/YK7rh8a+pZ6q1WCtyXlKmRR@nongnu.org
X-Gm-Message-State: AOJu0YyAlZz2iUIV6sxd3t5fWA141UI8EL08/dnA1pdALziGw8Wipe9L
 SMNM/ru63MTFupwqtGJvbC6ZYg0GBeXCLqhAcC/faP63tb1o7FbX+x6Aj4bn3uDQV3j2WMdo9Fb
 ZrzAZ35XDyhlrghFtZ+aRWv16T8mBuuo1OxN38SmyM4kofJPGIomq
X-Gm-Gg: ASbGncv6pcqOr+/+b7rzRfjYLqzQVFw7LUPouI+iSC4wru7kMaVzvJm79IUDRjg+RpP
 i58fi/V3bfF6/15PujCZTznkVgAZJkPzzG1OiOb/r5tr14G2imsun+dOQNFVa/OMJ/nT//FUJ3/
 SIIiB6tkiNkS1geEfFiJGC42Nw0TYQG741hQN7IMXgYYeVI5FZTtBnZ8KZfjwGNUkw2bBhgxyJ8
 QSs7/yb1KtcO3OAhFCnkUb6sRKlHbmt6KBwnmqQp1kpT4UAKFEVbx3P5vMTiYByEE2cLxKkyirT
 Is6IbMxB2PwVbPqbcg==
X-Received: by 2002:a05:622a:6:b0:467:1e96:645f with SMTP id
 d75a77b69052e-467a14d1987mr12870291cf.6.1734020441673; 
 Thu, 12 Dec 2024 08:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHOQ0qsybdJNkpM6Qj05KTEuBtmgSvjT/NeIpd9d+2HynWTQmLZ6V0ynnujKvA5WID3haIEA==
X-Received: by 2002:a05:622a:6:b0:467:1e96:645f with SMTP id
 d75a77b69052e-467a14d1987mr12870061cf.6.1734020441419; 
 Thu, 12 Dec 2024 08:20:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467923f5caasm15199581cf.48.2024.12.12.08.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:20:40 -0800 (PST)
Date: Thu, 12 Dec 2024 11:20:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/4] overcommit: introduce mem-lock=on-fault
Message-ID: <Z1sNV-kHCJw9S9Di@x1n>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
 <20241211230433.1371327-5-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211230433.1371327-5-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 02:04:33AM +0300, Daniil Tatianin wrote:
> Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
> anonymous memory with a write-fault, which introduces a lot of extra
> overhead in terms of memory usage when all you want to do is to prevent
> kcompactd from migrating and compacting QEMU pages. Add an option to
> only lock pages lazily as they're faulted by the process by using
> MCL_ONFAULT if asked.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


