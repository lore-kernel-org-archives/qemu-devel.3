Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFC9CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERgq-00023W-2z; Wed, 07 Oct 2026 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xERgT-000217-E7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xERgQ-0001qO-R4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791379665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jy15Kr4sjtoYQF06amY55/UjTpIN+oIKG5ps7iCdezU=;
 b=Hb8k7KwY4RBUT+ceR14rzIl3wUBh+vzpA97ylEYslcJXLJoiHFhv5d5e0ONgCZmuG53RgP
 D9eyTQp1XNObieEtQFjFg+oNqlVH6Py9pkEsqsJU9FrnI+eBRWPRB/GKPHExlnMTOUq7sU
 eBxD0KCm6qp1qzn8Xnf5HeZa95Qrjek=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-6jGdvsFWNouSGQB86qRa-g-1; Wed, 07 Oct 2026 09:27:44 -0400
X-MC-Unique: 6jGdvsFWNouSGQB86qRa-g-1
X-Mimecast-MFC-AGG-ID: 6jGdvsFWNouSGQB86qRa-g_1791379664
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939c30aa9a0so476560885a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791379664; x=1791984464; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jy15Kr4sjtoYQF06amY55/UjTpIN+oIKG5ps7iCdezU=;
 b=ZTxzSpDvnOSj1iYkCYs4SznWxk7vN0Dck3sgJBGJXYl7eSy/k5k9VJAkg8GdEp/9Dd
 wqVAviqVMa+/z/+8mzyVeUlSs/qNDf4+dXewaPJr3KMiOsEcyDNwUaU/n/0oPc2i73z0
 x+YA5IcCTy7/RFp9tbxJDZ32xBOsC90LO5eXUYihJnFPVqD9Yk8PYdA2ceOW+Gj7e5ez
 /q6myRskLSBoLjWrdVSFPcTfyc7lHXiASl/m8+nXA7fdY/smV87lBSzHH7kboDvK8QC9
 e7XdwHFvsWk8E1zQizfe1hhroZ2ATXsDsvB+yLjwnuE85JZWM5jSPyn9KKv8kYL8luWC
 6Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379664; x=1791984464;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jy15Kr4sjtoYQF06amY55/UjTpIN+oIKG5ps7iCdezU=;
 b=QkShM89qqcvxSyA/OFeYRI7ovChOcrXRJWluIUvqP5izwF6jqUwStSxVNGaPiFX4ar
 VbIQBJVDN0hhSggRdiVB+RoQaKMJ0p2DFcawDRpT8wKiTOahU19h+sL5wqyXMtDrZxsv
 p520xLzLw79ifiRBIixsCe4F/IZYKG2+ThG3GnYVFCi6nX6jUd4qZfOifYOq3/o8E2s/
 vL+jp5iVXfJ2HjmyyQ5uCLh4ObldCs5vhNDzkcMusMkkZdMeMraG7YmNYTRsvzSn870X
 FrWoSpR2CKuwsBtQF1BpF8aqajIgqjDjUyQsByZh/VnKW85i7xogQS1JWqLvpLaVxbWy
 wsPg==
X-Gm-Message-State: AFuF++mvzyPAH/qfh1tTeKyyI+d8HPjmyqUUFpbeFQ1RrGOpOPpFxtln
 rWK2vWKLSsxoVY6y+aCx+jGdAbALHa/IDVhTAktP7OaBlB/lodLp4aVrxVHohteYdSU74vbwVhb
 sbhphxeoAMwv9uCMd8db5vovp1bBST3RlkpaSMQtJ1ZQaegWAeHuKZ5e3
X-Gm-Gg: AYBFou19mIRF8F9pmzp/dJ2x5B657IFShCO3wSHud6DVA/wWfJLDE7b/zId0lf/uYQ/
 COxFmgRp4qS8Gd9+uN9e53S8XxgONmRA10f43PLYV+KpEdr+xcec3c4ab/53K5tKs9jnXViVXlt
 cIzsnxrIVu/Rqp/OP8IuKJ5TGwnwUsDU8eDqTfFJw/IzBgWp5RS/Ojpv6+Kl7tLTp/Fc77V6QZL
 iPMaLUQVCQVAcG0QC40HmpEEOT8P8Raq251C5YmHfnVpTHCXhJaz4DNUEdJPkWii8crIhJAfKq3
 WPMsiKTWVqZYPqRBeafLPwRL92wW/S8D2LnjWYEVn5z/0dYmQPwKXbPwGgZoOMJltofngC0=
X-Received: by 2002:a05:620a:43aa:b0:93e:910c:5e65 with SMTP id
 af79cd13be357-93e9b7c6dcfmr442309885a.49.1791379663524; 
 Wed, 07 Oct 2026 06:27:43 -0700 (PDT)
X-Received: by 2002:a05:620a:43aa:b0:93e:910c:5e65 with SMTP id
 af79cd13be357-93e9b7c6dcfmr442302885a.49.1791379662730; 
 Wed, 07 Oct 2026 06:27:42 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e98f6b4basm217156085a.6.2026.10.07.06.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:27:41 -0700 (PDT)
Date: Wed, 7 Oct 2026 09:27:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:nvme" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
Message-ID: <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921190345.1709227-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, Sep 21, 2026 at 08:03:45PM +0100, Alex Bennée wrote:
> This is a hacky patch for comment but I've included the diagnostic
> hacks to the migration test as well as my workaround to get itworking.
> 
> This test was failing on my KVM system. On investigation I found the
> nVME activity meant the migration never completed. I ended up
> inserting some sleeps into the workload script until I was able to
> get it to run.

Indeed, I can reproduce it too:

$ ./run ../tests/functional/x86_64/test_nvme_migration.py X8664NVMeMigrationTest.test_migration_with_unix
TAP version 13
Traceback (most recent call last):
  File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.py", line 162, in test_migration_with_unix
    self.migration_with_unix()
    ~~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/home/zhexu/git/qemu/tests/functional/migration.py", line 98, in migration_with_unix
    self.migrate(dst_uri)
    ~~~~~~~~~~~~^^^^^^^^^
  File "/home/zhexu/git/qemu/tests/functional/migration.py", line 78, in migrate
    self.migrate_vms(dst_uri, src_uri, dst_vm, src_vm)
    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/zhexu/git/qemu/tests/functional/migration.py", line 63, in migrate_vms
    self.assert_dest_vm(dst_vm)
    ~~~~~~~~~~~~~~~~~~~^^^^^^^^
  File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.py", line 128, in assert_dest_vm
    self.exec_command_and_check(
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
        "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/zhexu/git/qemu/tests/functional/x86_64/test_nvme_migration.py", line 48, in exec_command_and_check
    wait_for_console_pattern(self, 'OK', failure_message="FAIL", vm=vm)
    ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 191, in wait_for_console_pattern
    return _console_interaction(test, success_message, failure_message,
                                None, vm=vm)
  File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 134, in _console_interaction
    done, line = _console_read_line_until_match(test, vm,
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
                                                success_message_b,
                                                ^^^^^^^^^^^^^^^^^^
                                                failure_message_b)
                                                ^^^^^^^^^^^^^^^^^^
  File "/home/zhexu/git/qemu/tests/functional/qemu_test/cmd.py", line 70, in _console_read_line_until_match
    test.fail(
    ~~~~~~~~~^
        f"'{failure}' found in console, expected '{success}'")
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError: 'b'FAIL'' found in console, expected 'b'OK''

not ok 1 test_nvme_migration.X8664NVMeMigrationTest.test_migration_with_unix
1..1

Copy the author too (Alexander).

> 
> *NOTE*: obviously this can't be merged as is but I think we could
> certainly do with more tracking in the test to see when things aren't
> working with possibly the sleep as another patch.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/functional/migration.py                 | 37 +++++++++++++++----
>  .../functional/x86_64/test_nvme_migration.py  |  1 +
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 8d2428efc24..e51a82c22f4 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
>      timeout = 10
>  
>      @staticmethod
> -    def migration_finished(vm):
> -        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
> +    def migration_finished(query):
> +        return query['status'] in ('completed', 'failed')
>  
> -    def assert_migration(self, src_vm, dst_vm):
> +    def wait_for_vm(self, src_or_dst, vm):
> +        "Track the state of one VM in the migration"
> +        current_state = last_state = vm.cmd('query-migrate')
>  
> -        end = time.monotonic() + self.timeout
> -        while time.monotonic() < end and not self.migration_finished(src_vm):
> -            time.sleep(0.1)
> +        self.log.info(f"waiting for {src_or_dst} to complete")
>  
>          end = time.monotonic() + self.timeout
> -        while time.monotonic() < end and not self.migration_finished(dst_vm):
> +        while time.monotonic() < end:
> +            if self.migration_finished(current_state):
> +                break
> +            else:
> +                last_remain = last_state['remaining']
> +                current_remain = current_state['remaining']
> +
> +                if current_remain > last_remain:
> +                    self.log.warning(f"slow migration {current_remain} > {last_remain}")
> +
>              time.sleep(0.1)
> +            last_state = current_state
> +            current_state = vm.cmd('query-migrate')
> +
> +
> +    def assert_migration(self, src_vm, dst_vm):
> +
> +        self.wait_for_vm("src", src_vm)
> +
> +        # if we hit this we never completed...
> +        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> +
> +        self.wait_for_vm("dst", dst_vm)
> +
> +        self.log.info("checking everything is OK")
>  
>          self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
>          self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
> diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
> index 890f0aab6d6..58596f63cd3 100755
> --- a/tests/functional/x86_64/test_nvme_migration.py
> +++ b/tests/functional/x86_64/test_nvme_migration.py
> @@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
>                  rm -f /tmp/test_nvme_mig_workload.iter_finished; \
>                  echo 3 > /proc/sys/vm/drop_caches; \
>                  find /usr/bin -type f -exec cksum {} \\;; \
> +                sleep 0.3; \
>                  touch /tmp/test_nvme_mig_workload.iter_finished; \
>              done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
>              prompt, vm=vm)
> -- 
> 2.47.3
> 

-- 
Peter Xu


