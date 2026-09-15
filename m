Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EDCC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qf6-0002ym-Lh; Tue, 15 Sep 2026 06:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6Qf4-0002uy-P4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6Qev-00033p-5c
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789469104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KK1oKuPYRHfb3Ps5HkAxGCLmFDRYUaEQsYbWazCkzwk=;
 b=ePaC//1qk6HkGfvPwF8IXpc6vbJ60qe0GmOMC0AO1+0A3kkfrJ0vfGhFZB6HRmI9nbnWvZ
 +XJyJr+/Rfv1LkU6sHQnbDhL2DQZMoMsXM2+9cnMqdEnj/2qm/h1H83lAWXZO9McZ8Wn/p
 sfHorNdZquAEPtGfy69qoOTU3dQ2NcM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-zlfcDtxvNASonlD-a-3ZTw-1; Tue, 15 Sep 2026 06:45:02 -0400
X-MC-Unique: zlfcDtxvNASonlD-a-3ZTw-1
X-Mimecast-MFC-AGG-ID: zlfcDtxvNASonlD-a-3ZTw_1789469101
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c252b87e9a2so390782766b.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789469101; x=1790073901; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KK1oKuPYRHfb3Ps5HkAxGCLmFDRYUaEQsYbWazCkzwk=;
 b=DjsmN6a8jIBjqZ3Xl6lHRHiEcMnWLC2ijUBzCY30JGUgjCQVkF2jZH0IbUrH7lFMbp
 ewfuxnV3ANEbyVPKKVb2R1pfCgQg8Nbwm9f3WrU0eBSXIH9uNn+NqmTO5pZyKGyAw6bf
 em9x31LoYvjJ1nQ1QKMz7Qj1O+YNDtbAqnVSNexOffVVqGBjE8lMrUymCId/yNy/Damj
 O79Jc3QL3Jj6FGt+ozrOfXyVQZvDcDl45ERab2zPYKX21IBdoDj2MILgpE2+hvjyaQoc
 XYhdugtBctSrrVu1EUECOEdLfKzcnDkUiCiwV6IJ3FM2aWaicixemfipNFbMsGySnE2g
 TwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789469101; x=1790073901;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KK1oKuPYRHfb3Ps5HkAxGCLmFDRYUaEQsYbWazCkzwk=;
 b=E2uDg1cfPdSXKki73fJ6zRcYST+ZtUiVBPQkDERlwzicK+xN0dFafAmiKEfpGVi7M2
 QQajGdh4DoDsZNZG6OSwCNVFkOr/yyQnAVOb7qFgFfbSOAkSVt1/qVZIrr2L1wbPuME1
 6CTse6vmus+rk3dpTcN+fRyZlyfJW+mMy15/GpZAPVfMBwbliS+Y1lGvAn5JMgLjBLX9
 aq5XanUHX2iAnrt9HkP9S08hscWZEhO11NW2BNtaEVn5+/dIh/C4V+CmL2dy7eWsn976
 cyEyeE6aZ2Kbvz8OswnYfK4qFdoVKDdjujPH7jnldijfV25FPx+8ONu52ezAFZpg/HG2
 3W4w==
X-Gm-Message-State: AFuF++nb7ixRVqRVH6lvBzIt25namJajPvw3/ddpAHCfN32vEgSdvgwu
 WngwVn5MCrAKUV/ex7PmFuV8maUesXinfZgt6/VS8KByIi6TA8HVwZR4/CiOqexrKGDlYNlYbr0
 8yeJ0d9oQ7p5URFUzKLnfD4ecxNdcDRdrb2DKuwy1f10WVGbczcHP6AyBef/YkJEN/lVqA+JheA
 QLcS3fOQSg0+dMwJ4Q0Vb370Z9xKlSYHLImQ==
X-Gm-Gg: AYBFou3B90TjEEnA6tNtDsmqCEech0/9x3IWc5cngl6JMFb6LnsGREdoo2xpT1ODgbN
 CLpuGWLUxsG3Nh/MUvjggANYhsT915mljHZllskhGbPX+aabcTZV0UDvMzR859SOje1AhmqZ1Pa
 Okg2F1RedBPzRtvLTFsjLfsTioPc8gAxGLoOjhKT/NwaqyRnR7IniPekd/GNNOljQGDOxF9/Unn
 pRy+oNNmNkkmfJgzaRZYFvKp1OcdOt6ZPVqQStO/XjKX6xW5woiOILJv1YlF6lcEWwr865+JbTf
 kQdkPKD5sbMavizqIAIgFxr4NNNkFynu8/XbzIKvk/WWn/a1GGr8ko/oEliv6MxX8vzxAevy/CN
 +uG+EV6JfwryeTnh5tDfxKq0=
X-Received: by 2002:a17:907:9702:b0:c29:4513:f6fd with SMTP id
 a640c23a62f3a-c29d7940f77mr46085066b.35.1789469101230; 
 Tue, 15 Sep 2026 03:45:01 -0700 (PDT)
X-Received: by 2002:a17:907:9702:b0:c29:4513:f6fd with SMTP id
 a640c23a62f3a-c29d7940f77mr46082366b.35.1789469100705; 
 Tue, 15 Sep 2026 03:45:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2965c4dfc7sm560842766b.4.2026.09.15.03.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:45:00 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:44:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Omer Can Vural <can.omer.5306@outlook.com>
Subject: [PATCH] libvhost-user: protect against OOB memory table access
Message-ID: <00b77201ffaa7849634b251a4027e9818074ee30.1789469091.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

SET_MEM_TABLE handler uses nregions from the message as a loop
bound without checking that it is below VHOST_MEMORY_BASELINE_NREGIONS,
so a malformed message causes an out-of-bounds access to the
regions[] and fds[] arrays.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4403
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: Omer Can Vural <can.omer.5306@outlook.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2fed792e85..c17765110c 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1105,6 +1105,12 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     vu_remove_all_mem_regs(dev);
 
     DPRINT("Nregions: %u\n", memory->nregions);
+
+    if (memory->nregions > VHOST_MEMORY_BASELINE_NREGIONS) {
+        vu_panic(dev, "Invalid nregions: %u", memory->nregions);
+        return false;
+    }
+
     for (i = 0; i < memory->nregions; i++) {
         _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
         close(vmsg->fds[i]);
-- 
MST


