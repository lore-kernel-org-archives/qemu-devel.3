Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B63C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRT-0001Pt-Cn; Thu, 20 Jun 2024 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRS-0001Pd-1V
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRQ-0006WT-7B
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QCI976/3sOBC9H/aNjSRBPY5v3P4X1vwvF1rF8Dw3q0=;
 b=DTW6K47+y/HvNl+1m+qnUBIVRvjtC+9emahWm6Lfb3V+6fd3dneHoXxPOXHuJIBeZMnh4n
 df7zpqXSxDmVSsvaB2fFJOSLrDgjB4WZUlo4dlVNEaMfumzFmB3zGCcnWPMSscxNWTh4GI
 hENfxO7lSLpwqvajkNyMkSzzs8hDaUQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-oqaVSV3fNkWL_h_CcKqb1A-1; Thu, 20 Jun 2024 09:03:01 -0400
X-MC-Unique: oqaVSV3fNkWL_h_CcKqb1A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f1db7e425so53577766b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888579; x=1719493379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QCI976/3sOBC9H/aNjSRBPY5v3P4X1vwvF1rF8Dw3q0=;
 b=fuJHa3FfIySdpv0gW/BsGH21IozaVg2b/P0awlOCHXRfTzVA1GXxyf88MLqt/64dU1
 v2U5qUrswu5XgGZXLlcV6ZfBDpsFbpKxHUSZyFeMYmTG6MFMNbCKYIAFnWhtM0FzlMin
 kWcyKwtgta53kZrcQUxtQOBxZG5enqG0OmkZFzUz697WP8MZjyJUQX12WGHJI3+5BE2Z
 KV42yBlNemRaHibAjTBufx0MNwTc72ubQc3LFHf0TusvHSxGztpT1Anal40/0veyqFzZ
 WJTloz5oRLHeTmWD9jkAOyjpW0a4yNKzXxCDjHxKPFHpgWYMv/yo/C7r0/f2WRYN4FAp
 s6AA==
X-Gm-Message-State: AOJu0YyexvSd83u56xVw23fOcoRqBIl5CYaDJYcgNtG7U/H4FP4kz7BL
 zpD57kOZuVwwA2Dr2iaRpQIpg/YzjGcu5y6W2fB0BkcIHLH21jRXzciWBC0AcyAkurINgHQW4nW
 l+sRfgtoors8ZxIbTIwhBQ8W5xanBqyYVYe7ziROjnrYf8e+K1CYGBNapNVyb6yHR3B/pXrcXz3
 wTUnrm9wnTobJvHfhWGE8P+NG+KTc+7Wou9vqY
X-Received: by 2002:a17:906:1359:b0:a6f:5f26:4d91 with SMTP id
 a640c23a62f3a-a6fab7d14f7mr333905366b.69.1718888579140; 
 Thu, 20 Jun 2024 06:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfQWeklky7wgsg2sBmX8DsrVun3SL5HuxQ3LhqBV+ScAkbmCuB0nnILN1m5Tv2o9STIC+6jQ==
X-Received: by 2002:a17:906:1359:b0:a6f:5f26:4d91 with SMTP id
 a640c23a62f3a-a6fab7d14f7mr333902866b.69.1718888578617; 
 Thu, 20 Jun 2024 06:02:58 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f8a6e58bdsm344477466b.187.2024.06.20.06.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:02:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 0/6] host/i386: allow configuring the x86-64 baseline
Date: Thu, 20 Jun 2024 15:02:48 +0200
Message-ID: <20240620130254.415699-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As discussed, add a Meson option to configure which x86-64 instruction
set to use.  QEMU will now default to x86-64-v1 + cmpxchg16b for
64-bit builds (that corresponds to a Pentium 4 for 32-bit builds).

The baseline can be tuned down to Pentium Pro for 32-bit builds (with
-Dx86_version=0), or up as desired.

Patch "host/i386: assume presence of CMOV" is not reverted because
CMOV appeared first in the Pentium Pro.

Paolo

Paolo Bonzini (6):
  Revert "host/i386: assume presence of POPCNT"
  Revert "host/i386: assume presence of SSSE3"
  Revert "host/i386: assume presence of SSE2"
  meson: allow configuring the x86-64 baseline
  meson: remove dead optimization option
  meson: require compiler support for chosen x86-64 instructions

 meson.build                      | 56 ++++++++++++++++++++------------
 host/include/i386/host/cpuinfo.h |  2 ++
 tcg/i386/tcg-target.h            |  5 +--
 util/bufferiszero.c              |  4 +--
 util/cpuinfo-i386.c              |  6 ++--
 meson_options.txt                |  5 +--
 scripts/meson-buildoptions.sh    |  3 ++
 7 files changed, 52 insertions(+), 29 deletions(-)

-- 
2.45.2


