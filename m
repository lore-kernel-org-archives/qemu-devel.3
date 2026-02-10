Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8226EA8122
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohj-0005E3-NG; Tue, 10 Feb 2026 09:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohc-00058y-B7
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:56 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpoha-0005ls-QY
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733601; x=1771338401; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KsYqriaHSmD4XHCZXQ7qmbrQv/TGxI1w7u+ZtUQQMhy7f58+NbQQujLQ2jic8iYQ
 wYwSC3SWpdq2hV/dztLduQ9eYqUCU11QswNWFSOPBDvCTnhcdYCj5SZfAW38v5fu3
 rT9D7DHpo0t+YgubUOWHA0ZCdVMs97wVYtl4VKfjJPvxzMuQsXJW/SwQ2bq6RaG32
 n2fg7FRiubaYETgFqDe+iEN8UsvETLOm78xNqpbUXNVmgVxFAWAtMM8lHasYhdJzQ
 1IUloMts4J8lili662Ts59Hd783Yj4MnTSSqozy6zdQ7mcj90r+pIw+hi257Ms9LP
 FZqjqY10RrOqQKo1kA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi537-1vKtrl3SkL-00q4wp; Tue, 10
 Feb 2026 15:26:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:20 +0100
Subject: [PATCH v7 08/18] multifd: Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-8-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Ac8lDvENeYR5YV+y4aqt/AzxcXzIoYJ7L5K
 hE4WXvXmaGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WN42EAC4w4NWJ5+nqQE8VJ6xVf8AK5meVDphLCY1mbEfzEo/M1CkUSa8+kWDe2gn0oyrK/P+XJp
 tOiQJIYiW8r/mn/YhYcPw4leR7yMQomlqBhCYBsy5opBZxliNQM2bGGcvObrg2vnvcv7Ilfva8E
 mZ/oZQm4qtIge0z7BZsKIM3alwHCybehhkXUBx2ZMHihhUJ1Xq/FwtZsYs4okGtz3sG+FQgkAVU
 YSJpUD6K4rlydYcXp3iKFJAw2MSsVAygdTmu5358rDbvFh3EWDV5/uOVPP582Dq9Hh9/F690BDo
 BZ4sbfL9BHdnxcgYNSNqXWPZKeYPfSMU2mGCvx78jn6HKFNefnIC1NaF/OYSNqVqcPRYez4YpYz
 T5Y3b63LfO3ygbbrSMoSn+/KZ1XQ50AI+DjmLP5nG3u/Vpmqyanht9PQhQfRhylVd3f23Vr2P+3
 1MVNdFZlVFTQX8NT1VHmpDqL344MkkzidUMpNwYZ/jlt7R6u17qBm8KEMHW0hDdLh3CWjN1yR/L
 WrrN0u0y7c415cKEeLe1kZpOl0Tjnuv+5zjBgfnxicKM+V2NFPaqEOgOuxoOU5vJsEENNZLyMWK
 TLOOdtPDbAIrTLlsJJSIyMju1V+PSvzhWLWfd4gwmqZ3fwSNtnGlI6ygi+s2QQqSlsQkZefjpWr
 RSeEWYBYj2iUJfA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:hlIvzodC4g3zzJjzfjJbyvBsZm4iLrRQwc62tfi50JbJ7aLCjE1
 NB1vM/4dkRmy/+Vg8j6zWR0utce3saza/LpVgRF5SU9MrttKCtxd+xUvTNKUrFSZ5EMO6F/
 wn7WhGw+hPyIPwBBZUGAltIFKC0gsdzNNfaOiqk0t1lrOBMSRxk2UvHcRMZf7h/TtHd7d0Y
 wJGS6OeEk50BjuAf4BRtw==
UI-OutboundReport: notjunk:1;M01:P0:dcLxNeCPKZQ=;j0rp+XBBkKfRgzyLcQ1HeO3z6O9
 Ig86OV7vwm41dK/7K0nd4p6RSsaG5/iBrizla5H0wurGplZjSlmejJUqjSotyQjaeP4WUyNVg
 on+ry1Bm03Itq4X3NliQS4+NOsj9mwDSoaV4r3TXWhiyo5l9W7yiWix/qILfJr73fPx+1Dmy3
 JKXzH9c0RDiLcaP7snbUDHZvZ1+mNsbbjygXBVdcNBA840nCnijMMqkD8nb9JZKiv7x1lpWnO
 4NrDl7GVKTl4LXEdgF/ZNnKT2cQFzEL64RaF4nuCiNMB4gNM1TfNvOigu7ew0WjEmsB7fLOpc
 nY0dvMeJe/92Tx7HqylEOO+PahhueRoi0LgX90Z9/m8WSWBZqM69YOLFUc4XoZhbSxlamCx+5
 9fu3+ohLlQJZ+tFT5PV2HcehIFgXOG6kOUJ+9eJrLYEAlKFxSAllUMncSGgvkGm/FxKe4SC1o
 RM0KhdUFKyklAbE5clxTgxd2j2mDtce+sarV7RbICai5dQSEWsj3OFSQ7Z3RJ2MrYyEmRvvkn
 G7YIiKG5XYSoQ88MfeXHZH/ehzKxEcWWbLNb74/i3BoihYI/tUCMhpjniwTC5xUQBW4bmm8Eq
 EuiswPdKu/aBRHEGhI5iEZix5H+E7p7TrW1EHd+GLFkwYQWz3QwNKIBiBRohXToAraGJqYCFM
 Fmci+jYd1wVfMcEjiKelKhf3GUF7PGC9wVPIoMGgyiOEsfzux7/K4MbgxayI2GS50iYmFPbrP
 qw5nj5FDzc1H7lzqFCOGuysvyzqXEG6OcSSwfOZd3IQT7m7ZFVUWo90Rd48oMtMUNut+o/zue
 GiFQtFGVg/ArmcK4OXK+A5lSaydlZlGn8zbAOqi3Rtnzt9lN7oHjaYccfyc3uGTOyyU58kQ9b
 8rm0BMI5ohixvSvWset+8t4iI9hZbJN6SwmgTzVU686XbKGHuYdlv4nghgm1UiVKmzU60aA6u
 MUmTTxY/cL4Goa2Y0aKLv1IvaTzAUL5EY1RKLDnAkSRX9yCsTT6XyOcfh9+Ds9T3FLEwEbaFl
 HmpJivcYJYGJ6ZAqmIbX22Tu9dggs2gmVX+psBD4mBdZAeSmSLU2ij2sp3KxWW77My4LtuJtk
 iMmcw8LB2wyWKJuZEcDUprKHNCyVySWTRSovf0deMLR7Udwg3W8bfQ1ylwHzeQ+TYfreIok+K
 j2OSDIsBhoZtPGQpGBA/3KqYXRvnSQHkEfEBjEM06FlEDgw+iVrAZ3ESKAl8dSH598zMNadbC
 it4RNEkxaShT22nO4kA9Aa58AIdHqQLrM4nFDzLjzkmRm0IAu5fX49PUJKMLBUeSfreu56Axt
 eQCo8eGFcOTh8PaY0vdxAWo7PQ3pGWk2QS4hrz/YbyMrE1kTMZV0Wq4zmhUs8kDJY56wrCGvN
 HQ9XgJQ+4WfUsL4FIhokPpBqu31Saq/Pph7PdShaagdXzar4iY5HT7rXmwCu95QYa9k8SSjaZ
 YittI6xY5uzdi+fjvBmUql6E7zUAzLghoQ+d2M1YWrfXe5cvLKBFi5cc1/wlyec2bCzRK293t
 98VjyyfT4xnsx/gQ/t3qP/J35eqiasV/aZDF8NGF/s51W1cYVj7IJ+ThJG0ZvWgdC2OFEkWAw
 wmqVnAnlCw8KuHxMeOkWOcfqFWJqT8+h6GRc2BNnmT3bDOYmW+3zgBMLAgZvKSGJroD03NqdI
 QuGs4/SH9VxMTTdNoCdoqZAoOUsYTTAQ2oauf0TlySWCI9hZYRkVGqoiiYxrGqxB64BSKMT8y
 0UKV8q7MzAEDMVlM67NAfhWypY+Ts6WHL+pL8wov9JbalcMHjIMDSurgoFT8d960sC2VhCg9D
 +47HrCGmP8P//Ixj0jm+oWYtW+BaPgIm06NnlhYK5CFlOn76lEnaRerf6zkqI57DA43UuuVYW
 BoEq6Z4oZt+P+eCiT2/ywAxhP3QZMsU1tuuQ6c7kfE+xHnt5hjVxueH46eOiRfCGhYQtav8Wy
 PHtZ07iXBUqlTTQt5GYurw9Pt43Z7RR2lHgotBQNZGtkMD+/UIXwXrdSyFNgDlm6hBZpTxMWK
 IS55Iu0l7OBKd/nzU+XHpfFaJmw3CW/RQtD6Fd36kl5IphtAK24lw8XpFYMs71St5u6dxXVAh
 xhYuD5AbrRlZrn0q9wG2aRIpeygoKjQ/FPnOKZ3tkKog4Ol4D1H8uyFK57KFAE/4EodmDp6x8
 LAicDHb1JgzlxiTGi7lQwjPbbl454KbGB4aFE0IHtuPKVEyrnMykFDIydfWH7B5x7EoLZYg8n
 EDpIchbYrNUq2FBrZ7TMjr8aDjC1SAjsTqZNhOyrh6jphTeX52WPHkjVL0ZcS64CL5dEvXYVX
 3t5mT+/DQxp4VIc27neTH10IcWbLVakxN9Fx7/NgZQFqMIFmawyioACfLx9m22plBWDg3Q/+x
 sSXZyHSIEJgs+Xvi1qTm2JqkKu55qiyc7sOha54D4vKnjSwIbpWpZl4AQOLCHF6T2otYwqErG
 4QsTEiHffYeDRUmowfRJcHN2oxLeF+L6DbhZ+c7kZ7eM4RpsKqH/0XWMTw0F1QfqskdWRo/pV
 x3P3a+b3v2cWd3fx76q8KZiFki51svrL5OjbkX+tm1Wsb6u3Yqay0Q7NSpX7IlH+rqZbbzY5j
 edj8/xaZPlrdctEZ3oUKDBagFkwdWRMGsNC4Po6cOI8JzVt+MvUgNiZ5T3TxD/IW9OQgeUIXi
 asOm/zoCQaPrujAa7nHRxnO+mMXkKjaafEWIOtdQzaAQhmC8POx9/LLq058zVS3cYUlsDlbj/
 kD2rMx9rwX0Iry53pOZxbLu8Pz2ObgsMgcgu6tnVQH931c6qlvPksqVuG+2+6TsjT5OxF89cS
 zU+ia9vSxNH83fkmspfmpFIN9vj4bIA96WP9CqmiLYJLsuIVRIEzdiDF4d20FUsn6qvj4WD6P
 xBsisFG7j+Q73ddG5oWFxlQgUhQfTIuXDVxhaDLp2wmVRtHfbeljuhcnYLtjeSv9nAq9/TKm8
 8btbBr8MIJZG0gU7WV3NuWrUW2sp6p/WoZx1MP5teNLfytd4o9y6/gxcNAd9ewyPI0z/Th3Xv
 eCD0HpH/9x2Nr5ergzj58Yal2Fy0RNUBsXhmuHGd5/59maoVm6h/DiuIFZT0STpLICSh9yUZC
 oNvFIwVV3+41Q0HG/1MPPtZ3q/ocPqakVnUSs7Px75CSzDc1jIDQkTM1WU6Gsr0Duzc58vJHj
 88XkPVPOhD/I9M6556en7EU9mNyKeuDYFhm6P7gfDg4iLjWtXxNFICAHElKiX07Ed6c7VLLna
 olbrNLUsVlAU7/PdBgINjQrOQGi9oEAiDk0SEX/Q+I6yGMbzCUPO/i/qajuINn8304uzLYvac
 pDCqwG2GiGbWE0fFFSDLb3I1oCKmkrRsg+KCRrbl1hbCtCxvV8QnTEhjsH2OPFvIUT2O+0yjb
 4A+zsUERWp3OEKlWp/x9mZ8F7GR4ZOBmVjiS0RAhwOK5dN7zk0rfw9lnDugGRIPe1YKZx4/sE
 rBqJjuLLscHA+4itPUooPRWfn95AJbvfuBp6uvCTUDDsh+uX4kDgbRMnMKqHkGmMzRPLIr5xf
 HVq3FWA4TBlKjZT+peHqPu+HeVp4v0xt9cfvpxOpHTqP3kBGG9T9hE3Iuet+IZXclKTjF0hst
 gccdVyu5kSOwUNB8c7mPaCoY68pMFt78pMENpcQZMJf0kHQb7WwbctY9+RaJpAstiUCn4gGyO
 acFBgzOD0UjxuYtrs7oWYxWR63kvR6uF24ZU6KM2ZQTGACLcYHOZ21E/l/FWvx0ZdIsNDQ90B
 0nCamBCTOuJ4lKNaAe/faRNyiPvPhkaGJMYdkPAQzY3D7oBt1cCPdzlF6tb4sAQECqwAd5map
 RXGTzHN2mmzx/lUcB4AYFzRzCtQx98VnrcaOVKgDkrOdJNN+dHm64ImSWtx39aF43JVOePBd3
 XH3zXIZ49qzMPhue646EQD/kCAiMXv4dYwfRmN6yM58d+dHKHcA5qrVkfD0RKoFYw1b+KwH8g
 Deh2iF1+epi287pRhS3bGsVEQ2hOS++85fDqxJ6R8LkbUfhi18BrfGL3/tIixbqZXzAaZv4Jy
 Esq2+BAFl6QrmB2zMpY0o8ckCHgjknrujCoAFyHu7nLIdW2YQvdhdutsjFGBeLOEYFxnRt3AJ
 H/sLX3wEYkLY7OQ6wFvBgVesuskMduEb9tv2fKx1wy8NWzv7xD1wijDU2yjyjebUlwie411Rm
 YLb2z199HjOLs+AxODMARTF80e9CX4eS6WjdAtWjyYBRP8vw901HPlNypDQNL6w7jNnMVUqxq
 wf/Nl+DCmbEQxzHTEUr3HLVnEZ5IQrcCzp66ZqPM0uVo2V+ukAISv/aTs8r6o+J/4lMk1jKaF
 dHxAP6oDL1gN8QLcLrtUn3c+gQwUCtKd9Zwe7KFt6RaH7T8FCB+JAHNz1X/8erOC/G4JJKOrs
 AxB8cGEyyvzeILOl9iIULc2xsjoT6wFXrcp/nprBDZbLd5sC51hPPkcftFzwy1gBlUjROCTe8
 UFPbW4IEjAdHTcx/y0kbHiC+j291JEgId6P2yVADdX/LQYv86YTbnzf0beCTGgG2i1STh20v6
 csiPUEdrZUhTB4d1f2SdASKZD8NsASKDWqBchaumiDEP+kbsLrGRTBvlJVC5PEib7WHQj9Dd5
 0kd30xhCmdrmMr8O96a6fiR/z11KfFA/llx13kuuiM7u48W3y8mmWjj2orbGUGttmxY/FIzQ2
 O8oaL6U9AbKcdv7eViC8P9N6g0aDmjoKmaz+Q8hXC1Kury69gD/IteFpMewiqOFDFJnfuk+H2
 UXsFt5/QsiPkCQWhRkwY18FhI0rBHET1zgNSywpvi65wqxCVvbrmYG/lHAdPyum//rW6dnP3A
 qqEJ4jwwppzJ2P1gruBJbPdWv1mopmEIdSz+kvmwUjq+zoDYwYSRnrau9sQmdvWF/uhFAYoHR
 QAeu2jxfg1+5xB7gKSeX3l8fcWqlxApa1KhhkiMQGu5ngWsbDWlaMp9t5mY9fikI1e9uG3rXE
 p8aQMgvG4/N3JwQeKTKBec/D9QzgsNVDgEZ/WMSoNirK2ncYqTyFSpxM2UsWIZfsGKLSosycr
 kThp18SYqCfYdXfEpoM6dAgATM/ztRQropXCcssPDmsHfcbHkklPMNjrFcTr4ncLXhwqoRP7B
 tZ3IkXXvDKTaZsoFndGwTG0LUOjNwq5g75vsRtx1HWq2Dm3uhm+d/kPp2PoM7lIRsKJ7SyW5s
 ZDkzbr/kncrMNuCWzD3r4cX4t1PonvnyVavlPG0OolSnul986ug==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
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


