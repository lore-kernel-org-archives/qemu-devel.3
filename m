Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD00C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBbc-00023Z-HI; Fri, 24 Jul 2026 04:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wnBba-00023G-83
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wnBbW-0004iV-F5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784882999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDTGVivw2yWZjtMO4GQBcaj4N+chS0liQOAFC8ErBmo=;
 b=NH3fqV0FfdrBNzfZSLmGxC4sYYBTlzARHPLUr5KudvsH2ceOcZ5IZ0Oh91jduZEQ3UKTag
 Nnh8TtuFrK6zOEBE8K0SI9SP3fnhDwx+NJj6g/stLq+1/v5w/sOEdq4kunJ8SeeFWoncsM
 em/YRHt8ImiOood6/2bm8kZIhGG5R1c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-XlpKofWIOLuFLAd1VRJNkA-1; Fri,
 24 Jul 2026 04:49:55 -0400
X-MC-Unique: XlpKofWIOLuFLAd1VRJNkA-1
X-Mimecast-MFC-AGG-ID: XlpKofWIOLuFLAd1VRJNkA_1784882993
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4C6618011FA; Fri, 24 Jul 2026 08:49:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63BD91954226; Fri, 24 Jul 2026 08:49:48 +0000 (UTC)
Date: Fri, 24 Jul 2026 09:49:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
Message-ID: <amMnKWlFFi56kFdQ@redhat.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
 <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
 <87se59r999.fsf@draig.linaro.org>
 <c16b4480-06fd-4d96-b628-5c423d300988@oss.qualcomm.com>
 <87mrvhr3co.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mrvhr3co.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 23, 2026 at 07:02:47PM +0100, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
> > On 7/23/2026 8:55 AM, Alex Bennée wrote:
> >> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> >> 
> >>> On 7/20/2026 6:14 AM, Alex Bennée wrote:
> >>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> >>>>
> >>>>> Those options were useful a few years ago, before containers were
> >>>>> available as an alternative for missing cross compilers. Simplify the
> >>>>> workflow by removing those options and maintaining only the container
> >>>>> based approach.
> >>>>
> >>>
> >>> I was expecting some discussion around this patch, and to start it when
> >>> the comment comes. Question is "Should we provide this feature or not?".
> >>> I totally agree with you that we need to support other configurations we
> >>> have in our CI, like MacOS and compilers from homebrew.
> >>>
> <snip>
> >
> > The way I see it is that we offer native cross compilers (with a focus
> > on debian at the moment), and the containerized ones: people have a choice.
> > We can add any additional compiler name for other distros.
> > Also, as Ilya mentioned before, cross compiler on fedora, for instance,
> > are not providing any sysroot. So it makes them unusable in our case.
> 
> No sysroot at all - even for compiler headers? We don't need the linux
> sysroot for building softmmu tests.

Historically that was the case, as the cross compilers primary use case
was kernel / firmware builds, which could be done with "freestanding"
mode and thus no dep on C library.

Since Fedora 40, it appears that in addition to glibc & binutil packages,
there are now sysroot packages shipped for glibc for each Fedora arch:

  https://kojipkgs.fedoraproject.org/packages/glibc/2.39/8.fc40/noarch/

Note those package names change in each release, so latest would be

  sysroot-s390x-fc44-glibc

NB. I've not tried actually using this myself

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


