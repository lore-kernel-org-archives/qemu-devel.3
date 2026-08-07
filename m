Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070D8C5ACAB
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsS56-0000JW-Cu; Fri, 07 Aug 2026 17:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsS54-0000J5-5a
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 17:26:18 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsS51-0003z4-KU
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786137968; x=1786742768; i=deller@gmx.de;
 bh=ro7aOfx0/R9PvJHP8TClW1MpCZse+RM248JwEC3u1e8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s6r8EnyYwFBxwmSeuHROKmUcxxXwjMEPrX6DAxAzLbk7bqDGUuhFu8Xgn6ZnL4Ng
 2xmU3GcsXiggby5eTsYM//mZMYkKWvv9H3fcLcQkvA88Gj+ZqT1EvdwQh+XYQY3Y3
 BBpgVIQdHxxDHWoKv4431vmWdcgkyfzu+EvC2BnplRVTbUP1+lUx/6/zFVzO79Y8j
 0riyD8FQ+mx3xgQiTMEJsPPT0aI2pF0pvhRBRWCk/z1C+MozkpvTh8HtJent4VLb4
 93kkk+Pwyr+KNSAKWIIA2LEiOJLQBUgpkmmWIpw+uV6hFpyaoxGWrEmbPe6IQFknN
 g3REMdhStyekEVZywg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1wNuUL25IH-00Jxe4; Fri, 07
 Aug 2026 23:26:08 +0200
Message-ID: <6f98eb42-54ae-4909-b4f1-4ff683d3d6f9@gmx.de>
Date: Fri, 7 Aug 2026 23:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix issues with mmap on 4K guest on 16K host
 and library load
To: Andreas Kemnade <andreas@kemnade.info>, qemu-devel@nongnu.org
Cc: sre@kernel.org
References: <20260805164052.199608-1-andreas@kemnade.info>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260805164052.199608-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bQ9K4wFmJFFthhTpqbo8EdWLjvWY5Kqr3z2rQRBYhbwmWO4h9S
 iVJsrV6rC2Xstc/sDnurR5XX/bgRlSz1YUtv833UAHoX21aZjvzX4TKCYIHio73KwinLpsd
 uldUBvTmGHp1BUeYWrvDdCrFpZJh5gc2PvhglDbwENUWIMJVvWpuNbjGGObN2Ip9qQAmKS3
 SjUAUrmhLCNeAguwoJSgg==
UI-OutboundReport: notjunk:1;M01:P0:gQi+d203DZg=;6sDlZuL752KfnmWKzgMpgTKuYIr
 aAfwgjA2h3/SHrhCSfC8BZ1bfbDf44E0R9BntFJWynJ8ynfdp/TT0vF/wLOek7Ooms19H0CyU
 YvDeDjO0plAFeIYDQNQdoXQiExzzDQJGUqeqWtY9jfEd89wADBq5narNHU2P9/KVMV1qIm1kp
 hE4xHDWyn8bmVm9shMJ9sdBdxJbjn4Bm0ivSqfjWVMrrMQVqF+nU7pS/otQuL0k7as99gRa0C
 dxoY1RxIdMY6MoRwteXT2Cv8kqeBHd8lZdpRsUdoEzM9Mj032xJeCbjeTIZnBRuyI0d+2/Lhn
 MpmMvCi8boAKkm0lLtv8KuPKdtemrK7ZxsqcA4VnISg7okeGjc5aKf4JGuq7ck9f+hQjxt8Jp
 +m85nF9v+5Q2WxRZdDslFc5jynvmQidGFkitAKkCLveLqBNdSjCF5TVPioFRwAlwlsrky4tRo
 tPUlwlSQSb6rxRCc27oubGUkFDK3jUQNhkQp6pYIoRnmvCnPYpVOk4VqcAKZfKgnvhJwyWMIc
 UL0/ckDQI51ddQOnCKIvDWqExlfQk8uS/nm/3N2KQXcOspDkIA0pt5kAQe8NlGPJA/OPs6els
 EuxBiaGXx3r8u9p0Ux5AdnMu8H51WkxSq2eyN8k9x5vfA/RHAsepJon0m73J9V03PDU45IF+f
 UWLcMHrcCKjx9mYh1IzU3WDdM7EWY4jA6COGHaZ5nP7TJe+jCljy9r+iPIvNO8AxyKz5OBACY
 aaffmL311bGYQQSCDLN39oDUssB6lnnvc7PIrAgkTO3WW88E17B3rzjP3zeax6NXvFbV5yatX
 FUAAnWNTltyCn1zVA/DWorbi938cXcXkwVIbAPWujH8TG82TFpn810gxspmk30yEBqhKP6Q+g
 GVc2jidIjV1/iIK3Xl+0A3SkF0VT5wicdnw5ksvPvTbk5X7yQ5Peztj/5kgyLU6bkFpuAzThp
 ruj50HxXzXej25iFwqj4wLertERr+TSTDO71MWhpohkfWTqGkA1wouyMWcLUbSgsLY+BhGpTK
 B98pJTMzBGhTatO32Q1BLjBSriMwR6B+uMRl1jvOd0MLGPXZIfQ+eNu2Zxh/RY0xoTPv1CpY2
 DK5UznqqNIi+kZzFENZ69yFW24NpSfgoYGgP3stJWvTGDVS2lHEKb+zoGWrqtfKsH9uV40k+V
 wdb5enx1g5A6jcynjm9ffo3f1bw6yIu/ASsDjnviveB0RieafAI50JzrIi9/ByLUHejTh04Uo
 Fhgm0PKrC33L7p6RWEiVsM1suedpLa+6M+eERE56Yj1qZhrztgYK6/HN/IImRY434zAw3EoGT
 TF6Ux43tVxUTWVbW4315nDbmVk/UfpVV6rpab4LSNiSBxJrDIB7w/VlCHP0qycdpVJn9mIAF/
 MxKe/Q5XCxPS8Zx6Zo7z8rArH+wD4/TsmsNxBD+ogueImljr/7eMMT7r+SJIcNngzqa0wLtRA
 0rEUGJGEneXPV1PyNLnaW5gBiaV8irdc3OQ+KXgbgeFgNwozj2PveCHTCb6ur+R1H+J+mSpek
 EK7a7OftfM+pLriGH+79UV/zabwBctMdRGN7rfxHbtslrTAVo1A0aDLtvBQaV3HcPQl4/zD8r
 HAuHdXkz/+Tjt5yyru3S/8TNWvyXFkPqm97/AFRgJRZEKPuHwACpsz7DdjhAlZcc13HvucL+3
 /jJ3rDoeFRleENgG3NjZ8N6q7272Xm8iaY5j1g3Dgk2uMMutENylZBCUPIwGakyFKShCXlkZ+
 FzQYi0btL60++D/El6v1XWxwTScMX4d0wQM2eghqSFxMKQTnZkTZ7Hjv3YbRBo8PngKhY5Iuo
 UNW+41Pm7laWRnn2LxaIdqav3WAzye4cglnzaXEEWD9Rx+0XDhuzeIjHjL4jbsptB/ablLbJd
 pajqLZda3xqmK0SS0xyenh1oBjNlPWpEQkATs8ZvEcJ9hXrFgAJSduj3XHddvXVdIyezwJKg5
 1qmSNFwHSofEWeYLKroLIQc2oZq/ako2EGQcYR/6J7PLw9QAhYmqpfjV+dtgc9VWayaLl5Os6
 BGllTVrkEgujg6evFUR3Ho0LrP0Go5yMAdeieH+b0lVWO6+8RMXznEfW5harRwJqg1cAxvMJ6
 OSAONhwABt5DacwYswrpwwStcNKj3ZoSnnlibZvBhK6S8woNtA3YEm0KVdu+x49/vehwTbLQA
 AX/VwKDD3zJyb+IRuCq+tDmKlluJmmGojqBcyZLPIiKxfuUDw2n5KtvvMjKPjiizYMEuu/VYn
 SXcJFA/ZDT8IRHpqZ+Aq74ndr2Dv1y/nYEj9Yn5RuLcN+wHAoXZhCMWGsRqhzWV4HAebvQyb8
 fGVrvR/pKJmcO7yRxNCWgTTPW/0UUWsNFEpLSta4pTEnRVuz7J/22AYMcdqNMtVn4AhHNyKIC
 UzQni3WnuE+indzno8TGPqPqqSJDm+Vy3ANOWCF+dvtk45w3eoJ7itedzk+waKa1xN9bj1aDE
 pCwFu6a2/O15icn9LIb3yFogIHJboJgq+INu/ko+E/K2lC0Z3hz1cPDU5uPdHNW/wqZHWwcb8
 AgLw14LtWLwHjX6zhU5FqaJGiW+CkpIXCQErYKOMZp8cMJHOBaoT/sZqBirVwV8ohI8IatHh0
 ONHUm9I8v9AnPWFeWlnixTxgtnmTQ2I5kC2UGXW1CoFIoMydfCrlmsKU1wvU2wuCxBsonC6pu
 zSe2cF/o+tdFf/CjL1HAIy8T9i6FxTTWr2Qy3iofdoq9P3+ydJGTmvxWTO/vyJns/1PGktDJw
 B0WOQZNa7UfkL+A6nHwsTRG/CUny7zxPxyEWiQfslfULz0CO/Gtpedfd2IGq7fIA5Zx96ysXe
 +tGt9LVYG1dekxLkWy2TUGJcr14rrvzTyQa5ib9rB3vTDMreMpf4mMDspCYj4XzUQ48MxdpNP
 VsCvkyH2EzYZOQb5UKGWlQRn+wjg8PpcTW1pA4copKYzXP5clngWWjICQzgfvMZvsEHtC+hvu
 T2ge4nxElGLahIv6fNRR2TTiRRuzj2J9eoBWXzJtwD873voIpz9yWcOiM8Z9+f2JPzQAc8zQM
 ZNgrsH5A52POgYh0Ww8aBFPgrQouBcrvclinbKS9jwr3NkoTdGetC/Qr99Rpx7Rx4MfVHJ9lX
 jrwAtouicRFzRfK/C+9mERbNiPPpZXWJGT6bloe7HcIVpozO9hrzfAxdtCJPv762nVWffR6zx
 lHyj1kiuUjoubi+SpqEmYQkbg5LS/XESICCSvRTjjw90Elv1h8KwueidXHVNnV11INsiqlc+x
 ZQ1az1vy04snpWqjMZGas0xF9g35UKqnq96Xa6C+A54zJ7u3YRkAC92Ht/cWRHBPpX6D9/mRn
 qp7FqOEJ2PeaXxM4s8DUX175ZxfZWyCY2Z0H+GabvtEgRW+jsb4Hbkudn9pAbvJrL8F0M4OBk
 20D0KKvt67cdTa32SDoUeeFI5pSRaDg9nkJqq/DXszRU3adcCphT43IjuXZiTNoZEfPK8dRkt
 vVzARKr/SlHQ2RSsusKZGh1JDTlzKkN4D3461rvPCBccrtCEi76aZX0elYtSSfWXG1OSmI/Fu
 7QlQ6DgoCqCDvjeG74kU93J4L2w0gU57wZB+bZ9N6ID6WsKfuMmjupXJV2V2w7ukV/6yK17lq
 kYtitBuoyvAf7R2TRxzM7tzleMDFZk3vzD4qwb8D+3Zc+DAKVVS0jbKIxBDhDRoDGL+F/VxRh
 tMvDViy6PCFIXiumzYVhjSQf5/hnPD/KGAsuFp/s3mQHIwaNgBlhrIM6k7wo1dVOI2J2hJpq7
 IIUU6K4COBEhYFFB9S7laDgJbKnHTLu+41C66Pt2tpwyZqBj1/kIwDdiJApPHF5PGbIcPCIwJ
 /sFKQnm8khNRGHjDrg/hj7aNZAi0gwt08iccJxRBVMbdCBlyTi24EUBiDNv+oaZaMOmXxobjq
 IpFMadR3mX5LbHTxLc1puAtbao4zVbsWnYP8kjZB9hlnJ+R7DgF+bWoM1pphWhl7E36aUt/pr
 /LVkrqAT2G+8I9ZqhhgHMC3HtKO5VQDz+UvgpLkyyYTIbeY+9W8mPM7TbYq3fQ7HtUp1ACjwx
 isK2Mp8uHlHZdM4F4T+IDvhsjFy+HPKfuaGXfrn1i1LpXl/ctODFkaApEzV7VxVVLC4PwpiXp
 Byj480ku1UJcz9ND9bbkpboUJr5AflbXUO0jd/qVlQGHMPBkobZPrJ0IDUOkjgru/P0r4RS73
 O5bsKFWDLoeUNPc3MTGyU/VBj+djxfbRIq50rOA2LwlR21+mbXyU3SvPQkoH7y60/KXaCuqIr
 NjeqlZmvU0CmP8fasfoPdWvphKRixBOftkqZUmoLuYqiLBSHgXkOdmUoPOR2PWT/UiqBh4/8S
 1ECoakOKS2BzFn3PSgSbiRRoESkP1xz3fW7JkzyWsO9MKOwf8j3obF+AYOkA+QJG2v6HzhiXd
 jN69VPkxSJxQEFVV4X62hzudLbK+YWpC6+NnBnS35+UCaFNaV6fSbqW54z8oYSU49ttRSlk4p
 xigxc0Xj6IoHvslFgnGcoIyTAAivpBl81K/QnleNgP55qEkAWkKfAGQy7i5zG+Q8AgMKMP9yW
 BAYVQwcFnFwI1Pg1GnU9181hsmlKjp2yYIEfVQyfiu/SrQoNhuXz1aW4wl/v8wDVg5fZFZOfE
 60ilx6aYned71O233qjwLLsdFr8FvwAs/sIW7u84kdNo+5yDCUiO5bDpjt77tBqysmosU0UFK
 sB8LsXRLHUZ32RkUsJQ28qASpfIei7lUmUcTAemK6O5vf2hh3zaAmLVMmd/V1D3JIDkGtOpfJ
 +Vjz0G8GHERqVfLATh+WAqR/TzZVd9rinew/a63QDibzdXzMwmNZ8v7cHjPAm3rPg0HtxDl08
 hEqEqb8nvRRdv+BHyvxn/JJhLhkHvg/+KgWNeTkpt2EwmMkrQnrA/wkmuqiB72VjCqKIpykfn
 aXEeSJVHH0MTi3HXNyfpPXBC00KKTeunxPjpVmEjMw1efC2oRxpK62yT3yiJ5ZPCvR5KYyrb8
 CGd9yqwg/PBzj2rwjmoxk1UAI1RFZclCC36xv4FtgoRrxOQ2Vl1NcKUV0MYPVGO38RMSALaRW
 udDSWFal29OaF1PBiOymA/99FLUpXqR4x8qfeVAJiwZGCS30vyfsWtTd1jpxDHXnJPWQduY4I
 QsjyHCqMneAdNgrARYP7yzK4vMjRxEp240aiZ+AnQMcOKyKALnrEiMuxAM97eEi6HKMkpSc5G
 Fuq8UAoX9fGyjKg6cG3wM0mt9MBGxmPW/lDbP7Th3u8EgogwGVp0wsZtQdEGcJmxlMNO3fCSQ
 SsTxg4Eeh50fSR7rlySNGMO/buUK2ynCbzAe7Sg6v7qVVowLkskaBoO59cDH6M856FznIrxUD
 57a2JmwYeIzVUcaS2hj1oPIIbyz8Mdp/cXMJj2XXN1kYntVlLY7q38F4uM+cDbuMA8OII983d
 ERQst3+3So+1Im1yGvqKE5KlBVtg2XnCa53No6FYjq85YZCvxQbbGom0aOtvfnwwGAabkQsJZ
 81HQM5gBScrQabh3cjIR+Zub5pc0t/nwykCDlAyzTWYkRxTV0dQku2diYQ8bEfB0D3yiWyoCv
 CWHPWlfXI/83Y/cUaZ1SkSY1jKcx/SX1gq2gNVSXjbl5XB0hzidkxHNEw52STdT4Dbljije8i
 F8PXfeXTImEB82AtF05HXkOIGXuCvlCmOrMPYsERomrEZqKeR5OLjyUn36alKPIFaPUsDhy+1
 SZLB+vHeA3C9FfNhZxAyqHMZliZoKNzEiOak15mzWN9hv4RDAQZQltVXsUhStNF4eOSe1FGrs
 SRqQVn7tdIcK8yDdXp8rgmzdzJI24+mQysO8Pfu/pRaca5WEae4QIRJghAxR431OEBdufrT3t
 sos5RSjBYUacUEHkK5Xee4nJk358RYMi+DzydGCphhi6NoGnLfJlEuSb9jGTwUvQboCddF6oU
 LVIRxTbsg0hY1H9nKXx808dNiIR16XertvYOB/bm/bsbMrOzcFJBR5/3lyLpB/QpT5wahia8K
 vJ/IvPiriRDztX6zf66s8yriXurYCd6PYFHK37WSFUFXfiN0IS+De8J+4VtKlVuauXxXSe6X6
 rmf3ExsH0BzKm1G7sZvwbM/x9w8IOynL8b8NRaUBTthXbsCaMtOxsN9mZmKJnnjGr5aHhb3iz
 cN0OyyYExcqs1vKIgtYefKzPD+NDX9WWqfNj6zRp
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/5/26 18:40, Andreas Kemnade wrote:
> Strace in qemu:
> 198005 openat(AT_FDCWD,"/lib/arm-linux-gnueabihf/libselinux.so.1",O_RDON=
LY|O_LARGEFILE|O_CLOEXEC) =3D 3
> 198005 read(3,0x40802570,512) =3D 512
> 198005 statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,ST=
ATX_BASIC_STATS,0x408022a8) =3D 0
> 198005 mmap2(NULL,269428,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRI=
TE,-1,0) =3D 0x40868000
> 198005 mmap2(0x40870000,203892,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYW=
RITE|MAP_FIXED,3,0) =3D 0x40870000
> 198005 munmap(0x40868000,32768) =3D 0
> 198005 munmap(0x408a2000,31860) =3D 0
> 198005 mprotect(0x40890000,61440,PROT_NONE) =3D 0
> 198005 mmap2(0x4089f000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWR=
ITE|MAP_FIXED,3,0x1f) =3D -1 errno=3D14 (Bad address)
>=20
> strace outside qemu:
> [pid 195331] readlinkat(AT_FDCWD, "/usr/lib", 0x7fffd1a7fd00, 1023) =3D =
-1 EINVAL (Invalid argument)
> [pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf", 0x7fff=
d1a7fd00, 1023) =3D -1 EINVAL (Invalid argument)
> [pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf/libselin=
ux.so.1", 0x7fffd1a7fd00, 1023) =3D -1 EINVAL (Invalid argument)
> [pid 195331] faccessat(AT_FDCWD, "/usr/gnemul/qemu-arm/lib/arm-linux-gnu=
eabihf/libselinux.so.1", F_OK) =3D -1 ENOENT (No such file or directory)
> [pid 195331] openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libselinux.so.1"=
, O_RDONLY|O_CLOEXEC) =3D 3
> [pid 195331] read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\0\0=
\0\0004\0\0\0"..., 512) =3D 512
> [pid 195331] statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY=
_PATH, STATX_BASIC_STATS, {stx_mask=3DSTATX_ALL|STATX_MNT_ID|STATX_SUBVOL,=
 stx_attributes=3D0, stx_mode=3DS_IFREG|0644, stx_size=3D132612, ...}) =3D=
 0
> [pid 195331] mmap(0x408a8000, 16384, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MA=
P_ANONYMOUS|MAP_DENYWRITE, -1, 0) =3D 0x408a8000
> [pid 195331] mprotect(0x408a8000, 16384, PROT_WRITE) =3D 0
> [pid 195331] mprotect(0x408a8000, 16384, PROT_NONE) =3D 0
> [pid 195331] mmap(0x40868000, 262144, PROT_NONE, MAP_PRIVATE|MAP_FIXED|M=
AP_ANONYMOUS|MAP_DENYWRITE, -1, 0) =3D 0x40868000
> [pid 195331] mprotect(0x408a0000, 16384, PROT_WRITE) =3D 0
> [pid 195331] pread64(3, "", 8192, 196608) =3D 0
> [pid 195331] mprotect(0x408a0000, 16384, PROT_READ) =3D 0
> [pid 195331] mmap(0x40870000, 196608, PROT_READ, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0) =3D 0x40870000
> [pid 195331] mmap(0x40868000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MA=
P_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x40868000
> [pid 195331] mmap(0x408a4000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MA=
P_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x408a4000
> [pid 195331] mprotect(0x4089c000, 16384, PROT_READ) =3D 0
> [pid 195331] mprotect(0x40890000, 49152, PROT_NONE) =3D 0
> [pid 195331] mprotect(0x4089c000, 16384, PROT_WRITE) =3D 0
> [pid 195331] pread64(3, 0x4089f000, 4096, 126976) =3D -1 EFAULT (Bad add=
ress)
>=20
> That makes simple commands like ls --version to fail.
> Tested was arm32 on a arm64 only host.
>=20
> Fix that issue by truncating file mapping and replacing out-of-file
> mappings by anonymous mappings.

Could you please explain "the issue" and not just referring to the strace?
It's not that easy to see the problem.

Thanks!
Helge

Btw: you patch might fix this problem, but you may run into other problems=
 too,
see e.g.: https://gitlab.com/qemu-project/qemu/-/work_items/3410


> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   linux-user/mmap.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>=20
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 423c77856a..4fce6fae3c 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -796,6 +796,32 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ul=
ong len,
>       bool misaligned_offset =3D false;
>       size_t host_len;
>  =20
> +    if (!(flags & MAP_ANONYMOUS)) {
> +        struct stat sb;
> +
> +        if (fstat(fd, &sb) =3D=3D -1) {
> +            return -1;
> +        }
> +        if (offset >=3D sb.st_size) {
> +            /*
> +             * The entire map is beyond the end of the file.
> +             * Transform it to an anonymous mapping.
> +             */
> +            flags |=3D MAP_ANONYMOUS;
> +            fd =3D -1;
> +            offset =3D 0;
> +        } else if (offset + len > sb.st_size) {
> +            /*
> +             * A portion of the map is beyond the end of the file.
> +             * Truncate the file portion of the allocation.
> +             */
> +            len =3D sb.st_size - offset;
> +            len =3D len + host_page_size - 1;
> +            len /=3D host_page_size;
> +            len *=3D host_page_size;
> +        }
> +    }
> +
>       if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>           want_p =3D g2h_untagged(start);
>       }


