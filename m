Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A42109022A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Doo-0005cm-VJ; Thu, 19 Mar 2026 09:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dog-0005PT-QU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dof-0000w8-BV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDofQv4vt201Zh/k4snhVYsy/sQVoI5UURNb8/LcQl8=;
 b=GQnodTA9hNwD1YhCImcc42qVocpnj9w/rMDvIsmYVexrqb0IFGUU7xoxKFWsvONZU5EWS7
 zZ1mKFS/Wks5IEWld9NYSj2lrjlWzgcwce15lbO+ovhpJp1IDh6iWgMURcxvkJ+5mf20ty
 IDz3XNSeirfSIMeSSt0ULLPw90sDZLM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-TSK_zKBnPIOvRxdggoI1gg-1; Thu, 19 Mar 2026 09:53:35 -0400
X-MC-Unique: TSK_zKBnPIOvRxdggoI1gg-1
X-Mimecast-MFC-AGG-ID: TSK_zKBnPIOvRxdggoI1gg_1773928414
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b061bf1a2dso7834935ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928414; x=1774533214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDofQv4vt201Zh/k4snhVYsy/sQVoI5UURNb8/LcQl8=;
 b=cDCXbqyK+WWAqTwee/gz+WvGogi5U0FG849qQ7LlMn3gROb9mNKutauhu7dVR5q/SG
 bZLa86as8FmP7DNh9TqDbuygCPM++nuM0j6EFxQ5V+Dj0XgxGrL4ICftA7Oso8UfvtxE
 Xg6r/Urd6vWwOxNxtzMRFQoaERfPcX8cJAymlOwr0fBEyQVrRr5wZ9VOoeBq55Qnusj6
 FJFbfprrxjuEvlTv1r1COhOy/tLYNq73cIzSb5/sv12c+KfqXvqNl5J93ZqvnkgdaVNd
 sJ5fHybcHVQmP45WrmoG53/1yuCZnH4OiRN9viSsIUWRvdTQsFfn+76fobvnoSrzn4gz
 24fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928414; x=1774533214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aDofQv4vt201Zh/k4snhVYsy/sQVoI5UURNb8/LcQl8=;
 b=rXYh0fdJcY0Eow1kbvjlG5IiRo9vsl5dPQpJ+NwNkN9M+tsok7Cg5D0qq/iPT+M2Qy
 ANRfRapiqYUuhEpuKRCORk8oAYR3XxUCD4DEbQ3A9gZTY4j0bvgFE35B5gwEXDcvqKso
 oV8mB+c9mOZQvIOwEypoIINlySkgffHjzG0rbZNGgPfSg48EFKINrRqm1yKJPXnF8sY9
 E2kxusMqX8/CcMzG4SeCbxAaQql+ptLiDPkx/gKaxx3roNzrdaeS/z+hU0bsKmTeUuZC
 QE8DZaMioSfK41Ko844cGHVe8Aojvpqfu0gpLB0l1cSTrAHCpplrEvDMpWrbKHMgWM7N
 aRaw==
X-Gm-Message-State: AOJu0YxN+v9Pq39ae41czVHdLsFrvqLKkrK0kToCqXqIyflOrUyQv6iH
 yfMohfLJFe8Jre19jZhgdaT8z0PCVPeGiBQwyzKbaCyBR+37tOtNlQ4q0txEoBf6wz6Vu+4j21m
 WKb/s4AR+mro6GP0F8YaNvcb2riRw6YwUPQWhDF74fbunm6OjOunMbacFQ3dxkcEMQLDuv0LOi7
 +X2h4/CGll7zSioqaTPYA8qRK5DwIAkFU4xQT9QPQ=
X-Gm-Gg: ATEYQzxabJ0AFy/pESTZdkFx5j0ormET1xRnfU9/Vvz7JOB4IUarTHiVeH0W+V5HTEx
 zdpYhagizrq6BFFtp6PIvowSWeMt6d1z3rF4b+sXv4lksiqn29QpWDznQ4fQt+vZVf/GVXqqmjG
 hefkaihySdku29mBNdPZrEJEbfw2pWvDkyl23g3YQ4BWUDtiXA9Qtdtc0TWxzujEiNT7HE6gK6K
 cXxCboXSg+SgqV2vPOwf8gt0woj+hucwA89g6N+meX8xNZjfO6OWCyk7WD04SdGll6VsQp+vp3H
 NSIU1D4Wh63spzTil3yN7CpeP41FygHdDA7A9AWy0X4mAmnQqTScACfNy1eLHHTgrCigrfILFuX
 K5nAurt1x0J7dNk/nUvyCm0eh4hp3vLhoAuEqUQt8gkEMwYCyoxrkHaydX6Bxdg==
X-Received: by 2002:a17:903:1ac8:b0:2ae:471b:e55 with SMTP id
 d9443c01a7336-2b06e3c5c83mr75583295ad.30.1773928414122; 
 Thu, 19 Mar 2026 06:53:34 -0700 (PDT)
X-Received: by 2002:a17:903:1ac8:b0:2ae:471b:e55 with SMTP id
 d9443c01a7336-2b06e3c5c83mr75582925ad.30.1773928413659; 
 Thu, 19 Mar 2026 06:53:33 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:33 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC v2 2/7] hw/tpm: Refactor CRB_CTRL_START register access
Date: Thu, 19 Mar 2026 19:23:11 +0530
Message-ID: <20260319135316.37412-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace manual bitwise operations with ARRAY_FIELD_DP32 macros
No functional changes.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 0a1c7ecdc6..bc55908786 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,7 +145,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -194,7 +194,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
-- 
2.53.0


