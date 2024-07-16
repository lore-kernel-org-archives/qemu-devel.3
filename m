Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3B8C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTe3f-0007Vi-EV; Tue, 16 Jul 2024 05:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTe3c-0007Sn-CP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTe3N-0000Vs-MT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721120455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nn6LWkSU28aw4wa2A9R1Uc+par669e6qPoKBMRBmcmE=;
 b=iea3RoGC889N5iI5vnfb4CKOF0AEDV/+qOD6Hlv2y0ADi0OPZKlbH0WyKt37JNI77hHsIO
 U9PmodH2zoZtnQ2LaOQntYcabVXMa83PTv3hzOvE8Nl3FLJVw+9u/xqti9bHNGH8hhnK7d
 8krSZLOvDtQO026mghM7ASV7ueU+LpA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-RdKR-L9OM0-ic43wrEoD7w-1; Tue, 16 Jul 2024 05:00:54 -0400
X-MC-Unique: RdKR-L9OM0-ic43wrEoD7w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e969d34bbso5582981e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721120452; x=1721725252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nn6LWkSU28aw4wa2A9R1Uc+par669e6qPoKBMRBmcmE=;
 b=BogepzP5J11v06nWPL3b0flnOhpxZovY4Eo4Ib6kGjZml3+3fOsG60W0E6gIujyEmJ
 x1z1J3HWZBaJWgPqcB8JAENSIi8DJt9m3gwI/ygdRZz+IvGv6cXYaZoIPHR2G89g9Fiy
 iGTNPT7kHCO1iFSM52cCuuQa1RV98oQWhV+yaz8E4ourxhFhLgDeiW9zpScMbCI3M3cJ
 eFxYpIu1TrHNu/BdRLvFCUOHYUe0ljWTZOtpmk+Bk2xGW3dtooOuTmUYGM6kZOv573uo
 T3RrF2jNhtpWk7g2BswX3qLUuxS8RTmr9jRpFusOQrzuKRKnPBNfpl6PcYa2SE5SC12Z
 Wcrg==
X-Gm-Message-State: AOJu0YztTyvrv4MAZ5Oe1DVCfp9GHn0KX9Qd1QZrkNwSRjcWaKDtKkfr
 5xa/FW4+dNINRjvu2v5RMJCKD3kQLC3BGBQyGEIvYqaBB8qWkCJudtEkA11LEjmf/49jXzAaIqc
 dDYlP1oNGlASBIk9SUocXYrIbJ6BC6mB4qXjsjfzHlTkBaavgspam
X-Received: by 2002:a05:6512:2253:b0:52e:9f43:c150 with SMTP id
 2adb3069b0e04-52edf032e9fmr1033462e87.62.1721120452142; 
 Tue, 16 Jul 2024 02:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEld7gLltZJoUXHW1ivCZ/ojGTcZORkcN7jHlvGrIGzZX4NG+qDfQm9mQ2MafkG8Hn5qj4Mhg==
X-Received: by 2002:a05:6512:2253:b0:52e:9f43:c150 with SMTP id
 2adb3069b0e04-52edf032e9fmr1033442e87.62.1721120451753; 
 Tue, 16 Jul 2024 02:00:51 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25abf0sm151143715e9.14.2024.07.16.02.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 02:00:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Boqiao Fu <bfu@redhat.com>
Cc: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Manpage: Update description of 'user=username' for
 '-run-with'
Date: Tue, 16 Jul 2024 11:00:09 +0200
Message-ID: <20240716090008.187506-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAFRHJ6J9uMk+HMZL+W+KE1yoRCOLPgbPUVVDku55sdXYiGXXHg@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> Manpage: the description of '-runs' didn't show this parameter will use
> setuid, so the customer might get confused when 'elevateprivileges=deny' is
> used. Since '-runas' is going to be deprecated and replaced by this
> parameter in the coming qemu9.1, add the message here.

Queued, thanks.  I modified the patch a bit to explain how setgid and
setgroups are used in addition to setuid:

diff --git a/qemu-options.hx b/qemu-options.hx
index ad6521ef5e7..694fa37f284 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5024,8 +5024,11 @@ SRST
     in combination with -runas.

     ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
-    by switching to the specified user (via username) or user and group
-    (via uid:gid) immediately before starting guest execution.
+    before starting guest execution. QEMU will use the ``setuid`` and ``setgid``
+    system calls to switch to the specified identity.  Note that the
+    ``user=username`` syntax will also apply the full set of supplementary
+    groups for the user, whereas the ``user=uid:gid`` will use only the
+    ``gid`` group.

Paolo


