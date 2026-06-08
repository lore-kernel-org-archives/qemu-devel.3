Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC66ACD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWR8-0005gC-Jq; Mon, 08 Jun 2026 05:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWWR3-0005dY-Ai
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWWQz-0005U8-6y
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780911494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kppLJO0fX8gGVRKWJJztsqRrRPTzd1ASqdXx2FhnR+4=;
 b=FbKwT9JDJ4D0cuS/Lh5RdEi3aQJOFP1m4zER8ycN2Otw/BrIAFNqWAQ0Fi5/0jTpDd27QP
 /oyTHVuQLzJ+fFHf1Na8xEfHY+ovSEQMQdgP4LdPLZoWR9JZKQFIREBxC5NUfIErkQDig4
 MvDUxfJBHY3PakZ/ecp6F40bEIINuyg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-04MTLBRVOK29DPyBxSWK0A-1; Mon, 08 Jun 2026 05:38:12 -0400
X-MC-Unique: 04MTLBRVOK29DPyBxSWK0A-1
X-Mimecast-MFC-AGG-ID: 04MTLBRVOK29DPyBxSWK0A_1780911492
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45f3d008865so2929990f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780911491; x=1781516291; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kppLJO0fX8gGVRKWJJztsqRrRPTzd1ASqdXx2FhnR+4=;
 b=MsFSS14POOi+Vrruhyi+zKXFrgbnwa24Sw+hVsG7tC3YecYicLkgjeu6/+Jxu09I9H
 2zVrPMLazIF0YhmQql7tyF+1EjF0w1SMQ4TYwF91OuzSOzUviY7xqPMbSsEnvkc2vPtj
 mP+234UWpok3pP7PB1jCk8//rtO7H44EgN2NiX0bDD+dPpwAMnqqqfXDzFNqPJrzu0Tq
 rGIFo9Dl/LsDab0pFjL/H1rIH0vvUUnui6hFsPZXQ7zWOG2qNVh1NDtyHjpLMSteD5RL
 hZ+bez+KMqXHaDrlPjhXsCHHsmlCXaNGOkE7zCmri+pXnJCyRJhqhfNqAx76gInqR8GT
 j/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911491; x=1781516291;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kppLJO0fX8gGVRKWJJztsqRrRPTzd1ASqdXx2FhnR+4=;
 b=BGQli9DB8MoMR0uUyeExTEX+5/RHXOmjgdAb6ktSI31fVb/plBdQQl21xRF7uvFW0S
 sI4EPErKGulZEE57ZgJ109m3ONJf17HMeEC7dzSlPdwrLdwhjR0RNK6/yDK2dJL96wgA
 yNTmsj3AA0bpr/dABOY94QtgK6KxF8XpRGJynY/1qGNAWyoMWYmqsBhrKFxOWi6CuIHH
 mIUVB95gFf2Zn0BgRwB4DAhBbaul3b04XAHiKF9FC1nVzW+QJIc6upwjeoYqnGoJiAQz
 Rsht8hbTwbk0gTFo2lB/UTlDSTm63rIpqK/MTHvAJV78wNF8MndSCbKNvElQ3Dt3ebMS
 XQWQ==
X-Gm-Message-State: AOJu0YyNg26IonDRFFYpgl9JPPg6r56SbuTAifoJkrpDpys5rwNFVUd2
 kc9aFwqqJiaFj7LfV4v+0C7ja0ihPpvTS/BEs+Fd+1IKRtnI45gJal6r9DIu1H8GWaIsnSIkWEY
 VuYeXffkDKqpppiLKFH+Quu6pouskahhMkkiQOKQlZfEPI92H++KWKMWW
X-Gm-Gg: Acq92OHCpCmO9ztRfI+5dZ9YSPzpnLMfqnO5J1+zBeMs7pUo5/dmeQd1lkKpxt7/FPE
 sjns0NB05iHP4r04DWLaDXe0bkNLiVD77y4pwTGZQ9KrhJXkzqCA7MgNzYbAVSFpxAqNzBMswrh
 81DLtgkoy8TQ8wfeT1XwRUiCrtS+sX6LSoIhqJfcTKFeBz+Mkk5rD3zaN04ocwe88jJvwhd+8El
 FnFkCh2HksSfFu8UVaKPNp38tQ0v3QrZPO2mMqyET+JVb5CxM7GKb5IA5mKrl4uxC478L/k3cZX
 AKo1L6W1p7ly30zHna0lp14dWKgOZmr4YvXmhKA33UgKmo+rAC2CmHUdrWzaVcgDUUVEjxGICaA
 ifmr1p6s3F3dEuzpQsKD45jWOSrmRo5nW9G4xox3TRJVQoAsNIFQ+XytOFul2GWgvr0YZsekm0l
 mfdNBD7JMMuIwRwSgoKUOECOsZ2GU=
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id
 ffacd0b85a97d-46032b611d3mr21862787f8f.3.1780911491547; 
 Mon, 08 Jun 2026 02:38:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id
 ffacd0b85a97d-46032b611d3mr21862730f8f.3.1780911491132; 
 Mon, 08 Jun 2026 02:38:11 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm50144923f8f.21.2026.06.08.02.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:38:10 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/2] igvm: device tree support
Date: Mon, 08 Jun 2026 11:37:45 +0200
Message-Id: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMBAEvyJzNhAVQvArImJiq3NwYSIiBP/u4
 LHo6sqUIIxEbZFJcHPiY1eoyoLiOu4LDE/KVNvaWWe92TjKcW/DpHLEcAlgdGtiE6oA70ifp2D
 m5692/ft+mAR9RWUAAAA=
X-Change-ID: 20260608-microvm_device_tree-0263c3b1be86
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series consists of two patches:

The first patch packs the device tree for microvm. This is a soft
prerequisite for the next patch that exposes it via IGVM.
Currently the unpacked microvm device tree buffer occupies 1 MiB
(the default FDT_MAX_SIZE), while the actual content is well below
4096 bytes. Packing removes the unused space.

The second patch exposes the device tree via IGVM.

This will be consumed by Coconut SVSM with the upcoming device tree
support [1]. This will allow SVSM to run on a normal CPU (not AMD SEV-SNP)
and execute all its tests using upstream QEMU.

Eventually edk2 will also be able to consume DT via IGVM, but the work
has not started yet.

[1] https://github.com/coconut-svsm/svsm/pull/1006

To: qemu-devel@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Oliver Steffen <osteffen@redhat.com>

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      hw/i386/microvm: pack device tree
      igvm: Fill device tree IGVM parameter field on x86_64

 backends/igvm.c       |  2 ++
 hw/i386/microvm-dt.c  |  9 +++++++++
 include/system/igvm.h |  2 ++
 stubs/igvm.c          |  6 ++++++
 target/i386/igvm.c    | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+)
---
base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc
change-id: 20260608-microvm_device_tree-0263c3b1be86

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


