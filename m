Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D26FCD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcE-0001YY-Os; Mon, 04 May 2026 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbn-0000q3-Oe
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbl-00012L-Ox
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YvsVsIi/1TFcOv3yrrnCyz6XIRwOmOuXGjMWoQQNxM=;
 b=BImmZ+gsjt0fdtjn/XsHeoo5FkgNUkb5yvjKLmdSqcpF7e6hBQi9U7pzB8SHPAksJjlZ0I
 qJSAdXWAKT4NyvGV9VEET+a/j/keLkKZWWywneDILkfFr39ZbnwnG8Oco8BWW5jHHYcDwF
 1GkvYRCUIG7ZsHNm23Hj7NAUA3a8NTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-RyWBl1BlNaeLXqANzqKcgA-1; Mon,
 04 May 2026 07:37:04 -0400
X-MC-Unique: RyWBl1BlNaeLXqANzqKcgA-1
X-Mimecast-MFC-AGG-ID: RyWBl1BlNaeLXqANzqKcgA_1777894623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EC0E1800578
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB7051800669; Mon,  4 May 2026 11:37:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:07 +0400
Subject: [PATCH v2 19/46] hw/core/machine: free shim_filename on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-19-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=718;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HkzWuVnjpE18HvhyvwlZdG6XDtkdNuA+nhZi8wBpL2I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRs4Hm9zgRLx2kuLaxEm4HhimPiCJDmOl71p
 AzLhPQY/5yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5d9JD/4scmNdG+cc6cR0bPnR/rX6WWnaMXCjPe5Kxo8Rbv0FA0IlejLziuEb/ujsrrYnyknPfMq
 Im3AIYiPRlQKVWh1V0BSDc8/k8EQm5kH9qrpQv7HYx5Uy+3bGrD0Xr9/8lnF0Hn0Of2UqEPd75n
 StesVQj68Z/JVzN+AvGtPSttrrv84csAESI+2AGWeE230NqQyDg+XkguUbYXWICmmxOK7iKYGcz
 A8wKPWUnlCFvgTMYVGa4o+gRUuUFbN6aXnaKSuJGapP4I7TOjsG1vo4U1gloFPPaMnUJiNb4YQg
 sYMFeXG9lGczuOeLoXXs+71UEKknaRSEBnFaoQBW6shGumDDep2DuBjiM7FlgHyXZ6sr8HnM/hp
 HGEMYgzsnCOYPgbpCViZsv5QgawkczFFsKGQEpjXtroAjErAzdJ1WbHuAH0BCsZ/rKQ7mEkB3Fy
 V/1298RyvaDVYZewmlwG2ZN9/ucICOqlH93HoMYzoQFXQ3fj9M8HQ99zxkI7HOq/11bIwm2KhTc
 /ihDfTCGt23TrB6h2KqDOC0InOQ201+zLrU1q9RqNlCIe2ymiUMH1CbBkA2lipt0KNWfG04KaGh
 nSjglhZQsEo039U+idcVsUnbu/EpHV9H31wiqQVwhF96Iq0ZzCXRcI7dCQx42K4Me/B1cyuLUuJ
 er88ryI+WFMX/+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

machine_set_shim allocates shim_filename via g_strdup, but
machine_finalize did not free it.

Fixes: a5bd044b1579 ("x86/loader: add -shim option")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b661fd36ae..6a7fb312eb6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1282,6 +1282,7 @@ static void machine_finalize(Object *obj)
     MachineState *ms = MACHINE(obj);
 
     machine_free_boot_config(ms);
+    g_free(ms->shim_filename);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);

-- 
2.54.0


