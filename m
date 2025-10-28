Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B672CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd5S-0003oQ-QC; Tue, 28 Oct 2025 02:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd5H-0003lB-Mc
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd5D-0008F9-Sg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761632484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sFuj2530MIh854321LaAzcwpxFdazWrjdFWR9mQsJMU=;
 b=C6rwWJjWJeAeo5CIYJhds0qW9EP5tCBuckicqnL+sg91cDSZKWl7p+bwKSfUy9Slzl48br
 RCByo4DYzLT2iTxeIzZES5piZlrqkDdlDMRIFsqUI1Jgo+bWro/rzllPJ5H1KlBXfHMtQd
 tZxOjwer4helBHuy8GgJ1ljBoOwYZY4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-lP-Vh_LdOjaUEaZfND8xdQ-1; Tue, 28 Oct 2025 02:21:22 -0400
X-MC-Unique: lP-Vh_LdOjaUEaZfND8xdQ-1
X-Mimecast-MFC-AGG-ID: lP-Vh_LdOjaUEaZfND8xdQ_1761632481
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6ce15aaa99so4053843a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632481; x=1762237281;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFuj2530MIh854321LaAzcwpxFdazWrjdFWR9mQsJMU=;
 b=gtTUc8wNZKDRkfoB72p7UKcVgly3+FPAlFvrSykefsmOc/mjhWLyW4YWUgGu8J0nSD
 8vVGE5pYYzkwOSdatnqvSZkP+PCVMm5N6IxWwrp1tsduX/skWxD7+ChI6NbZ4OrEi6xL
 ZyfKAZm/7Jx2gYRAfmIe8yZphQLUFL1nvo3DJDDWnWgFhaaa9Sou65NmLaFJ5mymvloP
 fNDlookN1dFVCpiIabh2w71i20WKFJ+aTDJ/KEniZEF+r/YjH4qAnCvWY5/gv2uwFGts
 diDUE+VcTtOBUpDCxnRJXhHzjrLFaSGkef743sHQ++YE4JCeGTgBaHYhqJkH3Q6+RFgu
 NxHA==
X-Gm-Message-State: AOJu0YxX91JNyQ93aZDgcN1/gf5mZynhsO+oUo47JOFnMh5nza1JOLq8
 i87QIE4R8k8joRLyUUR+N/h7wOH+6lIoaGwiGxr8wOm/LJCPB60N43NdPKUZIJJyAWtyS7LJlz5
 AnOaId1PKU1mh0tbUTEL5EZH7hHtQsQ/gbdFckq5ECTiOSA14Mwev5dOJ
X-Gm-Gg: ASbGncuzk7o0sNqbUXtmClqkCTDBpqfAljDM5VZP2rGRRr00IPzldL0tx6taqpq5g+w
 T+nQXWGeKv0xdGqcDiHqs6lv/BK560lXtBRwgGNJtzKWq3usutoq8/YJfNX56KNOl9FwCGSiVuy
 SfcFySs5QvQu1T0ChK6pybreOBvwUMAjFTZrteKlX+bnzQU/VHeJRcziuZ0dfQ8ERe6gZOXs7zh
 ogm4FWBnqmQjLnhwnWKBF/nuivGip4AKj7lcAcpjL+8eL2zapnfsJzrh0t8RTneeL9Kd/5TE08O
 zHGm6MUrZaIDVjFPsUjiuiw7w00Rll7TGw6HQgNvh5GvZLE7J+9EWpc/X1iLMp2yBHB5iIoP2s7
 1ODEx3y88fziF
X-Received: by 2002:a17:902:b68c:b0:290:bd91:d81a with SMTP id
 d9443c01a7336-294cb3f1decmr21506365ad.39.1761632481511; 
 Mon, 27 Oct 2025 23:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfZnMbRhY7ecq6zReCCs70k0jN+BJ16K/vkYDwi0/9QJ8ngVDlEk2IuUrxb1pzMCW/MpWmXg==
X-Received: by 2002:a17:902:b68c:b0:290:bd91:d81a with SMTP id
 d9443c01a7336-294cb3f1decmr21506055ad.39.1761632481113; 
 Mon, 27 Oct 2025 23:21:21 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d40de4sm105463995ad.77.2025.10.27.23.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 23:21:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v2 0/2] migration: Fix error propagation regression and
 memory leak
Date: Tue, 28 Oct 2025 11:51:01 +0530
Message-Id: <20251028-solve_error_fatal_regression-v2-0-dab24c808a28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1gAGkC/42NQQqDMBQFryJ/3ZQktlq66j2KSDRPDVhTfiS0S
 O7e6Am6nIE3b6MAdgh0LzZiRBecXzLoU0H9ZJYRwtnMpKW+KqkvIvg5ogWz53Ywq5lbxsgI+1C
 UUtVVadHZ20A58WYM7nPkn03myYXV8/d4i2q3f4ajEkpYXaHqOytNjQfDTmY99/5FTUrpB47JP
 tHJAAAA
X-Change-ID: 20251024-solve_error_fatal_regression-301763debd8f
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=armenon@redhat.com;
 h=from:subject:message-id; bh=5fqHi42U+1OUPlqMAR8Vvp7KAwbHIOoGLJb8cVDxI+o=;
 b=kA0DAAoWanolONkPMo4ByyZiAGkAYNbIZ+QLwyyx1TZ/F82FfxspfBhrcHW6rURS4aUjBHrtl
 Yh1BAAWCgAdFiEEgPVQHYJQcVhZPenXanolONkPMo4FAmkAYNYACgkQanolONkPMo6wdgEAzdIg
 LfoiZaiA/jGBTQCt2q7npQvqdJB15xQ8ffYTUDUA/18YnrIjBQIGjD8ConN7KS2M70EJFe2d5Hz
 6GChXSYwF
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This series fixes the following:

commit c632ffbd74 introduced a regression of passing error_fatal
to vmstate_load_state() and vmstate_save_state() functions.
This will not allow us to propagate the error back to the caller.

commit 94272d9b45 introduced a memory leak in postcopy_ram_listen_thread().
We need to free the local_err object in the if clause as well.

---
Changes in v2:
- Refactoring of the return statement in virtio_gpu_load().
- Add another patch to fix the memory leak in postcopy_ram_listen_thread()
- Link to v1: https://lore.kernel.org/qemu-devel/20251024-solve_error_fatal_regression-v1-1-d26e6cbd0a7e@redhat.com

---
Arun Menon (2):
      migration: Fix regression of passing error_fatal into vmstate_load_state()
      migration: Fix memory leak in postcopy_ram_listen_thread()

 hw/display/virtio-gpu.c | 19 ++++++++++++++-----
 hw/pci/pci.c            | 13 +++++++++++--
 hw/s390x/virtio-ccw.c   | 15 +++++++++++++--
 hw/scsi/spapr_vscsi.c   |  9 +++++++--
 hw/virtio/virtio-mmio.c | 15 +++++++++++++--
 hw/virtio/virtio-pci.c  | 15 +++++++++++++--
 hw/virtio/virtio.c      | 10 +++++++---
 migration/savevm.c      |  1 +
 8 files changed, 79 insertions(+), 18 deletions(-)
---
base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
change-id: 20251024-solve_error_fatal_regression-301763debd8f

Best regards,
-- 
Arun Menon <armenon@redhat.com>


