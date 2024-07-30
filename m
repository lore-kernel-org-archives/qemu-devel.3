Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgA9-0006nt-SK; Tue, 30 Jul 2024 02:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYgA6-0006kl-Iz; Tue, 30 Jul 2024 02:16:43 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYgA4-00086P-4M; Tue, 30 Jul 2024 02:16:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id AAB82CE0AFC;
 Tue, 30 Jul 2024 06:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE05BC32782;
 Tue, 30 Jul 2024 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722320192;
 bh=BRy3EumtsayESW490iJoX78v2fJzwIdLETnfNWc7UdE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ex+pIZyZGhCHy4nhR5GKhkx5L7jGhDcHpXlc4Al8Wf9/94EQLPHAf0qsyYY7PDgbV
 sZsT3V0He1cO+zcu+cxCQVaYIOlR55SGxfUaU5E6280/ER3rDRNyoSGqfLEnRkTimO
 +SHbfaZBKkl4NN5Org53nndC1KYXL0frMFUEA2LQbmbfXEmxdF/LuY3u1nBDju9geF
 tZnFFFp+daHZBEGLkGMBqo2XTGx78hOdn9Ke8gtinwkwoXzSghxmW7B0GAhewQ/zXb
 I8WdFqfzqq+ojiB4DSmB/AjSfElY8Kywu7JRW/mrW/1635OUtFITflTF8A/jJeHKFG
 BCtSSudCSjsYg==
Date: Tue, 30 Jul 2024 08:16:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Markus Armbruster
 <armbru@redhat.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 6/6] acpi/ghes: Add a logic to inject ARM processor CPER
Message-ID: <20240730081610.6390c423@foz.lan>
In-Reply-To: <20240729173109.00006911@Huawei.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <7e0c1ae181e9792e876ec0e7d2a9e7f32d7b60ac.1722259246.git.mchehab+huawei@kernel.org>
 <20240729173109.00006911@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Mon, 29 Jul 2024 17:31:09 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Mon, 29 Jul 2024 15:21:10 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

...

> Markus suggested:
> 
> > A target-specific command like this one should be conditional.  Try
> > this:
> > 
> >     { 'command': 'arm-inject-error',
> >       'data': { 'errortypes': ['ArmProcessorErrorType'] },
> >       'features': [ 'unstable' ],
> >       'if': 'TARGET_ARM' }
> >
> > No need to provide a qmp_arm_inject_error() stub then.  
> 
> (I noticed because never knew you could do this.)
> 
> Probably crossed with your v4 posting.

Tried it, but can't figure out how to properly set it up at meson.build,
as it is basically producing build time errors during qapi file generation
on non-ARM platforms. For instance:

FAILED: libqemuutil.a.p/meson-generated_.._qapi_qapi-visit-arm-error-inject.c.o 
cc -m64 -Ilibqemuutil.a.p -I. -I.. -Isubprojects/libvhost-user -I../subprojects/libvhost-user -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/sysprof-6 -I/usr/include/gio-unix-2.0 -I/usr/include/p11-kit-1 -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /new_devel/edac/qemu/linux-headers -isystem linux-headers -iquote . -iquote /new_devel/edac/qemu -iquote /new_devel/edac/qemu/include -iquote /new_devel/edac/qemu/host/include/x8
 6_64 -iquote /new_devel/edac/qemu/host/include/generic -iquote /new_devel/edac/qemu/tcg/i386 -pthread -msse2 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fPIE -DWITH_GZFILEOP -MD -MQ libqemuutil.a.p/meson-generated_.._qapi_qapi-visit-arm-error-inject.c.o -MF libqemuutil.a.p/meson-generated_.._qapi_qapi-visit-arm-error-inject.c.o.d -o libqemuutil.a.p/meson-generated_.._qapi_qapi-visit-arm-error-inject.c.o -c qapi/qapi-visit-arm-error-inject.c
In file included from qapi/qapi-visit-arm-error-inject.h:17,
                 from qapi/qapi-visit-arm-error-inject.c:15:
qapi/qapi-types-arm-error-inject.h:18:13: error: attempt to use poisoned "TARGET_ARM"
   18 | #if defined(TARGET_ARM)
      |             ^
In file included from /new_devel/edac/qemu/include/exec/poison.h:7,
                 from /new_devel/edac/qemu/include/qemu/osdep.h:38,
                 from qapi/qapi-visit-arm-error-inject.c:13:
./config-poison.h:718:20: note: poisoned here

Such error is created by two files generated from qapi, due
to this change:

	diff --git a/qapi/meson.build b/qapi/meson.build
	index e7bc54e5d047..5927932c4be3 100644
	--- a/qapi/meson.build
	+++ b/qapi/meson.build
	@@ -24,2 +24,3 @@ endif
	 qapi_all_modules = [
	+  'arm-error-inject',
	   'authz',

No idea how to fix it.

Thanks,
Mauro

