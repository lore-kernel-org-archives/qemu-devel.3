Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388F1C5AC80
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 04:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsv5v-0002Eh-K1; Sun, 09 Aug 2026 00:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianbiere@gmx.de>)
 id 1wstlD-0003Vc-It; Sat, 08 Aug 2026 22:59:39 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianbiere@gmx.de>)
 id 1wstlB-0005LF-Gh; Sat, 08 Aug 2026 22:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786244365; x=1786849165; i=christianbiere@gmx.de;
 bh=pikJSl5bld7wjAQh5+9L/UCBZADUQwr7J8vhJtLZqZM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Message-ID:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ONjz/u42NtuCezn2uoFiDbwhtfTimRfcSk86u6ccbJ+tv1tuzNECKQOAQfpX2CQU
 sn107LbmtIEdTnzgSsBoDIR9HQ3FyTojX42yo0bfdxQ2EMVmme6pj41nMByIU/Ra3
 Y7R1/Mdq/1bdNRm4j6LbmI1aSR66SgE3hBilAe9oB85CCBDtdwk1IsNY00DHpK77J
 95Kw8bAOvq/vE2JHKVAmhJP6tKSJOsekIysiHuFMM7BbWoU9GuPEtYfov3juF7PY3
 dc8mAEqBAdrIPLSbgAuSGf2sPr7ZZ0cw6h4yYVCFcL/1DDwDELSMZqB+3svoDAItd
 Wqlh0h7p1yVyI+xW+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MN5eR-1wZqno00Ll-00PyFc; Sun, 09
 Aug 2026 04:59:25 +0200
Date: Sun, 9 Aug 2026 04:59:22 +0200
From: Christian Biere <christianbiere@gmx.de>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <3ffcd2c2-5904-4304-8fa6-ed970da0bc03@gmx.de>
Subject: [PATCH qemu] block: Stricter checks of VMDK descriptors but allow
 unquoted createdType
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3ffcd2c2-5904-4304-8fa6-ed970da0bc03@gmx.de>
X-Provags-ID: V03:K1:RXDDWAe6O+3ArmD7OYhsXF2gfqHHg5GCsYHE1tsc8YyrCqYRrjc
 bR60G7qBEn9cWNLADBcCVe6vm2rC0Y4W4ioS1WZlVWMshYwqbDz+pnLUa/udvPJQpEcXIlj
 HZANImKxexfsD5kWoVvgNLGwyKyL1BrKj+XTG6hCOUzwv0jAa4O/5vd/yCR9okwp+oQ9Uxb
 mrvIyHggQ76b340ysRcug==
UI-OutboundReport: notjunk:1;M01:P0:BnYkLMVq3GY=;ylnFhx3W8+fbmcB3yvMsEuUd/K3
 zknszHwz7B2TcLU0LNt0051qhkX4HCS9n65swU4Qhi2H3spu0bTUqDQ133pnUnxyAVuItbYtr
 NIGMWMDx+pNkAfEIOW1OlIxIPoHVn+5N0fYbj1NPaazFYY7Ynrot3jSeytqpSM0zp0IW2MQhe
 cgsHPzycF9V/vTyOyV5TH9RYj8k/GQLSKxMMUeZhsJFkf6YSPAyotb/0KzAeQ17xX/KUSQlcR
 VBNf73zcrwWAAFvfXj8vjNZ/xP4vPI+GKukQeNT1QGGodpTJysZY8M7H2ywTWe0Ztm8+pu3Ob
 BBZ5CEaKOEPRq8UzJEAm2JYBqmNaxAvDmCXlPin7aAakUuAKGYORCDbf4GzYxRekdOS4zDQjT
 TKZAesTfiZ6PfKFNjJ0RNvp/dcSrOaisGqPBwp+YF9h5PM98DhMS2uamUqB5oB1K3GIC95zyP
 HewYYOEFagJ6yW8hZdM77LFJndWhJn+8UV4BYqXnkFLJtqyZjyVGpmF+0XV/DztFknzVDluhc
 7gG75eE8JvKyOja+t+XG/arcEdg2lCTlbXzuoufTMz1g4wXmpP5V8AwpKChzM3DQn1hnHnk+u
 /QCqWGIG8fgVvJVXs3e/h8P/YBujO8JbzLq4HTnMLvjJ/P1Y1+79GUHRHnETooPHV2w7kxcyw
 47+UzNIo83xlHqJeYEEDDrELgiOvEq0/L3JwWybrXWQ0QMuqnmfAzLLy76mGDg7J1SlrGvO1H
 eM3cNmNpdsfttoLIQP+RuDmpFKAaakbwWje/QP2RpubC88S7fHD17PzcnUXA1ONjc5hqZmPbK
 mWr7eoFFQm6Y/Kn9bNscNVjgn9WU2QsjhmRZWj0L/qvNsLFhraKpmKjVeWhXXtLrMcdO6G5Uw
 P3P/SNSdxxeAMKwWdmCCI2kTMPtuBsNaOkufvF5bHDzoMjkb79tT07HRg9x3eMuqYX9xSpL0/
 cjftGclfbAy7Ez2lVkUPy93hjyRPBEBoEPUpbo78aotBRcZ0Q2YrC7H/9PXnX/4rqiCQnDAaQ
 1HaC2/io4XzihA3q5oxAiOvy9AvZxHRni8kNz/ShJ66NWbm+29t/gGBx7ZhgbzzIeRwYNQdsb
 t4RsgLAgmxafHzyijHgkoh1P9qWGflpMtSPEVuq/3hNJnhEwM9l1/eqjJOTQx7YpvZHayFv1T
 z8s/VsgkihDUasFV36xeCRzQi/CjNb81hvkx0Lq77M3Kz1w0s2aAld/59enLqwC0vp6nC0I7/
 6NE68QfwVawz/e8KfhYTYL/FdtvYkC0+F2Y9Hlx4CkzVH4PNA0VzrpmVv3Hqp+ljxijziORh2
 LteS2Yw8usf22fq4ugnjw4SZTR6OMPVK6JJKAqR/oV4pyvZmdtkWbMH7h//vJEpULxsuv/6t7
 PGNUyMqcLF/wEY2rIFPacolfx1wFvBAkmPCu731FFeiCK4X215IwzLTcoNXfmrX7B0p06nCEd
 Z31qZT9KDhOsyGb/0r7XJ8bCShC1aivHJKSq2CZgUdLyFXGA+8GipOr+beyyWo9krNHzNznqI
 7JJLRYl6fQaxeLq5S9El2AO6/j+wO5WkWwWGSwzYABDvQo+KI4e6nl8+wz9h3WQ/02rbdZ3qQ
 fSfqxtG2ghviv8vKhoX5nZxVYCY27xbGgphUiwI73FWjdXi1iyi78+STH9PV1hT039a/KQUIJ
 72Z7d2ZFdjJPVdQNuw4WLklgpf4OMp3M/UmTx5IgWvlJAwcvkLFogq7pYKxUJppDK6nQOTL1E
 OnbhDtqcKEp5G/65OgLbWgGXWywjOmAQU6F9JArd/ccRvMctfIldYzAFz6HFKwBq2dSnReXP0
 KSH47HICGP7EuHUW3Jt+Uw9JFXkDwONKYK3fva3EWIPw+TwXLnPdiQYM3g45J3eHffSHR29ln
 tJVarJUURNSl1DqjdLxMTiLSyOIIfFNy57Yb6OjST7K7WwwVPkOK4usxU4DvxfxxbGv8rjsTb
 tNr5gAjSxJw40HzYZtBITJe4dGURBIOxulmp289kgyHqZ8LFmNh07W2f6gQ4k5snThzrSpO7R
 3C6oVZvNIEKIkiH1zhaJpp4AIvgzeSW4EKxu4rZ0copMYAKhbLnUOnfHbp3hpS3YRi6Jptl9v
 AEGsh3v0Mxa2urCvS3v6ruzJcnnBLYfBmw7MJLZ6hYJU+obrW2JKmyiNgsKQww+En1nldiQu7
 rC6EX27KK2om6m3/6Mn4+bqr6njtNRQspX8sW+hdRZZhfypsXfOG39nwDvjRvbkXuWhn7PMjn
 hq/iePyOmF+Y6/9P1lT+sIkNQcANGaogt2dUV1JduAGG+LU091NADl6BJ9F1jFLva3u/xyCUq
 wSTwWeaguMDVA6PAmqK3N0H9T8VN9VMYjP9r85Kzv6FhIjZyl+Eers6GieY5v+zh1K8R6WJgP
 +CUjhCvzhOxYFjwgZX7tHJqKl/Yt1+5zoVEUNQCCIOLvhC3yEudkKihoIdVCH7eb2Gi+mBjP9
 Dt3iAGH3PPbWUNfFdfcTbclrncFOAFjXqEoHxEjvon0qhy6ws8EpIufOQjakSnRlbbZ4Gv83w
 lfr+w+LHTov0/krQbWaFkjB8fabDvq0iIUyxYPs78OO7iTHca+JwdSZ1bpTlqXhmbYSRZVXKe
 uKrWCCo/QYuL7RQfji/2+CLxEafQsum5vrTNrVuwjfkn7geG5aBrCRVpF3VBm3qMAlUYEHN1P
 LA7N+IFBvNPJH4ygAUHjF36PAMG1dwMolWKf7aFzJFkG2bHoiP2H1r/o6nhQ8x2FWN+LKjbxd
 YTL8ESXcykiN2E9wFAbXYM9d30/45xB0SYe8S/BYvpgV4QuONDlXsDeXPVFquS17WZxjrUwln
 ve2FFCqjMFYUF3wxPHEoOjGp+fhxL+jmu3dvBZAq2f6B46dja1++lIhMOeddQZE7cEl/CWheJ
 2VulIPlGbS8NBUb6rJutXztGHQtAeDm8BuvOxzglCrGA1F8Zcku5ku4KFHyw8kE6S2gsaaj6P
 V00bYQJhTWSxsBjsUenZp9x7FKzk4Pq3U+EXkdFthdGeCXNTx93zMN5woC4IzFWN8KiBUVfGC
 UHthN3FaOdq4DKNYF2ukDc2SbNVdmac9XOJJ2sQcnRWvGlcVjI7639i+o+D1gdoxQY+HLf+Ns
 g7tbHFpYiAQAnXr1OCoV5nhQnYPFTeiT1Vwr3Ui3m/aPbEGlhJ+JlQRD0TlXInlfVXVgL3IM/
 dUINHWUCLb1nQcp7LbDlnY9AVbmy/Xwnn8tBXfNCWZmeF8VCl6VJhUOkKScQHBr5g1SAvqhw6
 yAbzUWZlb8Epj3E2jDssbHr+kVhEyZUdrXZ9501oT2iaihn5u8yYeQQVES33lu9eMu75yv13H
 qmDOS/rHZ1OPYRSu9CpxRTuClQhI0KpsD8pS6pHnK7sUM3zy7paD1AD1vAA7stnYmMo7XyA4w
 OJ4ov+96kMz1yuU9BLKES1zgI8/3mtanMtnwOmNSvmGB2BpJZKtSDbMGrdkOzcpeLhnsFoJzj
 sK6925e17kdLRe6uyR48uDOr69QTn8fEuoHceIQ+UKY0OLzjo8m9/gMG7vrdcKY579XuTMCem
 NdSRMbs28lksDHvqgHGjwngj3Kk5RAqzTm3PfqLhV8UHmGwA7tsCKj2ubU/QHrxFSsWRfaFEi
 mTRIWkLtyMk+LxYdk/pLC26mIwZbFYA/9uY/ElZioUqto3kVpF9nJ2Wv2cR02JLJj83Qtgq3u
 5A9Hw0s1Ri5FiJiUhI5flLHdmUYQg1b0EHTLzJzkaKg0xyK8Ll819K6or22+wZ6gxPI9F7u+D
 /vvnd4kk4GJOXeZYeB97NXn6JHEEXoL/ycz9r1QrIg60w6sYxnWHOOyTp5fj144YyHSf7YFO1
 PmXLtGPfuqVXl5Cfnk7k5rq/Sr7CsyI/e0JrX5X0C0XqqSqVeetu0PrVE6Gnn/5dK5WEGDytr
 KBvBEYuf7Q4BXUOWaRoDC2roOrV6JOwsMb/yF4UXHLS+CnmGpotQv+pVUKzbZJVRY6ao8ChaB
 66pMhrfZWEPMW34Ct8eT0wHQTUg4sJ03kax6lBFIt7n+W6pvq6aRvbhgrn+7l7uxTWicKfYXe
 UXkzM3qrgjsUgiDMT0qjx8BpA4VpvYS5E+VhkxFPkTfLj1cKiqKXYk3sHjbmvjDxYv3iBSg6M
 SdvE3S7mKK2pY9HlncbE3dicvgo2Tbg3xgsInZbcX+Oz+/yhs13m+3S4JW5M8vosZBF7f2seQ
 zHjaiqazpr//O/dRsW9HcAuDj7Zlj+v53sO2TwY9/5cc7RGl0E5us/YSSDeuNABtjL+Dm5s5d
 u+kTRxJyLpIVfShOI06Ksp5D5a1+F3XCFf0LUi/9Zj4l1GDTfenLA14sIJjw4MjmUkxcmPujn
 x30qzVQzIHwomJ6vFAJSO9m2kmgd2m5G6cP6Y7X595zxIw70FvV1OBDha057NC7foALicnwUq
 5QwgaYsadssuyrU7OvZwMHBjVjMA1MlzWsp+oP0pLZztfEoERYzeRXD6RMmUHww9lEA0iLORR
 n/SNB79lv6Ui52SfTyveTo01uvka7zk+pVXCps49lafckDpyJ7Y2488fIZLDuDcKZN6iRMMYl
 RbGll9kCsZv5P0f8+eRvYKvXPTVYR5UQZLYrPgmBYXz8FKSrAqmw4AKqVlIJ16rO891UAOb77
 KMy2U25/HhF+nqfHiCgyyUhp+at3dmGzm25PfOdQatSNLV2PTrdwSEhKUD8uFihCEzS5FNzGy
 nf4szQCjPVyf7ZkYe1KdzfK0LdDiW3LBuMd9vfZfLLkw2tFp7OVjR5hC+YifhWPgHDwdChpHh
 GChOn2uM8YFq24Tj3Z0BgNd/oZoE/jxzSEzdkVEa3G3ZRa9AYgXEpAjwmlY3abM1FWz1peUdM
 qx2odcrrJa44M5AO7UxRbVdxdTDTkDnL/fU7MryneEZuqw8bV8xwHKYflFgl4lRzfxOOO/lFr
 MP9y5mbFTT4/NHqcbYvH1ImcYqqQ7z35DaqUmG+pOXsKLb8CNFqZNIU1BvKn3vJSZS9W3dl3J
 RoTOhY9xcaSZT+Ijp/J+Z/pYEzzVdVnKA/hcCa77yBWybZihWYbGCnpnURPoqvlL4GGPczUbQ
 heUBu6Epc6DokGSNxpd/+9bqTCYnxeDDJ7U2y8As2Q5S5elN0f4SZFrfImYaot7wDJSgjolQs
 2mnijcSF/YSXGhD8apXCnfHaDcu+1BQqSjUUfdCV/Mp53krdqNnz1thZBESacCikU8+H9Uyth
 Y1D88tedI9lKkY+U/sTAMwGR8qL5JUZuLcKouJqhoF5H8QMOOi1FkomFIHF64AKMwUULc7vGg
 ekX2MoH3iW/Qty/TfnPKd6aVRd8r/isnV9qBh8/9MrtNLRQ1FESMkbfq+x/qhzo2ARwi6QGeO
 JwbUwjNYwOyCZY85+FcEXqVbq01Z/FtPN0AbWXi9Ej59sYnhlrm+iWBXq9gjra9mkzAEzmvpK
 nAkvZUdlARZk/XzHls6uCZ8AKt1RGeTl8qiVMNqryOzrVwq6dADsIjZ1Cy4mMUbPTVjDgCyeO
 yxMe2VdU/HF93VocahLnnZrD9nkjNdY3whqkWkBavA5X0MnU7rmKB5MDy0j3qfgKF4gMp0uMt
 96hUkYYIbo9oT9fPestFhBXCSb//DDFCAXgpnyfOUXrYOwajeNhDHJr1hJX0hgGolsdjW0kmP
 7BXBSm7Dw+X6FZr/WMUybBN+CIgzeXx0r709BDgX1HmSkgGKlbBUNCbu/8VRbgAP1NX7SF2uL
 EaRtNIQOcXDk2JgKjjO9LKZ5G2L3CN83+040cjdgt17hlDJdKs4zGl8mD4C2Cmbis5pa3Tbon
 doB8y59o7pBfO5vGNKnxqIczWyoMfKC/ZBXXaWugDi+0r8o0gEbwHaKxBvuZDwYuVJ9iqS3ML
 0PJSXqAl/7TQrZpf3XuGp+AZUet5rtxHtxH/6Wb3DMiiBKnVXLEcJBj81ZwIBGWcDRBOMwG1W
 GU6StmwxQZg9nu7x/gYZUeKpL7qEYhn8++7Wqr/f8V7+So/XiMEcsGVPxzYu6H1Roo2GNG6U7
 Fp7CfVROs3ZJ4KK7pXml5DfsBtX7z5PcyF9UfPm4yX9nkLT6i54p8nd5rcxhQGqWavI+2N46c
 SLAnAolNeX6C77cEzziecfAZwEA6V4BvQyDca7fHgrUtZUVhSWx3VPOEk6MCs5+hdCip5QtGC
 sknR4jzoWg0kwfDIGLl/oCEtB/o6+Tg62Nm511kUVoisaAC06hNJj4KDqW248I/b0VBwTM84t
 lF58n7qL78=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=christianbiere@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Aug 2026 00:25:04 -0400
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

Veeam, for example, creates VMDK exports where the line declaring the=20
createType property isn't surrounded by double-quotes. The resulting=20
error message is cryptic but indicates that the parser of qemu-img=20
doesn't check if createType is follow by a '=3D' character but just skips=
=20
over it, the same goes for the initial quote. The patch adds checks for=20
the '=3D' character for all properties but relaxes the requirement to quote=
=20
the value of createType. I came across this due to a post in the Proxmox=20
forum where the issue was reported 10 years ago before.

https://forum.proxmox.com/threads/import-disk-vmdk-qcow2-unsupported-image-=
type-onolithicflat.135903/

Signed-off-by: Christian Biere <christianbiere@gmx.de>
diff --git a/block/vmdk.c b/block/vmdk.c
index cd8b4ec7c8..8153e007b9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -305,7 +305,6 @@ vmdk_read_cid(BlockDriverState *bs, int parent,=20
uint32_t *pcid)
=C2=A0=C2=A0=C2=A0=C2=A0 char *desc;
=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t cid;
=C2=A0=C2=A0=C2=A0=C2=A0 const char *p_name, *cid_str;
-=C2=A0=C2=A0=C2=A0 size_t cid_str_size;
=C2=A0=C2=A0=C2=A0=C2=A0 BDRVVmdkState *s =3D bs->opaque;
=C2=A0=C2=A0=C2=A0=C2=A0 int ret;

@@ -316,11 +315,9 @@ vmdk_read_cid(BlockDriverState *bs, int parent,=20
uint32_t *pcid)
=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0 if (parent) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cid_str =3D "parentCID";
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cid_str_size =3D sizeof("parent=
CID");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cid_str =3D "parentCID=3D";
=C2=A0=C2=A0=C2=A0=C2=A0 } else {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cid_str =3D "CID";
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cid_str_size =3D sizeof("CID");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cid_str =3D "CID=3D";
=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0 desc[DESC_SIZE - 1] =3D '\0';
@@ -329,7 +326,7 @@ vmdk_read_cid(BlockDriverState *bs, int parent,=20
uint32_t *pcid)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
=C2=A0=C2=A0=C2=A0=C2=A0 }
-=C2=A0=C2=A0=C2=A0 p_name +=3D cid_str_size;
+=C2=A0=C2=A0=C2=A0 p_name +=3D strlen(cid_str);
=C2=A0=C2=A0=C2=A0=C2=A0 if (sscanf(p_name, "%" SCNx32, &cid) !=3D 1) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
@@ -345,6 +342,7 @@ out:
static int coroutine_fn GRAPH_RDLOCK
vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
{
+=C2=A0=C2=A0=C2=A0 const char *substr;
=C2=A0=C2=A0=C2=A0=C2=A0 char *desc, *tmp_desc;
=C2=A0=C2=A0=C2=A0=C2=A0 char *p_name, *tmp_str;
=C2=A0=C2=A0=C2=A0=C2=A0 BDRVVmdkState *s =3D bs->opaque;
@@ -370,16 +368,18 @@ vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0 desc[desc_buf_size - 1] =3D '\0';
-=C2=A0=C2=A0=C2=A0 tmp_str =3D strstr(desc, "parentCID");
+=C2=A0=C2=A0=C2=A0 substr =3D "parentCID=3D";
+=C2=A0=C2=A0=C2=A0 tmp_str =3D strstr(desc, substr);
=C2=A0=C2=A0=C2=A0=C2=A0 if (tmp_str =3D=3D NULL) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(tmp_desc, desc_buf_size, tmp_str);
-=C2=A0=C2=A0=C2=A0 p_name =3D strstr(desc, "CID");
+=C2=A0=C2=A0=C2=A0 substr =3D "CID=3D";
+=C2=A0=C2=A0=C2=A0 p_name =3D strstr(desc, substr);
=C2=A0=C2=A0=C2=A0=C2=A0 if (p_name !=3D NULL) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p_name +=3D sizeof("CID");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p_name +=3D strlen(substr);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(p_name, desc_buf_=
size - (p_name - desc), "%" PRIx32=20
"\n", cid);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcat(desc, desc_buf_siz=
e, tmp_desc);
=C2=A0=C2=A0=C2=A0=C2=A0 }
@@ -485,6 +485,7 @@ static void vmdk_reopen_abort(BDRVReopenState *state)

static int GRAPH_RDLOCK vmdk_parent_open(BlockDriverState *bs)
{
+=C2=A0=C2=A0=C2=A0 const char *substr;
=C2=A0=C2=A0=C2=A0=C2=A0 char *p_name;
=C2=A0=C2=A0=C2=A0=C2=A0 char *desc;
=C2=A0=C2=A0=C2=A0=C2=A0 BDRVVmdkState *s =3D bs->opaque;
@@ -496,11 +497,12 @@ static int GRAPH_RDLOCK=20
vmdk_parent_open(BlockDriverState *bs)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
=C2=A0=C2=A0=C2=A0=C2=A0 }

-=C2=A0=C2=A0=C2=A0 p_name =3D strstr(desc, "parentFileNameHint");
+=C2=A0=C2=A0=C2=A0 substr =3D "parentFileNameHint=3D\"";
+=C2=A0=C2=A0=C2=A0 p_name =3D strstr(desc, substr);
=C2=A0=C2=A0=C2=A0=C2=A0 if (p_name !=3D NULL) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *end_name;

-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p_name +=3D sizeof("parentFileN=
ameHint") + 1;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p_name +=3D strlen(substr);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_name =3D strchr(p_name=
, '\"');
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end_name =3D=3D NULL) =
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EINVAL;
@@ -516,6 +518,8 @@ static int GRAPH_RDLOCK=20
vmdk_parent_open(BlockDriverState *bs)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bs->auto_backing_file);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->backing_format=
, sizeof(bs->backing_format),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "vmdk");
+=C2=A0=C2=A0=C2=A0 } else {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
=C2=A0=C2=A0=C2=A0=C2=A0 }

out:
@@ -1096,14 +1100,30 @@ static int vmdk_parse_description(const char=20
*desc, const char *opt_name,
=C2=A0=C2=A0=C2=A0=C2=A0 if (!opt_pos) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return VMDK_ERROR;
=C2=A0=C2=A0=C2=A0=C2=A0 }
-=C2=A0=C2=A0=C2=A0 /* Skip "=3D\"" following opt_name */
-=C2=A0=C2=A0=C2=A0 opt_pos +=3D strlen(opt_name) + 2;
-=C2=A0=C2=A0=C2=A0 if (opt_pos >=3D end) {
+=C2=A0=C2=A0=C2=A0 opt_pos +=3D strlen(opt_name);
+=C2=A0=C2=A0=C2=A0 if (*opt_pos++ !=3D '=3D') {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip "=3D" following opt_nam=
e */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return VMDK_ERROR;
=C2=A0=C2=A0=C2=A0=C2=A0 }
-=C2=A0=C2=A0=C2=A0 opt_end =3D opt_pos;
-=C2=A0=C2=A0=C2=A0 while (opt_end < end && *opt_end !=3D '"') {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_end++;
+=C2=A0=C2=A0=C2=A0 if (*opt_pos =3D=3D '"') {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip "=3D" following opt_nam=
e */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_end =3D ++opt_pos;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (opt_end < end && *opt_en=
d !=3D '"') {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_end=
++;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 } else {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Assume the value is unquoted=
 but line-terminated */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_end =3D opt_pos;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (opt_end < end && *opt_en=
d !=3D '\n') {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_end=
++;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*opt_end =3D=3D '\n' && opt=
_end[-1] =3D=3D '\r') {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* skip=
 '\r' if windows line endings used. */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt_end=
--;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 if (opt_end >=3D end) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return VMDK_ERROR;
=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0 if (opt_end =3D=3D end || buf_size < opt_end - opt=
_pos + 1) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return VMDK_ERROR;

