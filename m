Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CFBCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYW-0006Me-D1; Wed, 20 May 2026 14:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPlXw-0006AD-ED
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPlXq-0000CT-0x
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779301282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1AkXX33gPSH3AD5hiuD37VRAgcbfPProm/qe0uIHneM=;
 b=OCm5hepCsrqn+X6zCguu6nuuJa/2HTIbp1TYvqPG6v4MOAWvzsVUYGdrOoWRqg5tjH45fd
 pAvyYMNmlloXa7N/4Yew2/uSgBojvcrMOeummP+3q/VBWPN1dhHPRoS3l7m6UWnWAs/AAw
 OL91NgkbTk4o+m90T05lunF533MEoeU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-tXEUK8EcM0KoS5XM34R_NA-1; Wed, 20 May 2026 14:21:21 -0400
X-MC-Unique: tXEUK8EcM0KoS5XM34R_NA-1
X-Mimecast-MFC-AGG-ID: tXEUK8EcM0KoS5XM34R_NA_1779301281
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ca1295e3a9so69438736d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779301281; x=1779906081; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1AkXX33gPSH3AD5hiuD37VRAgcbfPProm/qe0uIHneM=;
 b=XH47MXsucZ+za+ERsq91S5Tr34WiLvbRl3IOF2dK/wCIZDUQ13R83tkCmtrbwjSjFN
 TZ9zPN3t/UaRPI/TZoCOdxBy2Jt9NTX+9s40WvoD5CpqM15376Ryy5JbgOCXTRY2DQZ1
 MZckfInCdLX5hz4jq0CNrydV3g2mJyTTZBsL5ghm5cGSZE8d+H4dGfmxrB5ly4lpR4x5
 VHp/8uLedogFJPAUP2miXrLeWva2TFkeRGEign52r+dqt25stoMaueYb1QBgEDULwRmC
 22ueIEyKY2LQGUM4DxIpkt7OLm1Wc84YNNYVBVTy+PIHK9eTgSSLeRIDVTMKxfPFSKQB
 TruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301281; x=1779906081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AkXX33gPSH3AD5hiuD37VRAgcbfPProm/qe0uIHneM=;
 b=VC1VWgvTW07F2o1h//nCvNt0ErKhMWtRdgpHRqc1+u6YIOnGVfAhiw49+EPE1j1V7H
 QCMTxuHp/74QwrOKw62+++FiuPHTtLG7gdIyv0CBsPUCwSPKhJBsC0BirjmFc/iNUMvc
 coXjOL0fKINID5gGr8R8Ej9qtirWO4N6ubf6XT7/L89RGYjYJxDk7NoBu3GflqyTu6k9
 83rhclngo4mJMiwZShM65fwE/YR7LH3UHJeRycbrhRqiVeWlqF9gm2dK2e8RpSOcmyz4
 JT1hW7cE053ph7wcaZU4cnR3XK1cj5TVmciXdLZ2H84dD+b7oZXWg/pJ6qGJYFUme0sL
 VQqQ==
X-Gm-Message-State: AOJu0YwlRIQfZKqjY1gTaRkCW+GaBhpRUjkN0j27cgj1A5vfWAUPLX7d
 s5JdJBOGR/qtc+qziE3FOKEmXQkefqpYiMAHIh5iUoFXp43zjKCFUDklAEJbohNy5f6lx75pzXM
 TRtj0iUiympraiQOtzFJMPIgENaz1mQFRP2uyHWolOZDrCr9QUllwEqK2
X-Gm-Gg: Acq92OHy1HVmm9koto7Zluo+2yA9c6l5miKnKwaf3dviWPR/breyFbk8sPFUfwjK3yK
 xOLnbhqnTwiB/icW6BFSXgfoVk57h5DC0T/K5booZ8EFjF2EvZQmummylycFW6z/q2eVzlJ79LA
 yT9mpHhJj4eT922UtGwCkaNuMOL3Q6HwCHNG6ATRTF824Now1GU72HT0rUTjsOsr8d56CwGmUKy
 ig2T87mnZhcwKSkDfirEL4t+d+D41E/90eIAhUbUli1lNW8gAim/CIc9hont96HE/ZrssnTujRR
 UddH2y4ortdScG0v8s9lo3u20+bi5DhgcvNpRvEPOGEtm8QrEUuNhbi2SjczNJidgK4IsRiHSbi
 0i96FXgnkCDMmd4gNHxt8UooL9MXilAEO9dYwN6svtaUJbKI=
X-Received: by 2002:a05:6214:4ec3:b0:8ca:f1c:6493 with SMTP id
 6a1803df08f44-8ca0f631cb4mr383102886d6.1.1779301280436; 
 Wed, 20 May 2026 11:21:20 -0700 (PDT)
X-Received: by 2002:a05:6214:4ec3:b0:8ca:f1c:6493 with SMTP id
 6a1803df08f44-8ca0f631cb4mr383102426d6.1.1779301279980; 
 Wed, 20 May 2026 11:21:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cbf144a6a1sm29847996d6.49.2026.05.20.11.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:21:19 -0700 (PDT)
Date: Wed, 20 May 2026 14:21:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v1 14/15] tests/qtest/migration: Stop passing URI into
 migrate_start
Message-ID: <ag37nRX4X_wVBV7M@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:13PM -0300, Fabiano Rosas wrote:
> Don't allow changing the default -incoming URI via migrate_start. The
> default is now -incoming defer. If a test really needs to alter this
> (such as with CPR), the target_opts variable is still available to
> change the command line.
> 
> (aside from the larger goal of using defer, this change is a step
> towards allowing migrate_start() to be invoked only once for all
> tests)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


