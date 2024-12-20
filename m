Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF280E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfsM-0000az-BE; Fri, 20 Dec 2024 11:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOfsJ-0000T9-Sy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOfsD-0001uz-1Z
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734712147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8FbVRVMEjxC5D2fM+4aahxzeV63aPJwexQS9Oil2cQ=;
 b=O8vuL7MzPsVtZYUY7yqyT9GQ4ox1Tk2HSvq8XVK6oPj+otfbsIMEFjhEjuqgJn9qhnU6xg
 HIQkdk9o0+K3K1Ucq5/8zSjMiWtqU37cDEyo6Y+/cSumtLwD8Y0Er9AjDAQO7emSOZVNFB
 Gsk1IDZfo6Qe8IwG1PeQ2MAXxERS7ck=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-baP6IQaJOCmuGIshNWCl9Q-1; Fri, 20 Dec 2024 11:29:04 -0500
X-MC-Unique: baP6IQaJOCmuGIshNWCl9Q-1
X-Mimecast-MFC-AGG-ID: baP6IQaJOCmuGIshNWCl9Q
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e23e2b8fso183029985a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734712143; x=1735316943;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8FbVRVMEjxC5D2fM+4aahxzeV63aPJwexQS9Oil2cQ=;
 b=vFviYejFBM8YgRqYd0Mf5e+lxQodaseaU4PgEDbjJkLoTd/O3INOohgxFwkSTRe2Y0
 sZQN3jAcUMS8CpECgfAix52+cwXY59LxLOXlcvud1DyKdaSiqhVkZlcjZwXrw6diZoi4
 cnnEJnX0GysWuLHYJiJkkbkhIDzSk5xCrznVU3PLu/kt8tFhyTgq3Lxjo7whnUB1QgcW
 l09BjeSWRQPDmJDRPTOsFeMzA1FoKnlz3qTRhAseH50DTyDH14vO2+xrAo7Y24qUHM07
 ndyvgF6kMkneyHblV2o4BUZhTHb3kUe91+brWcelL1TVZXzH4Hr/lc/ONbK5bkpgbDQo
 qVQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Dr4kHlhjElpIBWm9ckY5C+Q0/uDP8yqGyFDEd//SbkX/wlXv0txMhbp1mmvxd1AxKw6LlaswgD+5@nongnu.org
X-Gm-Message-State: AOJu0YxSzgRq20HrTwUYZjo0+Sq5R5dGYN1xjJld2c6Gd20Ql3pS5GL5
 kIyfMQ+lTzOgMqVrd5jEYW5eFL6sDUWBlp8PgfumLonfuT2FD5+8OTqDqp4JIr/8pIiU/xBMxam
 g2WPhwpMYkKgGC4YM5af/vNmc3Rkpk1VWBLfY6gDR5VCcYE7Zqb29JK+uaZoM
X-Gm-Gg: ASbGnct/hSeFyDHdcsrX0Ydj5SzA23bjNd0Dj6pfe7NHgextFbiRLvQM1FmhtbJU4RL
 cVVZzyB2Pm92PdWfVAIQvBnWzqA1VnEoYuX41q6dPVmUmpBNqc+av9aK3tJHnnfThp0F5e796cH
 EEQzcd/Cg3Ss+NHtbCqHuHuhISTWtmcje1qNLoJAXwAzpbUz7l2xjircsu4sKDdO08uSbyqKdde
 zXX2pvZPRsT1ylfHYAffOGp931gnNwHurwsLLnaT+vQPAOZ3KxphpniCK3ZNpFv6v9yvn0K7rpd
 zV26IwjkUREQh32BtA==
X-Received: by 2002:a05:620a:4551:b0:7b6:6c46:55b with SMTP id
 af79cd13be357-7b9ba6efbbamr583057185a.7.1734712143302; 
 Fri, 20 Dec 2024 08:29:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgjgw4CBH1PpnAHpctemJhEoid/wsG5W16faxSC3wzrkewLhRsd4dsci7k0BHS+gqOWMuU2Q==
X-Received: by 2002:a05:620a:4551:b0:7b6:6c46:55b with SMTP id
 af79cd13be357-7b9ba6efbbamr583042385a.7.1734712141501; 
 Fri, 20 Dec 2024 08:29:01 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2d1561sm149914485a.31.2024.12.20.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 08:29:00 -0800 (PST)
Date: Fri, 20 Dec 2024 11:28:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
Message-ID: <Z2WbSZkEGSnA-BX9@x1n>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfkrtsgt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > Hi Fabiano,
> > Please take a look at this CI failure:
> >
> >>>> MALLOC_PERTURB_=61 QTEST_QEMU_BINARY=./qemu-system-s390x UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_IMG=./qemu-img MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> > ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> > stderr:
> > Traceback (most recent call last):
> >   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
> >     dump.read(dump_memory = args.memory)
> >   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
> >     section.read()
> >   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
> >     field['data'] = reader(field, self.file)
> >   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
> >     for field in self.desc['struct']['fields']:
> > KeyError: 'fields'
> 
> This is the command line that runs only this specific test:
> 
> PYTHON=/usr/bin/python3.11 QTEST_QEMU_BINARY=./qemu-system-s390x
> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
> 
> I cannot reproduce in migration-next nor in the detached HEAD that the
> pipeline ran in (had to download the tarball from gitlab).
> 
> The only s390 patch in this PR is one that I can test just fine with
> TCG, so there shouldn't be any difference from KVM (i.e. there should be
> no state being migrated with KVM that is not already migrated with TCG).
> 
> > warning: fd: migration to a file is deprecated. Use file: instead.
> > warning: fd: migration to a file is deprecated. Use file: instead.
> 
> This is harmless.
> 
> > **
> > ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0)
> > (test program exited with status code -6)
> 
> This is the assert at the end of the tests, irrelevant.
> 
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
> >
> > If you find this pull request caused the failure, please send a new
> > revision. Otherwise please let me know so we can continue to
> > investigate.
> 
> I don't have an s390x host at hand so the only thing I can to is to drop
> that patch and hope that resolves the problem. @Peter, @Thomas, any
> other ideas? Can you verify this on your end?

Cannot reproduce either here, x86_64 host only.  The report was from s390
host, though.  I'm not familiar with the s390 patch, I wonder if any of you
could use plain brain power to figure more things out.

We could wait for 1-2 more days to see whether Thomas can figure it out,
hopefully easily reproduceable on s390.. or we can also leave that for
later.  And if the current issue on such fix is s390-host-only, might be
easier to be picked up by s390 tree, perhaps?

In all cases, the regression is since 9.1, so maybe we don't need to rush
anything in.

-- 
Peter Xu


