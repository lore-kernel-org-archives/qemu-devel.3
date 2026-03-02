Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98360E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1it-0000Fq-5u; Mon, 02 Mar 2026 06:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ia-0008Lk-4H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:44 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1iY-0006Bo-Ey
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451940; x=1773056740; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZLqZs6V7v8fVfT0ImbPsISdyQrsbS0kZa7TV0/RoYVMNXG5F+5GrF/p+7l9w21jr
 ZSMlvQ7ggO7NwiHzVB+AJaN5tst6MI1i/zqgQD3ZxiHrEkMB5j9TYGj+Noz4tNkDK
 U+g/3VHqty9J9bBMRHfi64CosPezm1drlPZ28NzLGwn62ALlH80+ebFd5pMGSmSA0
 630MUYzMe4hShIWVWjPsMsKRTtBRX7nozCwLAPVLgdkxhgutFLobGUpryYfvFfD81
 I+sVjOb4nZ7aNtUjwSEQ/eb7DT/eArCSv0hKXghjOdrq7E9+XhRQJr1vOusihlIVS
 9GmYtJ2DxwAV6D38fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4fI-1vqw6T3p1u-00GP08; Mon, 02
 Mar 2026 12:45:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 11/21] colo: Hold the BQL while sending ram state
Date: Mon,  2 Mar 2026 12:45:26 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-11-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6UH347UxT0TbJUp92koPPgqwwnLOU5m0k39
 AVvjU+rJJ2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WKDZD/96ISCOzA/5cIw7afVVdtbWjS3+WdEWTWPB2hDBaIzPMHRp+cfw8o+7UhDY9I+JUl+qTW9
 bxifO39xFtRP82No1Iw797IOUWi0tLkqpafl3tmJCsurG3Zh1+MUQNQpKPrSwSwHMQztMjjjqaC
 VjEeWRPMYrLhrYm6n+Qf1olZZsBzYL6kJsivRGEylULZiQyXp4mKVVPUPo1dIQ49rwQLBwIvXZ+
 qHsUXcROrLBoPKG8NDolPlWW17izNUQzn50+iiaPMsJJ0KWBrtepfM4auEX5E84GaoiNCOANLzm
 +zodP4jbtOl2rX3nSitneMuXPVdIN2XWAh9M2x4tcuQefxcLWWPP9BvbbEj7G/9Jw0HTQgXM863
 +BWdRuNwjgUPwj6BJIRRVoavySjgp10CT4uAGeT146ZrE76V0bfHyj0ACaDC2/D7OvyChOr6lUT
 XCvbKAD9CwIlFnrzsyh3sPBp6kl1FXvAr4YUrO/DEQTszLFXjYzarofBjrYwPuqqVxsAP5zWALf
 Zf/6FhTd2+t9/sLpt8bnooQKqwQUCcIXJyFcbLSrURK1UEU8P9MlcGORNNeUNLBJHNmLokn86sP
 eBZiLyLxCqZ1WlJ8JtxrtUprUy0GNvSWZOTYnnpFWXgIfKk2FhuSzhNOMVKMyOJ5TZyZ4o9bXlf
 NlZkuDTu6iKKL8A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hPUeje1DQ7Ce0REWq8zHr46vjw4KWh1UYSZcZVajT2fUwPkmoNS
 NKaXfL9RyW0dttVIvIcCF0pZ2vi8Pz4OHRDSKjfvp8VTpWcp5BtmfpyZhhnQM/aMmvl23BW
 oa/aG+yzDnrnAXGMGlIbQkLNFxcR/w8Pv3w84nNtpXQh4f1xWQDeWRkilvDaSczBZxTL6mj
 YwaJPYZIhM/IDvMMZ0wNg==
UI-OutboundReport: notjunk:1;M01:P0:Cmm/Wn2e1hU=;a1+iV4KiKxstBRnM7hYIuU0C07N
 JaRXuxmvGJ13aexxSYC4MtAXXAVEUtrhxMPviGA9Zp9aDopRLmkJ5OSbvOOjlPvk3no8qIKVb
 9GuHfNnV8ot6d5UYfFki4hWq/M3Mn6/p6GPqp72fm1mnT3ckV7c42rhE2B+E2aAb/riKCvTpM
 pp6jN5umJGZi1TuZUBSrW2JbDA+xEhClWuDoSuu5Yxrkoo3JL/5RW7oNc/FIDVUsLR/JQo7/F
 0JsDPVRdE1yci5P1AR99yVG6IXtb4bq+Esdi+lyA6jcipTfoJCr0SMzK5XVcsYdDM2FfRrSIF
 46Qo28odol8bRdNtQp1+qYI7RtEaQxHHGsplVQbIH+1oMM1M6DkUo7FON0fwv7jcHTh0c60TL
 vKgB2tRqhdTp3VBaeh8g/bzEmXGQ01S/y0BUZ4ATTNMWWTg4So8FFLMQlV9XA72dCFvYFZLh+
 pGBmzGDdLvn25yhCc8t8ef67bLdj6mZopmePpct4LTw+CjeOVRQvMVUpPcRHZ99rdYrQUq/1Y
 jZzGJZcqHRiqiBV0QeV+Mfjf3I8klcI54Y/n9k0B1XUs26biMiH6d8Bs/NmwmDY9ikJy/CSRh
 /6zWKudALHRiE8iQW7Qt6sWoDodGR5tGByBSy0t4FTCHudBKdYfcGH54eisATrm02DqJTL13L
 R9JZ0nA77vcMlYnpk3saxaeLtNpMK65CqG5RpN9nbcAB+6DutZuInAm0oapWV3GSX6Cmc/sY6
 74HGdngK53HxqMVrrtWPAUy+3flnMWpq/z8HzF9XDdhLTQpLKZ0lnaO/icWvGIPgw/K9xBFKE
 XwELozECo/qooZwBzPfm3vVG6OgLm0igF7+7SMXsBjgMZJ6YULFyWM0/leX5msO0miAAcT7ab
 2n0jtyAw4xufcNd1whpqNSHUf9+rTNLUg7KddH8nkU0auiBVnsy9tEFc3tcOtBXy/wUcEDjI6
 Pm5RPtMP8HR7vWUJ3tZp64IDyxN/9kdCEoMYnE46kKDuV1fUh8fTur8IKBYud66t0H8NIX6r2
 b2qYi/iZMR8ns9/6uaU8TxZrHfB3R82PkzRfoiVoAOei8OqqCx8j9PHVq0ubTfZs31gjv66J7
 /3mlIcPDmaTnm9byjzu6tJ7GJlVCpz8BQZMZaGaKukWrNNoKAcjR5ZeLkN4yK9BI0C4IzGkv4
 hYAhlkOe2ZA8kcKWEfa40zwFtVSVtwoPqgfIZs4MCl2ChaXbg97aLnYRrE1swPsHak67OxNxh
 aXTrf3g+WN/MWVUDlNfpHbXWfk6EZMNaXb8AeCJHvYjXJq/a5XYCFexEVqQSpDNV0j4swWkV+
 Dp8qmnrBCDqyk+DWHyHM2y2+Ys+krOIS/AM00LYyBH8ocY6J+/G4Dk8ivRdm753TLiOT7uj7z
 D+bBT9ImALwieIbQtbhtDMqp5XkxIRPbr0eB/VWHtcADnAwRTSmEzGOY24DUUcLwtD5+S7pG5
 vPzc0Smi1RXajc5yIGZroueHH3vj5XfXXqaUDazGRwXVE7BoCTPyYsqXMmFGHeqvso07BELV6
 tH0jB76V6hZXve1L88jB2k7kfq4PYjbWgeohCzh8++mBDdV+AxuUUV6/U24o8o3NPdMwMVTZR
 ZGi7vJuY0uujxolcKpydTz4NY8rij8dmFwZJVJiZ6ui52MmGxJ3LiY16Cb8H6yFBzw7Wlr6t5
 ekhnf8HRCUBDdi+tJGxZ0q4C3LyZQfWew5UQuv8QO0vugt16L10ZZsmd7EkTJZ62eg/p8WA5I
 Oqvfhh0FOjQAGpDD+doAyueEJO4Ahn9r8kbGC6gfLxVdPnueNqVd5n/r6pn+P+JLVNoCMmqIE
 0Qi+Wg3fDseYds/62aiJJlHZqvog+xZ9AbR11FiIC2WXb1L3DLpTIeqLh0BWCagpYeNaPjTyP
 gjyeTWcfs3+/Y1o8JELAk2rIBO9BQiZaCcX6vzzy5SEmsJ3WWPv/s0FDFTqyOOfwIpHB4XpPF
 oJT/AQbhZRbdFKUj23UfPtUy+0wygFMNabU70zW+2rMTKz46q8OJG/0I97suWIn40Q68Deudg
 XENxWx6bb1WawKOSHH/oxsWAGu3VtDb2AYpWbWlgC7l1u7GMogQkrtwKWXQEvlw+oDqVmLe9i
 WaYjkbRC8kBpLEhEJX2Q+tx3jG1Ia5khKcageew+TMWyGwnDq8kGLvmoyr34ASXmiXgamgMUg
 WHukUX51g6jjU0PnqYOGxhmhMvwxJ0NKWlfQUS6q/puyLQ/9JMWCEDY4agbM/uC2YLxsNwsZN
 8Z2A1aA4Ejay2uO7mg3brUCoKBSet3Tj+75gHX5eXpLcBrtFs1X3sjSRwUWOBE58uM+zvbzVc
 AISqDWz1Y1w0PBAD6jDO09fPB1tRnFSUbmgtB5//CBBbYE756r4QcDcrmlvs9OcGTlTbW8izQ
 m9CZGkouVNC+g/QNKbToJGtrOD7NjE4jLQVF+wF+4kHrmaw2VUCmcthrRm/+quWur3DWdkwBj
 mdS9ZiBifQAXLD/ABkNlkse1JtZR1BvMPB1EYMAx8ZGx3NpMrC2ITOmgimUOBFQRAXaS1pxZ5
 9YKo37UwubEHHV3vZxD5OuvssiH+tf7LUErdSkxECzWjU2Fyv2nuaT9xvaRbFMfXRJ2XTNopw
 G7KHnKUTfyO+5uN7KK9yEuu71mVk5i7aru1xLY+QYolD8BIEG3WD6MZ/hxUpwAq5MVQh93TJk
 ZOGfRTucKvuYcL0e5+9obSsUZTmtOW6Axw4pPz5+YSq8owidrsCPd8uy0DQ9GZrn0U0AAfzMt
 Mpc1WNAEguwb04lmZzRxrDnnoMhvel9EEfJqKBJrOLSuhPD1bNUlAwWKFnXChnoFm/Tr3odbZ
 CvvhBER7D8y0QcnC/R30Z+3W5u81eGQ/ChTLGeQY2KxzXB1UsbvkiEpOxnfZMBDRpL6oKG0wS
 xzyTbI9Dl2L60XT7K178ZXdHN63sOW8Csgvido/shaqy3lUrCNROWjDI8wGACfivI9TtAG5pl
 tHoliAzIv1mli7L8lIxL7Hy60J4I4IFh/dZviiVjG3T6uj4KR/W1JS88iIQHDoXwoWRG2dGLw
 XsuSUPCQXWZcQckZbDQcClQIvLXg2t4iUvkXs0OQylmss2dAu/TAmXaW8kGLFA+1JQR60viNG
 Z8wHDUe6D49kGsuQmDmaksRKvzHT7xIFZ9m1Z+1YppggZhrc1MrN2au7b4FjsvwUb1PgnQGIB
 hRFEbPXUX+RLZ1vqhpwPBzv4Vf3TpMZhbF71DUwkNJwCSBZKxOHfSmGAiBAECZ/NRMZgn3hlV
 ETxNvZQNRmigm0HOCJDBYEyVEYprQVJNKRg3D9P18eAuYiBUMG7qL9wnCh9yxu7DgIleZfZO5
 KXQJKKKvOYVRPgLYQ+nXoUPjTNy5IeonbHoXGm3e74c8GR1PkQ7hCWCd7iEzJGwa6UNRJzINz
 Jax+PKcaLHgGVX9S2u81UfaOg9y+hQLS1cztYMJWpHp9oObRkIwK90lzF3R7WXw09GOQve6DQ
 bVFyfjpQqnnYsllqyk7L18Ve60zCBoxT0kS5Z1KHnmcoA95bcOqz1ZGTtjTm7o+DhEZ1cAgXA
 p88bEZEvTr4kakK9m6IgNzvSXz8WyYTxpplGWCLp9GfCc15H8OMXJTgu0+TxWI49ZVa/eO3GO
 f1U5XikgcpbFbB9GrMzcaPnNlz4EIHWZF+ch9KsJZ5JKPF1JnetYOP9YU2sKcBvriNV2btYO5
 2Gq2K1Ddps0x1fhuWMxvAG2aXCSSsX93uOp2DsB82+6x2c9h1uTHs1CFHH9j7QKl9+GYEWQyy
 QPPmDMXar5f6uoGrHld9FM9V69Q/StIjwmshUZjgQY5fDDhPNYP7Ock15t3ZcQ9M48mEzLJWW
 rpQg/IlAif1+/W3OWPlbUCDiT1U80JFgVEAOlQkR02fcHeDD7x112FZYi5eRWW7Wbpn/LiuLu
 gPShsdzyFajEvV9zRCGM1coWRhF/X0+i7jCTBLV0fQerTQIX/35mkUxPYeATvJOH+tAf/FJlI
 1WMKnPDdocwuCzESFF2s8FBbnysWsGogpgOB6H9vJ11CHsrcakxUoVeoYKF7HLlP9DWdtB+5L
 0EYjjA/o5GaO9fVYPaX2sASVrzhoPd1okfack7mYb1wVfIqCBwH9B+ocZeRd/HpYtKvOD1QQB
 Xk6VDvAWvQDn1Ol7eckCA2fajAKPDK9YVvYi2/oVEiqm8xYMsWAGS1chnsI4eyjoIUcPdJ3l2
 oGWkZ3r+HDxQXC3+xcpUjoQvaOvxuAxRUH2YohFpPR3kTkpxLZi/YKuVs7OSbiuR3jy/EzEdT
 nhY4te7OZ0n/TGdnLKOZcVP05nrjNvXY4rxWezoS+yc7Faq9iF8WwuE3I9DSEi/+CO5+absRd
 JW0bro906awd0nACvJNsZzHa7OcyTxIHajPLOM84KvJX1ejNbJsIwGZMlh31w3eRvoj2n5PYN
 2BAusDNOgJpLnt357SOyGDY7H3VHlE+CmhZ7cOcgBsj836DfS0RBgC3zmz3Trt48FnyPxWG58
 hNoRvcyX5Arh9I3TfEK1SVBdozJDSQRxnibVMQBv8LDMVP6f3oGnU4ohLSP5N9Axpi5pg2pIf
 A1jsjUuwlY+msnFs0qmDllg4PBsxIPUlNy4ZfwpRlix9zQdmPBYPr/Z0y08lh2ZUgHLJ2LUYt
 wK/cYzDaLcJdbNV3l6UBuYcqFpcDFYxLMTwhdmcpc2palqNZL1/I68fuHEq+/mv6mqnEfQ8ye
 prJeNGhd3HYzcm1mfRBQAG4IL9XIrCf5DRThH1hqTbFdGfaHn7FEOnQucLibg3bVv7DvjqNCk
 cAcp986aQCCgANUCzJ3pZbL5nwy+Rdyn6v8GciJ028LVtlf0NrQB5C+d6Gvbe7jScUkn1WI2r
 m8ecJjYwIOgnu/xtQsNKO5/Mt2De8pAcCy+RcIelc1kcrI3s8z0q7LtiFqPLMghkKfjHxaBfi
 xCMeUuAcuM4vw5ltNgSPYIyeZhtN6LhtPxtZayRt1aRF0tGNZk37GrasqYIS+RIqf7ePjMaKL
 g0gDxlPxSBeYLhOPV8w7waFXo/7ZsJ02EeXZ7yZM6eka2HDNwTKJVpywKx5wn9+arWJQv1+oK
 PsaVyo2VAl28Es5KWWPpA96fEG4zxe+1gw7horGmNdlX7qVOMPq70cIo/eqHNzeNkAv+81GT1
 gFviytRMP1Eq4bplE=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

qemu_savevm_state_complete_precopy() requires that BQL is held.

This fixes a crash when running with TCG accel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index dc7cfa81ef7db78e3ee372642de48567c5bc06eb..3297aa593cd9f87bf101359846=
4cc581a9d23531 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -455,9 +455,8 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
=20
     /* Note: device state is saved into buffer */
     ret =3D qemu_save_device_state(fb, &local_err);
-
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
=20
@@ -471,6 +470,7 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
      */
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_savevm_state_end(s->to_dst_file);
+    bql_unlock();
=20
     /*
      * We need the size of the VMstate data in Secondary side,

=2D-=20
2.39.5


