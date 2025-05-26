Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6C0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZ7t-0007Sq-F4; Mon, 26 May 2025 10:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZ7j-0007Po-IM
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZ7f-0001gr-97
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748270893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDaGnJQzmm5IH/fd1G97Fb9TeD5PnGoFR4Dv1ckxPRM=;
 b=dbpguObPbNS0NuxolnJr5W4/5YMBtuT2rqthwOwDag1H78WCE6O8ZNvlckjhICyfIdKNpk
 La1rGmm0vEUbqUzkgLcQOsDnKHzcLu4rgnrWKdWuvBSPC/vCR+TKjPntmM0w0TXNhkeYdB
 mSnvKLNhOvOpzOQDLF98PzcuMcRcx3k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Y9wifRNyNdqA_ttXovYXxA-1; Mon, 26 May 2025 10:48:12 -0400
X-MC-Unique: Y9wifRNyNdqA_ttXovYXxA-1
X-Mimecast-MFC-AGG-ID: Y9wifRNyNdqA_ttXovYXxA_1748270892
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5e2872e57so481762185a.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748270892; x=1748875692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDaGnJQzmm5IH/fd1G97Fb9TeD5PnGoFR4Dv1ckxPRM=;
 b=uNphwAs0oUJM3TOwcNKxGAPsfzTND1HV+mnUe+DsbDrgtwgve/r/NSTgUA0VwYb3Kr
 1g8O4vgDV0sI15oJY0ngAuCmPO2wHZQl2BCNVk2rYa8pPJiz1KMgoi1DfWjivCndLirI
 vfxm3so1L8QbWsibszVieAw+8BpZTnN2OB9DIaifb2lM0wDkxSnsVZLunFNOudChpKDd
 bYSOqlvEfgRTb6j85ypNZGBNrLRM8QA6RmUzUWU/SwvKFAizQAslmwJim/jKc07qPHJU
 Yj+SR5iVzBLAKnizjxlxK8jBwBKi2t3eqcFVXoMUWK2wdQWHaeMVPAR8hx66MNEKdFEK
 R8jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBK3fAif6bieReBvSuh/7B5GnGcgJ1vSHJea8Dq9tlzrVFOkKH12ew3WUZpcoBiNSVxZ/6kFeZENSk@nongnu.org
X-Gm-Message-State: AOJu0YzbcCzAeCnJnT1JFd2+DAbEV/l9fhE2uD63RGMG06p5W3Qn2hPO
 CtD8PVwktJGGVfme2Ysc6k25hm0DbCOud3VmshKzwpxs4Y0mRRPdRvoUJe2CeDQnkm2TwwaKaCe
 omt7mXghfOcnmltqlbQiqhM1++2f5hN/mL2Q0NpjM+XliPRf2FWe/pbNP
X-Gm-Gg: ASbGncuEQoIXAGbKZ6CxlvIMd/XF+0sPyswyljVVsjbf4ZnOhKLzkPj3YLk/j1lpVBY
 GhlQ9IBoPzfbzzc/TLb8s6yDSdvqGeqNxJA9Xtu3KUCed6zzWg3okSX7ud9VYc9Y2aF4bTHJhhc
 JlgD2HF6rJc89S0VgA2sbePstqzAQhYfmPydJgW4EsUax+xAof9dG5CPZCkCUIMyQmpcdgtTNe0
 WIohvHRFGu/UFqCn+do0gA/su+LbQdCDZjD5Gp6FY6zE46zjFiSyN4HKZATn1HK6br/fgJ2/F1/
 JXs=
X-Received: by 2002:a05:620a:1916:b0:7c8:4634:51d3 with SMTP id
 af79cd13be357-7ceecc90411mr1476206785a.55.1748270891813; 
 Mon, 26 May 2025 07:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZo2a/8xKJs3sTKqO0RgVal+G6vBrYugaJ2N455lFEQ4mlSXMUYrQuBMmtho8J9BEO5yB8Q==
X-Received: by 2002:a05:620a:1916:b0:7c8:4634:51d3 with SMTP id
 af79cd13be357-7ceecc90411mr1476202985a.55.1748270891370; 
 Mon, 26 May 2025 07:48:11 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bcc19sm1581645885a.3.2025.05.26.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:48:10 -0700 (PDT)
Date: Mon, 26 May 2025 10:48:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve futex usage
Message-ID: <aDR_J5iYsSlBTDJm@x1.local>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

On Mon, May 26, 2025 at 02:29:10PM +0900, Akihiko Odaki wrote:
> Akihiko Odaki (11):
>       futex: Check value after qemu_futex_wait()
>       futex: Support Windows
>       qemu-thread: Remove qatomic_read() in qemu_event_set()
>       qemu-thread: Replace __linux__ with CONFIG_LINUX
>       qemu-thread: Avoid futex abstraction for non-Linux
>       qemu-thread: Use futex for QemuEvent on Windows
>       qemu-thread: Use futex if available for QemuLockCnt
>       migration: Replace QemuSemaphore with QemuEvent
>       migration/colo: Replace QemuSemaphore with QemuEvent
>       migration/postcopy: Replace QemuSemaphore with QemuEvent

In case it makes things easier.. I queued the three migration patches;
AFAIU they look like standalone to go even without prior patches, meanwhile
it shouldn't be an issue if they're queued in two pulls.

I am still not sure whether patch 1 is needed at all, but I'll leave that
to others to decide.

Thanks!

>       hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent

-- 
Peter Xu


