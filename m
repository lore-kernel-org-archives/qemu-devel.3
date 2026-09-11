Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609BC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Dz-0004BJ-Hu; Fri, 11 Sep 2026 12:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Dn-00049a-OO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Dm-0005Lw-6P
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRnXKZYrzbjyn4A8hYpuDdRC4OzW1AM3O5ymYNZ3gBk=;
 b=cgpZt0EEmP+s1XjlH2Y1dg1ZJSY1ClXOuXNVS+G8hTY1EqZxZyAYT6rN6MnIFNVCO2Xkg+
 hQRXaT27xSHkr1JERg+CLk9omrlCoDz5Fp9BZkqXFARjPGs1szyla2ycd2l7KAfLpAhi0a
 6hcxOxuIQyxo6VC9TP6jYO43xzEL0Cs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-azchH7nCO6Wx3kOEoLnLGw-1; Fri,
 11 Sep 2026 12:35:21 -0400
X-MC-Unique: azchH7nCO6Wx3kOEoLnLGw-1
X-Mimecast-MFC-AGG-ID: azchH7nCO6Wx3kOEoLnLGw_1789144520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F84318015C2; Fri, 11 Sep 2026 16:35:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 328C8195608F; Fri, 11 Sep 2026 16:35:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:36 +0400
Subject: [PATCH v5 02/62] qapi/gen: fix _module_basename for multi-dash
 'what' parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-2-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8qQ5+NhKhFTbUvRZ8NDUWUg42L5+gNHRkxrEPEB9zC8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC22nl7ZF3UnpA4ZseWcBupEpQBTZDCGFU+TG
 HOgvnSiFiiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttgAKCRDa6OEJdZac
 5fLfD/4lcrJa2/Cw/kuk1CJUXzA5UC+peql6NaNQXmAR8iDnCLUPH6f8FpUEypkW+TGMVZ5FGOk
 PhO6X063dKJzUuxw70TIz5OVUsNOyKwO+BsgVsucDqyjZkF3BFpl5WUwlZx6GIWJA4pSy3C78vj
 E+X8hpvq2TbJhNPZJNdkA4ayqmB8VD1RFM7qDSb+/fN16hLg4NBZ6xwVJdnJq0NHyeF1r4Ij+pc
 zCr88drL2XNFf0yjPBLvxJ1ovtRlU4KDkHsvAsIgNxoRGl4MI7UPrMx94l8/pMpFmeQPqUpJwlI
 0TICMdy4AFbmkZlZQaFjm9TjWX9esQnDsbSKVBnuZNb3GONHEK5Y8Jm0D6jmVwz8m1QoM4G6vs2
 eQE1Ru+GY8sJwqnSSjSH5h8BiobmPMIYRxLTxr5t1gJgB9hwI83oVFO7ymPt5X4jPjC6gr8SddU
 jOnWAR1++oNUf+ZFQvdym+LzDKRTFc2UB1RjXZboVBXwh3RfYjnI97PztsKfajWMMe7LW4dmcXQ
 IBA94Z8eO3sp6SVVgwMZ1/t+gY6K406NmZFY+6MhsdbGs8Qnwpt64LpCdw/Rgez9ZNURYTb0mX0
 COBRt32KA7vRsjEnNKpXVg8L2XO6XUERxTKYnoAAcUDS7X729KBUbDi4TZsom87HwjxE9hbU8Ml
 +GcHdPzpQ8wcRYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The re.sub() call replaces every hyphen in 'what' with the system module
infix. This produces broken filenames for multi-hyphen names (e.g.
'qapi-type-infos' becomes 'qapi-builtin-type-builtin-infos').

Add count=1 so only the first hyphen is replaced.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b024..690187d4280d 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -300,7 +300,7 @@ def _module_basename(self, what: str, name: str) -> str:
                 ret += '-' + os.path.splitext(basename)[0]
         else:
             assert QAPISchemaModule.is_system_module(name)
-            ret += re.sub(r'-', '-' + name[2:] + '-', what)
+            ret += re.sub(r'-', '-' + name[2:] + '-', what, count=1)
         return ret
 
     def _module_filename(self, what: str, name: str) -> str:

-- 
2.55.0.543.g5ebe2ebe4ea8


