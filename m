Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3775CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY6n-0008Tu-BP; Wed, 07 Oct 2026 16:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xEY6l-0008Tc-I3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:19:23 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xEY6j-0002g9-LS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:19:23 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-836ce6cbe1eso24995327b3.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791404360; x=1792009160; darn=nongnu.org;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A+dL8cczK3XPM5mO4iUAQYvaTXxsbpq3dQGMIy3qvLY=;
 b=eyASgXg/XmaG2YXy4wEJl+9QmQaddOlsE4X99rNU8n6Iid2GfC6zKOepdGhen6pE2J
 eHGv/oSqYet8HR5ws16sZmA8uZBquBk3eb7xXjU8mOs32zrIN8OelXtQvtZkHuCg8/tu
 zp5A1MGCLe/VHnP2WqrvPzOry6js9FvTBBMv2T2Lxm48cNOp3NndrvAESk6yIo2xrt9q
 /5CEfeoAT0DUVV8k4eBn1yh27CJgzkTU3zvmkI8uXRiAfIATCQWviMLWykDg3P9biZfK
 rGAVNLmYP1C6r78Mq+P4RlgYi8cKdcuwLfnrp8j4FxJx2s8lSxK2cwNKpqkIiRrVExKR
 EPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404360; x=1792009160;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A+dL8cczK3XPM5mO4iUAQYvaTXxsbpq3dQGMIy3qvLY=;
 b=aKmTO6//hQq7ya3Kq8bchIUvsELYjGovLpyTMne4+E9/yf/tPIQ82/VP/k3gvf1WST
 te+rnPbOUCkqNymqMErzwUwoZYAOEBq0ZaM26CIdT0MdvWsuqtkqfPxwxeaJGScWCOdE
 PH+8UVZj0xUadljh4118EsHFEav3Zbtohhsh3rsae9vabeRqusmU18DhaZeTyMXhQCAf
 hDplxE0nmwNh86A3SEg+Wt/i6f3SA6OjyenqCZ2pK5+a89jT+HPaC680sYFvhPn7IJ6v
 nvRLWUgDuYtW377sc5DikqvhpWGfVjKZQrXAMyKJSpGmD/0XXuEEz5vbsdwND4cpC++A
 cA8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAfTgB9CJzHlOw3Xv7rPoQ67fhP+QJEb47GkPnTxOL+Q8qMJcgyBfpziGlt0G9PHkgI9Cm+bZjqcxG@nongnu.org
X-Gm-Message-State: AFq9FYIckebqos+3Jx+dpAFW0OPsavV8WoQOxvyf41jnuNBwadJWvzPy
 06dn3Wzlb1iLuWRKfvuQt1GSYiNfb7cPUNTmZWjKK1n+GvhKjUdP4zXs
X-Gm-Gg: AYBFou1UwPR2tSUdH7g/sDh0BNkfflXyJhs2rcW2q7yJtIu0qi6nH9KbUuPFXq1CO9O
 y9xRUt5eQ53/uo2uCczl3w48LdeYfAaQHFqdZxIDH2hkv+aIUuSRfZmCqt49kLslEjqik1snRCW
 U9TV+EZpnO90pr22sbwGcKLKpmrzd4PhZe/lKNqOzeBYr5P37umrlsLnHSQySYvfXIGupnozTXr
 XvBKnBvT4VWkE2WULByqV4YA/eJi7aa4ZROCpxuDm6mwk5wUsRaLLSXEBsNt0SMbpdA0USGhLZ6
 TBrF2xJATY86TK5QV8aQsg2k3/wK5VRDabrZdqkb9MeiTKGISp3vgjXpC7Z8pHNvQug00Ed7U9J
 0eENJiWPK/CMHLQSc10HDyDCPXlMoULllbKEkVzSUz5SoW+zrE38y0dfCDet46sAqp7LdOrRVJ3
 pOqFbcdT0iwAy5iwCFBMCp0qCfTnkVoxCG4K/hZvPguhS8fgdV5Drhrdc4AfdXuFiK84kexVeAB
 8s=
X-Received: by 2002:a05:690c:387:b0:81f:e7c5:f420 with SMTP id
 00721157ae682-8b05af09e45mr27812907b3.20.1791404359689; 
 Wed, 07 Oct 2026 13:19:19 -0700 (PDT)
Received: from [10.138.10.6] ([185.98.168.14])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b05ab0156asm12554457b3.8.2026.10.07.13.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:19:18 -0700 (PDT)
Message-ID: <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
Date: Wed, 7 Oct 2026 16:19:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 13/10 agenda items?
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Chris Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, utsingh@redhat.com,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>, Frederic.Konrad@amd.com,
 Luc.Michel@amd.com, edgar.iglesias@amd.com, francisco.iglesias@amd.com,
 Julianus Larson <julianus.larson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Lukas_J=C3=BCnger?=
 <lukas@jngr.org>
References: <87fqyh79ty.fsf@draig.linaro.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49yB+l2nipd
 aq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYfbWpr/si88QKgyGSV
 Z7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/UorR+FaSuVwT7rqzGrTlscnT
 DlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7MMPCJwI8JpPlBedRpe9tfVyfu3euTPLPx
 wcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9Hzx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR
 6h3nBc3eyuZ+q62HS1pJ5EvUT1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl
 5FMWo8TCniHynNXsBtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2
 Bkg1b//r6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
 9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nSm9BBff0N
 m0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQABzTxEZW1pIE1hcmll
 IE9iZW5vdXIgKGxvdmVyIG9mIGNvZGluZykgPGRlbWlvYmVub3VyQGdtYWlsLmNvbT7CwXgE
 EwECACIFAlp+A0oCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJELKItV//nCLBhr8Q
 AK/xrb4wyi71xII2hkFBpT59ObLN+32FQT7R3lbZRjVFjc6yMUjOb1H/hJVxx+yo5gsSj5LS
 9AwggioUSrcUKldfA/PKKai2mzTlUDxTcF3vKx6iMXKA6AqwAw4B57ZEJoMM6egm57TV19kz
 PMc879NV2nc6+elaKl+/kbVeD3qvBuEwsTe2Do3HAAdrfUG/j9erwIk6gha/Hp9yZlCnPTX+
 VK+xifQqt8RtMqS5R/S8z0msJMI/ajNU03kFjOpqrYziv6OZLJ5cuKb3bZU5aoaRQRDzkFIR
 6aqtFLTohTo20QywXwRa39uFaOT/0YMpNyel0kdOszFOykTEGI2u+kja35g9TkH90kkBTG+a
 EWttIht0Hy6YFmwjcAxisSakBuHnHuMSOiyRQLu43ej2+mDWgItLZ48Mu0C3IG1seeQDjEYP
 tqvyZ6bGkf2Vj+L6wLoLLIhRZxQOedqArIk/Sb2SzQYuxN44IDRt+3ZcDqsPppoKcxSyd1Ny
 2tpvjYJXlfKmOYLhTWs8nwlAlSHX/c/jz/ywwf7eSvGknToo1Y0VpRtoxMaKW1nvH0OeCSVJ
 itfRP7YbiRVc2aNqWPCSgtqHAuVraBRbAFLKh9d2rKFB3BmynTUpc1BQLJP8+D5oNyb8Ts4x
 Xd3iV/uD8JLGJfYZIR7oGWFLP4uZ3tkneDfYzsFNBFp+A0oBEAC9ynZI9LU+uJkMeEJeJyQ/
 8VFkCJQPQZEsIGzOTlPnwvVna0AS86n2Z+rK7R/usYs5iJCZ55/JISWd8xD57ue0eB47bcJv
 VqGlObI2DEG8TwaW0O0duRhDgzMEL4t1KdRAepIESBEA/iPpI4gfUbVEIEQuqdqQyO4GAe+M
 kD0Hy5JH/0qgFmbaSegNTdQg5iqYjRZ3ttiswalql1/iSyv1WYeC1OAs+2BLOAT2NEggSiVO
 txEfgewsQtCWi8H1SoirakIfo45Hz0tk/Ad9ZWh2PvOGt97Ka85o4TLJxgJJqGEnqcFUZnJJ
 riwoaRIS8N2C8/nEM53jb1sH0gYddMU3QxY7dYNLIUrRKQeNkF30dK7V6JRH7pleRlf+wQcN
 fRAIUrNlatj9TxwivQrKnC9aIFFHEy/0mAgtrQShcMRmMgVlRoOA5B8RTulRLCmkafvwuhs6
 dCxN0GNAORIVVFxjx9Vn7OqYPgwiofZ6SbEl0hgPyWBQvE85klFLZLoj7p+joDY1XNQztmfA
 rnJ9x+YV4igjWImINAZSlmEcYtd+xy3Li/8oeYDAqrsnrOjb+WvGhCykJk4urBog2LNtcyCj
 kTs7F+WeXGUo0NDhbd3Z6AyFfqeF7uJ3D5hlpX2nI9no/ugPrrTVoVZAgrrnNz0iZG2DVx46
 x913pVKHl5mlYQARAQABwsFfBBgBAgAJBQJafgNKAhsMAAoJELKItV//nCLBwNIP/AiIHE8b
 oIqReFQyaMzxq6lE4YZCZNj65B/nkDOvodSiwfwjjVVE2V3iEzxMHbgyTCGA67+Bo/d5aQGj
 gn0TPtsGzelyQHipaUzEyrsceUGWYoKXYyVWKEfyh0cDfnd9diAm3VeNqchtcMpoehETH8fr
 RHnJdBcjf112PzQSdKC6kqU0Q196c4Vp5HDOQfNiDnTf7gZSj0BraHOByy9LEDCLhQiCmr+2
 E0rW4tBtDAn2HkT9uf32ZGqJCn1O+2uVfFhGu6vPE5qkqrbSE8TG+03H8ecU2q50zgHWPdHM
 OBvy3EhzfAh2VmOSTcRK+tSUe/u3wdLRDPwv/DTzGI36Kgky9MsDC5gpIwNbOJP2G/q1wT1o
 Gkw4IXfWv2ufWiXqJ+k7HEi2N1sree7Dy9KBCqb+ca1vFhYPDJfhP75I/VnzHVssZ/rYZ9+5
 1yDoUABoNdJNSGUYl+Yh9Pw9pE3Kt4EFzUlFZWbE4xKL/NPno+z4J9aWemLLszcYz/u3XnbO
 vUSQHSrmfOzX3cV4yfmjM5lewgSstoxGyTx2M8enslgdXhPthZlDnTnOT+C+OTsh8+m5tos8
 HQjaPM01MKBiAqdPgksm1wu2DrrwUi6ChRVTUBcj6+/9IJ81H2P2gJk3Ls3AVIxIffLoY34E
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <87fqyh79ty.fsf@draig.linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------u2KRMSvb0NgU1zb0d3poj01a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=demiobenour@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------u2KRMSvb0NgU1zb0d3poj01a
Content-Type: multipart/mixed; boundary="------------CpWidX7Tsvu740OGCV5zRaDV";
 protected-headers="v1"; hp="clear"
Message-ID: <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
Date: Wed, 7 Oct 2026 16:19:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 13/10 agenda items?
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Chris Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, utsingh@redhat.com,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>, Frederic.Konrad@amd.com,
 Luc.Michel@amd.com, edgar.iglesias@amd.com, francisco.iglesias@amd.com,
 Julianus Larson <julianus.larson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Lukas_J=C3=BCnger?=
 <lukas@jngr.org>
References: <87fqyh79ty.fsf@draig.linaro.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <87fqyh79ty.fsf@draig.linaro.org>

--------------CpWidX7Tsvu740OGCV5zRaDV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/7/26 12:29, Alex Benn=C3=A9e wrote:
>=20
> Hi,
>=20
> The KVM/QEMU community call is at:
>=20
> https://meet.jit.si/kvmcallmeeting
> @
> 13/10/2026 14:00 UTC
>=20
> I would like to propose a discussion that came out of Core Collective's=

> QEMU sub-group [1]:
>=20
>   - Memory port interfaces for co-simulation
>   - Dynamic machines / data driven machines
>  =20
> This was discussed in relation to recent proposals to upstream some of
> the features from the Xilinx downstream fork:
>=20
>   From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>   Message-ID: <20260915160044.345788-1-ruslichenko.r@gmail.com>
>   Date: Tue, 15 Sep 2026 18:00:24 +0200
>   Subject: [PATCH v2 00/20] hw/core: Introduce Remote Port Co-simulatio=
n Protocol
>   From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
>=20
> There is also a wider meta-question of where the best place to
> co-ordinate engineering (and potentially funding) for these sort of
> features is. Obviously CoreCollective is already a place to do this for=

> companies in the Arm eco-system but features that support co-simulation=

> are hopefully of interest to a number of the architectures.
>=20
> Are there any other agenda items for the sync-up?
>=20

Is this also for topics related to KVM but not necessarily QEMU?
If so, and if there will be people who are familiar with device
passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
faults are recoverable.  There is a virtio device I am working on
which requires this to avoid either crashing the guest or allowing
the guest to hog host memory.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------CpWidX7Tsvu740OGCV5zRaDV--

--------------u2KRMSvb0NgU1zb0d3poj01a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmrGqT8ACgkQszaHOrMp
8lOkLQ//aqwKVwRwpV28aC4RYL4aO8yhJOepcW3MuzPVblmEF9S+7fZecJV6ulZn
RIFteLS6PUxGsDDVDxiBWYOhIrVLp33fVhMYKgsY9f264EbHHaO8Uu2YRw1kEBp8
MgwJRDvk8j4KgcQ3t+IWtJGZrtftlAUN4htFeVvM9pksMpymSKuUjGxISEDZmreD
Baqx5mObhvYAybtfm0ZclshstDYw255mWb9k6r4evgrzbP5xuHrb3ZHcjR8RF6L8
IfBNQsnMB6qIXPz+r7tQ5aEa509JuKR5OMvvrJs0kk3AMcCY7OyPzbQblvOm1KKl
RNZ9JE4Smpy7jhRFt6yK9AmY0yCJfzsplxFxRY0YSKB9KvrmNnEaz/fR7pxyweLw
KTStdIQvmSZifhF2Dm5ya/lDpE3V7BvtzH2dsUv+WPptK3EZp3qK96TjJZwcOb9w
dikqP5AKvTknvWPSzwmDcbufLilPySu/FHTowdrjhKl2n8DfnkAGy1R/BrKTKW4M
iPLS7B9c6JBJyabUR61wEvV1YoLIWYktYb07AYgogwayNEhAONPfVsfFkHgb6UBh
qLL2RL2ZPAjq04MBwimQ77+5vnxOunz/iGjK/Wt8g4Z+JpVtpLPhLcC/iiIov7yq
e5C+5AcJuvN0eWba8Eypi2kcbWC5SRnoS0meedBK9nIUFgcyEVE=
=BSUt
-----END PGP SIGNATURE-----

--------------u2KRMSvb0NgU1zb0d3poj01a--

