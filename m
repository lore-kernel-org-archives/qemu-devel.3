Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC27606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqXMa6YF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVmKN-000847-DU; Tue, 24 Nov 2026 03:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xVmJu-0007vP-8y; Tue, 24 Nov 2026 03:56:10 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xVmJr-0007eY-BV; Tue, 24 Nov 2026 03:56:10 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3EFD43B84;
 Tue, 24 Nov 2026 08:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122E1F000D1;
 Tue, 24 Nov 2026 08:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795510564;
 bh=cYeNmvxJeXzS0rh58F+oqN582mVc1D8PcYhk/GQjCSs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gqXMa6YF8vNfFuVQpV6eRuHCrf4t4705fZpSF3t2aPCNZTpJ+x1CIlNiAhZKrwjZm
 Wc6zxRUAgjCO7FyJ4tVydE74tvEr0Uy1O0CT6cC3wgxgAKylgiNsc8HSqP8hMj7xJa
 2IkwpsZqT7QFvzEoQK3xQ0NHqrjK16A23Vkqbamy/+8XTD1YIAiN32oi/FNN6hBRBQ
 mMUzQOz/1TUlyVgUiUp8tnbZimWmF9/tlvwoWUB2cPo4yfuEDI0s31nSfmcUv1Y6tV
 Dt9skCNHKYkHx6g4t1aLh9Nyd3cykOdk7U0IyAq0hLRJxe2xCFx5pL+uyX5kEMUn2O
 LTzf2WeEH6X9w==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v18 07/10] qcow2: validate the write pointer table when
 opening an image
Date: Tue, 24 Nov 2026 09:55:26 +0100
Message-ID: <20261124085529.1537572-8-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124085529.1537572-1-cassel@kernel.org>
References: <20261124085529.1537572-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The write pointer table is image content, and qcow2_refresh_zonedmeta()
byte swaps it straight into bs->wps without looking at it. Every other
zoned field is checked before it becomes driver state, but the table that
those fields describe is not.

A write pointer is the offset that an append to its zone is written to.
qcow2_co_pwv_part() takes it as start_offset and only rejects a pointer
that reaches past the end of its zone, so a pointer that sits below the
start of its zone passes and the data is written into an earlier zone
that the guest never asked to write. The write pointer is then stored
back, spreading the damage. A pointer that is not sector aligned is
equally unusable: it is reported to a guest shifted right by
BDRV_SECTOR_BITS, so the guest is told about a position it can never
write to and the zone can only be recovered by resetting it.

Check the table against the geometry the header already declares: the
conventional bit is set for exactly the zones the header calls
conventional, a conventional zone records its own start, and the write
pointer of a sequential zone is sector aligned and within the writable
part of that zone, which is shorter for the last zone of an image whose
capacity is not a multiple of the zone size.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/qcow2.c                            | 67 ++++++++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2     | 22 ++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out |  7 +++
 3 files changed, 96 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index e2e946e604..9d3a7d3ccc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -520,6 +520,67 @@ qcow2_refresh_zonedmeta(BlockDriverState *bs)
     return 0;
 }
 
+/*
+ * The write pointer table is image content and cannot be trusted. Check it
+ * against the zone geometry, which qcow2_check_zone_options() has already
+ * validated. The write pointer of a zone is the offset that an append to that
+ * zone is written to, so a corrupted table would otherwise misdirect a write:
+ * qcow2_co_pwv_part() only rejects a pointer that reaches beyond the end of
+ * its zone, and one that points below the start of its zone would send the
+ * data to a zone that the guest never asked to write.
+ */
+static bool qcow2_check_zonedmeta(BlockDriverState *bs, Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t conv_zones = s->zoned_header.conventional_zones;
+    uint64_t zone_size = s->zoned_header.zone_size;
+    uint64_t capacity = (uint64_t)bs->total_sectors * BDRV_SECTOR_SIZE;
+
+    for (uint32_t i = 0; i < s->zoned_header.nr_zones; i++) {
+        uint64_t wp = bs->wps->wp[i];
+        uint64_t zone_start = (uint64_t)i * zone_size;
+        bool is_conv = QCOW2_ZT_IS_CONV(wp);
+        uint64_t zone_end;
+
+        if (is_conv != (i < conv_zones)) {
+            error_setg(errp, "Zone %" PRIu32 " contradicts the header, which "
+                       "declares the first %" PRIu32 " zones conventional",
+                       i, conv_zones);
+            return false;
+        }
+
+        if (is_conv) {
+            if (QCOW2_GET_WP(wp) != zone_start) {
+                error_setg(errp, "Conventional zone %" PRIu32 " has write "
+                           "pointer 0x%" PRIx64 " instead of the zone start "
+                           "0x%" PRIx64, i, (uint64_t)QCOW2_GET_WP(wp),
+                           zone_start);
+                return false;
+            }
+            continue;
+        }
+
+        /* The last zone is shorter when the capacity is not zone aligned */
+        zone_end = zone_start + MIN(s->zoned_header.zone_capacity,
+                                    capacity - zone_start);
+
+        if (wp < zone_start || wp > zone_end) {
+            error_setg(errp, "Zone %" PRIu32 " has write pointer 0x%" PRIx64
+                       " outside its writable range 0x%" PRIx64 "..0x%" PRIx64,
+                       i, wp, zone_start, zone_end);
+            return false;
+        }
+
+        if (!QEMU_IS_ALIGNED(wp, BDRV_SECTOR_SIZE)) {
+            error_setg(errp, "Zone %" PRIu32 " has write pointer 0x%" PRIx64
+                       " that is not sector aligned", i, wp);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 /*
  * Returns true if zone_opt is valid for an image with clusters of
  * @cluster_size bytes, false otherwise.
@@ -950,6 +1011,12 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 return ret;
             }
 
+            if (!qcow2_check_zonedmeta(bs, errp)) {
+                g_free(bs->wps);
+                bs->wps = NULL;
+                return -EINVAL;
+            }
+
             s->zone_list_entries = g_new0(Qcow2ZoneListEntry,
                                           zoned_ext.nr_zones);
             QTAILQ_INIT(&s->exp_open_zones);
diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
index f1f938fe40..bce97a6bf5 100755
--- a/tests/qemu-iotests/tests/zoned-qcow2
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -351,6 +351,28 @@ poke_file_be "$file_name" $wps_field 8 $wps
 echo "after restoring the offset:"
 $QEMU_IO $IMG -c "zrp 0 1"
 
+echo
+echo "case 10: a corrupted write pointer table is rejected"
+$QEMU_IO $IMG -c "zrs 0 768M"
+
+# Zone 3 starts at 0xc000000. A write pointer below the start of its own zone
+# is the dangerous one: an append would be redirected into an earlier zone.
+poke_file_be "$file_name" $((wps + 8 * 3)) 8 0
+$QEMU_IO $IMG -c "zrp 0 1"
+poke_file_be "$file_name" $((wps + 8 * 3)) 8 $((0xc000000))
+
+poke_file_be "$file_name" $((wps + 8 * 1)) 8 $((0x4000200 + 1))
+$QEMU_IO $IMG -c "zrp 0 1"
+poke_file_be "$file_name" $((wps + 8 * 1)) 8 $((0x4000000))
+
+# Set the conventional bit on a zone the header declares sequential
+poke_file_be "$file_name" $((wps + 8 * 2)) 1 $((0x80))
+$QEMU_IO $IMG -c "zrp 0 1"
+poke_file_be "$file_name" $((wps + 8 * 2)) 1 0
+
+echo "after restoring the table:"
+$QEMU_IO $IMG -c "zrp 0 1"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotests/tests/zoned-qcow2.out
index 8ae8323345..fb116e7ef5 100644
--- a/tests/qemu-iotests/tests/zoned-qcow2.out
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -257,4 +257,11 @@ qemu-io: can't open: Zoned metadata offset invalid
 qemu-io: can't open: Zoned metadata region exceeds the image file size
 after restoring the offset:
 start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+
+case 10: a corrupted write pointer table is rejected
+qemu-io: can't open: Zone 3 has write pointer 0x0 outside its writable range 0xc000000..0x10000000
+qemu-io: can't open: Zone 1 has write pointer 0x4000201 that is not sector aligned
+qemu-io: can't open: Zone 2 contradicts the header, which declares the first 0 zones conventional
+after restoring the table:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
 *** done
-- 
2.56.1


