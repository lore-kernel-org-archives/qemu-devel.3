Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A8FC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nU9-0001wd-So; Thu, 10 Sep 2026 18:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lKx-0002qO-0e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lKe-0000Hx-6x
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCozH6Xs5QSeR+YEhmbXShw4rBZnSCVZ1vH0Ur9vXBU=;
 b=Z5fKU3hoIhW4SFOoy37OlDW3OVGiXcHOXPRDvFtTIa2yjgpTzAXlIOR3A/8u/AFeyxVevI
 lmKlPjabROnuq6YsCqoCm5ppV2B3eNkTXy9AAiDhVq0vjnA6ot0tjb2Zb0zddv5i5BGEtq
 TkGY6JqIH6mk2ELgvWZ6icMNNiDKxcM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-nx-jA5J-MiOJdgy6-JIWsA-1; Thu, 10 Sep 2026 16:14:20 -0400
X-MC-Unique: nx-jA5J-MiOJdgy6-JIWsA-1
X-Mimecast-MFC-AGG-ID: nx-jA5J-MiOJdgy6-JIWsA_1789071260
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso69244f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071259; x=1789676059; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OCozH6Xs5QSeR+YEhmbXShw4rBZnSCVZ1vH0Ur9vXBU=;
 b=QN1mSOT86a95xOiBirrQi8BOO2M+SpZEZrq00XgSDg4/f0AN/idQVewRcVlyX0gOaZ
 Svg3xIw96NXDvg/zq42I713X8kLcUhVnsgrHL3mj+7FeEMi1+EEIgcvW4cA/xwdnMsob
 x6POr+A8bKDBkybonMa3mGu0FxI8S0dgEHlKzX9qbnyf8W088hnKaLVe/JJNfGqgA9es
 F17wgiMhMqgXJApJ4hkr+XoXxvO1hKu/sr6zInz/HuVB7ll5QK3DAU9DcSn1egk+K5zV
 FscxpAwfL+RZVcqp3srRJeqDxOYTxFYO9B95CnGQN2wbhBETE0KXrfVJfK8jVIXhlS8i
 93/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071259; x=1789676059;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OCozH6Xs5QSeR+YEhmbXShw4rBZnSCVZ1vH0Ur9vXBU=;
 b=JmepbKmnTySbE8baHs7SbHhjz8frBMtouk8VDgTPiiQVi2wgF4wouoIHaiIJasTS7z
 5SAPGgkpJJ/aSEFflSYrPR6JMA0YMQPQfjcD+kRJMiuLbJo6h9yYzjCaJna2+EZGxu4W
 ZoetXANFVPFy3Z75LJEJZXwVm+pk5OeF09hL3er9mwsQ3twqGs9u9Soll22OkSm7ekSw
 ovj1DtREN5F+v+1Fi+DE5nC6kUSHfU4MwHnHtNxeKlak+am7jygQB7ZjrUsMkaMkrlgi
 7Zgk/HQFKcRu1js2ntQO/TGWxzBzXXd5PVf+JoTQb/IlCZzwArTLjzoOdiGvkFQcYmj4
 rwJw==
X-Gm-Message-State: AFuF++n7XKcoZzi8WemY31QPPHe6dIAGUfTKr1bB5vihCBDze7AsWjTf
 kzbR0ysXJXVV2BfR4Ff7UG7kjafzaTj9/HZsyLJdsu496vzaAJp1kKFqewrJG958Z55DFQSfIW9
 x7rCTT/5SP815e3TZzHL5QA8CqkRhZMpu/1xQ10gjbnphpn+8yO2HpXBY0nKMhceevQbY+URxPw
 12CVUtGOYLL6Snax8oE78LzLU9jM3OjsD7UA==
X-Gm-Gg: AYBFou2YPCNECIH7EtqBxvJ62chHhkB7zoh8q51B0zlzUBtubX+lTymB37XEwy6Kqkz
 zXrJzuAuWL9lOuAq4EViY2EaXLXJ1p63Tpmsg/hO54Qp9L/TYoB0pScjyBwlLSNg9ovfwgbHdrP
 DFHadG7OpemlTPSGgLpm0yv0SucZQlfhy+3gt64K0JisWuaCWnNK9TEOs5nKgwHPqQab1ECzS31
 7FcTgPBkG051ys+tjux+OtNGVZdgDckF9wEGyKzJM63aAzMfnNqJuejlDuA/J84lioQfSIW3UdO
 R6ZQgPBvmpEezjL5O2q8j1YmaelbNy45tS6q02GnZgSWA42qqTuQlXHMf1kuFqKj5fJTyfNU0R1
 hX02Xv92bEn7E1BRsv5cHg2k=
X-Received: by 2002:a5d:64cf:0:b0:482:f0ee:1390 with SMTP id
 ffacd0b85a97d-486eb34107emr1488279f8f.22.1789071259302; 
 Thu, 10 Sep 2026 13:14:19 -0700 (PDT)
X-Received: by 2002:a5d:64cf:0:b0:482:f0ee:1390 with SMTP id
 ffacd0b85a97d-486eb34107emr1488176f8f.22.1789071258673; 
 Thu, 10 Sep 2026 13:14:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bd1esm767200f8f.31.2026.09.10.13.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:18 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bin Guo <guobin@linux.alibaba.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 67/90] libvhost-user: return the backend mapping address for
 added regions
Message-ID: <793d2895ef2f1b4fc971d40cb0cdd6a6f62b4b25.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: Bin Guo <guobin@linux.alibaba.com>

In postcopy mode the backend must tell QEMU where it mapped a region, so
that QEMU can translate the backend's fault addresses back into a RAMBlock
and offset.  vu_add_mem_reg() works on a copy of the region and lets
_vu_add_mem_reg() fill the mapping address into that copy, but never writes
it back into the reply payload.  QEMU then stores its own address as the
postcopy client base, so fault resolution fails:

  vhost_user_postcopy_fault_handler: Failed to find region for fault ...

The VHOST_USER_SET_MEM_TABLE path is unaffected, it fills the payload
directly.  Put the updated region back into the payload before replying; a
pointer into the payload cannot be used instead, as VhostUserMsg is packed.

Fixes: ec94c8e621 ("Support adding individual regions in libvhost-user")
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260813095501.20282-3-guobin@linux.alibaba.com>
---
 subprojects/libvhost-user/libvhost-user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 248550aae1..2fed792e85 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -989,7 +989,13 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     close(vmsg->fds[0]);
 
     if (dev->postcopy_listening) {
-        /* Send the message back to qemu with the addresses filled in. */
+        /*
+         * Send the message back to qemu with the addresses filled in.
+         * _vu_add_mem_reg() worked on our copy of the region, so it has to be
+         * put back into the message payload.  A pointer into the payload
+         * cannot be handed out instead, VhostUserMsg is packed.
+         */
+        vmsg->payload.memreg.region = m;
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
         return true;
-- 
MST


