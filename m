Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3E8FD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUJ-0004CL-Ks; Sun, 01 Mar 2026 16:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUG-0004Bq-FR
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:05 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUE-00044O-Eg
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401067; x=1773005867; i=lukasstraub2@web.de;
 bh=lcGEXTcmjSwo1uIOCMzYBcGqppfFNt21+FB9vZyidNs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=K6FyfEi872P5usSfpY0/6cEIq4AUeW1pWDXy8enhvoxMgA893tBHFOIWc1Zh/zLy
 8/zLEeO6Xn/soj+f9jHEg7IMQYwu3NnfF1sniFgqt/bL9uZIsnr1qnab7AUzjBNIs
 AzghkHSImCc+wijbs+EJXSDF2GAy/j87T+I514r1YJJjc0K0fEbrJoycon+F1uyKp
 gJa1nuphpDhrDqe7uOoLp8JtlMQNoOAq4jJ151FSgAKPN3+QL2bADxBgmdIt/ffYc
 e505PdoRO7skggrMot6CZVGU6Pf6xCfKa+eYpwdIyqR7CTsQxiKf+r2Y0RnhIXSUc
 +m8D4e0IZogLOmfpwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1vLVaM1fXV-00kFvd; Sun, 01
 Mar 2026 22:37:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:39 +0100
Subject: [PATCH v11 19/21] colo: Use file lock in primary_vm_do_failover()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-19-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=REq8s1GLond4/LcE4TppwatMZ1netju7z89n3hnA2Mc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGi5VvAMSh4TVPmljdPE9INerlxVBjj9iHEm
 yunXg1rWPyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxogAKCRA1qwsonF2y
 WAMMD/4jfBLI18D5P5ke8iIU5i2Zzb+laSi/y278T5Dii9e1546JPtoHld9mLs4slppdoc5iYoH
 +dliHuXGBLJ6JFc5dbCZ+3XoEbfMRjjyArqfsf3NX3FdWYqkbuSOQANTn4fHPMTLaBMDekWlwyd
 jwX/UZE6VoygqnL2WdnjnS6ilQRYFvGa0fkgeLHXrStOVy/nzyfmLEDvteVjCPptW/n4pR8mqCZ
 L1RX8wAfTVFE/QLG3HiGzsQBg65f0WIe7t3f1pdIdtrUvw62Npcl8td+q9IvlyxzgQjOelIGSlZ
 vMcSLjxAY8GuhVyGYDSovJ6qs5OSbKsb0DowcAdAR+vK0gpiNQUuhmlzerFQQYwTyGOyc+lAoks
 l8BT+ZmxcpAl/Kistp7it14PGz5/T2wmx8rjJRT6Hlp9+fPVvr1LPmaW+IDyeJG2Mv9RCDT1Tt4
 qA2Ie3BtNlNavesA6lGviUlsyQhulM73W+UeBYF+rYHVlUvuwJCk4YLE4/AbGViTXY0dVO1L8aW
 DgmCRW0m4TUqbFK9bqdKA2TAsbOwLM5f7+gqU0iJ5RentPvkqYeg2wfvIzn/P82s1NqKtrJBQM4
 PndgzEx+stpMGJei+d35JvYiOaiezDDVeNYU7ZfXRRbfwUtN8P7bS74sHml9E2RKlXiQoPzqvAB
 3EVpNrCjFZ8Ikzw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:8vQrWhMyKjMYyxgvMjlUZdI9Ggz40h6PXS9Uu7hytwnnXUvVCad
 chyv68gyQ8eQ/MEqiE13ubcp90OnuBQVWWtdx7nppAZ7kZ1pn9hqYfj6YHxrpCXX9EFqacf
 ck4kRbNDy48bba0b/B/6LkIQAasB2BFcenu68sBPW3yVUVFTiwzKfAkoiInVyNVOz/J+zax
 1wLGqlS9WSHc0t9v5A07Q==
UI-OutboundReport: notjunk:1;M01:P0:ZQXPaM9VgCE=;voK4BrVYs85vyc/cCvZ8n9zIb1v
 nC8PtDx3ac06UtYnbDK6HurJmWQd1DAE+dJ0VDt20HN1mqlrxJC6IZsy3eTOHDXjIlZNUAkr5
 ENucqw57Zy3OAfcwMenBi7x5XbKx/UEfqS/vX9PlAKGbHoecTu3px90iCZgjA6GiIjBiQnhY7
 4IVB2rsLHRCov/ooDknxCK7JSe48LwdoPZIGXqxsVj4j5uXpOJlNAZc6PFLUekNArQMeh+ks3
 Tt2jPNQgiOpH5+0/M8MT+hfOpXilzYOCgftMWqTFQoLLSHtMDTZyiPcm10O+8JNbaYevTwa01
 JcRa1GkResKEuKC66Dm/UHGrrSpkHOTM8RxI5vTfcICj+39RvdOfEc8a7lpNzoGCkUsukv15U
 Q9VHtR3w3xDjXElHr4NoZ4ua0alBbrZcukvY1/vDUODLdOXRGh8YEr029NCcgTJlIDjSrlvio
 tYBc6j7AvDqvX+oewmmZrcZK1CgptI+BnAEfHBJQoaa/A3h56p0/b8ZAkKrlp+jWj/03Fkcgl
 5pLgUMx9wxMaXpRfsv530PhZsjhtft4WUZda1n/KpkmrGRs8R9vipoo5lTZw+ed8nCE1Uy8TL
 KUotIWmEGixKdMHt2KzZKZKRhqmy0cbBSP6amblO/RUZKiXi/gMm3pZvh9Q30lti/2BuL0F1w
 e//NherJv3jo9kPTAhdXSjzp/0P1ngrZAFeAwHzO2ibHV6DFW1H5VWcYccuOJvEmBND88abox
 tC0dXW4bbv+BcVLkmxxG8WCwmJFoWhzQHF6MBY6HbXHsYVQlaRR6sqhjZYRpcDJRF/VnKZjLF
 r/WGAkSCnej9R7Fnz6YR8tKrmSmmeEURoqiyyonjfrZNzOe1VWAf7SzgEGjVkxgVhSK1rfSSZ
 DNY6hqSWHcxBJ6Q3IekVDVgSx/dJSheEUXE40HTp23cpSU7wzsmTfpCylL9NK87MvRxLVG1Sq
 M9joUvrMz+a7qTynBeAyWfJl3r+So5Yq3Y2FumsLj0+2IFs+q6DqeVaynkBu1frIExkNPCJ0R
 QSIGO71vXeIw5jhiLWSYadCmjfPZXtGEU8xUtYR0Wn8z/IBYBDe9z1GWJb875mXmhkAE5YHSi
 ZtALVSWXtZTmrR/GnJFfnfoa5FaCOy2D1T9GMvYTpO/vWnrDfeD/wtdnNkCtr9RefV9pV9IGZ
 Plw9v3KYbSIDPrMNrlSE81DOf2hnyUrg1ZNztWs9opk8SDrHEPHDh9iJ99ASS/pNLHxCvcvDd
 F9Ufni0Og/mkPgEgbd8P7NYUgfa+4PawGOfJQfRRtt4XobwNoF43NK30rvK/1m0xgoLll9f1x
 gz5WxL05/+ljqLSC1XoojawR2/AP1zb1pQIlRJYlYdozMOW1qCvCgW5sIyhmWOKpZK0WDsqkb
 WE2PF5hxGPr/aTPUhyce9rq3nYKc+UyfhoBjIcVOZ2U+Ly6hdEzn4QsGgbytBvioU0NixdIyC
 KSd9Jo3hL9WBkzg8pan6fJuJprjcDmZ/LpGs+3lptkaPq1oM52thPzI5Cw9ud5GoCLWteZUQ7
 ekDHevP53hAdBjRXt4nl8t2YhN1DO6wieDuWq/xTaZUrF1L/+5iWhGVC1Iwo52ciSS2iwqhU7
 +yekCv4RxDsnYeu4lBeISw5IQGq56kRcuf2/8ttlljeJMl9BkSr1Y+h6O2KGAHwb5GS+nkfOE
 LyUMiC2UVasdG0Vj7pqNE6f80LrB+exoV92scMo9aZFRc+cQZvRzhMNY/3B6VWCGYUBf5q8HL
 cXxf9g98VagsuyO0CQ+QYQX42fnaNtZ9vhA9S1beqeizq0P65nW7AghBnNymj6RYjaWzNb18i
 VhKCfTt9NMwizUC+zaXHJPPKjeEA84hYgKkqdUYCl6DDUXvclKy/+XhgIu0sb1a94aUM4Lx1R
 kXDGNgm0wPCOP6TMkzF2iO7JK8UkXapELp8uGrTwRTY9LlkCcW5wU5gLWvOdgpsUYzQlIo9jV
 y4LHH8O0/0LNQOEyM8zVFYfz1WmLif1TX57xuPVVbZ9QU82EBzcgQt8LpeyWSOkvu6k/c6bl7
 MfC7/KRnS55t6DZScsqtNfVdaRSTLoHG4941Y/OdAslQXq8v+edCCKbYYl1DDe2q69wf9cksx
 jwQZRttdQ0mXTUCxFKgFDU40DxQCThlgLqnI+spETSQxxj+uY1HFNUzZFHfnie9u/d/gqFLlD
 6HfC3sxazekACKt7EGayJUu5kJRTkNbtsdy4R2Z9zen4Uz8m659ylLdDwzL9P2k4F2yEtCUNV
 W3qvkBCegxFHfSw9VoAahUf+AdglWgGNX5DsVUTm6F+0orUFTLbSPY4XxxS8EL2vHtLO5PgB1
 cuVMwQZu+86otGWpIX6rRO/E0FOi/NAAr5KdZbMQ9XhVT0S9TXnrHD1zUdJ3o/RXvjrBRwufm
 yVq16XW6HgMB3r7s0RFc5LSN/8T1ox4S3mMTwhSWvBdMmNiLPi+86mlgT37eV1y60pfZ7PvHT
 EWQoiwIYaa6BRZ8/kY2cbn7iokEKLKuwimy/9bKnxmJ/jhwviMMWWsTWTjrVluxZOBuZVhXvN
 6eoW7GAAqdAQi629lT0zqpb6mQsjXnfLhEHpjMsshivA8xP8XXkauj22MirG36v0svDZr8dxm
 rmmT+jmB2DuX+GpEgAAQ+hzWZe7vyl2rNufX5pk7F4gezR3n9u8RIm43ErUMkeG+rpJq5RB/9
 FgKEh6wnjlYXzc384cTr0h2ScUVrq5Cz9DNJWy1M58sLgkAFbYJO7QLGRJRb29kwJWnLowgGJ
 8ojL3KQkKRjkfpak2dQvQV2BD+Za5WvUHL9XMmCGOmiYUsAjCTI8zhCj6XvDIiU1oD47rTXeF
 8IH1msL+ezFXV/Lc/wsmGg82KeHA9N0Nxy8m4285HmNTYBMu4k6XbTBoU0dwkpJcYlcftnbpm
 wTU9bPk28RmLRdNLEuptpxLW/8lmIZ03gD7TExxIibRivvNfYDIui+bDFCf8Hpgb0EmoKjExl
 SwUjEyfVmZ0cN159hafZB8VaFAmYbJU/Xn56PR3pT8dQoioOqp8hxoolLUG1jkTEC3RcntPM8
 RqZ+oe2XoLUrSjzPd9M51Q8vEGa1HBUZyU02dmBVtV3D2iqHQmTHnHh8FVoaYWESTUQqJlbbx
 DHxkJ1+ByaNS5HhIdd/XPSJqCcwcQ8BeUfsUh9EdkBpE2Tl8HZE2u0exYlphA40Uv2fo3gSg4
 v5A6XN332oGtKSluqv3wKIUEnpvO26HJzJGX+b+wm1seqr9X37HeWn2bDU4IcZafd/RnwySXQ
 IuO61yjG4Nt+WIsDyT49o90jsx+YoVUwUwWHvBgJg9YdA9x71ABRfb+qMkoKBYvFPykPxjlMC
 KfUho/ZGnd6oS8PoOdylr+DGcLD133ULgUdg/BfZSoVYWO5OYBRRiFPUy30PjhSg5wswfkexU
 fWy++VBerPmIW0EnuntOPNKc96vAgDsjVj4MgYr3jOgymuj3gTngD6+TlZ1qjzDYRXynt/NGW
 kNTNWu2+IcM7TMgixbP38R3yBfyrcwAtH5eOMhcVQ8bUS5D0aSPMGh9gl5IDxFIZF18v/+U0I
 TPR+vMZzz1uO7B2/0uodIOKV5pZGwzVmkA6NiDUMhCtG1P1Lit9BeeTL0hr8CYBP1Sc/aNq+H
 vJS7GUBAlNs9yOg2akt4Bu39D9R8k26lDVJB7C+p4vz1wE4cc4Ml0pQOayj+aY8zbGc71rZsJ
 vYp1i8YY+o7By/Hm8Ljzh/COxO3QVG6MSg1U6f751NZMNdal2aH2ZswMRykuTV8bAIcuhR8Eq
 O4HzZEa04meVfUgcwJE+uocQTtNgjQYMFmw2iZva6AKESeqXtiCYEyxreUmV+rdpd/NazWy/v
 UqTMagjLYVQo8M4IS1eubADOfwJd9JVX8MhCDKe4FxfR1ZRuzLhapYKHDpT3LMzIt+cCAzkKg
 PokVi8dh3a8GFcuHdxEwmoKhSzQgZZCIKDc+0AvlX4wXKVJ+0cwHY8N0J+amMeGlFVhcfqIsr
 XyuTiL7G+mLgxidc6jJBrU2W+x6BUdeSmMg8tdwQdETA5SFzQOzVo3p2VdK5QbgD1CXlqnBl9
 bs1VJptJq0ewZ8oA/GKkDfLj6QlidbHkVbLQPhaxR5JWy6b/oiKMujgWb3vd4r1hmDw4nf1kZ
 PYeqpmQmQFZWbC8ra/VhDkOLtlktWHJC/6xBKCramTmxf9ycYivVtLx8NPIrymQdc0HVP/ncO
 AwYjxsX37KcQMD8zv1rP6OWJ4xTX8DPflDWhWe8M7TL4N01YD+lCSCeIfuRWLz8fQTgsgnA7q
 epW43gjc04MKSI94PrKunP9pL9Fqn5zTyrtCa8Ych9DsfACAaZ874uGlXMeNC15U5FRT6biZ9
 V9jhE3rxNuACtUQlwpori4gR7NWTk4hFUdcjslKaibGbNGUo4ZZK0lRGfu3XQC8vWi2ArXOq/
 f147OSxyJ0tfrHZgzWdJF77jzej82otHn6+IKAzZAYdBIB64r+PEaVtFQXWWNaCNOxNmFZ6P0
 EKUQKEFSYa1QC5wqN/LsjS7qJ/dRwNVJB71Jg5rKEtUEXt6PZ9XmidjKlWi3vmdQ+Mdw/3cQQ
 4yO6e4qNekk9y0Vd03na86cIv/sSprtOqdaeQ5nc1k8Ep1BbsWzwsGby4x7+rVPhH7Do4ec+S
 Khz/BuZ5QsIiZCsgkrpuKut1opa3KW5/pRWl2esPsyoOp5SIT5bJYOMb/0+Lg0j/r2NwfKlZW
 FbiQVumSd5a3Hv79LqfoCBruhRc6p2dHKc+5CG2Yv8pRLkNM0i7tXJk9nV0cerXFTXmelkfH7
 1/p/sSRvRmByzCjbSEloyaoD27XhfLcI3De43cuoaq9bpb05IhWeWMLsf134lHqi3IeCl8k10
 TNB/Nv1f6PI+aFl8PwP33ziHl+rsaYs+Fw1XNxZfm/uPZmRRwb8TdIjciya1DXoKMAAy0QAmb
 Xq6aFi7EVXX4+Z5TFniz9ZqpIKMF99Ns8Uj8tidMtqmuUtfQ7wRzVyWLYKM7cLicmi5BjNZze
 MFWDAHn61XXDEurfru96rY8cCivxOsuqgNE3BhQn461Y8Lw7bJQ7oH8XXSJZZMLWdbQrBsWXE
 P7gn9VW3dGoM1/7OUeCevF/Vn12S/MYJcCpo+rmQwg/mdmnp04eBXDu87HgDBJh0t4W5SLW0+
 0MHpPsF0glSoxyckVHTE4xMVz39EeKDGvfQ7CgBlIDjXqIqiq7Q91ZTElTZw==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Take the file lock since s->to_dst_file and s->rp_state.from_dst_file
may be changed in the migration thread.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ce02c71d8857d470be434bdf3a9cacad3baab0d5..dc47d03874039b686d2a4072ac=
4e6c77e4ff1f87 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
      * The s->rp_state.from_dst_file and s->to_dst_file may use the
      * same fd, but we still shutdown the fd for twice, it is harmless.
      */
-    if (s->to_dst_file) {
-        qemu_file_shutdown(s->to_dst_file);
-    }
-    if (s->rp_state.from_dst_file) {
-        qemu_file_shutdown(s->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_shutdown(s->to_dst_file);
+        }
+        if (s->rp_state.from_dst_file) {
+            qemu_file_shutdown(s->rp_state.from_dst_file);
+        }
     }
=20
     old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,

=2D-=20
2.39.5


