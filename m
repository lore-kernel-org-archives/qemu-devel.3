Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42167D711C4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWM66-0006oa-M4; Thu, 18 Dec 2025 17:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWM64-0006o2-9O
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWM62-0001Sv-Ov
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766095421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mlBox8IuDr5wav2EzFGOfzbtzLHQ3gh6uUinaZXGXe4=;
 b=ZS3fvplDmx+IR7QfTbNVHvodStgH8rL9XJBQFiCuv1aKFDyuNodR5UGkVbsmCrHhP70ynD
 Evj2V64mmkJDJOKXjQhUB4lbvCB0XJP3Q8jlq63AOs7w5GcSUP6Nwo0jk8ayosFh8A5430
 jmTp16I+tZ4gNhX9pAjBW2rUFGiso6s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-PsZErdipOJK2atThciN5Iw-1; Thu, 18 Dec 2025 17:03:14 -0500
X-MC-Unique: PsZErdipOJK2atThciN5Iw-1
X-Mimecast-MFC-AGG-ID: PsZErdipOJK2atThciN5Iw_1766095393
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8ba026720eeso272709885a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766095393; x=1766700193; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mlBox8IuDr5wav2EzFGOfzbtzLHQ3gh6uUinaZXGXe4=;
 b=ehPaQziCrcisTvvX7i3Q7r8sjjrimmVqHfDqlvS9PyrlmKCh8/R8EhQHpYOl0BKQIQ
 b/dDIuFh+EumUhElfNZGS89Ps+Os1XeH/z9RJW0lyo8ao1MsGNHb0Nmkyu8WiO54C8MM
 nsjbu+y1igjSHhhmkMLY+cbpHcS69usBa75irluy8JQiqsOM+UPV4T9zqqev9vlI5pm2
 /y8e45+5sXIlLL53D90Ohp2Pak3ppMyBwbMVli191KfZw70/hIsYKpjGrEhPwRUEVRDU
 rY5zXmIjbhKMncBj8naAB2W012J5QyXE9ns0Ge/WnJE1i3fR1Z2y0yTT+VnSbw6AebeA
 exdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766095393; x=1766700193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlBox8IuDr5wav2EzFGOfzbtzLHQ3gh6uUinaZXGXe4=;
 b=ZTYk+IhLkYRsPLGGEtIyUUzA6iNUQXjJVgV9Z181exjHLMM5E8a7KRhYXycdvF57l7
 Kp6f4ID1scZhf0ELHxjy1F8A9vFgtnGSvQteMahgNJZGRiF5igK7mr78OPEEVXS1mULf
 6QXyFPWmXCsWv2vPsCdPiJ5SnmD+HsCAsUGR+L5m2Tnm6YRshbFyhg8lCNLLQcPS/3xf
 aYBnDHz6/qd2ndHUBmW8DM1kG6iPNzUg9EcUeWwwmHw+FXyRGaPbwUVcIT+VOzrXUkjH
 p+jnFpnjKY/sniEixDsAPUGp0Sa73QDczh0S6/erhQTj8SWLNTwV8ZkNFc6afbiPjQA8
 a9Sw==
X-Gm-Message-State: AOJu0Yz0dxB/eDPoXVLck8hxWpu9zTYo3oGPG5FReCN8vCqdiIHwoL5c
 ayGmGIzk/w1dkzWM/LBPJsOun10KdkXKuf9f7p1l2Pu7LyjCduuEj+Q5iFyHYZAoASLBYe9BT1k
 TiJmNjgHFVxBf8hxNJCF3B58n+REb3E2AgBNwEkZSkzjPRG9lIL9hcsBB
X-Gm-Gg: AY/fxX4aGJS/iprE3Kq5l60G944qiJFzULQpoQj9EK07KZaCJ6Vzes4fgIkRr2xjTT0
 J/XpPgGaRpO10KN0QSIUdNudS4onyVk9EgLfw9Kq3Xo6zKskGvf4pGxZP86RuRSR+SG7aZURaZA
 Zeh/Q78yg1shy7KR3Odu7DH1gmV71DC8wbhT26L3+t9DuU6P8Nq5/hwimo35x6k/w59sT7No8RK
 vHQUpIQekbm42OhrhJ0SDCzZbGQTTc302ggKND8sal5D2Hmm8dE+eQuCCwMK918JLQr0hvj0WG2
 MZoBlI4jsvc1yJybsoFnac7sgCM4DFykMvs2/2ePlbExu++chZoEOeqjj2tjnsG2QauZHnpduZL
 R0WQ=
X-Received: by 2002:a05:620a:4052:b0:84d:c10c:e42b with SMTP id
 af79cd13be357-8c08fc011f7mr168100085a.17.1766095393278; 
 Thu, 18 Dec 2025 14:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0rHM7V8rETFxG4T0X88XehAqVo/O4lV/cE+d66sNd2ao2OICVLsr4U4BQfKNw4ekEiEMwXw==
X-Received: by 2002:a05:620a:4052:b0:84d:c10c:e42b with SMTP id
 af79cd13be357-8c08fc011f7mr168093885a.17.1766095392614; 
 Thu, 18 Dec 2025 14:03:12 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997aef2esm5037796d6.32.2025.12.18.14.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 14:03:12 -0800 (PST)
Date: Thu, 18 Dec 2025 17:03:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 43/51] tests/qtest/migration: Convert postcopy tests
 to use config
Message-ID: <aUR6H-ZQu3Jb8IOP@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-44-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-44-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 07:00:29PM -0300, Fabiano Rosas wrote:
> Make the postcopy tests (including TLS) pass a config argument to
> migration QMP commands.
> 
> Temporarily, set the use-config key to enable the new method.

Maybe worth mention in the commit message that the two set-parameters in
migrate_hook_start_tls_psk_common() will still be kept for now for
non-postcopy tls tests.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


