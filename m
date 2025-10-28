Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5863ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmG1-0007h4-Fw; Tue, 28 Oct 2025 12:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDmFo-0007g5-IW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:09:00 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDmFk-0008B3-Sx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:09:00 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A64E83F2EF
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761667732;
 bh=HMAH3SPkwY99wfIEsCRgGiy6p6Oz5j/29G/4FUed4yU=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=L5ZhnG2tO8N08gngK3tmXFzSHWSWF5dYDxNNTwDR619d3a5c9LZm1DwsepBgfqwsl
 apJEA52/66RVvLACYSEVp/K7m2ET+KqCcNmAeEIJEGRNHyTDz4sh3cBR3GLoOQTOmQ
 +3Z3PcqU72gAG8e96/aaTpAsDUztFe62wTTHevq5s7kAOdFRSUuJuJdAbhJNpAh8XR
 7JB0oSyz8NXAHj0JuSP19VhWLLHRVvnoB51N6/r2ZSwdeMimraCT6/fyl0dm/8p0VI
 JgOwsf4aaJ0zNlu3Z9Avm+1Pcwbn65oje04JQXtsafPtvIcIWH5Hqr+AUoVelNGl6a
 mptGVfDF5Z1b0x7ZslW/siPEQteC4O15SXJ0/DC2169n3vk89U3wlrdW5x1OXZjNH8
 g2LdvPpRk2/FisNJU6MBIw2v23ldQ4hajkEePuZdWDjMEXhpXIWHxJyABQoOH0ThTo
 xriTKM0skqWw5vLfkAKwAnqh/GHD3/wgz+rL3pNFZXazdlGCpIgBi1wjh5XvdjGN2C
 q28tLV95UQnH9DOroD7tRhLD5x7u5HSXe2myJlI3L06Hf2EwOWxgUIL+bocwC1eBPh
 LgfU1zhCvZn0KoOhPmQlIvSgzm5XdC7YCCyvgdBcHOFWfZFaUclHF3l2Vm+dSLo1EL
 kiODUOyHQHgw9G1mcf6Djs70=
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-430b3c32f75so64820295ab.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761667730; x=1762272530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMAH3SPkwY99wfIEsCRgGiy6p6Oz5j/29G/4FUed4yU=;
 b=TjellFIAdjpLJfiV2aO/ePmWQsFg0PJG4Wm1aJO5AVnaCRo7aN6hdMA3UXtlCNl1I3
 ngAlvHp2f4nLc5z9L6AAzv8C9GYpPZLf0eTD1rDg6aFRcCyCEVcmgkAAWOyUJNCuAetw
 EeIIPdMya0Bpn7x0XYrOHiRQrRf+pSmg6lZwplHqAmEKPkOuB9GRAdBpv/T/CgJY5HjF
 vqoz3XGZlQoI00mJhx5XZyJKA1N5uhbPaJRuwjb9ARPQbnJZAMA9t2E5MZpiGwfA70Jm
 RRdAfyU8jEMVPoqBhYB25iB7kqnOr5qwJbjZ83LACuOHvzDG3Pd8D9eIt4lCUB3X34JU
 duaQ==
X-Gm-Message-State: AOJu0YzMTmXEg1aUx9mFvZbO84c5vIfUDEapCDRWRFPZu8Dby60teMmv
 cV317rOKGPKeRO7uKY+99b5zcRLP8q7Op4BtI6tnUSGBdc8Wq+cyrPXJ/xGSHOVLa6d0w9RYGH5
 4CGZO6X4e6SpHRK7MEx9N9qDfmiXC/Ky6NO/Onl6sdpMY5ACUDY3SNYT4lmkBcvm8MykqHjdNQQ
 W+b9PW
X-Gm-Gg: ASbGncslPPfoXVo557/1f5OeO/OBGbv8IMqepbbtMq5QzCpcdHUTfCG/cBDrcpmiqtR
 XxsCwqwsKiDc1t8XV/ebWKdTK2iANwopx5iT4PWxOh3ZQAWuYE7bEDKZA+JkUNIIxu2nqTq1xR+
 m0KVz3GvYgqIy6xZ36/od5dwYEA1uvMUYUAVA4a1c0KcmeFOq8mm+n//dIsRm0rJ4PoUGFCg5G9
 /yFjx8jE1jwG0GO2m4J/mHVtTYc8PxPoToUAymnqoel2OuYqLmvpYDGoT/OqNuykdDI9BU4XImf
 7MqJn/EVhlww8uNKn23zGbisDEsYCcMIhV2JZeZRLa5Mymh9y+wFBJKzQ9tJt4DOAtnoay0/xp1
 dAnU6vqRicHrrMElC
X-Received: by 2002:a05:6e02:144f:b0:430:a66b:4ec1 with SMTP id
 e9e14a558f8ab-4320f79b2b0mr53714285ab.23.1761667729890; 
 Tue, 28 Oct 2025 09:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED6X5HJl0LRepFPuiI7L+/B3sZpnowkknrXUaRHjBhszMATptJsHboPVDWXgl79LiNNN18QQ==
X-Received: by 2002:a05:6e02:144f:b0:430:a66b:4ec1 with SMTP id
 e9e14a558f8ab-4320f79b2b0mr53713625ab.23.1761667729275; 
 Tue, 28 Oct 2025 09:08:49 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea9e35c4asm4558721173.56.2025.10.28.09.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:08:48 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 28 Oct 2025 11:08:21 -0500
Subject: [PATCH 1/2] iotests/257: Insert missing flush during blockdev-backup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-third-fix-3149-v1-1-bf3c712d2439@canonical.com>
References: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
In-Reply-To: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8993;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=E4NNWL7hhg+RvqhJWX/JvJuAXx4WG8wiWCfzbciBxe8=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBpAOqN0vqALwUJzNIwZdL1T0FsslvEn/Y6qRKBt
 /fc6NfL+LaJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaQDqjQAKCRD5KICs4jod
 udB7C/0ZVWDS+dHESgGjm8mFozIyh4hnGNru52Lt7ZJvzcB6/SmIN5vBXG7wLlmHxTXkFbh7f7W
 4G1Q/r33Ys+4klwy8CivVlYhGpWWMg5ZOE8H7IXpMy6AMWU1w3D09/vKfV/DjeD9II9qVPeUEUl
 +4YHrk2gt60qMJAuJoKzg0kjh26r5GEKH4ucD2jserQkczxx/TGOP4LCaI/FSHznLbMNgUBO3Ex
 w5pvXRfk9cuqe7DNnJuRO0Gqqa/oP88spvYK925WbVqD5DTVO3TF0ygtpnxjTEydRGPTQCpZXyT
 u0qtNIA5rInl1SAoJmwwo7Zt8xCK5BKYLS1oSQFg0PofSfWt2flmoRp28T4+B5I5aErHG57BJSQ
 +IcHhgEm1iUVAZdo6bVNdXEiidlLkic+NF9phVpNifkANZIGCvgkBi+WSiMxp6bjjZurcX9hWNg
 Zyvyx0V5N0BI1cYiAb5UGFAzMgHT6aq2PLrClVgnz4CIQL6h9g1/enzztlTd9m9eRB9xo=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The next patch causes a blockdev-backup job's copy-before-write filter
to hold references to its children until the filter is unref'd. This
causes an additional flush during bdrv_close.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 tests/qemu-iotests/257     |  8 ++++++--
 tests/qemu-iotests/257.out | 14 +++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 7d3720b8e593bbe17a4b49ac0f07e1d209bda820..cd0468aaa1621c195586379b09594a550ce7c18a 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -310,14 +310,18 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                     'state': 1,
                     'new_state': 2
                 }, {
-                    'event': 'read_aio',
+                    'event': 'flush_to_disk',
                     'state': 2,
                     'new_state': 3
+                }, {
+                    'event': "read_aio",
+                    'state': 3,
+                    'new_state': 4
                 }],
                 'inject-error': [{
                     'event': 'read_aio',
                     'errno': 5,
-                    'state': 3,
+                    'state': 4,
                     'immediately': False,
                     'once': True
                 }]
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c33dd7f3a907fd1212e7624b66d7a0937f37a1c7..fb28333cb2fab0e7f25990b889ae9253abcc40b8 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -272,7 +272,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -1017,7 +1017,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -1762,7 +1762,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -2507,7 +2507,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -3252,7 +3252,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -3997,7 +3997,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -4742,7 +4742,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---

-- 
2.51.0


