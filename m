Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8EECD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIe-0006jN-5H; Wed, 17 Jun 2026 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIc-0006ic-Go
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIY-0007pt-Ti
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGqHZXSbvSrSASH5d/OaWvfysk6IMn8xUrNHyfcBX9Q=;
 b=S75DPT32l1e/vho4xJCCyiS6BN8Wzzo70BN6BgbberXipzKP1T7VC2z7QhBBa6XJ7A2sbp
 uuCneQeOKADKiaUYSbMkzT/7feR0W5otuHK67A++tEnjZ01g5fUdBNMsh/7KPTf9yASHrM
 5Q+DvG/cZuzpebwAMMvumo1K52r/vQQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-akXtGmfdOFqRuyQWZdD3DQ-1; Wed, 17 Jun 2026 10:31:20 -0400
X-MC-Unique: akXtGmfdOFqRuyQWZdD3DQ-1
X-Mimecast-MFC-AGG-ID: akXtGmfdOFqRuyQWZdD3DQ_1781706679
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bfe735f3bc5so512812766b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706679; x=1782311479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGqHZXSbvSrSASH5d/OaWvfysk6IMn8xUrNHyfcBX9Q=;
 b=SowlimXLpSuwZd/7PBvwecPAiUt/98c9Z9KrIIfddptjYETm8poWP+3iilpBqtLBZx
 QNP0PRuFYt9kPhzXyyie7j1igsXRTR7t9pTFs+IEZrKkdrvHyda3M5ER0UVoX8V2DyAh
 YCHIDKy4oUNEmWVB2hWWzyxynqtwlHoj0Gu+20DQXpUzo7WQZ/e/hNelL/jDEEQnCA6C
 9mgNJmFE0oa4aPZxSusw6vZTEUHsvuGj5V1t3O6jJugYE/K3qM64402ZHf8utcoCewbA
 h/yoyQGI1+jls0yoy9T0Dgo+gjEtiZ2iMPOFwymnhAJyF4cu8ZVjRXwOkdpvoQMXXLay
 McSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706679; x=1782311479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JGqHZXSbvSrSASH5d/OaWvfysk6IMn8xUrNHyfcBX9Q=;
 b=PA1EvTS0uoh2gG22xEQN5qioeOC9n352lAuce4xbrOmE4p5CUig6Jr7gKHzoyjegH7
 FKBkV8NBGQoPRkO2amM63WvEKjsa4h8T79lwiWF9XTE7IiiIrZAc9nYNDD5h9rPEIN/B
 EiUq9HYoxq1jn4GQl3U/2OCT1pAKuU5Nwfeji4IeIHNDhVDhv3toUn4KOyF3fPFtGQPT
 JhZ6nCBQsFXt5hwwC8/E35JZuxcOFFyg9qDAFeFOTAr53e+muMpttXS8AjY/9Vlywmkn
 jVRrDYPZjawksrtVOuudyjyC7FihOY6L0EL2d/jqvSGm/BLfKFVQm6NZldbk2UdyEjR5
 eflA==
X-Gm-Message-State: AOJu0Yz4C+xSnWnqMSK4buMFpcZ+OtIxLp5h06EBstN6EPoeHqh2P5I6
 Ju+o9n/HBtKVo+NRe/iQOftZa3SeABZbSvJmJlhD4QfhCaAZwQ7T9kff2a5tBnNBgih0RsgScmy
 BMr6E8AvlTCJtxa452Tcs2IQ0sgmVx0sS3YWvA+wx6XCo/3ZUuoMsKZaNfX/uTOFsR/oR3X72m/
 7ceQOJID/Zu752IrPUCKk0x6MCQYZO4XW6lQT7jn+9
X-Gm-Gg: Acq92OEYRNoh8omvYtu7f0qoFZFfA6aWds8Fr+ExOjx/qxt0Pdq6mntYFC4b1J/ccgZ
 jnKvSzaFZpMEF1kUI+Qp44NXjmNZb4IVwBVpTz7ohUbXzf+Jlt8i3PwY9GfvqjJHWuMGOoI7VPo
 0LZOwsh8+OfuLb2vRrPI+Koh8Ik3eIdF6IiXfGm/qNF5JJoZucFU8mdfpcOK8vxW5zVcMRyhYuj
 YNI2/WHqy6Yn48lEFZceo3dXGXfITlfp4CTjwD5KG4tsEB31f48dYRN+QThcljl6opqd6tN0o0R
 UM0le0F2CNFrLNp5qnOzFNQkPfUldBQ+8p+tYJpW3lJAIYCTHxO7TdiNFXPAy3N7o01xqMohRRa
 Zre+zZYcu5mrZoOvlZhNEF5XH3XjToMTsCsYgVKNN9yUz5gL7/6SNSZ5+eMtn7MYqqjjZIlcc7G
 Gl4TmTBvXOB4X1KNlZ
X-Received: by 2002:a17:907:9803:b0:beb:70d3:9a5b with SMTP id
 a640c23a62f3a-c05a73a8197mr289009866b.36.1781706678482; 
 Wed, 17 Jun 2026 07:31:18 -0700 (PDT)
X-Received: by 2002:a17:907:9803:b0:beb:70d3:9a5b with SMTP id
 a640c23a62f3a-c05a73a8197mr289006866b.36.1781706677905; 
 Wed, 17 Jun 2026 07:31:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8e1db3esm806140566b.56.2026.06.17.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 11/16] qga/meson: Remove unused lib stdc++
Date: Wed, 17 Jun 2026 16:30:41 +0200
Message-ID: <20260617143046.445322-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

qga_libs are libraries for guest agent linking. Guest Agent
is a pure C-language application and doesn't need any C++ libs.
VSS linking dependencies are placed in a separate file.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-3-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index 89a4a8f713d..1c6433ef250 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -97,7 +97,7 @@ if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
                '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
   if have_qga_vss
-    qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-lstdc++', '-Wl,--enable-stdcall-fixup']
+    qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-Wl,--enable-stdcall-fixup']
     subdir('vss-win32')
   endif
 endif
-- 
2.54.0


