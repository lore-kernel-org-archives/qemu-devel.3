Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BAC5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXq-0000Wf-CE; Fri, 20 Feb 2026 14:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXg-0000UN-Lq
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:00 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXf-0001SP-54
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617109; x=1772221909; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=d/xj+T/ufc21gEx3rq1LBhxpPn04VZcBB37vZqxmD5+CkLEfXVLmFVyI4T74ty+j
 R1C9Z8tKtA4Zi+g94ZF4OJAVONlAfVTu1tKfSB9ialEgg3HugBbVXO17eGYZga2lC
 FW4DOjTN2LoSq1DZwfYQNrOdJEXClsiapOphGy/F6V/m3rQdYzoFVjUrH83EcKPtd
 5D8VZkv1Nki5DAz1jaSVCbbf/gyNm7elMhK0uQ/E10TeSwX1rhAn31tkWRhUjadT/
 wWZFKQx85bIMOF+gPWLRsQXaVqU7D+nfXNQtOzzofT67G9O2pSXA8UkagSbCQ2fPF
 AYQdKbPIesQ59MWfyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LEG-1vhJDM4AC4-0172Ee; Fri, 20
 Feb 2026 20:51:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:29 +0100
Subject: [PATCH v10 07/19] multifd: Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-7-bfe67d422ef1@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOdf3MMiRYhkq0pWLssLHFCgy11wFO2YWuD
 J+MRHzV3puJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WPuyD/0aQT05TB55WmuN4eZUM5c/622b8ZB3biPqeer1gNxfiHHro2enOb6QFFVbP/jCRJfcIaQ
 u6gyY+HVf2EQuasM4JK4oMtB/uJJz9Db6gv6EnFl/JT7rBB7Llg1yaDLYGuiOQGrr2Vv4VrJ+wW
 PbY1XpL0AeMEozpnSTkfj9Jj6aYgqGBOA0Y2nruw5oYJpvIIp3FiiSHhshPwS9YKIPF5Rbb2Scz
 NK9UjHcsXwSEpiipEY8IVK0pjSBbDChPnThYLY1/soguC3OeMysWKymPsDhWMMa+GmVGRGKKtFH
 lI5mv7iphqSr81fMJOegjU0wMpiKTcrm+pwNfsbioQ2TBOYEXosi6j0ImciuXQP6tmNhW+MwhA1
 sSRl6kpje2QjhbBoc9J7SWFtHXOQP0SPEKCqToQOSNT9Rv2ZAwoiIvZFGl6nhEAWRkHHibj+WzA
 x+VPV52gWsKQBoUGM00V/sVYW0GbF9Et4p6MJYTUXI5LrVTqwh7kSEawHzZXx2wKfa4OUDMqtW/
 QpBzdiZNI1DWZMh0xpMIhkjQPOcsRDzL64vFfIN4neHAAufxxMpEme0uhom19q5tZxvNonwG2pO
 4O/rD/XaukC0WZKencFDqHroICs+zXCxw5U+vEVV8UiyhjW7ZbTyajhSiM0qaWDyhXGJHjYGVGz
 mIQSo4PF3PNNkuQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Qtle/r9B3bGwDTtvhrS/c93CjoW1QoKS+2AAZJC2nYMWVAi1o1G
 F+oOs+JbngXR9YxxKIsDfocu0gNVQwfBd6OYqxwauiGA18tfhQUJzkozwrk4Fb+POVYfByA
 AYrB6zHppLDaFlUnCz0Q0qfUt/EdOdc9fJJ9Wj+muKH0BVmN5xYal3QeOTl6WopfIBVsRic
 yXE7rzrCIubJOvf1UgLSw==
UI-OutboundReport: notjunk:1;M01:P0:Z8mcZAXN098=;pF8lRFf7EOYrqNNjyszkOyVuDp/
 gOg8BIE73xc2SRP2mwoqIN1FUVpvA1HiXprbjJvOniQcsztaeGe4ojo9FtvNdDus5ePO919uJ
 4HY+FYQbqzJNM00XtoYMQ5BoxDNY36rE9yw1ceJPFokiUJPY2LClOB/gJWP2vwt+erjyQ1M9V
 r5vm2Ja+8uX7knDuDfB6RqRm1DFm1dWMdAkfqcR/UFbbOOlXwGOvkQ7tQbZVKKlSPzefwJ5pS
 2Ays3SlH2FIJf5tHp1IfFj7QLBfpiGTVB0NV4wTZLvDtW5tf+3MrCUbWoWKx/fm7wF+PL1iAU
 tmfnx+3bVqbtk7qy4/zC+dqXrLnQ1LLeHSo3juEzmeq0zmsYX0FNPUoamFzC/QwI3kjSHCSWj
 LXRQhxs4eQ5Ui9z8YwrLAFF3zIcj5kCQGCt38hxvweVTVHSzn+uhPyix1GVnXzsHeF8bPvvcc
 GBnw6NDDMuDloDzmn7hq0wYL1GSk1NuyUuNYl1hNbBIb75OFbLpqeBa7DbW/YmsXc6DslTlH+
 p1R6W4Ca9A3cmXU3JNoP11kAEgyRxxTYCeYzpaBG/Lyu4If2foG5/w+AGF6wmD42oMUNlhvae
 80d78J/8FBTPpwTayzyYt1jMqipia1GJMbia9z3NQy/pME2b6KHUbHhB0ggaR/JR55ipqwHcZ
 nRXYdZBlJP8hPN2Y4uxM9lUeGtDwFrPnF0N5ODWE+CfiH7S12Tyw3wzMuvUfnYxW2ENnHotGX
 ig6reRMjvczNH+QexfRxmtDeyXmHmeTMWXBIlv8Mq4f5qo+BKs9GUN24QFXBKKLJpeVquctzY
 YAal5N+M4rTNCe51Y+9dq/EHoMADkylip8LCs87YXv0hiS/YqgPyTtT5m/6YiZ8yFjRSaLVX/
 6IFon8Uc1fHCWOMhXmnvsIG3rguxYlNN4AlF9D+MhEYeokQEzK+deBNItIQx7fAMY7ipK2mDD
 3lY/f7wEMbkAz+reEEZZGoZggVOHJUWX9qABH0fM5+/XDv0RYsTjzMlcmxtLj0+3o4pPXrgew
 Az3Z49bTMlicvRGgeBYpvSM9bL4JwAZn2ctY9m/lq+Sp4npya2UYP0Z4yJU7J4kcNnYdAmUPw
 KC4uUyuQX/Syq52Qu6HKjHoDIHQug5dKwTvXh6zEKKUWD25eH1lmkxONdqw8PBcvwcXKViuGr
 uprcQZqNlsxOgNXvCRJrQJ66OHbv44brwKL1O6URni7Yz8mmP6K7rOhJs2f/GtFl0x3F8ZY7q
 UBZeh9S1zXVINyBuqzHPULFd+7x581PCJaTek0FY1zVAihOSa7QzuUSgHozdSTtESG+uzxMXm
 vbgXBbZzMVoY4MKLe5rLQws5VWduuNL8ffY+xjgjnmkqn+D99njfLz3pctutw9DEqdSuNtxRv
 rE5yq1uScgCOha9N1IARC6CAjMhC9XRuVhIGQc3UugPim9mAo1WTCrxUgZGTbMRY4OKV2oWX3
 K5KJGwaJsCQh/sAxacOZwhSmsP5wpbdOqlW6Qzrf7dC6HsLoqAHeL2b262swxQ2Np+Yv7RhFh
 wCkm+sc974RI6nBuEdccnv2ievGZG+MZHNISubcFi7z0ArSfqqooCPUDzZ1Y0cnQNRfUzJA/R
 XiLB2Z9kpfui5m2qm4S68XMAbtwa6W7sfwmnlx1DPuCba7LckgRlPFXm/2NpM+mPxAC2NtCom
 9h52bBh0XpjMzd0otGCfztklltxzlH+WMbMUZ2TCKMKmi7NLo0XU5/uxzdK3NDMDMca1wiOjE
 RDU2GsmXrUSfxyOhaCBUFIcyBXR3HQ2M3NNwsv2nmMaGWj85DRxXZWloHcR3kr1UcauduSlwi
 vt1YsJZq2kwKorTVT4CC9+60kFChoVIuYuuZFoCxzefBQdDb1WlV8PjsTgqVY8mCuVkDCZtlr
 effzUmcG0Pcq2QMNUhXjvDfB6Uc7TFtAQRBBaP0qxz4qS2wWg/KTvddQtYA9TWtDEvRwKHFly
 BnBESFg8HdftEOsQM+gRhOf5asJTW3M5vF7BPgourpSsUqt22z8Ldyrh/2loQqGJVFZHt7Gjb
 KMaiXxq8oNuRy0BOdXWjjJ4LAaN2Mgur+OeLjNeYnhDZAONFqxbjxgzR78aA293DyF7mV4gBV
 FZG4mElVMz0XPzhT/tuqynYH86NSYgFYmuym1rlAOhB2/ZdtYiToo4Ms5kKfWRSC+KOP3iXJw
 EfwJSzv65WOWvSromMJMq7/xQ4Hh4WR4fB3luNl5k4Rfn9mmA9KqElJOLZSxGDA3NWBuATT52
 ZDZAhGgqSah0TD8bVANYGGIe1d8FBrHdqk9gqVoUjBTCsuccSbWxegZSEKzZEgsVH014ZEQ1f
 Ah3bOd7GcTP+WZtch9ex0EMqX6iIUXhvEItlFwfHWwfvQNocljJOyXSsGsHlvkgx4y0lVeI12
 krNBoZzXJ5uVC7omYBB6EasrWspqHNIoKcZj8hvsp8NjKJEhaOs8QHdX6RUKqRXO3hrkG+Kts
 7drLikOuz22TsDzR3m2+NWIVFosz3XwuDReZHgOoOqLtNvwcFdMQLSSgp6bUSYz0pT125OEA3
 HmV4hiWJliI+unphcPizHKW77IpMdtJ2/+GeccBSp3VVRQ/kxmqmDQclnWECCu3wD3QjnPC4g
 HIu75ZlpR6/KylhWP+3ZQXbFWwbXWZi5cMI35dGmp5UzzLmvmq4CJMHif6ncaektpb8piu6hz
 4v0YB2U27T5BbWpyBctLRLAf+SdAcfSulCgCO5dEH+f5t32aQ3BsEyeLLZXsZIOsgs6hhqiaj
 wvtqHLTC0L/p4lUDmwMFDXzbRJNbLL7/khOh2RcYfQF7c0FqZZfdHvAm6vJSz+w1FVz7IrNfj
 Ts+jIHJh0SUggIMXjASTCwH9+pEYYF9FRh3UkVcAw/P+6gRxgHKHFv6+qfdv2fYnVK8As4eHU
 Jx8Izyou2ZQJH97wfHflX1Uiv9pEqVJlJaEF7AEketaw9PkTdXektpvkatKFgmIlPSO6e6UJ9
 o6JOK9HUWjKj5sn1CDw8CyEB7ZEtLlT1homD1oTcDp8XrebIEkNeiTCCFRCkppT3O/hgvuWNc
 o1+3I3fp1+nmEF2WA58I6WNEHuj8H7XM/pZHG5FRs/D+aev1euYOAcRXNhXwBYBTagYCh3B3/
 w4vXOoqJwEdrnxVsT3kVfd4gWBhtutVnJbvuLR8bKo00CLOn5vqWF8RgWTDISX8yJNKyv9LOw
 c76HglqP8210QloMPMcNWExd+tY8147TD64vtqULHranDN87lUa5aMJzeAlvPFqCrqwArfLtL
 Ndf6Ekp/P4MUqLraJBKNzwFW7qPuMcvr3PUEfmsa7fK5Viqe2DxrlusdLW6B6G1ZVI/6N5DhJ
 yYHceK0VRPiGV2AZBJ4jWBRMjDBUdOkRH5YU6upPzblMpY4AuJOZz+WnueB5XYac1nFME6Gqv
 WMrxTAR0kiKce7ErUTZGlx8KhNeTybcF+hiE8tL5/V/LMTZetOryXQ6Esbc5XPhVU1jo7fLay
 xsnUFvSO1uKACTvEU2T1Ov/9tyEwgb38zm89Vo0oRBJtDxctHRCLwn/Nxnr7+3NetF4rJTSBM
 X2PZoOKBug5zt2IrO8QtaJ2yjCyKsxKClwZ1e69V92tkERcZyTGIH2FqA/PvbX32M3dLFoJ9t
 wZwMDyK11ibg/MUgRb0b7BNZmXG0B39XOIN9X9+tCvTBHTBTxpRiUslPvuGeseCp4b+Jbqrxr
 xlgxhQmZcNwa8+CB0zccZ5i73lsbS0cQNz8ygkWIIPPvGl43E4z7hfDtQCYOrwl0WXKVHD+3U
 vyLgSdrmjOsUNaujuH6Rjn4kKphGADCpw7RM3NHP21IDnhduzUBrD0X+jvzCIpX4+RogVEvR/
 FlUco++Wnohl2yWio/FUtVFVvE5oA8JXIcfdhPErcEJ+rJ+b1PF216cXBeJhSxKnjTV3HTZ9p
 pIgB+iGsKK15McaczuENviPHwwOtBGa3OEzi83JZeEDwqm2Wsg2umMvfdgCmu9gPqgn+8lRa7
 t/mwP0gy/A0HhdNfIHvJSCXu/307ETg/Fufub7be2diZ/fYM+i+pfNAJdskaGu4DG0wN0cpbC
 RuaWQF5sY7440g6xlg4KQX1n62kndWrguQ1ibBjT16z2UF7mVw5KjH6CNkbBD+r5dPesYaR13
 8bleLKZ0IBJz9FnYZ9c1iRizexLDh6gHgvKPD3NBmOzeoMtgU9UxqQpLhpljDucuj8SmBEks8
 lUaXbDFz8g3N1WeshInwhEMM6J7GB8dale3zvqBgQJxx7rcFJxmrE4ep0CMKKlNW4fkW684ah
 5Ii/Hp9Vb7Iv8mT0wg5I6F5YryG5zrpgH3ZwJWI/120zM5fSaoXYjrcq/UA9hvG5pusK/lAph
 X6pFGXvlNecK9b5DmyTXjxzu9VJ3q9bVZE4Ojyv+qMCD4pH/v2DqXx16wB1FPqeytYVhl3Kl+
 jpbA3cKdF6qqcm7Bf2FUK1jtlEtp4mRBebfXbKEBel9HF6+zQcxO+3EpU0sOkrW3bgW0IeVay
 r9TVCxdOd5TmfUhreEBque5I81YwoYua6MUn6Wt35B+6BLZ0thHQuI+DLoum/VVBnKxHL/xV6
 pHkpGzaFLpqWvoH3p04DXMqNALfFbCPWXIaamIFMezBHg4k7MAhHhNK9M4CMhe/0JYXOV0A6/
 4TjszICtkBQXSYyco9Ms+dKs4fYXChnd5fSVcrtPeyNVhi/A3t0aXE3UAbLMGL7dOMUn6XSe5
 WsO5QC6FDIW0cSK93WAC0/O6gYjFceG4O1VxgzNbT4woVbpjCWxwz+PeQciHveqM5J3zS7EFz
 SgWavRYdnYPlLynlN+gYBsgKuUINi0HiISzl9FFg4++9gIx8HC6xao1GaYiLV4WlNoNoCP/VJ
 4MBGk0Qd6kisq8SFTpM+yCKBP5+jCialNolFUhHOnEQKKEjYQw1x+REDg1dcSORkvJOP8d0RB
 d7vUZjfEcF0r9ikCs+8bLccGrBzvPewwgjR1lmeX0l5+QWvlIA8fLLIyiJkzJlny7wS7tnjqi
 aZYLMUjAoxMahqKKFAQAh44EeffbNS3DfPGuvRIrASmLXmWul1SlZLyf/xR/Gsu3WVdsePAay
 pf0yHasIpUvwvpleFo40FdkOjqGbxmLE0e4/nRvd/nc4d8tpHnNGj8q+kH2THFn52gKXcGFAr
 3dxDQM2X62nz2MabLk5yd89KWOZS8d/cVMCxBts9QSO4zrQjX9CIkRzDVDwQ==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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

This is in preparation for the next patch.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688fdf98a5c7f4ee9fb80ba2901201a33e..332e6fc58053462419f3171f6c=
320ac37648ef7b 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1253,6 +1253,15 @@ static int multifd_device_state_recv(MultiFDRecvPar=
ams *p, Error **errp)
     return ret;
 }
=20
+static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    int ret;
+
+    ret =3D multifd_recv_state->ops->recv(p, errp);
+
+    return ret;
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MigrationState *s =3D migrate_get_current();
@@ -1387,7 +1396,7 @@ static void *multifd_recv_thread(void *opaque)
                 assert(use_packets);
                 ret =3D multifd_device_state_recv(p, &local_err);
             } else {
-                ret =3D multifd_recv_state->ops->recv(p, &local_err);
+                ret =3D multifd_ram_state_recv(p, &local_err);
             }
             if (ret !=3D 0) {
                 break;

=2D-=20
2.39.5


