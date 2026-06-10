Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B23CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGAw-0004Io-9h; Wed, 10 Jun 2026 06:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGAu-0004Hq-5m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGAs-0001IS-An
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781087320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMXnR2dWWFIW58+CNVLgGxcEKMTDoW5SAM5OH8H4ZdY=;
 b=LesEvLYnRXKIWuX0iEi+OAKFgxty+wGK+iXxu3QcNfE4750ITSsDCDD/rfjiOpuw9EpCUa
 ttk+yBsobXf1/GfIw1Zn9m19/pKMG+CZigVRq55KA9LA4x+kgSoFbVL6l0+Ar3115wSuBT
 g1ST+0GBtnDkqd5NnM2lAXAyK1dKYss=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-r9gGNPj1O3umDj16QLkPDA-1; Wed, 10 Jun 2026 06:28:39 -0400
X-MC-Unique: r9gGNPj1O3umDj16QLkPDA-1
X-Mimecast-MFC-AGG-ID: r9gGNPj1O3umDj16QLkPDA_1781087318
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ab3f6e55so26891935e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781087318; x=1781692118; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oMXnR2dWWFIW58+CNVLgGxcEKMTDoW5SAM5OH8H4ZdY=;
 b=Ug9TQRy/XqwR81hfiEZQs+4OFIT600vvz00ApJxXwaBQKsvOwGgg3pjdph5zbTGNYk
 0T3Q8wCR7phkfBmIxrMhb9ab6QUNQnkDb0jgwHEpX1RkQ3J2nfrcYO7jV41xDKY6WpbL
 o4tNCRjfqmA6kPGOpoPgOG9gFnr9ulwUtC2+NtWV7d9cTtLjKy+XGobymHM0r/mi0wAK
 thuVIQLq0i8hsV2NGvPBSTD4FkoNPmI1QtzhYvLvI9L/sM31N6jgoeWFRR7U0t5u20JF
 1UxGSVDN0M0jxFFETrWzSsSLJHlCol9Hab/DLZraM8Jtnf4h48x+GcXDiYJ+fu9Ne10z
 rcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781087318; x=1781692118;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oMXnR2dWWFIW58+CNVLgGxcEKMTDoW5SAM5OH8H4ZdY=;
 b=r1w9CadZLR83xLatZwi+Jt7qgxtCA73sViYvEssyt3Tr48f4WkbAP85EWqZAYKuwIr
 RIGMDsoWJyoHJc2d7JmgGBJYx38I6h3gBRPzVJalguuVI9cOvDqXcVEnAoTbcYIEO7Nt
 DudH2Mmgo7n9BOcFXA07v0bEuAWylQjShLjRoG+o29JJSndIuFggH4OhughdXofpy3bV
 44AM61+ZeLXptuR3WkgVtzBb09S1U3WqzR6VSmOdoI6p515eLwm/Rfiw+QyE+Bkl5Xx6
 r87pRKy0lTCUcnYEch3/SquT2mxhXVHO56Wl4qf2dqjoenyd0WIqBPbwAVrx+kq/iWwY
 MWuw==
X-Gm-Message-State: AOJu0YxOlQhFmiMoRVhHY/l87Y1qNZEELlQvM/D3CB9Up4Ya1nmLR+Ei
 IKh5oY7LXO+V9mhmyy2ekhyTr7ljaPUqV+2DlMQJVcVWV+A4YdOJlGHlLd6u7e+IkO1+E5IguEg
 z128QwbxPBgUC04JPvdK47c8ZmNUHERksI2YqxaYc8oXPq+IlturlItoL
X-Gm-Gg: Acq92OHGnwnYC0XQG7LGWaabkejiY6NuZShLvA7B8l/MXc08vFFTBteVupHtucK8Jo3
 zqvZS2ml4+F2DKQN9hgN9G1J6xog8lhaE4CUyLIoJqp+KLbJB8OjUkgTERo9EMNUi5xCWFU0p3a
 nO6r4RNIKiD8gxBytEJY6lWarMZ1KEngwXkV+Vf0K6L8pjaGNH1ArqaJC0domZjsnI/7Td1vZIp
 hFzPapK707EzRC+4QI25qWdDwmcebkthpeXBeBU8JcBE0gkklHI6n+VpsWSWCIB+PNzQbhaM5e/
 DewemYsDYCqe2H0wPv8kEX3a0iU+mfOpRDzcHDPqtIkhZtWy64uzEOK+384Bggc58bdK5zum5LU
 wziWBxkUW922yy5R89eOLoMqXixFWPtmZNWHXrgQocci6WrFw3OQnOw==
X-Received: by 2002:a05:600c:34c1:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490c25716dcmr361560465e9.11.1781087318088; 
 Wed, 10 Jun 2026 03:28:38 -0700 (PDT)
X-Received: by 2002:a05:600c:34c1:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490c25716dcmr361560045e9.11.1781087317563; 
 Wed, 10 Jun 2026 03:28:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm520738245e9.2.2026.06.10.03.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:28:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:28:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 0/3] switch to GitLab confidential issues for
 security disclosure
Message-ID: <20260610062358-mutt-send-email-mst@kernel.org>
References: <20260604165048.457860-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604165048.457860-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 05:50:45PM +0100, Daniel P. Berrangé wrote:
> I previously raised the idea of using GitLab issues for security
> disclosures:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04582.html


Thanks a lot for posting this!

Do we want a special

.gitlab/issue_templates/security_bug.md

For this?

It can include guidance in a friendly way.


> This patch proposal formalizes that into a concrete proposal:
> 
>  * qemu-security is entirely discontinued
> 
>  * "confidential" GitLab issues are to be used
> 
>  * The priority is to have a low overhead process that is
>    as close to normal bug & development workflow as
>    possible.
> 
>  * No embargoes will be accepted, beyond the time needed
>    for a maintainer to develop a patch, unless extenuating
>    scenarios apply. A vendor's/user's desire to delay to
>    suit their arbitrary software upgrade schedule is NOT
>    an extenuating scenario.
> 
>  * All confidential issues will be expected to be made
>    public, either when the patch is proposed to qemu-devel,
>    or sooner if a issue is low severity and a patch is not
>    a priority for the manitainer
> 
>  * Eliminate dependency on any single maintainer/person to
>    the greatest extent practical
> 
> Some open questions
> 
>  * I describe using "cve::required" as a gitlab label to
>    track issues that need CVEs allocating. I'm unclear what
>    the best way is to actually do the allocation. This is
>    where it is hardest to eliminate the single person
>    bottleneck / burden.
> 
>    Traditionally I would email Red Hat product security via
>    Mauro (CC'd) but that's still a single point of failure.
> 
>    I'm personally not willing to sign up for QEMU to be a
>    CNA, because they have unreasonable expectations for
>    volunteer projects. I'm not going to give them my phone
>    number nor agree to any SLAs for response to query.
> 
>    From a selfish QEMU upstream maintainer POV, I would say
>    that CVEs are largely devoid of value. The people who
>    care most about them are the downstream vendors who
>    ship old QEMU versions and track bugs for backporting.
>    If we want to pull a security fix into our stable release
>    branches we can do that easily without a CVE.
> 
>    Thus one nuclear option is to say "not our problem" and
>    no longer assign CVEs at all. Instead assign a unique ID
>    of QEMU's invention "QEMU-SEC-nnnnn", and let downstream
>    vendors take the pain of allocating and mapping QEMU's
>    identifiers to CVE identifiers.
> 
>  * We have >100 disclosed issues to qemu-security
>    that were classed as non-virtualization bugs which
>    I asked the reporter to file gitlab issues for.
>    Almost no one followed up to do that. I don't want
>    these bugs to go into a black-hole as they are all
>    basically valid, but I also don't fancy bulk filing
>    100's of issues from my own account.
> 
>    There are also more non-triaged issues some of which
>    are valid security bugs which ought to be tracked
>    rather than sucked into a black-hole. Again that
>    implies more bulk filing of bugs :-(
> 
>  * Moving away from a small dedicated group of people
>    handling security reports, to a distributed
>    responsbility has a notable risk - every maintainer
>    may consider it "someone else's problem" and ignore
>    security disclosures. Some poor sucker then gets to
>    run triage across an ever increasing set of issues
>    and try to encourage maintainers into responding.
> 
>    Based on our experience with normal bug triage work,
>    I'd say it is a near certainty that this will happen
>    to some extent.
> 
>    I don't have any answer here other than even this
>    bad outcome will probably be less bad that the status
>    quo with qemu-security email disclosure. Personally
>    I can/will not continue with the email workflow any
>    more.
> 
>    IMHO this mostly points towards the downstream vendors
>    needing to invest more in QEMU if they want to have a
>    guaranteed security SLA upstream.
> 
> Daniel P. Berrangé (3):
>   contribute: reformat/restructure bug report guidance
>   contribute: add automate tool disclosure to bug reporting
>   contribute: switch security process to gitlab confidential issues
> 
>  contribute/report-a-bug.md     |  63 +++++---
>  contribute/security-process.md | 280 ++++++++++++++-------------------
>  2 files changed, 155 insertions(+), 188 deletions(-)
> 
> -- 
> 2.54.0


