Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336C610F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EbV-0001gE-04; Fri, 27 Mar 2026 17:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w6EbT-0001g6-Qb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w6EbS-0001Oh-2t
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hOLSKYh5G+WWJsgxykMmOfikwQDmICNZ3hNKyObsbk8=;
 b=FO5Iqi4JcdWv4bRDehR8qfgPaMDeKLwaRIqFL/HkOXmvg75g//jphy4y2fs8earPQ0f7zL
 QvgqVIJRtwjM5+0w/bg4DW80gJ8j090yTrwotzQlhXO7xmMFaEf9pzlv8kyt/jFMskYLpL
 ALKphsjTxt5wV1qIar/S6nutX6IbY8M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-G2g5H9DSPUit5C6l6YIarQ-1; Fri, 27 Mar 2026 17:20:12 -0400
X-MC-Unique: G2g5H9DSPUit5C6l6YIarQ-1
X-Mimecast-MFC-AGG-ID: G2g5H9DSPUit5C6l6YIarQ_1774646412
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899fead92c6so82807916d6.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646411; x=1775251211; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hOLSKYh5G+WWJsgxykMmOfikwQDmICNZ3hNKyObsbk8=;
 b=HOjn413AhZLNMHXVBIqPMrqDmae/IksrXaGBI0KhwcfMP654hL70naRNIPj6ytTC1w
 PFTW6gf6UYdZH/3Jxwv4kegdrFnFhAfTKiK+6rSLvJXmmlRtTswZYjk+tCYjx6VHK7A1
 UzfddGokrz3uL4/wnMk9ZVQ4bOQXfWxgUgZfqgCJyoqdvX5iXMFbvIL5VPrsSo5MrIDd
 ymFszhlIyxTts3COleBYWWCm0XT3XB31VS2p8peWqIFbsGchhjU3qh7tdtACNRpXE8zS
 Ni3rmNG3thTkuz5eE/YbQ/uIGJB2rK9j87/RsQr5mYN4frCNOXeudvtaXG4ob1dzO9BV
 GPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646411; x=1775251211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOLSKYh5G+WWJsgxykMmOfikwQDmICNZ3hNKyObsbk8=;
 b=UyaNZ/n6Qdsi7p7tTEQ/UlIFpqpAqQB5L8Qa3A0zUvcyUcxo+Dbfo1wLjEj9PJe5O6
 xe1ksO9QDf1JIQSZeENYlUA3WQuK6dnBPTgTryqHmeoJSiOO9FHb+q/vI38laJsiKl3x
 MVF5t1Spx955kygTc5AULd5TNryAfl8BWffcoqjjDwhugR+go9jpd12LWmDstJbcPe9w
 JWa2fH4fRvoPZTvyi7x7yJUOYeo0RUu70KpftyegPsbQXWCqG4dUnRZVvdXd5bsWDSb+
 wqaj0CREOQqANsp1lIOAnGoPJKE0MxSBko76NTr/Q020vCRpZzDa320ro6bePZuFY/Hp
 sAZQ==
X-Gm-Message-State: AOJu0YwXMUA9ceohB0qZjra68Kq2XCwgmLrzOfUoiYw1qsqqWvR/giZO
 JNh+Mid541gXA24GlOyjHT0uIoPUgw2/eAqaKcwf2dxGH1jkP2YWtDGeb/VjOCce+IghJwRINN9
 GxKEdqlqedZ/y3hW9wfFF1HwnQjPUoy0t7jvyOHXowedCDhvAafEvg7Uo
X-Gm-Gg: ATEYQzyCC9z3S52/iG38nin+eLAjgkft49WZrT34CdeqGj8Azsy931CpozD+BdJTD9B
 knWdeWQQqKitXKQIO2ABORtTaGANA4OwBNY1uN3gzKmZmPWiZgUziroH4iPdNGomIdfLJBqUiCZ
 EU+EbNhJdV0aTm39da9y/kBd+A0ihUrKJOly24MaB7UBvj4q2Uv7ImBfi1g4HErALca8Nov5nvh
 pq52jifxRLMrtQWxt+rzoeYH8uhSfYldCRED3qjlFRqgqpAkVLA2ZBz969CfOT4IBK8YieH3qe2
 8VWeFJCc1MU+w+yO5CQoQA7S0A7RJvUDNk1MCscUpAcC0IcV1NmZFb41gRKubDYsJEqQKfRuw04
 8sYBfJOyw8taW3w==
X-Received: by 2002:ad4:5c67:0:b0:89c:4ea7:a714 with SMTP id
 6a1803df08f44-89ce8d16f11mr60110726d6.22.1774646411577; 
 Fri, 27 Mar 2026 14:20:11 -0700 (PDT)
X-Received: by 2002:ad4:5c67:0:b0:89c:4ea7:a714 with SMTP id
 6a1803df08f44-89ce8d16f11mr60110396d6.22.1774646411120; 
 Fri, 27 Mar 2026 14:20:11 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89ecf95f3c1sm2275156d6.40.2026.03.27.14.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:20:10 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:20:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix slow test dirty_limit
Message-ID: <acb0iV_GGevQW4uo@x1.local>
References: <20260326164405.1626-1-farosas@suse.de> <acV4N7ENkELzx5V9@x1.local>
 <877bqyjnv9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bqyjnv9.fsf@suse.de>
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

On Thu, Mar 26, 2026 at 06:13:14PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Mar 26, 2026 at 01:44:05PM -0300, Fabiano Rosas wrote:
> >> After the referenced commit, the incoming side doesn't exit
> >> automatically after a failure. Tests that expect the destination to
> >> fail should use -incoming defer, issue QMP migrate-incoming, wait for
> >> the failure event and issue QMP quit.
> >> 
> >> Fix the dirty_limit test which wasn't updated properly.
> >> 
> >> Fixes: 4e8c4dda97 ("tests/qtest/migration: Force exit-on-error=false")
> >> Reported-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Highly likely I missed something, but could you remind me what is the
> > problem before the change, and why "defer" fixes it?
> >
> 
> The original issue was that on failure the incoming side exits abruptly
> and leaves resources in the io/channel.c and io/task.c without freeing
> and that triggers ASAN (when in use). The fix was to set
> exit-on-error=false always. -incoming defer is needed because -incoming
> uri has no means of setting the exit-on-error flag, we need an explicit
> call to migrate-incoming to be able to set the flag.
> 
> The dirty_limit test was not updated properly because it's under g_slow
> and I forgot to test it. I removed the qtest_set_expected_status(to,
> EXIT_FAILURE) line, but didn't make sure exit-on-error is set to false
> for this test. So it's now aborting with "expected 0, got 1".

Mistery resolved after I git pull looking at the new code..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


