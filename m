Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A9D2447B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 06:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz9RY-00067A-AK; Fri, 11 Oct 2024 02:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erbse.13@gmx.de>) id 1sz9RV-00066r-A8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 02:48:05 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erbse.13@gmx.de>) id 1sz9RT-0001BS-Bv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 02:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728629275; x=1729234075; i=erbse.13@gmx.de;
 bh=lRYoZ8ZEfCljSmCfJERXD2hAZ7vpp+9eIza9Jf6ArUA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mcy13GH2c7B4b6bNWJ8EqrvoZWXM9i4Sdx/BcE0wuAqorXMKoi0NsjtqwU9gbllf
 HVhT/dB+YBmaHBjw3h+U7aTFB0NQHXVaMd3V0VqBzLHcbPLWgYmugic32HMIgV5tV
 Ru+HdLBVjpa5EP6RJi0YC9rp5RNHXruIKDTM7d6uewT0F6PqOdSnqnoO7SWW69Pn1
 trJcJJxrYT9+t1mOld9xlz4aSBiTmM1x4rUYKHYh+uKVnvqrbVK+d7h2dHfgzGlYK
 7sPkcEijyjPCcu/jUQ0e+rajnUoz97H0iD0hjPKiYIgIeOLZY6Y2+pv8oa/ROf+1o
 UNZrke6CdfTRCAQybg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from server ([88.152.43.130]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1sxlaq0h5f-001DVC; Fri, 11
 Oct 2024 08:47:55 +0200
From: Tom Dohrmann <erbse.13@gmx.de>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Tom Dohrmann <erbse.13@gmx.de>,
	kvm@vger.kernel.org
Subject: Ping: [PATCH] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Date: Fri, 11 Oct 2024 06:47:33 +0000
Message-Id: <20241011064733.1123414-1-erbse.13@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903062953.3926498-1-erbse.13@gmx.de>
References: <20240903062953.3926498-1-erbse.13@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBu2dyWc2rfrxhheMUw1/2gv0CZRx+bb9aEGiRV4t12nG6Z2+rV
 xABtV7yRCNtIR62RpiLJuuoEAK08SPtfKWWfAGKBUvE1UmB8f7d9G5yRiMdhFbL5rAMVMbw
 E3uHRQbwL0xZNnVihp2phu9lIP3lyeHYpELh81TvOp79Aau5yd+FeD8Wbv6uxCTPQbAv/KK
 sgCBtkfucoBkozorjhItg==
UI-OutboundReport: notjunk:1;M01:P0:Ji03cwJ+J28=;cQrWFO3UDht6/S+lT2Gsx8Keypb
 fTHArrX58iqM2zv7CW8U/TcW6hyDgCTYltUMTsVMh9snCDP053opKzDQNTitOcB/92HrLE/b+
 zxNFCeP1u49dIGHBVQrSzSzn7P8WGTHN9fKj6hJ/HhrV4VmTU35PmNc4uI0lgVbBlJCogNN15
 a6K2j6/4jcm8cgOgeGALOcQTEXPXHKyu+0gyQ+ltJtgSiwydwzkG+mezx38YUiMQrMZ6cvbUB
 PukxhyIVQv++ceuieF8+uYlr0EGwlpj/YDBLDj3oyvkLLP6T8ogMWfqOfEGyPcv/07Lfy4Moj
 7KDG1lPzsfY6K6PFHNEN4augZYWr4m1y35G6JRVaG4BVrAFPmicsAgFMOerqxtTgqBKDw9n0O
 muHGKp/4dijFnuktgAaaMlUSO6xSU2fGBB8/0ONrS3yfQMmvDSqkE1FRcBR/7jfqeUUnurpHb
 QougsDgXbLa7fYQ8N/9fDYKjZi1Hvyu2C6/gTeTLRDDXuXnAFbR5EdR3l/HGUKAJimwV+CxeF
 CZfqOanuwGudoKK2XXDHIBbYLjeDHeJSRnIP1i939qTcQzVXr1s1qIExL4jo1v3+gqEnhfoys
 U2Pr9Crm35otfpoT1EHFjH16m6UPiPVGnYtB1H6e0053pu9IxvVSt2EM4LKYMwE1RG17pmmy6
 3ecTzP1OGQpKL9m5Cj5/+h02mu0DZkHEyHoBRZ4rrCy7kLvEUwRN7x+PxMfMthIstf4Z/2Oug
 mMylFhiRikU5w6bSJxPlGoVh9s1AHU38j54Kkfz5aJ2fjg0GJH+D8v/eczwEbAovhnlT4nl2V
 n5gt2NRQ4NPhlxHHpg/sMPvSj0O5GgoTwbTjpBnWdPd1I=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=erbse.13@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

I haven't heard anything about this patch for a while.
https://patchew.org/QEMU/20240903062953.3926498-1-erbse.13@gmx.de/

=46rom 5c1ad1ff44438402ec824a224ac4659c8044ec7e Mon Sep 17 00:00:00 2001
From: Tom Dohrmann <erbse.13@gmx.de>
Date: Tue, 3 Sep 2024 06:25:04 +0000
Subject: [PATCH] accel/kvm: check for KVM_CAP_READONLY_MEM on VM

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


