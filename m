Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FBAC021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4rf-0004Yi-UH; Thu, 20 Feb 2025 06:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl4re-0004YU-6f
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:37:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl4rb-0000px-Ph
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740051425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5BBqNP7nURydCkT5QDQjUCCwChA8frM+lCdM3VsFkeI=;
 b=TwFktT71otHO1n1YfXdqVQFtyXxd9UlDGIBmAsJU92Fq3zbozuFc4zECArURx2tNHuaYAd
 v5KhzFxyK++9HVm1O6LysZk7smN/wUePeAfiQU0VZBubtzAGzL6ibzNkC01Fgm8EJqBphu
 Ap7OuPUiLYPWoBDCspxgr5NqxrzV8T8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-yhM1xYZcMQSNHBmHJJGfSA-1; Thu, 20 Feb 2025 06:37:03 -0500
X-MC-Unique: yhM1xYZcMQSNHBmHJJGfSA-1
X-Mimecast-MFC-AGG-ID: yhM1xYZcMQSNHBmHJJGfSA_1740051422
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f3eb82fceso373699f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 03:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740051421; x=1740656221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5BBqNP7nURydCkT5QDQjUCCwChA8frM+lCdM3VsFkeI=;
 b=V3LRYDd9bphuDONWAmYnszfIt/UTjSuj8bPcMiPUyLs1czD0PYpjKhs67kEYgH1VyD
 CfJRDfeb+nSK2OoBfxTvPUYydT36J3LXGOTHeyqpP6mYjl1IDN3fcEnOA7EqKcORp7DR
 A+YR6fMUnNaGzS48I9dCyhtd4fhaW8I4T6dCy+FRdAWS3atzpokff0LezkU7l028v3ce
 J87IhpmODnBnA9BlReVS8+kuw/yXLFCTLSGbCzH8wh9CiWAeFhQLsF1X0T/78SlQy6qe
 Lk0OdmdHOu11kxsBLay06pPgdTCM2Lru9JkIk6iQz+VybzpPPXU/HfuMf21OwAvaE9y0
 ovxQ==
X-Gm-Message-State: AOJu0Yyl7BisdoRqgCIQv/PdxXNlL3iwqxc8RiOJ9qHY4nU2hp4dbumW
 DVmeMMTLSoP/V+TLs/m9xtua5/3F5llmIjxaHsw1jZyr1TVDZXzvfVuokGYtFd8XYvsxb4MdcMm
 3irYHkojSbGzAVh7ps+T2OGYV2sOhlOMdW48NU7yawsy3uCnbz2qj5FeVyY5WfAJ0IqcGq6w2cb
 TsRC6tEiP7+z48LWEKGqeNTB1HaWOZGqVoaVgchWQ=
X-Gm-Gg: ASbGncsCudPNgUxEI3+o6b+g1CEBQnwAkXjouMBw+dndeQEw64X6Y5R0vcaIwkBYkbp
 bfmFaFN5brUWXCJvNJHzDmp//qYpAaj+4wpA3q6PkiRKpAsgSBGyAAH07YuopjxKiTgXvGrtiEc
 qMg68sg/hakTHaBvRCTFqRGr7slTx5dQZ7qa26w6CDvluioSEji0hpUjK/uZ0J6YxhqmRp1MG0C
 rdlUQIpIR11WqXKPCxnI8zAHHFOxIMDJzLCYHTzQ+hMHjFqSrIvsZ8VLVu4SuUKXaMHnegBvN8/
 kYyob8T/u5g=
X-Received: by 2002:adf:e888:0:b0:38d:d932:d9a0 with SMTP id
 ffacd0b85a97d-38f33f58dc9mr15099895f8f.50.1740051421061; 
 Thu, 20 Feb 2025 03:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHemURzcezSq3bGtCbnoQtPmZco1h3SfYZfdtA/863ujjgqLDPdP/ZsWlC9VwmiNAZdwNl7sA==
X-Received: by 2002:adf:e888:0:b0:38d:d932:d9a0 with SMTP id
 ffacd0b85a97d-38f33f58dc9mr15099870f8f.50.1740051420604; 
 Thu, 20 Feb 2025 03:37:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7fe6sm20040095f8f.86.2025.02.20.03.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 03:37:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	kwolf@redhat.com
Subject: [PATCH v3 0/2] rust: add module to convert between success/-errno and
 io::Result conventions
Date: Thu, 20 Feb 2025 12:36:57 +0100
Message-ID: <20250220113659.863332-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wrap access to errno, for use in the block layer and character device
bindings.

This first version of errno.rs focuses on io::Result.  Kevin
suggested allowing conversion from io::Error to negative errno.
For now, I'd rather avoid that to encourage separation between code
that can propagate errors simply with "?", and code at the Rust/C
boundary that needs errno::into_neg_errno().  Since Rust code rarely
passes or returns Error objects that aren't part of a Result, it is
plausible that the same is true of QEMU.

However, if this turns out to be wrong, then it can be changed.

Paolo

Supersedes: <20250212093958.3703269-1-pbonzini@redhat.com>

v2->v3:
- add libc to subprojects/.gitignore
- change subject to reflect the focus to be Result rather than Error
- fix docs

v1->v2:
- use the libc crate
- provide separate From<Errno> implementation for io::ErrorKind
- hide GetErrno trait inside a submodule
- add into_neg_errno() and corresponding tests
- add more doctests
- make Errno field public, so that Errno can have other From<...>
  implementations (e.g. going from *mut Error to Errno).

Paolo Bonzini (2):
  rust: subprojects: add libc crate
  rust: add module to convert between success/-errno and io::Result

 docs/devel/rust.rst                           |   1 +
 rust/Cargo.lock                               |   7 +
 rust/qemu-api/Cargo.toml                      |   1 +
 rust/qemu-api/meson.build                     |   4 +
 rust/qemu-api/src/assertions.rs               |  28 ++
 rust/qemu-api/src/errno.rs                    | 343 ++++++++++++++++++
 rust/qemu-api/src/lib.rs                      |   1 +
 rust/qemu-api/src/prelude.rs                  |   2 +
 scripts/archive-source.sh                     |   2 +-
 scripts/make-release                          |   2 +-
 subprojects/.gitignore                        |   1 +
 subprojects/libc-0.2-rs.wrap                  |   7 +
 .../packagefiles/libc-0.2-rs/meson.build      |  37 ++
 13 files changed, 434 insertions(+), 2 deletions(-)
 create mode 100644 rust/qemu-api/src/errno.rs
 create mode 100644 subprojects/libc-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build

-- 
2.48.1


