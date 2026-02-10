Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1536EEA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohj-0005Do-8j; Tue, 10 Feb 2026 09:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohR-00055l-7B
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:47 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohO-0005ip-Hg
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733601; x=1771338401; i=lukasstraub2@web.de;
 bh=EAb9TsMuWPPA3CZIfZr/ezHEKFwjsBr7eMTjDjKG9rc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YnzrhIgPT5lmTv/QYqBPRH929kZkIBgiUJ+UvzQ1XbgoWugXWoNRk8AKMlxfzqLX
 fQTHBQ+ls+wuP7OELDV8WrO7FRkvaJKHXZM6faTnhO/YwjMIsLG0dTqr1pQTQnZAG
 OZPyCS3LVcdS2G3w8keiq+QwgtXy2GZcl6FO83FugBUali0wXtqxSJtnexHAP4UCd
 pOW3Hv3xNUpl1QnBxME+tpsRw0EzDP9w4BQc1r968/udNwQHUhOCYESyEYz6ZgJou
 DZXPxhdjzkTdl/v2zOiWegVQ/iZq9dbHS9YkPK8RfdxzPF6d4yDzCaS4aGpzdducU
 kY+9mQekowCuYfBQXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1w34Er06wC-007uUY; Tue, 10
 Feb 2026 15:26:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:21 +0100
Subject: [PATCH v7 09/18] multifd: Add COLO support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-9-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Abosr+xKE1nTrw2cz/Hd1u4moj2pYzHV7m3+DIZpG0A=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AcRfRJt/Ru42BRI97V9T2XEllQJ+mYK8OgN
 rbTOXlvRgaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WBwnD/9BoPYIGTHA703NY00M1f1NdcZ/GtKpkHPkVxvsTH9z2SZo4FeccSG+3pD1B/0h/+VMqZW
 +prwRwoYEyyS5GGhcXEygjbbIo/U6/Bi9fSUiSlafXLOBJ6h3vP6ibKpaaEk/3ZXHCmvCr+FCV/
 15951eTZr5NlWMeeqfV26JDgAw0l+4ae/0l6/1ibaoUbGef3JbQBnH9cUHipjqTGRqiN42N65mu
 ggvi/2ExM1kEHR4S9iZOqtIcj+HLeNfJ2zCSLt8hSmkflLRrpZxM4Ov9Y1IwkAYU94Q3EyfPxAr
 umhq6wtvST3EQDl9XAH5wxy0X6WRAZYkMbjCHkDK4E0aPVjcV73ZbLHKP7rzAUaT+Y9zS9v2oBk
 dscOJzbuP8u2h+uDnmamSk9JPE+zUyjRJyl5ukOLLa1jYXIF+ZoZUFCWSDkLzwy/f3SJsTEuTfI
 9JeUginFk+CRkoUdo77X6NgSxM+/Z39hM1fBzfag0uLtmweCnZ9YSD4aYaylDIVWjxtS0LwX587
 zMC+CC/ybf0gh9IcfbrvN2jIpZgtYbZGE9v0EWH2xUrVhLLpWKvfh3gIEGVvZlGTBgIi3kQV2b9
 2UJpYMRAjIf5bw9DTpjm9+2BSBfMQ3prtFbMOr95iMr83cmWXVb1acX3Jtdb3MhilRL7VRtLBu5
 2/atPnIEC9sFy3A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:UCxpkXHPJRO+kUhAU09EFDbQ8NK+qv1R+rgD49oPfjeg7pVcYxA
 zcztr8NnjkpJbs7ILkWR67gJ9Ba/DsiougDtycedFyBPdvzNZUtqrTabh+O8w2one117Rid
 cugNBs3l6uPphvmpqECDYPpMgsTVyl1gx3KykESYd8JyoLeNTIRC+wNjkmPFWxf2+855m5h
 xI3AqUarvnWpDI2VUFKXA==
UI-OutboundReport: notjunk:1;M01:P0:i8Cip7sevqY=;jp7S3A23NKIbeaDTZv1KA4q2Oqu
 yopaUl3xMOYIYninmOkCrglj1TTAi9h+Fp/U0/Y/G+F2Eq5nVKHHwIrsqwP5jM4XguF28hxgq
 wZ2MRTD9qypLuJ4hvdpEs7I3Xv+WXcefqO9croLUB5ph/GWKFe+sthQvSQOXOtsTTaP0RJnyg
 3xC1TqXK/sJmqlPipFFLyzrTf+zsNrQZX3rlGQ5cRV8uOC7wwhVPIIad4ESJ5zxjTLbi23Wxz
 mrKMhvjLR52BvVo26tkDmZhI0zWyPWpuLIlJX1a2dmV9sjcAjAdIqPUU9dMNRvvq35y9u/s7w
 x2JNavnVAHhQKXj1N5hmW7k+LA0JQDmLujNdZEx9KCZG7fLNxkgmuxB7bNQrunc2H1CVNpOAD
 KsOto9CDf5u81vkPj+0R546h9911BfpFUFHAB+uWOS+41W7L2BP+oIVbeYE8yGRAaw7twfUnd
 8e3xRuYihXaGl/Mx6amxbrRxER2FoYGSWzkSDzDCR8GeDLoAEg+9pqXsfyEQQqrtiS37zGMyV
 1iAPVrgtlCUjt9rW8mP+HrufZARGQA5aOtpk0EM+jtFeBQmKkSxs8JqxCJaZ4/Njir/Uza3HP
 5IXOde1vm9Q615iN88wdU/V/sq6GHCUBVNhpxxAjDt1QTshjyPdJnnd8LvuvA19olOXB72QGw
 f/CW4VKNDc0901+QvFy88zYJ2hFrh6RMXAkx6nx6DJNGyFXegSHY9oUYOu1dIrmsZqFVdHg1x
 69Hq9S96zf7WATnQlhquapy5jJ0elf5rxryexkLhXHU6aHvxM5ac0N2xhBs8jfPfgbuH0fiVS
 ZTCcSh545pmuN4RhDaM9egqoqlGEwFGUtZX45I+qXE3Dxq5qTNwmb10JeBhxYrG7ILi/BsgZ6
 pkA93hzKht4VoiTI7ZltfvjHOvPj55dpdXukULXlC34vlyOpphcohSc46vuXymuubwXu4mNls
 ErF0P2huY3qaXuKQLx7pyJ5J0XEsx2RO/o2PDFlmoTaxiRN48PXXSJi1ihLaFZ77akM8dfw/h
 abc9IjW9uB251U17e+Sr4dOkdQlBq3xq7vqz0yJzsAu876Gv2vsGLXmYdhjojU/siN9aBxY6Q
 p90qaspBolLiILmGpgt0EjFLkJxbgBiYGrubSoUkY3sVfb44cYtfstFG+gCfPtzxeZJtSP92i
 2bwSAxDAVyw0XG1DZcDrJncsWpYrEoIcbxuxqoCEU/LAqP3bng6ZGOL/b/O2Rj1dLtB/g3cAB
 cqj0Wzal6lAe5gsjYkyS1PL8QFJjDfVBQk1nhKBI8EoDNJp4ylGPXW2xoJ/MQZiho0MB3gkuo
 PVMFsV4IqCSineNwTGu4ce9muAXus35P/wYLC0IOLK1yh9sE2aghvXSJIXs5jyqGcrit0UWQW
 o4+Wy4OWlS70HvjNKfkp/0A5GVkDrGIFYa40uDZan52NZMCiLcmyp2QvxbJdJoKaR8BQTnXM1
 IUSZLCfSIsPCjjHlpJnVPo3QuDdZOKydxdyWnrvN1RuS79Z8r+VD3vQDRvFlS7zP74r+PHsfq
 SOjdI0ba5eatuFApLn+CqNcPO1NgnL0CFRjL2QXXeTAlfXVe2Y7aGCDxOXfk1ZQvUBP++1Wx8
 cmPIRGgHyqr54DZhxyM6UYguzCbqJOltCAMY3fdEFYZXVu0i344X9dVibqdGKlUp2k3/nOF6C
 0XRpW6o+GfhsZKglSUrjv873dmemM0KyCiLaupADVeSOH5uliVgHNEVqDRa2O37O+yfpmSIqQ
 XskIUO2A60iFHOGPW+zG4oFLI4upwUEajFeO32kq4ulSs6adyawjhM6rT+nA6gw6/UhKH+AG4
 58ijE7HXGbit4ho1LpiL1DEn+XBIL170XnpZUPY1FzOousWpDJm69FXyOz8NvxvzJTMioI9aw
 NYqStdOl0ztmOjJMZcR7+m0N6q8MxZZhFJDX8vy5SHOdsPow5u/X3M9GYW6Hrl9wz0+I961tZ
 AUVJqB8ZMEBy7ZI11/ftyGx9DsurQVRD2cHUDECyhZD7gjlAza4NimWGbm41OpsyNc32Z8lNU
 AN6pUEOxo1mIQoMaE7OC8PS7+xIdOmO4t6b7wGzVc/dCclaqC1/r/SsOFM05ORkf4YADIEc5X
 NEOAtiRcM+oGCcbzA46pir07PY2XWnuNk0Z5ngAH6kr4va0W0eiQHwQwLMKgfM4UFZ/G0V3cF
 Ln0s+/2xS+vTmhHc75WnbRipVxwWU66HAlPCq0HRx3jr1oZuJL+XOknn5ZH7k/EGS6lbzxWGk
 qQfjvVXp8FoKRN4iw8EbOxKjHjz4lwzyYs1D+TahWmtCsYVq2eUU2HVw5h8XBqFPrLoSv2O5S
 2ZiMNSwDyC9iLqTc71jRs1LEu6iBcBPN94/upJ7GsStZm5q0iMbD7s3wRlKd7acEYZKQklnjr
 yOonhJJhTw4NoC2okhMoYPZlJz3s0qnFA98cZreMDw8gddhtXQzWTVNO2ezMknW2h0kZ8grE+
 SPpUIbSmpLbGvF3j/jQcJQYALbJxf82En9VuG5Dl9YSIvYNBH8yrMUw9YkA/dUEsusI2WP5+4
 eGjstN0AGnTMo9W/4NWCK3+HOMoqUflMvPvkCJKR4Vx+Zfc+hPg0PJQ8w7U61hwDYUpZNLfiR
 Zm2AnmuHiGMbvMFSZaW2h83Oi34HT/bQ63b7BK9KQueDgVPZR0B2gt0yNZ30eWSGUA+jLCWVW
 ZHiD5uXxQO/XGKJxIvel8ikoRrD39+afzkAi479gv+WitJ3K1QYnVgrZdFSFnJUHIJANuzJkV
 ze5UCxbHS7gBohZuvhcaPT2ttEl/VTrc/FGDwE9Y78u+lRfDC5Vi0LSbBMzuIRBJSl0+5MZA3
 aa4OH4IX2m890KmkjqC3SHzNsGneKbVmXsAItxL+9VwbB3DiG0UlTHzX+GeAXJtcHwBCTztCR
 p7bWl+KYTVpXodELcNIsDhz6fKP9j1NPaLeWoHS1LDCpt4hEj8BWTQMZ/VBJxd00iQakKjMlz
 DODW0jPpTM28US7xvxGUvUmH3motWdq+TyO3c5lQMuDeeZGfA7xUpWADJxMDxYhhuKEWF1gyK
 Q14/yfnoVezwkyS7xgOnstXc4iqhpTvbSPCUXmNCk3MJUjTWa5t7nUKa7mIpojAScwQVzcb+8
 6xrw7XyTBOvM7FfaTurpsK9Mlb5oGq90YNpPezTAJLPLsdkk5dpJy8QSMIK8ui3STQlERQgV2
 7rCbVTgxXvFBCn9BxqblR/y/vBRIqMmuDzg6HdIuXDaq006ZAj60XjBfq662NQeWZYs6MqFMr
 gh7cTLUCvOM/39WJrB6BeLpruxolD/aSW5OcFM+eRQqanGU02zu6ZiothEkON8CNUAwa9Bx24
 00xV2cQRzgNffnBnmV+y3dCet+CYJ+5Q4gcpaPHvwmUlJoz1XytXYjzLthYSsCebd7UO+RRG5
 9X2Fff5+NhdTnEOZX9Gd3u8lDgCZyLAbEf1F48dB+giCE8ZfpPlSD9QaeNF39DvyXJDB6ms4s
 ffL+ZzPBOq4pD9UK/GZZCmddaC0ifW0hoFtWd87vffUNbNEwQdgnbQyujAsFK2kJ+OSlscgN8
 PMnDTBqSMXxo2b6YalmTy6mKSxSH5ALCYL0e5+MoOwfEmcyzDBu88Y1VnWdJgu59aXjZJgC2Y
 cpOmU9rrA9uOHwTUHkNFOKOuMLDH6an/GcEOYpHL63Crxaqxm/gh4P75VY/gq8IZB/3XYV6pt
 HRWTXWmotReOX1Xoz4lpKapclPujy1bpDPZfOZKiDm+icsx4iS0E/d3nCZ0OxQmwsvaXKJro2
 5KEmuEcL4HA/fA1LzaH0vKgl8KtYyMeg8CJXnMrf4OfB2lsQJ2KtCKF+YRsxKj097RM5BXK7W
 cVZG4JZrRK0cFmqzTmNG2STEMqJxglFHCpRMZM3fiWDzruyHIqkIsZLnvKpp83oAUroYGlk4e
 Vh5ccJVVW67cJHhE2pTD06iQ6zcYEBxTDBaAneYd2fwktyK8w1xbdsga6ijrf6O6yc2ouhc1O
 Req2QpcMrQLtw4Bj0+X4/VRbX6QV/tm1aYcLr3YNr47ue1S5Y0HRP/+ikMMJCKtHkAK/2EMdh
 16TMnMjrGapejrcwbhOMIlI4Ln0PBFhEt5W5VD/OB/QmA9uovjZmnFxMLuWgkbrAt0JUf03nx
 JL83J9b+qjCfzQjcX3o92Q9mfGME2kBuuV2OVPe/TI+OqMiwL2IgwP+o+a6KArnH9GburQLk5
 z2Dp19KsCYEGXNGaFtaT69wmOGMidwmzI7gEh8u2ye0+XYEd5kK4K813Pdd+thowaHq9zL/Ru
 aKyriDf6XkBApjqY8qvYwb6BkCNCwm/HtHMer7qyAvlGnuWLrC6GJIlYG15zGVlFbk99PqqXU
 RN0642n/0vPv9KtzfRg/+zv4UmumssRRb4Bs5FEJKNSrXc48XHtVfUGH8PpaGZ3QJFwfHGUCH
 1L21F9YabJ8AhQ3bb6FOIZIEIzKMDx8JVQtgYGDDsqzW613Lm2/ASeYzDOw9GAJP6RIeVd6qI
 y/+Oe5h2C/0M4zYeW1lxcnc5YhZ6TKi3loyO0lqqxU23g3KbPMFcJZsYgHzpgDX2LLfzHaQ2/
 XJIyrzUtkMIB3EgpOA16ZHztPG7wXSvK2/yDz3XTDG64zLC6Wf54kl31/Zl0t70nyuD1J2hkG
 DDVbb6yWIdxVA/e2+XcJz1Y8T+5yYCNcpezqfrddO/wCsB57aGRmih5H+Ef2gzm8l2pupgZ70
 92sZyp5QknTfkFgotx9qbTx0ylbGX1kkTBK4dB3xVbbWE1g8p09e3FJ5w5ASnIihZQFiEEbhk
 s32QSAoJ/0zlKrQM3suS7RnxutocZ8sJ2g8F6K6sa5+fBbvtQ0jn1kkX91h8ZZWlm3nt/K0dx
 eCgDiKM+DnYsBfaBz+r81TfNP/bCFcilP1badOv+EsAzR9P5gbfFYTZvKtwOOqzeiBIMF0W2v
 6CL/3qkHonxDQLsnFpk+5Nr7Qsfs0byHzvrbNx+TNOLItKjeyFW/y5Epiw4rP2FdqhH8+7h8d
 sh+jrNdrUfYTRCrEqE/7E0Qd7q3wY6woKDCzEbWhrk4eUJ6dTvSqLvkl7K4CHVxG3pustWOxZ
 U5nzEGEjGoDejLykRk6AQj6U+crc3i53GHkssUtnDGOvtgqmhWrBIL8bL3PhWoW+ErmVLps51
 NE8cXQR/IMPBkNz4S0uDSJFym8LkAR5xmINH4k+9EKq2CMHoaPaQgWU0JhIh0vkXGOzS/gcxH
 rVngFpPU=
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

Like in the normal ram_load() path, put the received pages into the
colo cache and mark the pages in the bitmap so that they will be
flushed to the guest later.

Multifd with COLO is useful to reduce the VM pause time during checkpointi=
ng
for latency sensitive workloads. In such workloads the worst-case latency
is especially important.

Also, this is already worth it for the precopy phase as it helps with
converging. Moreover, multifd migration is the preferred way to do migrati=
on
nowadays and this allows to use multifd compression with COLO.

Benchmark:
Cluster nodes
 - Intel Xenon E5-2630 v3
 - 48Gb RAM
 - 10G Ethernet
Guest
 - Windows Server 2016
 - 6Gb RAM
 - 4 cores
Workload
 - Upload a file to the guest with SMB to simulate moderate
   memory dirtying
 - Measure the memory transfer time portion of each checkpoint
 - 600ms COLO checkpoint interval

Results
Plain
 idle mean: 4.50ms 99per: 10.33ms
 load mean: 24.30ms 99per: 78.05ms
Multifd-4
 idle mean: 6.48ms 99per: 10.41ms
 load mean: 14.12ms 99per: 31.27ms

Evaluation
While multifd has slightly higher latency when the guest idles, it is
10ms faster under load and more importantly it's worst case latency is
less than 1/2 of plain under load as can be seen in the 99. Percentile.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS                |  1 +
 migration/meson.build      |  2 +-
 migration/multifd-colo.c   | 44 +++++++++++++++++++++++++++++++++++++++++=
+++
 migration/multifd-colo.h   | 26 ++++++++++++++++++++++++++
 migration/multifd-nocomp.c | 10 +++++++++-
 migration/multifd.c        |  8 ++++++++
 migration/multifd.h        |  5 ++++-
 7 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 356e3a7889f9ab45f002f165112322e6fb5a1967..e6e711ac8a333bb9bfa0d75c2c=
42dbe74b8523f2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3859,6 +3859,7 @@ COLO Framework
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
+F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
 F: docs/COLO-FT.txt
diff --git a/migration/meson.build b/migration/meson.build
index c7f39bdb55239ecb0e775c77b90a1aa9e6a4a9ce..c9f0f5f9f2137536497e53e960=
ce70654ad1b394 100644
=2D-- a/migration/meson.build
+++ b/migration/meson.build
@@ -39,7 +39,7 @@ system_ss.add(files(
 ), gnutls, zlib)
=20
 if get_option('replication').allowed()
-  system_ss.add(files('colo-failover.c', 'colo.c'))
+  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
 else
   system_ss.add(files('colo-stubs.c'))
 endif
diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
new file mode 100644
index 0000000000000000000000000000000000000000..f160c6543414d3e157a444d613=
c96df4c5f0e602
=2D-- /dev/null
+++ b/migration/multifd-colo.c
@@ -0,0 +1,44 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * multifd colo implementation
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "multifd.h"
+#include "multifd-colo.h"
+#include "migration/colo.h"
+#include "system/ramblock.h"
+
+void multifd_colo_prepare_recv(MultiFDRecvParams *p)
+{
+    /*
+     * While we're still in precopy state (not yet in colo state), we cop=
y
+     * received pages to both guest and cache. No need to set dirty bits,
+     * since guest and cache memory are in sync.
+     */
+    if (migration_incoming_in_colo_state()) {
+        colo_record_bitmap(p->block, p->normal, p->normal_num);
+        colo_record_bitmap(p->block, p->zero, p->zero_num);
+    }
+}
+
+void multifd_colo_process_recv(MultiFDRecvParams *p)
+{
+    if (!migration_incoming_in_colo_state()) {
+        for (int i =3D 0; i < p->normal_num; i++) {
+            void *guest =3D p->block->host + p->normal[i];
+            void *cache =3D p->host + p->normal[i];
+            memcpy(guest, cache, multifd_ram_page_size());
+        }
+        for (int i =3D 0; i < p->zero_num; i++) {
+            void *guest =3D p->block->host + p->zero[i];
+            memset(guest, 0, multifd_ram_page_size());
+        }
+    }
+}
diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
new file mode 100644
index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de52f=
9d57a337d4754a
=2D-- /dev/null
+++ b/migration/multifd-colo.h
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * multifd colo header
+ *
+ * Copyright (c) Lukas Straub <lukasstraub2@web.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
+#define QEMU_MIGRATION_MULTIFD_COLO_H
+
+#ifdef CONFIG_REPLICATION
+
+void multifd_colo_prepare_recv(MultiFDRecvParams *p);
+void multifd_colo_process_recv(MultiFDRecvParams *p);
+
+#else
+
+static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
+static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
+
+#endif
+#endif
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b35f=
464103a61787f0 100644
=2D-- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -16,6 +16,7 @@
 #include "file.h"
 #include "migration-stats.h"
 #include "multifd.h"
+#include "multifd-colo.h"
 #include "options.h"
 #include "migration.h"
 #include "qapi/error.h"
@@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Er=
ror **errp)
         return -1;
     }
=20
-    p->host =3D p->block->host;
     for (i =3D 0; i < p->normal_num; i++) {
         uint64_t offset =3D be64_to_cpu(packet->offset[i]);
=20
@@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, E=
rror **errp)
         p->zero[i] =3D offset;
     }
=20
+    if (migrate_colo()) {
+        multifd_colo_prepare_recv(p);
+        assert(p->block->colo_cache);
+        p->host =3D p->block->colo_cache;
+    } else {
+        p->host =3D p->block->host;
+    }
+
     return 0;
 }
=20
diff --git a/migration/multifd.c b/migration/multifd.c
index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4baa06=
9dd252c8ad293c 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -29,6 +29,7 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
+#include "multifd-colo.h"
 #include "options.h"
 #include "qemu/yank.h"
 #include "io/channel-file.h"
@@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvParams=
 *p, Error **errp)
     int ret;
=20
     ret =3D multifd_recv_state->ops->recv(p, errp);
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    if (migrate_colo()) {
+        multifd_colo_process_recv(p);
+    }
=20
     return ret;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92bae=
d35994f5967c2b 100644
=2D-- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -279,7 +279,10 @@ typedef struct {
     uint64_t packets_recved;
     /* ramblock */
     RAMBlock *block;
-    /* ramblock host address */
+    /*
+     * Normally, it points to ramblock's host address.  When COLO
+     * is enabled, it points to the mirror cache for the ramblock.
+     */
     uint8_t *host;
     /* buffers to recv */
     struct iovec *iov;

=2D-=20
2.39.5


