Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91D1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 19:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubPHq-0005CH-Hw; Mon, 14 Jul 2025 15:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ubO6Q-0002Ua-2s; Mon, 14 Jul 2025 14:40:38 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ubNx7-0004nz-AE; Mon, 14 Jul 2025 14:31:02 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae0dffaa8b2so921571766b.0; 
 Mon, 14 Jul 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752517858; x=1753122658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UDaLxDt7pCkG06zk8nYJQiI9Ye1w8YFGf5TfnP/8Es=;
 b=nWjdrfWqm6MWczlYJ26yypPkZR0BuWxgsStqoAKKvXnEXVkWl2AXmIODyRSO0B4rEt
 Zd5zCfSJ+TG4YXm/fAyIq+xmWXkRsicmBaFAHkiOFcWfW7S55+Mvmxp8zJG1/8yStT+N
 zW7a9s2pIVTRRAoNQWX+4PpAcceXZvqUZdd19dBtZzSHhlJgJaj1XUaVaooGBaRLKjos
 J3mjETeul1zxsqZ1wWq51jNtps694HqPm7Rcr//SVsb/N62QSli1AcmpjjgwuYv0+d3A
 6ZLMj1gSmgwWjnGWRiunjFXzCFxnYepG3RcOSpIeASKceJSXww64Y4D7OTFwoSfBIhGU
 RJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752517858; x=1753122658;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UDaLxDt7pCkG06zk8nYJQiI9Ye1w8YFGf5TfnP/8Es=;
 b=Ezeyf8bE5oHHclDoQoy0Wg8tRAmjmE4645TMf17J6cJtSNZpVpshR9p5NXca0+pczj
 NH3jqZaW7B0Q/nl8dw3zTjzk1D30mbQbp9YhYVQ7DGWojyYpFu4Q1FmyjW/x9iEA8IOE
 LizUa306pbK5UGptEvUixP+E9QOcbmaHhv9rGLU+RVae1lFnoAtvKpT15SH8KvudigTF
 9fZ/6IT+ZuEfzIMoB8Mla4D32ACz3IdqP6Go3MKJ3mokA874yWQMNZ8TTfqVTiA8bEgT
 M6mUU+/fjp6IlLPSudrigl7l42oOz8b+0OsoSaKmIdiuZ/liqlENB5zAY3AoxnlVKX1n
 iksA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB7eQUpd0nq37n4mFcfz5U4+SLCxo1y+/XQPKRW1iA8kLjmsU4XxNF/qIL1UzjPADHvsFBt7vLcQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzf9vAIHsdgEChpKmHfaRXjeidgkeaKKxQNY7afo9Du0KhqFIoe
 hiFtvzKVNvRPk1grhyXS2i1NgNhY0niuYZm7e048BnfKeJd4hmSxrBawQM+b5Q==
X-Gm-Gg: ASbGnctbFLBhCWin4TBQuQC58nPoBfklIQkC9WGjADPHWVJkSf56OUDm6Az0sKkssrc
 mdXZuGlLORv+Ebv/PNKwksYtDxXYW6BGcOJBm6IUxeGW0QZt5I2Gk+pJEHGaEgarJLcIganXWrH
 2J4FbC5aqg/cEmy9ZwJXbFXmoKUNxBktTfghdk/WucqHC8z+162bvcIipSlX21R0nX+jwE98UP0
 x8wusMHM4sbTJqgvSsu78bJZ8viy9Vph7SatHPqTWKBWH93gPVFR//HxP7nFzUKx0MOVzcvPzvn
 YH/Lfdjx9t1HtkaWQ1mv+82qh7oUGyAGGjol0rb6YmBVKKoXZ3U6Awt8Uv0S0S+0zelolZA9lLg
 4RokcPHotHqnw1ZuPOh5GvEAXMpxupRZfuCNqW9fFKFI0yIp2KhHZ3XJsdRjMudetjQF2yJ0bbA
 /j/pmqcN8AruRTp8D8H7sqI7Ck3DbDmQ==
X-Google-Smtp-Source: AGHT+IFcvPIcxAgKqHOJI8azPpAI7Qm1M+LhAZVJRYEkQvx73YZukApeDj7wQhS/jLGeuPeOggdmjg==
X-Received: by 2002:a17:907:6ea9:b0:ae3:bd96:78cd with SMTP id
 a640c23a62f3a-ae6fbc10ae7mr1476215966b.7.1752517858010; 
 Mon, 14 Jul 2025 11:30:58 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2f9c-9100-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:2f9c:9100:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae71c875129sm589056666b.17.2025.07.14.11.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 11:30:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:48:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 0/3] DTB build housekeeping
In-Reply-To: <20250708204806.1898-1-shentey@gmail.com>
References: <20250708204806.1898-1-shentey@gmail.com>
Message-ID: <550AFBF3-E264-4223-987D-D153FEF8957C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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



Am 8=2E Juli 2025 20:48:03 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>This series removes the bundled device tree blobs from the repository whi=
ch are
>redundant to the bundled device tree sources=2E To make this work, the de=
vice tree
>compiler 'dtc' is now required whenever libfdt is used=2E Furthermore, dt=
c can now
>be built from the bundled libfdt if needed=2E
>
>v2:
>* Allow building dtc from bundled libfdt (Paolo)
>* Find dtc iff libfdt is used (Paolo)
>* Remove dtc configure option (now obsolete)

Ping

>
>Bernhard Beschow (3):
>  hw/microblaze: Add missing FDT dependency
>  configure: Ensure existance of dtc when libfdt is used
>  pc-bios/dtb: Remove device tree blobs
>
> MAINTAINERS                                   |   2 +-
> meson=2Ebuild                                   |  16 +++--
> hw/microblaze/Kconfig                         |   4 +-
> pc-bios/dtb/bamboo=2Edtb                        | Bin 3211 -> 0 bytes
> pc-bios/dtb/canyonlands=2Edtb                   | Bin 9779 -> 0 bytes
> pc-bios/dtb/meson=2Ebuild                       |  17 ++---
> pc-bios/dtb/petalogix-ml605=2Edtb               | Bin 9882 -> 0 bytes
> pc-bios/dtb/petalogix-s3adsp1800=2Edtb          | Bin 8161 -> 0 bytes
> subprojects/dtc=2Ewrap                          |   1 +
> =2E=2E=2E/packagefiles/dtc-meson-override=2Epatch     |  62 ++++++++++++=
++++++
> 10 files changed, 85 insertions(+), 17 deletions(-)
> delete mode 100644 pc-bios/dtb/bamboo=2Edtb
> delete mode 100644 pc-bios/dtb/canyonlands=2Edtb
> delete mode 100644 pc-bios/dtb/petalogix-ml605=2Edtb
> delete mode 100644 pc-bios/dtb/petalogix-s3adsp1800=2Edtb
> create mode 100644 subprojects/packagefiles/dtc-meson-override=2Epatch
>

