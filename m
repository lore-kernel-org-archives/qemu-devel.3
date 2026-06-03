Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8FACD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpfP-0000Rx-KO; Wed, 03 Jun 2026 13:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUpev-0000GF-2U
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUpep-0007Zk-KV
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780508731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+C/9lPFJiMDATa0qbUxq/FzdWUtrCiAGlU4f6y5iIc=;
 b=BX6563M2tYUrhuCLBp4a9rp8DFrbRSQHtpyqBRL5xwqN8FNibH9ts8uMDPuNizqP0AGZXm
 2sgxi9TpyPFOO36lSbdY8vzMs0BNo2OkA4Mi9mWGGnuh+JLhc6tuABrRyZkcKS+Rrm8usp
 u4PTVASvkzohXbXkfKjlqWOMOmP0S+s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Kvc_fLBUPXSEWsUcHWtYHQ-1; Wed, 03 Jun 2026 13:45:28 -0400
X-MC-Unique: Kvc_fLBUPXSEWsUcHWtYHQ-1
X-Mimecast-MFC-AGG-ID: Kvc_fLBUPXSEWsUcHWtYHQ_1780508728
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cce4f4634fso111125016d6.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780508728; x=1781113528; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q+C/9lPFJiMDATa0qbUxq/FzdWUtrCiAGlU4f6y5iIc=;
 b=GjjEtf8pzxPLLq+H3efAmLsgZ/0ibfDCT5ZH1bHIt9SzEbWpPf/4BlunlNZ1r990ix
 naqW+Hi0G9r0cQds/jks6teagsJOM6Yym4lXcu5iNTyiO6All3Is86xOxoY+q7TO2rbB
 aybyIKt8JkzjewO56w8LhcxUZqiRGq/pyd+ZcvTzOocq9DV3wLdJzgltBU3wIcv0hrNA
 eq7mEHCN+SHKG60eWzBmxGUopoRIaqR1oJBH+SMuTxYncRIdOub/Z7hmsBBqnpNo4PA4
 2ndGBnuQEtBjR+Pb8ml7ryuGsR9T6RQMOwUz+NuFn1C9aLxBlFh2MdW+42DaZ/KjVt8v
 IvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508728; x=1781113528;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+C/9lPFJiMDATa0qbUxq/FzdWUtrCiAGlU4f6y5iIc=;
 b=XT34Ojmo1RnJnHNrhrlK5hIrLKUULtGZhfhNxpx9xDXcTFx1EoPZCzGMXoQBmdcc0z
 bJOw/jcDKaBJKCYIur03Oz2q+0AvdnjhuszmOCnSnpXU5e8NrTmtny85T20YdfDaLVgn
 ekmsolrZG3KbehxbhIePb0nexC8eZFWld9m1O6Fdx6bOiKUGbaNICbBuiucpYyJ/tzf0
 cNKUpF2LQICdaFwLZQJDNGxln60Nys2hvHw6FENJpB6OTbUgwOC/bpvXkAH3G2NnVHS6
 WMOV/HW/hdwIj8Cr2zemwXhXaJg5CSTzB7d00RU96M/C2TykcKFudMobT7S1dzVu+2zd
 iBgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TPXxtDnXaWvuziZcIhhEpbIJvYcy+9p1aU1CFaAqUhm/JH4P2UbYiXGq/hRnteMJ1GEdX7ysZLs2z@nongnu.org
X-Gm-Message-State: AOJu0YynzMDLtWgsE+XpOt8rbj2u8yljZY7/CQwZVv6IzPE3yoeiY0AN
 H7zdVSfomLy2hcYfkjnLfcxG6eREUfhqLHZaXBA86gAJ9TV0zoT8PfofQmvTVSLTm4jpctfHbEp
 UxTlEr/+oORScSHWj0ExyrRWR2gm+VPAY3jd7tyVHHFR451gzDC7tKFlK
X-Gm-Gg: Acq92OER0ma+LTJdiozNRks4ac2Vhk2T4+UCQBCoaHStndDggJdr8+YviCm9lCy7ncR
 mOi+zZLwTLrz/pM2hJgjiIDPjFRjEvFmpVy2qIlmOuPzirpGIrbQMZJT0EycHq9IAjpGbInagJN
 fqa1OlTeA5a4WzZN82DQbCzSJgQjr9L71YOH+03tthEynLqeuVROjy7Rmt1bk6kvD1zJKkHf8NN
 w6tgEkwf7Gym2SQB5XlWDV97Zz9aydhKl6ey2Ww0//jWiZ7b9vvS1QUEwwBZSzkSTZtZzVcYWBc
 4HnLGZ9bnqwUfq6CBk5HIxRe4Qgm8YIT9cZfunYR6cAKlgfqdsV2PLrbLCPgihvIDRFY2V0OuOa
 qB09Xy2khRCjBVZPKq5BuZGhI1w==
X-Received: by 2002:ad4:4e09:0:b0:8ce:af02:fc78 with SMTP id
 6a1803df08f44-8cece030faamr48256096d6.37.1780508727603; 
 Wed, 03 Jun 2026 10:45:27 -0700 (PDT)
X-Received: by 2002:ad4:4e09:0:b0:8ce:af02:fc78 with SMTP id
 6a1803df08f44-8cece030faamr48255396d6.37.1780508727043; 
 Wed, 03 Jun 2026 10:45:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0521f2sm26230176d6.31.2026.06.03.10.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:45:26 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:45:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiBoNIIF5Ofi7NcK@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiBhTTqSctU9lFsS@redhat.com>
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

On Wed, Jun 03, 2026 at 06:15:57PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 03, 2026 at 11:50:53AM -0400, Peter Xu wrote:
> > On Wed, Jun 03, 2026 at 10:48:54AM +0100, Daniel P. Berrangé wrote:
> > > On Fri, May 29, 2026 at 10:15:35AM -0400, Peter Xu wrote:
> > > > On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
> > > > > Peter Xu <peterx@redhat.com> writes:
> > > > > 
> > > > > > CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
> > > > > >
> > > > > > This series introduces a generic way to specify migration parameters that
> > > > > > can be used even during the early boot phase of QEMU.
> > > > > >
> > > > > > One example use case that already existed is CPR-transfer / CPR-exec.
> > > > > > currently QEMU has a temporary global variable (incoming_mode) to achieve
> > > > > > this, but it's hard to understand and this hack bleeded into quite a few
> > > > > > places that we could have avoided.  The lines in patch 2 touched may
> > > > > > provide some idea.
> > > > > >
> > > > > > With a generic approach of setting migration parameters with cmdlines, we
> > > > > > can remove this hack meanwhile QEMU should be able to keep the CPR behavior
> > > > > > as before.  To CPR maintainers and reviewers: please have a closer look,
> > > > > > even better if it can be smoke tested, to see if this works for Oracle's
> > > > > > environment, TIA.
> > > > > >
> > > > > > The 1st patch implemented that new semantics.  It is straightforward: now
> > > > > > we can setup any migration parameter using an extra line of:
> > > > > >
> > > > > >   -incoming config:key1=value1,key2=value2,...
> 
> snip
> 
> > > > > - using "config:"
> > > > > 
> > > > > This makes it non-uniform with uri and channels which don't have a
> > > > > keyword in front of them. I guess I could live with it, but it seems
> > > > > odd. I see that it makes parsing way easier.
> > > > 
> > > > Yeah, having some identifier would be nice.  I wished channels also have
> > > > identifiers if we don't need to keep compatibility.
> > > 
> > > IMHO having a magic "config:" prefix is an anti-pattern because it
> > > involves custom command line parsing logic.
> > 
> > Yes, it's not elegant.  I wished we had something like this though when
> > introducing the cpr channels; right now anything wasn't "defer" or URI
> > implies it's a "channel"..
> > 
> > I also wanted to avoid introducing new cmdline parameters, so migration
> > incoming cmdlines can stick with the same option.  If there's better
> > suggestion please shoot.
> > 
> > > 
> > > Does "-incoming config" imply '-incoming defer' semantics or is it
> > > independent ?  
> > 
> > They're independent.  Examples:
> > 
> >  a) "-incoming config:* -incoming tcp:*", setup parameters for TCP incoming
> >     migration without further deferral
> > 
> >  b) "-incoming config:*" only, setup global parameters for a possible
> >     upcoming outgoing migration
> 
> In that case they should definitely be independent command line
> options. The old "-incoming" design is already broken / limited
> in the non-'defer' case because it is hardcoded to use URI syntax
> which can't express all the address formats we accept in QAPI
> syntax. Adding more special cases onto -incoming just makes the
> bad situation even worse and is not a forward looking design.
> 
> If we need the ability to specify migration parameters on the
> CLI, then as a starting point for the design, we should assume that
> -incoming does not exist, and design a complete solution from scratch
> that uses QAPI exclusively, both for addresses and configuration.

Do we want to obsolete -incoming?

> 
> As discussed before, IMHO the "migrate" and "migrate-incoming"
> commands need to accept both the address(s) and parameters/capabilities
> as inline data items rather than relying on pre-configured global state
> from the 'migrate-parameter' / 'migrate-capability' commands.

This is one example that "relying only on migrate/migrate-incoming to
specify parameters" won't work.

Essentially parameters like CPR's and the new "local" parameter wants to be
global so that it will be visible and will have an impact on how other QEMU
modules behave.  Here for TAP when "local" is globally on we may want to
initialize the device differently from the default operations.  That will
need to happen before any QMP commands.

> 
> If we did that modelling for 'migrate-incoming' then that modelling of
> command parmaeters could map directly to a new '-migrate-incoming'
> command line argument that accepted exactly the same data model.

This is true.  Then we will make this series to depend on Fabiano's
previous work (to be posted; per we talked yesterday).

I wanted to see if we can reduce the impact to minimum, -incoming is indeed
not well designed, but in real life we have control over what can happen
with URIs and the current "config:" won't conflict with any of them.

But if we strongly wish to obsolete -incoming completely, I'm OK too.

Thanks,

-- 
Peter Xu


