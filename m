Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A07FD2ECF9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 07:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi6bT-0007ZF-Th; Tue, 20 Jan 2026 02:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi6bS-0007YK-5I
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 02:56:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi6bP-0006gO-Q0
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 02:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768895798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6adkZkyD2Tj5z9uefJ///44UUY51zMX0hMMapuY2rA=;
 b=ETqcm6G0ga/0j/q6hcao+/EW59In4VjaFIGOW5oyFZSW6CGK1pXCbm5DTJ2NaPLLCWYDZo
 ffNWRP4Y7fAstZnKn5W8NUsgxwQn3Q240QrwYxDGYU0yQoWmwjuZWw3OrhrT9DIjBX/ECA
 j7KJFHiEJNMuOOnEPAOJ/Hh8nFNlsfA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-mB-HrmjnMTikJ58_FLP_6g-1; Tue, 20 Jan 2026 02:56:36 -0500
X-MC-Unique: mB-HrmjnMTikJ58_FLP_6g-1
X-Mimecast-MFC-AGG-ID: mB-HrmjnMTikJ58_FLP_6g_1768895795
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso46917065e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 23:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768895795; cv=none;
 d=google.com; s=arc-20240605;
 b=iX1svRnFFt+5aYJ9nUy4XJKYAAzXTT8PWWip8eChNJPkVri2Ug9LLkSS97schiqRBr
 gk/csKRPsc376bszP2Owj55rfiOTJ6Ipaozc9EX+ngk1i7G2DETAXX2Lr3lzHtW9psej
 fzYA3Z0oZ+w0+4H7ic9rYyw70uuLCv44V4Az5+za2rS7vsHCYtqb72qT2/lqDvTHLrVG
 pm7G38cvW6VJplyvgNOPifKz2oHrWJboAxkDtVflqETwTosPb6OO/pvuTcKidA718uvK
 ZV1HIvOOvc5ixI4gn5Bk/qVUIoaiZcerruk97d7UF0be8i0ij22HyiJkKOpqTLrgAMT1
 IE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l6adkZkyD2Tj5z9uefJ///44UUY51zMX0hMMapuY2rA=;
 fh=ANMLY+vUlDJOw2PdV6/55gZrkEUXmI3oVt0AZ2Stn1s=;
 b=adbSleWwnEGCpB7X7RkSerWWefAcmPA2dHFWe71BYXhon6z9XA+t/e6Lf/0O4lv19Z
 QbEYlN9os2mBBs8juUbiGR/KhPbmWTI/qaDb+UwhgrGvwy+iKx5Gi60qDKDDB1z5wgBt
 sHlTvi/GjEUoX3jSDTNT9OLBqu5A5RaKVu+EaOCXDLcy596g6YYJNzG7fCBdcpQV66WS
 jk6mgJ+AHIDvBgECtE3ho92Wd1bM+kGfEsEa8ei3EH6X3h+zo9mNle7MQIQgTBWevnyL
 2FPilSVL1L/7vT92EgrQH5BRqiNpKeEK1cfh8ZVZeADXy+r3Ljz9aWL9SKKHbdykanGS
 pxjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768895795; x=1769500595; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l6adkZkyD2Tj5z9uefJ///44UUY51zMX0hMMapuY2rA=;
 b=lxZEwRnX/YHy6zOwll7mviuuofwUzP9/IlXtuSqrN4ra2c36vula+EtoD46p3lffMX
 nqT/TAQ6vThYszSA+z/GFp5XaCGufn6k6ZL6qw9nl8Ikq5EnClZSZD4HRwqRuyLGkWNK
 ksO20Ra/OZ9/VzQfiqRJ+fu/lasgjahnpUfCHZWm+yF0PCaHalzxjXtOQQvDyUaZsR37
 Cu8XCsXjZexTNXoY13VhCKnFhLWKhTZPTGAcT9uNp9WhkefLfFLtlYk9HvcY5hPuIqvg
 K2qd30kaEfmMZsEU8w1TuEK5zQa07BBJtmBhF0iNf8Q+JjABbRXMw7JU5GLzHRnF5LZc
 2kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768895795; x=1769500595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6adkZkyD2Tj5z9uefJ///44UUY51zMX0hMMapuY2rA=;
 b=ZjQRA13BUBiMje3IJ0JP3Lp6UA4nBp4tA8oKktrvnmmk6cIubDow6NoR2OM6SIz2FP
 ybcM9WlC7L6h1Cn4jA1mPr/fb0ZAcAzPpoB+rVedv7No/tV8Dmg+scK/+EpkxEsjQJp4
 Vg7fm5KEVKyC09jWywtW+WDgL/qWBnnwQ1P59eqRi+uFs7LF6gT76zMJ+FBy8GuVN9Qy
 KpbrBYJ7XsDqOYCJWLg/5grVhFZ+sZ6BuPJJHjE4TTQizMFwfMMB6b0MlSDdtouZjTeO
 DOm9z8TkOtpUFCsRGrPFA9TrCnQtv0UX7xqE6YR+Fjj+eiv7RL+RA2k34IsTEBc/JpWx
 UuVw==
X-Gm-Message-State: AOJu0Yxs2dDq6shd+z84qpcT+qdL+0USGrAiE6m+a3L6145+18pWObFr
 04N/kGwYQVfBBuJsMgB4eMyg5kGU+JEuexkpoI2uIiKaRafNtwf1u/YZrhZ6cUf4wW31ZOpxl07
 +m6Dr0ub+XoIOX5PS1sKdWrbVY62PJCxeE1FYyZfgoDuVFjXpnu9HGShLNlbaCLdz6F3cerSgwm
 61GM4JFo55piVpNHXDf5iv2uwqxKWkj6k=
X-Gm-Gg: AY/fxX4YsFmbHUIJk8WLmhMCbsl9rycqzLXWIVd7z357lgJj3fGYwGg+3xa+LOT3VAw
 GarMO8si/xJSpw8g+Q2b3gP8TCNUIfTd2HQxXygLBXNgslO+RCxI58ndEpdRWy/fbJgkxvFO2Vy
 1NCJiM/ruKI5FBdVIntwgAQauToYCT+HEltd9aGSojlzHHbxbNnEnvUShPPBt/eRYcURyT4NPZc
 pX3fxJK1Veyi10vtwT3jA/vaVlD/xalouYvV+O0F932lxDFYVu4zFRQ
X-Received: by 2002:a05:600c:1990:b0:480:3b26:82c3 with SMTP id
 5b1f17b1804b1-4803e7e819dmr10461595e9.20.1768895794776; 
 Mon, 19 Jan 2026 23:56:34 -0800 (PST)
X-Received: by 2002:a05:600c:1990:b0:480:3b26:82c3 with SMTP id
 5b1f17b1804b1-4803e7e819dmr10461435e9.20.1768895794318; Mon, 19 Jan 2026
 23:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20260109123519.28703-1-farosas@suse.de>
 <20260109123519.28703-3-farosas@suse.de>
In-Reply-To: <20260109123519.28703-3-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 13:26:17 +0530
X-Gm-Features: AZwV_QhmFWYQ4fqsX-75-H_ASUIOel5Aacn4ubyz2hTnuOGE1EqtK-5UTmDnQvU
Message-ID: <CAE8KmOydo3r7x1AMWyO3hYEqrN5+XxHuz0y9OYNJc4nPMWq2DA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tests/functional: Add a OS level migration test
 for pseries
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, peterx@redhat.com, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 9 Jan 2026 at 18:06, Fabiano Rosas <farosas@suse.de> wrote:
> There's currently no OS level test for ppc64le. Add one such test by
> reusing the boot level tests that are already present.
>
> The test boots the source machine, waits for it to reach a mid-boot
> message, migrates and checks that the destination has reached the
> final boot message (VFS error due to no disk).
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/functional/ppc64/test_migration.py | 12 ++++++++
>  tests/functional/ppc64/test_pseries.py   | 35 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
> index 5dfdaaf709..a3b819680b 100755
> --- a/tests/functional/ppc64/test_migration.py
> +++ b/tests/functional/ppc64/test_migration.py
> @@ -4,6 +4,7 @@
>  #
>  # ppc migration test
>
> +from qemu_test.ports import Ports
>  from migration import MigrationTest
>
>
> @@ -21,6 +22,17 @@ def test_migration_with_exec(self):
>          self.set_machine('mac99')
>          self.migration_with_exec()
>
> +    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            uri = 'tcp:localhost:%u' % port

* When port is None, shouldn't it return after the skipTest() call?
With port = None, uri will become -> 'tcp:localhost:None' OR maybe
port should have default value?

> +            dest_vm.qmp('migrate-incoming', uri=uri)
> +            source_vm.qmp('migrate', uri=uri)
> +            self.assert_migration(source_vm, dest_vm)
> +
>
>  if __name__ == '__main__':
>      MigrationTest.main()
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index 7840c4e3ff..b45763c305 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -9,6 +9,7 @@
>
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import wait_for_console_pattern
> +from test_migration import PpcMigrationTest
>
>  class PseriesMachine(QemuSystemTest):
>
> @@ -87,5 +88,39 @@ def test_ppc64_linux_big_boot(self):
>          wait_for_console_pattern(self, console_pattern, self.panic_message)
>          wait_for_console_pattern(self, self.good_message, self.panic_message)
>
> +    def test_ppc64_linux_migration(self):
> +        self.set_machine('pseries')
> +
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> +
> +        dest_vm = self.get_vm(name="dest-qemu")
> +        dest_vm.add_args('-incoming', 'defer')
> +        dest_vm.add_args('-smp', '4')
> +        dest_vm.add_args('-nodefaults')
> +        dest_vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        dest_vm.set_console()
> +        dest_vm.launch()
> +
> +        source_vm = self.get_vm(name="source-qemu")
> +        source_vm.add_args('-smp', '4')
> +        source_vm.add_args('-nodefaults')
> +        source_vm.add_args('-kernel', kernel_path,
> +                           '-append', kernel_command_line)
> +        source_vm.set_console()
> +        source_vm.launch()
> +
> +        # ensure the boot has reached Linux
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message,
> +                                 vm=source_vm)
> +
> +        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
> +
> +        # ensure the boot proceeds after migration
> +        wait_for_console_pattern(self, self.good_message, self.panic_message,
> +                                 vm=dest_vm)
> +
>  if __name__ == '__main__':
>      QemuSystemTest.main()
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


