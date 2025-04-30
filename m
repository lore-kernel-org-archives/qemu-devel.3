Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A03C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAA1I-0000w0-LG; Wed, 30 Apr 2025 12:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAA1B-0000us-Si
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:10:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAA14-0004om-0i
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:10:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224191d92e4so81938665ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746029432; x=1746634232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z3XyIxKPA5V4UlOW9SQ4ZX0E+VyaDz3H99BKPMxbrxA=;
 b=ktRlEEngJoNpXRaNkFBdFBNkQelMYqOTH/YqfO8f+GMJJGjhKEQrvNHvQhYEXRae0Q
 ggDZV73LwAl3qOuzggP5sR1FgjNTb4r2IZuRH9le/LaRKI6IXluAA3zPmDAsDKyL52Dy
 bEnj0aMnIAay5lnas02W2rLOqnEnnC2o0A0+RSRx4zWiWKEYDPKqbxBhlh2oMaEd29NU
 06eU4LdtafpJZzHEbrZE4CsieORoRhgDb0DNaiyLz/uOXmGfUQpj35KGs7ICRVQaR9p1
 Pgb+ZkiX6d2m+Nkn3bcsaLLsLkfr9XUts/+edeRDIfwosqgeM+9wKWoGAiHFiU/ftewN
 e2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746029432; x=1746634232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3XyIxKPA5V4UlOW9SQ4ZX0E+VyaDz3H99BKPMxbrxA=;
 b=VM/0yygv5SHIAgLJyP/RCDmrcr25XHf8A7LLVBnLsktke5diWLLNAL/G9vXw1gUiA4
 yuVy2No/kP5q1y/Rcz18bqPBtyCg1fCjIMVuOwHUpjM7gzbc+6de8wUYr3hunwNM3OLX
 eGHo68sYdkbWn0weYHG9cH6vnNmWtNLg3Nj1lQD8gtILqtN1GgIardvJQsN5v7uUAOIg
 /8Si6uod2VI/o2I3aYPOHEqzWk3WAvhN1Inb4BCmC62LDfcU19x/RVBB3Hle67QNUfOF
 bWdds7BBjS8h+71G1NHs/HD4tU7QTksdAcRkWnuy7TF6tUF3E9+UfomsLuwDGX6U/1Ph
 32SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj27yLFGqXS7zzzY7SUPkJ6lj72sk+vWksZOE7rp+wpp0YOTes4hFotgMRr45umdIgTU2VkzvEgv68@nongnu.org
X-Gm-Message-State: AOJu0YyHO+nQqudZU7rwoJEXCjy+gM1FBF4S1OOaWhs70ewJrY17KCqv
 0d04VILp3A3T8SjT67vQqY1rHc3e4sRtM82eCF0RqvTyi2JFj7skc6R6qr5OL/I=
X-Gm-Gg: ASbGncuw/kehVJDsrbHVuebEqfiqtoSEcCzqUxfGcTv06gSJyCPWhr1GluSmjBzBzER
 gD2pnSeiOWLi/1NOECDae0ktZQAfZf4iyhthAAnBh0w9V9A/QNDwZEyxAC9v9hpryUk0D1mSfl6
 JzbczGO6i8iBYxg80QqeHuHO8Pyu9jT+26QclYzaMIdhC5gdnlWPfB0rRbcRZMo1cCVqLWbyQa1
 Rxtobypr1i/X7WeWbceK3nxY/XhpZBjGnatKF81qxm7iPhFwg/WnS+Zs/yNmtxw1OAKJ2G4LkxT
 MpytvCWdxVN4oAoZXh6zAXXjvez7522ZL8f/274J23x0zGpE16qq2Q==
X-Google-Smtp-Source: AGHT+IFRIjZPAKgFKIjjL0a8SP/amRgggH8rAGl1JxcZ7oFOfmKkc6+eBeh/4ZSlPqYpt4q1Km/Dqg==
X-Received: by 2002:a17:902:ec86:b0:224:f12:3735 with SMTP id
 d9443c01a7336-22df57b8365mr50309665ad.31.1746029431718; 
 Wed, 30 Apr 2025 09:10:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbcf7dsm124148525ad.69.2025.04.30.09.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:10:31 -0700 (PDT)
Message-ID: <d47d36db-f94c-45ee-bdf0-477607703461@linaro.org>
Date: Wed, 30 Apr 2025 09:10:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-5-thuth@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250429152141.294380-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/29/25 8:21 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got this nice vmstate-static-checker.py script that can help
> to detect screw-ups in the migration states. Unfortunately, it's
> currently only run manually, so there could be regressions that nobody
> notices immediately. Let's run it from a functional test automatically
> so that we got at least a basic coverage in each CI run.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                      |  1 +
>   tests/functional/meson.build     | 13 +++++++-
>   tests/functional/test_vmstate.py | 56 ++++++++++++++++++++++++++++++++
>   3 files changed, 69 insertions(+), 1 deletion(-)
>   create mode 100755 tests/functional/test_vmstate.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65fb61844b3..6a8d81458ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3525,6 +3525,7 @@ F: migration/
>   F: scripts/vmstate-static-checker.py
>   F: tests/data/vmstate-static-checker/
>   F: tests/functional/test_migration.py
> +F: tests/functional/test_vmstate.py
>   F: tests/qtest/migration/
>   F: tests/qtest/migration-*
>   F: docs/devel/migration/
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index b317ad42c5a..9f339e626f6 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -76,6 +76,7 @@ tests_generic_bsduser = [
>   
>   tests_aarch64_system_quick = [
>     'migration',
> +  'vmstate',
>   ]
>   
>   tests_aarch64_system_thorough = [
> @@ -164,6 +165,10 @@ tests_loongarch64_system_thorough = [
>     'loongarch64_virt',
>   ]
>   
> +tests_m68k_system_quick = [
> +  'vmstate',
> +]
> +
>   tests_m68k_system_thorough = [
>     'm68k_mcf5208evb',
>     'm68k_nextcube',
> @@ -230,6 +235,7 @@ tests_ppc_system_thorough = [
>   
>   tests_ppc64_system_quick = [
>     'migration',
> +  'vmstate',
>   ]
>   
>   tests_ppc64_system_thorough = [
> @@ -265,6 +271,10 @@ tests_rx_system_thorough = [
>     'rx_gdbsim',
>   ]
>   
> +tests_s390x_system_quick = [
> +  'vmstate',
> +]
> +
>   tests_s390x_system_thorough = [
>     's390x_ccw_virtio',
>     's390x_replay',
> @@ -305,8 +315,9 @@ tests_x86_64_system_quick = [
>     'migration',
>     'pc_cpu_hotplug_props',
>     'virtio_version',
> -  'x86_cpu_model_versions',
> +  'vmstate',
>     'vnc',
> +  'x86_cpu_model_versions',
>   ]
>   
>   tests_x86_64_system_thorough = [
> diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
> new file mode 100755
> index 00000000000..3ba56d580db
> --- /dev/null
> +++ b/tests/functional/test_vmstate.py
> @@ -0,0 +1,56 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This test runs the vmstate-static-checker script with the current QEMU
> +
> +import subprocess
> +
> +from qemu_test import QemuSystemTest
> +
> +
> +class VmStateTest(QemuSystemTest):
> +
> +    def test_vmstate(self):
> +        target_machine = {
> +            'aarch64': 'virt-7.2',
> +            'm68k': 'virt-7.2',
> +            'ppc64': 'pseries-7.2',
> +            's390x': 's390-ccw-virtio-7.2',
> +            'x86_64': 'pc-q35-7.2',
> +        }
> +        self.set_machine(target_machine[self.arch])
> +
> +        # Run QEMU to get the current vmstate json file:
> +        dst_json = self.scratch_file('dest.json')
> +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
> +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
> +                             '-M', target_machine[self.arch],
> +                             '-dump-vmstate', dst_json],
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            text=True)
> +        if cp.returncode != 0:
> +            self.fail('Running QEMU failed:\n' + cp.stdout)
> +        if cp.stdout:
> +            self.log.info('QEMU output: ' + cp.stdout)
> +
> +        # Check whether the old vmstate json file is still compatible:
> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> +                                  self.arch,
> +                                  target_machine[self.arch] + '.json')
> +        vmstate_checker = self.data_file('..', '..', 'scripts',
> +                                         'vmstate-static-checker.py')
> +        self.log.info('Comparing vmstate with ' + src_json)
> +        cp = subprocess.run([vmstate_checker, '-s', src_json, '-d', dst_json],
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            text=True)
> +        if cp.returncode != 0:
> +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
> +        if cp.stdout:
> +            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

Thanks for this series Thomas, it's very useful.
Could we extend this automatically to test migration on all 
combinations: {qemu-system-*} x {machine}?
We could generate a single list of references, containing hashes of all 
outputs, and a simple and clean command to regenerate all those, and 
associated jsons, so we don't pollute qemu code with tons of json.

This way, we can automatically detect that we never regress, not only 
from release to release, but commit to commit.

In case we need to update reference, people can point what's the actual 
difference in the commit message.

As well, since I took a look into that before, this check is not enough 
regarding migration. Beyonds the VMDstate, we should check as well that 
the default values of every field are not changed. For instance, we 
recently changed the default pauth property of arm cpus, and without a 
careful backcompat, it would have break migration. It's a bit more 
tricky, since there is nothing available now to dump this (I hacked that 
using a custom trace). And definitely not something in the scope of your 
series, just worth mentioning.

I hope we can one day get rid of all "Is this change safe regarding 
migration?" comments because we know we can trust our CI instead.

Regards,
Pierrick

