Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB23BCCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lt-00014N-HB; Mon, 03 Nov 2025 16:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lr-00013t-7b
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lc-0005OQ-1q
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ro0rqiX7tgkkRvJEpK7ll/B4dLckc2iwMhybX5sTV6c=;
 b=QZfmeda9QW2Gwd9cXqXPJ5EilJbK0kLVeXX/9AmSRX2hlGrndR0x5gNM3kJYozrw5OmNZ0
 ALjbg1wDaZmA3xtA5F2OSs+t26Cfe083T3439h6Sy66DB8/k14P2wSXbku8nnZM1UdysI7
 RqxvnDHDIurmDTi7S6slIfE08S/lbcc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-LUqpTBlCPwG-vp6l_TjOUA-1; Mon, 03 Nov 2025 16:07:03 -0500
X-MC-Unique: LUqpTBlCPwG-vp6l_TjOUA-1
X-Mimecast-MFC-AGG-ID: LUqpTBlCPwG-vp6l_TjOUA_1762204023
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ed5f5a2948so10153741cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204022; x=1762808822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro0rqiX7tgkkRvJEpK7ll/B4dLckc2iwMhybX5sTV6c=;
 b=Y0m+MtrTg/6Bc3kMMyd1GrJgd3ooinGmE9JXUKZS5WJJhI9hBN43XqoVUF98xDpowh
 E1iIbJX4/g138y7t/TGdBFtsVSp33qMHejfY6oJPAap+5O/e5Zi2qSvfBMu7/0YkGdJa
 Ahe5du1rY4jT2HEe/3d3BcW2FXOLIquZIAlwVhaEun2PCKaN4bI4iKf9Lqm93vUyPsnq
 10yb3m1p+B08Y4k0Qz5AmkJVny3lWERe3PmncLsdBX4kABXPzYHUO0bJ8WSa7Y49zP6R
 fZle+k2uNI6p2m4524RsmO90pWKTPA0AegRf93zUldghporMlbo1OTOj2DvS8/ljQTgX
 FXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204022; x=1762808822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ro0rqiX7tgkkRvJEpK7ll/B4dLckc2iwMhybX5sTV6c=;
 b=BG9pJRLbF5/rb0fPtRdtEyhyb7+kWaJaig+WfyUpEd3NWroZ4QlgyWc+qTfTT0QQuy
 9Bp6YeuCQTETMxdFCROjnUCW32DD5t24QwAYpwMKmuvOeNlAMI4z1ncpwWxnwkIA3Z24
 K1M07qfGIxt67FHYLBJIcnV6sGeFwdSawlmse+KArZx2TkuLqjybiEHzWFs2bgQG1AR2
 GDREwVjXcHIBCtPukYF56D4kJv7xMeUeWwdBK7YG1cFGrhBWCujScHEsCJmrfOUNRj34
 NxRgkciV/sg1uTDkqA8G6FMayqb63azN1R9dTQAGs0GawbiH6kJXnPBUujsQWrX2uvko
 7cow==
X-Gm-Message-State: AOJu0YyuDuwJSajEdh8+AsBBB82mrNKvM+YOfw2j1BybiLXQG4TUYRjs
 URJlckkmGaBernXtU4smI3pFuFTKVUiwhgWUYoJk4xRNfbqh8fU1EcmqOAMZNsOodGrvxhnqNBE
 zKMNtQOLq3azqoLvM8O1Z3XtOwyEneaEqx0249jKB7IJogcCpkRNq4wsse2V14cAF2usje4FGne
 ZESQFnt1dx3xRCSs+YfYR9OvdqD7SiKGJSTAIAeg==
X-Gm-Gg: ASbGncvWdSGg5koKfP2nYlfTwxzWs23cnNcZcqVngjAEdaMlXHbzltAbosfi1Gx/iLV
 IiR3J5Q9oD22KkdUOrnpoA66v80krgKFNHqTS5kGzhLlMFnpWa9TniEykq5cuxraB/NTqGP+eHf
 XJznbVaFoGjZ7kWg942Qv9nkZLAuoHHiwwLXQzSqZtEEgvQVvYJGb7MkYTrW4W68/9UJE3rNIXy
 j2FfmBOHkMCO8I3OqVt5j2bdHw+5ySnn1FzMoyxACq/34X/WGWPss0Q6aV2+507FFi4UVccurcU
 EjCGkzRNgNz+jZFGCWlBp8O/bO/T2TOKU15+THV5upsLz2pHcWBKsIr6sh4IkP5j
X-Received: by 2002:a05:622a:1825:b0:4ec:eecf:66fc with SMTP id
 d75a77b69052e-4ed310a77cfmr188497381cf.51.1762204022255; 
 Mon, 03 Nov 2025 13:07:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWrdDYk3VljiAcGnfLyWpCxCC7h8Mq0DR4iVdkwqKoIENEvVqb3X+QYYqb4rinJwo+alhoFg==
X-Received: by 2002:a05:622a:1825:b0:4ec:eecf:66fc with SMTP id
 d75a77b69052e-4ed310a77cfmr188496591cf.51.1762204021652; 
 Mon, 03 Nov 2025 13:07:01 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:01 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL 23/36] migration: vmstate_save_state_v(): fix error path
Date: Mon,  3 Nov 2025 16:06:12 -0500
Message-ID: <20251103210625.3689448-24-peterx@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

In case of pre_save_errp, on error, we continue processing fields,
unlike case of pre_save, where we return immediately. Behavior
for pre_save_errp case is wrong, we must return here, like for
pre_save.

 "migration: Add error-parameterized function variants in VMSD struct"

Fixes: 40de712a89
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251028130738.29037-2-vsementsov@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 81eadde553..fd066f910e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -443,6 +443,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed, ret: %d: ",
                           vmsd->name, ret);
+            return ret;
         }
     } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
-- 
2.50.1


