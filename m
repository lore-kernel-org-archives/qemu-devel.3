Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC62DC369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4df4-0007l7-07; Tue, 15 Apr 2025 06:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4df1-0007jB-L8
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4dez-0002VJ-Qe
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744713414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxZmAGB88xGyzYz9cAltPUYuEmyUD+UQnZxn1q1o0sQ=;
 b=NvDIazO4GO4+arv0ez+d9SlGezVWNiXCQw+lMROrykp0CCwBiuF1yFvf/hdCXuTDzYo1A2
 Khz88amsIRqH9nInQ7dcVku6WprCTfs0Xp5wGUoSA33NcunwSjoptdDlBo8Urg/U8F1y3z
 5CKbfgLMMxy9OydpyQ2Gslj7LUf6f9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-KB42wOXRM62YDmNM0HVWOw-1; Tue,
 15 Apr 2025 06:36:53 -0400
X-MC-Unique: KB42wOXRM62YDmNM0HVWOw-1
X-Mimecast-MFC-AGG-ID: KB42wOXRM62YDmNM0HVWOw_1744713412
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0EDD180AF57; Tue, 15 Apr 2025 10:36:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E0CD19560AD; Tue, 15 Apr 2025 10:36:49 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:36:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] tests/functional: add memlock tests
Message-ID: <Z_42vZhXelZyFJRo@redhat.com>
References: <20250415090854.71526-1-dtalexundeer@yandex-team.ru>
 <Z_4k7DEDiiaznG2q@redhat.com>
 <7c63f352-4ef0-4e1e-b95e-8e3e586799dd@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c63f352-4ef0-4e1e-b95e-8e3e586799dd@yandex-team.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 15, 2025 at 03:27:29PM +0500, Alexandr Moshkov wrote:
> 
> On 4/15/25 14:20, Daniel P. Berrangé wrote:
> > On Tue, Apr 15, 2025 at 02:08:55PM +0500, Alexandr Moshkov wrote:
> > > Add new tests to check the correctness of the `-overcommit memlock`
> > > option (possible values: off, on, on-fault) by using
> > > `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
> > > anonymous segments:
> > > 
> > > * if `memlock=off`, then Locked = 0 on every anonymous smaps;
> > > * if `memlock=on`, then Size, Rss and Locked values must be equal for
> > > every anon smaps where Rss is not 0;
> > > * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
> > > smaps and anonymous segment with Rss < Size must exists.
> > How are you running this test ?  Unprivileged users don't get to
> > lock any non-trivial amount of memory by default, and QEMU functional
> > tests pretty much exclusively get run as an unprivileged user account.
> > 
> > This test immediately fails when run:
> > 
> >    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
> > 	Exit code: 1
> > 	Command: ./build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -overcommit mem-lock=on
> > 	Output: qemu-system-x86_64: mlockall: Cannot allocate memory
> >          qemu-system-x86_64: locking memory failed
> > 
> > and we don't expect users to run anything as root.
> > 
> Hello, thanks for reply! Looks like i have a larger amount of memory for
> locking in my system:
> 
> > ulimit -l
> 4063912
> 
> I think that's why this test was successfully running on my system.

In Fedora this limit is set to 8192, and GitLab CI has it set
the same.

> Honestly,Idon't know yet how to solve this problem properly. Ithink the only
> ways is to runas root (whichis a bad idea)ortoincrease limits on an
> unprivileged user account by using /etc/security/limits.conf.

Add a new decorator "skipLockedMemoryTest()" to:

  tests/functional/qemu_test/decorators.py

with the decorator accepting an amount of required locked memory in KB, and
checking it against the current user ulimits. That will make the tst do
the right thing and skip execution of insufficient locked memory is
available.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


