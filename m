Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D94C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 16:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUr7Z-0001Q1-7R; Tue, 30 Jan 2024 11:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rUr7X-0001PH-Hw
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:37:59 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rUr7V-0005pW-I0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:37:59 -0500
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-0Cq1PfI_MEqMDL4w0X1CrA-1; Tue, 30 Jan 2024 11:37:45 -0500
X-MC-Unique: 0Cq1PfI_MEqMDL4w0X1CrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25D45837227;
 Tue, 30 Jan 2024 16:37:45 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 761988C11;
 Tue, 30 Jan 2024 16:37:42 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 0/3] acpi-build: Fix hint messages
Date: Tue, 30 Jan 2024 17:37:38 +0100
Message-ID: <20240130163741.145925-1-groug@kaod.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

ACPI build for ARM, i386 and Loongarch all have the=0D
same warning report with a hint for the user. The=0D
hint is printed with error_printf() as expected but=0D
it lacks the terminating '\n'.=0D
=0D
v2:=0D
- s/error_fprintf/error_printf in commit logs (Ani)=0D
=0D
Greg Kurz (3):=0D
  hw/i386: Add `\n` to hint message=0D
  hw/loongarch: Add `\n` to hint message=0D
  hw/arm: Add `\n` to hint message=0D
=0D
 hw/arm/virt-acpi-build.c  | 2 +-=0D
 hw/i386/acpi-build.c      | 4 ++--=0D
 hw/loongarch/acpi-build.c | 2 +-=0D
 3 files changed, 4 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D


