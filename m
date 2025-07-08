Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5AC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG1O-0007Yd-4p; Tue, 08 Jul 2025 17:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFFm-0004aP-TP; Tue, 08 Jul 2025 16:49:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFFj-0003Hj-Ta; Tue, 08 Jul 2025 16:49:26 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso745867466b.3; 
 Tue, 08 Jul 2025 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752007761; x=1752612561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2g2vupcFVT83dTeIRjMpe9CpeCnq618xPyfNG6np5fk=;
 b=W5iCuq2vt4ZYvoIHdlJEz6/mUQc9Pi7NGhpDu5uD35U8d3/lg/SnVHpl71YSMfqo7K
 X/aKIQjFeaFPs/E2JCGbeheD2odsv9Za6coPoDds5zrZahwmqmx2+v/nO+wLJ1W3+wKu
 Bdm7pQhsqjRhPjdzGrCWB0LUQPU5/c/1oyZBNtAV1bVeLcKuAZ/AX0Uu12/eR5vRHPFU
 /91PuedDAUoFahMmhYdsnUSmbsxnijxJ0PbV79zumf1AVD5yz9shziSzf/bA7MSVebQi
 PhxVFh/ZF4/EBoYwlqmPEz9uyxMA25qo4/eAme1owhjO1DdHn7rjMMaIXk3euNWFne2f
 mNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007761; x=1752612561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2g2vupcFVT83dTeIRjMpe9CpeCnq618xPyfNG6np5fk=;
 b=qg4LcQIXB38rNNHlN07Yek3xmUghGuoMjP4McLPL/Ygl7wCSBejFk18ku+PC3WpnIy
 aDPsRehuYC93M3VGVBHRvDCARi3yT20rzPJZsIdpuGFhqMDgfn6OpZSxxBiZZ3KYw+w1
 rAUziDbLoESpuv91OA16DoVUBGl0uE9iFTKcilfHrwH6yQa7kk14hxmFE+VNC2+4pbt4
 vW+B3PFmJ0e+KfusFrAQ6KnuiZD+LV+hh6fnA8WWZ2ZdNfKLc6lBDmVfhW6OR/jyJ4tv
 vyuGdMeDInI+WZLqukmgHKaiINkwZzt9C8TNB2D8P6HG83fc8zf/NcwD/b3sQ90deF4u
 iCAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU8cjf4SUDVC6tNlcRNNYAnUPEq7J7J1Ng7Nco5XCH4uEJIuAbOX7+9pe+W5w+Ulx6aOlIpfAOGUo=@nongnu.org
X-Gm-Message-State: AOJu0Yzm7owR6Zls+LvNKeeHI7dthiKm3Qmdrw5vzf7OqF0h102msiBS
 Jg4mrYKVd867i4OSJ7N5C5rWPdwNuiDrayJrayPeYsMLAmXdgeUJeC/Fnxit8Q==
X-Gm-Gg: ASbGncuvJK+26V3MgB443Vg+GHBCqXsC60WQ6ymB7qcemqBbxOp/OCLDnUGhzZOlGOA
 nZuhf8jiSAhr9ceN/TmiainX2UaagW9iyOr86AeAb8aAHsmHgV7FYjKleNKsyv4a6PwErl7GH7q
 +3tv+wOu2omHN+/CYY8pQdz/9XPsNwzORSrwB5WqnwvTpAjs7wJHWAKeq/CdCNJIHqpwaBj4W2C
 DEKo1WE+a3GCo3rlw8OCF3sI2yHI1Zjr4MIVtogkeWkrvVL6+e2otsgwf/1MH6q0CNLxMkPcAz5
 0yi5igkfrAjxUAzV1pjXzh9P8akCMnokodoXuoNF7IA/9xhmPdTrF0oxeVPDBc+bqOsMKctL5K4
 umbSlLRHT4hnVxray9Sz9mG7ilsn3JMRCYEzC9kezn8rw8+A7jXvD7foGoZzZmPeraqDVqcQOHK
 O2HfTPtQ==
X-Google-Smtp-Source: AGHT+IFj/79km7AS/9Gq76dCR9RT5f8QC7HYk0MuWZKCFRjrQEsFiSY89wQiZfk06r0x4pDu4FFaNQ==
X-Received: by 2002:a17:907:7e8f:b0:ae3:dad1:70c8 with SMTP id
 a640c23a62f3a-ae6cf7a849emr497566b.42.1752007761132; 
 Tue, 08 Jul 2025 13:49:21 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-18f0-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f692fbddsm963788166b.62.2025.07.08.13.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:49:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] rust: Fix compilation with rustc v1.88
Date: Tue,  8 Jul 2025 22:49:07 +0200
Message-ID: <20250708204907.2178-1-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

Rustc v1.88 ships with a new lint `unnecessary_transmutes` which triggers the
following error when compiling code generated by bindgen:

  error: unnecessary transmute
     --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:792:18
      |
  792 |         unsafe { ::std::mem::transmute(self._bitfield_1.get(0usize, 24u8) as u32) }
      |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  help: replace this with: `u32::cast_signed(self._bitfield_1.get(0usize, 24u8) as u32)`
      |
      = note: `-D unnecessary-transmutes` implied by `-D warnings`
      = help: to override `-D warnings` add `#[allow(unnecessary_transmutes)]`

  error: unnecessary transmute
    --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:797:28
      |
  797 |             let val: u32 = ::std::mem::transmute(val);
      |                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  help: replace this with: `i32::cast_unsigned(val)`

  error: unnecessary transmute
     --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:804:13
      |
  804 | /             ::std::mem::transmute(<__BindgenBitfieldUnit<[u8; 3usize]>>::raw_get(
  805 | |                 ::std::ptr::addr_of!((*this)._bitfield_1),
  806 | |                 0usize,
  807 | |                 24u8,
  808 | |             ) as u32)
      | |_____________________^
      |
  help: replace this with
      |
  804 ~             u32::cast_signed(<__BindgenBitfieldUnit<[u8; 3usize]>>::raw_get(
  805 +                 ::std::ptr::addr_of!((*this)._bitfield_1),
  806 +                 0usize,
  807 +                 24u8,
  808 +             ) as u32)
      |

  error: unnecessary transmute
     --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:814:28
      |
  814 |             let val: u32 = ::std::mem::transmute(val);
      |                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  help: replace this with: `i32::cast_unsigned(val)`

  error: unnecessary transmute
     --> rust/qemu-api/libqemu_api.rlib.p/structured/bindings.inc.rs:827:41
      |
  827 |             let _flags2: u32 = unsafe { ::std::mem::transmute(_flags2) };
      |                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  help: replace this with: `i32::cast_unsigned(_flags2)`

  error: aborting due to 5 previous errors

Silence the lint in the generated code by adding it to the allow list.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 rust/qemu-api/src/bindings.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 057de4b646..3cdad0f0ec 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -6,6 +6,7 @@
     non_camel_case_types,
     non_snake_case,
     non_upper_case_globals,
+    unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
     clippy::pedantic,
     clippy::restriction,
-- 
2.50.0


