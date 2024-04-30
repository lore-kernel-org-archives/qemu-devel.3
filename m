Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D114FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kJJ-0001Wu-IF; Tue, 30 Apr 2024 06:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1kJH-0001WL-FZ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1kJE-00011Z-Lq
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714471320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edkCruug9wzPi1kWn74ppgCKz4uvxRBKM4zN1EnKEew=;
 b=OWCeyZdm9u6mMFmwItmXdSrS8XPyy0c1o9vUdTctHEfjroaeZAoq1z4IMrG+h6i1glbZ74
 C4Y6DJfDYMuDrupJoe+mIGBc8wt96FdQvsMO4boW5Kb6vNGI+MvL/HUOj7jKLQ7ne/FXkC
 Vrme0wRxprMEK8lGrQcJrM0nLbkrh/g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-ezHyA0OCMjmsmvOJNIo6oA-1; Tue,
 30 Apr 2024 06:01:57 -0400
X-MC-Unique: ezHyA0OCMjmsmvOJNIo6oA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AC923C108CB;
 Tue, 30 Apr 2024 10:01:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5A6C2166B31;
 Tue, 30 Apr 2024 10:01:48 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:01:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 afaerber@suse.de, ale@rev.ng, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>, bbauman@redhat.com,
 bcain@quicinc.com, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, clg@kaod.org, cw@f00f.org,
 Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com,
 jan.kiszka@web.de, jgg@nvidia.com, jidong.xiao@gmail.com,
 jim.shu@sifive.com, jjherne@linux.vnet.ibm.com,
 Joao Martins <joao.m.martins@oracle.com>, konrad.wilk@oracle.com,
 Luc Michel <luc@lmichel.fr>, mburton@qti.qualcomm.com,
 mdean@redhat.com, mimu@linux.vnet.ibm.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com, eblot@rivosinc.com, max.chou@sifive.com
Subject: Re: QEMU Community Call Agenda Items (April 30th, 2024)
Message-ID: <ZjDBihIw0-w2YXtD@redhat.com>
References: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
 <ebdd9766-04d1-4908-996f-e93c0cd4e6d5@linaro.org>
 <Zi_C_xHx33Q7T_96@redhat.com> <87v83zcnfc.fsf@pond.sub.org>
 <CAFEAcA9P+axwCS+aaA1K2rVzBsNquRG0-pNTncZemaOsXi=GyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9P+axwCS+aaA1K2rVzBsNquRG0-pNTncZemaOsXi=GyA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 30, 2024 at 10:44:20AM +0100, Peter Maydell wrote:
> On Tue, 30 Apr 2024 at 08:36, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > >  * /machine to get the rtc-time property value
> >
> > This is an alias to the RTC device's "rtc-time" property.  Only some
> > machines define it.  Useful because the actual property depends on
> > machine type and configuration.  For q35, it's
> > /machine/unattached/device[N]/rtc/date, where N can vary.
> >
> > If we moved the southbridge out of the /machine/unattached dump, we'd
> > have something like /machine/q35/ich9-lpc/rtc/date.  Stable, but you
> > have to know the machine type to find it.
> 
> Do we really want to call that stable, though? If we ever
> wanted to refactor the devices internally it might change.
> 
> My gut feeling is that exposing something we want to
> be stable as a specific "this is obviously an externally
> exposed identifier" (e.g. in the way we do by having an
> rtc-time property alias on the machine object) is more
> likely to be reliable than trusting that a QOM path all
> the way down to a specific device is never going to be
> rearranged.

Yes, the ideal would be that anything libvirt needs apriori knowledge
of should be accessible via an 'id' value assigned by libvirt. QOM
paths should only be used by libvirt if they're obtained dynamically
from a prior QMP query, not hardcoded in libvirt source. That would
avoid the QOM tree paths becoming API/ABI. The challenge is that it
is hard to predict what we might need to access, that does not yet
have an 'id' alias assigned, which is how we ended up using QOM
paths for a few things, where 99% of the timee we use 'id' aliases.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


