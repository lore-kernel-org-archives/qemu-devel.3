Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA7FE6BF05
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOl-00048i-7S; Fri, 30 Jan 2026 07:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOj-0003jp-Au
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:49 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOh-0001up-HR
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775274; x=1770380074; i=lukasstraub2@web.de;
 bh=jrCXMnZWzv/c8n1uXyg5THx/mQoZsvSMGmEgClqre0Q=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WWMvuE8MfhVVHleqLBgKa34moagPgDMsOx/F2beK2QTdVGKAS7usMNE0/TaiEDfj
 geL/yiwE4tyuEdejeqZUfxwcY0hCyKjpvv1tFP1b4E8i9fmQdZc9BYbHcCaH+KiM3
 TA+RWzeNqRAG4RdA6YvuJwZ3MY0LhWT8BHuaIijTt+m80pCysw7UO3WaQUgdU6brZ
 Ex7bHZlv0YN/jH5Mqw0N8qBcdx1JX4mDQNhKJyc5ZpgvuWXoN3TsMlRn+oVLux9RA
 8wImc3O/HTKbhb7RXUCFFSznD9iKl1ZaSmQ/5zAXCP3SG9Kz1ex02gHi0ei5bB261
 isu4TK+k7xOdAIystg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1vYJOX1aRb-00670p; Fri, 30
 Jan 2026 13:14:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:11 +0100
Subject: [PATCH v4 03/16] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-3-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=qRB/Q/pg91NIOOfZMIxQDrQKCplhY1Pj+87YWvbXmbY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCl9f6g1EvCTGRwf9RoPkAhz+lZUQdGpnT4r
 Xwg/spC+bKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WE++D/0W9hLWfEXvBre3Osb4JxRoR9rXZ7z/4J87IVh6Xi3HXExoVMeuJamItsY9G9bGrcBikLK
 5dLHm0fnTlZZb4c2ROzCqYjYgUCEm1L2I30ZKHSIkphVD+GtSSGM/b4ARhTy73gTMQwzr1gKupj
 r+VX7Wzn1UMwWoduWxk0uqLC/Kwul8xLQCW8RMW1OeSbHJQqjeCDFbG5Vmb+zThjsUoaBlDrZSH
 7BOm9YN2NGRHZkiLXfIlOdfV8T/p86e5rPnz/cDvRlWl21EQ9l+Y7LLCEYVAEQgBatink3U61vs
 HpECLBSbcImrrPfvLKdX0xQ9QgJNmOBZe95fJXJ2+0H6tr4fSKci0hov8cTOifZce3R+ktMWt7k
 5bY0O10e8RTT9ObS6NrubSaIHZAE2Mh32r8rxtFPbeREhGNDoWHbQOfk7tFrClfi0+Glzjvpvzt
 81AMyq9U8NITMe+Nf4G3U2xTqDntKY5Xb/bxN5vNYEi8ux7xiHLqSvnPOOA772X1ovwjFnitmkn
 6McMQcy8c1Hr3+HjV1SFrG85LNxCSOUyuOoSqB6pIlRuVjOKJU7ChDbV5JE0T9POlbdmukZ7WdU
 cK6JLd6W2BCYiaHhug4+k0M0dO03Co1xSH/s9l49yA2f/Zud/j9NF7NF8w0ZLSRHuV7qVUFWppm
 DhGkOGoAcyhraFw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:a/6ZFO31DewU0p2Cry6Rwi419v3Skjb2SGjwG5zHIQX9qLVcycy
 KqqpZzF58jh+22B8lSxQP8E+FbdD12RmEqmvVjYrdtzXzYrCFCDVS2qF/nnd+mKJyFKz+il
 UDnR63ukdPyl1BMyXPiPtUhwjO0lTD2bHeP0SPiuAztgMommAFmFuTVXzCrELjuOjo6thY8
 6s42QUYBbXKI8R/7ITQdA==
UI-OutboundReport: notjunk:1;M01:P0:IAdC8R/EeI4=;TWDbkpE9wNLWlNcH21vRUr5OLt4
 WHTRZF+zyKx4XVlDLnWrc4+cmS0O5pUGyT7EHhOeTnijn85EOQCSO+AJ6v3dad5fWsn8k8JwT
 O6UIignDoTm5HsGrbrOudFZEuwdVFbMeEfsZG0xKBd5hP3VMF/otvCob0FjJALeNhppXO+fMS
 pFemF2GKILxrKDYTCsHMcIjI5d/+wd5mQj9nkKrMbaFptmnqBnnC2/Z3JgimuFPWctYmpxWmd
 v3XgO/EHXY7ummxNQh0ZZIYvAyJcHBgfrbgccxW71GCYsNOZVXTvD7psrqkPNOtBs9dO4/lwC
 E8+pFsR+nDjQECcGi6d1SsLpnl04pC+7Snpuusk3gNt6OBgHwAlDU2QYqjbNUUpKED1x4f/Bl
 EUqyKWu/UPmxiF5SX3hjFyEeOQC6XIE1KeXdD2Ut++pjh7gE6TOzZuco5n9gkMOgEgZU39Q6D
 FcOzOZgHYPWE6nCkYRMnJWJ/URhKljCu0QjilgK+H4C6n5JUH/fzehSZ2ESGzyp0Bl6DE0Hte
 R4MzKGdzBpsxj5VkOt6EiJX/i9do7EpVN9mxtoV4/C+GIRhmIuMhD7BgHiassf/sXMx66NuBA
 Y4hCRjECxqF5A/3b7/evGjz/dfB+MtZUX2+boicEaQ6CLAU3sWMJ2o3wtOfddAvMgDOPNEBdM
 tZtX5dYY15xbSIlA2DAaqkrM8doHyy0R+QhWEldvHkP0vjmmWo7ubUraCVm3zbI5QVR7MyTCY
 q5azS+KJ37gobmM/TIEYX3AfKue9mdF0JV1M0ImufEYsBeyh+yIcoYeql5cCZZ3RQsbkuKIiO
 D+/1gFvSUY2qPrCShtc6YB/lcMj513vxcjoHl/U1jPRF0f6c1XHgIrq6ybhCAbcHU6VR7uzS5
 DuPW2EKWlFknWGPXL7H34CL7rUr2iRPe77BL+OkbX0wMB4AWokzw4EOww9C8cR1Q4+R92P4wP
 LYa/X1toSkyuIKEAljr+P5Q5IXAaRjEi7K/GNxSHdPZ/74ACuAyB+GikDDKIfZdKhfVpvqZFO
 EhlH+1Lk9NTUIINhHxYwkvj7LCDEYTne9iv3tLnGSVxrUtcK+9x4m4PKrMG/ED87fm90G4JLn
 ynu9saXRNK/zWjr7eE0Bu9E1fs+V+P5HSAabxF0dWa83zrOfgyuw0pP4ntZOGBze2VzCCm7J+
 0vKPrllXsvqrBeJd+6VLrRJYU+WBikRnTrsx2V98UlQZwVarBY18NA05BuM9qPyHYmcO2xYdA
 pne7D9z/RH35LDg53BQMtpGyVEdYccMXNq9z5c5QBBfaFwkXhBPKON02s17mkzoRbchvgK+7t
 IfqYmfXeg7udhD6Ag3Zj0IOyYDoUFlnbvO7IiN2c+3v96CBV8ol+ewGGkaAvEBkTmPCScLfa5
 JSHxouia3+Q0NpHL/aR4TxKvGWEMHc68IyqHX3aDyKUo6h0N3qcbzbVKvkf+rBNehNO93IB3U
 Ileg4xVTp5FpYB2nat4h+/G5afGjktkIjWBWJzV8GQIxUDK2a3ZKAnM+PS3QnsZ7/k1fsL+aJ
 mc3ijVs+qP97Rcr9GMv3FNXcaNu127To54gVuExxYHkcCBbwNBMlAi2tMZ8QjXWYoTaUEWotY
 ejUVdPH7uo2pd5D/L2xVJDHsca46EeF7RryxaWEj7cNGt/sNyiATeTgk1TZs7R0tUHzL39WZ7
 Sd0PYPiySyR7/iqwbnKlrQp+n9BYZY5oB43LdKIsXLhMM7f9gdKiNtvNm+1KuNZjj7IV1FupD
 v6yLDIyse4kdS5acAQB4t+qB8hL2yKhpYjsg91pcTO1gtjHz4ffl8myXpSja+vYLe98pkegp/
 IaQlb1KxHaAshElU7dvoTs3t4GiqV2ZhZfHXrxeqUoZIlmrdqPpeluXZWWe/EPpGIBaKEywp7
 n9q2Q0MwgujG7y2w5s8Lrk4KmPMKF7cHre20csKu8s5uoYD7SDVLLErhHwmMg7XrsikIUZJKv
 smOflW1LrRBHjS3qErmOSqAouCVX3esvxNi4jm8vAO3mUA5OIyf26UOBz35ts//hyhA17niyq
 6ZT1KOXySxgzxig8XDsnDTkm1PbRX+VCbPsbAUXTApzinAY75feU/RgBvciBcbadhgEiWBFMX
 rJEJHanUlyWYRXsbwe8RzP8EkwlBRT0nqkbBMaIQYRgt+qUwIae1BG36IOTG4TonptuQ1CJip
 ccXkjOcwuMLtlJhyKU3u1zFTmOU66tXwsyOnlU8sSp7K22mG5g1kgPefSb4MxefqDN7Khw6WB
 UWddFiKbT2w4ZinPw+zJSd6jGqO+24tD0kr9qtxycA/6T/l61y+sGKNA3+hNLvxefy3ICUSUq
 R386s3VfsuA+uCOC/rd+I8Eq3B1fgrvSzYM44Klm/So1hHkKYia7u4Tti7O1meBXr+sdLeQzH
 +l2BbLXff7QIJYkuVeGnUZd3MAK0mAEUqhRaAb3SRl2NLXgfvPxqtJcWk2RTv8dN77LO4Q8Ho
 JLKt3mE/o/8w6kQ3vZtljRstB+XN2TfJthEbZ9CUSvosBj2TiE/zSpTT0AcFY8C0Cqsi2WzRi
 NhoLaoPK+4/MJ4tCO1QD3id2lU11cFO09kqjDVuHndyVI36x9BPCXRXStRVOaXYyUJgevAkKz
 dfY2vJbqlYCmQqI/+t82Nati3QNUV8mdn3pu9Yjk9/HOzQ5EBqZqaDpYXNy0NcFZn3PposeXa
 NR4frgBarjz8lZExjaAtRtfKv9LoZ/N6WPni2mE1CK1PjcqxZSlPqwX6YATh6AidwrrYrB77D
 ERX6QYrvifzcsWuJfkf68jo/UsVGQ7jRGsO5Xsvy1XkVfSQQrb2ElMWaYGf/KI+P7+uzizJsS
 OiLIFS0nDhoYvZm0/V0lzaFTQmFJsL7gv0Us+C/R0BYQA9hJW+7TiVKOBCI5t6M1KSstJDDKj
 vprnonZEsBvumQQdEKuHLJNtmkAOMz3ktaR+dVrrCvB2I9XLp+OTLvUBgxZEU76InImqZ1+jI
 Kg6t0afAmeDpOURzYVI1mT2RPNa1VvLdRJm23JtoXDvGmdFCtpg9Tu/JxNqKg1i/oNIKKHiVE
 XuHuhd8B6tFLFTH+EwmP4UHCYH6so1KJUk2BoDE8SrpZ5EEfomAwbryhYigXtDBUhC3IVaK17
 4192JVdm1n4Tm1zygBDHcJXLYgJQ/q10OcNdptIyZ6obKN+zflF41ffW3XPkBgZvFqYbAItZH
 KrVhViDYhMN4zuyMwZDY5qzicEiucvtwCH9yRwXbe6AWdrNF9/Qj+Vkb5fHbT2VktfMO6mSAJ
 vG4+jRcy1jo7OXYY55uk2LvqKmVft5MUtTNJ4BPjY2a//o+88et477fDgYm2osX7Ag4Woa1D2
 SzHzdonKNp6ytXW4p+bscs6AeSx1nEnMOJiylIG9s3s1CQRyzGz886l60Lgw2Jm6OlfpzfnC9
 DUkl/ycBfZWv1LTxj6bheY8vDA5KrYnwCxK1UJ3Mmrrf3rJyTf3NSao2amdJzAIQYv2eV/JWW
 Te2idfDBE6ReeF04R+8Xcr5j2aSkivb4OGBHoU9b0x4nXQQnmsTc3H910RmXCPfYueSLapBdG
 6gisltoFmO48a318GLAPn3ITZ1c+oDyObg4Fh2/CDnUPq4M25R4wfucXd70ETEsV+QqCAS2Dq
 GHsbbDXgKfXID9s29TO+dyDpI15+GesdC28dbEiN36+9eUwGfFDF9rvW8u0fqJLW1tUmOCg8P
 dbpXcBl1Kq7Kuz+HSH4o3AdePlxsrIw9oVRkq8TCn+25SLSuFHCF/luwCYHvS+Sl9FuRLoUKX
 59HtE4xXABew8x3bmPdxG37tb5YSD1v+d1p0moB0VUVqUJHvHcJgbERTIi7S8uTqd7Lmib/KF
 LoHqsplSaG/AwtzjwK0C8sZwaWaEcXA8221yi8O28JWIPEf9N4eM922k48q84poDlWG+bKqi6
 uQLsorE2TWdRMNkoeoQI8Jm2MpLox+sLpCffvn6eniDDCg95zEtwYHKK8cohAfKQE/XldEP6d
 mQXYifK3QUox48Vm0VfS5s/GSP/hxKBNidH0xBapKLdlKVygyd3YB2qGSSsJ2WOCxVaj50he+
 NlOulvbssx0PllM6eS5Hr2qqExwYQ+E9vSi3BMHSa/dhu8FtawgIhwOXLnsbJHaMLw1rObDuT
 7VAEo0wvm/bhiyCtH0pKpIARmswMEJXNyOcrodnFDvixQs+FMoevtrZ49aJpc6GP+ylZqGEkx
 mZ9javpHK7iTJ4n5SYeAJ7oQA7euSopaRDE8fX9C4x8vhVU5LuzXMxcRQTJlB1sGJGxavOj8l
 Z9aa8DNNsK+j1Bj9SGxOP0w29+Dy+9dvtoNhtnrxfpecnf6qrhxTGXEaLn2FIVaLE23AWW/6W
 Q2+CBlEPLqXK0xUnuPZTS4sUilscC5ew85mMqC1zyUqOwnKhJ6G62KK+Uxsv2mj7tcunJdJNo
 9gKyj6Hr9tjmk+D9YHKFqJGMdpsSqemacl+GyZ9FqFSRf/wU9fzs/F6UC0mG8V+/FeH92w4CL
 JwxaVyAJEubMwFku6gnBiFD9oCKBJRjgh9+GcNRd3E0V0xi+cFxqNgcdgRhKYfv63BrhyW+5X
 M2JFtuW2VyldqOWurGWFQPO+itHNfgRCukp6sP6KY423QMQ/EBSPIRVzvQip5ZFAJ/y+d3Bjh
 umzTDS6TGjdjvRruob90+vl0pYxt2LnYGQnWUhnSImpcpDFFOpi7O4MrDjoAkDN85RM0BNMnF
 lk/SP+PpbdBvnh/+rzG9jciIbzpZXG7JIMyfWwzXD2HuJcLqAuQaVZIkQHhLNQAoZdlV7AAON
 Tvc0MVJ2yjCZGPwcR2vgAejeZSBoK9lPIVcq/2iwuEYO2IvMyza2osMAnRgxZR6DV8yRmTzRz
 No9MJtGRzut0HnSbf+vSItBRPJTVfpodImcvHc+P2/wW+sa5EK0tPGVCeFy99uAP2JUwmW/b/
 oGBuN5FZUQ0U+c41EZgjGsEUCIzbUC8EOHUOZRdLvm7e2OavRgTibBpHFV+51f3mz36GwYwIl
 3A+FUzMaF+OBo06vTrvmoN113rZGMkDmDvy+S21stMK6+7t5ar8KpU3Tb6RfBR3W+aWnumIaa
 PhGJZ9NKxokkGv5gv+L7yAIbvlCfujgqio3UkQu921vz6sCVey2NuFy1HrBLIx7H5ln9I0BEl
 7xkLD3HIaw+6Gd4K0VdwvLWTYsIkIKgOYJ4o+/badbhQCBGlrBPVP4VKU6c+lY8/VDT3HC1Sj
 oIr/3TQMe8lQGktcei04cMBKFMk7uFXLsQ7Puy2iHSRJ1eADB1W0IgJ3gpL6NdUqp7DwRSpET
 d6Eotvu2A6Y/IjTsyWa7
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Use migrate_colo() to initialize the ram cache in the normal migration pat=
h.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c | 18 ++++++++++++++----
 migration/savevm.c    | 14 +-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0b83009d01d238ff16c0a542d83509f..a73d842ad8b060dc84273ade36=
ef7dc8b87421f3 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -630,10 +630,6 @@ int migration_incoming_enable_colo(Error **errp)
         return -EINVAL;
     }
=20
-    if (ram_block_discard_disable(true)) {
-        error_setg(errp, "COLO: cannot disable RAM discard");
-        return -EBUSY;
-    }
     migration_colo_enabled =3D true;
     return 0;
 }
@@ -770,6 +766,20 @@ process_incoming_migration_co(void *opaque)
=20
     assert(mis->from_src_file);
=20
+    if (migrate_colo()) {
+        if (ram_block_discard_disable(true)) {
+            error_setg(&local_err, "COLO: cannot disable RAM discard");
+            goto fail;
+        }
+
+        ret =3D colo_init_ram_cache(&local_err);
+        if (ret) {
+            error_prepend(&local_err, "failed to init colo RAM cache: %d:=
 ",
+                          ret);
+            goto fail;
+        }
+    }
+
     mis->largest_page_size =3D qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bbb4e8f5321114c9919d4619798fed5e..0353ac2d0de819b6547a1f771e=
6a4c3b8fb1e4ef 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2407,19 +2407,7 @@ static int loadvm_process_enable_colo(MigrationInco=
mingState *mis,
                                       Error **errp)
 {
     ERRP_GUARD();
-    int ret;
-
-    ret =3D migration_incoming_enable_colo(errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D colo_init_ram_cache(errp);
-    if (ret) {
-        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
-        migration_incoming_disable_colo();
-    }
-    return ret;
+    return migration_incoming_enable_colo(errp);
 }
=20
 static int loadvm_postcopy_handle_switchover_start(Error **errp)

=2D-=20
2.39.5


