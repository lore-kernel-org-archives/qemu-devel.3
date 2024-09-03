Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A4CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slT1K-0005O1-HS; Tue, 03 Sep 2024 08:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erbse.13@gmx.de>) id 1slN3M-00013a-ML
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:30:12 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erbse.13@gmx.de>) id 1slN3K-0003bx-4b
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1725345002; x=1725949802; i=erbse.13@gmx.de;
 bh=vv2avKkp/oIl72L47UeSkMyREe7Sb6GxGrdiZncgkK0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qUH2yqE2/OVD2gX/A3sGU6DA5Dp+vxWueu6TaMgIkDg5DIPGApGnNqecPs1Cql6Z
 UjQENjY3SdD4toY/3EOX8Mf0FVdP9NZonU+VcXIK0GcLacD31g7hdLGqeB85X9Cot
 ZaIwaXqYrMGTeYfi8/O3LYRAUV2JRmgP1Dh0ePhEaceDi78mlRtNVwCvVH2X9Djsb
 1hBpKjht0yZgan+9E3k1iFcxLKVvFcFDvZNu7fuwMo8RF3Dbhq/4/OGjeWEGPn6b1
 tOlNazRHVqTMEjQq6xsH7R0l9G+TkiOHDmo0eruMKvBOrWFoIvWt1HYgxncO6sQ4l
 fw5LnGyKh8aGMKip+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from server ([109.192.237.113]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1sdy6R10tZ-00SQLD; Tue, 03
 Sep 2024 08:30:02 +0200
From: Tom Dohrmann <erbse.13@gmx.de>
To: Tom Dohrmann <erbse.13@gmx.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Date: Tue,  3 Sep 2024 06:29:53 +0000
Message-Id: <20240903062953.3926498-1-erbse.13@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TeL5Dpd+HeKRcyOCGLFIYa1mmRh2o78bO05fbEbFeB23MUB3yjt
 NrkopVBcHiGVqvL7yqd58jff/wsZL3pzQmklSIikYloVrz48WtCa7KYPTtmibzyktKFUhkZ
 BnmofNtDAG9HXHsXBqm14XjDjbb+VRECNPGrtL/pl1VxbVplSQ7by2SvH4D1MqCia/tMa8Z
 0+rYm2kgGjRTn+a0K9trQ==
UI-OutboundReport: notjunk:1;M01:P0:Aoy+/hfHX8s=;PU1rzbY/jH+nOTiOGqaEGQqSIaS
 aIzQ5HHpzr67nIlTmR1OKxf/idtQGgzCeOQ5sL95/KNlS6bEQjJNDh4YIcdl+LItMdlienN29
 Noow4naiPzefqPqTthRDvPoz23RuH/9/PEKeG2bfWxHKj3TUcQKUB8NHJ0tMGJ55MvQNp3W4A
 NiCfHjUSzpz2ncJAzThbzGNy+hMcwiws0WFaZbf3FFasnqF3vtIPwgCPZ/V/6lgZft3B2XwrO
 aMjGGzCSFMpkBvi59+uuceuS8jeNd1BVPgVvb9LUwOCky4aD6r+osYfLRSugeIvKCDaljO1uy
 Bv54LB1g2E6G4Ac8OWbuEMv8mB0noEe/l2oYMlkHHL6xRkv0+HfO8H7o5F4MMlr2n+FAX+2gI
 Hns/tat79rf6TLDsGAIbch2RTKPuzSDGJd9v6F/BneHcoo+IjHVDW4pn9lSEKs+hE70U/xMrR
 nRCdq89I/vUpdSzzyeT9368rQv7tSgeOAwF0yu+we1PNNXNBhZZSS4VCBpmOwNyH+ul6A5CSO
 gSF+YyVFgVUp/UIRlYn9JpEh/zucWo1IQmA+aQtkLyMq5CAAJdfMGzGIblLA0PcmxFjJbo8kj
 xmDZKMtF02W/LDcl+Q3CARkQZkw2i+nf0vBHxN8il601uoRrAjsS+B66ViRFJDi62/xzHin03
 DZlqbL/NmSUUlQYFXTw5deI6pA8ss/nILH2yS+QA6JMxoyfvYVUpoQm4Wdba0BaGbF5+NLRuV
 vESO+WGuYCpLmQENtw53o0jPd67zkBjr4ROri/rOx4UlYtIjECbD2qNwQENrm07YsWDQAmM1+
 l0vbA9vHJv3otZyb2oYhbj86BhwJgdTaDzVCPuoxOnsKM=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=erbse.13@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Sep 2024 08:52:28 -0400
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

KVM_CAP_READONLY_MEM used to be a global capability, but with the
introduction of AMD SEV-SNP confidential VMs, this extension is not
always available on all VM types [1,2].

Query the extension on the VM level instead of on the KVM level.

[1] https://patchwork.kernel.org/project/kvm/patch/20240809190319.1710470-=
2-seanjc@google.com/
[2] https://patchwork.kernel.org/project/kvm/patch/20240902144219.3716974-=
1-erbse.13@gmx.de/

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
=2D--
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..acc23092e7 100644
=2D-- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2603,7 +2603,7 @@ static int kvm_init(MachineState *ms)
     }

     kvm_readonly_mem_allowed =3D
-        (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
+        (kvm_vm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);

     kvm_resamplefds_allowed =3D
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
=2D-
2.34.1


