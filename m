Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F3CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnyA-00023P-Mq; Sun, 31 May 2026 17:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTny3-0001yI-Hi
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:45:11 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTny1-0007vv-O8
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780263906; x=1780868706; i=deller@gmx.de;
 bh=WuyO1E4MQjlK0QtM9qvN6C9h7OmIw3orOSE4jNFSByA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Pd7mOwHRdEh4w88TR7BRt2/eJUNyVLQzgCMJGSUViN3yo57wdiuy+qjk8H1WLfJv
 rVTXsDw1KREhuqu6bgU2mOh0CjF5j1UdwHuI+pnm88nnxMwcUmOZQfur5G4DyzpIa
 ZY/qfSKP74nAGQ5oyNVhNFZwJ5GUbeAvI7JRTBAGkW6+PkaEBzWa5e75gGTtOOzMB
 /jyW+TArQDSmHoxrwPAuzJtrjQrYvwHUj4nuoTf2bSulqH0J+/1OxnH972k+NqIgd
 PiuijEJq8A3VBs2iGnaZ+jhuxTp3UXqqKz/Bcxei71Q75wQMthJ3grhMb05gixpJJ
 mNhLRhrlwjUuv2Soiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1wTnxy2AvQ-00HNAS; Sun, 31
 May 2026 23:45:06 +0200
Message-ID: <c9f100b2-4873-4798-ac2c-8db9025547be@gmx.de>
Date: Sun, 31 May 2026 23:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] linux-user: Introduce PGBRange
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260530211248.375318-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZrFiWub9SyQCZFR/JNRbdwKyn+tnhs6hE8o1+SFAR0tkv7B3p64
 UfOQ5mLjWJqywJQ7JFC73dr7Sdqq+ipnOAxnx2Tt5XziWTArencvtPKcIpot2YETJZhUVmm
 Qj2zIP+/bDv2qOrNFSbNIvgnGnWTWoV1lmVM7N9n6q/Uzc+ZBL2F71KJZBNJd+Zb8Ypegky
 /LhrKpiS3rvfUGSuP4xBg==
UI-OutboundReport: notjunk:1;M01:P0:HfT5dFKe8Fg=;2R2Zu1jO//yg1mbx0V51vDAwKp4
 4mucUJ33h5ppjvZLIIHTBJRSNEZBUaZCEJLLpEN3Zi1uMAJ4spw+D1gpcW6JFl4l7BT+ZA3qu
 0gc0zFYdp9o7HNmwmShpIn5vfvSYOQutPs6Bb8MC+SAvuAz+Ukv1Kfn70X/2PiGqAusJ/RSkD
 S2FPUBw6G0CpDHEULIEMxt7QGGdYfJZ2GaAjdnu5qGx0BbMepUDl4M8tXNJ8TLcKLADoiXj7S
 VY3PFnVUg7GBZoYuuh/VQ8Rzd+4t8hFb5eGXLTCstRVZWCbz5snO5lxtGmaIGnF18dIwxLqe8
 tULexLJye/XuYxBUXtcMfUt/YpaYaU6toTRB2gM/tL4BlTtp2IW1DCYLkeCjMU5hVu00ID+50
 2GWAMUznZuYhqFZ9KEH0vShri2QPWyzr0GgMpJP8BTL41wOMOyYq7+sgVGj0D8wrB+tjv29CA
 JLIffjI2w+nXt4mbRmKmHCKW5K8TgQL3CaNj6w75kkf8ArR954sR6E3M4JkmCkDKSADm0vSBa
 ewpovDdOErCCK6R3XA5RiIP5w9yeodywfzlnFWwBoJ6qMnquDyQ8usG8/BgfdVX2mgfKMysf0
 2y8dNqth/XpfUoNnigslvhKJ6l+sSC328fU+jLtvEJVcSB8KscrRQNKcsly+eoovZU4CEM3Tb
 jCx1g9mKjkkCnNG1CwshlHBgNDd8Osu4/b6wJconUAwERcGfFF9EYwp2eGZjUELRbgrqZOb9J
 MRr/RTzhOOxALcabvpWGBbG0Gnov0e5OsYCAjl02GAbFCjp1Y7Z+OYh7q+Ipyak56BBJ0FfYg
 5dG5X6w+ekcqOK57gzpUonpY3WoocOTPiWxKt8RAThRxFkTYpIDZEzsRMDdjNelz2K7bpFvQ1
 PQaxos095ZPSuD9FDwhqptKGt+g4MlNh0ZjxPAtNU4L0U0TJrgsTlhnwn1W9iGVu0yuVskJme
 BePSIJbqmtdHcEPLWkcyR4O/2LZm/UbGw5J2rzkR73iJZCR/pGZyYJMs2prs2Yw5myePCrUAu
 ABu+HT8dwlDa3+s9tjy44tm+kEw//bsfkcQOxA1Y0kA/+6v/ijqUOnXni6DNAK3ZbNkrTUXKl
 PN7kK/HCR/L0163KEyXnksNzEDBm0xK7qlH1FadluTU+t2xLjGUKU3ZWM4/P2jL7dTVYQaSWG
 AEODOeYO4FYWTniNowyufUYAOocawjOvi+BerPIH3UQmdw4XhMZjGxiM8cczXCDPQe5TotUF1
 RhNnUoR1UNX2C5aciz1e3J2xL1EOgHQWX23TJksgANteCI6BNWhJYKXQjRZg9YImiP2DrIRau
 W9qitufQ7YdXiE3VSOVZkTiGJK0U779cpmdQuDd76uWXYRTtvhhA0V/X1NqRbTPWGLPvwFEBG
 Gt62LI/SJb1Pdt0aUlkxnBUWr2Ihh2rDJIOWsp5RB/lrwo2OL8ofZxnoBBIz357IcYCgf5tUW
 8bpgbkhmVx8kT8cIWX0kEXo5VlcKHLHajor+jFtut+jSJAGIH33iOwv36omKbZNGQBx/SLgP5
 BEw5HmlKzzONdwu1oiDPSnLODxwEHZbKZBqd/DXO4e7z3J1sxgtuXAp7ioF6a+6Sav9tMPvyy
 0KFH1HMr+S8UJl0rJqwkRisB0qv/wfXSMLhpnBO0rp8X46mQSTbfTZMfcL9k+MbyCa9DVXmaz
 5FZ6SzQ4LnJMfluyFRpr1SUwifyLvuCXTcpNSI8hVMrHqxPlv/3Xp9BlSVXnE6TCbGiUgRilk
 +veZYP55eEfqSNgDWL1Q4mjcwq5njw1VaeKDjrQclQqQjX9XkQ11Ak5vjriLfyYLDoDXvXkgN
 zw+HUlPHfPdb2hzxRLTcdJABHm3yCz0zyrWJ5HwzMMQmh85WN4v17N/N0VKduK2NJSN4yMNcb
 0oA9NFboVeZ+LbWJwpnC56b1sh/xFh4hmyqy5kmlDRxb9oyJW2hH2kb4WDk2Qhzj8Sz9zQR9g
 Juyen5ZUDDiE99DMPP74sgBvaKYFL3p13y2mPVmASkVOnCJoyDDV0FsjXyn2b45dUCMPlN5XA
 TsYjsAmd1snu5m/etMLo0aWGQncts0T2mZjRrGmXFoyYKXHsAuyt6LJLah7EmM9gA6TxhRiq/
 Ws26IiLK+GtxnP+pDZcqyI07jRUmFg7nLUYzW7RWTLqwy+cxoMbiTfDBfB3ijSWc86tcBqh2W
 To4DFGX96UMxp+2JJVg8a7dzFxY+ufml8sl+014ViZ0OT8z23j4xXdy6N1cp98zqyijBBf54k
 rqgPTP/Llv/9QmG1bHzUyg8IVM+gXw6UmuW5el+GT6ES6Zsx/MhJaGj8zP8EzGinGjmUTvvD7
 zQJgDzeCjDQDVurQTWs+dKR9O1nL0qXjIVw+2+WQfpjfFEtRF7pizzQZiTN6DDFCwEZNp3I+6
 T3OM0m+OfBV/rL0mFXB5BLGvEUs3eBbZq0qpKV0t/9qc/WhEasU2e+dKyb72nWeClicSj4MqV
 kn4klO1LMUZLJLq+wqYyXiRVVS+VJMlTQyhDY/x6AbtJWuQYNGkJqiwaZ2gEIcb4l1N6JyPdm
 Z/S+B8cmog3F8Mn0sVVvaw3kkQM1sN22RUh91bMdNVvucM+UjGuqDQUIhJVjLTWUVV5eyqqU5
 HLWxhKOxRVFkipd89iUXWrZpYVMaiXqlD2PKY1xecbx+vL3FRXos2jogadVXQfadM1Wg4TW/v
 vnXSTksgxw/EzwyZywew9gLXf/Ttu5xGj+uhkWqmCW8HVQjIrMGnzV8K0jAp+iTQKt3svE6fj
 b7LmMSB8TfkUmGZzCQHTZYH2r51S6h4t8yVQpWY1Cb+x3e1Kh+m8u02tcTrA2yGESNCRGE+Tv
 er8Pd2pjZFuKDuH/b6/HoR4RBosjdA/hORocfCDeHekJwfOOWEpNjlM0TKIXqd5BUtN5VPvtx
 8C4wmJFf5Q5kiHfrM1CPH7L18EcuO9DAMbVcClIzWI5EEogVAoIAP2ciVqVat46WmX4DpigBb
 R9RyvVKVeHKj4LZIuk5qobAAPDx/N3cJahRVp09NbUlW0IpqU5veuWM8aJ1ts3X4AQPJnFI1+
 Ht6aJFMxQ11gPtbXgfRmBLqGSLqYR0fPAo6Fa+ml7HJTL92vXyiXAfxrfEUnO2vGZzus3dLsl
 SmYjkwGJPfnl6uWnWBDsK+nEXRgtNIBqBFIgBT9LEJArXv+SsomJm1OMjA/7xd4qJMjEEww3C
 ZSl1s0XTsUGDKRhCQNln41krL32jj+usog3eIqldLOytpvI+8U6GPrzH+MOcfFYGgMycQzcj3
 PsobsCizNxePPMIaYXNn9JJEUT6h/N3eRokfTBYrI7oC4/vz9D2f1owEo6W9hb/mB+LJPYUTf
 Yrxuby44SYIH2X4O2Gebbfhzph+XfFQLlCA3XQNizQ95YxyuOZ74APGScNGKwIdlfqM2ruM5F
 1POvdo8IElOzBc4y4gKpJzQIrXEkKBx6pZ6Yuwt1C8xoJjQlckfS4DC6E3jgi6kbZ1oRHyOdO
 K6RdDOW1B4ZigC8jxC4oGj9hJlJbw0d+42QNVqOtvx08dHAuKfPc0/LE1VnnRUvrGoi8yj678
 6OgEEVdgR0+/6NO9chN21AkslCvcWB9Xfc8j+sF1xjCun4f1+B/bhhdhU9tKCvkoQqUIqL0VZ
 Mp2AyB/MXjaADEvqAoKDf8Lk8IIp8tpwNCu1GWeuEnuPE0hUehN3ltszo/q+Mcp8RzS0K2jrJ
 kqVLo5lZ/TxOg0Uv0J44v+tyicvzx1zjV1PGgY/0mTi9VZOVWwxqrYpU5PRMQ1YSgaJSM69Nv
 13kgg+TG+T4cxs82FKdt7y6jKjsauUWsidN9aZpRlAAa1VB4bTdQ/mU0sosEN30gh3XxIk6wo
 2jN+HBT0M+6l1Y07VXnRf7oalF25zEKd4fz3+afX1G/20VV9hekdA4VRhgtDOaa1aQ+8KYC9R
 8cvxWWTowdmsYOAZieTSz3CZHlzlrXJoyGcXZSkzmmXDfC41N9KZ5uBIkZkJ5trSYjFNqjFRx
 BUosC8CMrRrvWCFd1mWdnYTDV10lw8zqXp1+rTjE4fOG8AwLbSDOaimDP3rWl9NpcrIHw8qWx
 1p+O2413iqPfveO84/a54PLD8NMwO1fXmi+d1s6VStm0AY4YEupegp5AqLKIW39MjlH6mE0Tb
 Qe43E7jAG76zFpK+Mg9AqCQReBqkQoedR3Gsg+vd8YWncj5LoQ0aeBRQ0XLHylf2d73DWGY1f
 dlXaePN9B7dw35FL/QSTCGukshkmElHtL9kYL5GQP/pt4CS2QlKPsRV8zzpKtevukcUUpcLOy
 NVsN5VHwosd8ocNZ5HtJIY7dwR/IIlZU25qi7tj2jRgEIMbtKo7ny/WN5BAJ9PZUC/dhEZquM
 5loOs/IPFpTjdX5Ly45VqLzkwR6w5RaLcT3dFc2qPGfQnd/WXUaVaz41ouyazlyy5u8YH8z3v
 xykHvR2c3D96QfEolFOnxXBe3wMDJfEGGVP6usUzJ1yUweLsizZgff61mCLhen7QeQTg0QaCQ
 w/z9WkqpdbcL4TRaIp+z3UklihONwsVzkA0LBJcr6e4GWVGhZEbLXchfdkO6ZOXUO7WCBIwCu
 5c/0z6ACSkHlUGoKx18gPK4QAYJOnyrwQP+OKfSoNxdlwlCDyMg0UnPhbdqH+1f1TKc2QDKST
 DzZxBzK9pj0vqBC/j9VPTWt0zVBpvFa1A4UNWCfHIZYm2NhXf0ujJDcb5a9ytFOCIp1xlIlqX
 51QSoSIzN3YcFkHQjWaJEfvtTXy/CBG1qH0UbEo27R70vvmPzqtX84a1CRtBr0j0WHTp14c1f
 YPgF8evaVbedOA84h+cWM8CvpkWqvTtlbPzna9cMSXELRmEDgbWi2HrIyyLMNcv1CJBuFmNXP
 E6y684nbvJFOeHW4JU+mI+MBY15hfintWlibWVr+HiokW68RrGG7Ef2du6d+PF3D3FSpiv1Sc
 pI00BoIfiGM3SSAdFvq9u2Sr2tzu0Qm+rs6liP/2VKUtezVcJb6vLPzKMx1zD6rMIpmtcF+BZ
 CULuQ2OtgqwbbAbi32MZho0YL9ykRnf2/aMW24ZuTqsiKe5/TUP3QGnM02iJJh1gBiOGOsBBp
 hSDDnGB8N6OIwAGj5pppGuhbPoiMyj2qLX60yGtBl/FLH5bgw1NiiPBdKtwXb9a798OEltY0Q
 yWhodp5VPH5ZbfirsMWfLCa+u+RIcmqj8Ow/K/Xh5DC014I4uDyEqQkPqmAVJJxnXBFHbz1QH
 hi3ge5V6FK0KAGn3TWDG4J8jjyTZllCCzRokxE1XEzeJ/Vi9XmAMydQ8fzknRJ3nfrR/6oaD+
 jCfiT3whJA6g3O9rYFPIY8nqIj5x7hrs+ClOHK7YujNf92JGDV6Pcbbz7xRpSLTj/xEFtcv5K
 8LcW3cGQnZQMJCKvfjZ9wDEXfoMm7DEZMPysvesrY5qExZnSlNEssGuB9mO9OI3TTU0kRS77i
 +8r0B+rIkQzV//ZX98mywZBu0JUpqW9c9Qs7pyJmwY1fEDX8Z/WY55NSvQ8ZrKaralXF8DatV
 hl4gEd+KXBIBF5CJ3aBc/CXctg0Mjr4itkK5xkZCZ6Lh/RNg3SzkCTyECdW2Vk7CW6pcgxaNr
 VHrAMF5njgzK2XL7DFc4iLG5XqY=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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
> Create a structure to hold a beginning/end range for guest virtual
> addresses, for use by probe_guest_base.  Use vaddr for clarity.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/user-internals.h |  5 +++++
>   linux-user/elfload.c        | 36 ++++++++++++++++++------------------
>   2 files changed, 23 insertions(+), 18 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

