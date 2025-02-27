Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A84C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfaK-0001hA-0s; Thu, 27 Feb 2025 10:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnfaH-0001cm-29; Thu, 27 Feb 2025 10:13:57 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnfaF-0006DA-34; Thu, 27 Feb 2025 10:13:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1FA5D5C032A;
 Thu, 27 Feb 2025 15:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A22C4CEDD;
 Thu, 27 Feb 2025 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740669230;
 bh=iRdlLeLNV1v/SdkmRrf//HdDAGmEp0/h9w4ViUssNHI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KlMV9lS37dpdw08l0ZO9yoYTuDxJ4zhPda/N50v/03oY2/UWS9pwfZc8fajaTrV11
 uYsB7hW9K9j6tYE4pcLxuha5pJp0rYMOuaZdUEQfLKeQ+v0OnQeMOPYTGmLYe1GwJ8
 8D/PtrCKkKjCNupk0/u0ha6GvrEZLlf6hixpN9MCfzc4O0NGAQIGDf6mPYbyLpCR8c
 7n25zAJcN1SF6DSQVnLZF2XS5bLjBeLRGDKX3o8laLNBPnhHOGVChdf78Kk1m8PxXY
 Gu6hygs/eIQMK2jeqKggfMzN74Yfw/J+t/XQkFVsToGsT27SwWuhNrybsKQI0ZuKCP
 8vMe+5FUiBLNQ==
Date: Thu, 27 Feb 2025 16:13:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/21]Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250227161343.5249e9b8@foz.lan>
In-Reply-To: <20250227143028.22372363@imammedo.users.ipa.redhat.com>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <20250227143028.22372363@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Em Thu, 27 Feb 2025 14:30:28 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 27 Feb 2025 12:03:30 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Now that the ghes preparation patches were merged, let's add support
> > for error injection.
> > 
> > On this version, HEST table got added to ACPI tables testing for aarch64 virt.
> > 
> > There are also some patch reorder to help reviewers to check the changes.
> > 
> > The code itself is almost identical to v4, with just a few minor nits addressed.  
> 
> series still has checkpatch errors 'line over 80' which are not false positive,
> it needs to be fixed

The long line warnings are at the patch adding the Python script. IMO,
all but one are false positives:

1. Long lines at patch description because of the tool output example added
   inside the commit description:

	ERROR: line over 90 characters
	#148: FILE: scripts/arm_processor_error.py:83:
	+[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)

	ERROR: line over 90 characters
	#153: FILE: scripts/arm_processor_error.py:88:
	+[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.

	WARNING: line over 80 characters
	#170: FILE: scripts/arm_processor_error.py:105:
	+[Hardware Error]:    00000000: 13 7b 04 05 01                                   .{...

	WARNING: line over 80 characters
	#174: FILE: scripts/arm_processor_error.py:109:
	+[Firmware Warn]: GHES: Unhandled processor error type 0x10: micro-architectural error

	ERROR: line over 90 characters
	#175: FILE: scripts/arm_processor_error.py:110:
	+[Firmware Warn]: GHES: Unhandled processor error type 0x14: TLB error|micro-architectural error

   IMO, breaking command output at the description is a bad practice.

2. Big strings at help message:

	WARNING: line over 80 characters
	#261: FILE: scripts/arm_processor_error.py:196:
	+                           help="Power State Coordination Interface - PSCI state")

	ERROR: line over 90 characters
	#276: FILE: scripts/arm_processor_error.py:211:
	+                        help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")

	WARNING: line over 80 characters
	#278: FILE: scripts/arm_processor_error.py:213:
	+                        help="Error information (UEFI 2.10 tables N.18 to N.20)")

	ERROR: line over 90 characters
	#287: FILE: scripts/arm_processor_error.py:222:
	+                        help="Type of the context (0=ARM32 GPR, 5=ARM64 EL1, other values supported)")


	WARNING: line over 80 characters
	#1046: FILE: scripts/qmp_helper.py:442:
	+                           help="Marks the timestamp as precise if --timestamp is used")

	WARNING: line over 80 characters
	#1048: FILE: scripts/qmp_helper.py:444:
	+                           help=f"General Error Data Block flags: {gedb_flags_bits}")

   Those might be changed if we add one variable per string to store the
   help lines, at the expense of doing some code obfuscation.

   I don't think doing it is a good idea.

3. Long class function names that are part of Python's standard library:

	ERROR: line over 90 characters
	#576: FILE: scripts/ghes_inject.py:29:
	+    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter,

   We can't change the big name of the argparse formatter. The only
   possible fix would be to obfuscate it by doing:

	format = argparse.ArgumentDefaultsHelpFormatter,
	parser = argparse.ArgumentParser(formatter_class=format,

   IMO this is a bad practice.

4. False-positive warning disable for pylint coding style tool:

	ERROR: line over 90 characters
	#805: FILE: scripts/qmp_helper.py:201:
	+        data.extend(value.to_bytes(num_bytes, byteorder="little"))  # pylint: disable=E1101

	WARNING: line over 80 characters
	#1028: FILE: scripts/qmp_helper.py:424:
	+        g_gen = parser.add_argument_group("Generic Error Data")  # pylint: disable=E1101

   AFAIKT, those need to be at the same line for pylint to process them
   properly.

5. A long name inside an indented block:

	WARNING: line over 80 characters
	#1109: FILE: scripts/qmp_helper.py:505:
	+                                                   value=args.gen_err_valid_bits,

   Again the only solution would be to obfuscate the argument, like:

	a = args.gen_err_valid_bits

							    value=a,

   Not nice, IMHO.

Now, there is one warning that I is not a false positive, which I ended
missing:

	WARNING: line over 80 characters
	#1227: FILE: scripts/qmp_helper.py:623:
	+            ret = self.send_cmd("qom-get", args, may_open=True, return_error=False)

I'll fix it at the next respin.

Regards,
Mauro

