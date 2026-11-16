Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CB606A880
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=WBcJE4yy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Tx-0003Z9-EK; Mon, 16 Nov 2026 16:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mirko.kirchner@mailbox.org>)
 id 1xT1uI-0006EG-6j
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:58:22 -0500
Received: from mout-p-103.mailbox.org ([2001:67c:2050:0:465::103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mirko.kirchner@mailbox.org>)
 id 1xT1uF-00016M-BQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:58:21 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSxvm5731zKmSh
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 19:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794855492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=WpEywh/hD2vIupJ0ZIu49cudtqzvOEed364K6w5KLP4=;
 b=WBcJE4yy9OECFFs6DIXZNdeb07C1ItI3o8GZL3IE5diIEiwmrv4sIk/oKa5Acopz0C9zmB
 xWyASyituPfjCCETLCc/Aczjt9tpBJb0gGyp6gNyk3Af3hNLcfSo/Yp8LXR7+WAKzI2lEK
 YxLpGM76rnykE49QHM9QRcZWduu3E5E1hCTawy+lSXhvE6CjLTPG2Tkr6QQIsFy9Y6aEza
 7iYjNtOwkZtAUgOPUAR83BK9+m/jJqfzpDHoDzyO4lMBWFrc2aVhQ+8kzSI7Jvb+7YD8fh
 r47heIhAqc0Rd0vxsuO6xTfydNBlQpBbHXBva27oQOtWyYBtwPZohfNclqTdkg==
Date: Mon, 16 Nov 2026 19:58:11 +0100 (CET)
From: Mirko Kirchner <mirko.kirchner@mailbox.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <1235332171.672234.1794855492001@app.mailbox.org>
Subject: [BUG] x86/KVM: CPUID.0DH.01H reports EBX=832 without XSAVEC or
 XSAVES support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="----=_Part_672233_772170533.1794855492001"
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-MBO-RS-ID: 3c720b48904aaa9aae2
X-MBO-RS-META: jz64khjmt83cgikhjt7h1uf3jfnypj5j
Received-SPF: pass client-ip=2001:67c:2050:0:465::103;
 envelope-from=mirko.kirchner@mailbox.org; helo=mout-p-103.mailbox.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:43:18 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,ZIPFILE
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------=_Part_672233_772170533.1794855492001
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

AI assistance disclosure: OpenAI Codex/ChatGPT assisted with investigation, source research, diagnostic and test tooling, and drafting this report. An experimental local correction was also developed with AI assistance. The measurements below come from executed, retained test runs. This is a bug report, not a patch submission; no AI-generated patch is attached or offered for merging.

Hello QEMU team,

GitLab account verification currently prevents me from accessing the issue tracker. I am sending this technical report here and would appreciate advice on routing it into the tracker if appropriate.

While developing our own Intel64 operating system, OS64, we encountered inconsistent XSTATE enumeration. We subsequently reproduced the problem without an OS64 image, directly while configuring a stopped KVM vCPU.

QEMU 11.1.3 passes the following CPUID leaf 0xD, subleaf 1 values to KVM:

    EAX=0x00000001  EBX=0x00000340  ECX=0x00000000  EDX=0x00000000

EAX advertises XSAVEOPT, but neither XSAVEC (bit 1) nor XSAVES (bit 3). Intel's SDM specifies EBX=0 for this combination. The observed 0x340 is 832 bytes.

## Host environment

- openSUSE Tumbleweed 20261111; Linux 7.3.3-1-default; x86_64; KVM.
- Two Intel Xeon E5-2699 v4 processors; family 6, model 0x4F, stepping 1.
- QEMU 11.1.3; distribution package qemu-x86 11.1.3-1.1.
- Also reproduced with an unmodified build of the official upstream source release: https://download.qemu.org/qemu-11.1.3.tar.xz
- Minimal reproducer: q35/KVM, `-cpu host`, one vCPU, 64 MiB, `-S`; no guest disk required and no guest or firmware code executed.
- Separate in-guest confirmation: OS64, q35-11.1/KVM, host-passthrough, one vCPU, 16 GiB, OVMF, VGA. The OS64 image and CPU profile were unchanged across the comparison.

## Expected behavior

Intel SDM Volume 1, revision 093, section 13.2, printed page 13-5 (PDF page 324), specifies that CPUID.0DH.01H:EBX is zero when both EAX[1] and EAX[3] are zero. XSAVEOPT alone does not change that condition.

Reference: https://cdrdv2-public.intel.com/929351/253665-093-sdm-vol-1.pdf#page=324

## Steps to reproduce

Prerequisites: KVM access, strace, and a host/exposed feature set without XSAVEC or XSAVES. Our native host returns D.1:EAX=1 and EBX=0.

Use the unmodified QEMU binary under test. For an upstream build, replace only the executable path; `/usr/share/qemu` is the resource directory used in our test.

```sh
strace -f -v -s 65535 -e trace=ioctl -o cpuid-ioctl.log \
  qemu-system-x86_64 -name OS64-CPUID-REPAIR-PROBE \
  -no-user-config -nodefaults -display none \
  -machine q35,accel=kvm -cpu host -m 64 -smp 1 -S \
  -monitor none -serial none -L /usr/share/qemu -qmp stdio <<'QMP'
{"execute":"qmp_capabilities"}
{"execute":"quit"}
QMP
```

Inspect the successful `KVM_SET_CPUID2` call:

```text
{function=0xd, index=0x1, flags=KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
 eax=0x1, ebx=0x340, ecx=0, edx=0}
```

Each retained probe contains exactly one successful `KVM_SET_CPUID2` call, no `KVM_RUN` call, and process exit 0. The test sent these QMP commands through standard input; the here-document expresses that same sequence without our local Python wrapper.

## Actual results

Values below are EAX / EBX / ECX / EDX (decimal):

| Observation | Values |
| --- | --- |
| Native host CPUID | 1 / 0 / 0 / 0 |
| KVM_GET_SUPPORTED_CPUID | 1 / 0 / 0 / 0 |
| Distribution QEMU, KVM_SET_CPUID2 | 1 / 832 / 0 / 0 |
| Unmodified upstream rebuild, same invocation | 1 / 832 / 0 / 0 |
| CPUID executed in the guest before correction | 1 / 832 / 0 / 0 |
| Experimental local correction, installation and guest | 1 / 0 / 0 / 0 |

The inconsistent value is therefore passed by QEMU to KVM before guest execution. The direct reproducer needs neither libvirt nor our OS code. All 31 installed CPUID records match between the distribution binary and the unmodified upstream rebuild.

## Source localization and local validation

In the 11.1.3 source, `cpu_x86_cpuid()` in `target/i386/cpu.c` computes the compacted size for leaf 0xD/subleaf 1 without requiring the exposed XSAVEC/XSAVES bits at that point:
https://github.com/qemu/qemu/blob/v11.1.3/target/i386/cpu.c

An experimental local change conditions that calculation on the exposed capabilities. Across the 31 installed records, only D.1:EBX changes, from 832 to 0. EAX/ECX/EDX and all other records remain unchanged; no extra CPU capabilities are advertised. With the identical OS64 image and CPU profile, the VM then reaches its intended halt after CPU inventory. OS64's consistency check was not changed.

We also exercised the compiled CPUID function with 24 synthetic inputs. These are not 24 tested CPUs. In particular, eight XSAVES-without-XSAVEC cases are robustness probes, not valid Intel feature combinations. We do not claim an actual XSAVES KVM runtime test on this host. The attachment states these limits explicitly. The local AI-assisted correction is not submitted as a patch.

## Scope and request

Runtime reproduction covers 11.1.3, including the unmodified official source rebuild. We have not built and runtime-tested 11.2.0-rc0 or git master. We do not claim first discovery or impact on every CPU model.

Could you please check this finding and, if confirmed, correct the CPUID generation? If this case is already known or we have missed a relevant limitation, a reference would be appreciated.

The attached `qemu-cpuid-evidence.zip` contains environment details, native host/KVM output, all 31 installation records from each of the three QEMU builds, explicitly identified ioctl excerpts, selected original guest records, the bounded validation summary, reproduction instructions, and SHA-256 checksums. Only the process-ID prefixes were removed from the ioctl excerpts; register and return values are unchanged. Private paths, VM identifiers, OS64 source, and guest images are not included.

Thank you for your work on QEMU and for looking into this report.

Best regards,
Mirko
------=_Part_672233_772170533.1794855492001
Content-Type: application/zip; name=qemu-cpuid-evidence.zip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=qemu-cpuid-evidence.zip
X-Part-Id: 381db3ca5fe641fcb054e0cf3ccb3d1e

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
AAkACQBMAgAALRoAAAAA
------=_Part_672233_772170533.1794855492001--

