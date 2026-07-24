Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0EC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFWK-0002NR-QA; Fri, 24 Jul 2026 09:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWJ-0002FZ-5S
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWG-0002bC-Sl
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MO7147FECvFuDxjWBOjEQ4Gl9A4ouJbHyFOFNr1XOQY=;
 b=jJQwZJsG9kxJRLuoi9kYL+fknNmFbZ9hg7Y8ZBLiX/wE9lP5S0si7C+yYML5vYHTUpX4aR
 /VkLRrUQyQRMdbU/a/Q/KFDFnWwASLgfKsSnmc1KYXjDcAxGsfGi8X4z8jqxoJyK0x8sAk
 IpPQl9rR9K6qj5rYnOm7qAb9sOpU78w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-k8h7F9Z3Oy2xem0OvEuhBg-1; Fri, 24 Jul 2026 09:00:48 -0400
X-MC-Unique: k8h7F9Z3Oy2xem0OvEuhBg-1
X-Mimecast-MFC-AGG-ID: k8h7F9Z3Oy2xem0OvEuhBg_1784898047
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49554715277so4482605e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898047; x=1785502847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MO7147FECvFuDxjWBOjEQ4Gl9A4ouJbHyFOFNr1XOQY=;
 b=BX+D6BcwBR/Dz0N3GNyu+B1N4Jj3UdMu1y2moCEWmMTBZAemvzSnOOSb3a3Z8U0QDU
 0ZDniHkZd11zfVCoxR9NFh2uKXCNZYKQhPONGFWwdpeUNrt/jX0XNF1dOXGlOjMSAG6o
 urk3WxEd4ivKTCyCKAG8Qcs2Mn2qAdJUheDKBLT/UEbJKLLjnjpFsaE2wsTPuMtLVa4J
 A3PcitaB4XpZabX3l3x2ocM0lO38FhaucY1gC9XW0CbZ974JkJlY7o3oLiCQ4b6YMe5A
 5kyY8qA5MBF1EjZP1JAdnkSjmVa7U9zkgoUH/xysxrLphzHGqIdBYdux7iPWZei25tYK
 Wmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898047; x=1785502847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MO7147FECvFuDxjWBOjEQ4Gl9A4ouJbHyFOFNr1XOQY=;
 b=JbJATsWwkR+bc7cCATO7vCz5xvhy+tDqwFcrzXNqI3x2btOKzgj9AwKnr2Rk1Ahy//
 QffcoS413BfNYGcjZWHnQxOEV5jRBzwkZ0IEPmpuTwFhy/jxNm2OfeJhxgkpeS9i9bCl
 pfrqM7ovf3sf5jBpFesyMPmzIljaZoN7uwfOMtDzvwI+W5khS4qllLBDMpgE6IGVyQK7
 enw94t0wojxkJDP3XWCdJ+iHta5TXFq61/NXhUiTjiJT7v8OJR6tO309Gb034BCJZdxK
 St+EzWDlbYdfpNSI6zdsbp75tdLhhMZhtumZKvtAkL2Lm/o2vhXnvY3CsVygMJarX3I+
 bNiA==
X-Gm-Message-State: AOJu0YzPRchmNI1SteEbmq1BM7A6zI68kzrQf5aDOABIdn2EcJBZjL2+
 3R+nwEGl7T7FvnUClWo5WC11aoTMJM9LxiHnaGV/JItkbEvt1AZ/1BU09eg0xg0S60QSr6UOw/Q
 h5odZobG+4mDWfA8OwoUGfDHQo7LR/JXsVH8y0aT0Byz+BUiIigN2c0t154LsKiXEYB40W97D8I
 ADj9yNibp2DveTz4ZgS2aJUPjeePzduTZuj+WgGELL
X-Gm-Gg: AR+sD113oobTOzEDiN3zNqion/4rKXYIeTtSk9lhXI49nVNdNLPCeHjVMnP8kaRaiZJ
 Phsqpw/LjSSt2BYVPY+Nu7+eu5Z5BgubcivR9kv4ssV4gYfZ+xiSc0xZInzTt4DoAdJv8nYc43i
 ENnQAuTpx6mvPgHAwgO2d4vysXudsEZK3UArYBbOWEVu5pVAWl/aX9J+qFSsUevMqDZ9Q4k0WPM
 OPMtQ9AzrlDhbWfcdNt/7PvRbviCex4VfEMF0fueJBsxT/9NCC7Ij2UMdE2E6fo5TE+2hK8iFWN
 6GtK6SpHGDdI9jaAL4zlZXjn/rUNxZk1CTaH2AyEqexJJ9nT/qett5Q83PgS3dl+uKs0uRRfBV6
 UKFvNQx6Bin1nxfCPzMKQqrCNAthEzbeRrmJ0VERaoRE9xSgB7abmmyMCO5YESZ818ipBMB5ccm
 yt1Q2o
X-Received: by 2002:a05:600c:5246:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-49573d21d8emr83230755e9.37.1784898047010; 
 Fri, 24 Jul 2026 06:00:47 -0700 (PDT)
X-Received: by 2002:a05:600c:5246:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-49573d21d8emr83229275e9.37.1784898046048; 
 Fri, 24 Jul 2026 06:00:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af910besm83551215e9.14.2026.07.24.06.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH resend 0/3] scripts/qapi: non-Rust-specific preparatory patches
Date: Fri, 24 Jul 2026 15:00:40 +0200
Message-ID: <20260724130044.1369843-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series include a few small QAPI patches extracted out of the Rust
series.

The first two tighten the language in ways that are necessary for Rust (the
structs would not be representable) but probably a good idea in general.

The last one moves C-specific knowledge out of functions with a generic
name.

Paolo

Paolo Bonzini (3):
  scripts/qapi: enum with conditional first item must be optional
  scripts/qapi: reject empty enums
  scripts/qapi: pull c_name and lstrip from camel_to_upper to caller

 scripts/qapi/common.py                        |  4 ++--
 scripts/qapi/schema.py                        | 12 ++++++++++++
 tests/qapi-schema/doc-good.json               | 16 ++++++++--------
 tests/qapi-schema/doc-good.out                | 12 ++++++------
 tests/qapi-schema/doc-good.txt                |  8 ++++----
 tests/qapi-schema/enum-empty.err              |  2 ++
 tests/qapi-schema/enum-empty.json             |  2 ++
 tests/qapi-schema/enum-empty.out              |  0
 tests/qapi-schema/enum-if-first-required.err  |  2 ++
 tests/qapi-schema/enum-if-first-required.json |  6 ++++++
 tests/qapi-schema/enum-if-first-required.out  |  0
 tests/qapi-schema/meson.build                 |  2 ++
 tests/qapi-schema/qapi-schema-test.json       |  3 ---
 tests/qapi-schema/qapi-schema-test.out        |  1 -
 tests/qapi-schema/union-empty-if.err          |  2 ++
 tests/qapi-schema/union-empty-if.json         |  6 ++++++
 tests/qapi-schema/union-empty-if.out          |  0
 tests/qapi-schema/union-empty.err             |  4 ++--
 18 files changed, 56 insertions(+), 26 deletions(-)
 create mode 100644 tests/qapi-schema/enum-empty.err
 create mode 100644 tests/qapi-schema/enum-empty.json
 create mode 100644 tests/qapi-schema/enum-empty.out
 create mode 100644 tests/qapi-schema/enum-if-first-required.err
 create mode 100644 tests/qapi-schema/enum-if-first-required.json
 create mode 100644 tests/qapi-schema/enum-if-first-required.out
 create mode 100644 tests/qapi-schema/union-empty-if.err
 create mode 100644 tests/qapi-schema/union-empty-if.json
 create mode 100644 tests/qapi-schema/union-empty-if.out

-- 
2.55.0


