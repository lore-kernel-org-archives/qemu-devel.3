Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2F9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 20:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryzw2-0007SJ-63; Mon, 22 Apr 2024 16:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw0-0007Ru-9H
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:40 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzvw-0004h1-Ti
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5878caeb9eso13246166b.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713816394; x=1714421194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sl26ga6h5Q58l/gzuVi4N+UzDwCYgBKrCTpcOsVn9/k=;
 b=dNGUAGHxo0UvJdbkzNAVZHgqPERSS+Opp6VDctGOUGM1JwWHSrVav+1Woy9Y8JfR/G
 9Htc5XIVAgZ8yhVWrT3TwUe7PnccBJyQcUx0FKD982+sgPNiP0qqKbCDKglbqD82m+kF
 BAHZIWjELNteUM+qtd+G+dzkAOqW3bcuhaEauwCVTu1rdnkN2j8TyIPhYqsijEJ7W5aA
 lhfYuKFWFpY26JRGpjDAnO6sq4OMWSfcuF3/ERNiHorSRnItY3/GHnME4IJkG/x9/0Kw
 bo+cg4Yf0GR83SJNISqcJl1A7bsA4etafibe9OsmNt6rFRlSMDKf/3MUxKdriDdkIviY
 lU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713816394; x=1714421194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sl26ga6h5Q58l/gzuVi4N+UzDwCYgBKrCTpcOsVn9/k=;
 b=fgmzYSZiDmnvHpzCaSiUD1qj7MoOsVtCzMzftOgMzFpXPXYy5ny6d9BWf8FhkF7wrD
 ou/c8UGww+/3ShUc3JlDX2lMKUop+5qHtCJ8Ovla3El8nzKinJ1yqdiL/1m38mdQEFIo
 QZKKtfWVyBJ4Bk03Lu3drbCuuScJAjAGXa8vGByrhCsE2J4gNoe3A9VA2JENuEUMKlhb
 mlNYKzjZVPYWthfDGrjumIiiTQS7a6bkWhIZsfwxYHuwYJ9eQpXNGFYjAOmUKHttRxyY
 zQgJCKajA+yYKxLG2x5kZoCUU+qgfUkptri38CX+e6AkzA1uJcJMzy3c2u1d7LkjGccM
 dK2w==
X-Gm-Message-State: AOJu0YytBuzhPaBe33OURZ4Gejqk7zDrD5yMJ4Y1mAFFAAgkC0AJmAm6
 Zmf3ZfJu4nmNK+JKte1+yfopgIY3b/IjJJz9vu0ohZEDgHQih3exMvyN1A==
X-Google-Smtp-Source: AGHT+IGF55KfhsCasp8cKQ5G1A4dhQJnpwAbF/dVxJIPG+h4IabPsI2GszbqZ9bDfSr0OByp5OODpw==
X-Received: by 2002:a17:906:ccc9:b0:a51:8d60:215a with SMTP id
 ot9-20020a170906ccc900b00a518d60215amr7034091ejb.27.1713816393591; 
 Mon, 22 Apr 2024 13:06:33 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-188-098-082.77.188.pool.telefonica.de. [77.188.98.82])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a17090665c200b00a55bbc4fd16sm1209230ejn.48.2024.04.22.13.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 13:06:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/4] X86: Alias isa-bios area and clean up
Date: Mon, 22 Apr 2024 22:06:21 +0200
Message-ID: <20240422200625.2768-1-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series changes the "isa-bios" MemoryRegion to be an alias rather than =
a=0D
copy in the pflash case. This fixes issuing pflash commands in the isa-bios=
=0D
region which matches real hardware and which some real-world legacy bioses =
I'm=0D
running rely on. Furthermore, aliasing in the isa-bios area is already the=
=0D
current behavior in the bios (a.k.a. ROM) case, so this series consolidates=
=0D
behavior.=0D
=0D
The consolidateion results in duplicate code which is resolved in the secon=
d=0D
half (patches 3 and 4) in this series.=0D
=0D
Question: AFAIU, patch 2 changes the behavior for SEV-enabled guests since =
the=0D
isa-bios area is now encrypted. Does this need compat machinery or is it a=
=0D
bugfix?=0D
=0D
Testing done:=0D
* `make check` with qemu-system-x86_64 (QEMU 8.2.2) installed. All tests=0D
  including migration tests pass.=0D
* `make check-avocado`=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
Bernhard Beschow (4):=0D
  hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()=0D
  hw/i386/pc_sysfw: Alias rather than copy isa-bios region=0D
  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()=0D
  hw/i386: Consolidate isa-bios creation=0D
=0D
 include/hw/i386/x86.h |  2 ++=0D
 hw/i386/pc_sysfw.c    | 38 ++++----------------------------------=0D
 hw/i386/x86.c         | 35 +++++++++++++++++++----------------=0D
 3 files changed, 25 insertions(+), 50 deletions(-)=0D
=0D
-- =0D
2.44.0=0D
=0D

