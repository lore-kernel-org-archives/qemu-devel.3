Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9498D3C549
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 04:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1f2n-0001kG-2E; Fri, 18 Oct 2024 00:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1f2j-0001jy-7D; Fri, 18 Oct 2024 00:56:53 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1f2f-00049x-JH; Fri, 18 Oct 2024 00:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729227409; x=1760763409;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bGu/+Db0FA2igHiNwYPOV2iX0Touqy0Pg/UF/MibiE4=;
 b=DBCEBZhqcHWlRT0gN2sxUAmhnSICDjUI/tDxBQ8fA0OQDmGEcoADctUx
 f4nR8Duy14IJ9cIQ9QyVloP1g1g/XDsUc06BekbRJ7OCOxUQVhuxeFwHm
 gYdZMhHBGLkbKh6mY8XKlqOI2aT/nn4x9jdqxSiymRlj7toEQ8LB124h1
 8rYDHGCGv4FlOqP5pFv26hpB0UYSZKOrSwtKMUpDlek7YeGcWCXB7Bfsk
 yrzjj3HzmYxlkdUDHrOyiA6EI2xNfNVbovcc/QyFbY/WXuWaLxzSFsqZs
 6sKxX+f2+YTXUnAOu3X/hX04hknBjH06SCL+AH+GLbt77OK6iSztM+zHM g==;
X-CSE-ConnectionGUID: JGV9Cr5eQZ2neZvOIl8e4g==
X-CSE-MsgGUID: ljwC1UfYTXSXc26egJNlLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28184833"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; d="scan'208";a="28184833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 21:56:45 -0700
X-CSE-ConnectionGUID: 7gnTr/A0RBauVJqQ4cSmrw==
X-CSE-MsgGUID: mufS2+6KR1OT1OeLqwYIEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; d="scan'208";a="78664072"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 17 Oct 2024 21:56:37 -0700
Date: Fri, 18 Oct 2024 13:12:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com,
 salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, linuxarm@huawei.com, gustavo.romero@linaro.org
Subject: Re: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Message-ID: <ZxHuVC0uDL7kEB2i@intel.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014192205.253479-4-salil.mehta@huawei.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Salil,

On Mon, Oct 14, 2024 at 08:22:04PM +0100, Salil Mehta wrote:
> Date: Mon, 14 Oct 2024 20:22:04 +0100
> From: Salil Mehta <salil.mehta@huawei.com>
> Subject: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled} states
>  in ACPI _STA.{PRES,ENA} Bits
> X-Mailer: git-send-email 2.34.1
> 
> Reflect the ACPI CPU hotplug `is_{present, enabled}` states in the `_STA.PRES`
> (presence) and `_STA.ENA` (enabled) bits when the guest kernel evaluates the
> ACPI `_STA` method during initialization, as well as when vCPUs are hot-plugged
> or hot-unplugged. The presence of unplugged vCPUs may need to be deliberately
> *simulated* at the ACPI level to maintain a *persistent* view of vCPUs for the
> guest kernel.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/acpi/cpu.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 

It seems this patch changes ACPI table layout and then breaks current
ACPI table qtest. I'm not sure how to do such modifications. Maybe you
should first disable the related checks, then modify the code, update
the qtest, and finally re-enable the checks for qtest. This can help
to avoid any qtest failure due to this patch?

I think it should get Igor's advice on this. :)

Attach the error I met:

▶   2/920 ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion failed: (all_tables_match) ERROR
▶   3/920 ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion failed: (all_tables_match) ERROR
  2/920 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test                                ERROR            1.24s   killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=/media/liuzhao/data/qemu-cook/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_BINARY=./qemu-system-i386 MALLOC_PERTURB_=142 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=./qemu-img PYTHON=/media/liuzhao/data/qemu-cook/build/pyvenv/bin/python3 /media/liuzhao/data/qemu-cook/build/tests/qtest/bios-tables-test --tap -k
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-VRT5V2], Expected [aml:tests/data/acpi/x86/pc/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-TTT5V2.dsl, aml:/tmp/aml-VRT5V2], Expected [asl:/tmp/asl-XXM5V2.dsl, aml:tests/data/acpi/x86/pc/DSDT].
**
ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion failed: (all_tables_match)

(test program exited with status code -6)
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

  3/920 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test                            ERROR            1.25s   killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=/media/liuzhao/data/qemu-cook/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=./qemu-img PYTHON=/media/liuzhao/data/qemu-cook/build/pyvenv/bin/python3 MALLOC_PERTURB_=41 QTEST_QEMU_BINARY=./qemu-system-x86_64 /media/liuzhao/data/qemu-cook/build/tests/qtest/bios-tables-test --tap -k
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-D5K5V2], Expected [aml:tests/data/acpi/x86/pc/DSDT].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-G6K5V2.dsl, aml:/tmp/aml-D5K5V2], Expected [asl:/tmp/asl-AQD5V2.dsl, aml:tests/data/acpi/x86/pc/DSDT].
**
ERROR:../tests/qtest/bios-tables-test.c:553:test_acpi_asl: assertion failed: (all_tables_match)

(test program exited with status code -6)


Regards,
Zhao



