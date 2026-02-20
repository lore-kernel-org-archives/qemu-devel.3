Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A0C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXc-0000S1-9k; Fri, 20 Feb 2026 14:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXa-0000RP-Ir
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:54 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXY-0001Q1-PB
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617108; x=1772221908; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=USeCCwfud+SMW1CRSnjkYZdYi+aqYd6kd3x5PlsSrls2oJj1Dmq+WIFCSw/fxdB1
 rhWbM4H4pK5Ttv83N7QRWNREj1ArhVv/peck7KZ/0++TN9Gn9wfb9yHXJ/fMCEkBS
 blwFqgVshLopgWj2SONpO38XVOT1ms+H9z44Tr3TBEfJNzCkYbBhMGTT8LFn0lQbH
 XepDuFaKdK8WUNNuKjuxiAkWffQvyjQFm9z8EyyLbtXll6F5VVtdnZhL0Itw/Xe4p
 TMBQoD8zgjWJ3Zieu3mbDNeSpNmMEBlSJgRL+uSawYF2p6uzzc3jlinIrsGM1fCkb
 2YUwp1fckN1Ty91kzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1wG5TC2kmg-00YWEM; Fri, 20
 Feb 2026 20:51:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:28 +0100
Subject: [PATCH v10 06/19] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-6-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtO3Jrak8/eeY1uP+83g+Y1GyzhKaT6OthEs
 cX0RM0RCE2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WDVVEAC8OuTPWnJbJCdNuoMaquT64ZRIIcoQ+gAYIU0bK+UGrZ+1oXSRH5TZOPwGIjTaIC3Vxiu
 pDOwOAEBKvpxwsi3o654gBzML96mJ0KwCOMgtJlPbOvGzSJdSKE68pFghxCoXw74Pk9/6jAqVRG
 D411X8ZML2RBDJz9hR58r5Mty5tIAd21ZFHlLe+vYuh0hu1zB3qqqRptQSoV6AVgkd0URzRqa7I
 Mn8H9+wS6TUWgkRxTbsMPUycIaZT/zn8Dk+OS1+0Htnz92jQeWMDpZbu+M+K4qARVy8IG4PiPxT
 dOImWl+9YyVGdOEHoxtEIu+IOTb3GMNO6vPT7sS/+gXX9GPHVa7Cxu7dWH8gD4aCAMtlp5SekMe
 pijyafEKPYOkTq77m+mvoJftgkNnjX1a+6BIK01yqIpao39gGvZuS62tBqH9dAYVsg9dLxs1ld9
 iB8liSYoq81nyhU93YsVG63uXHYopvrIvqoCl2v7IMeZ039NLqeCt5DkPiOTblQwD3Jg8Pn1MXV
 ljN8lvBYaFk1Yi0oIDVxinSOwYPNc+onoPoBYqV9RxmXKt1hRJ8GGkIbKG4czQE6K61Imc9uznd
 GOUESFUPm/yYIyADWt22ZQBXRgsWk5GzfbGM0Z1jZOfv3dTA6SCv6q3c3uamKDZexnXfibOPWIj
 eUcfIDo/62P+RFg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:T7FOTfTvqiy5Dd3CCvSpyIjyNWlIep4JEwnh+hkt5efSGzl7OEX
 X/gNblwp0WDguUbux/2nlYMzW2dpi1wYyBme00NDOFkCzQcwbv+LgSQWyxSn6R7zDoS2VjL
 RgwNxfFxgjSsUq+bRK4GQO2cMNsrXEX6DVJblMiCzIcSRb/q5PUYla7J02sF4IuB4tWo49Y
 Lx/SGLv+7iqgKbzXjybhw==
UI-OutboundReport: notjunk:1;M01:P0:1wHsieXjY4s=;bliDQrUr08kZOVo6XViR3xAX+/S
 q0ga+TuwwyAo5+bhb+joVwE6hb+VOnRi2k7gcfZT/K9MjmnKgw0R5Jv8nZtnuzr4XzVihn+ay
 MSOxTNUfjGD/xZCB75hSOC9Yklc+LOXRKsKonI93vfdEQ5Ir/3vVtyJ3AoBvBSrdUQWB20LZ4
 +DlYO5844flc413tv53fujT/JUa/8h0rKgZnO1rgweOvXvgq93j3qSzwPIKMHTNZ8YGaHAhc9
 FWvXtO+WSoSleh/1txPVbAvCM8RZ95YkdWVOTJ9xv5j5Dwk14cnLI32PvFqwdsY1xlWNGQ76k
 aH6JLfqhQP1jrSY5R91oZPQAoMZJ0tIIhoEGRmVGnuU9szTZ1aCY9eu7IXfoUwwYHmPTdMglb
 HnTbzF+NY7ciNYXvgzyvGgbSJ2VIJCUnr3kApxz6BIZgaetg9vVJi+tl9Vl7xmUeylbJoDtxH
 rk6qe+ymYiJLzzodFS5Srj8EKbn07vXksdUQtezbm0qw90FVDeFQQwW4YcnS3Xo4mG5GC4N7M
 Tz8pI9irTAVfTONCFNTAICYGtO7lrL7u/2FQNK8bYeSgRYzBDpb70g/weDZmvjZb5xWReI6jU
 zvJ8Yn1MNhA6b4eTbaQ7AjKoWbyFOJ1yk5ozpt6qOEKZuHaFuxkLveebfTJnpnBmv6FuYpOTH
 w1LVWgg5Mb7tvTLNb8+OlRpefcInPdKdd3FX2b5S7I9I83EUymlRuGuIEFtAhBNQac51ghA2V
 UqonTUVJN5ajONof7k/pxy3i+vzDXaunZkPAxv8LCaEVjHCLIMf/6WJdZFmUz+rZ6sYdsDKcO
 V9ffq9YqPnqnbzkibLXnC0ZRUjO+U2lhF2lQubhdk8vecIooRDjIMcsOQRiX+rtj5HcnxhoOC
 FVFjmxb0hAHLMhTDNBiIrHVdtnTB8qj+z/o0qrPEUQMLu9Q2/eLuCPDF5GtTXOPGHVb89K85R
 xy1njPFlE7SrPc23mkc3yciX83H5rwJUmzv66uqxVaO40ft9X8piHoqVY2Gyc8ygFfrbfNKIY
 r2mjZUulN34GYqV75/5dcIbVMzsIfEZ1Vdlxhkg2kgbILPUq6YVKL70xHwTSz8rmRvvRI05CY
 4UAs9AkqxflNCdw1yW/SOXHcBTAFxyXAE+Y3Uda/RJmSUtsXXJZzBEVmIQJ1jQYNYCpCXA2rx
 AYvrCWATbjAVgswH6mU3hw5SNq+V/syOHK4cdaFRg1ivtYLvptp5Z/nugkPaPzTAkj5v28Eys
 iTGLwHG1E1N1vHFnefssApBhZvncvMpFeJv5/YW3RPHs1Tneo2GNcVMpFStiITsrd5VRjzyXr
 zNEFpe/5r2TOBOu+QxQwQxdNvPNquTABby7lAQiEx1fCa7cbNLJ2sgA0gldcp280wUPKTlR4w
 nPDsOAFev8n5YsimyRLa9hxiZJIjcPLnzFTT/I7emqDTdVnW6nOq+8zcUmP/x7t/MnhI4KPoH
 iU8kOVxjqPjbrm+8jrXZxJJIJhNqE6xsI3kY4epUREyu3TTynFWI4soCoSsbkB9BRbNSqazqy
 j8c4Ala6uTq+9H9mTEpYSZmSQzw+JG+Zkr+v+jQx4bIJGv5iyYJXpHmXFgsiBKYrkpR/v0z6X
 EN+XUjjiGdCaEFNjq8H8Z4MOcWFlat6c5SdXb3QmP06+zZLDkla42NlAhj3zrJdbcBCJm2pwQ
 OfRKRfG5uvbbW9a3EGI6fG7vXHW3Nj7J8vmnmVxAL51tTBpgBj154Z2PYyTlfb0Y2IxSsc4rz
 DGjYIcRYpnmwyy9aQbtPfFDCYq+Mi/aGaIS/jTkgmilpRbNIiIR1vKSCZ8yMDfYn8yotMVSdB
 0MabJ6nfahkFbolumVtZvS21ojWyN8HWjcU8W2kEUF2X6YtmTkY9uBrToTn1LWLZGT2FfAcib
 YGmieqb2Kf/crAmvXnGMLmZrjfXhIbQSuxlFh1fEOmc2mfl9ppFGHJ8mpGtj/BstuGWKsh8Sa
 ynDRdGanXbHvaJ6oy185IjXAxsCM8FSh/s+VHZv9KCUfs+t+2iIt3LL521NjGY5SwdtaRopuR
 h3igRDfvNw8BNU0ZVguzLzN2fnuYyOE/yWCEGYzsO9D8ExFPqC3Li9etmAZZiYjqKtcCOBsLh
 qGCFe+IrBv2R+utDvp0ZuMqCl20Y9O4gXvm0Z/IOZxIfTYDqzuCFoPQXZuUQpStdcqsUQDh/c
 XpaZ6mOTeMSwpB2rwKSvX/cITcswGX5txN7QWJ9aNll1P1WZb0qQg5Z0EzwWtz5AYPuEOKo9g
 lUO5m98SlelGWrq2+uOYUD3arN8IzmXgtH6JVvCUN5LAOnJc91xCJ4i5QRIR5zRHv5bfNY+y+
 6WUBau/FkoA/+F0WCzp64u8ijttugw9NSuNNxQvkqsvR4u3XNnyBcmymhzA96htlLh/R4PLBt
 2cbGK59mj0sFALzLp8Gws99tznpitwoaz5uj8ms8akmGqSndjT9MAd8y77zoyE4B67M6DYEQi
 IamibgRTVYm1UuiJCHaZluBJxKEVRk99jRK2vSyQTmE86yRaSYxPpBi2GJBc6eAuhjbeK3HyT
 Rg2s+QMDKhouIeWqnelQrLzlweGPiYjcuthPGC+M533z7hodC5X7SIeCs0osAp0gidPUmE+5z
 Vm79u7zvocQJhDMrd+Ac8IS6bi9C9R84/uM/etme9p2ARV9/zwsewC/cxQm3LI+dDQ0SlvxUM
 dKys1X+ueDaAmWuOYCxujTkli4Ptd1cFDJ4I+Ck5uoBDzivDXPYNuuufFRTn1mc8MJv8Lg1jr
 Jr76aIBIdq/YA66riB4BsXxR63hONf7gWP5UKK0IWTfebRbjpw91vfvDI793pGm2aucA80rfT
 O1RcPa+dp/PP5rduGGGrTS4lZKnznEVUME6nAP4NmdhMTgUfTifEw0YMfhCCBxgg4Uwkh5kX9
 Z19+6vuC7+b3YEudpgmgswK/EtM5FiM4r7n5i6MJY2t9QcJZ+f25pi/CgwdMFeCUq/XO7u8+1
 xDCWM0UQ54tZl8MMAIChp2YG76c1kz1oMHaRMJvt81Xxy7sYlLkN7ozH+puFrICMbjRYFti1B
 AmhShx/UIR0zrjXDlZ+1GejvGVUDOpcoSUho+YyDQxQfukzRw4fUaENbM4QFkycRBwylL2SaQ
 zZ4NE/czuojin1/Mchj/SeikKGha8RRAiZDQzviEtxt86wygONFcsIxpgV3HBCTdytt5bBNvJ
 iQB7o2xPfCUYiYbcAk+E/DO42dPN0NO11FS9MospzjV7N18RqCxatSSyM2B3zfHitPVIR8Of5
 +ZPcxcmbnKjUmVWj+SyVAstFPLMWlXs9/WrnPKwK08qGqHGu3ClXvsJFm3N9dDQsFuo1YJB3D
 Y3VDU15st/Ec/hSgt7oKQcWMfW2VYMLUEP+aUNnpKYGCA6BHkf8GhsICoY0MmHP0OA9zFvTE0
 Oi6m+jsJcJtNUcrCDbNkeZcSyxIl5lWaFRA/qKEJVD8j67++WOXAx/H7Ix76GibEn0Jxap92b
 1iepKG1mn7Ak0xhxqfG2s1BuOC80N31IE8kYz4RjT7l6DpmbQr4PCdpPIC3kC2o3EytMMTic7
 8KhdGri8Ddzfhx4ihwPHkxJNxXjJOoGtpNYsXbkVFySZZe9G3p4/PtQwSQsb8VVNXKujAWT5C
 3nr9Xek9ByQrGfFAvtTnoPWL+IR4l7Gea9vhAa0l4Y7fL5aA0E78juogXVSy1MF2PCLRBnqgO
 Oedgn15faVA29wnmaqJ54YqdMiP/xMLziylDFd5Dg8PpNAAk+1GU5DmEh/UzClvlBV2EzAihP
 zsaAVG2h7xwG0DG91EsaIWRX2etYHU2UGwW1uyviIsH2UFretX5qu7md1V7+XHCusGWN8QayK
 8KUjwJGKEWuIcViqUbgHi3j0nLIuwxDYubwLLZa2RsNiGB/uGPfXlBEc+Ws1+LMboZkiSglOZ
 52SkwiM0/gvs1/dOcrfxDscJjIH60dnXBVB8TQ44Ra5n1emarzoe6R1LtARLnMby+B3EGPSVX
 a5fzW0BFHZSMLMkBXihlabq+NPC1Lj5VAEVsKT4TwpfdeMWRNfd8wBpc44zNn+v4LQo3PtbpG
 Vtf8foL+GBXSeDZUcdg3CABZ24WutEjgwC3dYcCl8jvoXmXgGvlR9YKcMhGJbE9hyjwaEiUhR
 eegGoqcFLEoAl4/zVDlD2DzQjAW7qLwuURzrCAvSWoqYGig8vXyvC8NgpQi/gv/n8E8v2QfRh
 tkk5+wTGLqSWNbfEfEqzxTM20B3gjgWPSnk+RL9SaBs8vQ7SL0ENycZ0sIWY/Y85DuTydNepG
 Ykyh/mDpcC+S6rX4bILMFXthTk4vxtIbW7WHc04c9rlMNBTBv9WqNEuSGtH8YimWEtGrA2hNF
 VG4mU6Rd8UiG52CPMqmxBd//Euqhd+WpAcTbAGBies5AQ5JnstIkTFzOW5AurUIvXx5KCeNdh
 rH3/EOIhr0ZoMkcKII/mXrMpYeIY+UAGRqh3ec3ftCcoqfil9E+u/lYleBEmHDvx0+DF5CVyr
 c2P4OvPAxzS2QPs2nu6YohX6xmsNGfCgPjc/el5MEagxa2SKCUoC77qnXkywV7x5AE31SwBEy
 ICs8+Ma3OHd5zUO7AzOzEu6nkngGyLSoV9mHTKy/XhYzc7ADWaU/YaGeflpy97iaqQ//ZJ5lx
 ZnDPO1IBQK6QPk72UuTXWpw3QhCU/NeAKHEMyxbC073820MvY7SmHdmR93BSA+G/ckO9jtOII
 3c26Asltd+gzSE+I21+/NciyqAcbYju5d5kNP30vv/l2ZOKPLO9nxDuGVbQfZxduBgJEy4vyV
 i4hiUm0x9gIfCjuSx1CTjOV6qh0nHbLBT9dQYpEv2dreY8e6W9vdnKMT0GQLcKeDiMoOhRjTA
 jVWoXlsl7SB1oWk/HTA4OuGdSqTWylgV7cKchoIzAD3tJlGSERnU7UtQifMddkGoz7txDNWM8
 DyXCQ/+pZ1O7kjDdPjqGx55n/Uov/QHFmCSFX7mSH3bJf66PklKjh92LR95vnttg9x3MEUura
 Vq0uWX2XmaxoBE2Rm/j8i9wxzkjojjhLqSOJ76ik1iqZ9dnyDVljw8t0T8Oimxks2+Y1V8b9o
 6/V6RkbTbibnzCg0i9NcAU+Xfp6PsSTXNk8kSgfosRHhJSlEtx0AkUNVlgc8bM+7ckQK6BaI8
 hhA7sJ+HhFJTKo3kMjXoWrWC7hvQ3c4XLCxpl0HUuLY6FQ5vKI21vJi2PgZRN0mYsm28qz7Pf
 6M6c5s/s=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5


