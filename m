Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19258C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PPC-0008KH-HW; Wed, 09 Sep 2026 17:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4PP2-0008Jo-Vh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:00:22 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4PP0-0008EY-Tz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1788987616; x=1789592416; i=deller@gmx.de;
 bh=aeQ/ZW9NWOqgtCtNPQnKo79I1qD484PyIRQ8qxVAa1E=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=f/Rv9rq3szW5h5GUdc0x1BO92truK90LTj81mMXxsmvbuKVjO5Vyi0yd5bJUU7Gm
 HNZefxefvHeACg/VUM0dAicYl418d9TS37Lw7MANonvoILp4JhVDZnraeavb8Hdqc
 LQfclcMPL5kqfmkBk1DYIKQpRHRplfzilxCHlp6pqh0vr1rh3YOy98xl6Zy6Ekoo+
 uZPvrTfpeVcxX65Wmr66ptLmXxJ2HrkghDJUn1mYdKX8WX6pndFu58FuOcXOptmUW
 q1B75FgOTmzrJNqqb2CXkD7/a5LECNoR70AqzGgOQsenOiC52is2F25uBhfpb89Gj
 VZJyROuvUUZIeJZBWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1wR0F91TcJ-00lKNk for
 <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 23:00:16 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix target_madvise() to always return TARGET_xxx
 error codes
Date: Wed,  9 Sep 2026 22:59:14 +0200
Message-ID: <20260909210014.746930-1-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wv/0QNkJSXusmcct20+zC3kNpXBdcpdKYNzwb8k0muMqtNVe51V
 eS72loyPTa6yU/+PWO4eMPxN4gzdX/TemRjcByQOtUZnBZx13Z6AMjaA2tFjcqnDGdBWsJG
 v0GO/eqr/EydJFUPYUfBXz2Oe1DghApoxkNgi3+5E6wIijw5+sd2OGp/9S8oZjovpbS8+HA
 zMBM3LQS4+ZiwS5lDHKRg==
UI-OutboundReport: notjunk:1;M01:P0:/2TOcgbFZ58=;1fMb9LMw9RrSCg7IH1svmyYTk6I
 /9eh7TmXvVLhtcjLNIl4TsnzQ0xljo+iIaLhXx40yONabhF0wnLXirHmaVY9VfRywSB/9fi4N
 QfFJ896D2Q8hfGbdsZ139ARlPDKIYvwExyM7l5CxiJEkjeG1ZGlwZz/7eyNmIAphd2zBrStuz
 nkwwpFx8cR9rJEJ9Zki5NbKOf5Y7s6qwCz360ErV/EnDqb5DpzNgNY4QHyYtiWE/qg+vi77VP
 TkZvgDEfQjw0Pezb0JxRnlLZZHYH7m5LHToMd6TuGQ9wZad3Mtyks2YuayfoLjQoxaRL85fnr
 asNW/oZwlHLPTFyMEaPHbcrYsBYWcMqL077pZBmokLki9TqE+GXdfcgLzpacpXWxLWHXrtDBZ
 VNTldYDWHbd7mz4lZLFZJkJbIYuEJGNOFJDMbewTWFA5GETqHmsWpURWxrbSBW35wXiMEL5HQ
 wnSvYTeFIhpEeI7tCdJSRoc6ncFQ8FgTQ/CxinA4/4TmOoxpP4fZ/J0WecCtDuv0WHRXMVMn1
 49sxrbWFQN+eKqhrK5S8Vlp2lQqNfd77QmSgQZb0jikoIoAFJRNRgC53C6T6Ll/A+TUIdY923
 DVFmZ73EySWfK50dMCTefB06QBBGCRvHBDKMAZrseb5QXWt5lGrxUeqkVOymyNJyFIFQiIu8G
 C1UTBJpQYjeDHbvs1is7x03DYUumL8698l7yWZzc8y9Xc23kLQMoTOlpUUUv6vdkfmi7GoPZn
 0kAj08YDupifNwTW6d6DyDdVkLYy/iNLuwwoBT+uczR1Qj/kU8RRk1QFUabpV8k3KnpmRfl3I
 4PPnp+mg5bL+yzcLyYWTIaXp/S4mpUACdFb7YtTTuixdMsBob94tMwG3f1z7MVtMysndn9Jnj
 Jf9Yg296osVYGJgIjdMYzC9vgxpSITU4GhyigpVZOdX6V0SMz0hMLHQj5SxqRscoGaUDvRrgD
 LKNds0GwlUMo50V+kUVcIISDNUYAfgWpfHZEmqcAKByhMOzwCiNDmEccdQU9PTFsiqArkl50/
 GWdJ0w97yJFZu1vMnwc3xIF7JDwUxJjf7W2M/HTKt1CcAanUf0H4LIt87h0psJPFOZmk//JVt
 QkF2spwuJxUE4l/6PB59pO3WtykOWIZXUXgMZvmUXeR7E5HIaM/KShtxc4zC92GreDUxI2m+y
 kIGZD02RDDFj7xu8RBQ324AD8kL4tFroBy15Xl4pVAdxXqiL89Z0PYrNKnu8HG82nrZdHDCvo
 oM0yz6MdMmw/y4/W0uKEH18gFEoVVl7J97dWsnaKQVSpLZhOCa1YEGHcR3jIrglQZ1/xw2b7e
 XhsE2iVzNnHk0W3g2jNEy5aBH7vLhws1BGTKORMJtoPF/JDaDlnEm2PRdAjP9R+u4+ZBLNE/9
 5+zRCBBo4Ax+fqkJUMQ8cEOpYRRNEuz0yYnCYHrpt2s6pu2Ujx1frb4e55xlhLiqw7GRXLzhj
 NbdiKJLOlYeieu7C4pquSZEltM+4ESR6Nh8IsLpnr6OEG7Hb6LpId2aRJQMysFEOLlbdTAUuq
 kerHfMYG0JJI5l7PGErveMTwAUc9icaiQm0uYftjYMn6Z3f0QIgtHY4y5pfrbo/g+uwVP+IcT
 ZJaH7nrRpFh2mi0n3ZMtPG6wVva0lfR34a65pQ/cL39KadhZgVYILwyBrUfc/ErXxI4jzadI7
 FY8+oSwSB3O9YsE7NzioCRzv+r3EfCIxfR1CVhf/YJLblQbXUMsrEO3kxxAv/4CTF0oV0jOsE
 amSzU0SOU6vGuDm43cXLKjW7HM9uYi2Uql1lMSzGfP2fs29wrK/gmftHEMONZ0E397o83MI56
 0Xrwf08Hy15xYdFipWnCi2zCc+I1omdI0Mf4NHYM1/y/G6fw707FbDZc7hNTNVXplEYiB4AVs
 50ZcgvEHPLgiT96UCg3u2jOjHwcd1H5o4hOwz3iZxNZiL4Fuf0Cj++zFl02+DhBneQLv85wnu
 Iqwtf4EMCr3hdllx1fNf3QZfue75g/QsdXNHXpjmYjDx/6J29vqwHlqFEHERXfGO1GxGQWDxX
 x5dAT4vRREbPAp+R8ciJw2NCK1qsD3jPc/t3gw59OCFMGjkp74XkT6qFL/xPg5N4CZ3BGXnf6
 w44XPVUUPC8xAbQC+4n22uvf6VVi+nkO47BSS7gdsv1U98lq3rh/L1i2+0i2sJpc7dqD/rxCV
 qBV/fKRS6OhI4uuEwy7Bi3jb6RFUHM4tlqVIe3Q/OQIWN3PWm8QfatbRVCekfwNs0mE4N1CfA
 tv7cwgpEuHh/ndKe90adNFezOD+yNfGWhC2Uv7KWeuE2e2JH8WTPa35JckRdsOf1tInPSBTyO
 snfGsGcHl8GG+AQWAHr2IJ/ZTIB7b/E4vVA2e9oN1J8z3+I9/QFFsTRnjsxr9FAnnHiBOuHSP
 WdwRbG10jqgZsm+ltsVaDO7SCoVRUmS4kwe2BXtZD2oLQjEJaynAxAQzps4PsFkzT/CLa1q4d
 3s/rmxr8o+mU9z2efs8qJeAcD4YI8+gmSnHFrc/rLSetV1fn0kdfqtTMwhTwrvSMb4q04S6d5
 1rDkpaeiz6P1lYuWE9n/srymrbogP28ki9i4aoQCkPNx+rX8fDvctgEwsLZUS8K5CE6HTNM61
 5j7QrLSZL1zfAxZug047rMt+pK678Y0JmQS0RUjHlZG+DqMk5/wNWBHhpWEB5GpCmDgWwbKND
 2i/U2ojfHHI9ywF/FRZiULiaziAO3hnaTEqCxcJuO6XX5FeIHDUZY5P/Fmk5MjUUNlh85alm2
 FX+L5r7egiFomSjIg24v3xhssGN0igw0NBGuyB0KfOoiF670fxf6nFr+IRO7/lzoIrgq2RVp0
 PdmaL8fcizhUAtwiUzgf+/EAHQ9ynJghxyfHWHoLigK4a8rubQ78yIY1xChYQdKqU1p4y8dUB
 xzwy/RIj8iNJk/YiPE4uN851aHn3xdMv8F6QezmWivuTubHVsYlNu/3TIVH/W9Ptx7tB7ht3+
 Eu26ofW65r3lPf0W0seakOCwWezmnOuzyrxFuhv1MxM/DDxL3HwPGP/ZP014GYKjYTW2davcO
 uWCmNvoD5+if41aYSXT4AsSsaUJvsuYBnuJhXbnbiB5LjqRw3htMXEfs2j/+d9KbaUbm6wE4F
 WJeHJ/PfjoAQ4cZao0g3TeMsO9lt5WyCeunmhzMs2doV2ACcW8i8yIdcZQ4D6O7LKOdaGGNG/
 a9S0EmFWeRNpMZx0XpJj9tSjDgGfvHzrsM6cJTBJs/uxrmAjfRNH9oGW2LkzewYk75PkIcVTq
 YaGVvKJWHZQUQMVQxlkoujOaVWhqHgg6SUjC65qO7wZNQsf8P+KN8MwnVn1KjMZb+V6PQ4w15
 iA2k8lzcMe5meqgIdgwUyigyO81tBQvCmE2Of9CAHU6bb1NyFfto4uXXPwpLhDgdIwprneBeg
 uVhs+D6lyXdBP/vzz/JcVuZdr4Rd/00iOayd5bEBkVsI3OXFpKg+Pc+kA0DBiELWywlMmP15p
 uQfjgUYHi3/x5Q5EiT2tHI82Dw7QcKBbfrn0WFdoQJkooKlobULux+TA49YknnT35TmOxHLnn
 K8NnnUghSfPQi7AQO+PPIY+F0p0hdqNwmQ9/yiahb8Q14WsnzDjw2RW+1oKKTTvjv/wqY8GWf
 uJccSfNaWApRqw0B4s42y3EyBNfQxBh8cnRP4MKa1PEhKW70PJ6ffNkIMkl5d4amMXk+Fm1Gg
 amLXKUTyoeL2QHU/zC4L8m/t4Xa6DdsJgjcz/X2+RKAnKK5n0lbWQALAlxlGHGjAR+KPgGmU0
 8mIMdjloZJCRmxc8rTZhz8clWiMRijPhDsDwwMbNt0UsFNBu1YI+oEd+hCII27Jf/tLLULMqD
 1SM4b/YhuR5xDi0ElyiBlu1TFDeUXNnO0739EeKVS/swZbr+tSysMbWPDcc4ImGDyHll36hRi
 +HR6uz2jnkYMbj3TbJhDvlOIVytis+rAEp99SdJsLLdy27LhjkipxGlMXv+L18Z6BQZ1hl0Ew
 HtQmT7Am+VyTawgQEkLIJFHmcS6iUqFQzq/w8S8TIKEAWOPVPZ3aYLbIySXPf0ZTYtZsMMGtA
 JtdbLrES/NkstFRVaMsYiRbVqNB2B9qtMl76XCEnzKJfjjxefANomZB7F8LM6/IZTVWaysDVk
 Ydu7ak8el//gxZ0DSO/2bdDsfAppzSEkK26IllLExqIP4UaqrSmc0hyAGWVtdwsn7oT/oOOzG
 IJ7sUIf9SPR0yaLdSflomuXu2moz6PqT98XJVjY8CNnVf4crUB0AnWZYxunXIKC2neNtFSlMG
 pTFkeFbXPZtLCUdjhF4QMBN+o0Xb6to3hnT4SG2xUcMgl5ADTPooBUA7syDEqixEI0jSQhNBZ
 t/qwXLjpEfhttuWzS+BGY3IJGITJuaM6QaXemizyWZwAxxNN9aKaqmagP1C9YjDE25ZMlhyOS
 MsJ5+ilO/x/giBK2j9SrHPouFRAlXDib7b7lAoPtV6Gkd7sOZDNvZ3h2nJ1mxSPyfv+kaEVKy
 WE1rOtip2ShZnTZiaD7jL+KcBwzImiCpxOoU0Gb+IunNF0XP9WJoGM1683AtBxIh+oqaPaBpk
 3U/MA9Sbw4K2kccY3Rd2Gqeo1Wfam0IxeJcrdo+Xc7t+xYOog9H/T3pJ6SlWkdPVzlGZpwB8G
 Fy0kwJw4QANFwK+ztCN5pmdJ9lJRsEZwKiixdzNICWT0nAvwrXfJpiITO5fjUonZR6vCYz9oP
 uW92+5guEAKhGWYp/O/BL0EG5OX4ptLIVPMZO8/5PZMWw3bv+3WAiedSCpCDlowfbNrPr+a6b
 tANWS78IziK8fy5EfRNdbe8/4c83NCCX45AUfW85QhjsYF68JNO2MdkClRMHTwCnJqgFJJ3sb
 0tbu76EFU9eOnqwmuqwHcgEKQdkS43UXs3Vy7o/eNAEHAwilwLbAAQYJKuQVndYmK3k4/P7Ag
 FswdSfCVhY21m8KOCQ6j3h3IUPO1T2ag1NfxJ4I1iG7nL7zQB5LVoLUjPENPpGliqHbKnrlxI
 eAEGm+idO93lAu+baLtoXQf1s9ObqAW1EKI1zIB2pbxSk9Jsj9pkiZMLokoBM47sslM0HlNqb
 mrEdzig04aio1E7W3X/Hbi/OgUJMcCRZBjWEODHHXrLuaCvx/sjxcNB9pwt1GZeBb4ISCQv45
 Z5btKfO2V61jU64NmFPwIQFuZ3eGtf/DsmRKep2ECsOgZyS0nejRezsyJCi6mkr9Z04rZJvHC
 1yzyIL5WKPH4BdWKU5kr4Vkv+9F2BFdN1vA08tVK+PbHhxVwbYSQcj25qxhlKyaVswycqjIZ/
 dkSGsbn06Ia5eHhD18ILYDAXUZkXAXpW16Y9y21HGTcH47A8UerQL7dZ8fPynyugaEfl4asGJ
 cCE4OpQ6wJo/ui+0TRmYBdCOP9H/UrQvmL8pqcOUexweLw+loQktpH7FpQo0F1aq8pdgBHDEg
 VuVU1Z7aq4pUjcGGOhGFXBhY4q4warCXyv0X/q/N2Hzbu4dGm4RURAlJyyj39jU82WHikcaup
 DyTJb7E4NUhOAwNI3VB/Xpn+MUSFZiv5PPsRigahnmZ5cMejlw85AqA95WwqHAM7t6fFgeeqZ
 PaEGcxB0wmVNmiIXnteHZLEurePa5BLybvRn4rwLcfEi4CcABd1o5P6lrIshkvhTtT1nvtGH6
 LPlTsK/LXSq9GGXl1PathzldKJOSlay9tEdjj8wX8itQcycSjZjL4W/oFEc60ZIZo1E5h0fSq
 sVM6/iahBhW2qeejZiBaVs2FKz7PfkSlgfXN8VsOw0i8meQuITNs3Qybmujm1MSJQ8yIz9+x/
 xuycxEOUDKvzPp8w2D7MpI85MwO+WcBlwieaYBtG2IkVT8IiSdbSfHCAX2IAgIRmZsOuMxG6n
 IiRK9lIXsLj0+CRAUpo8E0Bb2zo3HXAy1IBRllC6U3DCOLqDBG/tFmYEK5PJsO3mhpSWoxWd+
 bRwasoq4T7jtEQzwfabi59qGd0R+EUMbTorrxG6ZEcO/fj96Kb3l7ui/6oYuZsRaWDjjyb3Cf
 N8+FUsyqgMB3joF1q5lqdTU1crmM/zg6o61NREsbwsUbf7vAFQXDPdKbwOmpi0Lo/8x+i4/D6
 +EJx9/5GwKOmZ1GY6x2bzY9GwvBd/LyBq2MvOHav8TpoSIyl7jEFcnIQzIDMIeqoSUv8z83EA
 fsQ9cJzT6rCT4qy5EsqwWVbITX8S17batsvradou65k2rzCQzmO5bssMZsyoi4lfaSfKycMa8
 Je3YAg6jMoHMJ+PMqqV+Xh/UHtUVi0N8hpDm/wbPBXBiD3LIlcJLAlrtMXqm4B3VWa9Evo0NX
 8n0ajDREoHuMcYLsSr/PcSClBtT5IaNa5zQRXlq+hDaQ==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The code currently mixes host and guest return codes. Fix it up.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4066072ff4..dd957db55a 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1329,7 +1329,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong l=
en_in, int advice)
         ret =3D 0; /* OK */
         break;
     case MADV_REMOVE:
-        ret =3D -EOPNOTSUPP;
+        ret =3D -TARGET_EOPNOTSUPP;
         break;
     case MADV_DONTDUMP:
         page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
@@ -1339,7 +1339,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong l=
en_in, int advice)
         break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
-        ret =3D -EINVAL;
+        ret =3D -TARGET_EINVAL;
         /* fall through */
     case MADV_DONTNEED:
         if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
@@ -1361,11 +1361,11 @@ abi_long target_madvise(abi_ulong start, abi_ulong=
 len_in, int advice)
     case MADV_COLLAPSE:
 #endif
     case -1:    /* BoringSSL uses -1 to check if the environment is broke=
n */
-        ret =3D -EINVAL;
+        ret =3D -TARGET_EINVAL;
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Unhandled madvise(%d) call.\n", advice)=
;
-        ret =3D -EINVAL; /* not yet known advise */
+        ret =3D -TARGET_EINVAL; /* not yet known advise */
         break;
     }
=20
=2D-=20
2.55.0


