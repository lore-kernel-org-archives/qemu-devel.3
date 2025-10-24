Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB00CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMCO-0004Pb-Bi; Fri, 24 Oct 2025 14:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vCMCL-0004Oz-VG
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:07:33 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vCMCJ-00062r-7y
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:07:33 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 40F873FCEF
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761329248;
 bh=jGBTpgxaWd9BNfOkrmxqe8GIY4UBuLK9jHD5a24y3QQ=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=oJTbeUSHTf2lPaxEqqZzYN58vQPIJKi2OSZZktKePaTWpZ/rOnqoEQVLeaDT80/1b
 la0pq5IxOx1Z8hxFzfu5Z1stCoqe6OnVFtMNCk0oL3/508fye5rajlG6Q7LnM4ZxTM
 3qg0bBrTdIfMRDLHjsaZFDhvl73fg14q71zFIYsObcPykTi67a4KevmgBNLZ61yLZA
 kNGqG8ozuGYOS+4nL1NsVJR75PUXDqONqqnYDNX/IGCNnqknb8P9aWu6IG/+Rx8Zj1
 7tm3sJA+Wtxdo1BAHVSctzKIVSZdQKXNcRfqKvdlJvA2RpPCVqNOJkmnQ+pqMku6Kf
 AXcymPFlS0V1ahh4cmvRxUS9jD06xmylbzxI9e7wW6XRFwhkewWKlWWHeXJOgXMl6u
 VVtxXcp9Il9zoQ9b8cWNBfKByC8fEbld2lIv4xOE1vvLFVEg9Whmc0ihuBHrINnEhD
 VFQRnzoV7Q/hIBP7kovav7ZYwyZfC6xYQkwbiuXSca9yDslvuY1D5vB5R517HK8gfH
 VJCXMCA/1Wq5pWIUMILuHKWh5p21FkUsCTM1kiKAuROgUA6r4r+jq13Tr3n/tTOSFN
 /7PssJ0mm6wir/g4Csoli/0xrzhmll9dZmbDW08oRJNtlvM+Ut/qZcidXpd1KaZMiJ
 zsqZkznQE7jtBJPPmPScMhXc=
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-940f5d522efso632642239f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 11:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761329246; x=1761934046;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGBTpgxaWd9BNfOkrmxqe8GIY4UBuLK9jHD5a24y3QQ=;
 b=QTU+MHfC4Of90psNjKmdZr7ygtYjsbqQnntWhbcGCg16Swh+HCoFGbhe7WYqkeqasQ
 Pwos5NC/P9QZNGVMCPwMVy22xDhvxFxgaBV8LnGE5nbv+ffToXAx11jheY9/gcMZHmie
 wD53zgveIuBYd2BczSHKw00SadaDLg+az6mak4j50GiwqOh34w5HXrSjKF0k6TX9QoyP
 LsI9uACeBuR3UT0KVSSO4Nk23f3gcSvg/UfRjRHYF/i4fvdPQfK1Q/WmlJFN2er1+aVW
 t1rXvn/Ym12NiljWDzxJjbwfStsVn/g0gNsSVjxFDl4ZU6Vk58sOc8hMl2Ppzm9mYrVs
 i6Cw==
X-Gm-Message-State: AOJu0YwbHC5R2Un1VjBTRj582BcCloYtBMO4RqufO0hEQW9v4rXJ9zJ2
 NSoFaV3Xtf02ZErB8O2vHgjU7BO8W972WvRdTTi1VD8Jx7xOjD6j8sDjwdmdES/Bg2h+UjiMZ5J
 ZowKa8sAXYPIyend9CwGsOKLUYIl/z0PX/Y3a6kKExpbtwpM8Ws35+E7S55Uln0+KwKtsTquE
X-Gm-Gg: ASbGncupCeMw/mnQxO4QeMKxN87sgwVYzmb5SXEH5SI9KXRX6SOAdrrID6lEkN4LSdJ
 xI4RQnmML+N0jobbJcZpgoqdSqy/gGAsC2arP2Weu/HQLt35AbqO9GIx6BIF+PbNGRELZ1tpruC
 AONewZreLOo9B25U2qs44EfmtiFWqIgcqFFMjZD0yt+SqqeCNsuXshCVMARtJYMAlLCb34HPcK7
 QNvdCPrPJwpsy5E0z0T083HmBOdOKJhwITQiudR/L91Uy1WDWsZyXEUqFfWrP2ic67625RyKWrQ
 vu+q3srJl+d80EOugThdNFMuPAiS2JXWLIpoi7TfDAWSfnExUkW4W7Z8mstlzbzhSBzy+aiuLEJ
 payToRh/7ZK1EsYxa
X-Received: by 2002:a05:6e02:1aa7:b0:430:b32d:c1a1 with SMTP id
 e9e14a558f8ab-431dc139f4dmr96153335ab.7.1761329246564; 
 Fri, 24 Oct 2025 11:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9XHGSzzqoHlrGsaXpgvHIw3pePTxBO6UEw/pjeGXe4M9VE4BDvNjpcck7LyjfQtSgFZfvPw==
X-Received: by 2002:a05:6e02:1aa7:b0:430:b32d:c1a1 with SMTP id
 e9e14a558f8ab-431dc139f4dmr96152655ab.7.1761329245977; 
 Fri, 24 Oct 2025 11:07:25 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5abb8ba7f6dsm2386451173.55.2025.10.24.11.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:07:25 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Fri, 24 Oct 2025 13:07:06 -0500
Subject: [PATCH] block: Add missing null checks during query-named-block-nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
X-B4-Tracking: v=1; b=H4sIAEnA+2gC/x2MywqAIBAAfyX23IJuSo9fiQ6la+3FQiEC6d+Tj
 sMwUyBzEs4wNQUS35LljBV024A71rgziq8MpMhqRQYzuzN6DPJgp82IgQxtfgi2DxZqdSWu7j/
 Oy/t+xNC4NmEAAAA=
X-Change-ID: 20251024-second-fix-3149-f242bd8f57f5
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4665;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=L8GGCcoymsfzdRMwP6L5gPp2wpLnPyuT/p0GSeLrPCg=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBo+8BcknF6LoO/i7aFw/eui5P0qykexRPjgPAMP
 8KOz28mvlqJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaPvAXAAKCRD5KICs4jod
 uURFDADF9nZKsyiUOngibojdFPE/SU9uY/QTMPLLcVoQTr91hU9i5ZWuJWVVMkI3IVhiLffpZoH
 BSV8xl3OY7pg1j557e+5Oi0gpFjrFnlpC3i7tHlMnw+qvW6/PlUjas5XBTOJ5WL/0gkOd73Pl0H
 KFezobuLSKS7htHhXKHMDaZgI7YD+QE3gUi1RKhVEoga3NlmY0L5CpSt7P9pK7azWYQ1wfNxS9p
 5AgbWUtSQIoMjCXbRMtDNrye+1jcUHxh+d1bcBbFQCu2cI4aYKeUnA0lCfYI/Xi1s3rIv20Wezg
 7/FaIKRsWtm0bhBz5bDrkrIgrJClBWkdhM/aCGsJudl5wFp2mjkFUtn4Q74ZzatpQSGG247RdzD
 4MMPXU3mhTJSezTK7FSTZJsjMt60DbHw8DpvA9jY/lIMCyQGh/mj16s5Pw/Pxax7synj54TTQCc
 8UaVGqDfK9+FN1IH2geqEQw7nmm7r8vYwWACHLojMGLzWYkI6KYtUCwJsjBndRTCCSgdE=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Some operations insert an implicit node above the top node in the block
graph (e.g. block-stream or blockdev-backup). The implicit node is
removed when the operation finishes. If QMP query-named-block-nodes is
called while the operation is removing the implicit node, it may observe
a node with no children, causing a segfault.

This is hypothesized to only affect the block-stream operation as other
operations use the workaround bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
or do not detach their children during cleanup (see
3108a15cf09865456d499b08fe14e3dbec4ccbb3).

This backtrace was observed in #3149 on a relatively recent build. The
bs passed to bdrv_refresh_filename is the cor_filter_bs from the
block-stream operation; bs->implicit was "true".

0  bdrv_refresh_filename (bs=0x5efed72f8350)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
1  0x00005efea73cf9dc in bdrv_block_device_info
    (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
    at block/qapi.c:62
2  0x00005efea7391ed3 in bdrv_named_nodes_list
    (flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
3  0x00005efea7471993 in qmp_query_named_block_nodes
    (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
4  qmp_marshal_query_named_block_nodes
    (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
    at qapi/qapi-commands-block-core.c:553
5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
    at qapi/qmp-dispatch.c:128
6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
    at util/async.c:219
...

The get_allocated_file_size change resolves a second segfault after the
first was resolved. Here, bdrv_filter_bs returns NULL as the
bs (cor_filter_bs) has no children:

0  bdrv_co_get_allocated_file_size (bs=<optimized out>)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2+test8/b/qemu/block.c:6018
1  0x0000631d078522be in bdrv_co_get_allocated_file_size_entry
    (opaque=0x7ffd375c5dd0) at block/block-gen.c:288
2  0x0000631d07929ec2 in coroutine_trampoline
    (i0=<optimized out>, i1=<optimized out>)
    at util/coroutine-ucontext.c:175
...

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
Buglink: https://bugs.launchpad.net/bugs/2126951
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
As discussed in the previous thread:
https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg05458.html

This resolves the issue with my reproducer.

make check-block passes locally.

Please let me know if any adjustments to the patch are needed.

Thanks for the quick & helpful reviews!
---
 block.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 8848e9a7ed665a1bfbde2aba29e2c414f5bbe39b..8629324703d5d5fcf0bc3908d5b2dd4b26e4031d 100644
--- a/block.c
+++ b/block.c
@@ -6024,8 +6024,18 @@ int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
          */
         return -ENOTSUP;
     } else if (drv->is_filter) {
+        BlockDriverState *filtered = bdrv_filter_bs(bs);
+
+        /*
+         * A filter may have been removed from the graph (child detached) but
+         * not yet unrefed.
+         */
+        if (!filtered) {
+            return -ENOMEDIUM;
+        }
+
         /* Filter drivers default to the size of their filtered child */
-        return bdrv_co_get_allocated_file_size(bdrv_filter_bs(bs));
+        return bdrv_co_get_allocated_file_size(filtered);
     } else {
         /* Other drivers default to summing their children's sizes */
         return bdrv_sum_allocated_file_size(bs);
@@ -8067,6 +8077,15 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     }
 
     if (bs->implicit) {
+        /*
+         * An node may have been removed from the graph (child detached) but
+         * not yet unrefed. filename and full_open_options can be left
+         * unchanged since this state is temporary.
+         */
+        if (QLIST_EMPTY(&bs->children)) {
+            return;
+        }
+
         /* For implicit nodes, just copy everything from the single child */
         child = QLIST_FIRST(&bs->children);
         assert(QLIST_NEXT(child, next) == NULL);

---
base-commit: e8779f3d1509cd07620c6166a9a280376e01ff2f
change-id: 20251024-second-fix-3149-f242bd8f57f5

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


