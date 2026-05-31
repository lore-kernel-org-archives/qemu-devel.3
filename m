Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF96ACD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 22:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTobD-0002Ty-Ie; Sun, 31 May 2026 18:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTob5-0002Tg-JI
 for qemu-devel@nongnu.org; Sun, 31 May 2026 18:25:31 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTob3-0001kl-3u
 for qemu-devel@nongnu.org; Sun, 31 May 2026 18:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780266326; x=1780871126; i=deller@gmx.de;
 bh=GhtXO41NDJldsfTpQ02qnWBSnzsvy4UiLdtWs9dm7XQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kHAO85JibmLRBuSnzr7YF3QUFOyJOJUD4wtz/JCqF92sB9ACMMxdcJsvxgi7a+sO
 ZYUgK13Txe6kyowYzEFAnHFmsj0OVfQPuG6bvdopA/fLXuIIbBworpNemGq7BfTBS
 BydQfpoK8lvKBfHkfLMee51igPHTh5j6KMsqhOAN/aZuyLN60dYWsSJiQqcczgCTD
 d/S+/hQ4XSMMzrOjQDTFZq0YEPll2Qu6Fr37N/9xxpuEf6DgLxgmphfNDx4xn5xEj
 4AY4fmchAfRBmbrfEkVqrDj8C86xzGw7jdVT0UcKIyi8CkEX3n5YaxE+B9/eWf2qn
 4NW6WHp6OG3Us2Pc+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1wVh5042UJ-0001Ct; Mon, 01
 Jun 2026 00:25:26 +0200
Message-ID: <a7deb6a9-6192-4b16-8374-506c79729417@gmx.de>
Date: Mon, 1 Jun 2026 00:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] linux-user: Use PGBRange for commpage
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-6-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260530211248.375318-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mhLoI/wibbunBWYxoycY+9bteHiN2/5bgN9WW5AuEEzmwleqW3K
 DxXEo7HvuUwMtsGKxEpzs2wVi47G1O0NrQ+eIXZyPm5e0EGhY58WrRzECKPdUbelWC0IcnV
 jc13jyx2XHs+Oz6TUGVmy7Ls9Y4wIYA1K6sReaVdslZZvXn1PCC+hA0H3MikP86FQqaGeHv
 fVdCTA+A0rV2NF0NbOhpQ==
UI-OutboundReport: notjunk:1;M01:P0:HcqFJU3wPWA=;BZw8mAaYFhBH46w1jrHCuloOMsC
 seEPCv+VWDgBoz9ASQX12T5OdXHqm8RPRqPxQmbQV51jtKxH2cfV1o4F9LCXoNfOl5m9nv1tW
 KtNd7YAQFED8pHXJP0JqAF5GUxGdyB18VCrNGgbk0dpEdseSFATpZHPteCdf7gf53EXxoE4cW
 NS6IyB0SYruYe5tqdZr5MJnuZRLl6K10B80JqzHs6AGUBeRiLd8lXQ8nnKmHcMYg37IP4Wz/Z
 7JSMXu+DoD1OzXPA0vWaJR00kINzi8jNk415QTl0vgPzYG3aiOgTd/v5ZPgJhcWof1FCDBII1
 FbukScpKErfDfLaFX53CG4s0cZFTAMKUkwp8hOd+kB+eqawYurMWAoFW4j0inmP+k4a026q7i
 /Uqr2JVd0d8K8bm1Z0exD2mo0vzYh6mkh6R30G/tgvt+tdOgq0VzlUyLmsMsDHF/CNwr5AOAw
 n0yZX0gCCSuSNtM6MCEHot4J+RjSO1pDwbXfE4ArzPA1YlBvromqjc96D85SQqrhuL9b3lehq
 Wq/pCJ5hswPGKUXnFjiqsgaAN3DH1T5td0oNeYzYYPMoAqMmP+1QIPBWycKlez8Ei+wrq2hZi
 5GN9a2gp+/uGJHH8U7SqiMbNI2J1ir2DvVRQzBGp9gbByX3V6uUF27lsG5BkdYuN+khSKLnNf
 6kMJoH0xSC0J65o3j2MDIDo3E3W5AVu/dG5mPgynUdzOdQ5bMslpXD3fbr7lAgh4aHBH8USjQ
 ybiwNN24UMqNV+CH/rM1GK8J4f+bsNBUJcHT4XkSzP76kF0YK8qU5TIXr4km5uANmUUcMsuEx
 OfKo/2jomWff02AjL5GokagGN5BZaPcmNnnqYnGYFVm5zgjVM6i9NyC1j1ZsmrI12ybFJlSJ1
 SVfBQ82mNkcrwm19jvewsXEsXhCWn2pPbE4ClQHT1MNMrYLnEnOSDEH7kPIrro7FlDCvHueXk
 dOmlswLZZVmwK4eQy9Bge38F9OlQeX6by/k58FjTdLe7dz3a4tnU1uNpMNreEX6SSZVNy6P+Y
 yJGrXwG6gYwuOh/XCaDIN2DHRDxy1CJP9EpLxS3t/XjkwGpj8mu8pTmQZcJIceVHTq3EXt9II
 uhYclC2YDcQgNzqw7xldzAC5fcwWRGL8pg6L9LXusmCJNxzb24flpFQKdxHh9Hj8fOk83gPqS
 Sv8P0Z0ltkjALJ3H9VEuVR2JzBsyYDaWWR+aWIDcX10aGCtvaJaZip7+zetTByL7QR81rOySg
 iCbts1Vj92G4p5DiXoCkjDEVfdbU6UAKRSVChsQaEicH09fU88cr01g/sPw+GQbQpb/N/E+ZD
 5JQRyUNfTggFuG8oZTUxgfShL4bqfeEu9HjdRiNOKUdL7MrpW1EFZ9wlxnWid1ZB93eNVLnkk
 NcwRh63OfgMcP81DJ14oyTFfeoMOt4Q1CWZtLctrh/gRcHQKy1jlCEnNGt/erc9Z4If6RSP2O
 LFkwCn8pIq170Fx1IQuqeT+wrr0BYAcbanOx7bmTjl6dsPuRmZ9F4YzRgdA0ZBeyahWP2Vk7q
 9gXdtzRa/zoJqIgsJsL+PWR26m94FU3ggoAz571QyugJQyevPAACEeCZHi9lxWPuefiC5+zCX
 lhs0dVltqRgJZGASeY1Pr840OL32TJabCPVUnLvl4AmigfwAT0wG6Bjzl8s7hcDQ7T2VyeZmI
 1wmeUjksPVliJGnhL3no21I1tVoMRjpK801mxzAsJHE4SWpOzTGcuAsFLTQvGA5qyasVuw2l6
 Duy3xTWhsKJ6xVoYjrM+a5nx4yq8pdQPywaAspaBYLXRq7A4RNIWs/WCbGDjrtE9Ny28rJ3ts
 gNR4bWwkf3rQ06EObznoelJcpp4m16ztPfPi5t+DPCPBEGfv10tdQnv+3EOgiYxw3bcPJ/Ium
 f15kacLO8FfuNjlD6dZhSCl074SNvYHEMnGGwDeTkrrkzhuzDine+nr147X0D3Fs6ax4WgxeD
 LKi/T5FF7FSTF7aaFXCF0N1oqiWf4GFKvMi6ag1fBY29lwq0CSzhyusMOt0iEWtz7wzRcScfr
 WrUvuAwnh4lC7xikbURpoFjrngNunkIwd0+28th4dVEFpkwCn1TosLt+6isPtptT+sK02QMNK
 0k5Y0SHUYVYbT1bz+WZIjH6d7Znl9IlC9c5MyuaVUiKfN1DxqzYEDZTVG3/kVbCzR67kCDm2L
 zOSOByFhkQWDjnPrlkFnzA/ZeorzuL8u+JfuvN4XiDwG9HpUsxsE2gU+TPE93E6U1g+Pfy4ca
 kdT9HuMxEDHitllfrHhefp/e+PVzjkrlaT663z0Y8reNWixOncFuasZjHe0ESSGNxdLzIEdm4
 5iFCQmOoqf6oK9+X5XfWzdfZFRDzYMSR6rHYw+ai52zUwLirNVdC9/GoFSwa0ehzhvEdyTEmV
 3NEwaSu+DsRdm8WXYjimApuEULwxJaJRHJlRrKJOaYGEacztUtksRx2uBZs9UFCPnBrMJ73fk
 JeRW4eNMMyXvR2XXo3ARK3LCh6x8Vn7vdzds3SGO8DfLALyYDCINabA2baBjv0k8YqhDso+CY
 2jxMcf4IMPfXuw1FquF648AZsVOdmVWtmcRx5EEo0PR9YHCfdAwdBQRh893Nwp1O49cJ9/8NA
 XcsChjzFRnAnGd5drbJMwoU2XqBPAb4WBw4a+kmZhhMgThm7uhapxKjX69vdSOzkU7qpu10RH
 vugTGneZShVzi9Jz31Sk41NCo75SyltejB5OxofPyCu+PTguCqY2GS1t/W2VDQNxwMuvMMsIs
 U5AQlwdfmmKMekuSckifMr28GjbQKfl9W3i4KjfImDSPq0ZIK5P/T/NNWPl9P17ex8aERL2Di
 W/k4skgF6kPmiNRzOzuOlPIFzVsrg0T9e5fl7t3YMr7JgH99Xl5+4c+mOujCLQxPkl0REm5rm
 86Ij5F1obd6jpFI1F2CSGn9ckqO7uVKs4Fmypue47SYLtfUk/m9/M9GEbK17dSQs3wIxnfBlC
 DXrEglisizCQteYlG6qiZrBP1ai+gmMFTg6BfXaeoluz5dYFMmggb9b+7cKc6dAR6Rm9anYhH
 Ai7XfVBe5lBslR5suSapyduAxi9DjmiJN+y57Y0iLKLepIlL2fQ/lDWf5L2NPcqtDKvxlrL3C
 OBuMkC8HGm3cL+REOMbDtUlCkshrm05mFkkxr7YQarlUj/xXYuWvQnYO1OC2AV8aWuVyDAUMP
 7svPVVHCSxRTAaldLOtMIMN2Lm8skJa0WRGds6AdzqCkmPQOrw0LFc1KUljr73S7twtp8XGTH
 sqq9tftV41zOIWx9pTlBsVGKzQvoEsbk6AgL5GRZitCToCJOIrsAj4AgqkqVyf7LLL74TZDQg
 9MvOODcs4X0pegbf/Aqcy63G4O94RZhKni+pmoXjfy5GvXpDGx3B9Yl//8mFOwh/U6Rya+mvy
 hEEdOv+9+frIFhgAyGNB2Fig6erwBT6eFz1bP1CN4TnHF8Bh7GlzASo165//sjeR9O7hRJRVi
 bL5Z8PUTx/zbsgRwoSHpcCDKtO7kxmHEeX24a7STleC1zJqrf91usdKvl+OkGuKKVyrIAOtF7
 H+YGrKtK0HhZoLYwZHZy76N9IoD2BQVtJj6pZ70MKIncoah+cAjUqI3XgyBCkVdc+NFEgf5lE
 EYTfzZY050L4qUPPZ18yhj3ARSQjFqO7y91rWCFhNDftawbguABm2bmYfI3Rv9s68ANHBqFaA
 oEuzVmzomp2ir57QiEqz83xifrcRkcxmWRh0P08PmeUWVjUDiVDv4QrdzLhIYZYBPG1Pz+XGH
 YdfpjEVEHS+HXyyuQyMPhBgi7Yu7skBfSEpXAnBTGNunUtaGfnLOISP/yYRDclcCGapEmpdSa
 bJGwKnOalnUNoP94RLA8e72jgq4P7wk20PCWw0+4bnOcELp9YBHUL8fnYpzTLYlAIi7U+VcCO
 trxAwgiiQWSizoVVWivVUGFcYi0LDm6qT39YiSpx/raE7eLiTQDrNjZAraJMMzyslCbUh03Ss
 xPE+MxBG5xV8KoeGIKsl2Dv+XUOm+vcWmBxn4b/6hjsXbFY+Jt9epuHsAImAS//KFUDFS+PiS
 CmPuhFL5rYW2qd3f7Bjlva5j/W5oo6PjYlh14utw7VZikWZPmgO1bdowrfz5ZX8hv0r6vYjDD
 oC8alJgnuXSMSOutQeeUcJQQMJWXcnUMIwn5mTmkymnZgtfkdrqNuacRkjAqrHzngSwBfwv7x
 sA04K3+MjHPWF5gUjNU6dAaBe1GLDk0Axym2ZIGJEDKtwE7ztPdCG7cj5/JkXMnhXW1Bn0Vxx
 /PSeFqvskU3IIl4YrOWtQ/5mxmAamumgocHyaNfqtH55saxVOnVeseue/sQxgzcLVetROikem
 nnvZeN4c90ic9x7Wn4wzrpbiJRlXjtRreBst4F8tlZvp2HHPWwASfquauRNrnMVQyfeLzAPsV
 5EI23eEH5DceMWJUEDeQJicshpaXbvwg8J8WdOz5Yuur26B1UqY5X+/QtNUq+MXHYj59X9yOl
 bpMFBercP0wRY/zqJGmfSWnEjqav2kZ3I7af1xBjfsseoQPjGe42w7HX+06EDiQQqX98zP5RF
 imeX7LVxpsoFxzP9QZMqdxO5cRAiIuUC8rXRa/YLkPEPe6oLsYiK0OLDyTbyPFTGwIaYyDpOn
 I96lkuXjGmdvt0uHULbZU3XfIHMOBvyRA3Fy9ADee+EMFbY2z1/aN1Dhh3uwH5PfLLiE/V3PH
 rFsyKuUZe6rU0G3kZG6nYl+yx2GuscEiPJlIGAjtpGxQ/ZKp+XwzVFYGq99A1JSlOS9X5/VcX
 3uOyP9lSisNlcsVF81qekivAykLGsDNLcAMov1gBkIQPbqC1FhTMqCrJWsoRvh8XXTMYHMmst
 hY+y6YpLS1X7WRYuqrtD/6c+LUYR/wcTNuKUJYJwBgCdiEeGbatjNB/5xF4uWoti9+xYviNeC
 DZBzvZFV0eVMqRYXEkxNpsG+sgDmnCJkKotfswfzZ23Y/Dbstf0Cr64gutj/Bxs9kqgNLfe1J
 XooeHmscjaYHsSU8IDAr7UTDldtIBV8LLdwCGdZibNNENztmK25xu6UM+jSePw1oC+rz6qc0t
 5438zoB37bkHpLC1q1PniVAn+cUWqOSC01lJn+KJI32/kWw/AX/5Gm2YUmFhNi7sBbvbCrHAI
 9SWjuSUawBBc+H8DSq+r2sO9VzzemS28DSpH0IvVkw2xbB+IKBGq49ut77EM8LptEAC0plG+D
 yqg/y26PKZ5vwnhRmuNBPW8H9RQewIK767JYYXd1k2wJDOCbhaixDUf7dUF7/sWEP0SgDVSZl
 mr9bdzhzNjczfMUa2PGDRvlFmRcGHcmCgmhLu0ZLNaxS0tThxqBdjUWlmkeGkFMclQ3eo2Aft
 cWV5fPyqoNcJCqsDhOncsHlEJ6tBsNVChR/RuI3jL2AmSKwZvqbutMc2jWQ9poHfYylA/29LR
 06+N/lQwwmt2M1+EfK75egnF8hYtyj4tIoR1fDEpeKzi5d+g7VYXBiOfgPc5MEGIIlSXBqUhG
 Ise5jSkTSxpeWiXuYV6oAlmtwlxSktfl6lRAZ6Td45j+VfK0jPbmMBg1O
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/30/26 23:12, Richard Henderson wrote:
> This simplifies check for no commpage to a NULL pointer
> check, rather than reserved values for LO_COMMPAGE and
> HI_COMMPAGE.
>=20
> Unify {LO,HI}_COMMPAGE into a single COMMPAGE define.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/target_elf.h  |  2 +-
>   linux-user/hppa/target_elf.h |  2 +-
>   linux-user/arm/elfload.c     |  2 +-
>   linux-user/elfload.c         | 64 ++++++++++++++----------------------
>   linux-user/hppa/elfload.c    |  4 +--
>   5 files changed, 30 insertions(+), 44 deletions(-)


Reviewed-by: Helge Deller <deller@gmx.de>

