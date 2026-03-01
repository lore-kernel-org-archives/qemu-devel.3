Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B92FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHm-00015m-2T; Sun, 01 Mar 2026 14:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHk-00014a-7H
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:00 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHi-0003Vl-5t
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392615; x=1772997415; i=lukasstraub2@web.de;
 bh=1wB4PGSEbATkgykqfYbhMdJ4xkZ6sROXVEk3Mx6V42s=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CosOQMpYe6l84/1/FP7x3D6E8t5gZKUdrT8fnmbeh2XCA7gi8V9kGe5YCzDtFN/T
 g5yUx292pAow1359r8OWjOIbva2+Isp7JJOEiwa47guDXgUhtOqEVcwSJ/4L0jgDt
 Wz+tFcmOW3GmWLj14C+J0NKRAgZ4FFSpAJ6YtOX2+Z83YkoyvqYlXIFZqejsI+XyO
 iHj3AJ5R9kkuvxHRma5+5mwArldpJBN+3df0tjPcZ+cPXeHKUYC+YVbse8yinzcbM
 qGZkYyVbmZgmhV/fekL+typrpF6g13TYXxkZnLaH5Ztkv1qdZpNxZDwKjFsuu2U4t
 3vJMjLqFEAQxDMaJHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79N8-1vbq9K3glA-013IZq; Sun, 01
 Mar 2026 20:16:54 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:43 +0100
Subject: [PATCH v11 18/21] multifd: Fix hang if send thread errors during sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-18-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Di3bviqJ1tNSV+njROs9ZVoxf8DQzRNWY6OcVfgFrAU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCeI7wVM9S5XAXP6QDRbl+BHK7Dx+CE3OaXz
 VwUFpK+6NqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQngAKCRA1qwsonF2y
 WLbJD/45LxLv1B9JV3D4SQY4m9WeWLLyEaPkaMnLPkmltC+AAMH4fHVyxq+J8iBEONSN8/lE6MB
 42X13kY5XGcTZmUx42cu5NkPA8aRfuA09WcyRCQ4R+HiwgbDmIZT3+FTZRqk/WcZ2mbyX5k1a3u
 tmSTJfLvJXQiXKAsFDT2DrqjWpYfrMLN+nLb6PHXMIe4ZKucS51PZxsrH1azxoMY5Z7cNoFraAL
 lKjDrzYNDiP/5O12wfpzmh5fHZey4HK/PWwJwyG9O/di26XV2UBOuKnd/KKteCiPc4+y2UkEPmX
 F/gudPvqCFVxxGslhLjF8moBuLajng7teXh4wMOQCwpSxCI9lf9ev/eWCCMDqKziHh9XOffNxnH
 XmM4KNsN0SSvJ+pyTb9WIDfCOJ2rpCg2HBZAmEfF754diuY9/lMFqpzG6Lo1emdetoMBj+BLqS/
 AwH3UGaYiTREtkVwzrN/ETIzffWgFPiQQKdAK0Q1gWMxcyyVNZsIYdCJKtLGz0pQSu1szOwXUjQ
 bSbugyDIbQlYLa4H5OfYJscbFqiZlOuyVAHNRwIp8O7gPrvjKa+Au4lg5a9BvVh5DPfSI8sdjQS
 Pw0aPVjBlBlE6XjejhdWrbCRMRlafG5s60mo2z7ZprwOWCRMD4hh/jSVHPzq8bmXMtIkTmvL1T5
 8IPjCm6z8IwB5+A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:NyBH+K3HAiC0kDDzmFGxswKayt72VnJTMGE/PwbYkGeaW1i1QcP
 QqLccWif5SC/MRXRh/jcCkfzd6Xvfqejs0LgrKi6BTENK7UaLIYyxZRrTOcpVzAPWHbgnkT
 urKSuW+zZdYkFRA0x1njBOpANKPAOfZsS33HKV10RWOjcQDCmm9B5dXbfZlX8FvfWA+EUIk
 9y/SfGoAVJkkYPDl7TUTw==
UI-OutboundReport: notjunk:1;M01:P0:AN5PG4s8Vwg=;5mmM/8ZtISrcqPFkEArmoDweGPD
 4vimIirMKE6LK/8csOJv3flS8S2AkFGo3TczqlOvu86Y1IjxwJFeILYcW86RsxCxDcHKmR5zC
 RYInBALEzHMmzlBD3iEaEMbEfw6kuu7Rm3StgLqaWqUfHdtlsC4lUI+xp6kxebb32XazMvHQW
 6gRBBRL4EMz4xQI0MQyNGYsQ+LJ4uwZW3/aWFRjYn7j6peHq3jftMnpQsf7zLiuqrQ/LIpruy
 sEBFGqXxD82u53VOPBELN2UkY+3V6Vx7zcmVnI063KQj2lkxnKbPRXKmrFTGkKAHyVBxjG0//
 jydIxTG8y0wHFNvAbDY51GWZUGxFfy5elBFo3I6yRHZk3B8lrhgiRnayIkG8mXOLLfbIbyuMP
 3eIsc0NZ9CEpHp8XrgOeEKy2ARdg7D9JTfDLeD//cXZ1Rh1znuB9k4ZI1H3y/6/V4ssGuJvKY
 KgnM+//4YVX5ATMtoVmPInXsNQh4MllkXafzOfAyI96vM9+0QCZNbr3uN1vTEg9YFXU1J+Hap
 qtQNUppcAn0lMB34jtFrh/hppKOAIK/WENeKuogfCt1GG4BX65B+uw87BM9pQJzxnQYR9PItk
 AfanCCTWIkKzIPFl07yytx2hYbPk+7W4CM7HHRC+VaNRRIL2hrENSGmgiRG/XPUufsZI14QeO
 VA2aHrPElp/B2YQFYegj1qoghnCrlSryktBR6DPUXa/hZKg1ahm9JX8pTOMjf77KRAcmCHx2V
 fCxq3EQEpcpJcyKvueTS79O1FCElFapgoZ8GsZBg0qsDKDt60/kjc+XPpkv8025MnDfBRYjp2
 IRkwScRXeJUl+eJUGWfmR4o7liOdWjFGRwsIYC91smQ6AUwS3/k2rkWA2qbaRDmhyKazi0YwL
 /dZ/3Q/jvv3mZH9uNQh1oFeNEfr3A5BJLyX/RGik/TaIgRAg8PBYhF3hfjx4T+N3x1x/E1sc0
 J1YiteI8iFkDT3lRnunAtJ2BPdDTvZnonbfYHFhFSgG5OBtOWld1Mwf1b8nqtDvKXwhVsc/Mg
 45VbW1EzhlnbtYvjI71wQpB6GXTj8f/2bHFNE1JHHjPBg0JLARhlx6rdCmFY/Bd/j6GEKNVgK
 r2cZF2o9624bdzwo8SgZJInhuj4f9UJBp0C5n5qTjQNoHTG1OFDW/HS7Wt1OosYztqOmXddJX
 RRbX9h69CbazF3K91/JUfAdKddA7xMHtEsLuYlggh8wRToLMWKTNNyw329ZFiKZP41hs2tC+S
 9Xy8NI7iVAn1ZBDcctOgKFEwwNLmN9TcBsb7EA/4m2y8QtUJ3IJePWg8dgf85k2VwuLaQlQxl
 N0DZK812YqaXnWhoAjphRyVf/jaNVpsiLh255/eFzFv0dCcGxzMLnSCo+5qjlsDV20IWZXhv9
 FGk9sCdprYyuMCeTGya8E3V0Coauk0F0sNqsdbSxe0lvRH9jP2nPrg+rx/mhvZAHRSYy5SCP0
 nP883xHgAuaR2ei0yigiWP0yt7RJXEEtjpoPUzBwuMUl/cJTLVVva/oNKikukDlHT8ipdvnOJ
 c8v6TmZ3pJX+ubsq2XsGxZ0rw+SoRrHZiCgXLrNp0FE/8pG7+vWYSopq//wqG8B0irQ97IgSR
 CBYroTaxhr08xqZxDHriat2OmR+qVMZ9PahM/cVTSsRWJUjAPDG5y5howWr7W3ZSjfa6Jbx1K
 Ya6STu2SD2FzNzprZLrlFmXkZNN0VgngaynHMxflzIXIysySgoxX434CK6Dyq8xQac67SaoRj
 p69jqQZwFjotucOJ7XMMdCiq/wAoMj4VRhH7YTOMSKr7yfKvgIhe9AJKOqUt7iJRH4XWvgWik
 LikXR2h0DpiQBMpcNtSLZinXsywK8IMaD8dJKQE6Jkv2GFuRDauhIwRzy+02ScScAk9wo8rc2
 UZAwv0ASZrQojdnDukSFrgERVZPWXZ3bvsUa0Mbe7Kh1SiyITQHC76n0opZWWcoj+JP0i7+rY
 MfhvA4IC+x/11XQUgkwuCbuCLufBlYYYB0Uu0zimNYRK4IHMbkbihy1NycHhGtmEI6QZans34
 fbXCm7jWygJhfmAL+QBwxYrDuLTYbQUOtkZGC9n879GyRvgAMya8N3bl2q2pvMDRRRS3l9UAJ
 mS93Jj5/3dwq31KkuzTekvxBXURXkJeItnnxQlMSS6lJkLfxSwktuhCx/YkzgaYxr4oC9x6ir
 EtQ4ZfSJ2F/c2OOrTZ8tGGJancEsdmWo+tv/sdu6ILlbTpDizjmOrvro1SY8hCIgR4MxmtlWp
 LZ7ESNyIYmFc+xG4ly/7+nRrqmvJZSc2Nyy4vI0uUjtDovEEP8EL8lN2/iXCrMyQ5KqNEOz8O
 toGaaWJAg9FJHv8QSQNacbHqA2ylJEGewKj6fWu9/uO39BW3FitxsN6+1tfok3t0shgSpjSdj
 Ej5Lixhe4XZLlQBy48hWR29cxfjRNj4Sz6xUxprG3fbTftjZ9DRx7EncPvBgVrkN76sof/AA1
 HY/Wmlr3OmVtMJzGtgZi7+AhK/SsW2VBi7xpZ4GaGMN4EAhKZZV232F1DuUoHsfVvJCH9bjBZ
 Kq7t6DCt8bcZ+1+nTnemmPn3JZavXh21nS+iPDdUZHYISwdtxNG5M/9V7s5+TGEzyaadkWsXL
 xWC5bYGKgnEvq5XwLI0Hox6IV4hjehf6TNbU8kI2zCDPHKVZmpeYMt3igktpLdasAdD6CuqcH
 QPBQ/1nQ2lj2zNSWtu26aigOqUrJjYCoDz7PoI0XCGvXSR4h9c3yXsGklcG+TI2kFfvsY6yKu
 mf6MMe7EhIexVpTcvb2c11QMtYChSRbFHHKm9/v7vT/DzrlgiqWQaVs7OuJK9I6zPvgOQ1Mvk
 LbndWMfRHjVXFsjSIK9to3Kd0kwjhDW3t7ExghpZz3Ucm3G7bPpJZs3UkezkNAPQSeAdsqIiU
 rcJ4APWm1Er0FOojYLa7cpXnmR/RYhgRdTmPNiyK51Xi3C9LcR45WeFRYeHDzNqMob9/IdwU4
 WVAz6jZKjc46x3nRVIhvvY3i2Ksu7SmHu22Ovslj49YylcCdgMoFtjHyIJiRDh9R/1fgS+2qR
 AD/si6ZiOeSDR5mzob5k/t7Jpz2bezYrtZPec8d5M9j4Pxj2sclxMKmVlmFHWi08yUaPWkgEK
 Q0/GyIvXidfAtiPbN9Ht1QpmcRBk6qlSxUxRn8lZoYv2WZZuCUJEfpvtQY4K54XSXjk0SOGAD
 Dvw9hpFmIb2rm+BlQ8rYAMwzzeCc8SKqqCvBsiTVTpN5PqQsMKpiqOmYGYRyqk2G68XmwRetL
 m+hmF5Vf/73EETeJWtSEIvyALCZ5woN2XKuOKxXKydQK7mv7n/+zYtINZsk2dI2ZOhrV/xXzA
 IkWS2fou1PnVLWNuSBaFlM5sJSjDqZvQ/NZz09AgAS6brxJXxfOSheAK3SvH3eObIaKmeGuue
 uzzGxIZGHqcDEYQkETSTkeXB1xgWq+Wl2rnqTzLZsMEO5MKpoDoOllv/nGVG0Y+lIS1DIFkg6
 mn071Rn/tVKovuEMs38FgnFRvMyO74KmszVqxVJVBWKLcEiZRX8zVnvWmCoTMCYbc6H25abk6
 ofxiFJCGqw4orZN4TS0qP9JoWY+rsYePJ6kTTSHOpTqfskT0wWUZXEj/eVEzLyieUL1PRDv7I
 JXA8AsK4JjdOEKPQGAuYI4Gbb0lT+ob7gWTJb20kH7q7tl1VT1VSBo8b/BtGO80I99+FhcjPy
 4mxtonUS4N/oUQajWnTH2BimV2cgMlAqClsEl3oU8oMG7Ubkg5y2lT7LE0T60lpLZ51mbCMQv
 9XByVO8rOwFJt0nT/wOjEsVc56jVRglwfPXYOpWPkJ6ixJQtsOxtFFTX7ebRc0+2GcPRrwZyS
 UGq5wVtfTz0QuPqjSfGTuOJkGztp6BkRgqsy0Gsi3Ba26LUXNy7diQoXVChGMs0juzY1M9d0H
 nO1npmdgeutnFejZXq4NFZEcI2/LICdHrrlYgV3LvIDzpC1sZnv4H1hBRs0PSMysHULo+EpHz
 vks2vXC6rhVpk2H20A02UdDyYh4oNG7CAqUR2l+b/LsIyUBVAwe/gQeKxynIdQx3u6kE/FJQm
 ER3mJOo1vH9dcoqrLnr2erQlfM8ruH5D8qJyTm6/rIOP9TUKvZF9IW+HB26lvgFJhaiOD/Hq+
 uHM/Re6xv2TH6lCJVBPv4R8J4SPAs15e2Kh0VEfxdYHdMQ46rquFEJxap+gbaMV9V74cKBdds
 2Yw6clQSJlu2/kFEMVJVcD8NsRONFCmPkyWRmclBi/lIizxHBjMN3tLY3xqX/YEKqIczJVOck
 Z5kYNv70zAbg0YOoMeNub3uhm4nrjox4ljKLDj0Iol+kADShhPnVeRp6SNnqdptqf2wwvnR8R
 a5Oqx4B/hCqmql1ehn6TtD2bNdoPVYHfDDK1jwPcvJUPh6+2j2jZhLAHugMuRtoSWZLcndI0S
 sIGWhqK4dk9X4gIa/1Tsce0LbVbNxHbqDp5NGvMhjqhu7uUC5hS6xTq2etjB7gWl6t3dmDvu5
 EK2CZiwe/h0JDDeS0lY3f4+8ZayTHOUisDOWU2xBbSIuKFMIlNTk7Ghj+VJ4WoBn3V1uObCkb
 K8k2UuG5kS0eqjufzkTC0bCKJCNRz0Q1sGGMVf/oBu1bln6Z6059iPXs6oR9MfbrTJtM2D3v0
 9zOQZ6dZ0WlP4A4ZxwsLdI0/TtEJl+QMyV2YRRAbfXctKAi5sF/dxHSZo4lhz99GkuEOKSa2M
 wpNV+QzTnuU14jgnJMISST3TIaHp7Jm/ZRpKmXXXHBY2Ipewy8i5pBAeMDD5ctVZMTIR/zzWb
 IbfAVR5RWm61UtQ9xNJP5irITXz7E3mAwLnrm6XDVk8c705CpNvs7+DRrbbngobZ9//VKogu+
 lu5gxmdQbbqUUeuuXUISdBsYl2dIFreEwmU6nM8Mf8NIZJi5nyPvHd65ds/HLW1qZCqku5xlC
 x8Mo+OywqCWDpkTCSuqjL/adIMqJzftx7Gom0n5EnJq2zX+WHawnpLEQGHNsTj+u8YeidUOoA
 yiq6Jh7C8EG4ppKFP6tytk14gISFYe4TRmiEuY1BxNWi+ZPTtc6dCytCn5FPritMagTpygSCG
 dsmDUQyHaitF8kwOuXC1PPUuBZ6wX912rXCgeKtCViznym8Y3buy5Coa7vpaQpnAdiGSdmlhd
 EqwjuokRAD9uY54dLVBWdqX8UPxjl1UQOn8pJS0p6a4V6FKJB0PaFn1U9b2itJ3rA4c++TlrB
 WqIPRjNuJqw1YCoe+RVz6c//uHqGY
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When a send thread encounters an error (as is the case with yank),
it sets multifd_send_state->exiting and the other threads exit too.
This races with multifd_send_sync_main() which now hangs at
qemu_sem_wait(&p->sem_sync) in multifd_send_sync_main() line 647
as it waits for threads that have exited.

Fix this by kicking the semaphores when exiting the send threads.

I encountered this hang when stress testing the colo unit test,
though I was unable to write a migration test to reliably hit this.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 220ed8564960fdabc58e4baa069dd252c8ad293c..7762aab8e0702672d3730f27e9=
c9ee3b86500f0c 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -772,9 +772,14 @@ out:
         assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_error_propagate(local_err);
-        multifd_send_kick_main(p);
     }
=20
+    /*
+     * Always kick the main thread: The main thread might wait on this th=
read
+     * while another thread encounters an error and signals this thread t=
o exit.
+     */
+    multifd_send_kick_main(p);
+
     rcu_unregister_thread();
     trace_multifd_send_thread_end(p->id, p->packets_sent);
=20

=2D-=20
2.39.5


