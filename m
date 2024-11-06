Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7160D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fMs-0005KW-Bj; Wed, 06 Nov 2024 07:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fMo-0005HQ-Qn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fMk-0002f2-VN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730896949;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wf+at1j/9hoESX6cYWJ+T8//wb21r6QBuS1vGJBwp1g=;
 b=A6B1ayYFahJJOlF8BJlBV+R4zaaSyw9PbjDgB9vKRQq3rlkxftl01cESMJZqXuikMd7LAd
 ZPAXnF0sG1UrZ0giI9IuTUXQX8gcCFuGXadkw17jL3lRFE68c0DNNzlGJ9LmgLPFEBz7Pn
 ewkhBfPgDTctEn3wI39OKT7WyVVd27c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-wGIewnNcMBuqZSZueThGfQ-1; Wed,
 06 Nov 2024 07:42:27 -0500
X-MC-Unique: wGIewnNcMBuqZSZueThGfQ-1
X-Mimecast-MFC-AGG-ID: wGIewnNcMBuqZSZueThGfQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5452919560A6; Wed,  6 Nov 2024 12:42:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.180])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 918D71955F40; Wed,  6 Nov 2024 12:42:23 +0000 (UTC)
Date: Wed, 6 Nov 2024 12:42:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 21/22] tests/qtest: Add support for check-qtest-<subsystem>
Message-ID: <ZytkK6p3gff8bCVY@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-22-farosas@suse.de>
 <ZytO8SLDAT2VRjly@redhat.com> <87pln81qoa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pln81qoa.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 06, 2024 at 09:40:21AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Nov 05, 2024 at 03:08:36PM -0300, Fabiano Rosas wrote:
> >> Allow qtests to be ran by subsystem. Some subsystems, such as
> >> migration, have a large number of tests and we could benefit from
> >> being able to access them from make check without having to run the
> >> full set of qtests.
> >> 
> >> This adds the following make check targets:
> >> 
> >> make check-qtest-migration
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> I did not include check-qtest-<arch>-<subsys> because meson generates a
> >> long line that affects readability.
> >
> > Can you give an example of that ?  I'm wondering how much of a
> > problem it actually is ? Personally when I'm running a subset
> > of tests, I almost always want to limit to just one arch target.
> >
> 
> Ok, you have a different use case, mine is just "run migration tests for
> all archs, without bringing all the rest of qtest along". When I want to
> limit to one arch, I use the 'QTEST_QEMU_BINARY=qemu-system-<arch>
> migration-test' syntax.
> 
> The issue is that meson always shows all suites in which a test is
> present (quite uselessly IMO):

Ewwww, yes, that's pretty horrific :-( Very annoying behaviour, as it
actively discourages people from adding more suites :-( I agree with
your decision.

> 
> [1-8/8] 🌑 qemu:qtest+qtest-s390x+qtest-migration+qtest-s390x-migration / qtest-s390x/migration-test                              0/480
> 1/8 qemu:qtest+qtest-x86_64+qtest-migration+qtest-x86_64-migration / qtest-x86_64/migration-test-smoke           SKIP             0.02s
> 
> vs:
> 
> 1/8 qemu:qtest+qtest-x86_64+qtest-migration / qtest-x86_64/migration-test-smoke          SKIP             0.02s
> 2/8 qemu:qtest+qtest-ppc64+qtest-migration / qtest-ppc64/migration-test                  SKIP             0.02s
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


