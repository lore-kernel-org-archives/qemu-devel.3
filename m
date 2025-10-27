Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980BFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPiF-00045M-19; Mon, 27 Oct 2025 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDPi1-00042b-Nz
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:04:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDPhw-0002pJ-Ij
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:04:36 -0400
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 002654664E
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761581066;
 bh=K+uuWePygWGRawRF+mLJCdCtahM8w0ZIFtVRhWLR0oQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=WT1s15QgqH06CkS8SHLIa8vcZYcn4gtpofmhQS6C0x6Ke5LtOr4EzDeGR83SaSOqt
 bbjp1HxUv6HquKDrdt6MLBXbHMqxnnF2rpLpNt44VvX2P0+lhm9YP9Et9tGpyf/odO
 ITenEkElEiWuGbdzl0pPmTAsz/FzyTzoto+LNhtmcJbwrxefujG0aRG6kYeGs+3Pqn
 4g8VmGN5w1te17bng7c3hih1o7gFJVAe76XTlV2US/laU1AFAr4cXia+/BWyn7DKfS
 TuyD2mp/jXRuWqOwgOl/ffwziEXHoatT6C1tz04SLr4Ti4zuXH3fpVxhAjJjeeUQnA
 JNWzKTW/vlFDLI0cYtj5s4UrTwZT+2jv2CXgFbDeb5q0I63nJlIxu8ib5NHd3UE++t
 Z7GzSt8qErTY34npdL/+e9bnlAYsBXsZFwr1LXXw+c/u7XIC9iYwp+vb9UqVtOgnDo
 1S0q6Jzc+9rP6/Aa7SfQZZCn2nlSpzf2qe3kFEf3Mgii8MBFsdho25da7sVEeJ3/Wl
 FJpYtBcSWH3CA/EoZ1+PA8uRuMb4R86X4Wd4fV8XQwwXI7z00EuePvcEp5y0KTwWz1
 PB/fodnx17NbnzLtH7HJ9LR+8AtTfIzNVzOU8K/1ridd7LsyBVy+6p8PMWfMhoAFYt
 IFinDtcpg6JxzyvoRXU9h/GI=
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-78378ec9d66so77784597b3.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761581065; x=1762185865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+uuWePygWGRawRF+mLJCdCtahM8w0ZIFtVRhWLR0oQ=;
 b=o2gileKci/EEjEo2LqdhG7jFcTO1RUq1Txj8mj4HfR2AvOcxY5nNxI+c2NsqjPNrs3
 ovg9PmCYG2jTg7LdsE4nWZ6/fLzgWBhybhjHB9RmCOSS56cuiL7CHxJblg18qgyXg001
 iDecOvsZnxPgfyBWaHpMY+1/Dhy2GuxNFmeyVlifHJbuokWHcBp8aSfb0Ar8SBgvaZOB
 M0eeh4sn/i247lHYVNY8AtzCEcfhLHBqgJmRU2nTpYG3KMqcXX1yddLYAihZTCvwPcQe
 XCNrJOudaxOdwf73185pNeGIWKTlaYEzDN+IAczVvFZ4fhBEayb0aRggzyEt8nqj7BWJ
 8rhQ==
X-Gm-Message-State: AOJu0YwbbHc76iEBSV11HKvMN5RS6DTi+Vqbp5EzOFX0ESu9sspTfS0x
 zV4bCwUMG1yzknZz2fMFROBU6yaPVHYF3sz/1cNe83O+vCpHOBDwBj0bp/Lq/758kzY17Q7Uugm
 UX4ncx2zdAr120PuUcrZLeb5ReTS0NyWBJh2ZfAvbyx9+KLG4s0Bwxsjs8kZRHpSQ2fWZ0/JaQK
 dEzafe0gonycU3P9REY5LFCIH3T16uuc2Hme5m7mQKP6/BobM=
X-Gm-Gg: ASbGncv/lUXMcLLXRW249Q0o57hCa1FpcO6N/xSbxXHZBUhV6f1DqXGNCbgOIRxOa+g
 dwAbrCjGkdPT7cJpxLhLSOMO79y+xHCHwQflZDhuE3/5O85fooICCX+fPQtt3vNL3sMg5O2e5ts
 8LfdM0CAqD9NSX+hIuOJguMfiqofn7Io7ZTl4wkXzhcCazDXDC8+ax2eTU6nMo23tRHf5qPJC40
 cKUH/w1f4fpaTk=
X-Received: by 2002:a53:b9c4:0:b0:63f:5642:74be with SMTP id
 956f58d0204a3-63f6b9d41abmr402105d50.4.1761581064646; 
 Mon, 27 Oct 2025 09:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJWYZMx5ZqQPVn/EDNtIHxLZ/9laaVHZ+WyRvmBBGMdnQ+y/A1F4s3ma4HZyYQHsm+1jyKS4d1VGx/s5Y7UmM=
X-Received: by 2002:a53:b9c4:0:b0:63f:5642:74be with SMTP id
 956f58d0204a3-63f6b9d41abmr402077d50.4.1761581064268; Mon, 27 Oct 2025
 09:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
 <aP9BhBEUSuM0ougc@redhat.com>
In-Reply-To: <aP9BhBEUSuM0ougc@redhat.com>
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Mon, 27 Oct 2025 11:04:13 -0500
X-Gm-Features: AWmQ_bmjriDjlsTF9xdqJQ3a8IMx0TAii1wLj36kCLG44SruGyGKkfjFo0Tg1UA
Message-ID: <CADzzt1B4ZwRwv+ZCWyGwyZwqScHAfKkbL2UEaujd3BJNSkMbXg@mail.gmail.com>
Subject: Re: [PATCH] block: Add missing null checks during
 query-named-block-nodes
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 27, 2025 at 4:55=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 24.10.2025 um 20:07 hat Wesley Hershberger geschrieben:
>
> Sorry, Wesley, that this turns out to be a bit more complicated! We'll
> probably need some further discussion before we can know if or which
> adjustments to the patch are needed.

Hi Kevin, thanks for your thoughts.

> Before I send this, I just had another thought: Why does copy-on-read
> even drop the child in bdrv_cor_filter_drop()? Wouldn't the normal
> mode of operation be that for a short time you have both the cor node
> and its parent point to the same child node, and that would just work?
> I see commit messages about conflicting node permissions (3108a15cf09 by
> Vladimir), but I don't understand this. A filter without parents
> shouldn't try to take any permissions.
>
> So another option for never letting the situation arise would be that
> cor_filter_bs just keeps its child until it's really deleted.

It sounds like you'd be open to a patch that partially reverts 3108a15cf09?
In my local testing I did verify that preventing the child from being detac=
hed
resolves the bug and am currently double-checking it with this diff:

diff --git a/block.c b/block.c
index 8848e9a7ed..72261ea1d4 100644
--- a/block.c
+++ b/block.c
@@ -5386,17 +5386,13 @@ bdrv_replace_node_noperm(BlockDriverState *from,
  *
  * With auto_skip=3Dfalse the error is returned if from has a parent which=
 should
  * not be updated.
- *
- * With @detach_subchain=3Dtrue @to must be in a backing chain of @from. I=
n this
- * case backing link of the cow-parent of @to is removed.
  */
 static int GRAPH_WRLOCK
 bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
-                         bool auto_skip, bool detach_subchain, Error **err=
p)
+                         bool auto_skip, Error **errp)
 {
     Transaction *tran =3D tran_new();
     g_autoptr(GSList) refresh_list =3D NULL;
-    BlockDriverState *to_cow_parent =3D NULL;
     int ret;

     GLOBAL_STATE_CODE();
@@ -5405,17 +5401,6 @@ bdrv_replace_node_common(BlockDriverState
*from, BlockDriverState *to,
     assert(to->quiesce_counter);
     assert(bdrv_get_aio_context(from) =3D=3D bdrv_get_aio_context(to));

-    if (detach_subchain) {
-        assert(bdrv_chain_contains(from, to));
-        assert(from !=3D to);
-        for (to_cow_parent =3D from;
-             bdrv_filter_or_cow_bs(to_cow_parent) !=3D to;
-             to_cow_parent =3D bdrv_filter_or_cow_bs(to_cow_parent))
-        {
-            ;
-        }
-    }
-
     /*
      * Do the replacement without permission update.
      * Replacement may influence the permissions, we should calculate new
@@ -5427,11 +5412,6 @@ bdrv_replace_node_common(BlockDriverState
*from, BlockDriverState *to,
         goto out;
     }

-    if (detach_subchain) {
-        /* to_cow_parent is already drained because from is drained */
-        bdrv_remove_child(bdrv_filter_or_cow_child(to_cow_parent), tran);
-    }
-
     refresh_list =3D g_slist_prepend(refresh_list, to);
     refresh_list =3D g_slist_prepend(refresh_list, from);

@@ -5450,7 +5430,7 @@ out:
 int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                       Error **errp)
 {
-    return bdrv_replace_node_common(from, to, true, false, errp);
+    return bdrv_replace_node_common(from, to, true, errp);
 }

 int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
@@ -5466,7 +5446,7 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **er=
rp)

     bdrv_drained_begin(child_bs);
     bdrv_graph_wrlock();
-    ret =3D bdrv_replace_node_common(bs, child_bs, true, true, errp);
+    ret =3D bdrv_replace_node_common(bs, child_bs, true, errp);
     bdrv_graph_wrunlock();
     bdrv_drained_end(child_bs);

@@ -5917,17 +5897,7 @@ int bdrv_drop_intermediate(BlockDriverState
*top, BlockDriverState *base,
         updated_children =3D g_slist_prepend(updated_children, c);
     }

-    /*
-     * It seems correct to pass detach_subchain=3Dtrue here, but it trigge=
rs
-     * one more yet not fixed bug, when due to nested aio_poll loop
we switch to
-     * another drained section, which modify the graph (for example, remov=
ing
-     * the child, which we keep in updated_children list). So, it's a TODO=
.
-     *
-     * Note, bug triggered if pass detach_subchain=3Dtrue here and run
-     * test-bdrv-drain. test_drop_intermediate_poll() test-case will crash=
.
-     * That's a FIXME.
-     */
-    bdrv_replace_node_common(top, base, false, false, &local_err);
+    bdrv_replace_node_common(top, base, false, &local_err);
     bdrv_graph_wrunlock();

     if (local_err) {

> Vladimir, do you remember what the specific problem was?

I'd be happy to submit this if Vladimir is happy that it won't cause
other issues
(I've run make check-block with it and saw no failures).

Thanks so much!
~Wesley

