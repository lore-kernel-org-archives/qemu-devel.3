Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83FBEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAZ-0000Ea-C9; Wed, 04 Feb 2026 14:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAI-0007Ut-KF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAF-0007sr-Uk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvf+8kNCv/vttBlFTNJUy86tTIEYvZX8DU9qziGh9Yo=;
 b=K99IZedfDKytjPuNpPW5978seBd41CgeC8o6ErWhU+8ZGdNSK5mV/pt4/vwwpJui1ahBi8
 AxpMQfn9+RHCmN8w+MFtv3M314peCGFnt9f8ZcbeVyyQQ7HMpnJBCAtePNwt9YZA1gk99e
 WaoIXMg5kp9PN1PTPXG6OCwVG8IgHgY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-KFdf_4bhPSWTqM3rb7T91Q-1; Wed, 04 Feb 2026 14:03:46 -0500
X-MC-Unique: KFdf_4bhPSWTqM3rb7T91Q-1
X-Mimecast-MFC-AGG-ID: KFdf_4bhPSWTqM3rb7T91Q_1770231825
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso178302f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231824; x=1770836624; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jvf+8kNCv/vttBlFTNJUy86tTIEYvZX8DU9qziGh9Yo=;
 b=M+ByakKB9FRTqpYkrsrOvJ1ET5uJUR68ECxS6AeG6tJ2JAnKvwWaToUoBTlNgsXJz7
 II24cTO4HROxg2pjp7W9CTU7/aY3QOMrk7nE2GoLb/ZQbX995GfEmBIgKZfGp61Gm6lh
 XA2mULWUPI2JHPhCpEfbbI4vinlW02Et+PMO9SqgWp/1eybhBaeV5Pfb7spZpABWdAOR
 pv0+tzGCFTMBiG6tNXVjePdwnFSBUxT+u7yXAevVdpuX0yA+tiWY5Dr+I+PdiTSVY2L3
 RMvuVnWz6S7VyuhrhaVYm2CetbQN1AOsgIVcJjFs2ZYoKMDE2cXOQ4rJk94zrRG6fgQF
 B0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231824; x=1770836624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvf+8kNCv/vttBlFTNJUy86tTIEYvZX8DU9qziGh9Yo=;
 b=cqAYkH1TnIMNAwH+IRtJKQ76FKiyAx/StdFmgqDCIZsX8RKK5ag+fChRMmoli0nYwI
 0xRK733kJEbSbS2k74WdmraZE5MMFJOgwZUtjlO2YwIXGy4VLD87krSOpKYNtEQhJZ46
 KU2Pqbfp/VxEZKyPkoJYDNDWzg2g8xwrc3UgbJyv3gInJS8JKcGC2ox8EjyGJBSUXXp+
 RQQtzN8gLc25JJAQtQiHcVAVhNusaYa8YoxaKK45ExhcxHSgq8FG7quxWKUsrX0jIjIn
 ZHkxdFS3PHA1jyEtG0c8kFMCF59MiaESOxLs9SsLZEmQyi05xmY3eRCdjbdngoomzuZX
 X02A==
X-Gm-Message-State: AOJu0YzJ9T7J6BienQ/57n+PFKRcv8zbY/n2VnwrAyPHnkZv7sLd+9Wi
 D4hJwMFKvvSbu1hFvFetTpr4E4Xb8LeadYYhZKfe1K/dBE7nUND2QbhUurGMBSLZLe+2skYL/Jz
 rTyGDOKIQ7th6luwsd/Aq1EmiV7Ka+pCMLnfVAjx8yuoEughWx6foU3+6SiW4J45ashZUGnz2bp
 n+uQyCJ8nqfQMPcXcYoKhIy/aHGEKITE+/gw==
X-Gm-Gg: AZuq6aJvdlUt+c57yoa/RkRF6AQsmbJwL/IJvsOtLDrLHjJE5aCieKieYcuFH1IAoQl
 rdJSual+1Nqye9KtrtQTY2cpmVYwitlZLiCDnBGnM0zoe2Bru0P/Vjn4yx57jy5mMPvq7v9lNWG
 nSrKoUXYV6ZXlNdxn3IlyNLQv/J1kI53CzDVwvlUUFxofe86IWrCxv71dp5+qMNQg2fO4dwGe2Y
 C6sTxy3W1uXar3dgXwIsP+Q9mckpxE8LvTP8rzZecqmPi8JCBmOD0CwEiJpNIsEs5qCOWzRNl5F
 OEas//Auv+lQRKQIKoSRLfRdvf+XnNo3AXiNnjoj8x/ggCHAFESVAhhgtzVtxG3ddEtblXNsI2g
 b4CsvoYtwbNxZMSftXB7g1+R+uiveQ8V4NA==
X-Received: by 2002:a05:600c:c163:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-4830e988f3amr60107425e9.24.1770231824281; 
 Wed, 04 Feb 2026 11:03:44 -0800 (PST)
X-Received: by 2002:a05:600c:c163:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-4830e988f3amr60106715e9.24.1770231823539; 
 Wed, 04 Feb 2026 11:03:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fe86a7bsm23426845e9.8.2026.02.04.11.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:43 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 23/51] tests: acpi: update expected WDAT blob
Message-ID: <4c0583750e9b7b75fef8cb9216e2f9f8827cb355.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

replace blank table with a new one:

+[000h 0000   4]                    Signature : "WDAT"    [Watchdog Action Table]
+[004h 0004   4]                 Table Length : 00000134
+[008h 0008   1]                     Revision : 01
+[009h 0009   1]                     Checksum : 31
+[00Ah 0010   6]                       Oem ID : "BOCHS "
+[010h 0016   8]                 Oem Table ID : "BXPC    "
+[018h 0024   4]                 Oem Revision : 00000001
+[01Ch 0028   4]              Asl Compiler ID : "BXPC"
+[020h 0032   4]        Asl Compiler Revision : 00000001
+
+[024h 0036   4]                Header Length : 00000020
+[028h 0040   2]                  PCI Segment : 00FF
+[02Ah 0042   1]                      PCI Bus : FF
+[02Bh 0043   1]                   PCI Device : FF
+[02Ch 0044   1]                 PCI Function : FF
+[02Dh 0045   3]                     Reserved : 000000
+[030h 0048   4]                 Timer Period : 00000258
+[034h 0052   4]                    Max Count : 000003FF
+[038h 0056   4]                    Min Count : 00000004
+[03Ch 0060   1]        Flags (decoded below) : 81
+                                     Enabled : 1
+                         Stopped When Asleep : 1
+[03Dh 0061   3]                     Reserved : 000000
+[040h 0064   4]         Watchdog Entry Count : 0000000A
+
+[044h 0068   1]              Watchdog Action : 01
+[045h 0069   1]                  Instruction : 02
+[046h 0070   2]                     Reserved : 0000
+
+[048h 0072  12]              Register Region : [Generic Address Structure]
+[048h 0072   1]                     Space ID : 01 [SystemIO]
+[049h 0073   1]                    Bit Width : 10
+[04Ah 0074   1]                   Bit Offset : 00
+[04Bh 0075   1]         Encoded Access Width : 02 [Word Access:16]
+[04Ch 0076   8]                      Address : 0000000000000660
+
+[054h 0084   4]                        Value : 00000001
+[058h 0088   4]                Register Mask : 000001FF
+
+[05Ch 0092   1]              Watchdog Action : 08
+[05Dh 0093   1]                  Instruction : 00
+[05Eh 0094   2]                     Reserved : 0000
+
+[060h 0096  12]              Register Region : [Generic Address Structure]
+[060h 0096   1]                     Space ID : 01 [SystemIO]
+[061h 0097   1]                    Bit Width : 10
+[062h 0098   1]                   Bit Offset : 00
+[063h 0099   1]         Encoded Access Width : 02 [Word Access:16]
+[064h 0100   8]                      Address : 0000000000000668
+
+[06Ch 0108   4]                        Value : 00000000
+[070h 0112   4]                Register Mask : 00000800
+
+[074h 0116   1]              Watchdog Action : 09
+[075h 0117   1]                  Instruction : 82
+[076h 0118   2]                     Reserved : 0000
+
+[078h 0120  12]              Register Region : [Generic Address Structure]
+[078h 0120   1]                     Space ID : 01 [SystemIO]
+[079h 0121   1]                    Bit Width : 10
+[07Ah 0122   1]                   Bit Offset : 00
+[07Bh 0123   1]         Encoded Access Width : 02 [Word Access:16]
+[07Ch 0124   8]                      Address : 0000000000000668
+
+[084h 0132   4]                        Value : 00000000
+[088h 0136   4]                Register Mask : 00000800
+
+[08Ch 0140   1]              Watchdog Action : 0A
+[08Dh 0141   1]                  Instruction : 00
+[08Eh 0142   2]                     Reserved : 0000
+
+[090h 0144  12]              Register Region : [Generic Address Structure]
+[090h 0144   1]                     Space ID : 01 [SystemIO]
+[091h 0145   1]                    Bit Width : 10
+[092h 0146   1]                   Bit Offset : 00
+[093h 0147   1]         Encoded Access Width : 02 [Word Access:16]
+[094h 0148   8]                      Address : 0000000000000668
+
+[09Ch 0156   4]                        Value : 00000800
+[0A0h 0160   4]                Register Mask : 00000800
+
+[0A4h 0164   1]              Watchdog Action : 0B
+[0A5h 0165   1]                  Instruction : 82
+[0A6h 0166   2]                     Reserved : 0000
+
+[0A8h 0168  12]              Register Region : [Generic Address Structure]
+[0A8h 0168   1]                     Space ID : 01 [SystemIO]
+[0A9h 0169   1]                    Bit Width : 10
+[0AAh 0170   1]                   Bit Offset : 00
+[0ABh 0171   1]         Encoded Access Width : 02 [Word Access:16]
+[0ACh 0172   8]                      Address : 0000000000000668
+
+[0B4h 0180   4]                        Value : 00000800
+[0B8h 0184   4]                Register Mask : 00000800
+
+[0BCh 0188   1]              Watchdog Action : 06
+[0BDh 0189   1]                  Instruction : 03
+[0BEh 0190   2]                     Reserved : 0000
+
+[0C0h 0192  12]              Register Region : [Generic Address Structure]
+[0C0h 0192   1]                     Space ID : 01 [SystemIO]
+[0C1h 0193   1]                    Bit Width : 10
+[0C2h 0194   1]                   Bit Offset : 00
+[0C3h 0195   1]         Encoded Access Width : 02 [Word Access:16]
+[0C4h 0196   8]                      Address : 0000000000000672
+
+[0CCh 0204   4]                        Value : 00000000
+[0D0h 0208   4]                Register Mask : 000003FF
+
+[0D4h 0212   1]              Watchdog Action : 05
+[0D5h 0213   1]                  Instruction : 01
+[0D6h 0214   2]                     Reserved : 0000
+
+[0D8h 0216  12]              Register Region : [Generic Address Structure]
+[0D8h 0216   1]                     Space ID : 01 [SystemIO]
+[0D9h 0217   1]                    Bit Width : 10
+[0DAh 0218   1]                   Bit Offset : 00
+[0DBh 0219   1]         Encoded Access Width : 02 [Word Access:16]
+[0DCh 0220   8]                      Address : 0000000000000672
+
+[0E4h 0228   4]                        Value : 00000000
+[0E8h 0232   4]                Register Mask : 000003FF
+
+[0ECh 0236   1]              Watchdog Action : 20
+[0EDh 0237   1]                  Instruction : 00
+[0EEh 0238   2]                     Reserved : 0000
+
+[0F0h 0240  12]              Register Region : [Generic Address Structure]
+[0F0h 0240   1]                     Space ID : 01 [SystemIO]
+[0F1h 0241   1]                    Bit Width : 10
+[0F2h 0242   1]                   Bit Offset : 00
+[0F3h 0243   1]         Encoded Access Width : 02 [Word Access:16]
+[0F4h 0244   8]                      Address : 0000000000000666
+
+[0FCh 0252   4]                        Value : 00000002
+[100h 0256   4]                Register Mask : 00000002
+
+[104h 0260   1]              Watchdog Action : 21
+[105h 0261   1]                  Instruction : 82
+[106h 0262   2]                     Reserved : 0000
+
+[108h 0264  12]              Register Region : [Generic Address Structure]
+[108h 0264   1]                     Space ID : 01 [SystemIO]
+[109h 0265   1]                    Bit Width : 10
+[10Ah 0266   1]                   Bit Offset : 00
+[10Bh 0267   1]         Encoded Access Width : 02 [Word Access:16]
+[10Ch 0268   8]                      Address : 0000000000000666
+
+[114h 0276   4]                        Value : 00000002
+[118h 0280   4]                Register Mask : 00000002
+
+[11Ch 0284   1]              Watchdog Action : 21
+[11Dh 0285   1]                  Instruction : 82
+[11Eh 0286   2]                     Reserved : 0000
+
+[120h 0288  12]              Register Region : [Generic Address Structure]
+[120h 0288   1]                     Space ID : 01 [SystemIO]
+[121h 0289   1]                    Bit Width : 10
+[122h 0290   1]                   Bit Offset : 00
+[123h 0291   1]         Encoded Access Width : 02 [Word Access:16]
+[124h 0292   8]                      Address : 0000000000000666
+
+[12Ch 0300   4]                        Value : 00000004
+[130h 0304   4]                Register Mask : 00000004

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251030123750.136175-6-imammedo@redhat.com>
---
 tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat

diff --git a/tests/data/acpi/x86/q35/WDAT.wdat b/tests/data/acpi/x86/q35/WDAT.wdat
new file mode 100644
index 0000000000000000000000000000000000000000..e1e056b390e51c49f11f7b0d35e4e7c55d8067b1
GIT binary patch
literal 308
zcmaivF$w}f3`JkEx{TV)5#kX9FW|0)oq~c}T8Xtc(2GYhPO+$9AY^#?`OH6WH>b6L
zth#-_J6bm!dNVTt;vLff$K8QJ!5f$W4`2?6f@Jj4QYvm-AjK}Dx5`T;m_2{<;x*QX
lL4w7nzVfzt``kzV@waK@$$at15&T;93Z<9T{~wRc(JwJ97XbhO

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 14b680debe..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/WDAT.wdat",
-- 
MST


