Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DBDD4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSYS-0001Sv-Vb; Thu, 15 Jan 2026 13:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgSYD-0000wZ-H4
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgSYB-0006a7-Rv
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768503510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSaWkiEldx16GFFC1s9mqelmr/R2HTRT2+Buu/tOcCU=;
 b=hrm3SnhWUORdFLf8v+4BE4FO/9rWeLrbnzkcx8rmPV6Q+14rQImyckk602P65DlAAndUSN
 p9IA9XB4/jFK0tGbefH4wRgSw1rtFySM+vSKESq2p9GzLsFKO3Q+5N73cyg4fchG5Cyv5Q
 41zFAkSOfmO0rbiRHtq94hBL9Pstopw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-PzW3wbYvODS167qxMFoNGQ-1; Thu, 15 Jan 2026 13:58:28 -0500
X-MC-Unique: PzW3wbYvODS167qxMFoNGQ-1
X-Mimecast-MFC-AGG-ID: PzW3wbYvODS167qxMFoNGQ_1768503508
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5014d56a63aso35335891cf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768503508; x=1769108308; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hSaWkiEldx16GFFC1s9mqelmr/R2HTRT2+Buu/tOcCU=;
 b=ArXVvQOsWQswUiGyYdfmofPwtRJRT6jJASRlyAVDSGD90rac9HnHxf+fzwzkVVmHFH
 h28nb3amGyCZZiJtAlqjW9teL+OZhGv+P9BALtr3++nba7O4rDT2MwaEMxzk8v0fXDt0
 u3GunZ8eXQk+INsbq1+5myi2atzFXxSjk5GRAzXs6mJWdYoKmIy4buBkCMIjS8XxAQaT
 caGMpL5X1te7ckyok1g64m1+G4DbtHouUdBsvpWuuP0l9DK6EfYR9Ob8Yh4e9xKaJSv2
 L/RYDGsmo2F2FjJ8dNQUawfWfGKhJqsfSipuTZ+bwltMkJ5MCKih61fELrwfIEXU/6jW
 3ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503508; x=1769108308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSaWkiEldx16GFFC1s9mqelmr/R2HTRT2+Buu/tOcCU=;
 b=mWzM4BbErnws5HzcX4UP25TF2zlBPpguYhZy5X8c7bQHFTXGyHPHEpxvfH/WYAHsbg
 2lhz3TykfV7tsUXsIiembf9gEJ+6/kS7JwIQAhMUmwqIHypt8siKggXbc01IglHaRdxT
 kr7lYl+AvVsn+Ar7E2dYoimj0Vxaq/UPLsmopg3hLhcngC6OWQzmglKhRb6px8K1JmiW
 SKdpwSIITJeZib92tXRDGDqEf464FVXGGFNWkrYIgW1Vh2qstv+ZzJ5+Wwh7qptqDQWF
 malRrNfScz+ftdqymuq88HNjGnizsen1e3dicxBohMql9/j4oL25TngB1cOLIM1cm3mu
 IT/Q==
X-Gm-Message-State: AOJu0Yzi/fSiYDoY65QEj02QySCdYOn2sxzwOwZI9wudYDAP0Mc6WH/R
 zqBItD1vwBlSdiH6Y1S5h+uHb7IyEaog+tyeVsFoSd+3cZcglhSh8ssAzN0yRfpf4DK4HkCl//m
 LrDdW6xGngdor2pzPzsB3ZTl9Kluiv/INLXNDbVYPpl5i+xXKcg69t457
X-Gm-Gg: AY/fxX4aexvXqZZXUjpsCj8EwrSsmdXKimE5uT3TbFHin73XwkOpMOmWxMy09SBc1Ha
 XBqPm/js2hEj83lIM4slPkL3/6NlqqozoO+ChMf/2813afRyG9Qstm9hcjYTHqY3SB/OOsd8sMY
 A+Au9vB3HIyn9J34+dDCA1YLOKq8YfKtqAmHax5upQuRLxCFBEkJvG2W2joN+j8LRiejBfK/Kr8
 rKyyGfsd4ceAf1UrNhvnyHxNvZhGtP0/q4hz8jCdQudwZ/j5M/2v+mvFNt5iZoVimqZWSJ1SVGG
 sRUbjC2VzFNkIl04Oy2n/fe9v9CzLR2Yp0Pznx+eGlPGe9BKWQsbmgcr87HRJaZR3FBHthPLtE2
 z38Q=
X-Received: by 2002:ac8:424c:0:b0:502:a235:e1a1 with SMTP id
 d75a77b69052e-502a235e424mr1884081cf.10.1768503508238; 
 Thu, 15 Jan 2026 10:58:28 -0800 (PST)
X-Received: by 2002:ac8:424c:0:b0:502:a235:e1a1 with SMTP id
 d75a77b69052e-502a235e424mr1883891cf.10.1768503507851; 
 Thu, 15 Jan 2026 10:58:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ed3155sm2010011cf.19.2026.01.15.10.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:58:27 -0800 (PST)
Date: Thu, 15 Jan 2026 13:58:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] migration: deprecations and removals for 11.0
Message-ID: <aWk4zklo0pV_Folu@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <87wm1jxv4n.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm1jxv4n.fsf@pond.sub.org>
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

On Thu, Jan 15, 2026 at 07:11:52AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This series removes two deprecated features and formally propose
> > deprecation of COLO framework for 11.0.
> >
> > Please review, thanks.
> 
> As far as I can tell, this together with
> 
>     [PATCH 0/2] migration: Drop deprecated QMP stuff
>     Message-ID: <20260108125512.2234147-1-armbru@redhat.com>
>     https://lore.kernel.org/qemu-devel/20260108125512.2234147-1-armbru@redhat.com/
> 
> buries all the deprecated migration interfaces.

Yes.  This series was definitely inspired by that one, thanks for doing it
(and the fast reviews)!

> Opportunity to deprecate some more ;)

Let's see if we can remove COLO first. I would treat COLO as five features
in a wholesale package.. :)

-- 
Peter Xu


