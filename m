Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4390EC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SK2-0006nb-EL; Fri, 04 Sep 2026 07:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x2SK1-0006n6-6M
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x2SJz-0000d3-Hj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788522182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jCTilR1p5zdi75Qspr2acnLHEnmym4Q8o2GixTJRguw=;
 b=OkkJuZyxq6jMj2ui6ak4r46Xtip50ukGvrIPCrD84LA1ZDe5uYMXlrmnX0A0VBTKXxL+y/
 Gq61ixPBc1MjQFhXMHu+P7jBs0KPgffeGkxE8A5LZV6tXOkWHCopfRZLu2fYR6JB+3jfnX
 zxgeaabdimsNszM9QOhxt7fRjtuAy7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-loQTXoKlNnOrpODvRqam3w-1; Fri, 04 Sep 2026 07:43:01 -0400
X-MC-Unique: loQTXoKlNnOrpODvRqam3w-1
X-Mimecast-MFC-AGG-ID: loQTXoKlNnOrpODvRqam3w_1788522180
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cc9f5bee2so7501225e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788522180; x=1789126980; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jCTilR1p5zdi75Qspr2acnLHEnmym4Q8o2GixTJRguw=;
 b=abFGz3f6d3o8gHElGAZI0uKav7LjycNWGDJWbqT6y3S14uZkc6A/cD/Eq8CtZMT4U1
 ow4k6wkwXF6yVi6rIqvteQXaoJUkVeGNSTzHWHQkTQH/QBhkm7V7zms1eXDcrqWPHSSh
 n9SkslRPbzRWYlmjEzh02QBAhSUZmmKonvev9/R7Gha6spoMTs0zuf2nBBCeRoP+8MJw
 nbJR+0dknKt/m95Bj8hA/QZ50YDGRuvLjzvdkR5nh1AQHbrl3bghAVQq+ZDONICeLWgd
 dm7DzqvsBwl1AAc7b0MxNGNxk1UYsMxv2F8FBG2cqmlh5tZOcK5lAkPsyevOqbGPUwK5
 y3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788522180; x=1789126980;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jCTilR1p5zdi75Qspr2acnLHEnmym4Q8o2GixTJRguw=;
 b=Zsg/hvThSrG8FsLdnIFm7ynMEz/XBJ1HBxTmBeE8Wa5+uPZc0kpWHM0LSQADOvgu1O
 ku1nhpSrib+IfbSDQ6Q2ZoWlXng7/EaYMFSUoot0iUI2B9+ju7nQxyhmYYbI6yUaeI0i
 +zWac2fTlncbsDjYi7gwy271JbdLInSurpworD+OIB+ex8W8eASTwlI6jbkVLtKsF2/C
 Xl9OBttS7vOwaQfssKXSxYIEKpNs2D3bhLkuBfzFLPGMJ+ExKWfkH+pHnIdtqFC17dBV
 NJ3G9L31QnNIuXyl6/TvXtXfLTZkfO79w6e28vcBIS+ECgAcm+YplYhCjNYmFvk7idsR
 VF3g==
X-Gm-Message-State: AFuF++lPMU+jGHoivIInBcklHbsuese2k5SXQIysQc92+xOAiI2L/pv4
 b4DF1qqa3xKutgY3od7NChSG3qyLeQoQUNd4hufr2pZH0cNFM8Pb+2v/TfT5R90re1DHkAoXLif
 Wkp9Q047JC5G4WyMyTMqzAV5k6nbXEKeYMkb4+VIEOEGv7gX1RJTL88Of
X-Gm-Gg: AYBFou0bV5UZ/9MZJVjgKcETZ4IT9JFBcJQ/qEwLa9+qxTvsjXG3SOO5qSu0nPEit0E
 uEahNOeFl7Wmeqb6XxhSk7yhoAxMBah8gplpMPdaM478HJAKr3FUMHyLpAOmKN57muLzZgY/g17
 VzPifPYkrtt8HCEClO1n22w0mypkMFj1ScdqNVApGePmI5sx5VR+8MKeaIRkDXvffmyw8iEc7lm
 kw+Z3dqzE5CQcxQqOG+85g0wJ/35L2HMhdgBLdimD1otsEPBR1LsCemuecZW49m2G/tO0YIodRJ
 SVu33sjsvWbfiERbWhc8DVuOisN11cldq3ex+kQbcIbDyzl8y9VDixul+gEcHEjg/ocDoUe10yc
 Of2bMdlezAlhE5zSYfUpN+1fvGohRJ0xjlcMNF3Ix+C1/OrvHRDClhFFDXnNTdyDiMhDn
X-Received: by 2002:a05:600c:3b9b:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49cf8286e30mr47187545e9.15.1788522179974; 
 Fri, 04 Sep 2026 04:42:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9b:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49cf8286e30mr47187195e9.15.1788522179566; 
 Fri, 04 Sep 2026 04:42:59 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771e9absm65081995e9.9.2026.09.04.04.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:42:59 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 0/2] igvm: fix byte_offset handling in parameter directives
Date: Fri, 04 Sep 2026 13:42:54 +0200
Message-Id: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ7CIBBFr9LMWgxMbG1deQ/TGKCDzMJigBBNw
 93Frl2+//PeBokiU4JLt0GkwonD2gAPHViv1wcJXhoDShzkJFE4ft+Dc4my0DiM1ijU2llowit
 Se/fYbW7sOeUQP3u7qN/6N1OUkEKejBrduZ96g9dIi9f5aMMT5lrrF52p9g6lAAAA
X-Change-ID: 20260902-fix_offset-a268cb12aafc
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Several IGVM directives (memory map, vp-count, environment info, MADT,
device tree) _can_ place their data at a byte_offset within a shared
parameter area, letting multiple parameters be packed into one area.

Patch 1 introduces qigvm_find_param_validate(), which looks up a
parameter area and validates that byte_offset falls within it in one
step, and uses it in the vp-count and environment-info handlers, which
already relied on byte_offset.

Patch 2 fixes the memory map, MADT and device tree handlers, which
ignored byte_offset entirely and always wrote at the start of the
buffer, potentially corrupting earlier data when several parameters
share an area.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Inverted commit order: first I introduce the helper and use it where
  necessary, then in commit 2 I handle the `offset`. [Stefano]
- The helper now returns data and size, that already consider the byte
  offset [Stefano]
- Link to v1: https://lore.kernel.org/qemu-devel/20260902-fix_offset-v1-0-04b18f7595b2@redhat.com

---
Luigi Leonardi (2):
      igvm: validate byte_offset before using it in parameter directives
      igvm: honor byte_offset when writing memory map, MADT and device tree

 backends/igvm.c                | 92 +++++++++++++++++++++++++++++++-----------
 include/system/igvm-internal.h |  6 +++
 target/i386/igvm.c             | 12 +++---
 3 files changed, 81 insertions(+), 29 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260902-fix_offset-a268cb12aafc

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


