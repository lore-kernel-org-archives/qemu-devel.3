Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C416E94121
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 14:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaaMT-00048J-KZ; Tue, 30 Dec 2025 09:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMR-00047O-NM
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:07 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vaaMP-0000fR-TF
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1767103557; x=1767708357; i=lukasstraub2@web.de;
 bh=4hmDx42RXLEyRLK7gTk/bDREkGb13Ph7XKc2s0dmsT0=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Mtbg4xb4/u9bzgeul+29JuZczraERPHMSs00XzA4UbCi0fWH5igzMvnsRvFoh3sf
 Nxd+4xJCfJ8vedpNGn6l/7zwVz3RlPNquBtSfPo/Nbpv+KOC5wlrWaZsMuniAm/e8
 ENQIFVLjUSxiu2eDo7QqE3PmC42BZxXb4WsHzVHF4knMzPZXluhItBEm3nKMYD1jX
 oObXF8VTFZ6gb2tDWodzsXxaFL0Lzd1YbIXCvLW2hNsG+2coTGpTGdZDbxBil+aNG
 l0u42YWTUnz3JqYrmCQ5JTas7RMkUpXHhnQIkF7icu5UmaTziFZwS0kIPkOCEdldb
 B46CYl/HvjV+GtdV8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.110.28]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtsZ-1vlKwP3sE5-003thK; Tue, 30
 Dec 2025 15:05:57 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 0/3] migration: Add COLO multifd support and COLO migration
 unit test
Date: Tue, 30 Dec 2025 15:05:43 +0100
Message-Id: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIADfcU2kC/x2NWwqDMBAAryL73YCmWqRXKSXksakLmpTdKAXx7
 sZ+DsMwOwgyocCz2YFxI6GcKnS3Bvxk0wcVhcqgWz10+t4qn+ds1kTFFJRilnUuFIMaXRzG4NG
 F/gE1dlZQObbJT1e+WCnIl/gyRvr9j6/3cZwBA9KggQAAAA==
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Lukas Straub <lukasstraub2@web.de>, 
 Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=/z8snEwOzI3LR8/HI+S/fkqwRHxkqMRPcE8m4dCyKks=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpU9w5pbvXQIG7QHezvxe1s728gpE+O/EPBflbR
 P0Tg9ahYsOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaVPcOQAKCRA1qwsonF2y
 WOPHD/4icsUe4d0zLjO1T/4xaNcdxrJohuFtEhI0bNt6D1ZEBbSTauWF5ZYJQOPibek4XCo5NZ7
 TvOOem/B3VS2TzytuNhjnB6J9EQB1KnOpwSWtAgcD9L3FKf1Ces4FKcNJTlhoHTRwB+KHiG7yGJ
 /pFeJ8JtJ99qoC7viG//Ul2AJAfhu5V157HQkBWBVFZsh3DgyhHL85+siFOMAxzPek6F7ZRjNTj
 iaAHkj7s1tNeJge6v4X43bgWB7Bz5A3My4vlMG0aK7IuZCcepuJEvz78VIGTVU6crEHdVNP5whs
 uz6d9FxAnXGB3m07fF13rePzRsjV/M2omMqLoXzOdla0ZLghyJWbMIF6zU+2e9ipPzdnctzkrMj
 u/mYqvgN/rSEgOpV/ALG0tyD41pzFtqLQy+vwDViY/MN+3zH7xmoB87JSPmYISC1H39q8mAKKyP
 oEN5MPJiLYtI9JxYLnczcsAkOm4kExpXSYECZ+FOw0V27b6cc6I5Dwc6RdFLCNe2e3ZZIV/mrxq
 GLoyMYIpj71W5HMzUfSZp79rp8XQiOQQv8w/kKeFDzRgOb3eNBzXTgGq7TFnw31x9ABavjIBiY4
 g029FSiLdFkdYNqWQjlGUbjJeDuCGrTargZ16FjKFZwEOyZe2fLt/5yJX3gHcr/N0vrRqFL0c9z
 gkzkDL7WOIG+JxA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:/0zicwZA5XlkIHHnztDY6+vzCf0hQnB58g6zChWh3VStvOzQWfZ
 lXY6T/TuCHsOmzJ0tD2fuSgkOK7Itgi2H6sNwjS0b4CTnkE7JbOpFrtvI0mZ+CBtpqh7bkL
 nwbT7tcIcecrluIyPAPcfdxT/V58vw3Eu+6q3PjE7RlGKHKxeHHRINhNq0BnHM7juxKpjBi
 LJl8UZ54tK3jHveEfVQJg==
UI-OutboundReport: notjunk:1;M01:P0:ryhD0/+AVpw=;BzPFXdDp5DAOaVQKKEbrJVNoFLe
 Jav93YQn15JwycKS+dqYlhxbOeqTfFjRBjgh9keqwnaCnMJTQVlW0RK8pa/pLq3TxU0O0fvv4
 ZHEGAp/U/E77fwx56LrDQLSI1Whf0+TY0XpOEVCAvGov406u/tLkLGFaqtLjIwxEMyHcaFZAW
 sIV5beuIHl5rK7FrerRIjgWQWPsnr+Eiy/9d004Wq+m0Woj/Wlw6N7Lg2dALKtPG2SqF4iDbk
 Pli5HcWo+0erTyreb1plt0nDRpr8XLoFbNubAbVQFAawhANwMsIcF8fOHjWrEfUE7cQKJqVUi
 NFTTziw25Pg8Tkeh+hVrx/A8Gbscl5FC1Nd7ggdpb7gw77NBCkMo2YkxmSH7bvbjoKHt2J6/h
 +/gNinHX3aZhtTdY/5GYPb/jDCuXzI5dEgMLNiOqSy0BiNGlOGVGrhCD2DBHKKVj4zNo4CaRK
 KSEcuWU4m1KlW9CIFzKLcS+HYRW97NoDPRGswyw1b2Dlm34NX+ZxkwKsnMWcCme8xc+GKwD34
 9Wn/isAgOT5nXyPGWO0fAaTfFIZ3nmdWCdVslCeyB1jviuybznNO24/d0mtm49Et24kHeENfD
 oMNeRBGX94+cMwCdkzLLFal53pYWbVy0ehFrxS8z55DeY9tCWavqpvq8LMKwaML0IKq43mRnl
 sNoWgmO9rMC7aJH+9JjNmEHi711fdrvJhpsZIZWUZbrK053/HusL7TQpqGXuyHApyCo8v0aVB
 eHXRX1ONVbe5C+tazY1510l6hV1s5h7RJjoIdrh7PhZkCu9ldlhs6tCiWn76yew+9OItlGtlX
 59XkNBxXM9Al6C+58bJtC3c352ulLQGGG1/eI0xjsg0c+okm8DiIvlIFrfI07AyqsJdRCjWr4
 +4jp0SzMh1Rr0rMp4bSAIy6dOIfeKsoqqBxSwfEq4F07xbraebK2AjqABKOFvV3VVdu2L5NcF
 p3K3wnN7ukUgORMKLryXbrWCwP6KD/QPfLO5b4/Gvqd0sYYuhbM0dJxRezOxN0HpN6R4azH1B
 iBPDijBbM7/e2YENjiCHbAhb8R/ZlMVifvCNAOUCP1j3YwS5zRgL5/BYdjtkKu9A+CuZMOUdQ
 FSzC4q8njJG8l4B4ueQ1CMTRfNOLDLtKUTu2roGUv6tHmcQse/wt7WtR+RtuVKSJ4fiBF66U0
 VwPqOq0LtqE4YhhEIkPalAJN78pbjMRsJXdn2BWbW3xtnbJrZCmXoxzo3Ddt0+3V38fkUz9Dt
 c6y1HAYCyzfFw854/8xj/3TIqMVi0u29Y1xgbLnC8+Aqdiqh5+7OUReCpQHx1G4YcqI+imVHm
 6/QIITUBgqKQRHBJnwVgxXIW7hvswAma6DRicMXt8ke2AoE2hISJBVJ23vZy0rY3vdYCtQOzQ
 LzojiGYmz+bKjxfC91zDgBWRraAGQki1e+BLWGkCVPgmvUe0BawimwXTkgFqqQPm2yuc0vUxE
 XSzLz6XNHfdyvyw94CJlTiMd1TxTYLyFI7WeIC9RUqfdNWuhkJtD8H89ad8QSZCCuFrPbswLV
 E4EX+nZoc4WeMfIXlnLgf7uF1XYdqqI1oEHsgCfB4RX25HWkKmCUSDSufrwlELz7YUEpkLvVS
 BBf3hOgYgklVjWXphZW7yEhE49PNl7Ur+ZNik0fOb/L8fGCCwSdDqiTuO8YgD8x0OPkR0pSNV
 lFVQCvyqI+axzJtYjADkz7yi/C59leb/hQ7/FiPd6zhAbR/JFB450hFYdLzrG29nxo40+smQy
 /act8/HC8Gn27XCD4MTHvySBw1F8WY5+u4zvAJm3XtYXwfBimh7vMGUj74gTECsKFw1mQOmf8
 TeyzFre2iNkdmFjfD9Fj3qQGJ69BeUHBrVc4jAmQpvavNJKI3cp2A5sruDWsx3GiSxsiHHS/W
 6SmIbmk/rRBEQZl3TtyumfHbgnjgSoeeu/Bk3ZyhmY2GTvLkvHHxdMjrqnzn9vgSDqBBGk/Rq
 Okggc10lu8xt+Ywzy//08J9AFkNMTM7msGhunTNFf1YrSwbFFyHWGzP6iML5KpmIXNxt/NPKb
 ZHMhGbqPXTUVjmWvqyKP0NIXk+BugbFAIK63yWTWWNuYr6SRN5AkSdyMMM+5o73belr3xxnOC
 KUeLTdZlSSM5qHqPrkUiw+73Ja/XcukCFEpRBP0oWuTUfd2WEhiU3YxZEE0tyPNKSPQTXJecT
 hn4J14pD9vi6cvkj8y3gP/fT59EqqCkBq/+4OCywC5GHooZidnejNQwHhl1cAGvIY/A2q5Xp1
 eJQTnj0HRg9rspUmaCE//ta+eF1NdoP1XRemeHPdewuQdDzWx1YHDJpdLRlapm3MPjtZumgyD
 GUVh1y2Gi7gFf8QA2xhiQIMZgAXmfAOexDXdeb7jZeOVqeGvGVouAxQwWnVJOaI5AsaSVurX6
 bEiyo+QHa4hDpgKQzep/pKLjzHFWCql5CxBsauhZQ6g7X7wcjmy6yY8cI877CsaXOYBXm7uJ3
 b4Jlh9Qi1BmkAbXoLHGgsdEOp+OB/oeHHl6bUEpk80xfq3i0ytnamm49MR6h5yey/49P10qmY
 Sx3A8ArDE4BL69Hu4fwnIbFyWEsLUnTo8idemFiDK7bxH5O/3zx9T793JvjgcuzeHbdQZyRj4
 qxE8KoeeNQvr0RPwUDxGSvJQjtJP6Lwj+94My6U7LYuyxFI7uAvNITFk5irR+I10ZZ5wGW1hM
 p5n7iY3yYIIrEi6seQbUTj4CERUwAiOr4hkQpDGpDMCq6CtySVWkuqphkb5/6nF0NTxAh1qq7
 ZjGeLVUjoHkaf/Zvd3cPx+91rxQSwFapDw4xgsEwnZnuSq8oOmaALdPOmYUBpwaRLuR+SYhFX
 6OQUq9iNFZxGWFagJmjMfWa9O3zUUkCvJ89ZNwnNcO6/jx8Y0JLyqyHQXbNuKDxfL7/6HnCRA
 GnY3aadMEhuXK4dPUKJ3Crz1m+VdgLMe7Mx9skY/w8YfQ0BFZ+vfr46oAnwSuRU3BejmQ7pQ+
 ClhBTDLVYwfoSCh1FnVRzfIT6AcAed/dtWSwNznj1brRtwwReG/F+0GLrWEUIbH2bjw7QLxZA
 q8QjHWlLgcBp6pIn3j2LjCe0Q0zwx2whmzxdJWQUdUmio3luejAy1IY8+KssyYrIVSoFvEifo
 ASkSdU+ZnTnBIvcX1tTwKui32bey3ZsX7Q+oTDySQJokZ2Rjsn4Vx7rPP78Obo3K5enEbb8BF
 oiTzElbN2+754YBL6vDQ9ZcVwnT6EXXBhbEnrh5V7zhn/46hY+7CKfu3Z2c89Mz77ok55cqQA
 3VRnMZwULrT0nduDBaGkR3ErLPZXNjR7ggdaDm3LX3lJARfQcv9ZZJudGpCiCzhgwXPTGCuVm
 gfwLItLHUUWVSUhAqy++yI2uYsVLaIsWo9s9wBWqCIehpE9z+kAnLJMb5+XOoVNmvmqgIe9bh
 rD+726qKke8qjMjWBT0aV1Fel7p4kJRYTngjQmhcpHaqdRGRFZtqhBRQ7WJrLlvCHXE3uek7+
 WDBIun27WvcrC1FZUJ9pMJNGqZYtQV69U/K/KUVoUrnfwYKQnPSHYtPh7mfTALDMvpN523iZO
 rWH63i/iuuPHFDx66uZ5C1NykE8tD2pc80+xF/OaWS4Pn478YcPHxPPF/mr9mS36iVlgycEZm
 on/Ii0NqAhLbhhwYkptwMg6EPivCcXfjbe1mn/gvg1AXVcjPY2m4IiAwYYVOEhBzkwwZxMNBX
 ON10UtLhEVC7Oo8ObOGhLVvPHkkcKjvQDD1KyyDdrapvCcjajHTEL5nvB9Ghts5szwOyxhVfC
 2ufViD+Rc9T1HqdMnEmNmAnwhpVXebFdLShWHMYeKWsU7/vpodm46Nfc/TIo7102C2ZM2LuLV
 3RaMaZej+2uFAhEGou5D5FN6xwTvyARpLMcZbDnWt4UyGz/N/b5IKir5w+fVktlY6DxM/xRsI
 gp20sAGjiEKzO2d8frone0Fz/e36VrDBULPnGnO0L+GgfmKinqaz4v6+swu0JICvyEKQuwO/8
 r3KS5K3jFbxNoSDaRw5gNAWXRuC8ByNkEAgUhlrtqmQYCAOSpjQXUCvjv6DREu8s5g105PEP9
 k5wQR5YnfRnxyuPHCKkRW+9u5fMZjiYGTqCGHhn4EFIcJ08jTR4Jw+xcE2KFEtglo9RiCxmtF
 A11gGpTHvc1GYg8dgq71h/1cNFVJKGZiH3QxPh/6w+FJKebk5hFGVZysgQXOSfxd9T/IVD/KE
 RS9SWhiLnIa3xPiji37IpuLW2DJNc6nLNx8MhoqHJ+HIWZqMunv3afArS3WS756+jfI+3LDZ1
 HCK+Z07yimaGJOOB7LClaZkbxTrPzZsFz9r11dzCNCXk7+de2wWZbND85Bp96OOv6ySEhjEeQ
 0Vtmc/xLzVixR26MwoePLXvSHpR0Vg2/e8Qc8dEfhee6QvJ7G8AAK1yp3KwvMoNKM4jeMVc/z
 Y+Ko4zb8hOr25DaJu4T7AWCTxNuByzEkjCFcEUGJHDhToxdUzRgwoDIBvUXHuPdDYkLubioKK
 HwHpQBiY5eHv8yM1HN8R8Nm14+XRepLT/LiCG/W7jfhSGzGRQCbnBYi9AR5p7P5vzf1ZMkszC
 Bzd2ld8TxtY7x3+KOmANs1T3oqyRVTmZ/CyNB3W277v1X7Czdrp+l12Cyg+6OoZRhNlAnwOd0
 4o1lCoCxeCpDSZEczGGFVm25oEc/vs8/dm8fyoFCqox6EEaT+LcbNZlV3VbNnY5HqQFJeODxh
 nnk/qm6OydyeG2yot/GXhzEbCS6WlKVR1J989z4AT0d7NmU+IPW6QhraXbtSLWR6F5nyX9P6E
 HQkoWapWHDl4J3w4NI0gzA2lt+6ALWwN/Y/buIr1B3qqcXXUE7al3v4zwENMmymvKGAxtL5Qn
 D0uO6Z21+682irV9bAoFJWBbYwk7dt5hHgxWdL8PrjS0dnMEzfZvHFqjYx8iUPS9/DIqyggVU
 34/tq1DI9BW+pwbyQhM+QvparOiqXoUg6zEoiEJdR2s1H+XA6d9SiWZZ3ZV6LhjxTIRf3UXnX
 wv3G1IBcv07ZEeRi/skhM5FELIdNHEIGHhm8A0Qf4k11Och56nu1OLtAIOm0/NUnx68MBdk9l
 otmZ1aTzBr57avUSdJcDf2PnzqSrodda20zHffqR8otdH8P9JH/HxjN2nkg0notA006sy/MDR
 2gTCdTtKeVyBWUdOY=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello everyone,
This adds COLO multifd support and migration unit tests for COLO migration
and failover.

Regards,
Lukas

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Lukas Straub (3):
      multifd: Add colo support
      migration-test: Add -snapshot option for COLO
      migration-test: Add COLO migration unit test

 migration/meson.build              |   2 +-
 migration/multifd-colo.c           |  57 ++++++++++++++++++
 migration/multifd-colo.h           |  26 +++++++++
 migration/multifd.c                |  14 ++++-
 tests/qtest/meson.build            |   7 ++-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 115 ++++++++++++++++++++++++++++++++=
+++++
 tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
 tests/qtest/migration/framework.h  |  10 ++++
 9 files changed, 294 insertions(+), 7 deletions(-)
=2D--
base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


