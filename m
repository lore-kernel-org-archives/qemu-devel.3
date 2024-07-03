Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44567C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lu-0007sJ-HO; Wed, 03 Jul 2024 18:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lt-0007oA-Cd
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8li-00039u-7l
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yh+r83dQTqjKVESuK/txPttml/pXNBlxCl8GGxw4h4=;
 b=V0ANs8c0Dq/pSNrHtSKaCJ49VsfycLELhGcU/k5WjcaQMvkKG+q8wBYfMNT6S/LdV5Vmoi
 kUfg7Dkl7iP70J3vd5vcc0rOQYiJXPXQaACPxDkeCyaAnkfbJfz8I7WSHOY6iWeNwZ6s2/
 DeA5/RZ1NrH+ozvY4YVfJv8zpG6SlCE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-k645Jv5NPWiPjlsFVPr7xA-1; Wed, 03 Jul 2024 18:48:03 -0400
X-MC-Unique: k645Jv5NPWiPjlsFVPr7xA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e9b943e6dso634717e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046881; x=1720651681;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Yh+r83dQTqjKVESuK/txPttml/pXNBlxCl8GGxw4h4=;
 b=LMcWCDZMMP0VzGHVG44qrH3X+nrWYXYFuRWVschb43Ufp7Y5qbzbd6RYE24fbwn0iq
 2Lp4AY+uVyW2Lt5oo+y8r/+4lkiGUSH9eMRMnOQsnMxBgIyrRLVXHfxKYtrFKB8466y7
 mkSJmiam9pReIwEsTbTkg/QQBHlRQUxnIaD4oG41bTe1LiuVdiFUjg/OrYKf+ZUqMxD3
 KspAni56SVefs2A1wGeltc49FvvIn9H/p5nsnvV+RM5tvm6d2f38ppxePVAo7WkMbBh3
 kSMSfz1AyF4E0uj5MMSl5C5NdmGi27iVyGA3TngAMM1v1E4z6PrFQa+splCpmAzzADh7
 THzw==
X-Gm-Message-State: AOJu0Ywm2LoocdhtCb7/kAH1JqXL741LsVkxREcP5iZbFwzRm4PqTQ/9
 b2nx8Ihcgt6Wd5SwnmP5rqegzrXjvjUcycsyPeg8n3jXp8A2355fgwsYwvpHx1UHCOZv4iacAPJ
 uEdvzLLE32/9yqQHfqRLrIKyNuoKyQUvJx7qqB65Ok4dtmp9WZU1w+uVPoU5xD0kXCzi1WZ/Vt7
 n4Vw8l0AuC4vao27/o8YasuZC6tOTxgQ==
X-Received: by 2002:a05:6512:1111:b0:52c:a724:5ae3 with SMTP id
 2adb3069b0e04-52e8270b916mr7904370e87.51.1720046881296; 
 Wed, 03 Jul 2024 15:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD+bSZN+ET+IwHWLsTiUzQwRdIfXJyYn1vUutJOdiKLqhbpFXw1rE9p4NLNecJhHcKv9pMCQ==
X-Received: by 2002:a05:6512:1111:b0:52c:a724:5ae3 with SMTP id
 2adb3069b0e04-52e8270b916mr7904355e87.51.1720046880510; 
 Wed, 03 Jul 2024 15:48:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c838casm7685331a12.4.2024.07.03.15.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:00 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v3 47/85] libvhost-user: set msg.msg_control to NULL when it
 is empty
Message-ID: <516dfbb783484959cf33f051864f2e44cbed45ca.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-3-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8adb277d54..53bf1adda6 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -632,6 +632,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
     } else {
         msg.msg_controllen = 0;
+        msg.msg_control = NULL;
     }
 
     do {
-- 
MST


