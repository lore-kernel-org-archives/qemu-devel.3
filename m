Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34567C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx255-00018l-1I; Thu, 20 Aug 2026 08:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernard.ladenthin@gmail.com>)
 id 1wx1rN-0003MU-BT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:27:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bernard.ladenthin@gmail.com>)
 id 1wx1rL-0003H1-JX
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:27:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so20976275e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787228822; x=1787833622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uvkTa9HSmLbrSKlwI2txI/oZG1ylV/9AWP+TfHOeDKM=;
 b=h7HiMBp7hISfU0LdS+VDHgRcp/ihQUkLsMn7AzyVnyv6bF4ts1aJJgRdUFZXQxr/13
 LKUwiZKr6M5z2Wstw9iiFy5PIYG8ViPubBIrRq6LEKiDfTzfkW2qRcpeWZvcC5I2TlE2
 f+Auk5AsAplpiTpp4bXauoCn+HYyhXG+mtkCPhXsAgRIl6bNHgWUyoDHzt5POWedojCA
 qVfqSgtXo0fBGyZ7MCUw49RRGz0KLx/525r4kp7lLLE53BnWK//ePF/ncvLz1Inxnp1+
 cyqzOHpdpkYQj1iJq5+vDlrOX12SJJ5Q14nNAX05DymCjiMRls3BnZ1e0fmaqUwTHQAD
 +qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228822; x=1787833622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uvkTa9HSmLbrSKlwI2txI/oZG1ylV/9AWP+TfHOeDKM=;
 b=gn3f9KxjqI8xCpHT26TFdL0l48fO8CHGb+dJM8CTIw5GGfheZtHjAKqJzQlIufVB+G
 Hwm+ixHEAAnr/ET5cUA6vcIqRHGAPuB8tVnmWz7seosong929qJAECmDibqMP/901ATr
 ZgAOzt69J4RGdPL4EDUE//tXi1lztj5Ci71jU9F7Y8HEHa8t0Dx8scfPAQuSxAPROcS0
 a05+hAcRbqZsu+IU6TWG1lCOFRB1weeE1eWSvb1+eY7S0d4QKivc+vH/6HGezmM0z4am
 JuzkZXD16bB4zX+SwD8jDd1/gd7nEmhMQ6KXbrSBlu9NmjzrUGZaG4sK38qU0zCt6cjb
 8OuQ==
X-Gm-Message-State: AOJu0Yw2ESvTD/smalHuL8V/O49r0bIBW5HrspD5eZBMrAK/HVvUaYOG
 r2v+3UIEGXBjPD8ijx2ebzEWOlR21H30Xp61+y7If6QnK0T4vgEUlp1voci/Najv
X-Gm-Gg: AR+sD11ZeB0xGJi+qq7bj+1BEHUatjlJua9BdDOqy1b5vL3Q+3qzNjQyjyRfiyodM77
 MbDYPAG1JX4Gwuk0fqSAPOsxE7Hch1In2AZbwBmTWz5rIrIHQHeBdgaTN6UE6cI+Yjg1Mr1dAyR
 1dRDUFj1D5LtJP7Wfyh7A3ZdnpR5uBGtNp23iUCu1TWa373/Ue4nz7Gem6YGbJvv5rDdil6To5h
 tGBFTJOMs1dnGahN9qM5U3/GKkr94vApqUv+ClcI7tR2hiKaKXCmnyo1FVoW+fkz2txnhxJYya4
 qU9cUqETkXTVuEnfp42xahJ5F4I0NKDDKep0+IVKYB7qUmP3DLQBRH5Efauhvi33I5NVVo9qRHS
 xz5ncdfEuh9k8+TvZjQRxC6ugNpjNnRTGAsvebF/wUvDw5TvgmgDB7tXaRiu0WebJ8fTwJT0eu4
 mjm6HzuAldVx6gIj5+n9hzeyS8/YlKLps7b2ss/hNEoavSp9cGyjCig6TKdK9NW7jaO6/IXxCSB
 fNJBO+atQlv6hYDbX6NA0B8QDbLi7i4SQxiaA7VusNqGA8PghMfa5z1pH+g4vW+Ut9b5LDfzCUV
 MWafk6qNkMNgOwiO/HCZU+0opOoBoONDspOh1GugnqmhbGDArnihzoCBYYEbmqptMphk
X-Received: by 2002:a05:600c:a012:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499aa180132mr242174765e9.1.1787228821103; 
 Thu, 20 Aug 2026 05:27:01 -0700 (PDT)
Received: from localhost.localdomain
 (p2003010827046e07f1219fbed82e562c.dip0.t-ipconnect.de.
 [2003:108:2704:6e07:f121:9fbe:d82e:562c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8022sm10536183f8f.18.2026.08.20.05.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:27:00 -0700 (PDT)
From: Bernard Ladenthin <bernard.ladenthin@gmail.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 Bernard Ladenthin <bernard.ladenthin@gmail.com>
Subject: [PATCH 0/2] spapr_vscsi: fix silent data corruption above 128 KiB
Date: Thu, 20 Aug 2026 14:26:42 +0200
Message-ID: <20260820122644.19691-1-bernard.ladenthin@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=bernard.ladenthin@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:41:07 -0400
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

struct vscsi_req::cur_desc_offset is uint16_t. scsi-disk delivers a command
in SCSI_DMA_BUF_SIZE (128 KiB) chunks, so vscsi_srp_direct_data() adds
0x20000 to it on the first chunk and it wraps back to zero. Every following
chunk of the same command is then DMA'd over the start of the guest buffer:
the tail of the transfer overwrites the head, and the rest is never written
at all. The command completes with status 0 and no sense data, so the guest
has no way to notice.

Linux never hits it. Its ibmvscsi initiator uses INDIRECT descriptors for
anything multi-page, and that path resets cur_desc_offset at every
descriptor boundary, so the counter never reaches 65536. A guest that
describes the whole transfer with one DIRECT descriptor and issues 256 KiB
commands hits it on the first command. The field has been uint16_t since it
was introduced in 2013.

Patch 1 widens it. struct srp_direct_buf.len is already uint32_t and
vscsi_fetch_desc() already takes buf_offset as unsigned, so that is the
whole change. The VMSTATE entries for cur_desc_num/cur_desc_offset are
commented out upstream, so the migration format is unaffected.

Patch 2 adds the reproducer. It is a bare-metal PowerPC payload booted with
-kernel on -M pseries that speaks CRQ and SRP directly, with no guest
operating system involved, so a failure is attributable to one function in
QEMU rather than to something a kernel did on the way there. The fix comes
first, so the tree is never left with a failing test, but the test applies
on its own if a reviewer wants to put it first and watch it fail.

Testing. Against unpatched master the test reports 2 passed, 2 failed: the
two controls hold -- the CRQ registers and the 256 KiB READ_10 completes
with SRP status 0 -- and exactly the two assertions about where the data
landed fail. With patch 1 it reports 4 passed, 0 failed. Both runs use the
same payload and the same script; only qemu-system-ppc64 differs. Each
patch was also confirmed to apply and compile on its own against master.

The committed ELF is 920 bytes and its source rebuilds to it byte for byte;
"make check-reproducible" is there so the .S and the .elf cannot drift apart
unnoticed. tests/multiboot is the precedent for committing a built payload
and running it from a standalone script rather than a meson target.

The bug was found while trying to boot AIX 5.3 on -M pseries, where liblvm
reads a volume group descriptor area in one 256 KiB command and gets the
second half of it at offset 0. That is not needed to see the problem and is
not part of this series; the reproducer needs no guest at all.

Bernard Ladenthin (2):
  spapr_vscsi: fix data corruption on transfers above 128 KiB
  tests/spapr: add bare-metal reproducers for pseries machine behaviour

 MAINTAINERS              |   1 +
 hw/scsi/spapr_vscsi.c    |   9 +-
 tests/spapr/Makefile     |  62 ++++++++++
 tests/spapr/link.ld      |   3 +
 tests/spapr/run_test.sh  | 108 ++++++++++++++++
 tests/spapr/vscsibig.S   | 285 +++++++++++++++++++++++++++++++++++++++++++
 tests/spapr/vscsibig.elf | Bin 0 -> 920 bytes
 7 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 tests/spapr/Makefile
 create mode 100644 tests/spapr/link.ld
 create mode 100755 tests/spapr/run_test.sh
 create mode 100644 tests/spapr/vscsibig.S
 create mode 100644 tests/spapr/vscsibig.elf

--
2.47.3

