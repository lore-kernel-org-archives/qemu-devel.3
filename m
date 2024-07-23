Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61231C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAMc-0007TM-D2; Tue, 23 Jul 2024 03:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWAMb-0007PW-G4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWAMY-00031l-Ti
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721721306;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOqszpLocJ4EruD6NhWiw5eEaI1GbnMVogVhwFXV3GE=;
 b=X3Q6c8XEOOz9O8oGUm3KabFyveZvDlwEy4g9Zo7SVnTrAMluw9FKR6BNE6KG5CoXdv74BK
 wmsarPJRjLbSvDTtVCkj5LG+b8ZkMhki6/SuTshdghDijdUchrt+kbLRcrRy9Ux3FmP/Z2
 tmDmc/cfABySlhWy03ijaxAFd+l6Oh4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-5EI_YxNZOriOfYCUucMJXQ-1; Tue,
 23 Jul 2024 03:55:03 -0400
X-MC-Unique: 5EI_YxNZOriOfYCUucMJXQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1D451955D4C; Tue, 23 Jul 2024 07:55:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F3A0195605A; Tue, 23 Jul 2024 07:54:58 +0000 (UTC)
Date: Tue, 23 Jul 2024 08:54:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4] osdep: add a qemu_close_all_open_fd() helper
Message-ID: <Zp9hz0NsHTWZD6dt@redhat.com>
References: <20240717124534.1200735-1-cleger@rivosinc.com>
 <c2085e4c-d2af-4ea1-9a04-f523c94a7315@linaro.org>
 <7aadff15-3939-4e0f-a81a-84f78521a8a1@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aadff15-3939-4e0f-a81a-84f78521a8a1@rivosinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Tue, Jul 23, 2024 at 09:16:15AM +0200, Clément Léger wrote:
> 
> 
> On 23/07/2024 08:24, Philippe Mathieu-Daudé wrote:
> > Hi Clément,
> > 
> > On 17/7/24 14:45, Clément Léger wrote:
> >> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
> >> POSIX"), the maximum number of file descriptors that can be opened are
> >> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
> >> of 1073741816 file descriptors. Now, when forking to start
> >> qemu-bridge-helper, this actually calls close() on the full possible file
> >> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
> >> takes a considerable amount of time. In order to reduce that time,
> >> factorize existing code to close all open files descriptors in a new
> >> qemu_close_all_open_fd() function. This function uses various methods
> >> to close all the open file descriptors ranging from the most efficient
> >> one to the least one. It also accepts an ordered array of file
> >> descriptors that should not be closed since this is required by the
> >> callers that calls it after forking.
> >>
> >> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> ----
> > 
> > FYI git tools parse 3 '-', not 4.
> 
> Hi Philippe,
> 
> Thanks for the info, I was not aware of that ! I'll use 3 '-' from now on.
> 
> > 
> >> v4:
> >>   - Add a comment saying that qemu_close_all_fds() can take a NULL skip
> >>     array and nskip == 0
> >>   - Added an assert in qemu_close_all_fds() to check for skip/nskip
> >>     parameters
> >>   - Fix spurious tabs instead of spaces
> >>   - Applied checkpatch
> >>   - v3:
> >> https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/
> > 
> > 
> >> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
> >> +{
> >> +    int open_max = sysconf(_SC_OPEN_MAX);
> >> +    unsigned int cur_skip = 0;
> >> +    int i;
> >> +
> >> +    assert(skip != NULL || nskip == 0);
> >> +
> >> +    if (qemu_close_all_open_fd_close_range(skip, nskip)) {
> >> +        return;
> >> +    }
> >> +
> >> +    if (qemu_close_all_open_fd_proc(skip, nskip)) {
> >> +        return;
> >> +    }
> >> +
> >> +    /* Fallback */
> >> +    for (i = 0; i < open_max; i++) {
> >> +        if (cur_skip < nskip && i == skip[cur_skip]) {
> >> +            cur_skip++;
> >> +            continue;
> >> +        }
> >> +        close(i);
> >> +    }
> >> +}
> > 
> > Build failure on windows:
> > 
> > ../util/osdep.c: In function 'qemu_close_all_open_fd':
> > ../util/osdep.c:725:20: error: implicit declaration of function
> > 'sysconf'; did you mean 'swscanf'? [-Wimplicit-function-declaration]
> >   725 |     int open_max = sysconf(_SC_OPEN_MAX);
> >       |                    ^~~~~~~
> >       |                    swscanf
> > ../util/osdep.c:725:20: error: nested extern declaration of 'sysconf'
> > [-Werror=nested-externs]
> > ../util/osdep.c:725:28: error: '_SC_OPEN_MAX' undeclared (first use in
> > this function); did you mean 'FOPEN_MAX'?
> >   725 |     int open_max = sysconf(_SC_OPEN_MAX);
> >       |                            ^~~~~~~~~~~~
> >       |                            FOPEN_MAX
> > ../util/osdep.c:725:28: note: each undeclared identifier is reported
> > only once for each function it appears in
> > 
> 
> Should I move this chunk of code in oslib-posix.c and stub that function
> for win32 ? It seems like this code was not built for windows before I
> added it in osdep, which means it is not needed for win32.

Yes, I think that'll be OK. The fork/exec concept isn't present on Windows
so we also don't need to close all FDs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


