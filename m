Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BC0E8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSB-0007Pl-73; Tue, 03 Feb 2026 05:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS3-0007FD-AU
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:09 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRx-00029M-Jq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113748; x=1770718548; i=lukasstraub2@web.de;
 bh=acIbGuWiYVbHQzrhTfvGmU5crz8RI/HnOnsie89+6bU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OHNbE6twY+2E3ytDZD8STdl7U9T/DwaApPxdjynixYAVbk1tZtUaUS+1ikII1vzi
 WJAWXpatAGuGcCA+ln+vLm2ls5M5PMLA3lUoqmdZkMz3rvkc5lOLgESFRWxwLWqx0
 75g1qHZ7K3d8wgSobg4YF4moLVbzeNsRbTlmdVcrBiBHmQw20UgHqkdbDY4VmwyxA
 7P2w81MMwWB323HHatCiipzlPdfuZ2wE1uAIwWr3IwXHapMMoK2g4zvgHfzS5/Qlo
 /VqvOBYB5NjaNlhKg+Uugwn9Zf4UrDF3RlF+Th1LlGquIAFMO8rtrZ9HU556mFzRL
 LOEcVdt1BOcL+rq9GQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMEW-1vJwtm0l7e-00oUS8; Tue, 03
 Feb 2026 11:15:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:10 +0100
Subject: [PATCH v5 04/16] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-4-57508b7389f6@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3490; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Xy8q5Le+j2M5D8fLVu4VkyakFnaluhNaPAzEkXoWOs4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrP46RkdTleO2a1zO4xHJ/qwVnGCE1/LmDsX
 f8IKjIZJYSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WC6OEACWrSr71LPSr218ZVYVnzeA1sRxuo8rsP7VBa/9Gg8aho5+FM4jTTz6LmSqzWHx0TTNyQ/
 kYMG8jEs4YGmalCYzTXV+48yZ5/4jyoc8D7adpJXl3QKAdHYl4D1UcZbCbF6pM4qoOZ6T+Uy/Zf
 8pZ/3DmQr3TDroH+9oIBLybRzM7KC02Ie2lB6Q9X8WlohbalEg2FgF1DK6zfg8IWXxJxm6hYfZY
 yf65xg5SyV1N7pd+aIICKq7PbIBZT2PJEeJeLiKmGNYL3MIaTAILIJ2J+1Mn+oj/PQxgqHd1XWm
 xcxLjjOpuhrSgDd1i2XNomFmFv49+SJrF3zA3D08ImzHjXWgsEggGMnYM/qQOlzk/AYGpDLZvG1
 siL9tPdvd6KYj6pNvi4Rf0yeTmM+421hLQAkSYw5T/taN3dx/zLdc/vtHA8LIsdXayZMuViiUri
 g5bKfXwVyzWhN33W6i2/rIBKrTBP9VWSLXaahcg2DbALEX3mjy8iwsbS6sVZpy5F3ywEqO8AbSc
 BpOXJt3slZ9E3LYrTZ02yGN3Gmt1q+AzNVPibpcNUzVEijUkccZnPGnkOs/oeHruOTS/J57v43x
 Sqqdxhkf3mf8XzfpLcvEU8S2mwbcR44L8s0anN6pCwGEBIAUi+rF/3/n1DzS6XAsEMx6MTNj+0n
 xDO28P2T9tE128Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:E/oS3le1aciaIhzZ6i5dpo9J69hepq5XE2bha5j7pP+sRThDoW2
 612EOWpnMwe/SZ/5y95IFIUO3tOnIA0iqQuj8nwFk6HiFLaT2V2ONfKyPsFOguBaucSJ4e4
 TC9B2rTcFJMhuvGdH2PbDCZb0INUNW6HX15GFYx+xEWcmmMDx5PIUJJ8SuplWTnCuh41j5v
 1GLMd9oqvKW8ZQ5eJQKvg==
UI-OutboundReport: notjunk:1;M01:P0:qCBQGnRq3H4=;CGjieGUZgKZlnKHbQLUOi8baT/P
 bzp0fhyIrDY4xpAjXKn1XNdPjWDKqmzOgUe4nuaajyHEJI2eMdXIbHf0zHrudtdpRXBUlcjou
 QrUPBweDuWQVNUS897UwXb930ZQ0Dpxvv1jXtu3uiqfKxBu6Nsz5uoj7BqSYz5p0VHWc1eutS
 MPGLbiHkv74FxAFN4g4HKiSASKtG5z2dqLGPhpCG2d8IELr+0pFYPOID/tPZlgYY86WjTJV4r
 qX2LRovPEzkHrLLHInrXzma+IFXJzUl2KV9swROf0aUyUjZoWFoEdm6dd0RR+DyKZoihv1KVo
 +gR4ydOCbdqiLO6F9RT/e3U9HHc5d8vFwkgaFJ2g3VAKd+7yvqifeP0INu/1JfjvF15E+W4ml
 qVA5MEWOb/pk6hJa9VFofLT7CWKB7fGvs+zcxlt44nUOamq9WbrveNHjR3NDqQAn5QRbh7Qn6
 3Mf0+YRIqxuPYeX4X7YIbPw69FfiW4NK8EG+kkB7PSAh+mwlNXy8mI3iWfgjniILBiuNnq7lO
 e5pvXVfc1KpioLF1PsuIwfVfEimatKKZZy09Z8a08pH+USdrUS1z88gG1mx5Q/HIfFiMcH0Zn
 ot90ie7v6NnhEm4j0X6A4vBQt/cT9FPXRbhrzj3oR+jsquPa8O4HfelfXtWfzqUj7VOoDuyUL
 ZKQgg9DMCnNExvyFLBCk/3IUPHW1qiWZ3JfWJY9baxym6Cj3fbUlZUgkxhL9P0hlgzn3yoSyh
 YN0NqJXO+cekPiRmRJ6rmsi78q2dDrCUQGVDQObcZZsXYUytFBxNur8ji5ttWRTjAqVJLl3/z
 Sr4TEegBYj8XFuYKIqUeVrEwTb6fRzDXhGWJPMsbOXMKjaAc4EPvs3yqno79KoYOelQShXqnm
 p/p/svO6xT+Ibk+gsePd7SPoi+dfU8qp6IbStN8OamqV7D6CbB8vLqsVxt4btE1myO+f6gzAH
 5kbIebMOTiBOjQkb69Pq1/IXcVbkUSQEGuMte5Va6RUfUYiDp5OONvxr3XRSxt63Tx+D4eqn8
 VQEQu3tqeLj7XDQTyDVZxOQTIC1ZvErlCiEpaDYC9bZpis7g2joeJQ+AmAmisb0zmYyKoiQic
 ZrYUUmpvHohTey6fvMFwC6qW97tUqNHykcSEk01WXA9tbrw7OO2yhJTA4YkVh1EP0jKyW4pKp
 S3hMx3WaAIuP3qnKbhwF17pAGYe5/QABGY6F8N6SUJtSNLJpc+s17nfTj1HTkGNp2SaKyrAwG
 BJhX4y9ALOeGY5/OlM12glfz+OgdSjRemQx5p96h4Af4LnT2pXzB3LRL+Xsjz34ccu/vP9tE3
 nuaZGXU7ECSfciwAdpcDU7N4Ex3u30VMktvt+V+P/+6BpkUihDrBEBe2nhuIRoEGfC+2cgo9j
 hIvbcdiT6Dgn7fY+cLGMx4kI4Km2L8M2DpxPp1sMJgyQ3VB5AgtzpMETn/7eh0pK84U/CVbrI
 aWO8+dlVEH9WICGBoEDn9Q3s6eZcyNnX9U/APHfTIDPQZBOfwvGfNupNZJQKQ/p5nDxZBN7C5
 g78bpPgR7RhHrEThcyCu8dqF/vC788skB129d0D1+iY46yVdevQ71rDS6bVcVDwpcpbkBk/zW
 mp1vdGVg4a6v+QgX9cYCDyqWYrFVS8MA9MDGUezhffAu9go5TzICNlViSMOst4sEdefBN1tke
 VKXykSB3/xiZI4uUeRE54OFilr/F9eUP8sGoKFyLdEDYgyPZ6WnrayDtjlX0u8K7JuuIr9RGB
 eWCj+ZZFnfyiBX2fegEnp7UF7ARp5Jx0VCpv8AERciwn91wALtf8e3wycf29kXBx9dSsS+dWu
 3GMTSUtSj5MTozhr8/Y4FLmyJ20kVt7un3wXu0Q/DMxQPuFX2PM7XI1kvOZmIxOyEUvTtOuCL
 10FzUHNqja2KedyKzgB2QXIrXwkRmXCksg6j1un2/Y4vN1anD+FJCYIU8Z/8Yo7feuATAV1kk
 jLT4N3mKdG4Qap7WCNUu6YULuIc7V6r7FlQN5tzmfq4CDPodRgyA3i7qv9lvb6sDCy7K+q/IB
 DSP07O1+n8jolbJ/DkkzcR1IPyhiJUX3MjlavHHqXwnwlM41WphAisCAMuCpcPtY31T4nTNkP
 pouEn8pg1TChVsfk7hQN9+TTkLtBNlQu7kKxmwU8RfW4dxBi3B0aogXYcIpFx4AAVMd69DQZG
 NnVMNwHZfknvGqm9LRE8UgexUPz87JY5ABD+LXJiAhcwRSvns0ieo9cGoyXuwo5etBVy499ki
 vQNFhaonkrIbf6CsGSXKW9C66Vs2bQcW5JAYhNrhjuaRsnAHDNhN4Rjd7Qiv5ErLUEuBOYYSd
 fcXqNhlbi5VMDBpBC5JduC//dWunbZI6mkk9354otK9mxzvJE1NuWhPV/fla/CUwttljfYw9x
 +pk7AjX49YY4jHx7YH8txhN/Oc3h9Xi6G/mWBVL/Lrr00K+/7M5zbu2c5ZtLw7pPs6V1OqaH+
 rNJCg8uQXtK1nZW50pSlfAIIfUmw2ncPP1V2Gg6Whwt1RoreT5132ViUkLna+SKTRKMUSohPv
 2P/muG218VvA37duQ/6IyeU98uBz6VjxT/bD4mAmlQdWtnQaJfWO3iaNRZXz98gTeGdICrAlv
 MiIi9Lrxk3QXXZqlNNeaEEmAZ3JcU2ny7i0Ks6Neaaatsh+pIKAf31tSwVjR87ATrfSrF9UEh
 pTDzQYOleWW+BLIrRNptUcqlFXI1Vvu4EjnZzGaaNyzLaZmnpluafOxWOKM+rhrtywHaLMEgV
 hnbpOAnMdDkjLoMXDYxemWvHEKLwBDHK68YnYbmOC+981hJAxBCy4nJeawPThpMButudbLADt
 Yu7UTnzGZ5HcuT2vlljVYZvAdGWY7Nu0kuRb2B507J5vEDzIpY7LoKedn+Exh4drLLHqyxMMZ
 N0p78U9EbsR+g0j5lEvU1Rsqg9pVVu5BuHcVgV5o2sdckUJQGzu2qMW5i93l3UpSn6C2mLWU8
 Rp0lck4NUAI1c0QeDUo6rnHkw3q9eu580AcGY6eKHH/CNfXFb8hOlLGrxsrwPK35kI/Udj6dl
 RKbRygZrortiaf2ktmh/UmgykXeCqH6bcMtnBBevpIypXNVBxkf5y74K3bkSIBK+s0tXEYtCO
 DkXkCSAehVvaYXLHQaEg54wjuoStv2d5bbDDpX6wXk++4JIkK9euLNl0+avV2c+PT94+6L/Om
 yVdBdwrZGZjJ1kecQlooOTwuKEfV3Djj4ONFYb62Q33NOdW05kcY5uy8X7FJNRYlZS2HDZPCT
 zeEvwRQTZ3JWeGGqo4AiFQn6H16mtH/Ef1XJMS77BOK/IUA/5umDI7T4OeRsXqhL+fJdu5xer
 O9busTZvsr12VGHSYvqEzBKMOmClasXXNOe7HOGz9rKtVrLMGOYOmOmAbquzfyDf3x1nO5h6t
 CaCydO4DmQfzaIfAsbDcgr3eIaT7GOgPaUf3DxC0est2a+VFwq/bsw3C5HdoyOcsfna0Ty/sZ
 tzGtH2tdcMV7J0vh6SV4MXLxh6FkOcJN+6sHudN5xlwWPmUWrfVU+AjlnlwbsU2yboXWfunFw
 z9JREqYHD0O/mECH1yUpvpspJrPQff3eX8APdMUf2/5L4lLOXSfEr7QhjXLqyTLMiyG/VJSQH
 szij5sSa8mTVis/ODtHFHl3n7fo7VzYB/GBn7zA6acR1C5g4WuZLYug0AkFjaNKT8czR9jOYO
 wRmKWC2siq0bhYbL611NQxlsbefw+dyTFeWXNexcPX/++oazHkx/yOLWK4sY7n/SILRLzVTHQ
 JJViRd4huq6ZnXk5TXa/T5ZHW1OdUoLN7xoKWEYqVO9H8m7+c2rsCSaRp3HwaRAi3mTiDcGLL
 XzkB3QMngysC4nBUxbLznXRnVQp3htiy34Qqlajr5wUZjpvC0S6g35oR8trEmGvfBIKOsv79K
 IayipNDilI2TwZQ+iHm90/A1vEBSVTnUdEbyQ3uPjy50sh1qBzoZ/XNJE2NjrPpcn5ZEL5/lq
 LXorafIkMWzokI7c4ijA8jSIx5RLDmirgwLzaaPtx67unH1URXaQvg01DfnWibLLkoM25Fy+Y
 zMcotlshbN+zIXdV2rIjOwOaBdBSaVArc+wNLhgupR/eQK+rUKMiW1b9kfxKRPKxpOqSjgLrJ
 crMnmqihSw8SOf8SHe8XtSmDmUJzSx9DXAZRH5FvEGst160Xmh0IW99uefDqKVLYeQ1j/8B7Q
 YehxjEcm6qgfnpOLU2NI5NeHm53zNpEZCyLZZ1jrL5Fa8jAGbdSewb68ufInRGSV6wyuedatx
 f388pD7DCgLPOFjpEZSp0qLSorB5pxtNLT2H6DsRfwDnv9rBTvUKS1e4whzbyibfCpUBamU6R
 HIMSwHbDGSKvykBoUlKDJJk62pporNowjB5/6E5xwgWAuCd6oACKYvP5y8EZSvCAIAaEcdDAI
 mx3Xm7g+5EJWyb/jEIYnDhw7YwR8pz68xJHeEOacdqbST6gJY317vKR7ZL0nvuxqFVZaeqNop
 W7/achDWkJwoGglyYwgbFqjOxmHAisDExCAl1UiboCBTGaM3SBrSns+75H6NBQkTvwAJFDzNo
 sb197WLXesKKmvDcyb5mfn7JD47t+C4+r0uZ+K+HLHBWrtVXN2006rqsymzQjCaEWDwnqYBKc
 j4Tt5+EPMgFmLjY3YPJBfoooyJYAt3irZJNCRt04ouaDOH1mdO7lJf///O/4TvewLLbGyqxDE
 1ZvSNn6QRP7Qb+06rcCYWjVHjZl65bNmXxcCqdZWVIO5hIkSOX4L/UyXh5SJZrp+1OFTmSMtD
 KK+vMnvDJ3GB919MNlpRxxrXsEY+a+5dw7btuocxuLrRMW1IMGyMpsahxvFuFAimIHRvfqHIQ
 lo1JwL5I5lqPpCG2N70/W1OoBgx9QcgPNm8cu934+4ZgtOzP4bahoy64QuQ6rmZ66Z8rFOErV
 7hqYt4hkKZbMagQAPua+o61SYVdv0WW+gUrL4bo8hCAE1ahOL3GkyMiJmICCS9azjj8anxj/R
 KMf6qXvUHh4q4QfINzFPa/kCb73RUgpEqrejSkrpnm0x5EVuPjpAA2F4nS50FnZ51fVffE5Us
 gUpaoG8M35eXUpHvGA7gf6ZrKs3Pkq7fePNKOn7MTORLGitl/fT6TIlUr6b4lY6G21ilse4wU
 87RnVRMVYkyWM82y5n7ztVgpLIuF2DE/CLLLqn3xV9uo9PlU69vxG8mVpMJbtVGF5UxUEBnAI
 /0sArB4nVPKxEdSS1c6cj1ED3ltUX
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h | 1 -
 migration/colo.c         | 2 +-
 migration/migration.c    | 9 ++-------
 migration/ram.c          | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index d4fe422e4d335d3bef4f860f56400fcd73287a0e..2496a968cc1ce709f706c0efe5=
7e4f765f163d3c 100644
=2D-- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -27,7 +27,6 @@ bool migration_in_colo_state(void);
 /* loadvm */
 int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
-bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa77500386d923dd97e522883027e71d8..8dfd39b035c48590fcebeb2045=
9f01fb37fb67d1 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -933,7 +933,7 @@ void coroutine_fn colo_incoming_co(void)
     QemuThread th;
=20
     assert(bql_locked());
-    assert(migration_incoming_colo_enabled());
+    assert(migrate_colo());
=20
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
diff --git a/migration/migration.c b/migration/migration.c
index a73d842ad8b060dc84273ade36ef7dc8b87421f3..bc8ce64ff5000b0eb634a20b22=
e5f3e3289b9707 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -605,11 +605,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState =
*mis,
 }
=20
 static bool migration_colo_enabled;
-bool migration_incoming_colo_enabled(void)
-{
-    return migration_colo_enabled;
-}
-
 void migration_incoming_disable_colo(void)
 {
     ram_block_discard_disable(false);
@@ -739,7 +734,7 @@ static void process_incoming_migration_bh(void *opaque=
)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-    } else if (migration_incoming_colo_enabled()) {
+    } else if (migrate_colo()) {
         migration_incoming_disable_colo();
         vm_start();
     } else {
@@ -807,7 +802,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
=20
-    if (migration_incoming_colo_enabled()) {
+    if (migrate_colo()) {
         /* yield until COLO exit */
         colo_incoming_co();
     }
diff --git a/migration/ram.c b/migration/ram.c
index fc7ece2c1a10f34aa5a91f58cbe42ea418d7c078..aebf77aa0b861e00516d6f1090=
aebefdd0d97e54 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -4370,7 +4370,7 @@ static int ram_load_precopy(QEMUFile *f)
              * speed of the migration, but it obviously reduce the downti=
me of
              * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_colo_enabled()) {
+            if (migrate_colo()) {
                 if (migration_incoming_in_colo_state()) {
                     /* In COLO stage, put all pages into cache temporaril=
y */
                     host =3D colo_cache_from_block_offset(block, addr, tr=
ue);

=2D-=20
2.39.5


