Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F2C9831F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qVR-0001XA-Pr; Thu, 24 Sep 2026 16:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x9qVP-0001WU-U2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:57:23 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x9qVN-0005oq-Rv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790283428; x=1790888228; i=deller@gmx.de;
 bh=RwsTz1V0m3rslKoF/Rxp66iJ2YDbHs65f0koS9+sig8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=R3eXq2kZyr3ROFnm0qnhAgq0+ZFSAjEj412q9jKTSkvKJtL+nabPfzD03TkaJPkE
 IXDDUEZEhQ4Jz3yKLz1TFkG2fZ73hTOlkTGBwxho3JPC1n+4TJqBMHgcyBVD2Oa1v
 zy0XY/kswKMPnL90OnN2R8bq6yxM62rTFbWoYnNM+PmRjvNr3KVjsW4h2HBQzo+YS
 VBKvT6OCU8JDCn/dfUJX442r0pfCDJdmfvVYLVgJHD2/sjnxjZRk4DdZCJSZ/dWjX
 /+w3hb9VHscQTBs+RQajtZgiciXtIugRR9NaaWiJeGD+hw5lWD50/iTuzzaNR6tkl
 bceGPeDxlZg18+ZpcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1xMrDR1YO1-00OTPg; Thu, 24
 Sep 2026 22:57:08 +0200
Message-ID: <415fa6d0-c734-463c-bbd8-360f1787861a@gmx.de>
Date: Thu, 24 Sep 2026 22:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: report EBADF for setsockopt()/getsockopt() on
 a bad fd
To: Michael Morrell <mmorrell@tachyum.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Shevlyakov <igor@tachyum.com>
References: <20260924193341.2064665-1-mmorrell@tachyum.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260924193341.2064665-1-mmorrell@tachyum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uqoEeEw/CHiT3byTzKf/WootZdgoTBpdG5qXToct+E7Ep4CuhbV
 VkfQsM+lNc6z+5AAl+mnAf8udVgMeOVf1JL6njpmGWwDNoym/pm+py8fzaJhzM/UVrYDGWC
 0ukc3UqSFdyul5xSeEX40z1NeZAguVeB9Kgk1W3utL+m1ci8ZCzvNZKSDtb7p7z2UhJPipk
 5Tdl01XhLiWlYnh9uFrzg==
UI-OutboundReport: notjunk:1;M01:P0:oNFM+2YMQbE=;aElRtzef+kDFdMBKPUkqMtwQ2To
 ptQYjemGWz3teyl8yu0ogFX0Q1YYLqcLiIaNqh1x6vUxaFMkZGees2jvagbXWu074OXQuix7E
 TdyFUTddXeX3u/IN8R488XQ7IKpMqn2TSGDuMv/U8t6e3pHWI/ArobCyE3wMAKNkgErWrlfd+
 ZPwx/7biy9FWxYwmrA+1KDvImdukDC22As9Heim0LG6g+LWF2NNmC5Z5dQgjMkhlOjTyPvAv1
 /UJP9aYS+3Jcq5+sH+bUpYeQNLyCAqEwENJiL30a+KZdXldBUsEBNfDPj6rkf3xFbeipo+7sd
 LgByV6ip9EZf/hGzTUgWAK8tN9hJx99zdu39JBCeDYpusBEPUjewecAPczx+dINcCxkchuYh+
 D+9evDYD7DZu7iKe/TENMlase3hIcC2PgkXmblIKbI4VYoIfJgiAYJTctLvtXA2E7JvoOjLAF
 hOYSwPFK9+6hHF7yzbHEFxlZAxK2mWP3rcxWDe3ktdXAEiP9tsGujL4UnYq3gPF7sym8NS0Za
 qtFq8V6sRPqMxbA4V/riymxnZuUBZL6K2lvWyfdDdMn7fC/OvVnm+K0cneydb3z0sTJkcSoWI
 JifRkxvlGRditfDJ/BKLUPfelu7G3Y1XXXtGS+qEzRxjmqaxjYC+Jm2aXnCp2gFj+omblPD0q
 Hyve0ehh05oMNI/vBjiVzg6YJlsrPkRS52dcMoH3UsKyrLkoTHeoII1AEM/Rw7L4E0jD45sAY
 F83j1TBrJRVcjc2HeTPSwntO3ywOQZaAEwcDlzGwLCRHJD43eIwflZ4s+H6f5XlEOkXUTG/W1
 N1/at9AfCqts5BYi4FeoPeSodNZ6UopYaNQoCfzM9F0q6roBmZv/7VLjXCLOcqAumdDE2qa6L
 ZNpCU8gDR9d7B8OqvX8E+6Vy/DyU4XXe4K6TsXnTUn/G0B6GAv5mF1disGxOzhVJLbzjNNmCM
 a+WnvGVUUa9KoWzTiV6C41ATVBwLMZf/Sf/qOhNdhXQSeMK6ApT5yaZbMQZXCPwlVrYLH8OHR
 Q5QTNROwGGwWa8h04fxUX7HChFXzFytqLVdTKgxe2nfJAfZA8jtrIBQpr9ZfKqehQRrMglWoc
 JhbPGIdDybRAPhSq1TfG7P44+69sIY+5vHt/hvdLOl9GUEp39ZbvFKi9R0LRqZtx6w+zidy/C
 mcA+uUMiSRUGK7JA2FujqxSoXOgk03L+DYGIEqlOaZZtkg+GugB4S/VEhXAFvCgYvSkv6T5af
 97aNtn8xlkUIVNlt/ZTD3LSGa4SknD4dgtS/7xeVCnnzNMY68tiG175YAuBBBIyZwChkKsHTY
 oqVnCvdxFeL+6wS1fs2c/q12uudNr/SfKnZALpyaG04+0pfkCqDvmTa2CKN30amaR2Si1YfZZ
 SbfCoVkjTANDDIlBE2JD0vB2UYdWU9Ho3yKMxcfPxJyWzTqoahefinoscY0sZeEYNMnss+Yxu
 EPpoTE2jNuXaNfovihabTzeXRsDeJsBcn78PivvmVyL/JpLwmYOJVB/qYriwNWXVB9e9Lovl/
 eZk1XAyK54E8hn+uwTA6MlZVBW9JQChl242HJi/QY72N2DQg8p/8RTuyFcingu6xjApNlGX2D
 Z3+NYLzpJWIT8zwhPak2Noi88cUS1/AUjWkpoIdI5NDPJSQ5V2ta6RtsHyKI4h6QFEU4NaFKp
 4SBLprqA5lCvMXKX4v0nIILjoWlpKAR/MuXOprMX4GorS7E40ngbd+OLKlsVauShRROKkti/y
 FqDIshHJcWzrWUhOaYAxvqwUbRyzs5YXHtYlQUxFpbtdlunDtqJI/vPgwLlOOH0Jgr0ENxOY3
 f6EGqAF+odCiH/jjUGjn6/3ZxXMHA5JgXOYxbhoBZbNnbJReCho2L1PgQ1fCqDmQvGP0Yk6u6
 Ejt1Qfr7JnKkjcQcw2f/8tmMcC6renl8+W1JXDfaWBLU6CFBkAnhsuGQVONDKNmLULTpg0VeG
 q87NnunIa66O7cDrO7mJNic60CfpKS28Qumwa89xtTo8m6djqlIt79mc27Nys+jajhoaEFwIG
 RizXg41Btsib+j/SfiRQtWeMBkPGmA0c9OLVP9lKP9uyYfx9S4kEP0I2zlSqAP8dpb+c6Nekl
 Z2uHpH0+F1CDU9w0WoI+z8OC9vCTRXwOW8o25jcCoC33rUb5AdXQuLrI0LKUuPrie7otDCkbe
 roxsEwc1ZXWOSY+NFltCuKQssyJ4yCtP8spf7zldkrTvhYSKePsG9caZpJYleSsK62pVBBgbc
 dl0iS8cDpsudSiRwRwIlda7zGqNHeQ1YW99dZmhozsiKh/R8GpqbMWdd9tQ2DqViGnWAlQqqA
 Nizy5lEym8BhQdYxGB3DZgkdOEPkJ8OZq489+7AraWRVgSyhfgbZN3iY3uLGCL53CgOwuRauh
 24jbeXw0y9YyUQycTYDQ5sMJEPUe/CTzWeKaPWh8vxQOM8xFb2jbHnE5VLbpK2MsLwsRZ/EHP
 3At4y/4ahLfe/9lYHc5JqxOfg+21V8vYgbY6XP/IHmMC5UxTjBeYUUCFV8q8JK4jxd7uXH7IB
 UO+RSj7wDBCmtueSUn7ETH/KOoRau40b33ZYhUAuiQAa8+HN1wYC+UZiWXvbPjbgW5TUnIGky
 IhBXlyPEx7WNLquuB9Xj2UAeCACWEMSBS3ZEwx2SFdS4teLB7Zb7X3AdqUkTwOqshxq+rPlYo
 9wbzgjEfEiu9SHlHfMHm5k4X5lW4+U/66KmywBoMzSAsoK2fsw0nj6iklJ2OhSUbNrZlXbXqO
 kCMfqVBBQXWrgcY8uD6nizcR9ZAlaw3jHmi9WbOU8DDbSuieKSmYDQmufd7jNQ9Ivj9Ojd+Om
 tzCqKNRFqZYU7ByEeC/tExanAtIWQjr27RVLYeoovWpYLJOSjY3xSbUSMEOcDY6HRPd+Hqq+W
 AOCaYbk9KOViiWWQkQW3HebmqIRrlAQIIQRZepnVuiZUR6schpXC8clE+0FfMwteyYsTk3lyO
 x1TqDxBruyFil4egqQrv989mzpFGaTufxipsNPONS/rbkEXKFNtDFDRcDUzsTmGkLdsXELcsX
 yZRq7nqyRbkdMk7+D0nD2qx2veVWEeXCYa+y1yrjVC5BWm9wtMueTLnwgdHnX+Amo0mbejgo1
 YXEhfYh4FM4YxVxW6EeWWIMUshZVMWG6atDHOAI3/CtENVQS6WFr3DwwXLUflsoU5G24iZHYi
 7o1JXGln4iyHH6WyspwSJ72G8sF24/e1jE9fzns5P8OEvLVATqKVISWDJd/ogBEifR3S6At1O
 FVkzYEtVcMaIjjrEDPKHo9c2GgjbZNwbUNDS29qbyjqA4bnvkRzr7pe5qr2Rdpdq6zEx/OOEZ
 PC+Jv2kEud0iSx5qxcNeEnBDUTm9b02C++G2NQu7eHwEtYJOOi5GzXWq+axsTD4uGsVtoTGlw
 KClxVhRYPYjzxz+0kUOSlV9ZWCFB76PQdsktOf5MyMpj4LphNR+3VRm4ICmOgFGkHputesDee
 xPhdrperc15sO6oYX/NzXfi/WNzOIAnETN1XqxKb/GFv05JeZmqEL9YaDrZmmr4JALZbGqaP6
 5cxwWN+Ch3WfoFyx74W+9aPIFDIMcP2Bgla0IruPGt0IHAf9y3F9ZzkFxTmH3VGFmgHS+tGEq
 OL4/R+ZEQYJrUCkh7RVcRyqDldWg4z8NOS/AIcFu4DFB/FOa9gIZdxU3I0Y1aWCe9Hzx2oy0H
 vt/5WPgKnXFJE4BvrElGtOrQsM0Z7fTkdeRyjC05Ids1IcRKosH45vn2yjQ1iNUwyE6TkO7QL
 TJ9uL5bA4jvgrSix0vl+6O3y+42gesw32RopcdCqRfNwgmENGr6LqfIrWvFpVlGjqGneUJBj2
 f9NbRVwY5f1RL4EIRp3ym5lsIWBXT+cGMMg9t0CG/CPChK+Mxd9zNYX0byliS5UCSeYYUvIFu
 GOLYDrFDX8FbuElnLSQX+ufF9Kq3B1cpgSC2zVDurr4pKFlDtz6qK44+dKEOV4LMH8BMoLiSz
 70ZNs1fheOxDQyB5e0+EV6tFR22eJI/lHAbYkGBgoFiCsAL43CEEtC9F2pQkmo37EKNYWKUe+
 Mp5Iqv1HWAB5C7QayiL2nXfCGG5O1nI37mlxf22IP91ZS8MdmDa92Bm/0iRtu5NTcLZo7YrC7
 ApaVJQxESYHNqY/ke6JOqBPEJg1qVTN3aY4P2zkOrZZf/vn4xXUrilNYF+9e7f0gaiFvdgaRW
 YLtDzUcAw95uHxT+Z+qOD0tq0Jt7OmWUx2VnS9WaQzK0zeq8KLUJY26RwuQMhT0sCCwKNtmEh
 g04jWmSeiynlKv7Dpkn/ZBluqH1317Agu6/14/6sr9aUCkFqPpXhuu+xx3EkzW8pSmcNDZFvL
 l9hKQdKRk75A6/jaFk81MM9WNp+NiUPgnzbYFR/hOC2HtbBwl1r8IVZdNdbUIusTEkBk3TKx6
 y+E78YiaxvAq7RtsfU25IjdNC1/b+MCybftfa9/qON5Hswi/c2qwKoz+0tJZjhw2tYNIquF1w
 SmUrhlPoBze6Dxo7qLNWJTnKluEbzTuoP3MP40rj9rRgVmR/moSHa5h+2Jj5y1eSBrjxn83FU
 mgWg9BkZTfgdGEpG4mwDGiP60zo9fT/gS8hMBfoxBrfYY1aQMldf+S1a8nJMXiOmFelKKQCUV
 A0xrif2ciR/P4+JcvxtlXB7gPbIbJ3/goDkT9NkT0f+qRhVTfKpzZNNJ2CmfFbR6gpzQL3+XJ
 lZGYUu1rTQwsuMa2QDGLqBB33mNPDVSWW+pEdnsfQmugqfPx7QrQWVqtiMVM2tDPgZu4IFE/m
 JfusgkzcbL5iUxV77mqZJlSSKBplW7ulivEJAi5vtkd6c1XG4z06V9DnBFZWePsi/6SWxLa7p
 H+pgXngOsSQgrNkEKKCToe0B5+bJQn2w2fOC7wDB3vgAAimjfS6ozjIekOefDoWyLObCl8BnS
 NfjdMkk/vvgnVeDQ5k01cO1OJx3p+i8Yu3FtInvtnua28N4B/86MEmcffSs7sc8La58nR0IJS
 jQG+JBcJRjxTrWGF/tepnRHd+UK7qIfNKQgeFG9TOmwus/SR+yOGQXgkW/PaCYmSKaYnRGUOo
 h8pCal7MaNN8PZrjaR1VrwU7l8AQVTDzDnCmzLppnflV4Jyl7M7h+/abjI3gOwZP5j2AwoQX/
 sDqQj4BFNnEk84t+sJLBo6Qxw3TBNnZWuE+CMbYvgC+ffDMR+1RFYf4LI8Xf4k7i1I/MbnpZW
 Ig4dxRzy3353P9FbrfPQtGWF0svPFTGozl9uzQGOhTOCGXdcGPhjPy4l+bj76TVKyZGW8QIEg
 GJxelXEzVObvi+INmglK6M75rktKRKOQGlsbr+5r4oD77ATkEsnlaDZhuHpk2J1omrgH9ThwB
 y9hqK+hbl04YWPk27RnQ05QChH1pE54BOLXlRLo2ZqfMTUTm2jEaGXfoHC3dlTwtoWYS8AdYq
 IxDGWjfEEYSGZlOxvKkymrCJUflizQafHf4YKNYtrhVPX01kAbh5R1MJb5aStwb5OT531EkNF
 VxD5dGIUPUiutrbWaUQGpJer64ObGM9Pa6DRaqRoAG7Yyllplx0FKEu1Pn+KNLvn4iz2iMyDr
 cwX5Jetn3DpSuqMaYruGg+H9bgK1NuebWHaa09Qur5KRnAj0/dDnkLJpjrLJpssyDgKvEBtpw
 rNJP8uEzyQILorbnQS5hMH5g8sV9rZ2HMTZdHtYNnYXBwf8LDeBPULb8+BQtXeXf1iP+U6d2Q
 Lvrz50D/z7iyEAnNZdV6nQBQMrDkwuWD2d7JmHn3xsqAjUrI02RfdVWi3Q3Ydi0F8K9vKDqbJ
 GXgJw50FkEsAe9b4VUdom3ztu5fWprT43dBQRo2KR1S5YlFC9Xa5JoqWLnkVzM6sQ2FVuqme5
 Vd5Xeakzi8dZWOfSuRfpd0gwewGazy0l/Kjgpu9EMn1dJBXbGFvt/hL9HaL0bp/U1oTfqEKzg
 wlGlfC4bHgax+6Z9uudRDpgmGU1asVz7m05/vifsdcXs1k2UaNSD7L09Up6AKKWm2XbuXe184
 TOCZ93iwJTcmgcCOhjeekglXEa5ZcBHTAAGK0+TZWDukWG6KplE1mgvJjAWg0ElWXdvGrdqO7
 jERbCE/j0Tb4eiKBFXyjmzP22gBTm6riDwv5d/tmJwkEmCa8aayqqtnHLN5m7zs5MXmAEMFVU
 elaFONvp0f7TzROBpxuyJTCqi8j+Ph0VECLiwt9tTk+Mqx/Cu2scm4rhZbpWIG1ebIBa6Y5bR
 ZqhZ11hZHk5lN2xvdBDfi8ZcoslMJuUKIMTmeGyIG1XJs2ABHd1kvA/ONcHp07pXdC5eqAB45
 1lXk57y5XGCWZC7n17KtTI+LX1zJ/OGwQ2/njsIqxIKpam8WcFrNeRTITawvdGa/CoJhoqTI1
 i8RnOwOpq/eNX
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/24/26 21:33, Michael Morrell wrote:
> From: Igor Shevlyakov <igor@tachyum.com>
>=20
> The kernel looks the fd up before validating the rest of the call, so a
> negative fd is EBADF whatever else is wrong with the arguments.  Several
> arms of do_setsockopt()/do_getsockopt() reject optlen or optname and
> return without ever reaching the host syscall, so the host never gets to
> supply that EBADF and the guest sees the argument error instead:
>=20
>      setsockopt(-1, SOL_TCP, TCP_NODELAY, ptr, 0)    EINVAL, want EBADF
>      setsockopt(-1, 0x4321, 1, ptr, sizeof(int))     ENOPROTOOPT
>      getsockopt(-1, 0x4321, 1, ptr, &len)            EOPNOTSUPP
>=20
> Caught by glibc's posix/test-errno.
>=20
> Signed-off-by: Igor Shevlyakov <igor@tachyum.com>
> --->   linux-user/syscall.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>


