Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B647CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 21:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz030-0004dr-W6; Wed, 17 Sep 2025 17:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uz02y-0004ck-9F
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 17:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uz02v-0006Ez-D2
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 17:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758145834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaHImPwyLdDGA3ngxd7ArVmKE9Z51PtIB2IgoqJP26E=;
 b=LIQ34B1CPl+lBmu6waqasaWZ3eh+VqAAWl41nzVXU1wv25CMVhS8GA7joErW0RgPrVsafC
 G3PF7D1QxF0PhTWxe0S9SvQe2Sfk8Fcw7FsRVgjTbakSP1bNh8IRT8Unab7CiZKmO15X1T
 tFc5MHgNqHtVhUfuBhUAsIs1132o/B8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-LzgMnjA_PA-VuKsXTmBkhw-1; Wed, 17 Sep 2025 17:50:32 -0400
X-MC-Unique: LzgMnjA_PA-VuKsXTmBkhw-1
X-Mimecast-MFC-AGG-ID: LzgMnjA_PA-VuKsXTmBkhw_1758145832
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78efb3e2738so4645976d6.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 14:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758145832; x=1758750632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaHImPwyLdDGA3ngxd7ArVmKE9Z51PtIB2IgoqJP26E=;
 b=XoXvWhmyHTm3SOskp5htfjX3bu35o+P10gMi+ypPacNWAtfVXgZX1JSLJsjIrw4d0X
 GmRFnD4yWgnQwf1ZceMGnJIexIll7dy1J/SX5y0gQvbI7IFfbBx8H3s+jguXFjhE2OWC
 1XZYNGdwngWoiguYat41pbGTMtI11cyzR6s8b07yGCJfO7EgnIiWwtKVLc/iLKUtKk+8
 FRkj85zLuXwz8b97/X6MDjXHwIkMWiNNsBw5H9gjiqWztF9WvXn2H1bxg6Y94p6gM1Qe
 YYjq7JdT+xpFPE8XEzqQhHPwoSWUwU+MDXrtPC1Fx3wZr2PRo02Pvx4muE6aaWucKDyI
 YvNw==
X-Gm-Message-State: AOJu0YxxOFoQ4EKxQyhPOBFq8rgy4Li6hqJMKAjxiL1kQqFyoIJ0MTzi
 XPJ9qcLEohqa9rpC4JGeny58qEt/3OR0JY29Bor7X1qu/ty+ojyixpGD5NE7YFsPEWs9ab9Umlw
 zmIutEv9Lb1XOcoqTC8LgEpKI8NVwtLJzJIAL+4xcjVYlwFr2oN7gRCvu
X-Gm-Gg: ASbGncvieBtfOP3+StQcyK9fLqnmtyTc5sJun2XcahSbsPic6Tvf3SgQyP1gafA4v9C
 8KcGwkK02HnQlTefrpfzdNQmitOhYgvpdIQHNgXlTYGLJdXG+xcDo4uxsEU0WOmlBlUfdhZtOKc
 wn9YCur4kRLvF8LtU+ZLHSYhEALSv+rrNtqNtknnEePZq5YdRfMG3wb531AG0o0Pkgt2Vs2mLEz
 +6Lxd3lVGfbwzXA90x2Bhfdw3fE8aq39RhWvuOi/fRJwcdgxrbnIoLq8UG5jPPAaY5+s9zk61hi
 zSVXQrJgHs0KtT3aNhTgQ/BrsoIpQ2XlAiB7QOuAkacXqhfGlbrPXpDrPrvcUkqx3Mt109c5y2f
 5mSIwyQHAGlU7zJUBQn32Tw==
X-Received: by 2002:ad4:4e30:0:b0:78f:6005:35ba with SMTP id
 6a1803df08f44-78f60053751mr24446216d6.34.1758145831923; 
 Wed, 17 Sep 2025 14:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHks5dZzHyKeedzT+lY7lH6YLlUcqyI+OBeJ2tonYAvWLfbJ0MviJgw05wkpipShJAHdelNuw==
X-Received: by 2002:ad4:4e30:0:b0:78f:6005:35ba with SMTP id
 6a1803df08f44-78f60053751mr24445946d6.34.1758145831515; 
 Wed, 17 Sep 2025 14:50:31 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-79351b9e6e6sm2359216d6.34.2025.09.17.14.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 14:50:30 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:50:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] migration/tls: Graceful shutdowns for main and
 postcopy channels
Message-ID: <aMstJdBDMR8S2S9-@x1.local>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <aMLK5nT4CVPrcZCB@x1.local> <87tt10vlvb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tt10vlvb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Sep 17, 2025 at 05:56:40PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Sep 10, 2025 at 12:01:41PM -0400, Peter Xu wrote:
> >> Fabiano fixed graceful shutdowns for multifd channels previously:
> >> 
> >> https://lore.kernel.org/qemu-devel/20250206175824.22664-1-farosas@suse.de/
> >> 
> >> However we likely forgot the rest channels.  Do it the same for the main
> >> and postcopy channels.  This fixes a warning message when running unit test
> >> /ARCH/migration/postcopy/preempt/tls/psk.
> >> 
> >> Thanks,
> >> 
> >> Peter Xu (3):
> >>   migration/tls: Gracefully shutdown main and preempt channels
> >>   migration: Make migration_has_failed() work even for CANCELLING
> >>   migration/multifd: Use the new graceful termination helper
> >
> > Please hold off the review on this one.  Juraj reported the issue wasn't
> > resolved by the changes, and I can also reproduce.  I'll have a look and
> > repost..
> 
> I'm wondering if the assumption that only succeeded migrations should
> gracefully exit is correct. My understanding is that we need to always
> exit gracefully, but after failure, the channel might not be there, so
> we ignore failures. But that does not seem to mean a failed migration
> can simply not exit gracefully.

Currently tls channels will ignore premature terminations whenever there's
a shutdown() on READ.  So when failed / cancelled and whenever there's a
shutdown(), iochannel already does the bypass no matter what migration does.

Or do you mean we should remove that, and still try to do graceful
shutdowns even if the channel was shutdown()?

Feel free to have a look at v2 of this series, especially patch 1. v3 will
come soon, but just to say, v2 is hugely different from v1, and should be
fairly close to upcoming v3, at least on patch 1 which is the real fix.

I should have mentioned that earlier.. :(

-- 
Peter Xu


