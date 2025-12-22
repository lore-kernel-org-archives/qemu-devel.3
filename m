Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514B5E6ADC5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXmhO-0008CK-Vz; Mon, 22 Dec 2025 15:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmhN-0008C3-7u
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:40:09 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXmhJ-0007ZB-53
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766435998; x=1767040798; i=deller@gmx.de;
 bh=t6Lv/7Wb2lXnWKxvf60fUY0rS/wOeJZiG1odeLUBvas=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YKH0tqApcPgtYXOaf4db6UWegAyqVes3bO4qXp+MrXUzNJxybK4WIUlcPVqEiWa/
 93WJX4Dpvoc3M2B16/8g+Pf1dK5YOMy0m4Rs3xUu36v0PjtM2+jM9IOw0HMkLa9hw
 O2jP0mzvgNEskKRLnNKHGsWAaw9Tk1rfq++xn4PmhAbwiSYKZWB7MsjPowas8ENf2
 69vsl+oMSkzmZHzeOTHVMyqVsUUmtmMEwiH/mzHlph5tQ0VgafFuXjdbX4maMdcQ/
 HXL+sxgY/NVWBFxqvBD1ilbFWK326ypMAE+oLsySrlxJXe16m0smYo+cRNNmkET7Y
 wkfn2sig/XP9X9imFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1w5SPw3RLZ-00gbIA; Mon, 22
 Dec 2025 21:39:57 +0100
Message-ID: <8f33fe1d-ec3f-42ec-a57b-82f5c358b911@gmx.de>
Date: Mon, 22 Dec 2025 21:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] scsi:ncr710: Simplify disconnect handling
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-9-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251221142317.266293-9-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K2fy3JJ7Um3yPiwzuIV/lTtQ5ub7SAhrLI3rsl/Xy/JtoHsL7/h
 10EGqtC2Xqiph2H7DTW+Ck93D6MY+O2eMXl2mQov3xiKktF5v1xvKKoGMzrlr9xVHfX4Rq9
 jQPSe29RnY5+nR4B7j8s1ypNLQzFn6xyIkNyi6PQEkjYXZ0s/Wul0jHgXRaTUrsneJowJuT
 GpNE4BjEVpiCV8CKrtHJQ==
UI-OutboundReport: notjunk:1;M01:P0:2E8usk4Zlis=;XurrMudplIlCYFkOOEHF0Z/x4Py
 SMeIAFUf2USoS9Ja7Fgtx9DQ9OgZyDrEDLJ3RwUPBNb0vYEuvCEKU3NvCvRMmbsSX1pz1jj9M
 Vkg7H0DOd0obpAiqDLWyYJJ1/FmHCbokI4Gfv11v9HcPOvIL3v8efHGNo9tolj2J3H5Lyi31e
 ahJHVKGnsnGpzNmBlucQAjEXF/DXjKdPcpL/tiuo5rW5Pt0TmZEA44SHhdupUzq2IKAA+dyq+
 1Xg+psKaJ7xTij3VVujedjgSocoNkWfQ84HgcFgZ09OPZATIWcDtvRcy5YWPqZQfPASo7JyOk
 EmoT7AGi/bnWKYCM99swAj9ci9dP/fXxYKcu/mSk2qL8MRgvnCzEcSYqXq7e5189cH7Dsja80
 Vl6ysqoSmgiGqatebwJ9kAVvF+11pybQTrkgEwnshakyb2KsZlXzmwQyoeAe/R5jNYI5Sw7Uw
 ZZKhZRWS2CgI7wf4YoWJmEfQm4NpKxp3icZQ+OolScPIzElAsx+V0vonS1iBkbW27mMXkcgN1
 XFcMap0O2zgk4KWVfsF/PEdmwxV823efLiI3a1si6RVRW1HX1D8Wnv2GnXBzy8Gv7/4LN+RqH
 gGrBbZWOargq/7YPx8DzCYRO9oI+OHKrvI8vmAnnl2ud8KHNJesTyu595rehEimYlYh3Avle5
 hdggiwAbFdQqk02YOmW/0cN+zYhE5rMwJYCCUkLe7gQUCWT8xyc30uxJzBPmpaMKWLe4F8uD7
 RQ3GbePcRS/C9j9dbMqZF0U1PmYjMfHpwBqZs4lB/KHxKudbrYa19U8BQeTa+d6nZSwk7Qrg/
 ackSwWnBMFwK43z5OmdphDDyC5sncappS1nqcXFHOxwaex36v42LP6S9vUbDZ6+KLPuJs7CeZ
 uF+ZgcCzS8HVovZ5CE4c72opXxB2QUxvJ11Dg2lc9NAL+65vOivzYvYsdU4Te9KmddrQ/exa3
 jTgiiLGRuWHyBejC5hFpaa7f7FivOfuvL/RHmsoAOEBVc/GbW0Vbv8OHGnn7W3ldi2Y9LMbPk
 AmQR+k96JQbtYXC/1WNSdOsiPq3FB0bOTyfR0EjHoV6/XQxqT2CNBcn7d/ItPPv1byIvMk3yT
 Mxcv1eFpk2cWYmzFKKvhSSovXAlB52jvwbgubRFS+TdCSLxZKVt6IPz7jYJzKYqNNSuoUTSiV
 eKfXP9IedFkEl2enV+2ybStYTtEnJ1caWxDZXd8ytPaGL6dvGSfeuE2Y4AAa93FdmXNPrxs9I
 1uKdwABJC8m5k2WDi/VlKRDbIHlr1pvmE/xtrV2EUHPWsw8dYlzKyTWOKjXbLKwANKpbioGXj
 zk5rd8eMMImqkDuRoJZ9pCpBcQpHsVTZbqbLAmVYBmtLGlrjJZpqaysUAq2fjPypMrGoHolpB
 mzUFUpgC8+YvebPU9UhcBKo9Zqq4qZW2nOrAJ55UySAnX3homl8cjSACxx1CjVtK29kt6gJQs
 F6iLzJVETg4K0j6FqQc12jOSL4DnuRfoBNwwzGU4Kntlx2kjm1/sA1UAgoCCxv0/U1QSiQfuT
 xvWGxMUhVuggZZPbfsAJ+9frt0eMzm1hSBg7RDjMbLIUf8gzt+qqCM4EKXxZ57Nj+8KmowgtW
 +87S/9RLhztEuNT88aUTp/MiO/Aj/gJrfen2YSynMJLPNJGL5cxsG7Owk910kvvNb7ZxcOOkk
 s9VFlalLRGoZ4jP1dTFFeNxj7WXCVJ8XxxTkvlBOfHPptl8TlFT73zWBzP1oxEgXlMEFKe0K4
 z59YQebf23KWtGlqJ7lHMvszbJfZu35La5qCyZfP6Tq+S55sUVfpH/cSkLzwEPC8XYLnlzPCI
 Q7tXTP0UQg4Eht37FrJ0BlXP2Sa59PeVdwzOnUGVNlv4rqdTI9kUrGEfgrgMeACsw6++X9k6J
 GtuzjbKD/Rjt+Uk7cxCQx2GLz2FTFgzNXIuzXT4Vg7F2Hg2JG3fhCfrTTWzR75TxjSI0OLUQs
 HnZcKbe2bypkFkxDeRnQYdo1fzYpksqgAck1X+tlyMC4CW5DOZeaejf2x6yJ/V/Q0V2mp42VC
 VD2wq81Ae3QSOxYLYezSH+WoYQLht74FNgJzchxykdBS49BFjPT7iZXYS1nBEtbW3kmFvOk0U
 LAj4Iha7N/SC6ZqIJVIc/lA40RH7qnmFhg1xiHN9Hock0M535aVoGl8TT5TZgJOqpkZ535tiD
 9UypY9SpULrhixg3+Hlk9yI3/w70uLw8HMRCP9Bc1sxV1TH55PfYqRf0IElf/N8okjXs/2FnR
 M1XcYxqprS1aI3k+MTipMBAHWL5BlgIvFCxQEqyzT3sxWCLbghZjftNCR8ZmC0aC/5fV2nwTM
 rjSS9Dxf6DlmP9Cfr5bX9fOtX74xcl2wLnfyC8g8z3FX1r9eRf69rNFvFPmxT3nQdXVo22RCO
 tiw/mKeJICwMFfIJVXmnAfYDELVHHDyfjl967plPF7nrEpW03tX/7J1z0MBzALIY3QSqirAfM
 gxzY05LQSCSalSDGgq4UXKIGx2mufKNX3A7dvP1SY2vv80L+sZ2tbKwMQTYDqjMfpeSQH8hIh
 FVIxEw2MIE1iBi7IXZ4g6BU3dsg4RO1Nor6JiYovj9A2+z4c5OU+eAKOAx4JJ9tEBT+VhDwdd
 SGEjYYmhDZ9TQBPF8wlXgQk6OTQh5nuSLV1S0oGaU4oySt+WN8MlmDf0S6Xq5AxscUnia5XTe
 g3g1O0e+yj9sqVhy3K8l7A9NdUq1+cZLzXbp4/lfp2/iJpnYnNCKe4LWbu69VPym1oiEVnk2a
 mSJjMaKFapXvmr6CpgxUmCM6c5WbuwT57HfxLGolzsPa/YJ9bDohUZRIOjJRcSN0sbEaLnbOg
 ztec6R8J0+jCe1wINxuFUUaDoM8i/Ueft8Yp2FoJiUPtkJYhdJdTyi22rWUalWQxRxHofcB/i
 6XhwfQdzQpfw8U7e8RojS6LLl+Eyy9YMk0RyAe6WPE6Vh2TrOG+uu08+oPO+i8uCaOU/COuDf
 /bDYx4O42t9IHWxhHShT15orQ33bo6rKnVGfO7/EVZsKSuf0+rel9ZVO0pXkA1+8pxWznyewv
 PmEUyNqCVOcnL903U4fbaDqEO4jO4HVIroPgFl+NlhipLKyeh8vZHlPTCuW+E7MSjDZlwor/x
 M6PJmUkJL7ociKM7HsQtbuirTXIGe4igG3UUHI2d6Zsb53CT+CHNXEOz9YPSLE/2PCTtECDHo
 QE5stHR/rNp4fdN53Rht7Ea+CdCI9d2hmPhP6BiVP/71zoVdYnqKj4MNFWBLA1PQDRCIoYMTO
 YS8JdUaLeGHxPIQaZxyu6kqsdeiLmixZPUU1ioUsRHvYIwxvIhWUiLQDQQY2ojYMoDKLFVhLP
 An99LIhpHmC/hnLw4t0FnPnghI+aA/zBosxoK/BhZTUUgvRUa7irecAeoKYbMrv3hRfokHYD5
 6J1b8mULfMFiQyOmXXuatseKGdZP8qTgJrvzo7vf88sD8OxIZE/QkC0Jkef6UykV27t36WuED
 KmgEQiS2VQeAmDfEV+RUxi4gTsJZ0sqtbnUtLaDAgDCxNgct9qqd2skazlQ8ns8DAqcAz5vyr
 KdwE8C6dv2wVQyLLTyNYlSbPhAZ9wE01VEIHuBXusYmYL4FjsDFZFVXX05mfAhzpzz2HbXh/f
 rhzyrJlsq7LFrnhpjMsZROnHMfTlAzKJkm0ZjLwvEqoX+Iv3Bq9MJk4pjbqTJFMvHJ0kqxZSf
 P0C05fQ8hQPgz28mmKwtwXGdGrj9+0WXwIgZ87srJ6KCGBs/Iv5vhGL8x2PSb2CmH0lPXIEtM
 C7lIYqwJUWzL9I2lLGW9kV/c2BLh204vw4Oz55YwJgIMI7q3S5Xl2mdnmfDPEnLJHpytyFKpp
 jPxV8889oocHo/x/ppS6y0BGRzeYS51gWE3hEnwlgmDSJyoaxHgUEriA6J9bs437ppUWUIIg6
 wG7zxWxkRR+NAa8VwltTqsogMC/x7kgkSyG7AZejqvwVL8U8Ts0RzyrdO4JNQ0NXQxbBYevEE
 o/hvuYtcwvED/8T2sF/YZX6hnWhSXBBmbgsFxSblgfWLy2iBWnljk2YjC9jx4BBYBt7buKA+Z
 V0HkoKbyEjvg6lrgM89+WzPi/KpZShc7QhGiqbI1NjW7TcPbBnt2lNrcmShXUnZcjoPNI03LJ
 MASeFUHKIOBwHbfTe8aE2z4WgdvrTArg9L6etjaxvOdCfQjjx4UfcJDmVzyw8Bbj95Vzh54JY
 NcyQYp/7qNxf54qZEilwDYjlbZLf2GD46PC7zmhh6wLWbGuvwoAKF5zqw0gIy10Yly3c7VnMB
 B2/ZiN47y0KelivUcPNcUa3IehuHXSWXoU/TSlrmqQ/QTQlgaPZ0d08HTIDi6QFire0ZSMBjc
 4jXu9prZ0b1LOy5CleGqlvfnAfi8mnZMg0HXxHh+JO2btiFO65IWYuVLj6Tqy9fMx2GOEfqpQ
 h5TjhgyFsA4NSklQGbMj5xu9J5493HN/jFp0ZM2B/Fg81EzkmwvUwfrSycP68nfwOwWIh0RMA
 wHOE+vMEm/Z7XwHCgmfadn33hTaPWgDT/PvRdKasX4df0effhBbsICUEnsJwIzuu1P7qSCQWY
 XB5Za8xmvjpvUuxxHqeLMAuu51ydr47li/1ET3ndSS/lPXvL8nnYyiJvZX8d9nVI86lcWl1BG
 l03UdIYbA4X72ikleimKjFAAdSgT4PHSVqZ59V0657IMxCgfslblNh/nGUdvVDtguOT0xsSkR
 e4JuTuSPQ5XcUBV6liCF2ZqCA4t4XSyPuWgc9O7YLPFiQPDQiS2865+MsOvKOxNzOed4lWq0I
 ZTJRvN/nDSmnEhqkY7vKL3U/sNIVY7KwIS41TRo0gv/MDh2I149UqjIgADdGpaYIxpHdg4Cv6
 rQNffPwkpkYLIGOhodpmj9Ix0SuE1TS5HSAEv/S635UHB3eOVpo+jX16f+c+0DAgnADKKgISt
 AJTCmPYYTKAQj8ZV5FEl5XatUEtD4maiyEJSH9PBMdS50u7jJJ1IYZCj8sYvI8TiLGL0mmFu4
 +BoxixoDTWFh2//TMsY5oLAj/A8yUSuoOiW1reYsjW8p9Yiqd5xtOMmrVuLn2Sd20BQ43pzCj
 EC6xDswXuTlefxLpJQ+eLrn/URSMtg0K86cglJEjw4moEZbg9aNyUQ7Lf198tLZz0g6XVDGx8
 oaQISgve1BBwVAMsn5FO5z5w59CCKCiu4jOLwq
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> Simplify disconnect instruction by unconditionally clearing waiting
> statements when command completes
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>

Tested-by: Helge Deller <deller@gmx.de>

