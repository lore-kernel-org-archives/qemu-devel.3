Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CC606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cR59IHAa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCU-00041x-Nm; Thu, 29 Oct 2026 18:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC8-0003vA-BG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:02 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006Wr-HM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311307; x=1793916107; i=deller@gmx.de;
 bh=Dw3LFXM0YgxvGWIPZNyqdOMim8Mx0acSGBmMO99krzk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cR59IHAaFvReOM+8W0xbaql0nmS+ILKsAdRF0UGgHRdjNK66+bWn7TI5iBJ5hfmA
 7hixDR64c95WUXe54QU5nJ1PNKlqRJ+lryPiiVcdXUqjqm5rVfSerFG1ZYIktKnoM
 f5MbWFNHmor2cmYCGxa7Giy2LErx0+5N6OM5ksiTqdZz9+RYXW0k/EN4JVCqqNGAf
 26P+6jt694Gb7v/UJ5nTdGMhcON5Z9s+dCTBpX7IGpMffrEwfkMLfGShsF35qf4Y0
 qj92dcLJSfLdqtNQi1ZgUnyFbrGxVf6irgRdsxT7eyE6XBTKrqS6ZiYikeSSK9Sxg
 OSaAcnSdzhljw5bR1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1wj97E0bH5-00kR1K; Thu, 29
 Oct 2026 23:01:47 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 10/10] target/hppa: Map CPUs at same addresses as on
 physical machines
Date: Thu, 29 Oct 2026 23:01:35 +0100
Message-ID: <20261029220135.412284-11-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lFxSwBTOfh9ayXsVB1rfIWIiWHdYClO22mQYsQWDYvSlgc4uEIr
 F/tQQZP7Pknbpcg92dhlIFp7H83YKEyZjxTEe3T1EuheXKn+5w9P/e5uc5oMFODEl3kAckF
 K/O+ao4tSBh3x5LDHUnDRlSMtjc8d4yL1LbEi8/4iCHFYbOGGTiJbb+tH0pcQnlcLDfU1LJ
 Z8g88s3BBE8p7NI+G0tYg==
UI-OutboundReport: notjunk:1;M01:P0:j2tSIyu8kkQ=;XTcD6WafWNFHAWgw7gqia5GUy/d
 a8n4yZO9Jth5CfI/mDwdBfP+lrkRMpk/wxkXjIH3dc9xCpe0ya2oa92KJz15/tK7Rf+2qoabi
 qHACPW40EonMZ+4172h7Q8ZcwPR4xJK3roxOVpMjTwTq7uXsIpa51s6WcbLljeUSVKCHbm65/
 Vj0d6K1x4Y1kyUfBAGcxzA3UaT9aY/QDJKkNNdTslKo4Onq8Qych/WD0tZjow9OQTNTuid3zS
 tftJcDmbx3hdpHHbl3y+HvvlbCXJkfTQhbzXwaepl9Q8+sLkyCNBCzOv6/eKgB2OrBBk/6Mil
 2GFenWh1xZc8J0e61hgzXXoiO6vD/PxFeqzccPOaDmgIqLrDoUG2lY7DMenwSh/YdO9lhjjYl
 fZOKoM3/2MkAlcDj9+oENkL4iHyHgK9Xwl8VfebV43TI92rFKhd7BBBPe623ZmxrZnDR0xQFb
 Z919dfilkV3R9glYLKwqBpprt/Q+jM27fhzL5P8SFQjdOR4KuklvdgyHTWS84wibG/vaTH5b5
 iwfLoRzl4Bsrn0q+Uq0VNxtHZgiFioeK9QBeCIEqxH5ofKLH9r+d+flal4duxkRLStiYajMFa
 6BkG6mmDSGlmsO/q4yTG7OO5QdBkMHqzcxitW0bXhfn/7iSLsHyyl+FjpvINJ+NzYdUNZEzEi
 Mz5cdcA8dKRL8TVY84o5mSRRt+PeMol2hHMBdsepxcBl53LJMu9lJTReeF2S5+vf1o8j/tCuZ
 +b2LTMyCpiR/rdE49kH53s/wG/tROIAw+kuE9wqdwhEu+rb70vpoi3stEGpS4kJYT7wmgXyxS
 xNIhqk5d49hldsUXIa/CfzP0m5D0banEUcX3DdUgHBrmwdVX/iOsItcxI/tI8tmNxPD5hnDNg
 rKwEvDO3ynevayC2UyaTvjNgjrxI7V5OibQq0Ajz1yoLZHUUmVt7uCfAAJBOQv1CO9llEaWLL
 SWq83ildxJZuCT8o43vQ/ivyQiqbpA+5b6R6IfXd1dmtXeR5/6nJDMsYwA27smrE0JNB/NUgY
 VC4oAqlMaHwrBGS+kYtRU6fVRM1onRZ5w8inl5DltaXTImloHuPYeDibDHWznYBKlJEg60bMn
 fsDgPj/yZUF19eS2zQQwZPcUnlxv+Ny2FmBLMM5O8CnBp1ZuFxaTu0cMxr6rogoHzt9BQDOvS
 FjdkLZ1mlZQSUGTyo0Uk2+D2Tk9ZmYY5H1awom9muCLYyl/X9BiDSqL8gSE9VBgFRjyFOQlHb
 m3mo4+Izb9/0co1X8/aNPZsZw35HT54Pw0B4l72n2BBthmsp4dyFFTK2drMdzRww7pO4/QLSL
 dL69+SioDIUalt3iX01IMhxLk6a4WeM6lEs3KGgJ1VPq7mw3GzNWC9yN5H+waKx5uEG3VDFNi
 cuaAzkFhUpiBhGqMRnivrOVzxzaTyJ4gBKYCbTz5krWTBJNMhDK1ujvyDShUUElTN81Yi657m
 nzfkBuuwUQoV+W/hlFNampJn1Ip0aLbnJNm+Y6vSvpKGEIrlgI/DHKG/jr7PDNqPoZyplEdfo
 2TultznKt5XhOSrQFPgc1V+oIJRdfaD160HzDuskd65m3515R0ZsTXNZz1+3InC0w3am1SdRJ
 f+z0f5E5YQGG7V4xY3ItTaLjp82BDLQNOaL0/Ls+YoA/f6jT/5eFD4PalE3p1sH1q6+FwFfQ+
 eeSJL4jKVhZokQ3Ym46S+QX+WmEqFVNsjooxaQ4p1kwJwmVov/xLCn4LKJxymlfDkcC8Ti4U/
 uLqqoowc/M5f2z0NDhVYUzQBKCAUTwEfUY/BGl+KE3PvzQIE2mNOcoY1BI+Qs1gdNdLu+JreN
 i5sTHcXcLP3z1Q7qy/imHpxcoJMZg47s2X2vEb/Pp+kMfpPuhmanhs8eEGnG2I7kQATgE5ZhS
 DlsoBE3kH3FROQDTVhXF29M1FD6wIBVUtka1CHNzwHpw5lCYoIWVOY9rqD47xyNt3k+0u5rig
 8SDs60aSIaRYjfQq2fXPZjLffK5jivGV57afmnk54d/kiAoi7aKiB20CMf1rzM+3mvHrHAQsf
 AERwZ467TIHA0RHmd3gfi0HQl2eSJzd2eznRp+6I5Z1hby6vtm1t9BYao0fTWz910KuYSgUzA
 hpMzN+asFd7lpAqFr7EABfwbg6zqv0cfYXoW8CA+tuAPax9r0IG23xe1pXwCtXullwTcNe3r8
 Q7rYTPQUehsLvhJeoE+/aWBV/8RtEx3xl+gAqXe1lxEFCb4CXIjbIoOsUy9BTJ9rP3bT8VuAX
 yfw+vzjty6/4v5XWtU34KQC4oZtVkHS4xmCOzDYdJUCWA8lY9ssLwJMD3rRDSqzlF/SClXhhn
 ImYTu062iJzdnG1ijLUPYdl9gAMwMtMFxlOm0ftAx9ogXZFm0RTA7Vjf+31+g+jP6jmRl680U
 haK0k8AOccxGFVA/yrzh6s37/N0OiKK26yMWW6Fg8+qEJ9CATZWv2z5DdJOnB05cE3iHzb1Wq
 nqMJ5momPAk7y67IumOpRIIJOTk7q/8khGQ7aeHIO1XREB20A88P1rrTl3iSJU6ZKdMBBaeS7
 xowQepXLOFxLA2PrqCKONbfRvMmTpsmAyJ/Q5wig7LQKzbLGQIzWvHxDxerC02vFobgp+XqXm
 SsLFfo0if7q8p3qPbogtVn54M0XlIMZYM8WeTeiPvYW9rMzxhPg1tbUuZDvY3CSvt8RWmAkKL
 P4NNDUu7LSwKtYaMKyo8HM4AW2KviMb02qG+IR9cKMPHzLJkJVf2X444HoHKRvKY4cNUoBM8q
 DlmkgmQ4Z5RDKQJNEFJwtea+wmWomV2/GPTft9cNSg3o1+HArfek9BDpBEShrSYmJK0LKePbw
 7WEbOGW/2ccJ/EIooXi5pjQAYzQZS3IKJHlIVigEiSjUFpuVH//qIUKT2KpGbURbAsAvQeywN
 z9U2PJ7YcrVVY54pxPtRdhCCQVkE+9LNqLmDqshzR9eoN/iIWCTqYyvPEqbzvVvsdUWcpA0Pj
 Z59cEhqRaAZYbslXN3PyA/YwyGTVfIZUlok07IPIvfajgAA25fbb8cJPF2lAHHjd4zXKcd5Jk
 rHqPZSndLmI0+btBmN0MWW/lj5CziknsYOtyD6KFDk5YQVue/mYQ0jgSoaZucqMnMJFfWQ1ev
 qqGzVhdvK08UZ8hZMEkpDTKOpVa7OxHSeStbkAqdsf7QC0763dgg2Bv2WzJoR9UmDIROpsXlr
 PVN8ZqIoxNyf06c0cA5cdrPlq/o9ymmsCZTVRX0kD9fgbXtFuT5JUogzrVkS3n6vqQWQFlsDK
 VPBTSfIcMrd99QA3vTPl2kIQ8DNwh6l6iRWfZQocx9vLp+nXcTebmeZX99xz+RdXe825Oo4IF
 NMjYE2+F+gAg5WWw+7sziz6qad720HdzbG2DAO4jv9DUBLCMPXUQNt3j+A5Uz3fiDfaP5I837
 sRTUaoK3zo0dgnjQ6vXdCPdALHCcH+jMsYT/wdxneuT65qKz43HeJESlwbZKIENR6pZe66td3
 ppqvgdPnohUwLbYcJJpiTMgWwH3Pe2j1TfjoZKLT2iehHbCZMiyMzyhlPyw1cbKgLU4rle65k
 K8tnGF7oWVKyDsnkBfwx5vWA6cKuwDogmwqICzcpON6D4AYbN//I5iUoJCHAXFUzjGvFgPJny
 ujR/QKX3FjpSZbV4sxzcD/f+vfnqZUWh5YB35rKj2X2XYFeMK5fu0AFAmTkSRKV7GQehDxiu6
 g8S9djc3WMgF6xPDtA4jWvn2KqV+e0ZQNDmtvj8Fig46PZgoT6ezzySDghtO68pW/NeItj7Xc
 g//kl7vE04JOSCDhMgIiJx56mycpQkwa+0YAsmKVGTc8ZeSBqon1SBWt/RuLiJATY0DszABSI
 CCBWv7cob0zO478z9C0wqSFIsCeDtMSQtO5VXNmrPkz9NPatvV6/vBGzpxzSDc5TpGYDSqglX
 47xOoz0EW4riZIqF4phhqQgOCxFzPihYpIiGkAgDLynhtfdpZqpdQVR0KpipMQIsA1V23YVjp
 2QD2i6e60AYSf7rEC1en4nizteb1m8mGD9pwZrjXFePKMKbT8j+svK6hR7bDvJCGGveG+MZtw
 o6eRzlfvXWYE4x5n7W5j656+sTR+Av6JQ9+U+wL08SEi1/SlAD2y3r2L2j3uM2JUlCnswN5M6
 0lgCXbqYFX08oG/J4ClrRvasC6kQDTi1xpNYe4/TN0uZ1GdFrzGm2QFKwCp6ujI6M80bEkrVh
 0nLOzhrzHloZVSCNOTg9JNtU0nj1qWmHOwuEoAeddRd2IK+8MseEGGuyRD4AEQSquUYwUEFdn
 IPoYYq8Fpv83H0KCSELjvZ97O2tayirO1xoMEwCbxZE6vYvWGl5TZUnaeW2qPek4aK8+V2uMO
 BewwQy97ut15HBb07Bq+xm90c9p++gyfE4mdL8gI+Nq64crDlS1QZ02dMm4oHv5qHLpeqUrh6
 U8EnPrsT8THfoOe81pCYsqT7Yphrq20CkUWfXNEzjgtnptjBN4dpWNIdc/ey1mHJaLS1GtYLB
 t1X+WlVBdEvnyVxyIE3+8CqOPd5rtUFNYw2WGSjjgvowPvjb/EcLml66XWQ0q+uHzZH/UES5q
 4LT9HTk64mW+IcHXs2nDHZjM39gTyBAMjq1lqtTQZigzQAfYHQfLvROIcbffncSBY3ItEhpMk
 IwA7P2hqE8ek8m7QU4tVCekrQfy1OMm5TnqliLG5mWsP3yWHKuo/wOH7WU/DSG0rZXdAo/PIp
 3KQoflqho1moj7jKwfl0EuGNZxNXSRomUOSTpi0jX6cUbtBVovEW90eJU9RYXCsV45sIEE2f8
 neowI3nCzqSw5aJeCvxBK1osUrF65YjsND4KNNkfGbCauOMiBuRAZ9pywCuYuRxxKW5xoozWf
 SOeHTrEk+/9syaFyQQRFU3gkZd4W0lwqqB+bSajD+n5tAC8GHerxNG7uNMh9KVr1SLswBlsLl
 f4r0Ths6R7hgjLQD57/vOiDYtEgIQEHiYvK5j+Eu6S069mPRZ8q9DssSLeu/5Kw9977zI+pPj
 0OrKSogLdGRjA2QhfTqrxRiIyr3ElX1nmx4NP5Fz8dfkvOr/vb5OSc3491QGg0n58l5fVNVkt
 BnWp5Hd7Di1yPsE4vzP9aEv11ea2Ttk2cc63NwEymyuXm2P1KzCvI8pU9E7YtxsUrEcRCN5Lx
 x2V3GtpiXTtPPNH4ldThQcK5AV/nqVk2bdHexSVzx07NieFZ1zlGhpF9EV6A5bqGYDO0V+JY0
 PO+zNEsvmMnPvTujFyICHpzdYaQxzt1ZyRNzJvsGGMiUNwaD1zS6YqhHoR718qJ1Iw9johXkO
 S8HKpWn9iZQeaed5bMxuZuDajB2JnE+Zu5wq/ph/QHG3NZ2ddca04eVfytkQTFRPnrS/qMDjb
 ApNo/L84HeaAUd8r/abkzJAHEQG/3Qn6jx/gJRZ4VU8db3r55iJmNB7IWcJiPR45lY5KnzWm+
 vcMbzAs3zq1gbDPFuR706Jx4JyG77ku9xgftWsdE5lAcO6aOyK325cChC/D/8DHIVRRFDCejL
 3UDqBspPnIQWOmU3stAjhXGPlUhBzBnlZWYGIJPDzTunSRemnwsDGPbT59s5zeAperRLb+PuG
 LYFmci0TjZ5+ZxPg5l1QL9cv9mAZev5PucTUBIuGQP8UczKdxnH14n3CVHyPdF4/0N3TR69Uv
 vY2voTwAxtYIYV67SVWPRGuBVw0zKQn8CXVI7F1WNJrRHu3ycocW9bnnz/R5HjUH5l9t+bR0B
 b2lBA0xpDOBttmXH96C3VFgRHjaKL7YknQlcqSkU83Q08Z+bO62lY2TwHzJz1Qd7DNpmMv+GA
 8Z+KVHjG7FxY5Dqa+Xn10SxFYWLcNPN4RxvMEalV7GnIISvfaEzK2eN4v5hMWwl/TX0j/eyyY
 tKdcHCL+VBkBiL27cIPbNMbC/b8MVeR4y+/wTQ4hLf5DmmSC8tElfXXsZgVO6Tp4p7Lpv9wFJ
 TQWMUs5yB4mn86FERckyTqLULm7FUsEH4qRzg/216TMQR+lL99UDzqiAiX5UucVZnWjfw/uvk
 8dcvpWVJar8QmIQ90E9QLFIEgOiT27xAoPTNeuIfxoMUPNcc6IBOGn0Fzu5xU3OjmK6aqASnP
 6A8ox4gjYh8orycEGZrSycjYuJKn1ulXuXWIIhsTEZ46KxpDE/d6wQGSAdjfGNsll3x0kJnJy
 eZsjmHsrN6mFbqa9vdqgJN2k5zH63WLNenORGUFOvl5upNSlYpAmuqVMFOhmwNLJWUvNG4ZCd
 h49uCQLjacGgmhk9575JPJOrrQzb6nhUt41I2XwJVY5hSrwdZJAURe7Lok3S3y7wALAi3JmDQ
 28bS4edU4EH9ssW7AoTWXZIiw49f4VlDQdVXxcppX1bN7IBf8EIorzMeQapcKci7iK8t/yDUZ
 zYxgjO3tEIOmyEjbI19i7FxRMiIMUWwxboRtTxh0Iz3SvfORog6M0SWm81ckdpeVYu6pfxVVr
 123L3FbSFGsex0aHaTA/08c9jySfEiUcjbaCxUtqr0BI79YerANbx8APhXQYJqLTON4ZIBssH
 01gCtFitJRhv6Drokgw4JWAsWky4akjyEK0GLECfgzr0Uv6P+8mu/KD4U5M4twGzUUHjGeWUr
 Qpzy6I5Qtp91ga4b8J4Pt3vvBqmQUHjDBRW6L9GnqY1DpaNRaTluFynOkYVcKnQovQWAdC6uZ
 9IAjYVqYzn0MFjrUYk0cUnhxJdKp8s81PSw6+FDnMFsNcwIg9DzLenCnUtHGEgFevGzlCDkQS
 fBaB+L9VQojkm5pIi+D42wHTPrfXMVXE2F8hcbrCpjR6I4C0eMlFAFsz+o0udT4e2zkOHhXKy
 Gm5mhGjCgiXccEXZ7SGMfV/Ffqs/RNdi3jJ33YccYPRuAzrflN38kaTDBPoYrGsQ3aANqxdqR
 0kdO9MRTUlA8y2DMhdhWi4DZrb5oyYOxBIx+Q5ygL/5Ri1/FJER0HanoGd8WqMC9wzCEYmYEw
 QYlshKmfX5f6YH+hJ+C9i3pzt+4cq4t67NrPz350ZRK3W4MWwC5eOrA1N8DSHIWFQz94wukOp
 nktNXu3LGL5isBmagJ025Y88nRtzs+MX2odwHqs8Kcv7bQdQ8SZw0afPdrDzqzrztANkv9lu6
 g2UxdxaGjO5hX8x4eCyFfoqEzl7MtBm0G0wnk4ak1QUv2L4NnsmK0lnX+StSioRlaHQNVqIv6
 f5BC6YMqEL3MVi6zwU+NY95G6/0SNxMF2yZYXIYtadKoIwYpEu9hdOxz6Q566VyAc7n0cezMa
 O/C8V2Slrh4bzAGmZDdYfa5r7TxYzjtRcV5OPXbXzJgRg3FWydd4u1Nwd1flOHW+0ZWEjoOFa
 PkpnXpk4xCjFztWOcJ/RwQihULNRGJzkxdie6DtEqicKHJIqYkDlOyu4SLllbLNzmYOBU53cW
 tq6MVzKW3VgsBQAUS/7tnV7FADX1cCnF14hgMwcZV4Zg7UPl5XsRkAMkEtsMjuYWi0FfGNkQB
 ft1NZo
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SeaBIOS version 27 allows to use random addresses for CPU_HPA, so drop
the hardcoded CPU_HPA which was used until now for all machines, and use
individual addresses which correspond to the CPU HPA on the physical
machines.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 23 +++++++++++++----------
 target/hppa/cpu.h |  1 +
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e403ae5fc9..f23936fc5b 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -241,11 +241,11 @@ static FWCfgState *create_fw_cfg(MachineState *ms, P=
CIBus *pci_bus,
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
=20
-    val =3D cpu_to_le64(CPU_HPA + 16);
+    val =3D cpu_to_le64(cpu[0]->env.cpu_hpa + 16);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/rtc-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
=20
-    val =3D cpu_to_le64(CPU_HPA + 24);
+    val =3D cpu_to_le64(cpu[0]->env.cpu_hpa + 24);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
=20
@@ -286,7 +286,8 @@ static DinoState *dino_init(MemoryRegion *addr_space)
 /*
  * Step 1: Create CPUs and Memory
  */
-static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
+static TranslateFn *machine_HP_common_init_cpus(MachineState *machine,
+                        target_ulong initial_cpu_hpa)
 {
     MemoryRegion *addr_space =3D get_system_memory();
     unsigned int smp_cpus =3D machine->smp.cpus;
@@ -299,6 +300,7 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
     /* Create CPUs.  */
     for (unsigned int i =3D 0; i < smp_cpus; i++) {
         cpu[i] =3D HPPA_CPU(cpu_create(machine->cpu_type));
+        cpu[i]->env.cpu_hpa =3D initial_cpu_hpa + i * 0x1000;
     }
=20
     /* Initialize memory */
@@ -321,7 +323,7 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_op=
s,
                               cpu[i], name, 4);
         memory_region_add_subregion(addr_space,
-                                    translate(NULL, CPU_HPA + i * 0x1000)=
,
+                                    translate(NULL, cpu[i]->env.cpu_hpa),
                                     cpu_region);
=20
         if (!hppa_is_pa20(&cpu[0]->env)) {
@@ -339,7 +341,7 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
         memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
                               NULL, cflush_name, 4);
         memory_region_add_subregion(addr_space,
-                              translate(NULL, CPU_HPA + i * 0x1000 + 0x50=
0),
+                              translate(NULL, cpu[i]->env.cpu_hpa + 0x500=
),
                               cflush);
     }
=20
@@ -347,7 +349,8 @@ static TranslateFn *machine_HP_common_init_cpus(Machin=
eState *machine)
     cpu_region =3D g_new(MemoryRegion, 1);
     memory_region_init_io(cpu_region, OBJECT(cpu[0]), &hppa_io_helper_ops=
,
                           cpu[0], "cpu0-io-rtc", 2 * sizeof(uint64_t));
-    memory_region_add_subregion(addr_space, translate(NULL, CPU_HPA + 16)=
,
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, cpu[0]->env.cpu_hpa + 16)=
,
                                 cpu_region);
=20
     /* Main memory region. */
@@ -626,7 +629,7 @@ static void machine_HP_715_init(MachineState *machine)
     ISABus *isa_bus;
=20
     /* Create CPUs and RAM.  */
-    translate =3D machine_HP_common_init_cpus(machine);
+    translate =3D machine_HP_common_init_cpus(machine, 0xfffbe000);
=20
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP 715/64 workstation requires a 32-bit "
@@ -713,7 +716,7 @@ static void machine_HP_B160L_init(MachineState *machin=
e)
     PCIBus *pci_bus;
=20
     /* Create CPUs and RAM.  */
-    translate =3D machine_HP_common_init_cpus(machine);
+    translate =3D machine_HP_common_init_cpus(machine, 0xfff10000);
=20
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP B160L workstation requires a 32-bit "
@@ -810,7 +813,7 @@ static void machine_HP_C3700_init(MachineState *machin=
e)
     bool is_C3700 =3D strcmp(mc->name, "C3700") =3D=3D 0;
=20
     /* Create CPUs and RAM.  */
-    translate =3D machine_HP_common_init_cpus(machine);
+    translate =3D machine_HP_common_init_cpus(machine, 0xfffa0000);
=20
     if (!hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP C3000 workstation requires a 64-bit CPU. "
@@ -893,7 +896,7 @@ static void hppa_machine_reset(MachineState *ms, Reset=
Type type)
         cpu[i]->env.psw =3D PSW_Q;
         /* Firmware uses FP registers before configuring CCR. */
         cpu[i]->env.cr[CR_SCRCCR] =3D 0xc0;
-        cpu[i]->env.gr[5] =3D CPU_HPA + i * 0x1000;
+        cpu[i]->env.gr[5] =3D cpu[i]->env.cpu_hpa;
     }
=20
     /*
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index da48a78569..7b708a564b 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,6 +272,7 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
=20
+    target_ulong cpu_hpa;      /* HPA of this CPU */
     target_ulong kernel_entry; /* Linux kernel was loaded here */
     target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
=2D-=20
2.56.0


