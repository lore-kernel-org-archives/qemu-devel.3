Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668E2E83071
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSD-0007TM-3M; Tue, 03 Feb 2026 05:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS1-0007Ck-DS
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRt-00027r-JF
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113749; x=1770718549; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LAxlmClVT/2UhcvcaBopH43oqxGvt54bq9uFk4D/lI06vtTbwWAOTCv2KY/FYGYd
 jxLsYp5jVoazL0BWWlsLyjP+iF+TTy4hO++CtfrnhONM4V0glmDBKxxxDHzmn6/o1
 lvgA7Fbg1VFKwpVA2hiuVweRoP2ZfvZ1rV3MYCFU06bxQe6mcH+znV4ZAOgcbvT5d
 TFac5/uUoWr0sGe5vaDuYIkLdo+DejIxgQUJ/FckU1w5LTJVkIWzRrvdHejipwCKS
 OTzGrglu90as3uDW7Io5kqQvEvvrP0pf3g3lYrEoPohovu/m0vciytzLo1hqT/i7f
 rqWGjIB/lcmfpn7TJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1vR8B32JUm-00e4aM; Tue, 03
 Feb 2026 11:15:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:14 +0100
Subject: [PATCH v5 08/16] Move ram state receive into multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-8-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQjxRVmzaN/2xqothvmLPJr82GsLFNWfXCD
 ZNaudEayOGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WKc+D/wN++gK8+AniXXA05PdmKHrJrCpbzUjtmK8pKXsFqeDGcyIhPFSk69D848ha+sCUmkf3xD
 MSSEXDYbsgQku1M9DCoSpbpm3o1RTxYdqMwSLBhAMtdbJkKceK/mLdv9+GV9r3SvJHUiZ2MaXwx
 jTEA8t7mZKVN6VjNuGr479v8OajYGM3DhgY5bLHch8JJHnNOK3FgJJUM/dkVKkWoklTnlJJeAO+
 EZaKNCItgOS+7/yZCXQn3M+gtl23H4QroQJR/RulHz7AzT/1R9Ei5YmvxfmoJIENA6HDRsG5zXR
 PBfuFn3y4uonrtMUHJEyRkwGAC6vokU5qZoKFwmOX8VBYapjChtE9sin5PjpOBSOqsmlHS80XAA
 K6OO8WipKOHJ0m97xsj+A2IEQM3/ql05S+0zRMsYUPY0wd80b8pTCyNmfzeXbEy0r4myEADhH6O
 vcpVcHcT5j2x1Fl5/5jtisA7E9ZxEHm+w0fK8R+/gD/7ao4S8VHBr144DYZHSzqcaFq4FMnsdvu
 y/5+lOnredSgc/gnJrqSrPcNInFKwdGUC8SqaIGANBwwaqgr5ClDxHLw+/ohSqNPfswiE671EP2
 VOptb6MZcexsLIt07DiL/46+G+RY/QOeM/2e0yIS2U9v8w5mfAn99uV6id5W+c+tMBFjhNK0byg
 s6P/i+yqkeZAcbw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:N4Qil2VXLqEtAcu7IdYCMKe297EhKX376xLxzR7clL6fEbpwKBt
 +aya+qobpkTT6CZU2F60Ae/HVmTIjuksOnBVHwQfmBv272dLL/nQ6NfvvcPqgtNn3caDsjt
 wmm6JaSelosoHINiIr8OCNl4NU83m2bNbMmBvqGKTgtE735hlaM2YqOJO1pezxHBhoD3RNH
 YHPtMZkOlq97qvxzNY1IQ==
UI-OutboundReport: notjunk:1;M01:P0:mAM0MbSXxqg=;U5GyhxmS83NkchcQFNqXJZUy2Ks
 jDTQx97dpCTbfNGZNjPqMjjDvqiIRj8rvY8FUEkgN759TwbpgKIwftY6mAd9PZNLEC91pLXV9
 IklZiQu78FX/iOwsar7i8etXozDmfJTE8yHMm9QgLcJXbjBejonlrQ8MXdF+jZZrfYSGtcMJs
 SytjFj7bQQP+HCOQn46um0/39px+mcL39mt0XKx8qRbeLhtxllyjY1TqS3NEASKLqMzDYhL6R
 9Nt7amUR38ualZLFJC0FUIeuIR7w3sqaEjsygNi8f/BpOvdLKsdf3qsxL6DCh02pQmLvekRn8
 RXgDecYl7YisEuXIJFFcTK6GMDmx351FHhrhTRURPi6LJFU3u0DUPQawwECA6zlbflWAbn5tk
 AUCWXCUylPaio0rCgEOitcLzGabtO9RZtwxOY0ebiZT1SB555sUIeX8hFHnuIauWrcVj5pJ7y
 88c/Typ1BphIYlp/YT6lb2jEUbedAaYfl5u5p7kZjLDJA8h3FXmBgqf9uiJIC71WeL86+XDot
 uSdOihbmpjsOeD+KIjuvheH+pWl6nkTeg/j70kFSke2ctvRe/oRL/aXHfBy3deqN8b4bTpNH8
 iHsGbC7IGfJ4BaHsgHfwzntkhDWpTh5zW20PEfL2tychB10zcxv8Ah2tlC9xaOPIeYE4xMPYz
 RY/TCs7CtRPNJ6SLGCYtYwGTMqG+BAiDDR1aRCP4FJNnnWrVlIdFFT1ZwCcdQp7Yu8QqBhEzi
 pnO2wHBldT7A6foaZEhuZJWMN5bx0dVX8nDmGMl7e9cVfsQkgGkLmyH6lvu05IURV3VFoN+eH
 mspWRmOQUhQZt0uPTVqUzgodwlzIG+67FlkpWt7T6pwiuAx9i8LR7ZrXQht5EiSmYkbojoKkZ
 gnGDXBDTwrwae4eiBETaXcZdfMlZYaw9kNF123TeLGhLDy+HTxOmv9AapxvbStXLS/FFSp5vC
 kLa4zvUuMR7sNkevndtA4XRmqP5mAskqpqVNgtqWP3IpGxTVIQe99RJtpPJ4l2JTXXsMP/H3P
 T+O0afaO6K4uRA7nwsVDuvlOAxX19eO8T8ifBZ29Hjn1FkNS8EfMyJxxNHQ6SeTxDZqcmFG8d
 yDA3vFCaW+HufrL6eWvuIX1eJJjIGjtjbsmEfFXzR+yR0u+RAss5Uqr9/DD6R1+GP5g++jtRZ
 RNABeStnUjxor5FWXJKhFhB+p2UlLdy0xJ6u2nq3kiYNWfkCEDeZ01h/2GeRi3UKiKc0nPBye
 xUxfqjKJev3LQDES8lvmKsDaIm/Vx1CgYYSbYl5BcS9y+vKhA+ujh3JfpeXurNZ2NsaZ0k22+
 NuPaE4nW6TUBynZsua9cBCsDkPKtYQ4ac5sdgQ9sMYpvdFQr6YInaLIzM4/gGBljyouKSjHY7
 9zJ62JOC6jmgwoB0hg4sESuKrpcas55GNuYwWKt2vYw0YPPWyFTkAcIK67ZIw8+TUEK/aVLG/
 No+EqUnWq2cqu8XraNFyzk041bPfwg/hUkZDb1CkwHaekaDvCG5YGRfmoEZDzFOOItOj3KqHv
 9/0Gy9CKszmLcDqS7YypmAtvAk9zj02rYbtw0DRXinG3lHs2ljDhJutvNGY8VdtiRXJVTFv6o
 sdq4754Pnl52FNFgs45CJmMcUBgpzYT3PWQjvoZsUTSiuXd+gxXEwJzVcIobc276uB+uuJJcT
 vrdY8z1ZqTB05Gd/WHE7sl2hxOqBHG9RcwIszgb5vPL1WmSAM0bIlIk4FqRhWehviAErufBHp
 v0Xg3z3Tp2KIXAgGIo0MOwQB2V3sdU5Y+uAXFXokr23di6bCM8/CWqOkcg+fUtE4nGUsIYSbi
 NPfW5lbUGbZ0ezdHn6wMnhzMXgO3iooO4A5oZCSPeydvMC2ywrMN2xVNkjA4HPqPijDbDE7CT
 /tMAVo3GBQDmByxg4FVWo5C+7LXv/C+TpYtmQpfFJhzJT/Iq4mgcS298QKYR9TcAXdoX3BTAo
 uq/7iudCCYIwVRqodzGepZpPZDuRqL50UIo+TqirtEBn3q8BnRNr2IVtPgxwelpXRncZMUS3P
 MdPYXiEL8VQDchdFQNlT8daNCA0TyE5VlzFrTNjENkSpI5wVKo3+OwZgGyJ7g9x4o/4uK1d+G
 aNwaiR9LJv5FzZRpOKopGU0NxWyxX+3dlwNAI94hxFvsymqd3ZyLDv905TsLIxMFQXK+yT06V
 rESgVXO8oxdwlwiX4iDn3oZ1mhlyp5C9ZZwTLqHAZklqBAJFwlJMLa5faGAFuhdPnpUKMDJ2/
 sD3r91iAVtnRlBfAZ52/IZogtd4llqEbtQTQygjCBAIcgGbfjFkrqh4p7lV91htWEY1RdmwYd
 9YwSzcwgeXD6C0Q5QndQZiac5fZ01RXPmBYrD4qbsT6pBfOJdZfn5d+S64hNNT7QOqWwPtOWU
 BC/AfFhwWDdjU+hD1Roq6uutpLKobxN6BYVldmNfKpZrSDMttyhLhxIGtM8L2gYcolnBCcdk+
 fNKkLDzieyuze5bplysTI5x/s26CSZFypik8yAPhlLOjnrhqH+1li9HKlJBNrw43YV2wbV2tw
 IxntfP4bTAoJSraERUx8aiUDWbIx7iKcou4p0LGgDs1w8DPpcg9hmdpYg+SiXNX2/qbF74dc4
 vNY8Czf6PRTDaZe6gQsjxRicxGyRLRmy2sIcPqDY3RCNlPaTYCoguNZO0ukX1YEliooBLoV6X
 ycOkXb8V7+JdnMBBUp9bdnr3pGNTqY6lkdnkznk2tg0iZNjbov5gurXIIuTaoSorINkhhJdBX
 GOBgZgi5tfn9R2itmiIburcXz3b3OC2mKtjktsiOwc5C3IcH3FlJ+rON/zOvwcTwMNu4XZNA0
 nRq96PYdxxHEclmsM5JASd9587WGBpUr1IkppfhwezFmhLQkl7G9C+jYSb/3L+sRYV8ibswnH
 mI12bgH8SQOkCGSyQS2mviIleuOdPjblzeyh/zNIbvh+OJC1iAhun9roY8ryg50VbKo1KJPUk
 5LQeyXXGyV94+p2s/FFoSyOKwoAMl0jTZTMU3TIg53ZlLXTQNeoI1cnadFbLRTsJXb6nw9yvg
 9j6go4XYsfqgaT/NB2ll+xtA+D0YR2icqMp7+CQ2KEDFZP4kieQei990qgBe/VFn/utoXyh+D
 iusTlYdXbtSt/4OdOtRgk56YIil2g7afxOZIRoGQTAweD5caRDfUMyuFN4qv5VLUQEktn9mm2
 U7iryZRBuRiqA/PZ1KufVdRhBrhqKnO4NCC1cVOM6gfDXXf58jAp4MWH8OdcKqcBoEluiqKYn
 nMWvWx0e2AcVwGWCj+ImB5tEwBTcYo9JFjIV1SclyLn+Y1j8OqgpnZsdv4vPS1yJCryo914ec
 /CK2pjQd8+nJws4swLpeqpf4tH8JFxiKQMIyULu0JJB8X77iX+/snhIm2SCi5YIS1MdQR9IOG
 DMAczYSySs/gME1qykPsrcxM+UjsBCmnqCtTDzkpp2Tsy73EgNERgHN7g1qS5EZuZNrfpUh3A
 Bx+JC86/w6iKT4YOxdsYaF9Vprs5eDmBkzb20biY5VUxwQNW4XZh4N912ikXy6WV6dWPMwcs/
 C+mg60XmjB6VDBXa/XnhXuFXlk4O2RUWWn14NG7cW53C6AvwA0oma8CIZavG/PQ7dpGVk3rl9
 irWn2btgdSrFhqXVv55hJJrG1kQeZV+WzcoOd0OnRmOAI7f3/HPBp9hxpmWnlvCKLKAyDylSA
 wLhTYqxcwYPdfXOOzUiBZUjvU80dWBc5pkt89z9a8mvbdJIhczaeQ082h+sCv6k78P6JMip6Q
 WoVHqcksUXtmarf5E+GHhG7ZugwycC0EWSgjony81YkyqBMxUfYUGwWajgMK+SPvp80LhTD2q
 agJlmmZFv5YbTzNVltjWw2mEXQFgXFkdEagIi/JS3unIpus0YNEi/uGK7A6Oq0nezCzwssu6/
 BxBzwCPdgRT2n4WjRQN06pPwJQtfdKnMlRAZJ/UGm94G3uj4ZnDsvc+2iQYrC56Uway9/Jmkq
 FMCyWjtcCXPDZ7iAxJ4ONe5i/1Bi0EdtIsRaXqoba+adOOnGa2IJ3bfOGZ+lxKviD2SNsURbn
 x0l3ek1PYCx4L+8T+iqycBNXjAYTG8Wq9e3ccpiCkTEcx5nbtxcbWrEP4j/mBkfp5dVyKfHq4
 oNCj0lzbaayjLpLBcZY1vNKrYaclr/L5tob5Mlc2RRBNbFIAj3NFif0XOrJze6tdpPoTZtPyd
 Q1/86yi3HL2MT9OiwLpT7p9KX9BPatuHcvjAy8pdt9QBFW42lcmEcDx+B49Nz/OOfBZXF0Knk
 X8CZwEsZq8fyp3aEsRvA6PjkQlxTKDslKLkLB2wOsNMO3RovUMty8mU6Ykx4kw4fSPhG6dAeC
 BOeMWM0+KVx5zOPULI82hk9yimfAaiyHjLpqJXhas5q5HGG72qv/QBwYJkYtF99QjXnkYPvM2
 FNJL85hhaGd+zwnO793e2rwe7cmdSjcAEX6gLuHmFP3qQrxRFByJkxVBrRP0pnsD7S7VVA+OR
 SBCF18eYVPlwFdFBMdAF+88QgBOjlbpMJQt8sNCe2MKaGcbANZu4jP0F3yqgJr6G/OfN+dzPH
 9oQ8t0Ttd3ayxO6YJRmbk7r2oNFFYtFAOXfkYO+ok4LyGCbXcpo0+k6OkZzXJ18l4Z52QIlRT
 Fif1DTpGHlpQ/DCgeF5W6qShEUPyloQy85mScLfaTvCJVbfH1YUvBJRumN1gDz/uAZWEFMhuB
 6yxWbEZD1iz0prVewrZAnwd7tdg6WPpLskt2lCHviQRpZBvMB85Fh0cmdyLEM92q/1O7ATmiw
 LysA4HA1Tjw77eoodL6Y0AQEl0ObszvqJdST9C0k3RE45ZTku8qQyWXzUmXj4cziDATnsfewE
 wwipAbQaTNpoeKJq4Fcasy6lxYpqakayArE4TNGoJrsUrcy9GMX1bsbBSXdVFYPJufZwRyvRh
 SevFkURlKjh1LQAi/ZZ2d2S+OqrzoRMBdjxGfoAO/Wuo0WSMmPnDfmv0+0gnqkRNYQ82lfS3H
 n0ydWBnGNGKaoSll4Bg4Boq4v9HG434F3eMbUVIQ5rB7VC78F5WooFZRR+O0ny9fXZ6v8N/bc
 YN5gCzNic+dWvX6mud0owh0qwIKHZY1r7a4HtaeJRCnlNlRQ2nDePdlibizh9AnDzHirfzvcs
 inFDgtTCThk3z93ynvlWjvSu57e/gFbUZKUjK9LKK/ktL7MPz14UoMJkbZcS2ZnuxJKrWPluP
 PrntOePSAWzxYYO+Kkf0f2BBDKJUL
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


