Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2F6C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BUK-000468-17; Thu, 17 Sep 2026 08:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7BUI-00045y-4d
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7BU7-0002LY-Rq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789649102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/+XnQQdpY16HrfqNg9Ud6jr5b8dFU8MA6VYaSlnQW0=;
 b=NZgcSjBPDzRa3t1Hw+xyVM/0jYqZvS2IGrXY3cdPdyWCFkgQbD0mFmHRXbxJ5Mc5vFytsf
 2U0nZCYYbvpXxhdOds+fvTPz9ycxADLq37esLyII3GBnyEWHwW2YMNpeOexN9sOa1Ktg9p
 INRMPdYvB3wHsK6cpLLkcYLJ291HEhY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-sCw8BkUpPv-259GIbJEJrg-1; Thu, 17 Sep 2026 08:45:01 -0400
X-MC-Unique: sCw8BkUpPv-259GIbJEJrg-1
X-Mimecast-MFC-AGG-ID: sCw8BkUpPv-259GIbJEJrg_1789649100
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91043af01d9so17810516d6.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789649100; x=1790253900; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4/+XnQQdpY16HrfqNg9Ud6jr5b8dFU8MA6VYaSlnQW0=;
 b=LpecIiUXE8kekMWGQ85lFM5ngMRNJX17oQfFcCl4IFkEHmUG+NWfmfYoBky9lELJmi
 C2LeEc6JTyTzUjrNiirRaggKoIXn3OqIm4ORYEZFSzvFosgkqVWdLDpPoEXK1iJW5qsY
 MuWzAO856SB+xmGtd12mpA0DVP0OGhlPUWy11nwxFZTuvNEpzKZ4SpfgDaAnm0C5qM1J
 jK0p5/P+o/XFcDSuHF7uUu+6++nSjWu2tiHL2l9j/5FPNbIGgwqC+q2WnAoSt0VtJQLV
 gLEehwwfRxLFHuOkvoJBeK9fRZw8/HT2enhnQOYp1mmZZMvDLWBX1NTD9fYv2R3K/K5c
 Capw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649100; x=1790253900;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4/+XnQQdpY16HrfqNg9Ud6jr5b8dFU8MA6VYaSlnQW0=;
 b=lCtR2F20Tj7xJju/gGpnDTP+ZvWEQz7CgiYtRhw0zsEydeFzG81jkmiqpDgzbYzFQG
 gLflO41JT9a6ip+V3PEqZ2rrQ63M10dE7f5ZDPz07BH5JfJ1vJOgeXNQq6gSR7jMVaLd
 x9zED6SLoVNl6QERqnMXWwOFz3jtkls7w1lXS0W7XGOde8wJ83h2rVpxYHbPEBOP14sp
 2HG6GnebtRcVlYiWROoUV301pN28Cv3qbqKRjmcwk5N7gCFw+HW2Puy30EXQk+3nIK5s
 Zi8y2K3cGQ1gjly9+c/3iaYxi6GxUOb3NrSy6JO5L7kxN6s7azs+XINy5dBlSG8SVEcd
 Q/JQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByVSqaWThD6tVZZhD8joOVIHAAnHcb0grEd7oaK9JuoDHO6eWV70bNSPMT5QE7aVwcxXB3ZDr8rfhs3@nongnu.org
X-Gm-Message-State: AFuF++mFL48gzml/kiDpLdxLuiQA0Dp7vujn/C1ShU/vi+iuCAtJOH6P
 fkWucz9CzpYtgBDEMfdup6gWip8xqv8gC3w0S+eRirxaeDBSEepSozuMIz4Q0sMJ1uqMPK5iNHL
 f/qKTFf4HmFKYZXs5zc93ddiAIWt0rB6CA5lVqx+myxMf5PB4TM64cTJ/
X-Gm-Gg: AYBFou1co96HLzAyo/vrYT9N1ZwfMxjXf7bvTaS6xk4X2Yu5N2YDpQy5I4ei8/ksRDV
 R6mH6wavCR5+UumN+b5A54EmhZsPBrDVssCL/ZLnB5bxwKI6rqH6aYZT8YopwWcL9MZcFsx0zHK
 DWBZ1iQtg6egQP/iE1zAxMIuRejH0jcPew4o8oFX9YYi5z1vuE2FHY2cWm3fDv7egKPKL7PXaNo
 rJmneOq3jSJL7+f1IfJ0luvuaEWQVhcmtLp/dQsOkpWLl0FYN3eFw4Qnn3jtqFpiHMOlfeiJEF9
 5F7zP8drw0YFN3TcM7UvAVLJVGlBVeK6cHfj1X1qJBSh3ta2fJddAMwKiZvplF82OGJk
X-Received: by 2002:a05:6214:448b:b0:910:31f7:3bd7 with SMTP id
 6a1803df08f44-9123d7d57f2mr116850276d6.29.1789649100447; 
 Thu, 17 Sep 2026 05:45:00 -0700 (PDT)
X-Received: by 2002:a05:6214:448b:b0:910:31f7:3bd7 with SMTP id
 6a1803df08f44-9123d7d57f2mr116849796d6.29.1789649099784; 
 Thu, 17 Sep 2026 05:44:59 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-912497f80b9sm16975606d6.25.2026.09.17.05.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:44:58 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:44:47 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqvgvw44pMtCZRGB@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v785rpml.fsf@suse.de>
 <aqrwAftZOnT4LsI6@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <88028fa0-6b8d-44a6-8a59-41480b9d7b69@maciej.szmigiero.name>
 <aqve6zlIKMMcIfKV@zhexu-thinkpadt14gen5.rmtcaon.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqve6zlIKMMcIfKV@zhexu-thinkpadt14gen5.rmtcaon.csb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 17, 2026 at 08:36:59AM -0400, Peter Xu wrote:
> On Thu, Sep 17, 2026 at 02:24:42PM +0200, Maciej S. Szmigiero wrote:
> > Isn't moving to more fine grained locking than BQL desirable in the long term,
> > much like BKL was split and removed from Linux kernel years ago?
> 
> My question was more seeking the issue behind.  CPR is pretty special, I
> didn't expect any new fd addition didn't already take BQL, at least before
> reading the last message.
> 
> I don't think we should randomly add lock for any structure that is
> currently protected by BQL, it'll unnecessarily slow things down.  We
> should only do smaller granule locking when we can consider getting rid of
> BQL in the first place.

Now having some understanding of the issue, I noticed I'm not very certain
whether this small lock can avoid all the issues.

Consider a race between cpr-exec migration at the very end, cpr_exec_cb()
does cpr_exec_preserve_fds() walking all the fds, then another connection
established in monitor iothread trying to add a new fd.

In this case, when without this smaller lock, it may crash accessing the
hash.

When with the lock, two operations are serialized, but is it enough?  It
means cpr_exec_preserve_fds() may take the lock first, mark all fds
reserved but without the new connection.

Would that be a problem?  Theoretically, cpr should persist all fds in this
case, including the newly attached?

Maybe it will never happen in practise because libvirt should never add
another connection there, but I feel like it's more than "protecting
concurrent access to a hash" problem.

Thanks,

-- 
Peter Xu


