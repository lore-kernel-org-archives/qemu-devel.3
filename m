Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D5BE9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1iw-0000PB-0j; Mon, 02 Mar 2026 06:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ic-00004q-Mw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:49 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1iZ-0006CF-UC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451939; x=1773056739; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qWZAFCDW5Zw9F5youFICkXpR+DNo+sDHqyMZ60MwjInWtKKSuruUJO+4lMyWvDEv
 uLF2GotyLYXygT3aalD8nIuuehj+a3QD99DZXN3/osFK/I8zbzYYDp0cDYDTjHZvk
 YjhvcwllZP63YfQ77PFkZ+jg3rBWNfTKL94wjoUsFOABkyUiHhtCQQ7n3dR59IG6+
 n6zBrmx0Fv+8LNIWA5JRk1e3YL8yvKGcFVkjxOqNeOOGSqbGf5zYiAi2KCmMdAwN8
 LZ1Axm03TEhKblmxtQrQJfeKy+azCBgJstkhExH0kDFhPuZVuAoVaqCw8Z8suyzd/
 MSAXJOQaNpeG3x2eEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3uS-1vV5pJ2UoM-00cFHo; Mon, 02
 Mar 2026 12:45:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 10/21] colo: Fix crash during device vmstate load
Date: Mon,  2 Mar 2026 12:45:25 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-10-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Jo9ygbD9kqkeUyQ0JD+anPkAvVD/vEUQ7S+iY6iqDJE=;
 b=owEBbAKT/ZANAwAKATWrCyicXbJYAcsmYgBppW6TE4TtvACx8sPo9bkeKrkgYOi9UHywHFffo
 i8wmTqS9h2JAjIEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WHEzD/YiFPbg2QKyOcqwBXfjR90ystq8HMSgiWtxTTG69A0VnzwP4tcFxxSwMGVSrYoSpp2CvJ+
 S+qmBYWb7HVJ8Qm3u7293sJBWk7WbPengg4RN5UTxVs7QBoMeRTm5AWJt816FC5nU6/5tpwv5ny
 H/MGiUkG/uMdPwUbHte/icqkDO0XHMdctkKgjCyCwieVsp4pRGmd5sWhglg6p1ONuY5jKma7zsN
 VrLnsDsB8W/z4X6MGi+wGDJE+iYUYbn5+tCo7ZVKjrJwWvw/Q04ffwTnCikSt9zg269K0g0b3Z5
 xA78DSHy3kt03XIw3e399+mM1nkZs0gwI7HqVMGSWRzaGla7H3wD/lymHFu77zGaa9XGriXvqQF
 oW5mtNkROcmE9o1ZwMX9Lph7M2r7VQQsKOZiJojqhYQCM+bBaaW+SzhjvUe5nlqegeLWE+XEwJf
 IsWA84xFVVVL3V4Rj8xa3kk3KOSm1T0+YkGhfbH6n8OXjdALf4U2bwlKfpKnDq0SviePooMowEf
 1I0lt167KCzsFN3TOabFgaHBCaHMSVFpPXNXYj++WnEBf4wwf30Uz2EJJHAQeQVl2WCywjvip2c
 UzO21BorGTI9j8NktQxa4ejP1LBUheOvZ74WGgY66rEXSVegHkaTKDuylLIE7GkFSwMnNKswBP3
 F0Bg+VSo0TdkD
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p3NhA2+8ZTFvWhW2HvbOvD9y9FsTa8pyxnkoGKjUfNm1EDw6Fg/
 722whGI2A+usYQDIlSQbtHmRBavlMXKVSO6KvhZqEv9ERXBnaCxF6DQxcBQNiC6lMtbZOit
 eInU+CiuriTOj33QGEqE/QSxHI47ZJeAN3MEt071L+rbBf+7g3tE2+Kud4Cw698oJRdBF66
 NgUt8tHOykl2qwa8nrKAg==
UI-OutboundReport: notjunk:1;M01:P0:WUr3+Pi+q6Q=;l2O0FcNgmlayeHQfxLvSV9jBlOI
 lpTSjWLi5/C996DvRdGuDQYYYcj7vrEn3qrNnfwwKQodMnsifUm/lsCl4nwesPTz7aVjl8PEM
 DcFktPuAZm36zbhp6OwGB4Pna4FDGdLeC6Xs0/nkCcDHhElvgISsUlqvnWSImH9c+gLJ8JD4I
 JUbjYORDwJ5P1YJU2bk4oCVoVeIqMGEPGSVe7nuIbeZx/ULXdWUCl3TEBo3AMvwwNGnhwEv7I
 XwS8ke/eS9hq9uUDZEhYsnzNJWImOgo8hByyH/BQaOIB0i83b8oQrpbBsZ/WY+xl4ZjfrKw+8
 63wHh8qvBxYqcjXF2XXeU+E+5CY2YQfsKpAHdzHiTsRi7SdUAsPMeR/XsvudjheyVHrbn5snr
 xSGjFC1ZsBRBu1grBWdYtDKn/84S0w6PANEVfbU8bJuYt6MXsmvpwluRNl+TWEKJCib+7Lwzs
 GbT+AdGkO4RjHbwjv61iarYQuzwcKn84qDSXq8jjXD0hs62Mg0VxMSlwT6OntMmpicYpeQmhw
 U+DV3V9WHZ88R+0TcpG+C0tddy1Opgqfn8KXjrnl96bzwfJ+lLbPHTYXaFXF1OLAwYlmTBucT
 AVgPhsJvDShpEWYrCeJCDehGS98c+z2NkIgkx2063gmGl4edRmvV5YPxZMIOK60Y2KV4sIT+w
 jM3vHILQMTTx5SqEgRWXu48syC1ELnry7NI13tXEpfvw4zyqzWek//PMID79lF68T8u+4oS8w
 APIx6k4i1qz2Tl0/CMpAiOj+gIZaShno4++rbUDvz/nLgaifxwi9HJIRLPhAC1dCKMXDFQgKQ
 xmf2yNUHY7HY9kHog/Q0cVRkuFp0vBHuLHxwIlwWpsC95McQ4Mjlbn218Cr9lzxn8zIbVfWRE
 Yz3H7+MhUSCpd+CPcQ5bjKT6ok1/yj28V4xrn+p78DESDCv1i7WhxJnutGe3KDz93BIYmzCMW
 7u0cn6K77hAMnpAs/kMmsKl8HBE7T8UiwQcF/JhQbaX0AVWadfbAmRJbLUT6NOo4EpbPO0NKI
 yhXKrhNsFblXbv20N1KEABlMxE6b2dKXc3ZVzMeWSjLs391TtRdqZm303zkQyJONjUEfWRc9e
 FRndDFr1R5IPQb0Pf9FdNmyrNY8ItIqZ/CV9f/VtzXH+QuGL9ikDfOtdUQDWSExXbd6jMd8Uq
 zDP7QyoECVzMSLjk29bfObX57NvDhXLU47ENWCfRCg274TvMvVCnwEMdL8AAniCkDYUhBoomv
 YRr5YvyvhPliEAWyGzz/tuON3pku2Q32NYkg1xaTOKad42cRgSKoh+SQFC/OdadBcLR39Yr7G
 UVobaBLUY9pazuHljEeYkR59G5Xg7qahyWCM841+c5twkceWTL1Vz9DjRS/VupA8XFPKjGYbB
 6iITOBQNSbM5xzzyCjfvWEJWcRRQ0KG+uvzbi00lQPmjtj9he3xxGOPC53kUnzBJ/b1zlrAKI
 u7nYDsYTDpf5SOe0Natm1xO9m5/W/dVSWALzm5shfMyRnLKLJ3O8JuhsBAU5OQiaUPp8zDDTL
 +MSnWyWUZsaEiqlqJp2v8XiPNH7o+DBh8DEC0FVsvbM4KkmzOsNc8cU/3BN8nWL5DvSF3BtYP
 XfTzI29ROU5bIbtU4HKcrHEUVkxbqO9RCmgKhVuNS9HJ7a1PIivvnCGVHihULtKkGGDwjRpoT
 FmVW7S+mORYQz0BQAWCwBRvwbaBsnc4gtRF2H2JXsLQQ9HBEMYZgARLUAN6pfcsX8I8tUdetv
 YMjegB7C2OzD2hONNTRBEO4l4353qfnJjIDTPzw9744SJhqR3Ao9JkYfk5NZiMHGMBkq9njpa
 NxDkDlqrIbND5FUnfx5lTsV0RS5Ypt0Xz1Ch91AeGEkZ0kb5Q8xocKiAJPCnn70nihZ3oOl+p
 eBbA8OXRGabBjV69dum4DcZ+MZdjaLosurAR6QcF5eyosFY2WLQItOlXSgWbrzr7pNBS/ATYw
 oDGMCux7slEs1dCCTche6C7fkSRuoX5o5nlauBDOwPBKbp32tanixp42+hpq0OHh3IlFL2wjv
 S7cuLf/d7p6Hucdxzl6FecpUKiXEdRQIG2XCkpUrOrpVQJczsAz5m2TpkfYv5rxGJYifFHo9f
 ajIB9G8fKYnscsnUzdyxKu77YOlCxPGxkflfq3lvnz+6tBhzp0HydsqAvQTZtmzXPM9dgt+mW
 Exk6gH2BfWX9+ZC57yf0tsYuxaN3x/tHvtm0jXekvBQnviT0GPpCG+SNwbQKtbNIQ732fDQkt
 3izUuMmMOD+O2ZPBbIbI6uvD64FSye291aWF7s8UnOxtXhh8sQmCHa3By+R5BLv78DDYXVg8S
 Lv3S1MFJp5gAw4UyIGwbDq1PgDbaxYTAPjFMr2dFn8zdCSC/f8J0UACm+ol1fmS5f7/jycU71
 DO2GMgP+v6Ut0c9O8ckG3vmPfvfqD/UpUicsUdIm+qEpd4TCxBrUlEnCPm6EIVxe0h+ZoVdYm
 e66dgAp4Gf0/ojglSNGtDKThw7/8iJ5243lJvmWQOeSR98PCl9qjf89A20YhTMoxBDrmG8pdT
 IHxwV8zilpwtyQWGaxDYR2opuxU2vqTRjkbcYU5NKE+lSXHslapBWi1FeZccDtePyzZkirc+G
 EI61DBfkdtYd+cFG1jWIB5tHLlnM5CUBM5zKFf7E4rAak4gTvKUo+ZVVGQDzJmNQAsyFcyv8b
 vKip8jgBfgHP7xrgp2PFCqbHQ58l9U+5KcbhFDW4TzfAUvwJzf4vyTwdRKMzPrE+RwrONQYl+
 OG2bBQmmk2klxFPTapgn+TySvGqSRf87gXBKmVdlepK68OgbL7Z8W5JXiyLfQMl91kKgtNVqN
 M7e93gTRU8e7Pr/MwwM5txo5eDE3tu1etYUJdgyIm9j1Et9azsu7bZdAYjRC/N5YxZuNER7lC
 E9urgpYytwAVV7JWxf+/XgCyGhbKwHP7DUhNemENbPp+y7if/gktHkgsM2Wa0wqJteyEJ+PBV
 iozNjgMvisTOKT5HqU/bHbt3BYvOXVHuKzSth3HA/RHPMvrxVgoIjaWdzrCYI1/RV4jWMfjvM
 nnsnxnq0DfUoM7LzqGaKYgF3RZJ1vCdyB0B7aRp/RFHyLuSApvV7i7zxZ//OBzEOQ3vMW09Qh
 HjIg+MAS1GRYbxN72bWR7GqiQoUWB08FZGBYI4aLm7ZQk6IXWj8C9oqo9ZaCz6DQycgC0o6Sj
 5LEGXREbPymTXXbQN8xv8TPkOTMnBMSAdZj7xpL6M7D1Gjs7GzyG42qkobBEhFFUAIXF+76Qs
 L7DTmau4fQbXPiZ6GW724Xopaqd/p3AFWIyMtuECTJg3G1isJX9eRHU2QDnePk8PNvE8qjkT9
 NgZermJTo1EK36nH9wfWExYQZi9lsGKhURvCdTOJHLE+fzWk4IkmjX6VWqgm/e19C6m7XJ3Ml
 8SrPKmp5ZZceGTKxbn/J2CRLp+MlsxSyzMVAsqxAu1haw5Mpb0ls4W5YJc3GihvvoyZuTr8XR
 ByfmIEvCPe7X3m9FyzwKKGORm8byL2g2mx5vVK71V7k+o3XBfYf9qzzHns7V3ggjo9090rNms
 n1C4TMke9WW2EptIY4EFyFhSy/wLXxvScaoQAaUXJi+2KjBRP/lJHSRgSOQke/H7sVasNUby0
 SVMUZfdt5iSOM7pCt7UkAo28xnV+aFA2Oy1j1ZQcPGTB6yYQADvm8JF4mZzFHB9JaH1w7UNFu
 J4FBoNu3fdwnQjGBj6X5W3HKT0tbaWaVPMwKv73G5r7X8KIpokwcxlCxKFVFRBgYuOtet72js
 l6mono0WxJz4oKdsAtUnh1H+4h/2bZg1iYkL29aM4dKvsW/GcilZY+RzeegGYi1YJTiFxGFvS
 n6dfXTEVat7BhLvVUChugx5hAhknVrTiwQJVslBG8fIL+7LCe3J/hyE4NUof1OFpwN79Obe3k
 fpJsUIVZXS55HPnFobdns7EeYbSqbQCpRJL9sFtN1VM6MOEHexrKSCFoL/w/XlU72A/R9EqRg
 WhdjZ8c5P03C3rObsyuXWEeO5KDglD8l2HWoAXu+bgEuxLHLlD0ksImQxkFTRcoCjdo2e1q3O
 03mFKKIvF/u9GbNo6xg6lrthwkgio47yzBlI5S+dng8aKTw4eH+iFgkt9qlbaWpmzrZCFVf1D
 6MvfudMIUGO05DWNP8yLzVPgH9OBfRyoCIRSHU9TE+J+SdTViimaB7psSeJmeEkbgMaNal5yC
 g9qFGlMZPWtJzyuh6RNRB9fqQNdHXWy1KEapW4R8pwAJ29pm1AQtukz0n4XTbce4T6irOWD8s
 Q3TsIVS1zw+7RKIhoc3i2uWJAS1UF/mV9Q/QxRk1I++QxAEbdW0pbtlSnnRXQwizvVJQgkvNf
 EY91Fgg5cfZQfXP8F0uBFX08qY1St8Fj7YLPZJ68kx5+Ph7yprhuVWhe5Ya9o8NPQk5t0iFTJ
 V5tqLgPyahGizRXuXGLSO+m89k8OCMegop4r9yH5jRWkYDR3kqfRwxh4NKKGVT2N0NnLmH0Jc
 dHd3Y3CnFn/g06FFjB+buv+0ORje/gz/xfKakxSx/J9JAbwpv1g166bF/ukeJ2OCcmpr968Xu
 B6HnJPbL72V0B0LF2o/K5TfgmSexxQ1uiOsPedYgw4aiKdK5uZpKlK6eCTOukryUOtjlo0NrT
 aakx/7y/rQtnB/aq2BbAojTaLtT91gND6SCkH/D46eaBR86OfZY1D2KAQWNiPb5slnYrb4aik
 43qFUJgyY1pQ4V+GywSEtNpjnai/+dP7pfuFnv7T0CjT0D5bZZlyjhjCR15foeJrFsRr1RIhc
 TWOhzHF8i8KZP7p6J690+4r8wzBNSElNFnq6NbZPbw3PyDXao9laUzNZXx+4wzQmLgtUMSK8O
 smZOeezjlhzJpkThEJkDQqyloQnDHbMJ7dWrOLP33F3rVI4rggBB/lSX5oxI94hgM/ZV+wN5w
 5tGbkgLIC7La/keHPil/3SRX24zrMUuH331C5SGcpHcMIXjIFjbroQskzZIfhJ3rb7WWHGwlJ
 naHfk/P4aEdIw+lsjYlQkBw3HCyY/PIKgYS4N2o3CrjSzzzQDbVGI3HElNx85eaogvJHsBOfZ
 PrOV1ymlhF3bhoOlXHoMge+RryaVKKVR7VNUvSKkNVyyCpccXbpyyh89iqDOf4/XFp0qtXHu2
 TckVN2u5dK6srA7AwVAadX+hgQQB8ub0GC88WuSKLpC8A8Oz0MiXF2DgRjWw==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

With colo we load device vmstate during each checkpoint, on top of
a vm that was already running. Some devices expect a reset before
loading vmstate on such a previously running vm.

This fixes a crash when using COLO with Q35 machine.

The reset adds 10-20ms overhead to the checkpointing proces in my
testing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 96102c9d0fb3b60e063c81ce07b730011bc4919f..dc7cfa81ef7db78e3ee372642d=
e48567c5bc06eb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,6 +729,12 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
=20
     bql_lock();
     vmstate_loading =3D true;
+    /*
+     * With colo we load device vmstate during each checkpoint, on top of
+     * a vm that was already running. Some devices expect a reset before
+     * loading vmstate on such a previously running vm.
+     */
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb, errp);
     if (ret < 0) {

=2D-=20
2.39.5


