Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A0ECCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mz-0002FS-2n; Mon, 03 Nov 2025 16:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mw-000236-Pt
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mn-0005eJ-Jo
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75HUCE6Au07SRMomYeRAuTHnwe9a6Sk1ODLtoL1BP84=;
 b=bdtIGPNltiTF0o8yyhAJmICw+YccdQk3M+jshDNPxApQXTlDFXvEBpMMFUHhDV0QaPbcIL
 1qKhmYu/ccOG3wDg5TME3fcYBgUquVObcILWAqHadrbbmcV96eQ1JgetuP/vopHXZsCgHu
 k0NrHB/1G8FthBm4mPNNfrhzp/mxy0w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-ScKG4onfPMq3SZINCuIb2A-1; Mon, 03 Nov 2025 16:06:43 -0500
X-MC-Unique: ScKG4onfPMq3SZINCuIb2A-1
X-Mimecast-MFC-AGG-ID: ScKG4onfPMq3SZINCuIb2A_1762204003
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e884663b25so141325111cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204003; x=1762808803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75HUCE6Au07SRMomYeRAuTHnwe9a6Sk1ODLtoL1BP84=;
 b=euMwymwLUid40PEThuKrdHVxbsbLqL/hJJfwnCFj+2JRZ6xN0QXQ6ZrrA5w6chjRgc
 HPwaTe3Ox1F0NAUwtfLPwGJ7s41vNIkdrg/bN8WxI6q6trOPH50ymJM4MA2f5W9P2Pgw
 v6TrX+LSBx/iuaMcxr9xzfpEmQuakZs7M9/rnSTsu7hR7HZkQ1INrukOhBI8uJ99ZKgh
 LmPtYDhHv6fNFynV/fh8DVzgR0NUvXrOg2LShiojyVSIxhjmckjPv1Yt/ZnWDK4JPlCP
 7NfwH8INikax4Kaus7rYAoexXklscNla/Cs78GH3JW5RcYFZPFsoThmfzVOo3UWeID+/
 87TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204003; x=1762808803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75HUCE6Au07SRMomYeRAuTHnwe9a6Sk1ODLtoL1BP84=;
 b=pyBpeCEIU21J91yai1mlt+cEFpYoOtCkumXiZiSDXQJx5k7Ja0S35Hzcp/mU52L4NU
 d6PA0OMVf+THT9zR1af133iVl1B1m7kCa4zAJpe6kgBVggKGzzFOGYpXY6XlCh3xfrGN
 0HqMGf98zoKY3AFa+6pA8GXEHp5RY09NeSo65LSx18c9fcFLHXxrVVCkn3EJlyS0cK3T
 W4arnjd5OGL2haH+S4+9M/6TK/k/ZzoLfnjoWtyUFDLiOEtgHKJACf5GNjOWwPtaGiy9
 2bk4LVawQi/6hwKx8yWF71tg5LG8UqT+B5d/zO5NUwrpV74H4oyeWDMF90iWoBtxRvBr
 JWjg==
X-Gm-Message-State: AOJu0YwsmLcoMTUbb68HzSAIxGONBiBxiJficXCjwnhvFXD5MTSWorXv
 0IFw1fSULMihU2rBawZBbHs6FEJkKaILjW+jjDRZ9v4XYBm3oEUf+gnjkQwzW4PgOGAo94SbjD+
 whrD5222N1xDJCtZT4V+5qS9xESAQdMlRL6cxGPU8KA7axjW9ufFrQMLQyZ22sJZM9I98iIHov5
 NDoiyWPM0QS66MItdqejQqdboBjxXMlHNVAf50kQ==
X-Gm-Gg: ASbGncuSj3t+PKUWR9brW8y/yNUvXL1uRfn2OobBNSuQJBOj4qGm5Xy8EEZgltEu6hw
 KtnCjqmUXBb19bUfdrXt8Kwg7xgU6FInJ4lQGV0zOGX6qfYclI6K79BWB1og5lVoo/BSwyVucDt
 lZFmNjr1rg8NN9HHAstSBc2RSfu04t9ITZZwN79jGCbLMlzXErDK1ktoTX32agZxFK9Dnzexspz
 QCxth+GytqN9Da0T7kR7S7Pu1te+AAyHfcr/q2PNcOJenmaOtrdzN4xZW+kCeQgbH80xci/yl4q
 XHn5crfcDAQjYVLsUmLk/Lsdn7+60f06KWzzpMyEgjbPK28Al7RUapgxWTrxO2xB
X-Received: by 2002:a05:622a:8307:b0:4ed:62f5:e1fc with SMTP id
 d75a77b69052e-4ed62f5eef0mr3204321cf.75.1762204002774; 
 Mon, 03 Nov 2025 13:06:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzcjDtRhaAc5+MuRoat9YXC6wz9fw2LxPPsgI+htkumYzq511qOktleFJzNhyTw681TNwVvQ==
X-Received: by 2002:a05:622a:8307:b0:4ed:62f5:e1fc with SMTP id
 d75a77b69052e-4ed62f5eef0mr3203731cf.75.1762204002219; 
 Mon, 03 Nov 2025 13:06:42 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:41 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/36] migration/cpr: Avoid crashing QEMU when cpr-exec runs
 with no args
Date: Mon,  3 Nov 2025 16:05:59 -0500
Message-ID: <20251103210625.3689448-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
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

If an user invokes cpr-exec without setting the exec args first, currently
it'll crash QEMU.

Avoid it, instead fail the QMP migrate command.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251021220407.2662288-5-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index c8a5712993..4ed2a2e881 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2195,6 +2195,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             error_setg(errp, "Cannot use %s with CPR", conflict);
             return false;
         }
+
+        if (s->parameters.mode == MIG_MODE_CPR_EXEC &&
+            !s->parameters.cpr_exec_command) {
+            error_setg(errp, "Parameter 'cpr-exec-command' required for cpr-exec");
+            return false;
+        }
     }
 
     if (migrate_init(s, errp)) {
-- 
2.50.1


