Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD861CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMDX-0003GV-Ju; Tue, 19 May 2026 11:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wPMDW-0003G4-2B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wPMDS-0006uu-T2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779203918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFTt9OPBQRIWdyIw3aWWLt7vK2HIYfO5V06dwyLC23Y=;
 b=FUD1LIFdY+L7m0PZbTigG45V3KCFTQdGrO9slHI43g15brQQVMAom0+YXtZdRRkomWbUYC
 no6W3M+8c4BzTwVD5Ekickargp66ZIF6y7SNrJ4Fz0wyB+i5g9uCiziGICZohZbOrBFOEy
 i3UJiVudR4wGt1kAym3QZSrMf7jJQyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-7NT5vHQDP4K51GeErAl5Jw-1; Tue, 19 May 2026 11:18:36 -0400
X-MC-Unique: 7NT5vHQDP4K51GeErAl5Jw-1
X-Mimecast-MFC-AGG-ID: 7NT5vHQDP4K51GeErAl5Jw_1779203915
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fda34ed0aso14581895e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779203915; x=1779808715; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IFTt9OPBQRIWdyIw3aWWLt7vK2HIYfO5V06dwyLC23Y=;
 b=N70RYckEsJUwE2tQy5U/DQ6eC9+rJHIFkMJ194TL7v+l+EturZcWDaUlE+N9bke4Cq
 v/v7qbht9U0DUM6c8gJ7varsRXJqzr05o/xq5uWpgLcOC56PIb/BYRb+oiP3EE2//oSI
 GCd1+PPEGQ9OwWYL3OcsVU/ahO1EZgRyLeGduTU9MfdyCTuC8DdMgUeQToDfGCyBg39G
 NByWU4MHyNTjddMr5sOQYc+tr45oT5QMPxekKKD93fVBlWkDXef6N+lNl9ajMs2hewtV
 ftzaKzH7dDZpOR0xPDKgACFrvy6u3MaBc3p8oiA0C6lnOWRnOLYJLoRh+CnL3hSViSto
 +MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779203915; x=1779808715;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFTt9OPBQRIWdyIw3aWWLt7vK2HIYfO5V06dwyLC23Y=;
 b=tRaUQJ4Gi1cH/Now6PYxvXtApaEhv3ZrA89a+9hiEErly6kwfFgo7LYvANYWEGyyYA
 DWihlUbtfsuAxShFoUPQ8pRt0fQ/R0rAIq9xQxoewjL2Xeo77t0VfAkUck2SttfCoWmy
 Db3Y267qMEAiACHHdwLtw1cA/yOR13pX+9Djhm5MtffidCTfMI5XCiJ5Y11Ki/QwHkin
 hp7obuv10IizXU3Gibe7UJg9EDIssEdRjv1f25Hz7u+JqvqcgVdjPA4tqv8llfC/BPTU
 rt5upM8Im35Xt72aTI8YOtaLmR7hOznD6EH+ei0FwHCOAte7wVeBsYyA2FjncMomp0hf
 cV7Q==
X-Gm-Message-State: AOJu0YzbEkcgjmSru62mHh+7ZRbNWBjVfqa4ibKg5n7co4QfXR5u5hTE
 wY4FTpByOPx/Skv8PsnjkLqI/72rTJVO60otxhXWETtSz4Q/lrebPi/iBkHRAEt/qLHQ0xxJ0uD
 mdipsT1SaWDSR6HCWz6jW7dMdLSF8tJxNmimkXfW2J9UNascdfw3OwAWH
X-Gm-Gg: Acq92OGD2sa/1PxKpwjDe26hCwxlg6LLQBqadwWgUdFHu4wu6t9SKOyrAi4bqmz/ymR
 HTupwDTKTm4tNvcjyU84UT0ebiuQThtDA0JfbTCdP6Nvoj/+vvxf0rzu8jTH7iUb+Yp2AuuqHWQ
 /QbTMkEp7gpjqgff9mFAOYGYkpZFUHmWTDvsqJNoxe0MjWDPES0Q3z1eun1926sfU5Vu16BtoU9
 jx6pRt02IUjyZmz632IJ82hycQZi8b/p78jh7Cu+3V5exuUg/ipFZc4Z85nOVUm1aBoq6MaE2rG
 fxAmkD33pA4/41a6Xug7fRVr2fpu7GjEry//XjvW/YlRKRUVwu1+90E1A59AuHo78yHGcGSNmEl
 kg+CHOhBD5yu4uNsnN8VG7Xt7t5udRSm2hrOw0EuL9ZZkB+TfZiwgpQ==
X-Received: by 2002:a05:600c:a405:b0:489:1f04:96c3 with SMTP id
 5b1f17b1804b1-48fe5fcded3mr291645025e9.2.1779203914704; 
 Tue, 19 May 2026 08:18:34 -0700 (PDT)
X-Received: by 2002:a05:600c:a405:b0:489:1f04:96c3 with SMTP id
 5b1f17b1804b1-48fe5fcded3mr291644255e9.2.1779203914132; 
 Tue, 19 May 2026 08:18:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm50538273f8f.13.2026.05.19.08.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:18:33 -0700 (PDT)
Date: Tue, 19 May 2026 11:18:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: RFC: GitLab issues for security disclosures
Message-ID: <20260519111646-mutt-send-email-mst@kernel.org>
References: <agxzKzzDOJm1EU_v@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxzKzzDOJm1EU_v@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19, 2026 at 03:26:51PM +0100, Daniel P. Berrangé wrote:
> The qemu-security mailing list was created several years back now and
> traditionally saw 1-2 disclosures a month at worst. This was manageable.
> 
> Since approx March 1st, the new normal is to see as many as 20 disclosures
> in one single day, more than 200 in total now. This is unsustainable.
> I was thinking we needed more people on qemu-security to triage, but IMHO
> this won't really fix the problem.
> 
> This needs an issue tracker to cope with & email is not an issue tracker.
> We faked an issue tracker with a shared spreadsheet to prevent us drowning
> these past few months, but this is still not sustainable & probably won't
> ever be.
> 
> The traditional POV was that security disclosures must be dealt with on
> a strict "need to know" basis until there was a concious decision to make
> them public. Typically that happened when a patch was published by the
> maintainer on qemu-devel. Rarely have we applied an embargo period after
> a maintainer had a patch ready to post, as most bugs were not severe
> enough. Also in typical usage Libvirt has SELinux/AppArmour to mitigate
> impact of a guest ecsape into QEMU.
> 
> QEMU is not alone in this chaos, to quote Linus
> 
>    https://lkml.org/lkml/2026/5/17/896
> 
> [quote]
>   the continued flood of AI reports has basically made the security list
>   almost entirely unmanageable, with enormous duplication due to
>   different people finding the same things with the same tools. People
>   spend all their time just forwarding things to the right people or
>   saying "that was already fixed a week/month ago" and pointing to the
>   public discussion.
> [/quote]
> 
> They have explicitly changed their policy for disclosure now:
> 
>   https://github.com/torvalds/linux/commit/a03ef333fbd6cd861c8457c3d055ee3643a9baad
> 
> [quote]
>   If you resorted to AI assistance to identify a bug, you must treat
>   it as public. While you may have valid reasons to believe it is not,
>   the security team's experience shows that bugs discovered this way
>   systematically surface simultaneously across multiple researchers,
>   often on the same day
> [/quote]
> 
> IME for qemu-security we've definitely seen the same bugs reported by
> different people, within days of each other, a couple of times even
> the same day. Dupes are not the majority  - QEMU has so much low
> hanging fruit - but they're a sizeable chunk.
> 
> 
> Because we don't have a good automated way to publish disclosures
> from qemu-security, we don't provide contributors any way to check
> for duplicates before submission. The burden of checking for dupes
> thus falls on the qemu-security triage people, or the maintainers
> we forward issues to.
> 
> For disclosures in the non-virtualization use case, we ask the
> reporter to file a gitlab issue or send a patch. They almost never
> do this. We're lucky to have any reply to emails at all.
> 
> 
> IMHO we need to move to an issue tracker. GitLab was originally
> discounted in favour of qemu-security list since "Confidential"
> issues cannot have visibility managed in a fine grained way.
> They are visible to everyone with "Reporter" role or higher,
> which is 70+ people for QEMU.
> 
> If we accept the kernel's view that AI discovered issues should be
> considered public immediately because of the high chance of parallel
> "discovery", then GitLab's limitations don't seem to bad.
> 
> It is also of note that we've had some people ignoring qemu-security
> policy and directly filing public gitlab issues for stuff discovered
> via AI/LLM agents already. Those are not getting attention for CVE
> assignment, should it be needed which and can't be cross-referenced
> by general maintaniers to stuff we have received via qemu-security.
> 
> We have some options IMHO
> 
>  1. Move all security disclosure to GitLab confidential issues
>     no disclosures via email
> 
>  2. Move AI/fuzzer assisted disclosures to GitLab confidential
>     issues, keep human discovered issues on qemu-security list
> 
>  3. Move AI/fuzzer assisted disclosures to GitLab public
>     issues, keep human discovered issues on qemu-security list

or 4. do it like linux did, and move ai assisted disclosured
to the public ML. Fuzzer assisted can stay with human discovered.


> In all three cases, if a GitLab issue is determined to be security
> relevant, any maintainer could send a request to qemu-security list
> to get Red Hat product security to allocate a CVE.
> 
> Out of those I'd probably lean towards (2) which is slightly
> more restrictive than the kernel new policy but not by much.
> 
> Some key benefits of using GitLab for security disclosures
> 
>  * We can trivially make disclosures public if we classify them
>    as a non-virtualization use case, or when the fix is ready.
> 
>  * We can formally track the lifecycle of disclosures through to
>    the final fix, for both virtualization & non-virtualization
>    use cases. The only difference will be that the former can
>    request a CVE assignment
> 
>  * We can do reports/queries of outstanding issues
>  
>  * We can more easily use automation to process issues
> 
>  * Maintainers can see bugs without waiting for someone to triage
>    and forward it on their way.
> 
>  * The small number of security bug triage people are no a bottle
>    neck anymore
> 
> Some downsides/implications
> 
>  * Every disclosure in a confidential issue will be visible to every
>    maintainer who has joined the qemu-project repo on GitLab. IOW
>    that is treating every maintainer as equally trusted.
> 
>    We do have qemu-security though we could be mailed if someone
>    considered their disclosure to be severely impactful but the triage
>    team can't make that decision.
> 
>  * We must NOT grant membership to qemu-project at a Reporter level
>    for anyone whom is not an active maintainer. They must be limited
>    to the "Guest" role at most.
> 
>  * No one is formally responsible for GitLab issue triage. We have
>    had Thomas do it in the past periodically with script assistance.
>    We have Alex doing some of it now with bot assistance. The danger
>    is security disclosures get ignored as "somebody else's problem"
>    no one has accountability.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


