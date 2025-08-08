Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85EC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 15:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPAI-0007dF-EN; Fri, 08 Aug 2025 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukPAH-0007cB-8p
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukPAF-0000Hz-2U
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754667467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHzETSWz0D0KMjFPISG7opCAwgjoN74KNRfYqID/tYc=;
 b=EFI06zRay26VWVn7s5Fz0G0GrevBD/0xMkJtJGa/zC3qW45RE5EbAw7UioC17KwP5H1T9J
 FWlttf89WL+eebYiSYb1nxAMsgbwXWujQWM81xQM98Cc0khCUrU5gyXiTZpUk228VF6EW0
 VUIJBbxG/TKaQ9lzmQg64NVJEd8fmDg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-5s5vvRVxMlqw1kiVpR2CNQ-1; Fri, 08 Aug 2025 11:37:46 -0400
X-MC-Unique: 5s5vvRVxMlqw1kiVpR2CNQ-1
X-Mimecast-MFC-AGG-ID: 5s5vvRVxMlqw1kiVpR2CNQ_1754667466
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-70e5ae5c517so29283397b3.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 08:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754667466; x=1755272266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHzETSWz0D0KMjFPISG7opCAwgjoN74KNRfYqID/tYc=;
 b=bNdl9R0LxOsR8Q4Meb1gfWdHDdL5Nx2vfOTlgWddovcWWcsfUX6fwQ2zHHRP3oHNHk
 tHhzaWCkEtmb/5wNx4n3Q9dBrotk7d+9lx/pASc7Uo+jBAeZP9QXBUUoFMJIBOH5T2cQ
 hQUZJAIV+YkkV6+Cjj9b7+v9uq1XbrMjk8ginMnFzDJoM5B8AKtMfgi70lKDo3R1d8dK
 qUSTvTzzv1Qlika9NxRhfheSflqXCfkPjkPaPqzS17OyINrHAHDOqXnsVMDv8VvQ+nrf
 A3pJ+zrQ0k1kIsxSGoJXsOlxs2cN5q6zrPawCdSO6fIA4CnfgtIIZuFOtSY/yNwWcH34
 8gtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbjt3UJ9EyMKsOrbkde4+BogiNgtEqGehEROwrzQBO3wVCcDWlQa5LFidNxJmJfdgve+yoYl0X+P6X@nongnu.org
X-Gm-Message-State: AOJu0YxPlHVCqhjRZ6Eb01exLqs8jYtKUTMELe8wJaayf03hUGonQmHM
 bEenGGiaLEhOOqAGwzmUUi3ip28mM3qw00TsuczGyZ2tnHcwaBq6hhhM+4uVl4NILlTqdx3o9yg
 II311F6sxwd4RXZMvGM5KyEAnum4nb1HXwyjcHeNvTd9v9CD9S9SV+Gnb
X-Gm-Gg: ASbGncueSRHjanBsh+frzPIq8SZefSIwsmkEcQY29fSVlX5+leF8Gy+iIMfRo6BlcyV
 mgKxz5cOqlAPq3dLY3gnj6FSolM1srCElltt3zturcWh1TR65fL1d14/s39Xz7za/P603AEWXXx
 avQHy2CK3+NLspBqsYg12QGqg8XG+oFklao8QiYqwNDuw2+rk4Y4C4TOlT30a5k2Y76LgOHHCLK
 rE9JpKJ48TpmjKLs8BDKQd6sRm+8xkOGog873nERu9Z8u6srrAoFOGzobiGtnIJLHvp+2bAHvM4
 VGZmNf9GMNLK1I8fF9A+NK0gSnzKOthd
X-Received: by 2002:a05:690c:338f:b0:71a:3f7e:ff0c with SMTP id
 00721157ae682-71bf0e78d8dmr40532547b3.32.1754667465633; 
 Fri, 08 Aug 2025 08:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdbbD2js4XmrV2CL00sulReOkERCWZRURrqtCJhHE4cVOxkHIR1246it2e2M8ywkfvDhrjMw==
X-Received: by 2002:a05:690c:338f:b0:71a:3f7e:ff0c with SMTP id
 00721157ae682-71bf0e78d8dmr40532317b3.32.1754667465250; 
 Fri, 08 Aug 2025 08:37:45 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a5c8fd9sm52474247b3.61.2025.08.08.08.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 08:37:44 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:37:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Yong Huang <yong.huang@smartx.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <aJYZs9NnAOqVMcd1@x1.local>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6sp2a0i.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 08, 2025 at 10:55:25AM -0300, Fabiano Rosas wrote:
> Please work with Lukas to figure out whether yank can be used here. I
> think that's the correct approach. If the main loop is blocked, then
> some out-of-band cancellation routine is needed. migrate_cancel() could
> be it, but at the moment it's not. Yank is the second best thing.

I agree.

migrate_cancel() should really be an OOB command..  It should be a superset
of yank features, plus anything migration speficic besides yanking the
channels, for example, when migration thread is blocked in PRE_SWITCHOVER.

I'll add this into my todo; maybe I can do something with it this release.
I'm happy if anyone would beat me to it.

> 
> The need for a timeout is usually indicative of a design issue. In this
> case, the choice of a coroutine for the incoming side is the obvious
> one. Peter will tell you all about it! =)

Nah. :)

-- 
Peter Xu


