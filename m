Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798A2C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 20:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZcjC-0007D5-DV; Mon, 12 Feb 2024 15:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1rZcjA-0007Ct-9b
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:16:32 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dionnaglaze@google.com>)
 id 1rZcj8-0006Jx-I6
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:16:32 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-560530f4e21so2639a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707768988; x=1708373788; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SDwQlnMvSUXWZCNDxSNzqAWpmsICnk3Smm8wfKL/l2M=;
 b=xafBlp+cPXrunggdim0+eq7J8Azlu29Qxtsm6sIV//uKPc+0N+Hj4boWEAF9jxhG4c
 C1Vkz0YdmDyetcEXp0+u03FFgeYkg5IvLgw8cm+5peZYrEGpZBTkJ22kOpUg3uwAOio8
 goDgo7rh/TLqSIUfS+TnKUjNOMeaEVPJS1EN3V5NNUGe3j5iyC4X2hNEaQANv7R1aMEq
 hG35+PNOcDZZoogtj+LKkU5TuLDnOauDgze0zVC/jo/YbyVxRQZ/z6h+bePQddjXZMzC
 Ht4RYEMaA3M/Qb84D8o82E4KJ1+EXHhmW5lct2w9qccARvm02dnfK9Fy2OQBoa2ETTBX
 0w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707768988; x=1708373788;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SDwQlnMvSUXWZCNDxSNzqAWpmsICnk3Smm8wfKL/l2M=;
 b=IS5eqgDuGSeH34vpdccj2VG8eFcAhwO+UPDydtVM3OE7I7zEg2NSsp5+0eHBtTX0hj
 9BJ6peqM1oIqMjS4fPOIugxWsm85PzHupPvTXDMTPhYp2zht1w5ccLWJ8Fo782ISc6oi
 e2gBkBqoW4bW83sUfwSeRA31R4PtoqvMqNhvtzS5vRXlc8XwMTXCYUv2hnErdFT/8elo
 +JlnT45nH8jgxnZYDRxSKgOsYCp4pvFy7sqgs8H7a/JYEuLH7+E1uM2rStr3czWSchs2
 JC2XJgVkpM+viV6dYTmJA2QaXDFJbyU3Q//xIu0ucvQZgwmx70RAC3Tak21EQsYmQssy
 pufQ==
X-Gm-Message-State: AOJu0Yzx04rY6ScrsZLE8GObqVWvt+tRc1PL5Dvce5WMReCee0pZh91d
 +7KYXQdWfgaZSYFGc0Vl7kBvKdmXiqgcAFCDTMVj6wf+ZsisO35hKVE99hTv/aK9uCP82Uz6r9H
 AVyi2eXRBvyoremFYJ7V2Xhg2dTo6l3G1j6M6
X-Google-Smtp-Source: AGHT+IES29R0fbvSPywXtnyh84PhzP09BkVlcvID9x5TsgBRPdw5BmJCGsvqXUUGMmyI4vZV9+FVq20pj92SggDJLKk=
X-Received: by 2002:a50:8a9e:0:b0:560:f37e:2d5d with SMTP id
 j30-20020a508a9e000000b00560f37e2d5dmr293201edj.5.1707768988023; Mon, 12 Feb
 2024 12:16:28 -0800 (PST)
MIME-Version: 1.0
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 12 Feb 2024 12:16:14 -0800
Message-ID: <CAAH4kHY+JHSznw_t52rwBckfcZpzvX28b9Cu3eyXLMShnj3NBg@mail.gmail.com>
Subject: RFC i386/sev: kernel-hashes, reference measurements and event logs
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>
Cc: npiggin@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, 
 "Draper, Andrew" <andrew.draper@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joerg Roedel <jroedel@suse.de>, James Bottomley <jejb@linux.ibm.com>,
 Chong Cai <chongc@google.com>, 
 qemu-devel@nongnu.org, clg@kaod.org, danielhb413@gmail.com, 
 harshpb@linux.ibm.com, david@gibson.dropbear.id.au, borntraeger@linux.ibm.com, 
 farman@linux.ibm.com, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, iii@linux.ibm.com, thuth@redhat.com, 
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=dionnaglaze@google.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is not a patch but it felt inappropriate to derail a recent patch
that's just refactoring the kernel-hashes object_class_property
definition. Apologies if this has been discussed before, as I'm not
particularly active here.

Regarding kernel-hashes, how is that load-time information passed
along to the guest beyond, say, OVMF? Can we require that these hashes
are also present in fw_cfg so they can be read from the kernel? In
Linux it'd be nice to have /sys/firmware/qemu_fw_cfg/sev_kernel_hash,
/sys/firmware/qemu_fw_cfg/sev_cmdline_hash,
/sys/firmware/qemu_fw_cfg/sev_initrd_hash

I'm working on how to use standard document formats for providing
reference measurements of the Google Compute Engine virtual firmware
for remote attestation, and these hashes have an impact not just on
the measurement but on the entire model that the IETF RATS working
group is considering for authorizing attestation measurements.

If you're assembling a VM launch configuration with firmware provided
by a trusted vendor (say Google), and your hashes are passed in from
an API, there's no easy rendezvous to state that the combination
produces the expected hardware measurement. This makes adding
kernel-hashes support unappetizing, since it makes the hardware
attestation report's measurement have no meaning, or at least, it
makes life difficult for people trying to assign it meaning.

The measurement is the product of two different entities as assembled
by the VMM given a trusted firmware and the kernel hashes. It's a bit
of a sandwich of (GCE) core firmware, (User) SEV hashes, (GCE) BSP
VMSA, AP VMSA*.

When you collect "evidence" to verify locally or pass along to a
verification service, you need more than just the hardware attestation
report to make sense of the combined bits. You have a PCR situation
like with TPM, so you need an event log for these different aspects of
the ultimate measurement. There is no event log for this
-kernel-hashes construction.

We can use the TCG TPM event log to post EV_NO_ACTION events about the
PlatformRIM, specifically, to point at a UEFI variable that we
populate to store our signed document about the expected measurements
with the Qemu-SEV-SNP-boot-protocol, but I don't see how we might
collect the kernel-hashes values as extra evidence to combine and
derive the attestation report's MEASUREMENT field to accept "evidence"
objects for the core firmware component and the kernel hashes
component.

So my question is if this feature is to be a long term feature, how do
you expect to collect the SEV hashes as a separate evidence object to
play nicely with IETF RATS?

Is this a long term feature, or are we expecting it to be deprecated by SVSM?

I've tagged in people in CC that I could imagine would have something
to say about this.

Thanks y'all

--
-Dionna Glaze, PhD (she/her)

