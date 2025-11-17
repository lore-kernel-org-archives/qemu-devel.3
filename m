Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3470ECEBF93
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuu9-00042D-Bc; Mon, 17 Nov 2025 03:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuu2-000400-8h
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuu0-00070a-1a
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zj1nInfR3UeZsM3aae0qLP9sPE2mkuL4wOLQLqCpPY4=;
 b=fA8lvDwCxMfMma9V8BFXW9AMaQIfoLNMfd1/XhNCck0LG631L2mhVylnRdYYAbNZWbEb2b
 4PNP3J1WuE3QiVWVizfmf35ltBKBw6MnBHc3mhJjf02kXzMfXPskmctQduFA969qdOkKRR
 8BaRlH/rfMnFoodoxlR24HyQA2IIYCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-iWtvM_zRNCGujJuKxScbmw-1; Mon, 17 Nov 2025 03:47:57 -0500
X-MC-Unique: iWtvM_zRNCGujJuKxScbmw-1
X-Mimecast-MFC-AGG-ID: iWtvM_zRNCGujJuKxScbmw_1763369276
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b570776a3so1910159f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763369275; x=1763974075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zj1nInfR3UeZsM3aae0qLP9sPE2mkuL4wOLQLqCpPY4=;
 b=H9qL19GOPFRbTi992FLufau9yReuizlPE+/RT5+Go97CsjVzNfZe7+XdmdBUReHdn5
 P9TIXWrJZLxesvboi8B/4i8ljDBDa9obj4xdGbhEbKCNU5JRkTgQ06XdDOOZukr13El5
 oRwv6MBNfgwgp7oE4x4yepUhTmgPe958EzIhZSXw590duEY2CrHhQXekpA4qJ3nqkYNV
 Vxff9ylEhci3pAqV50EynteVRYQCQAGv0W6CObNe5DSrI8lP6maJAIrHeE79KwO9c2HX
 LO05JOtUtQwmWRi6pj6Ih/AoHQ43XtD3HqCsoi3DNcwzKqgHmqOq+d7p+d6+fqnaCb6B
 DGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369275; x=1763974075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zj1nInfR3UeZsM3aae0qLP9sPE2mkuL4wOLQLqCpPY4=;
 b=poZ899dhVkZHLkBB8akQHi07g8zocQlzJdznGh+fR8q1/q6iwYBaJefrhw3Txtf7qE
 9Wq9GIez/aW1B78k6wlxTlKwq2qkPPwUcSLpeAbNvE4AN5A28f5ZJtl+UUORhRXecdUi
 I6mbXzoH82o31eN9+yarR8uO/7PsfHdtIrBXY2KwxgaVmBXFFZyBHVwhZutdgjqS+4hE
 S+pLcNHefdssYBXcOobi2TXvYzffdYYoCH6cIMJPAAx1rmS3v7xzLD4LIep/gGTpxm1f
 23RZP8mOhNcq4P/PNVPkcxAHwul0JuN+X/bfj4NU1O1IuUcKQ0czyMaW6NLk+sicc9JJ
 mi2Q==
X-Gm-Message-State: AOJu0YzQQoM3YUlSepNRIDaT7Sjx5jgBiJw0N7DnMa6JW8JXlBEI/jlA
 lz0TUEQy49SI8fRvUEG2GnueFY5QjrCD5OZWHBDop9WuDG5W2DsicF/c30O5yuZMCgdJ8ctMtGJ
 aJwMfpssdmT3YEke/6LPndxmIpPmfSObTsygq85n7UXlF/lLCAXB/iQHpe7Izl1nBIGXj9VUA0a
 7cQ92JKjplV0ScSEpekgjvWdyjPVshyOxFToWoIUPD
X-Gm-Gg: ASbGncvhHxyNASKVlMl2LcsLBt8cZKzbWooRlhnqlYig5pHtjtCs/q5PkWRmzLWpQPc
 plo3iiUIFuN5TW6WzFUvWtrTkBZojHik4IVg2Zkfwx5MM+91+XocbGcsLa9X05vrGUHJ1t7UK5D
 If0YXVYZyKoAMOG3Pjs47yULQqtHaMS5nEgU6Nu3k2PMIjXpQSQg5YIo3GXNhI8q8pgcRCCLpxj
 jN+gflndukM6am4jOyRogVN4vqHf6KqpjHg/Xv5+D4mcWPkPcj37n+V/7FS3ooBpDDj9n6fQ7TA
 6Yw0R83/0ZPqUAWBnfl/1cXAKIbBpnLZ+BbnjGSglFBBt9iJTKzJ2QsT4cZXCZVImaQS5Ht3ql7
 1LoxYDL/3YreapAbZHSvquSqUDf4yD9QuSip+4xs5QZwh61RWinkgGwBz4rEtSYi+P3V+jTyj/2
 ssd2B2
X-Received: by 2002:a05:6000:2083:b0:42b:3867:b39c with SMTP id
 ffacd0b85a97d-42b593745c4mr10653768f8f.34.1763369275311; 
 Mon, 17 Nov 2025 00:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLS2FixPcIcpTS6ZXVj6ShIviFsRbRGTqL7Hk7+jFgEEjYIgwEIycjfWFHHRNMi+JWxaTBiA==
X-Received: by 2002:a05:6000:2083:b0:42b:3867:b39c with SMTP id
 ffacd0b85a97d-42b593745c4mr10653744f8f.34.1763369274798; 
 Mon, 17 Nov 2025 00:47:54 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e845bdsm24187986f8f.12.2025.11.17.00.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 00:47:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 0/5] rust/hpet: complete moving state out of HPETTimer
Date: Mon, 17 Nov 2025 09:47:47 +0100
Message-ID: <20251117084752.203219-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This state continues the cleanups of the HPET state, moving fields out of
BqlCells and into HPETRegisters and HPETTimerRegisters.  It also restores
the old migration format and shows an interesting trick: HPETTimer is now
a very simple object that handles the "unsafe" backreference from the
timer to the HPETState, but it also implements ToMigrationStateShared
and is stored in the HPETState as Migratable<[HPETTimer; N]>.  I find
it pretty cool that the composition works naturally.

The less beautiful part is that I had to modify Timer::init_full for
this to compile.  It's probably time to work on the final design for
initialization, because this is becoming very ad hoc and the differences
between timer, MemoryRegion and Clock initialization have no real
justification.

I'm leaving out the conversion to Mutex because, as Zhao noticed, it
has a deadlock - the timer callback tries to grab the HPET mutex inside
the BQL, where as the vCPU tries to grab the BQL inside the HPET mutex.
This is not present in the C code only because... it doesn't take the
lock at all in places where it should.  In particular hpet_timer() reads
and writes t->cmp and t->cmp64 outside the lock, while hpet_ram_write()
does so within the lock via hpet_set_timer().

Patch 4 ("rust: migration: implement ToMigrationState for Timer") is
still incomplete, and provided here as a starting point.

Please review!

Paolo

Paolo Bonzini (4):
  rust/hpet: move hidden registers to HPETTimerRegisters
  rust/hpet: move hpet_offset to HPETRegisters
  rust/hpet: remove BqlRefCell around HPETTimer
  rust: migration: implement ToMigrationState for Timer

Zhao Liu (1):
  rust/hpet: Apply Migratable<> wrapper and ToMigrationState

 rust/hw/timer/hpet/src/device.rs | 377 ++++++++++++++++++-------------
 rust/migration/src/migratable.rs |  31 +++
 rust/util/src/timer.rs           |  22 +-
 3 files changed, 264 insertions(+), 166 deletions(-)

-- 
2.51.1


