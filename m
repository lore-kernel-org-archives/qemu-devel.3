Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82A1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGN-0000KN-Oi; Tue, 23 Jul 2024 07:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGJ-0008Jj-Fe
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGF-00031i-Dl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqD0Di/u5jqVGrexXisvKd7DLh+zSri/mjbojl6aQqw=;
 b=SIh91ciRITpYBLufjDSKRGC5Lgm+QzP7ohopUQIRvptfQv+U3PFr3XW0HTHTtJI3d4F0CQ
 XQBEB+mbN4l57OfQDsHvcsctFqEvb6YUqCLzHpv1PXphN4YzNT6x87YPGSZyGbyYSBgtYl
 Tc5qynOC2e4miTwlKuWThcVaXFdnTaE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-SJE15ggnMhOA8QeqVYD2jw-1; Tue, 23 Jul 2024 07:00:49 -0400
X-MC-Unique: SJE15ggnMhOA8QeqVYD2jw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36841edbc32so2684610f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732447; x=1722337247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqD0Di/u5jqVGrexXisvKd7DLh+zSri/mjbojl6aQqw=;
 b=OUaMIlqb8QmUNTNPRs7HNiNOtyG00Oj9ZCApeiqK7WVHDKijgx+HdNFHVT+PSD4sXH
 EFg5q9OLje/16dONAZTkV6iGYIIJ+r9mW7RaFyh2xbFzE/zQUBjItcrO/2XlsRfGtG/X
 FU+RuZiO8/sQ/5qxjmGrGlEFqbw1E3N6BSn9dgf2uJ9jRHzu8tXSNNu2ufZxohIJyDtr
 KMe9q4BCClOIavpU33b+QkrQDFErhv4kbZZ/kKYjToiJL5cAHiDt3WMtCK6SsQCFnAYh
 rTCYBcW4S9ZHsCEbvt98l0sgmh2/WvLWZ9Q3Gb5SI+OzTFfFmhiCoixNuLB8C5IvSDgG
 toEw==
X-Gm-Message-State: AOJu0Yz9QEXMiNVxF3cge88Tgvc7e2pJajN/oviB5y+yvSzYbnElLkT1
 qAluJY2A9Y4Qc04/tsJuAkRmhKG01zA13eIF9MvVfm6JTcn7iJjqNcZEhWkdeWXyjfpCh5TCA0I
 x1L7iKvgYmrhxUE7uivZmTCmzJbHHEdzFpjEQDTJB/ECrWXEELveaq5KJ1IVxZnKBTlbyjaP6iJ
 bj507l6FxjL3H3QTkgsmYhaJPFTpQFmQ==
X-Received: by 2002:a05:6000:4026:b0:368:5d2:9e58 with SMTP id
 ffacd0b85a97d-369bad7d500mr6749595f8f.0.1721732446624; 
 Tue, 23 Jul 2024 04:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtilGMZfRXFb0gBRHLvelJw9uW4IeubSoeafYySjjQydANmCHQnpuNFy12zJ3Fq4wZLmBFlw==
X-Received: by 2002:a05:6000:4026:b0:368:5d2:9e58 with SMTP id
 ffacd0b85a97d-369bad7d500mr6749539f8f.0.1721732445751; 
 Tue, 23 Jul 2024 04:00:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc42sm11205707f8f.46.2024.07.23.04.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:45 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 54/61] tests/acpi: update expected DSDT blob for aarch64
 and microvm
Message-ID: <0af3dfa5c5590ae21d1f58a389968d4b90112fd7.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

After PCI link devices are moved out of the scope of PCI root complex,
the DSDT files of machines which use GPEX, will change. So, update the
expected AML files with these changes for these machines.

Mainly, there are 2 changes.

1) Since the link devices are created now directly under _SB for all PCI
root bridges in the system, they should have unique names. So, instead
of GSIx, named those devices as LXXY where L means link, XX will have
PCI bus number and Y will have the INTx number (ex: L000 or L001). The
_PRT entries will also be updated to reflect this name change.

2) PCI link devices are moved from the scope of each PCI root bridge to
directly under _SB.

Below is the sample iASL difference for one such link device.

Scope (\_SB)
{
    Name (_HID, "LNRO0005")  // _HID: Hardware ID
    Name (_UID, 0x1F)  // _UID: Unique ID
    Name (_CCA, One)  // _CCA: Cache Coherency Attribute
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
        Memory32Fixed (ReadWrite,
            0x0A003E00,         // Address Base
            0x00000200,         // Address Length
            )
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
        {
            0x0000004F,
        }
    })

+   Device (L000)
+   {
+       Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)
+       Name (_UID, Zero)  // _UID: Unique ID
+       Name (_PRS, ResourceTemplate ()
+       {
+           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+           {
+               0x00000023,
+           }
+       })
+       Name (_CRS, ResourceTemplate ()
+       {
+           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+           {
+               0x00000023,
+           }
+       })
+       Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+       {
+       }
+   }
+
      Device (PCI0)
      {
          Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
          Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
          Name (_SEG, Zero)  // _SEG: PCI Segment
          Name (_BBN, Zero)  // _BBN: BIOS Bus Number
          Name (_UID, Zero)  // _UID: Unique ID
          Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
          Name (_CCA, One)  // _CCA: Cache Coherency Attribute
          Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
          {

              Package (0x04)
              {
                  0xFFFF,
                  Zero,
-                 GSI0,
+                 L000,
                  Zero
              },

               .....

          })

          Device (GSI0)
          {
              Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)
              Name (_UID, Zero)  // _UID: Unique ID
              Name (_PRS, ResourceTemplate ()
              {
                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000023,
                 }
              })
              Name (_CRS, ResourceTemplate ()
              {
                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000023,
                 }
              })
              Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
              {
              }
          }
      }
}

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Message-Id: <20240716144306.2432257-6-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5196 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5282 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6557 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7679 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5398 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 3023 bytes
 7 files changed, 6 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9282ea0fb2..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index c47503990715d389914fdf9c8bccb510761741ac..36d3e5d5a5e47359b6dcb3706f98b4f225677591 100644
GIT binary patch
literal 5196
zcmZvgO>Y}j6o${(6MH=V$k=i0*l}VPO2ub2wwop`ZK*wW5*Ir$o}@u?C09a4lx!+d
zA(aX#WYI!)G=g=I@<WhVv17-AH5>i_JB;ppIOkQ*EXH&1-1FS~%$$*qZ^!NI_47oL
z<@T<#?bh0#4xL)9R?~<`U8`T~Wm|hNaodyeaoMqL+n8+kI_Z`(?Af-xPR3-v*P-$8
zO=ouy-Wv_JZM$9%?imwj<Yvoe@kN3ZFhLg44>8iTOGNaH#>X3*2hOI?{iHkCw{5#Y
z#>CxgnMq^fI4#XbWX+6^h$NPR$d-P86fUX1GupLnd+lP{S>(m!CPjkDZH}n>vm-)H
z`x+v`5cL4jR;y@82s0uvbjE0KMpI-&B}R-fnw)V>WatvZV2o>=u_iL+B!<ZtYn*Xi
zWW*#!iZQNp#=6LeON<O-taHYO$S@>^#TXl$aYJMzBu0)gZZJkY_&6}dOjBay8RI5r
zh-r!+Nto&d#`usk<UCDD>sVrpTbv>1X<A~G8RIr*$a$KP7!}62!x?g(&P$9{#`uUc
z<UF+`MvXD<a)z9zS&8umW3)I!&eNR4xXc)B&XDtTL1J8C42Llqa-QZT#@me1;S4!X
z7bV8KjM3!`IZq1`<9){1<P14aixT51V{CDToTp0?!)A<a&XDu8BrzI{(c=s`Ps<YH
z8e`n!3^`AiCB}8e_?R=~JgrEK4aVqmhMcD>65}Rg3>c#+=jp1%xWyPdoFV6FRbt#>
zjNO3I)BCf6Xt*=99eZ<Dd<;i!He)8eI_FJqykEp%Up_W*N3J&ZQNeNmr5S*_ETH_p
z8S0)|Rq*uyN);n~S#Jp}zYkf#SA?u6vaSd$zi-C6`_s_r1#eBUTK0x|CcRG3YO0#A
zyG6#N-QJl!M|W?Ot(uh~In<*^R3n>e)S*Z8H9e-!=n;{EcxBpfw71az$~?*?_2hI)
z>fMlkt@UlYPPvroHzVrtgpFw5wwsho>#6BfBNbDhwNzAtavA@g7uURKsz^H+8}T9=
zvzCesherHJJBW;s7a7hH^&-O+M7_vxXw;9a2a!=fGMq*CBEuEvUSv2__ano_>waW7
z%N%&lf#)20&iRqyEHUtmfoBXoW9S(N&p3F-(KC*o26!6aX`rWpo(b?wfM)_d6X<Dz
zrwN`WdYb5&1kWURCebsAo+<E5foBRmQ|Orn&op?Z(KC&n8Su=2X9hhp=s6Fb^WZs;
zp7ZEwfu{wY7J6FfnFY@*cxKTvi=H{~%z<YPJ#*-}0G<orxqzMv=$Qx4Jb32OGmoB&
z;JFB%i|DzCo(1qMfM)?c3+Pz{&mwph(X)u2OW?T#o=fPtgq|hvEP-bUJxl0W2G25h
zmeI3}p3C6544%vAxs09_@T`Dm1wAY1xdNUm;JJdHE9kijo~z)wik_?JSq0B3cvjJ~
z8hYlfiPLV;c}DH}sQ)*9#j+hYpMIaFNQ%@kRVVFbktn4$bJSr?r~j$HW$NzLmqpT2
zQNKkr^@dOH5NUMs9*gmgBX7jiAH)vT|BMWGe>fz=*&FpKznPfqx{iKwNKWUVezqMy
z{UW<yTI0cA&3~(vyFVX1ZT))t&(BW|P2K4nG)@jp!|5C}pQwi7sEejTJy$2Qs?KND
ztJBBYw+iTuuAdcNordH5ZcE*Kq6Vw}^TS^<e!rTeetww$VA631`q?FaHGi!C{<pjK
z&EUu4KZDY5&fqL@`X!xbqnf5pG(H~aqpr(JAjjM2Qrlxq(|+ywc<*33omSPmV27oy
z)xKFf{@|+GncM1iCjJhEzb#i+rPO|}liuofpzMrl@A#od-BEXoQbb0=)W_c?RnzIZ
s-F_{<GU?vmOFU7HhiBI5^M|IYU|tLlMs4$Gd|Xl&{$zeZ=me$O|Ix+vE&u=k

literal 5196
zcmZvgO>Y}j6o${(6MH=V$oM0+<2bPkrQ)+1+f9>}w$vUwj!T>vPtqW{k}IJiN;Z|K
zkV=IVvS=YY8i_4Iip1YQV#SVK7p&Rv2iReB=OaC@dS>Cwy>riV@8i6duW#4w?rs%`
zB0qO_oK3gh`E=ye>-D-uMCxAswVrphdsDYFog7sh+qRAA=AfHyJEMVZ+iPS@_Xb^>
z99?&IhT*gEaMQLMjo_Ivb;fSCVwRpINC6XM5&aM&O}juuPiS(qzOnCY_}ou=!#&%!
zn`BJg-L{!DrjFCrd_>mF_=rfN98|XTyW?<4TifFu+qPF<O?zJXYI2hz!Q?haH2m2S
zp{9Ke5n+f%fas`IG$n)?kr+B-G&!RsGNKYA#uzQmxFRxiiD59t70y@{8FLcDWQ<kL
zxGFMY5+lVJS2<%%WW*&#hB4MSV_jqz62oGQb<VgZG7=Ia#~9ZbqY->KFk+@DF$#=v
zoioIk;)f)RdXX_c<P15dDQO*L#<;;5a!%6{qrw<BIYZ8AMq*SM;}&PgIh~gnD~$0G
zXUI9VBu1SvZgYm5)2zgJgE88iA?GwFF)lJjhco1y<|W1@#&8&;Dd)5xG2Uj3E@#L&
zU62^>GDeRx<eU~I#`}!1!5MN+OA_NUWAr&g&S_a<*o?8s8FEe+B}S7m2Am=1v?4LC
zFvcCukaM~uF|IPk$DASOv??*y8Donx<eV-`jO&asWQ>-a(-nzvgE6)_L(XYUV%%bk
zoq)0Z>&O`d>lkg1?6$qGb~}S^&}yk&Os`MIwA0x>-<G($<7~~Wj>w?_J)k<-RHrUI
zps(p6eMS$66vW$jjK;h9t*^|(TvAWYX4H2FHu?8j-yJk4ms0&^r0))zVI$gi2QA8_
z_0(*pk*aB&w^UV=avA@bSJ!&gRF!rxHsVz_&s(Z892)T}?VvJ3US&8-)T<0v5cMj<
zp;5oG5mZL~%5WCls|;75dzIl(-LDK6ultqZEOX#F2cC22Ip<e~v&6tN2A(nWjG<>7
zJmcUQN6$EV8sKSwr-7aZdM3a#0iFr;OrWO;o+fyj=xL&75<HXOnMBVddZxfL1)eGN
zOrd8QJk#KrM$a^QX23H8o*DGapyxbz&V%PXdd{P#1)dgoTIgw^XBIrO;F(3wEPCd^
zGY6hI^vt1W9z65lnMcn&dKSR50G<W(ETHECcrJkF0(vf>XAwM$;8{e^B6^m<vjm<c
z^emxg89dA2Sw_z?dM<+JB6u#M=OTJmz_S9L74)p2=Ms1>f#(u>E}>@?JgeYYMb9dF
zE`#SXcrK&oGJ39n=L&ePpyvvD*1)p{o;CEWg`Sh6fv&#P{GV^?E84L)&cBF9V>g>I
zlipFpo8DKtf6jn?h1k>`yIOz>b_{^h3_x8JP=4Pz>W*4fu)zhCIxpbMdP`vWeaH$n
zy2y$m>yp6o`vO+MnmU~}on_RikNSP%za5)#^YQm-ilj(gGxef9FA=5GVUD`2+3Y{{
zvrIj`{Jcb3D(bh0X5R4GEh3GM-(xl2b?A+l`GeS{`k#>D?u|xdIJ@I5Dr_XCJFcT2
zACS}CZ=7z%Prk_JO=~jztMzZKdi$sS$L-&4zWn_7z|@`Ye)IUiG@R~!>yc_Gj=E_n
z)Km3h*3|2%_2T5A_N@YXqZ_Bi7boF3zuQs|AF08r|LowGjNh*&X`CGtKA3jhp?-S7
zU(KIufBfyPelz^B^v`hdcV~E-IQf#!vQbS_FElwC>f@dZX;cSY>UgYW+ONGo-v3}W
zo7L3+f?bxnSLbG(_`S>OWUk-qPW_1c$8rs|@!T79)BRo-G9A_4@k<YT<6fUqL`K5Y
yC*LJi)9Jart$Ja3+Pk}(c%&NlPpy-u_f56mdp6o1cg(}d(W1KHpC>2yJpB)c*AqPe

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index aee6ba017cd730948bfa93e91551eb10a6809293..e6154d0355f84fdcc51387b4db8f9ee63acae4e9 100644
GIT binary patch
literal 5282
zcmZvgO>Y}j6o${(jy)cKWb8O`;yAGjrQ)+1+f9>}QfiN##KlgGCuxve$(2wMC7ViA
zNToswS+o#|1&v@GP=5##D|YNaV$Fs>zz(B3cg8($duB17`*EIopF3xy>)ZC)dp{S5
zB7e4a-EFVh`e@)*tJSJOMCw`n+TU#%x5r*<JUTA9j^mi)?QT2MbO&9>an{Kk?|0jz
z+iFsqF*;s$9j7j}SrOgX5F4YT<E!p&KOAw`-*%i@Ef~=pyF)KmvWkzBq^6l9o9Np(
z8OAvxdPt+=jm-mhQ-eS3^!FXdsgpVO_L^489J_AQ(1@Is)rd%PF^Fu&ZVf}x-p+8>
zah$d1!%icg4{lK;7~J8AU_B6_hJ6VUVTf9QXsKBQ%Z3OmA~9l&QRj?cbzfjaB}SYv
z8k})SFXRi1n8Yv{;}U1AiHsSEVKK%UXIvH;afy*;jLV#{E;14lBg+`;oUtJ?Oo?GL
z#s+6x5gAE|k!Or6j8O|dju+mGB{2$&ag{T~G{ui3O!WoEc$YKeJWWgUSY(WAoFV6F
zMq-p0<2}xh^E4|l%8YTHGvqv-l^Cmx@jhqBd1_0HDr4N>3^`A865|!dXmW;}r+JBS
zo-taSA?N9w#JIp1E@RZ?JS|9!*BPVD8FHS^ON=)eqr(|;o-Rm?w;5xTGvquiN{ow)
zvBep3o-RrZhcUJ}L(bDBiBV^aE@#MjT9O!-7~>{q$a%UfF)lO42b>}2X<1@yFh-9v
z<UC!G7*`pi&ln9kPgf<zHOAQC3^`9L65~2!>;{Z(tT)|e4R!{O>ugRpAA_Nn%UUUa
zpYy8UUvFZtt`Hx4L(dp#R4^St878343n*PTMcq`h3cemdsm%zV)@uSw*C8wTijWmW
z)&+s3>!z$5KMdS%@YWQo>1?Pq>9&JXL+$xGTV#$~t)1yQdV9lM#VQZTr7qp2Dmhf8
zHr=H!=pKDccZn3l-=+<Qdvm?dt)qM@mYPgRy&KZcM$d6-luxUAE25SsEJS;b)1Z7N
zmYz%uQZcn@Nk!EupVe)CT;q9BMLI#>h#y&>mQ-ZeHKHS(ATmOJWH?IHj|^uJ^&`Ws
zQ5{(eBBMGo93|#QhBJuykzv=EjtnOs(~;pQGvGM`o-^n<qa(vn;@}wv&p3L<(K7*_
z3GhsyX97J<@HD~GL{Aevli-;I&m?*#(bED?3p_3Kw9qpJo+<E5p=Sy`)8Lr~&op|b
z(K7>{8Su=YX9hj9;F$%_EP7_qa~3>j!E+WpXVKFJPa8aK^t9142c9|b%%NuvJ@eq1
z2hTiu=FxKwJm<i34n614vjCn2@GPKb0X^rza~?eB(Q_U>7r=7?JQvV&0X>W0Sp?4_
zdKS@h5j+>ca}hlk(Q^qrm%wugJ(tk41fC`EETLx!J(t0A89bNKa~VC$;8_OGGJ2NL
za|JwCz;gvXSI~16JXgVU6+KtcvjUzK@T{O`CG;%VW4G0$XIXWYr2gON9m{sYdhkt#
zB56|BMBR)hMWVDi%u$y;nf#~zmZ{c@Pl{xuqq;;i@w-p16B%^!7K`z(BfrN)cVd^S
ze@LdcKNyhd?hSiX*i4RhJvVl8NN)R}cD9{3{WLdc*`xknjejfU8$TXAX#VovAD^5Y
zS~0hMP(L}eOt*c|xUUL|qaGRx^+?^Uin^cKPfza|Un!v9yLPtl^fc_Jt8LYIUv*aX
z&klde>UuRu?b%`BopIai$Ii~_+5Eo#+uz>Wm;LXH|MZuBb^B+@)6eKxE@~L+Mx*0?
zY}oPG7RdDvy43Ml!*X6)AO9UpCX<SK7wodtvpP3xC2n6-=Y3n9_E?`#=)=C6+Dh$r
z+nKFS8@8QM;|(2p)ERcRC{1K0t=Q=6lq$L%uhXj*R>qxMd&&E%aOccEeRRiCJDA6V
VgJH`$8XYgG2R)eH5W2xu?SCHZ3OxV-

literal 5282
zcmZvg%WoT16o=2)6MH;<Wb8QcBTno>sd!dnyJ^zWmfB;-afuV-Ng5<qawSwm$)*w&
zQmK$a7A-_#K_jsaC=&k$5-WD>Sg>ZpKfn&7JCEf2+B1vs+{gLu{l;fBcW%e+?EIW3
ziri~&I~#7T{qfML)oL}3h}5<EwZ89Z_a<(8GCnLjwrv}ejeaNHa)y1|wpYoR?Djk4
zx7DRKZG5=s*mgr|Gb4UuQ*4Zm53f7hgK)&rV8gcS^<YF};*8vE*(^LukeX(KETZpX
zq-ht3=n0Jv*Vgx(bszjucd%>Qc7u$GyVEk0#>8=2nvcku86Ocz6obf?es>g#Zf=dX
zZQEWsANDNrd~lN@!QeJW1os0GYS>p05r(J-h_;$VaN7`JMkI#L7!A${?(R#BsKkgd
zMw2tH_&4$;hAuG-#<;>6D<We?VwjAv!WmaZMoeO)7~?8utcr}d#K<tlDrc;T3`1gA
zjIqWU*F;7_V&oX(8e`OhhvTLH#grI%#<<QIVw&PZ5~lhBW4zB9a-OE7c@!Dr24~25
znwA)4#<<BDa-L=+MujnMafY0yvl3&OF+Si7IZrK#QDcnToFV6FR${!y7%k3_^E4+h
zE;2@&Gvqv-lNgs6!(ohuoTqt-@g`$*I780Ud5Q5hV{|z~&eH{n@h)SmbB3I!1&MK)
zF?yUK=V?)5*o?8k8FHSMBu0ZV`kW!>X<1@iVT?PRA?N9$#JI{BA99AArxl5@#u%HN
zA?N9m#JJ8F1IB2|dAckyZZO6cXUKV4l^C}eV>@7M{W5g=!90drL%U_Ksnt%u6O@{2
z71QmJF=@BA&Xy(a&L~?oD?@UqPY<X@Hr1#@59mvJNT1LHA_egl9>dYj+~ybNK`yB$
zr&H>=eVhDit>^aZluN04GtzVWjj#~yx&0>P(t2t-)kwwE&q^w)LAi|I=EXJ7iz?C%
z`bNCS##u>4hFv3mq#Z;?$cqd|iF%RY45D6S*fr`$)`Q5X9~q9Kdy(M`bT2aOs{4`Q
z<aIwX9AySPXTWm?J!kyLaFiH$#=tX%o-y={gJ&E(<LDVjPXjy+@HEiVK+gntCcra+
zo(c3c!P5j!6Fp7zOoC?;Jd@~|M9&m>roc0Wo+<Q9gJ&8%)99H-&kT5Gz%zrM8T6b5
z&sp%CMbBCEw7}B>PYXRQ^vr^17Cf`)nMKbWc;>(}hn_j~oCD7}@SH=>IrPkfXC6HB
z=$S{)dGMSE&w2EmN6!WDTma7n^jtvC0(cg{vw)rj^elpB5j>0NSwzngc$UDkgq|hz
zEQ4nmJj>`=M$bj?Tm;WW^jt*G3V2q)vx1%#^jreZCGcEA&n5I+2G3>iTt?4j^sIts
z6+ElxSq(kMhkaeW)cnsk^@?`v^|Kf8aO7q)X42b=c-?!Y`}+)7myb={k*fu$V8s9^
z%>dLz0p-`7q3)<z1q)n2sr>>ztv3XgUx%z<p^L02vMvcMzb;_qt%=ia(P>8QC8_Tl
z|8{J|&Bx!SDUu>}Ow~zyULZ=T%^Y=D)9HWevrM&KeqJCg74=I*Q?L8<7Li6r@30u}
zIPiK*{Z8yq^-sufcZWkVoSo4o<<}FFZP(F{_Q~n&)lW9!$Dd{AOlv&&tNCxWa{I@<
z$E{y){`u+AzNtH%y~feLX*iv|<|9>59CguDsHf^=R@M2$dU5<v`&t3L-u07(7sp{g
zzuHobk5p$>f4cuu#;;d{)KB;G?@c=HKtH+Q&*qQS-~V=3z8d^c_-9c1%^92|jz6c<
zY*f?KiN=QmebjX!8`Vaa+8%3~_AB?t`wynmX;u9f?6B0e+Ba**?_E~=eZ6jH;-|R3
z*;iK!&)t3}-RpKBr=!|ie&|7W)a_A<$Viy__?x6EI$gKBS<5d?x_5UHk5u9QiFN$+
ZzNyxG&xU)Wws|l<EU63rJUPMh^gm}CCOrTE

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index bae36cdd397473afe3923c52f030641a5ab19d5d..33f011d6b635035a04c0b39ce9b4e219f7ae74b7 100644
GIT binary patch
delta 1923
zcmY+^ORm!}7(ijSNt))_Bz>mOEx4_iApz1w;!2&tj6JXeWQh$hxMJ8vAXdRjSVoZT
z{LMY1)T)o{FHUm5-mmG?=ch0CR;lsZ-|3qqdJb<|zx=B{1@?NW{q=kO?8blVkKxxJ
z?|;2~NWPhy)><`Ln04LgruA7hx&57vZ(3huV6&@giZJiGky3tMKeE+DHKqU0b=P5N
zOWl`aS6&_?TN;@=_NngEv2y9TpB%VUwh*{frUt$|_hsNqStfL)Y$0@|Obu0PdZ*id
z=u=rHf;56OqBQcQEHi<0;!1%|05x`OZ<0u3NMlH2N@Gf=kWL|;`clqm`hXgDiV36%
zqzR=7r75H-q$#9!_!^qI(w@KDLI!C@X+~)dX%1;lY5tJ9RSG~0HL}mY+?9gTg3=Pw
z64H{=lG2$g1v&%N%qX2vT0vStT2We2T0>g9QlRw!HTJcwDQzHaAZ;jZD4jz(hjdQp
z+?Ph)(*>jpNEehYC|yFjgmgJbEp$ofN~!+*-NUhhbVcck(lw-ONY|9EeJRilpk@Q<
zhSCkCEu<}^Eu}4`TUW{!wgc4UUALulOX&{M9i%%-ca-iS-2=Msp{D<8?<qY%dVusm
l>4DNCq{l&;cioZDqe_E!uRgseNKcTSC_RbvPucv8{{w0Ur_ulb

delta 1922
zcmY+^IkKBD0Dxf`urXq>jrYBKwU@~aoX4X{L%Q4{If7<#fmgV8ojQ{X<Q%yS8ExkM
zm90VlNFM?o*T+@fn%mdMT8QB9Z}}++zWloXkl$6+)F)A<QQEe>s;SSS%=CX5R84*H
zgRpAqt0?m*Yula>cAgvQ>LSX*UNhab8|w1p%D|MD=SY{z&kbyPa%mt;dUlgTllm=$
zCiPQ8Tb^AR+R`r*nbL0|GNqpy38|dZY(KK8U#1UfAJRUheOvlv29OR+>7fHal^*Mx
z<fSpBF{Cl2F{MLDhma0!>Cb8Sger5238V?638e|85>g4Ngj5edLQ_-f^EX>aAx$Yw
zDa|0wAk8Svo>H?)4rnfV`uX>FC8so}w1BjLw4k)0bYw~o9RaFFl#VDJLpp|ZOzD`?
z38WKKdg!EsD*f6{C@mo^AuTB_DV;((g>*{j)RxM>r!z=rkj^NbQ96fo4(Ys;YUrHM
zg%Ixi&BL*PbV2EY(j}xzNSBl@ZRw#aK-CJ;6{Ram*O0CuT~oTIbYn`tg-r)lS=(+X
z-B7xPbPMU0(k-PsNOyql98|fl_Kwm$q<cvBl<p}#Kzit;S=$~6JqQ`Te)#krAw5ER
jr1a>e-+tCn)ztS}@}@s-_jmXEFR9J=MSlKMl<)C>L_)+@

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index fbd78f44c4785d19759daea909fe6d6f9a6e6b01..c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b 100644
GIT binary patch
literal 7679
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
Tb?0#JXd0jR!+hoS0#*ALFGd+#

literal 7679
zcmeI1%WoT16o-!=vB%>_Y{#)<$Btbn70+sHH%(gFQhV$;E^%T!NrU7{u0TbUY$8!1
zN`(knw2&Q*#D-0fBJpQ{#EKm|7KkMq{sDFjy7NfSPd!^U$g{BL-nr+y_p^`XGj}>x
zXWOn21%GUBnd?@q{qE4L)oQf>5vg<ao<8~`aA#t*C*#ACX&8n!S?_m}Epym63}c0~
z$xgpR<HM`w*1*3u8mt>ez3yGpCg#Y>l=Q;m7%5<k(nMcJC=fVDL=S0vxVpA$uDRTI
zx`Q3VFdC#ytnHQ_*CwXf3b=@jo^lbv*n$_?3f~_2OWN2RZ5f8K{A}8@$Y+!56!a!H
zIHK;(jtDjFbBG{A)ICI7t)d|z^q|BDGe(0mnj#}4F(Qo7<cv!qBP=mA#<;{8%OYb&
zV(5&q%o&$OMnqyH7~?W$tcZ-L#7Hs53TLc}3{7IB8Do_*u8547#K<zn6~?H0KMqVW
zU6&X+#<<EEVw&QQ#834+W4y^3a-Jrnbu2K(HO`RpG$}DkjB%Ya<UCDDj51@~;0!rW
zXC=lGW4y%~a-OCoMvXCUa)z9z8Hw=%W3)I!&eN>KIL{bu&XDtTPGVeO43jY$a-QZS
z#><S+;S4!X=OxCgjM3!`IZyKv<8{VZ;|w`Z3lifZWAr#f&eH{nVKBxzXUKV4lo$=h
z=yQggrzMGTi7{?*hMcF165}#syv-SMo|YxXDr0PLhMcDriE))N28_{^^K?mKTw{z)
z&XDu8Dlu*_#+JuueK#~$y>$#Xhepd-Rn<<v<F%TkP1@~E{lF=b)SI<E$`tkdK7C5>
zQH?ruk3OOM^gi7qQlU<{F&u5rZG5aBWaHtuZBx(c8|0n`dRD(q*@WuXgFUO?@Ef6?
z)o)TZ8BW-CfK*KVtfitFlufzUoVez*riwJYu|X%Yan@3i{?MQsX?T%Aaw7d%LQbT=
zf{+vG4-L7IbuTjHM*6daok)KLVJFfb8g?W7#fRNUf0h~WoB_`n^qg@c{aGU583E4-
zdPdMQ3Z7B$jG|{0JvH#uz*9p{4LxJv83WH4ddARG2TvV5b@bHHGY+0{@QkBp96b}@
znE=lOdM3~_37$#tOrmEJJyYPB0?!nBrqFX1JZHgk7CmRtGYy_;@Jyp;8a*@MnE}rX
zdS=iw3!Yi<%%W!&J?Fr44m{`3a}GUo;F$x@9D3%^a~?eB!E+ux=g~6{o_X-hqh}sH
z3*cD*&jNZD&~pJi7r=7?Jr~fk2%bgoETU%-JxkzO0?!h9me6w%JQu-p5j_{tvkabP
z@GPTe89giDSpm-qdREYL2|Sm;a|u0{(6b7jRq(8$XVv!{ANIrQPtCn)Q-92+v39mA
zFdSK#lpc3BAYOF-$lcuq?8`+a*2oHYD6dWcR6qmNc>(42ouO{2Re5DCpwun_U)D<k
z%k4v!SKcBkgsck!%kA@6uKm28{VGYp1Q8w30TBi0A!*jma7dcDJ=&n$T5Pgqnc<^7
zGCRBVllAEFhnYD&Js$kt{JUDd`R(q5)=$@e``~C#51XCc#?hXxnVsF{zG^6rI%z7@
zBlV(J)$2+6>GA!*=L+bIuAk(e9{c0m?zFnNuLi6B)4lIgZoitOe!7=?W74q(;gfUj
zYJOe$<xgw*v%xoozXrvh&B00R_#-;agaQHeLgT~DABHB+45?(Zx;?jWJIfhWwpI1=
zkWA{+J*ts0E#90`b6ULF)8fs^glX|+Pm4Dv6Q;$RJuTjxOqdpLUY+@$6>qup#B8_d
zG^HNYsV!-@np=<R5BzeD=nJQ)dr}}usON9$NZa;5YA2nD?2Atd6i9^J7Ljc`y*E?|
zc=Q^JaSl})+UoF!dxz@(Ulxpm@ThCSt%Q0ush(&yb>q3u$N3Iy+penbf*omft{!!^
zqjxT<hpD}8XX4(UxKC2+YOipo-%0km9k?M01zvGO54xjnj}k;$Ob?I0jH{;EwYnR%
oTxHU|y&c<Ejk_o5<41ROwORLgxI1d=2jjz{I^j1%rdQbh3(M9{TL1t6

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 501314c91be01d927fd125e0c72e919fdd85592e..029d03eecc4efddc001e5377e85ac8e831294362 100644
GIT binary patch
literal 5398
zcmZvg&u<z>6vyAf8kXgU0b{T+Hl$6X{)`rgV<%10z=Ca3uqoJaB_a{2O4ZbtNR29`
zQ6<NRr1h<_+OsS952@5sZ@u-9b1(e|dMnlJ?2`9&-X8GIym_CQ&(2$EyscqtH$P7l
znr-g5Tf<88^S)cDR4N7$seAP|{cOj$Hy$>}qobnhIF2>m>a>y#x8HFbXN|1!UZ+Jm
zR+VDL=xE7xoSGD~LpoR&gJB)KA_h$zTor>eI(StKMs#pZ3`R#s*WI07U^(b*IZn0e
zTUujxFw7L~!t)rZM-!to(T@=_j0;5cghof}8~g5t27lJ>?KzH9BWpa|ZP;;Z?79s@
zBQkbMBSNtSKeJ)p9Rv@zyFJ)(9B1|QwA0MjliL*XCwDl)-vdObY2QGE7^3PUnrapP
zRw2R;Neq)QYMkNk=s8AMVni6D&Kds3pJSL3!(xmpoZ;8UImV2{uo+{OGyF0-$B0Ob
z1Y=y~48PjWF`^P9#TaXxv91g29K(_rX~tORjB6qzCNZ*%ag8ym{>yQ09k#^CF~)Vy
z5X%%_lAzS{jPWsN$aR{K*0I1CH#kGC)1<^GGR95Lkn1!hF-nYai!<apos}3XjPVI)
z$aR{Q7!}62%^7l?W+cX2jM3l>xlXeZ<04};IYX|~If-$JF<i!|$#t5O81FJhi!<ap
zotGHzGe(;;<T}kuj1L)OgEQnhEl7;ZjIqfXa-A+n42LncI76<}MTt>kj1FhWby}1d
zR~X|CXUKKBBr&cs#;2Si*J(*&tTRTJGvqp5mKfI=qsJI^xlUIk#tp{U<_x(`%M#-j
zW9;~hj@g|a?fTn&$8|QQhmZbXm`T}j@0|0tH(noNurC)G4+leIq*4BI0A*N!x+tJ@
z-xPI6t;&CU0HqEid|B@ZEZv7J|1CmR7+IGDmhPLfZvWhOJN~XIR>N6W&!p4xTXl8j
zYj2V@ZZ@~4&vCdr$dv6;pIqwD1FDci6>8A~`j#Hj7xaKgLA+yHf3Q2({l-4b#?AO-
zLTYbF-y2=WsZutf`t6W<JV7Jeb(}h7lV)NvF-YZ9r!AFLqijmYyuAABrpk2uu^}(B
zHf^cQU}#8ZI(}w|yv$&hu$LLEAnauZL&G|=>Su;^W-yECWd<uSz06>!sWXGcn>sU?
zWd=NFz;gyYXLM#TO9VV4;2A;B2zo}rGYXzj^o*jX1)dgoTIgw^XAC@J;2A^D7<$^^
zX@jSYo;G^M!7~n?arBI%X97GE;F&<r1bQaHGYOta^h}~>3OrNbnL^JLdd`C9EO^eM
z=PY`r!7~k>Y4l8^X9heo;F&?s40>k4GYg(s^vt5?9C*%w=Nx*@p=S;}bKsdn&m4Nr
zgXcVW&ZFl%dgj4151x7S%%f)kJPY7iK+ghtE`a9(crKvl0(vfj=OTD6qUR!d7QwR!
zo<;O5qURELE`jF~dM=@72|P>SSwhbedM<<KGI%bd=Q4V(faeN$uAt`%dX~Yn44!55
zEC-&s^w@1S=q#naU#b6Z^oeCFYCrxVNudO(YodOP7X_k(`k14x^knj%`nOC)FTW^|
zkqGM+(Zm}*xkY5q@dqr&yAHh(6FrDss{aXD!@Yi=EO&R%rQAkryfbvo;{$SA`_<E}
z=*d@^IXgY-y{i9PF5UiR|8e8Dn}2<Id|;byYrl4UU|Vi$zy3%y6i40E73!(_vCHcB
zH2w1Aq4B)}dZVkS`IjfbINhCA!AEMa>OVX9HKqI2B-OKn+(+ZquxFlL(5v}#?T^2Q
ztKap0D*V%1{N3%H#!kMbvrO19)DMl0dgh=#WJe&^`_QF6kJWAGjpyU-!DKQitG!@X
zTHUMfX3glm%jz5BX1g`!-{q?6D7DvVB{$nGICh4O_jKxEd(hsb1d$c9&C#>CYP#)V
tyIaXEkK1>5V~<qh{%QK;>3v(BV4nB)2Tl8MbhM~$^kn)#==w*s{{hx=B0T^A

literal 5398
zcmZvgO>Y}j6o${(6MH=V$k=i0#BpL5O2ub2wwop`ZNVNpj!T>vPtqW{k}IJiN;Z|K
zkV=J=X3;`+G!p9|RpM_Tv0}%L1#33^0d^Q&-<kBh>6yiN?#FrVeP+&Ru5a6K?-u5X
zA}6gKZ_}@~J{x$|YPD(*k-ApD&eI*^?$~dQM@J>kbzN(`*=whp-k|5Y?iyL+y<VGi
zTTN;+Mn_AY>(-?<JE9vKVq;V{UJ)Bj-MA_?&gjOgVq;7<u8EED(b08pryp7l`<t#?
zs|A+U*c<xUl3je3Aa!dJ<PiN3Bg42rM2~57w7#+LZD{bPo&KKdx^=R~{%+GwT4T>^
z8XA$cGa3;|ECi8F^Ug55xm(-A9oKbNUk!T}`D$>RBEjG;M+DCR5o*}i5D|u`1&EfK
zMewK)VMio}$ryFc2%hLUMpR<N7^A@%!Gk}?FeQe?7*{wW$d7Z38Hr&t#wuq7X>^Ve
zlNc$+xXKwpww+_dB}RrZ);MEbC)PQJB{3YvSm%suA|oL&a*T0}F>1lfac&;A#K<$o
zb<Pme6kn1s)eDUAA!o>Wnv&+Rz!*0;L(bE*#3(VwP0o<>G$S#}jB$%I<UE~~7%PnN
z5ogGG>PU<#V|>gRa-L=-#v6>$<P14aa}whsW3)I!&eJ)GafvZJ#;D7AnwJ=FGe(;;
z<UF0181FJhhco0nEl7;_8DoPp<UB1(jLVGC<qSDb7bJ$u7@M3S=jo!vs53^7Gvqui
zNsKFuaho&bJYA9)R~h3I&XDu8EHTy@V~aE7JYAL;*BPVF7!5g3S0u&_#@OZzIZrDR
z;}&D=1dQ!p23{|i$6$NlHr;i#+Ud1}QbVm`I$g5Ht=9J0vc%sVW-E4iKpyqzK2^!3
zDz)i8eM1lEbGlEYAk&4%V7NQC^|gJNOPa~agt~suC4Fsl{a%f7DOGPrx_+-77NT9h
z*PvY5Oid;RshHYXNk!Eum(gw0xW=oZigbg%k!fW8tfV5tt`QyS29Xh(MuwwAr;*_d
zqSMH*Yg9+pg2<?j3`a4ik>L!?X=K>d)RE!jO&uAIG6SA7;5mbyGdeOHB?g``@Qk5n
z3_auE83)feddAVy0#6G(E%da|GXb6n@Jyg*0zGZ;w87IxPa8dx;F$!^Bzh*%GX<V0
z@Jyj+3O&={nFh}^dZy7c1D+Z1%%EomJ!ipl7CdLsa~3@v@N~e_K~D!gv*4Kp&n$Xo
z(K830Iq=M(XAV8*z;g~f=g@NwJ@eq12hTiu=FxK=Jm<l49zEyLvjCn2@GPKb0X>W0
zSp?4_dKS@h0X!GLa{)aU&~p(y7r}E8Jr~il1fC`EETLx!J(s|92|Sn3a|u1m;8_OG
zGJ2NLa~V9B!E+fsm(g<tJXgST1wB{LvjUzK@T{O`CG;E}^-T3q(|_O8C)#s2&OXG0
zp`Xpz$>~<ao6}Fa-e<tNd~ECweIq~xD+WLr7N9N)C|!4kx~*mvEN}s(_6zv5-V#{4
z4q3rM7g<qcT@qNjE@0)IvDa$S%Z%E;QvYxC?bwXlkG@Y+Bt`0&sFU%$NR(2WIqGmG
zlmFD;GSzzdd6A4%RF{Y*)9#a7L<Swd$6}_(;k3s@cVdUCe@vFYHyDuR?GCpnzmXX4
z_?~%uKwf*lcDflq`7%3aJEQ(zjejfUkAK>K)cp14pI;mw*rwOsuOA=Sme<~IJX8h6
zQ5Ow`dZJEtMV(Kb7bg#l?-X#_yLMW5aT4~^)sAX>s5-0qmj^#*biEp+_VOVA!MN@B
z&C?5dHh--B{<pvSZU4vOKmEnuy#8t8<STlajT(kJ(deje4m&<%quS_F+hYyeeeM2C
zpTT4@si<ec4o6+9eX~~l?q#*d*zL5(I>q${V@)kQ_j>Jgx6_84jvDXi(8JEK)1?%V
zm9Wjx)1)eT9lx_x%`cBTcXksGRpH*LbMoY#t=4<b2K&R7eK<N=R2Tex@`Cs2fAp+B
AJpcdz

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index 765f14ef3d1e54d3cadccbf0a880f8adb73b3f1f..8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e 100644
GIT binary patch
literal 3023
zcmZwJzi%T&6bJCP_S#;LckT6$#Bt)ph8BUwwxXj!I(v5GGqRIq*Eu7Mv?rk;jx>=#
zNXH2&xH!0UoF!@_<qx2xJBf;l>nJF=hK7cct8UTkcysycvc-CSz4zub-eR1<nf_iN
zO1Xn0aVKaGKJ-Mp-EM0{B-`@W9{myqgK)lh=U^rdjPTCLu|9Ao$DH#n8DTK(vw{%{
zKPX#_4K+JsXEgHx%@<v9H0i|a&Hl5DW`xHhM^gbM6<{-KsJ%$PNR#oVO)_Sj9lB1a
ziu8py;=I$NIMN!r4ymvrD?H9pTFVp3pmW!Ehh!41UNU|DZ9#U08@S_kZ8vo9PV;B7
zb8lrYAKqgrVyQ>o%pb7x`Jy2ks+f1^alwVEMf1f#zw7f`YHob!A92q2)g;Rqp%8sd
z?PZ(QALU7-;?FNBMf5mJnpRi)T8#8D=lpv9gLQr*^!#A$&@?k%f8Cah)v{sW2iiK7
zI?VM}*Qqp2W!;cUja{XBU+$`V!>(8ga}{sMrN%H<@1|U7%vHJ}mm0guHCTFLbnUeI
z{9Sn_BL(hr`5grAkc@CJIJ`Q?VCt7!tm%=U5uH$*IJL>46Z(qo(<gL7B$LE{m*-Eb
z<1g5GrJxt0h~$4ms;!MV?@+~*<18hQC+VceocE|=>1GsZBx5>PJsH)dN>R<lalKbv
z8OhgcQ*mVXswX3prSgMROXEZ-iX)RM={PdkK{}4)>mq3t*?HBKHIpiO9GUDuk0X<%
zx{6FTudA9#l?*sD;LM;iqau?kS#V~-nMG$7ojGvkz?nm5PDLh81Dpmp4Rjjl%!4xz
z&OAEv=w#qz;AH4z=q!M<0L}tB3+Ob#X@b*4r-@DroEA7ObXw>vg0l$DB07ucEP=BG
z&JsFH=(NFUgVRQ*jm|PS%it`dvy9FPI4j_+ptFL`Dmbg)tfI4u&Kfvt;H;suhRzLe
zZh&(Gog3)f1m`9=H_^F?&N?{j;H;ywj?OJ`Zh><Pom=Q^fU^P4209z)+y>`1IJeQc
zjm{l#?tpU#ojd4kg0l(ECOVtw+y&<@ICs&xi_Sf8?tya;oqOnPfwKk97CKvrvu1{3
z(5FjzU3so<D~B2O(f1am<PcFLU)pzdB2!)*<?}R(qQBPd_QhM*X4JHdlFxcc^4wO}
zh2Yrp$PiP1Otpi2coYcz;*^9l>#XkNmY<cY%$`sF?ETkj-u`j+W&i1We|&mz%5>q(
zx)-O+5YDW3COa~ZZ1iNRhw{Z*^1ZU3EbnXI$b|9g&T8|?GFhjFZ8>=+7t8U>)1QiJ
zTo&nEp4Q$DonWG`-cY-FcI&slgZ-~3Kh*!3G=3G6Ret$7U6#|DCSNpPOmyE3u3d6O
qe212o=N{v)ozHW59#Itio1Dw~vE}arvh9!MooGL-<aCxHqW=NrAcr3S

literal 3023
zcmZwJKWyVv90%~96DM(A?8N!grfJhAup*F?s5%y;CU%-LYFcBr7etVJ5-Q^8QVE1~
zoRCU}gX_jsVh&Qp%*u8W6BD<A#K0{qER5WAMn6Bhy|1nwocHhd`@PRoBtIu`4u2~V
zW&Ri)*tdi3=zY)bcDr4Lh`7zaru%akjKcZit=*ZutA)2+$9Qi%J+dsTPg)op4n;`|
zZ9k|QLQE7hXXX_BKFt?>`(WCO*XzTlIYkSPTt|@s6&YX(W1>9IKF^Z&x=9?fm!FKC
zP!<{5o@-gX0mYHVWbBX(D~r;jJY|(45eJ=({qcl!qU8&r&c7~k*B%Gsy>4SO9N#%C
zo^t2z(!6+ZS7b<J9(pr>B+llG7B^%uZ{M?Q%a*lhz8I-@eCw8++uQdKEX&%KlcJ!7
zwmnqjUe-nPVUZLn|MY?~M33^MC{4Mq#m<kO?ONCQht}IHaGki?&|+CIo{$!fM*B%+
zJ|Dl@5p9oba_N}5WKowKI;Jn^9(_c|M4Tkvfaf39_dXM6wUSzjBANuQMY63-0=Gvs
zoySFH61e@elbr<afNF-SN0CAt)4S?%RG(^PITyzbuDcv*C2KQrWdEwik?B%CV!1R<
zl%Y5>t&)u+(;Z~vNGmClm65&cF4s(}sBvVv12v9Jm#Q){-MlJmrd4v_%z-n9&YX-)
ztK`9%2WK9gd2|-QSpa7Nodp@0IyG==;MCBmp|c3iA~=iaETU6@Q-D*TQ=qd1&Js9F
z=q#aA2d55B9i2Kl4R9LZG|*|FvkcBMILqiPqq73e3OFn1tf12brwL9IohCY~;H-kP
ziq0xJYv8Pbvxd$ZI_u!9gR_p#IyxKRY=E<Y&IUSHz_|j>6?Cqka}}Jc;9N!LDmt6s
zY=X0i&L%q7z_|v_HFU0_vjxr;I9up!p>rLa>)>2R=Q=t!z_|g=4RmgxvklHRINRuK
zqjM9So8a6;=O#M0z_|s^Ep%?7vjff!I6LU<q|W)mRryPG{fV}%-K!6==LgAELs9hj
zlm7DcBOPnx!@v)eB$d4HB)5qqm7+l^<Azjn>?+l}ysQ2VyAm19RlXsY9K&3Ln{s6_
zSLKFWaxBT!&_jDPq)R@FXYwfabK-+<4a)EkQN%Chn<kOY7e{`cL{aot((azW@zRW(
z<|uxWCF!#x_Yxd=9%=TWzekPTVt5eP>iG%T&aAh*UAXw9S{LSg`sd)kPJ8G3+2_M2
z@BIGp`H4_%XVyPI5t{AH2B+NNJlq&?st5cM9eyv(#~1gMuQ*}6y0=_?e37n`!zNFj
z@?svpJo%w4$GJ%F@}%)*=mb-B`I_9#(_6p(9c+I&{jT}XwDpTUT^27srORqoQTRpk
w#Z>jj0sP<i4$YV6fv{dVpJ#j?Q55}~o=ftW{Cl5F^FzKbZilskDsn{hKX72A9{>OV

-- 
MST


