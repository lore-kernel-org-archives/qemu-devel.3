Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73519CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lJ-0000uK-6F; Mon, 03 Nov 2025 16:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lG-0000tu-Rk
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1l7-0005A3-Gv
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkV4KzvoIdiR+K7onoBHG3vVuiufpb0vv5OwoxQKG/g=;
 b=efbcoPExnMp+bEFVLTYMOtumV3cXU3eyOqe2M/cti7AiDdafls3bCc1/pcxiQ/onf/acsu
 4zS4pVNNdY/dayLsGB8LyahM4LaUF1Ox1sNtMnahRmNt08u0m7y3ZEcgy5hjjaDTcCx+5P
 2XySgiqgJlXLyqhKof/JlnkaWj5amYM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-lenT4ApKMXG5eO3XGuhVsg-1; Mon, 03 Nov 2025 16:06:32 -0500
X-MC-Unique: lenT4ApKMXG5eO3XGuhVsg-1
X-Mimecast-MFC-AGG-ID: lenT4ApKMXG5eO3XGuhVsg_1762203992
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b12cde7f76so30919685a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203991; x=1762808791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkV4KzvoIdiR+K7onoBHG3vVuiufpb0vv5OwoxQKG/g=;
 b=PogixB+XOxrx9/PQks6Gt/zNak5ppbDyypRIkmkKjRZKcqGC31mF/AdmCb53I7OvXP
 QNkD2BxCCy0XZMlS7yY500cd0ZOIDE95Z+9LvlNNKw2QHaq+X6DEK4nTi4XAnEQvD8fw
 c9iwYbEKIhLvAp8fXHcPemdmm2hRrRBPXcxwmafvmGv7Z3Q33d4m86pV7XNBa8z4vEp8
 hwbrAoMd6zEzIiJPFePVEm6dN+N+1EVmCvANuS0O9eKue7sL0Rtm+rbW7X6nra2eyyd6
 vQVQjuYZKR5PHEba8wm9c8I9WlIoNkNhmVoL6ds3pc+PsWgT9Z7wG/am6qHchsN2lRSO
 5QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203991; x=1762808791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkV4KzvoIdiR+K7onoBHG3vVuiufpb0vv5OwoxQKG/g=;
 b=CJDYFk3j5iCDVrMSmvSC9ajYVKxDqIRkuSwoU36GJKNXmCT7CVMmy1Dj8cJOGVzAi3
 4aamM9q8KQeqjwRq6NVsT6GCrAExQs7Lic0lQPsDKT6soEzCArkTQNidl1CpwWvPFG+n
 GyeWdXd9OPB6Tw04fzHBb+SyftYQwf0locCH4JVGEn+omyCfaMnfVheX6XlaMFiOJpFy
 Vd7MpQEZiKKoTKfotUMeMucwze59z/yJHTJhRnBhuXtxlI2KeYYMKRTe+aFfgMDhE+Fn
 Ht5oH1BNBj4AeYchKZotXsIGHUQUqLrcdGbH8WfiYPzA4LvLhJAIdphkMS8AXtlIS4BH
 8Y0A==
X-Gm-Message-State: AOJu0YxZAd9Ma351WTemqs/wLFWa+QJ3b+YgTLhJk/7OtLlEg+FNtxqE
 E3FB7+MxRftJh7kfcCPF2d6CWqaNrwgrOCiaEFVQCnKYM40IzVhVBEeduX9ZS2QI22OYqiPW8s+
 khwM06j1Lo5CfzUIuKUDjflUAmFA+S0URe79jidZhjKwiH6aD4etzkBOvfnUMjkBWrGpJRgZgN2
 KEQlHpQlKtTsVB2zvy342ybj85JVve/od7nyZVtA==
X-Gm-Gg: ASbGnctmJQbgkZjmP2sSQmKonOV7Wtu4Pw78oZtS/mlz54BEr+j4UkxdR35RsDit8b9
 qyWLtmLAxgvJv5NAVgIsFgPX2l5UyS2w/kaTUueJ2iZkRHu8trFXwSQyjtICgN3ZQ3uTR2lHeJX
 RgDD5yVC34nNQxnvsdChkpz9siAgbAFZZnmTgy5VfYzXUN1TDNbq7ubePvM6+2W5Pd5+k01Orf1
 dPMOzHMDzniEa1OwrAKPED2URPbW+pzVH/6mmLFrcaSxD8sY2An82b/UV6VewAFaCTku+OF5369
 Ga67IbQDtTTrFmX+tZi3MdSHCghjIM86o8OcPmrjjxVb0TC8w8FUEmXhrdB9BI0x
X-Received: by 2002:a05:620a:4150:b0:88e:1123:ec9 with SMTP id
 af79cd13be357-8b10c4da943mr112983385a.36.1762203991132; 
 Mon, 03 Nov 2025 13:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZkquQMB2TG93+OLIiIpDHl7iwVIn6fYDjWhnANh3yXuSMx6xT4s98ZXy7Dd6zCQnT5QsB1Q==
X-Received: by 2002:a05:620a:4150:b0:88e:1123:ec9 with SMTP id
 af79cd13be357-8b10c4da943mr112977485a.36.1762203990567; 
 Mon, 03 Nov 2025 13:06:30 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:29 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/36] MAINTAINERS: update cpr reviewers
Date: Mon,  3 Nov 2025 16:05:51 -0500
Message-ID: <20251103210625.3689448-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Update cpr reviewers.  Some of these files overlap with migration
files, but some do not.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/1760098600-399192-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee058e2fef..12ec2d6860 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3114,7 +3114,8 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
 T: git https://gitlab.com/vsementsov/qemu.git block
 
 CheckPoint and Restart (CPR)
-R: Steve Sistare <steven.sistare@oracle.com>
+R: Peter Xu <peterx@redhat.com>
+R: Fabiano Rosas <farosas@suse.de>
 S: Supported
 F: hw/vfio/cpr*
 F: include/hw/vfio/vfio-cpr.h
-- 
2.50.1


