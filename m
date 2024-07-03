Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24A8C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iu-000289-PZ; Wed, 03 Jul 2024 18:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ir-00027K-Ju
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8im-0000vD-J0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=HNq76qj2Iq4gy4KjT7UfPw0fHWjGm5hAW9Pi4o0F7hV1XjhATZlZ01PTnzsBd3ereK5AiQ
 P0R/SZwF6jlJg8woN66ZfaF6FW7B7Cd8rn4ASx/olUKSC826xkJlj90KlT3su4IeR50UrP
 b1W/iLZvkoxxbODY2zPhWgRl0b6rlBs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-DX0RKLmuOUyaQ21mk_v_Tw-1; Wed, 03 Jul 2024 18:45:02 -0400
X-MC-Unique: DX0RKLmuOUyaQ21mk_v_Tw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e98697a27so1331658e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046701; x=1720651501;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=RM6vEquYEmBVQsnN6f1LniYwtuNViney/SEwYBO8Tx/EREDhxA07PDtvL4fEzjkIec
 vPWZUfCrLamYII3Xx06LYDr3Vhheyv/wYyPYiwOXPYCDddo5ynvOazuxogrAcOoZKyWq
 OQzBuBUTGELXbhgiZMMbe0Sxi4NwbHJ3ND3P/9Fv5vDppmbxybtm/j8SwDZHPbclGSyl
 2O4nP6HeHRAWfFr8o4MTorNt1luRKHWSdnlb3XKM1C1OV3Va9YM/qDwgmFFy5GKLOJ4q
 cYnzmtGgglxHtMwfRLYlTyPMEXPSe+lLkxIDpcyjDXjTCRI4IBEf0rCzltu7rhf6JB6A
 jcyQ==
X-Gm-Message-State: AOJu0YxzLb8ueNuRr4g6bJsJoX3gthjcAFrGC+N9N0Z+EI18h7/5lEOs
 z7y0XHlz/mZIOHV+OlbA5RpR3GADtqOjN0fJ5G4n89mm2TcUyu465BFLEPJDmPyclY+07Xv8cmM
 9DFanE95aZs5iM47nI6lKdXvafgudjFuZsX2YCYtIkilYUuEqp56UMGxqVMIVF800K/nbZdI99X
 ropI96w6QQEPLOdK9hc/sOBu1/gOn1NA==
X-Received: by 2002:ac2:4e05:0:b0:52d:6663:5cbe with SMTP id
 2adb3069b0e04-52e8264e53fmr8197327e87.12.1720046700784; 
 Wed, 03 Jul 2024 15:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAMVY3DMxNt0O68gztr0SxHQAvxN/VKW+4hzU8/Rfz0z+oAQnEzcY2kFIx+Ku39SSlZKfsPA==
X-Received: by 2002:ac2:4e05:0:b0:52d:6663:5cbe with SMTP id
 2adb3069b0e04-52e8264e53fmr8197276e87.12.1720046697719; 
 Wed, 03 Jul 2024 15:44:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324ed2dsm7634044a12.28.2024.07.03.15.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:57 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian =?utf-8?Q?P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PULL v3 09/85] Fix vhost user assertion when sending more than one fd
Message-ID: <5093bee0fa8a6c9712c96653da3a79bc37a4e45d.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Christian Pötzsch <christian.poetzsch@kernkonzept.com>

If the client sends more than one region this assert triggers. The
reason is that two fd's are 8 bytes and VHOST_MEMORY_BASELINE_NREGIONS
is exactly 8.

The assert is wrong because it should not test for the size of the fd
array, but for the numbers of regions.

Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
Message-Id: <20240426083313.3081272-1-christian.poetzsch@kernkonzept.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a879149fef..8adb277d54 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -568,7 +568,7 @@ vu_message_read_default(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
             fd_size = cmsg->cmsg_len - CMSG_LEN(0);
             vmsg->fd_num = fd_size / sizeof(int);
-            assert(fd_size < VHOST_MEMORY_BASELINE_NREGIONS);
+            assert(vmsg->fd_num <= VHOST_MEMORY_BASELINE_NREGIONS);
             memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
             break;
         }
-- 
MST


