Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A04C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 10:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5rr-00024E-9N; Fri, 27 Jun 2025 05:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5rb-0000cC-Af
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5rZ-0008M1-DN
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751018356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mdcOOQK4rFtnnsiyvXMveMZRY2UvQeTca55ZnMjplw=;
 b=IYTNHEsgd/VkY7R+f0thXOGTc1eoy0eJwgEyRV/e4K4erHW83aiyg6shjVhz7PtqThzdrR
 xuqSo2pNHQSINwGym3HoF0kReLK1vEff6FInPGDUh+lAfoarkL0C0X5gSxGblDRvOuGuzr
 dnc91dTKYaXRlD5+L8BpvyMc0C4bXrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-eWwoM7ReOIiykRkQufbPcw-1; Fri,
 27 Jun 2025 05:59:12 -0400
X-MC-Unique: eWwoM7ReOIiykRkQufbPcw-1
X-Mimecast-MFC-AGG-ID: eWwoM7ReOIiykRkQufbPcw_1751018350
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFFAD180120E; Fri, 27 Jun 2025 09:59:10 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DB3319560A7; Fri, 27 Jun 2025 09:59:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v4 32/32] qtest/bios-tables-test: Create DSDT acpipcihp and
 hpoffacpiindex variant blobs
Date: Fri, 27 Jun 2025 11:55:21 +0200
Message-ID: <20250627095620.3300028-33-eric.auger@redhat.com>
In-Reply-To: <20250627095620.3300028-1-eric.auger@redhat.com>
References: <20250627095620.3300028-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

HACK: waiting for the resolution of previous issue to put the
disassembled data here.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h      |   2 --
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 0 -> 6294 bytes
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 0 -> 5347 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 02f4f0b29f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..fce1c38ec902b08a152044e03c7d0023308c0586 100644
GIT binary patch
literal 6294
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
TIi}qR$Kk(>|LP`EaL&I0oS-L6

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..970d43f68bca060361105f70dbb00b3a25646db4 100644
GIT binary patch
literal 5347
zcmZvgOK%!i6oAjb0K+ig;bCKAY)F$veMSTLl{8HQGuS2pn=(#ZiAY0KrHbt?kQ!A=
zqe>2yk~F*8YS&cq52@5ucinZ-Wz|jpKzF6Oa|inz<;()+KF)XVH=L0U*KwV_zj6Sf
zlg6&S?Uoy#b?tJwTvh-;+>3AX`EBKa=Qh0ls9;-`rFq*eCt0_<Ez7djLG$jl9O#d3
z*t?zSSg*5fS(QpKrg?VHO&9e1i#P~i987@kqo6340N^R~M;n{__NL^1+U(r3EUOBd
z=kC?@gyz|HU6F{io|1@Ad_IV*tM_};Ewy)gyOw3GUMzbad9k<-p<r<fBPw!riV(}b
zfe0Z)B|tR9E~*?t4{;0?F{+qRV;NzN5k-s|W~{Ibm1Ag#v4R<^EF;1(bi`Q2j5U@K
z<roHHtYOAF%ZPD|6k@Dn#s<sKIEINB8<=sOWyCo~1~IN9MkRPTXo~4N$H*bZ4a{KE
zl)fa>RG&kPk1&JJQ-j;bJYw9$3_eej9HW33A7cierzwt6M2uUQ!RP4=$5=*;PcVbe
zQ<Gzq5#u&y@Ohf%7;hm)9W(em&2Wq>h|$0dK2Nh8<0@j<h*9P9G{-UCK@0~o_&lBE
z81ErQ6EpZco#PlEAjT$U@Ohf&7}pSE3p4mUo#z-9Vr*jupQj5Pqly?U%;591z%f=3
z;|^x<dAi6k))3<^X7G7h<QN->(Z&ouPnS5x4aDdmMvc$YWsY$ZF?KM6&(jjexP=(I
z0i&h1&kLgNPS>)n&GX`;+jG+?J>l0mm;L#&h@pMCsOR=vr7uyzb_hz*2<i%hl6~i>
zJ7QPC+e1*I7{S|mn_<a5$_m~h$_i7~RfZ+|E?6gByA}Luf>pOR#4~9*L8~TezUCHa
zUZb&d{v6%CUb>_gyI?~L9zhu_D1!r!;A=R5&*2e(fcRxvx3`yVf2AL15^7>H0rA^_
zyjR+mRe_8l`t^`_Jkv(FZCN$QBvoTFQ9#60&RZg?3YnA~^W$n4O%Z7Yb3=Y)^}Hn_
zr&B{R(h4F&;73kZ3Hy=L9fbYJ>C~`{tOSu^897}=^&_V{Q2og1R8>Y!H?PXb=_(Q8
z86ln#>KT!d(^aCxGfF(8)H6ywW5hE?JY&=|Mm;s+sS!_&dTP`&PCVnpGfq9@)Ke#(
zI`P!0r%pW+#4|xW6Vx+7Jq_Y%5Kn`88q_mMJd?yTNj;O)Geta8#4|-bQ`B>Yc+L>d
z8R|JhJx$_i5>JzQn$$B*Jk!K8O+C}pGebNx#4|%ZGt@InJhQ|zOFgsHGe<mg#4|@d
zbJTN|c+L{fS?W1UJ?Dt$9Pyl^o^#YQPdxL)GfzG9)N`JA&J)jh>N!t67l`Kq@m!#u
z3)HhfJPX9LKs^i8bCGy163<2Ixkx>W#Ir~|i`277J(q~*67gK3o=enonRqS}&t>Yl
zOg&4)vqU^g)U!18%$c6usKZ%Gocf6WH?m^cj_FTcB_U*hxF+I5d6@?=#9@xO%*o_G
z@wZHjUVE7b#R$t5z{H<ExdouW>-SNNe;xZXCUO$GME_IBwPW6{Ypbu1z;^a4<DJOq
z<8)Rx`<*{)|CWlkf7*Xi|K;O9zIc74tG2UWeSM^BwzFRwijTpwfnFMn&6Cpu<y#T%
zk5$ImlT&|K_L*X2I1oKQ8?sBFDrZNz4?V~2sN+j=&EMC5``caprt?GopU%Rsc4r(v
zJ%qD#SW(0W^hX`F*K|>FWBW%~;^3>MTW^^APj@nzl*Cg;mnrVWiC81{;F>sd+iE(V
zJbRD_ZWU1^-D^3?t)@c?%CPdT3_Wi4np<E1XmMTbKTn9J-E^Dna&F0M-rtK4MPo2F
zPoE8RQJcKz?)Mt{aeuTRZscOJ)U$&k%xov*Zbbc-yBldbZYMcjJ3WM<kROZ-C;U@7
z8;oN=9_XR7!BBtxY5;IH7#B|u_1G{I2|*GD!|z^w3Gi_EP!9G-3D>eb&8s^-=#OSx
qYeO~+kw5*>id(zrh(UjJ`C@u5FMcp%m{Aqo7@UbcK0Y`+8vG9j4In)L

literal 0
HcmV?d00001

-- 
2.49.0


