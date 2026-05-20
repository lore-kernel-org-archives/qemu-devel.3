Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYc-00013s-OL; Wed, 20 May 2026 17:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYb-00013f-9Q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYZ-0007D2-Ph
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHwQFxcGwUZK2npcYhrJfs4WcdI2M1xltYSZSmNE9Is=;
 b=alcr/Gtnbb8pNpTcLtOBTflwujWwkeGY+g+04Y1ojgB7oU1tDV8v97WXlbeJOr8izP18ic
 SKxvm00Q2X3ReZnoeXof94BeXlmPSwynDhUkKLHxvJzSvtRv689uRVd1jwFqGc2Yjon92P
 zdwSIcig37J6A/sXeR+zIt2poy/UG5Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-vg8yBJVuNoenXJPn6ft9Ig-1; Wed, 20 May 2026 17:34:21 -0400
X-MC-Unique: vg8yBJVuNoenXJPn6ft9Ig-1
X-Mimecast-MFC-AGG-ID: vg8yBJVuNoenXJPn6ft9Ig_1779312861
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50faf575af4so145630251cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312861; x=1779917661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHwQFxcGwUZK2npcYhrJfs4WcdI2M1xltYSZSmNE9Is=;
 b=rp2aUcgHelQiW9t9LmPh4Ha+wPCDkre2PSiR33ousNh7O3VMQEEWA3Izei2VBdvoVI
 5Eetk8SkRHdp6qEZjkuxFdDObb/hPAfOp5M0Qyevu7Y074l7ox9cP8iwpC5EII8uJii7
 wibE0N0Ew5mdh4jsYpNBoPZzQw0hVwJ9tlLnEw3C/lAiJKR2+tHX8mEKF1OnJ8/ApVjF
 b2/xWo33A6SQD1z43CcsnJMb5J1eOePnU6QfHCvjL58FFJ3bBX69V7ugvFObxSUrSMES
 zs3OJcb6EM3WwcMAGCrYWlgHU5SImF3QANZhzmVVnicxWHculpcSG1J38OCFySJqXU48
 yqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312861; x=1779917661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bHwQFxcGwUZK2npcYhrJfs4WcdI2M1xltYSZSmNE9Is=;
 b=tIjQOoqlfkej+rWbDYS4efnKrBqiH0lumXXBpDK7faIfsUG73Csj5UWnF66Gbcbn5q
 7aJuSyCAk2nea1UUnEIzqM8k/U6GR6RGdNQpMdedRTYTBawE6w0XT1El1ZlyovO9IdGD
 bkmIUYyDY/21/Y6271c0pDY/hApMuhkuiFmVmhokAxhIkrzdUEHu+aCw7S5h6fETYUTk
 TLHHBpMQtW4iTQTc7mnoQuq+77ycXECEANCLhoVQEJmE0B4MrDQGn+3IGFNAPozLOZqo
 ExDNpJZbUi0TH4f2fCDNGDoBSflrOk5xtDnodPyJ0Qp7ATEEtW33SsS4zwH82nZU089h
 Wk/g==
X-Gm-Message-State: AOJu0YwcYfDFXz93qX7KRXI9zPCLSlE8IeNlmqXNJiaaVZmomUvCF4tb
 d1uUVf6ZH1dHmjwLrya/V7XYXyOZPamtymA7/tG1wMaDTb5l5iyhRVeo54XoyeXiDuSvHScOYNN
 Jl0w7oTGN8IyHQV6L1+D0oe1V8vZJ/kOzp5Qy98DKkmTb9BCVCszjIVdCJn8lBgJRZa19uOQUwF
 F6OOQDCfKETUVkwsBFqRGBlCsd7Mzm/Ir5uZY1bw==
X-Gm-Gg: Acq92OEATeSG3kLhJv9chRYRl/j99vG5QTaHuO9KA7Z0M8DuhG5Vw34ePi9ZTW4MIjG
 J7JU10IsENV8oC3fW89KQ2J+leSv9Lm9RYJPma3gt3qvBa0HxYR51zajECCvTi7Ui5Yr8/9uFVk
 RxD/Foj4MjsB7clPuExDaieGiRjMGHBG8mDB90zBx2jyWNE5f342h7liAheBrHltL1pcezX7WVt
 xGpC0oKZ0dWjPf+9uu9AdqxleL+F3mdluqPVfSxhuLJS+PhUmCQcW5tLYKG3y9iE58wqZ6GP0eq
 yHSAMedBiRQ0gHxlj5z1FXdH35ktCOGddhbQMyRhyL2vmOFdDi299TpfGJBO6AusZ/hKFQ+FygZ
 72CWQ0k2MsG3XXQRQ6TDdBpV1bBIUNPYimNkcOx3ILUuL
X-Received: by 2002:a05:622a:4249:b0:50f:6415:1eb4 with SMTP id
 d75a77b69052e-516c55955d5mr3090611cf.49.1779312860749; 
 Wed, 20 May 2026 14:34:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4249:b0:50f:6415:1eb4 with SMTP id
 d75a77b69052e-516c55955d5mr3090031cf.49.1779312859876; 
 Wed, 20 May 2026 14:34:19 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/29] MAINTAINERS: Make Maciej CPR maintainer
Date: Wed, 20 May 2026 17:33:34 -0400
Message-ID: <20260520213357.40646-7-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since Steve has retired last year I will take the CPR maintainership - with
kind help of Mark who remains a reviewer.

Cc: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/ebe67053f4bdf92eedab1e5839603b7137e36970.1778687091.git.maciej.szmigiero@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eda1e84268..c6ce786b5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3195,6 +3195,7 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
 T: git https://gitlab.com/vsementsov/qemu.git block
 
 CheckPoint and Restart (CPR)
+M: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
 R: Peter Xu <peterx@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
 R: Mark Kanda <mark.kanda@oracle.com>
-- 
2.53.0


