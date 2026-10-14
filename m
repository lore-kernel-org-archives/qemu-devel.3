Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2716FCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH42O-0003nI-85; Wed, 14 Oct 2026 14:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xH42L-0003mm-V2; Wed, 14 Oct 2026 14:49:13 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xH42K-0004Qq-4c; Wed, 14 Oct 2026 14:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792003748; x=1792608548; i=deller@gmx.de;
 bh=YiR+ZnLFl4oq757y1sACiJzyTW4Yb6pRE6TizRqVod4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GNXRR6a6bCq/QpaT9OGrrWvw4ujFPbbGlH9lbxsmWiIiLW9UjLKSx6sx6TB+vCMh
 7NkGkoiTc5N2GqyG2KTbJWuPOkP5KJEvM0+jEsJLw7ojwJPvKmmdDUsPQSZcni068
 8IjSHgvLxYQopgCu3kQRZrCIcY63f1eCCd/G8759D6ICc7z2znACdb4TUWZTmvSZf
 OEoWjGsZDIuHJROsn2qPY71JUswY65apYISJsDfQC/FKVUx+9G6pb5cMNshaf5Rxm
 g2hgCm5rWZbBnGCt964jMch+gtRDZfALwIAhvmz+GVO4vShlsHl0oPwGA+DwDa+i1
 RNnXYylmkXcx9t4d2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1wNIgo3OdG-015Eii; Wed, 14
 Oct 2026 20:49:08 +0200
Message-ID: <2f563d2e-bf0b-4272-9956-5922360e36ab@gmx.de>
Date: Wed, 14 Oct 2026 20:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] linux-user/riscv: invalidate other-hart reservations
 after AMO stores
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, Helge.Deller@gmx.de,
 alistair.francis@wdc.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <682222a7-cc6d-45ef-97b5-65280c546e12@gmx.de>
 <20261014162956.1939-1-wangyang25@otcaix.iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261014162956.1939-1-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4MCvYQ4BUkfGvSC6p4mXyUSeGsaLD8wuTC6meP/nwuvvNd0SJ47
 uBwPtYuGaRMtpO4Y+j9Ef+cd2p8BYnJh7QoKBF3EIYC23g6URHna+pX+tSnMsy2EZDTsa0k
 Px3lfeET4/6DHoauYEBAZFcaVwl/CtNUOna+W4m6Q9+HErr7V86s5bKdumMseNgm6QXD7Hr
 Ejaf82FJQ19Uuvgm/wNww==
UI-OutboundReport: notjunk:1;M01:P0:96x3tIQU9ns=;Y7MQJbqesa5hCMPZXMn6lVyQJ6u
 MXXNsy+ewBg1QpXRGbf4xavH4EGkVeShSmJoCJZsY7bLZaH+jiAVm2KSzH+gVKK6oR53cPQT1
 C9ZwpVkJgdX7ktcHRDoc+LV/EqX55nxztCyT8ZEnt9PerKBo7BmaLPqpwarJYYk+1cI3oMU90
 qHpWYeLDaF8wKS+AtfBtrwcRrRX91IuG9j9jRIQkovlxAdr82kpX5GwFBFpAB6On5pCMHt3Md
 RUrP7/V6lyytSK2XAmGt+E47l2egL5QL9lPPpFe4PF0P8fkrrPJUtC9WDLJgFfsUAlntOo42o
 buUVXxYWayiug3WBEGKtPt/OMgGzx/7ZgR0KI0w/6xKMt/VdYmWECG8azK61Plypf9169sjR2
 KytihBuoRDDGe3c6tvv2KKoWhRWWNvM81Lo1xSF+L3iOUMttVKEiIZPnh5ULpQ0Pe//nCaTbN
 mxut6fWtsrdquqpVfKF/+AUsjbvLUEO/IhS5esqrDJbLp0o01vpR5EjLdy8A+tQJZ4lwDdUC1
 XuNouLOi793TuRbbvQrm7OWljqhLhmxDBXFvq1pF+4XxitYvBHvAQHEVUR8vCzE6uFf1B7NmX
 3bqcAmPpKoZ1AF6aR3tt1JPSYaecziQs0p2E6eIuDpqVo6ToVg3MvN8mNoUAwFw/QSFTIDF3i
 iTx+9K0wnuL/dLnf6YEvHXmyPTmF8O8tbslatWP54o63cJlgpBrKlPDPd3XuBvhAdZfohIx3O
 az3qA4IJECa8olC3b8g5w8BGs6nWeEglgOoPf2ovTyiPGgUOlytRv9DFjwa590id80CWxyHYi
 Kpzz4EV7L6uX9UfYs+3Gfj72JV5F/mtr+1mcvvjAfBOSb1ocrp2r1Uh4KIxzDtX58xMcO2NGF
 FoBJyqZaAe8G45euOn2ueh+Ol6Bzmh+HLdBedqy6v+OlYpXrcXp8SSoZmY7FFxo0L+6aUwUxL
 lHv5yR+U59quXfl3Np33zoeBJ/LyduYgQO5Xl5XFkX3BiH4SRpwg1u7q76WdEN4Y5hmr5CuEz
 y6sxXHRCcnF4W3PWP95y7l2vBMZIeZArv/lyS9IsFQ+MrJ49SnrXdw1rKdn8cR2OBAKLVK1ZP
 vbuOvkAoX+fSJUafSIgtLXB/6EIaEbYhPh8pmDnwP76GsRj0s5C76XlLahJ8IUNF3OrlW9kJj
 xOBjtASN33V0uDl/bewEou6La0u49LHPALYJ2mgvsOPLXwOcjpcyHyfBWdX69PijJiD09AeUA
 JqlKkU4Er1q6LnXB4qEFlYrwYcZH3GGYJNBP2o/D8MAmYWdmfTLUaVBacrZPmxpwzytqHSDsz
 qvyu/kJSczc7Mb/ahdxI8rznpCSAUq7Z039OP+Cycpx1BfhES/Vxt9AG07hLLWB6NHXMhN9Sb
 vqDvTDVS/Z4QoPcCN2K9eERrf+LWYGfYrars6APfH6JHMCqffyXwfJOrPoO8dFf4PZ9fGWhrH
 Ln/8r4Hei24wTUGR7XDmcZ3ev+I+A2rkSipR/U5i6QJdyzU2Xgf2BzMr0Qj/IsExPhsb9F8rO
 zMofSyKIBzHDz5i9zl0efYcjQyPZMjWfaWYfTpZslBd3rcYTK9XDx9zWHAIEFTATtOSTyC09+
 jgcDfw1i1Fsajni9kvoimavhpG5+u+rjIz0wBmDYzfxFJYSHgf1e+Is0bImfzGCRTuqSuNwEu
 gFvorsGEAhSxQlrZ4RC14cXn86GWiB2l/jgJDR7Dk5RiKIjDXxs8oGdCUIGlGNW3iBWc+BSYG
 91yCtp5Z8rsfPzoezZxlSWNZtyUUlVvaHpkhMBOVZtxJ7OhhLf5z74XsLk1Ko0Z34qiCeQw/r
 ZPFDhUepcMOKozfhHk5HVNYpOJFT01K7+G5tHuVrOvlu1WdE3DQ38KOcMejD8t6Bwk3LwpKwh
 2eAh/Q7KtkZkrVZKUHI0GuRPalUeMTarYUo40VpukZsEuey4K0zbGRTuOWw83YSBH0bUwJvUT
 MnZYmc/pBTtN04vDx8MSQ63T98UdwUrmTeXbhPZ8auUw/KJnZHGZvttiXMqfHPttpgdVO5Act
 8Qsd8a4XAm+amKHZ0tIXpOnM6MYbuskPxY8YYq1APRxhpYVMtT9MpfxsVC7oMn7Mg5Zy8zHnQ
 i2Q67L2QtdcCX/mnfMF9N4yhgnxbTGIzJL0M7ZCdY1SLMjlQvLFd11xC40n9JOQa71cFYYvbq
 /34Qqf9no5VdTaU6VAhM33FEXIa5NenYiWG51zPzAezsTaYEg5hopcHicH3+h44xIO/S9lINS
 YqZcNUQMW4eYymMaSeCaIBZa7dUWaKyTuI7zsY7Sdt+FlDl5AJgUXXT3c9Thdx8beH1ihMQ6x
 herS/brS7olIRQcyeKhc8IwGKB8uLbImdPtvhIVYkvxfKRpFTq1KDz2XN4aOjY9Juqg7DleRE
 dDruecNZjR2KJqMtUDV9LpHU98N5daYgV0dzbycrKGDhgTv90vkWv1DKmldlwILjHvKshTOil
 aOxaydZNg9ZTqZJBDm5qJ/tb+zduZ4Is/1BjRwPDrRRFT6DxPAPMI6/Xlmf5d5iPJYH+UtdiI
 1Dvo5FtbEJSUEMp0qQVs5ySnN3qXbM2vY6Hgo/GphQ7KCm/O8aEvWyMNn4Dy1d0tD7/3Zka0v
 atl6qOnlIJAmTEugYvDGA4ED+mZtnOscX4MomRZteEtx7gX39ErSSPSd1Nyg2K+SEwFr0q5Ba
 y4jbmegLGoPrjPRiBimN33GgSSDFmqFgAIeU2FBfz5Eo5Ld4sEF4ny3ygSk5f1FetI8HevL31
 hSe88QoWRRAZRN/fgI0r6ev8v4Ay5oCTBu7smGnnQQSi0PBemWGZycTfIiX3boKMx9aRaaVaU
 j0o3KOqtpj1CE5O456o2t9r+3tHU3YOIY4bjftRB+ll1Xmz3QTWixrlsnrIVQxktGN7FWswFj
 hRl5qsICLmcgZvO+MBkYsmU14gySmMGiezw3El3hdigTexfvI1qGO+Cv0Qpi8KG9kqiV5Tz3V
 BSeHjS4fNJOtWqtaApbPZLNO5QEH54sHSd9Olcrc55/yrSVdAkxKfYZowF9RO0tw9aDHbP0P+
 PdPyYInt/yQgtfacMTA6F8Bwr3yvxi0agnQKikfKqSssQTlp1ly12Uv6Gje/geQ6tRGlu0d2h
 K7L70grECb6fq+UaMhRuL4gJ1aZg2gl1XiVtiVUuxh54YB62nh3DMCFC9E4NW/K5YLTvwzsND
 l1tP4vCr+It4q8uHrEItHVFF9GqjNgxW3IblvpVGvzNSxeTDT98qtkrpI5gVb1F/AQq4snxJB
 paG2Y/FsbShcgIwrgGfSJqBJcpd9zakfyFt4bqvqaxK3MAr2TMbCkHvj3u+kocHLZmjJFzhpe
 M6Bgou1pkATBhErYRycdKgrRg14toZxo56GrTi1sFECSiJVkkQ2CysAMLMz52tQ3biDaFomEM
 nT+Ydy9tUtP1Ke9uuWCOxfZqfuZjMLScYVh+bEMatIbjcCWxmpOTS0KRWQ5BXc2P3Ca0O6DKL
 dtASXR3PkBZVhGvz9Hx4xXj4Ki63R7AUa/Ao4q01rRb+xmB7QMQZyOIFYgFcCUZBJgc76TRU7
 AtXvAXkKxUB12kIuzE+ZrOVoTXydnN2B7n8GFhF4vQ7UgeXanjo53z8To7sxJfyecWKh6iPiM
 qSkyxBlsOGu07ZjUPJzdoOroC7KbyO1zk6Q3MZqWRsKGjgzWxIPe7zEpMWuz1a6Ciiw82TFeU
 jCizQSsIJUQUHcjfaBmwBE7sHixFCfxpbQXY49MvyW2c7xTZeytQkK+JTFXul+8SjMQr0oGfT
 xzKKaR+TvokCD/C9nfCFJlSqPgCsZZPu7uR5cVto95O2OTMNkWP0ogCxbFrfAuftYNRFVDImJ
 wNDJZDkakTCm8711H7l0xwzxbFY/Aqs2MoqtfP/l+OSMpu5/NI2gh7ipQLAbUWqmU6FBzhHey
 ZaDWEwmlnkKPuyDFK+fqQ3iDhHf/Nb9GOKiq6048sUXu8O0MXrfZwpBRtXHXiL0aKx1WF9/Bw
 D0sk/+296lwTNl2135jkMvmdf6tux1LEXPvCqYDetQ90tAJSd2nXyt+3UjWi8WFD99NS9UZhp
 D7CThsedTUfJqNdjPnS2YnWzzcHonDE1p7DFddb8Us7Ccw89tFIywiZvm5X7EmkCjdiAYS7I2
 T9WfxVXuuQohMCwDucia6LX1Wt8ocgk9HbNuZzLR9La9JgQAMGXlGysHmVXXIWABhmRAlGXGQ
 p6oSSkBvmOg+ydrGy8CJhDXe4J77x1Gdbv57Y6goaU2Bn2JjsAVQb5LQMsfu4UbXdfLWlXznP
 auahgmBjnNOo10ETtQPymc8J3XDPh5S3sO+BVf7ezNEC2s6zFMnHSGY30aziLpWcA0NRVVgUj
 HIJOmXmxOuYQ8+DYzhj2Cf9sq+bOjI5aSfm0Jd+5a85DzXxcU6ctIQ5h4g8sjc3p4sW0EWX8g
 2TN8Vkc2IgM6Sou6sR70Lh32Uk23ePoJuTAQEkCeZNX3G1YpzGsEfxux/FFtLuaIjlotIJI0p
 la3XQ1H9RErSISiYihTxnF9bPAKz2irDjs9EQ1WDZxUxtXZdOUpQSlarp8YX4F/brIrr8x8Ik
 pYirYDgvSm1bz77/5t0GRoGcJYseBk+HwCmfTPWITuFEt5xOIvSl8p6gGfhUwo1nOtAQuPRVa
 KPD7qD4tnhQlsiCudIWaJeceKxjIrX6RMe+8C0xUxYl64w/g9mIN5W99PbFxjypfFT9X+mgzT
 jaZA6gxB1azVQHWK/oPQTETvL2CZ69zXdi8gnZG3iTgpgiOrdHNMnh0/fRlirrcXRU17BSf3Y
 PlyOk+Pj0L660IOGfNyS/qYv36pEBOot181wsz21QR8WCjV8qyzSMkgvwZHVnvLI5FazH8sqp
 4TpeHR/h/S3guTL6yzw4RVAv0+vB3Thuiw/5I0B+NPI0G+ROzCrHaUSYjXgblH7MvF4377n4Z
 TMAOFhELxz2pM1UgBb7IfuaQfNOdnAjzcem2nqDYkHkKLnuuRRQ0q9YDZLHZcqYb+yHVB6vmE
 2dG/iX6PvQpXR8/lm4vsgTiwxK/mfi80NNvE4W0gp0dGDJNvZLDfUnKpnh+Lb7t5W8QJE/KvB
 Wash9jfFIN73BjIH3LOCVpUnSlzc74ikbGwt0pNo7Ewd/WpYn8udTxeZV24cEYtps3EmRCCx7
 vBEc+dmw9WFIFiSLCn5L+mcNKmuWhNWedXE7QsiRFDsWWINTmi4TF6yBR9ZZiRf1vcrr4NI/6
 y7g3WlnA3mDkyX9nYijV7ANXXCawS6DRCLy4z9aymseGzCw9JKT8rQAa5Ko43o0CIlckONnCw
 kRfJh/VrYCYd1zFtd0ffkjFWTl+vWUL87XyNkhZ366cLsDvpUs+VXJmWimd1syKvhtZLcAd8/
 06onZbYADS034pGP0m9EbCJKFG10tLFFFneATvtl0tQyLaKuv/+OLaLN6voa+6xXIyvBQd2qP
 S/oJVTZVJSS2ht3wNqxKbySKNswCgCH4AqMsV7mvPiPE5UsLIMr83a72bYKUctKQJ7a+BkoX6
 6WU9sNc6kI4l80Zxo6ihJAcPZzDxIkf+6MheHKJMQHKRCfDT1+g5YY97odg2SxM3LPm06OVc3
 xQltXZUTFfQ+sKg+zocnXf3P5SoHpF1SJBBt+lSLQz5iU+mE9Z6QIIjJgvWzKNoO/B0hckN2c
 fU324zB8eS7dEuvh/FPGBEuc+0po1VnqXW3T6P/Rn2NbanSWsxgslbMfvzCxHn4ZGxXZA0FTP
 6NzrSYOjKkyrLNoN1TbrES9RsP2WgF0oNQXbA3vl7NqMwDuBIQhcDzsaFXr1LL+LUp+DDjy6q
 JUGhQZ9UUmaJeRk8v4RY9TMxhikekA+VtBi2c075RI9DuSbF7RB6NOv7TKQ0ZmaFkcAbjy1bf
 tDlDq62Ca5bpSSAWPctQLe9Kx3xXIG7Y+JOfkwxRJqzU3mQtxOK7oNZO8GYWiP8I7ivjsj9cy
 sUboUK7lpkhW5x8McqYk0AkX2+vhp0pRUM0J0RMNjbKuGQ3m8Qv4wD9rpw3zOBExBlYYOBRei
 pNa/1Cn9lDAAMCxD6Z2n0VaebEuDlXSzBK+UsFBUYxd8NcHDs2/1SyFRqUs3zQ127IU9FkuUj
 UIMx3gi7yFfxF0EIGelae/Xs98N3SQPNxac789wwDnnF1QRWRCf12RX43f2YFnW5xUnMWU9c5
 Sjm6GgPZ0NZAe2mVewZUip0dDAHuXjlHanPXUln111ZlgAkwNtfLMry/Plbp487RjnjZkNNDs
 8wCQnJw2XS545F4uAl62P/Q3b/NRzkYdKWqULASKZNCtMvuoT1MJTDqJF9ZebggkoD3XpG/QP
 NhCfD51zYaAaQpPK2dpvzDJdPDOMCkaA883kvc9WWOJcVcDp3We2ojSh4Z45L9+kTIjPBYHx+
 5M3NXMudCeDocPe4vZHvExU+ZeEeOOOSSVcEpm+R5+rstPGplCpv5vOtn0hwUUxflvCY0Vc9V
 bWp5xa/sV+MUv858NSlCwCMN8Rwycp+f/AxjNnD3Q3PbmMogKwtzO5gBknszq/KGhTpL3o6oF
 e8YruVEpflQnHETBciRS+Zt+gHq6UX2buZrTZcD3XX8BYWmwO9hejxGx3yvRv5THinCXXH7Tg
 ORxWqndb/sPI1MZkzlMsDDIK4JPi8=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

On 10/14/26 18:29, wangyang wrote:
> Thank you for picking up patches #1 and #2. Sorry for the very slow
> reply; I only recently caught up with this thread.
>=20
> The zicntr=3Dfalse gating patch (commit ebfde6dafff2) is in master and I
> have not seen any follow-up problems with it.

Ok.=20
> The reservation invalidation patch (commit 5089493e45d3) is a different
> story. I have followed the performance report behind the revert
> proposal: the patch sends every store through EXCP_ATOMIC and walks all
> CPUs on each store, which turns an xz run on 2 MB into minutes instead
> of seconds. I agree that cost is not acceptable, so please let it be
> reverted. I will not ask for it to be kept in its current form.

Alstair already queued up a revert on 10/2:
https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg00307.html

and sent the pull request out yesterday:
https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg03121.html

So, it will be fixed very soon.=20
> If I can work out a version that avoids the global serialization, I
> will send it as a separate follow-up with the multi-threaded numbers in
> the cover letter. Until then the reverted state is the right one.
>=20
> No action needed from you on either patch.
>=20
> Thanks again for taking care of them.
Thanks!
Helge

