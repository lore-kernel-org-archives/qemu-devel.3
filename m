Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DC5C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 14:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmZh-00028c-Df; Mon, 07 Jul 2025 10:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYmWU-0000LB-Ax
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYmWQ-00010d-7a
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751897321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrORKWQytDGSyGg0HdRou4LqiB6YlU0DfuBUs+OAb+w=;
 b=J88PVv8w3QMLeo8ZtU5WR7276Dv0vo5dVCPrwFE4OXT9fYucW9B3foBUa/tu2kMBS2V3Xa
 pglnf1D4GyeQVuzkshjol70DD+Fy4ap/BbJ0K7HrT/pCzvXd1654KFnl8jQZdhJbVDk1w4
 ounZFo7PaDnU1L7jYHtMUZGGESH1RwI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-nvYV-mKiPl-JJhnuLfiVgw-1; Mon,
 07 Jul 2025 10:08:38 -0400
X-MC-Unique: nvYV-mKiPl-JJhnuLfiVgw-1
X-Mimecast-MFC-AGG-ID: nvYV-mKiPl-JJhnuLfiVgw_1751897317
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA121800366; Mon,  7 Jul 2025 14:08:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45B3C19560AD; Mon,  7 Jul 2025 14:08:33 +0000 (UTC)
Date: Mon, 7 Jul 2025 15:08:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
Message-ID: <aGvU3c8FTBbz6B3T@redhat.com>
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
 <e3e2f53a-33ad-49b0-99fc-c7af4b76a0d8@linaro.org>
 <CAFEAcA82LrhSz47_Q_FwbBmC-Nve-WR2bhfWoWyvYi_60MSBaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA82LrhSz47_Q_FwbBmC-Nve-WR2bhfWoWyvYi_60MSBaw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 04, 2025 at 02:14:35PM +0100, Peter Maydell wrote:
> On Mon, 30 Jun 2025 at 17:53, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> > > It is useful to compare PSCI calls of the same guest running
> > > under TCG or HVF.
> > >
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >   target/arm/hvf/hvf.c    | 3 ++-
> > >   target/arm/tcg/psci.c   | 3 +++
> > >   target/arm/trace-events | 3 +++
> > >   3 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > > index 7a99118c8c2..6309c5b872e 100644
> > > --- a/target/arm/hvf/hvf.c
> > > +++ b/target/arm/hvf/hvf.c
> > > @@ -34,6 +34,7 @@
> > >   #include "target/arm/multiprocessing.h"
> > >   #include "target/arm/gtimer.h"
> > >   #include "trace.h"
> > > +#include "../trace.h"
> 
> 
> > Just a nit, using 'target/arm/trace.h' might be more readable than
> > '../trace.h'.
> 
> Mmm. docs/devel/tracing.rst rather discourages this:
> 
> # While it is possible to include a trace.h file from outside a source
> file's own
> # sub-directory, this is discouraged in general. It is strongly preferred that
> # all events be declared directly in the sub-directory that uses them. The only
> # exception is where there are some shared trace events defined in the top level
> # directory trace-events file.
> 
> I don't know if we want to loosen that to permit events
> that are shared between multiple subdirs (cc'ing the
> trace subsystem maintainers for their view).
> 
> git grep 'include.*trace.h' | grep -v '"trace.h"'| grep -v 'trace.h:'|less
> 
> suggests that the only current place where we're including
> a trace.h not in the same directory is linux-user, where
> we opt to use the full linux-user/trace.h path. So probably
> for consistency we should use target/arm/trace.h here.

IMHO using the up-level relative paths is desirable, as it reinforces the
intent that we shouldn't be pulling in trace events from arbitrary different
sub-trees of the codebase, only the current dir & its (near) parents.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


