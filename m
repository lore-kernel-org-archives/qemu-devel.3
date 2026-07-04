Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6E2C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 13:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg0Yk-0007G4-JT; Sat, 04 Jul 2026 09:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1wg0Yi-0007Fv-0j
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 09:37:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1wg0Yg-0005EV-4q
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 09:37:27 -0400
Received: from frill.fritz.box (p5dd8e1a7.dip0.t-ipconnect.de [93.216.225.167])
 by linux.microsoft.com (Postfix) with ESMTPSA id 253C320B7169
 for <qemu-devel@nongnu.org>; Sat,  4 Jul 2026 06:37:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 253C320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783172241;
 bh=kOm82QMkCY8gfmknyDO1hA3tJSpQzK5HeRSN7NXyK58=;
 h=Subject:From:Reply-To:To:Date:From;
 b=oR+zHYYqx9tdDYQUUkywi6mQaGtASbAyR+C7tgkqcHKjbcLN/DnS1pq6OvzTrhWVf
 OVhmy3++DA/FZfkC6Cprd6iixDBi/WjiL8rO6kbLdDaTefLlio8ZC+jZ5ThZdh0m5u
 eTswUMcSRXX0a76lKXAR4+L2FL+WDhMzzM8EL3yw=
Message-ID: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
Subject: [RFC] virtio-villain: Guest fault injection for VMM robustness
From: Anatol Belski <anbelski@linux.microsoft.com>
To: qemu-devel@nongnu.org
Date: Sat, 04 Jul 2026 15:37:21 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=anbelski@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: anbelski@linux.microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I would like to share virtio-villain, a guest side fault injection
harness for virtio device models. The repository is at
https://github.com/weltling/virtio-villain

Comments on the approach, the coverage so far, and test cases worth
adding are all welcome. While the tool targets multiple hypervisors,
QEMU support is active and has already surfaced a few initial bugs.

Threat model. The harness operates under the hostile guest model. A
malicious or buggy guest driver violates the virtio protocol on
purpose. It targets the modern 1.2+ interface only. The test binary
runs as init inside a minimal initramfs, bypasses the kernel virtio
drivers with initcall_blacklist, walks the PCI capability list
itself, programs the queues by hand, and asserts on the exact spec
mandated values. Each test violates one driver MUST rule and checks
that the host VMM process handles it gracefully without crashing,
wedging, or corrupting state.

Scope and status. The primary target so far is Cloud Hypervisor,
which accounts for most of the findings to date. Testing focuses on
the amd64 and aarch64 architectures. QEMU is supported as a PCI host
and as the microvm MMIO host. Differential testing across VMMs,
running the same suite and comparing outcomes, is the roadmap. This
is a spec violation fault injection tool that surfaces unvalidated
input handling rather than an exploit framework, so no CVEs have
been issued.

What is already covered. There are two transports, modern virtio PCI
and virtio MMIO via the QEMU microvm machine type. A dozen device
categories are present. They include net, block with zoned support,
console, entropy, balloon, vsock, virtio-fs, IOMMU, virtio-mem,
virtio-pmem, RTC, and watchdog, plus the admin queue and the split
and packed virtqueue layers. Test cases derive from the virtio spec
normative text, each tied to a specific section.

Beyond the static suite there are two extra layers.

  - Host coordinated sidecars. A test can ship a small Python file
    that drives the host, for example pause, snapshot, hot plug, or
    config change, while the guest makes a precise assertion the
    kernel driver cannot make. As an example, snapshot the VM while
    the guest sits between two block reads, then assert the used
    ring drains deterministically on resume.

  - A coverage guided mutation fuzzer. It encodes a descriptor chain
    into a 4096 byte blob, patches it into a fuzz guest, boots the
    VMM, and classifies the result. With a coverage instrumented
    build it feeds new edges back into the corpus. Crashes are
    grouped by error class for triage.

Impact. Many findings have led to substantial improvements in
virtio spec compliance and stability in Cloud Hypervisor, from
input validation gaps to a config read that could take down a VM
on aarch64. In QEMU the harness has surfaced a few guest triggered
hangs and a double completion. The repository README lists the
details with PR links and the test ID for each.

Thanks for reading.

Anatol Belski

