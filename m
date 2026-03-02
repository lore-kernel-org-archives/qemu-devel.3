Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8DBE9B36A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gz-00058X-4P; Mon, 02 Mar 2026 06:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gw-00057L-29
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:44:02 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gu-0005ky-Hh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451826; x=1773056626; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=n/OHgaqTbbtWrt9BT8WReEijrv67WOARNlXVFa+ABbakTF1+sbmjOEBN1YSn1L02
 lAjuCaON+v138oQ4U8iT5EoFC+cAmQV8Wh7jxomWeJGOOmaYnM09Gbz0yJJ7iZWcL
 EqwXLP0oVcGTM8gRWc/74LOSDhZqxe/1Q09GO6pRgisB0nqi4CwdadvMUL3XW5X7I
 F3E88Y/F09vF/GkzKv67d1voEKGhRl/7Xoqk4skmcPtjTo0IPgiwOA0es646wwJmH
 ZXsNJIQ0ofAGm7oIjCGH9FaVhwYy0gfE7D/0slogZNZGXkkRir4jHBDyrQnk+Vme/
 uvUbp99iq17CS8lUuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9rM-1wCrRA0J0k-00TgQa; Mon, 02
 Mar 2026 12:43:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 09/21] Call colo_release_ram_cache() after multifd threads
 terminate
Date: Mon,  2 Mar 2026 12:43:39 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-9-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TsiDljhhIO1/nXoIUalW1egzgZro8Zcfvc
 +O3subRuDCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WD/DD/9XI9mFXv61D/SBPpQx8t5Tjstk+l5sIdIbc7fDBjIMtdMhid+ew+t7BVeVpZQ/bIk9NZs
 OM23YVEiWcv7tj9V28Zbd69DGsMj57iAUfCm2K+NK/IMMCilr3oCKAGeUZ7PQzFphhJPi2CNYN0
 SfMl4IQZVug+TkuU/hF5sWcpcXXNL6KWfWDScuX3osvJ6dG1jPm8pguodxtynVb2Tr9/K4qPg+h
 3QsT9BWdYiWkgi3726RWhJE5quT+AWSTjAc4zaRIKEaRd81sQZ79x+gj1lMmcgc4LJ78wQJohU+
 czsixIkVRJM9/e8OVXRizQChiRYF71GTVzqPjnldOGx/DE9G9RtvPIS4ybrsrU5zLDGk4hmdsCp
 Vt1lE1M9LrT8+CLlEav0Olc8pMQ+4ErRKjpha79wLs7A2R4aYUJgze4bPYvBTOjbbG2Oveu9RFP
 WIqV024CNFx6JLSf3Vu61IVLM+sZf/jEDO1lhFJ05aanPHCTqST60fK+Em0d50xgkg+pvUs6C62
 I5p5YdPHwrUdNkDMhuusExE8Hz8o5FziQN6nCtjLr36GYIQyuQ3NcAZD1IHKR+BJdjQZSnfB3D2
 K+He8GUcEtR/xkDFpfgoafyqCWSSJx2eGpbw8y1KiFPpdQB2HgIq4BA65K8crneS4sVlvmc0JNs
 aapC/28Yju1PGtA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/AfVtt8L25VnVix5QmrLn2/MXTwhfjwMatadO4iH48ZsK0mtb5v
 pWy1ddkmdRArSwEmcrvp/fxwjgmPBg/gkA5LJMm+5NUxH5qqjFvmEmAzqJTcyBuNxicOmec
 PZWDVtNEYh0fsVG/LPPft6zaBI47wXNn9XenbSDihZJaIcJTX8hGYbM1ir+WvoXlEGI0DFB
 H121fzno6ML9cjd8g8taQ==
UI-OutboundReport: notjunk:1;M01:P0:qo3rmqE9KNg=;WNa7XHT/MeE0p/3uCR36N+UHUTs
 zTiH7/wr2u2ZFS5DX2k7qO5x09aRerexKTjYo3E75IUmmaZyEppBZZ+JecShTJJZKJMxlN0mx
 DKuL+WS4s3ZIgKlvj7yloiznu6FVr65fk38RSlsNQlPBtymY0FD0NfY8dn3t6o4U6WP8mDh6T
 hggI0TyZ3sfX3FY8uzSmk7iUHiGAtP2mziN77LItzX0/Xa5wEcz6+UaGj7K2f7YLZDI8+fV3j
 /8OGnMKieaBFm0PLys7qMVYt65GySGPortotptJ9Qu5/ai9W8Z9GTE5yFLv8aUlWQVKUZZV2b
 NLVPnsfPy1mD4LdgbOPML2x8b8FiQFKQdGnw6TMWZvzDINBjC3m73aB8C6l+oK4W7iGrVQ+Fj
 yI4RK7EL1tsyXqxn0p+yxKx6mWRElqDGbM3i6vCR8oMKA9XP1CaroY3LAl8uAYBx+W2Lv33E5
 GjVQM5aw1malv3kTUtfTp/2v3q3reZu8cBm3EJSmaYTh/5EVVJG/sjFr1yMVaPkzqbyeR6JsX
 tq44ApPke5bu/eb7UBd/AtIUKFj22uwzeloY6tvwvscVMHm7UZ7rIxodlzKkd5+KhtMmAKqr/
 f22lPK1QV1irobzgkuaPCVjIKQPxpJrrppCFdgI7CTtHRec4/1D50pWbqrl87MVy4BPVktrzF
 aQa5NBn6I/cyQ+s0P6dikaWmje4NAF81e6DY5+5s2N27ZeexaO2h6LNuxZ/LJceLvt4xGhK+q
 sKUqS9b4/iLO1KfgAzQMqnc3SEBr+lsFr5y8PG5Mk1zccCw9W+K9dByx7OzF9In668sDISoQb
 rsYwMrJjJRqnE/sInUASgjLiqPpuxqJiccPVhTwJF2irn6y8ZO1WmJfcq9BCS73UjVUomybfc
 cR8CNEvT5QH+8+JHr5HpawMobbVPSjBPYT508b/xCnw6UpSyAYWFfpNaDPiCslQSgX9njqnHX
 H7AYZhR+b/Fg3Fvmr0+YG3SkQ8pjJUr+Y3i00LcEt0ZAPeniDw5jxTDhWFQrgZb7iQ6YPoq12
 oqGIhBmLVG8fWqiq6luVjvAcJtWfphaZSuJFe9s/saLfg+fmwKY0sCvmQPqWXk7QzmHqBaTTx
 Ypm0QlVAW5NtNklNftoFZI8QVEQat5wkIuUM3bvIZUlJ2vE3o1Xd6RWylspGc857i2k42NjIj
 YbfLzo67YlHRo7ByK2A6Aj4Mg6zJGJ/AFcYE3ylJUOdJ85OhMX3CWqbnQEdRJKufr5LZpS4+M
 zqIwRRoJPQ8OSia7B+bxy44H396dM2ZYFJfKqDjT0pNaaxnEOcejr5OVoa6xDJTRkoWZCgFtk
 /PEE6FhvUnpgpUCvIFnPKXJvvLsmaJTS35JDmu8YJFyl+YlZbvijnB8QnS+mVx4jhQCNYEOKs
 dDSHI73siyA6viPk6IEr37mCTUvevQc1f6duzGeCzPBMsGAUU/S5ZcdC6NmJq11CM0FZx675D
 Iq+lUAMGToFaWWQ5vhg8boOVariuvGgHffAsq0TPzHwLbTgAGc2mwZ/LveXSqrQTCXcgekmLf
 Kw27beMsjdzChPBEl6NuDAGhOlcnBJj3EKOmoeqhuXKDzcGS4HFDoefLEsIPRchgtomqHqPPJ
 a6UJYnDhS2lumGwmvbRJfgdJyzbAbbRSqPTEBZJ3QbDIcV8sU8aN9v6StHal4oJdCkCPw9hzc
 rGkaOUis1bs5jinyNm/iQ5KT3gCxnxODs0i1PsRcUe+Esg7yeKRpk4C/HfleYmmXJDepbifyh
 aaUujYzZduZ5oe+0IWGVWe/hmaa9lurVkS+nF2fqMQqF2J6NNPZErwJdL7pfgPVXlBLMVQINW
 ATKXqMbj+64P5LwuHuF2VbX1vwiEAYK5U7wDr1okfkYXX3ClloeqzImWAIEWEYXDBsf3jUnls
 KUpaaMaR3EsGo46RVGiR9Rd/UxXFECsPtg82IPyH3Ll7AXcIo7v0bT6jlaZzi7NNkaZmJqkRI
 TnJPA6dQfD7RpyssmqgJX9pLR7kOg90xsn4KHi9vrPthL9z2hOiSp3MW95xNHglx2Q7Bf7yBl
 Rb+MuxCV2J5CE/ZsoUCnVy9mWI8GWatHOMCdSGZDMQ6kRSihMs+ffMpYguIYm5BDhsXfGw9W0
 8kEu90xw4jUnIIJrSwAZbMEEdtR6HnHNcKKRjetdAezu2NN/YBd0yiIjvr9bBONdDB164adj2
 UxiT3QCkI8au5dcClgA95gSgZJVAJa8ITF+8hC7mJjOKfTvYkgUHQFmxswimfhsKfQr2Mj792
 EhYDslygnL4Ob9KsIUmzVtudDgx7Q4YHfN2N0IGVOL89tflFEsXK4lInn2fK+we9EKi8ltTeP
 +SUsof9VkG5r8u7X3lH1nYdbUr8R30gDRMYui2e1F5cikvwRl8H+zCaQyDTIkXIyUIWuh6Qto
 sjBAT3KieUY+pSDTr0paA5QR6MboiWL+g+UAsJXP/mqBrr5mmynC3ZA5c4Ll6BiwMuhikNiC8
 KLbwm88APM3k+nXON+7IiVkMQBNFsPZA+LeursYM3gpuWVpppWMNcRNLsG2BaqBCLVIvQC0kn
 ee8dTez7sdLtZKug5R8KXfv7wEuhwSSGxLDQM6X9Bo8RhqqjmIfmOuM8C/hjvSBot8zQeEoxQ
 w5/CXwGw2gH4tUusOWxkwLd0H+pADMrSehXWUtBQIwaARfiGi7hh3N8haXRdjx1bdH9hpjbsJ
 7vSyUvxMjBLs6JNENqo5qpMEkKF3x8i5WOJIUFdX3QSCKuFHq7k7C6RLlUnrLKUQWd/6bGorU
 YsM5HiXEW5JXqg17Uk7abeAmLETtoqBaajxNJuJ4ee9ryjV34HwJF0N6361wftNl+cDUC15Zo
 2hhdEf0R7QJe0I2MtFO2eHRfA1n6vPeEH8JObG6SzO3zK14EBsbK97/uTEf2bpT6XWNDVAKgK
 EPRrc2L8ibwOeUjTGaBIsD5GGSceI+SRIh8pg0gThCsXJ+lJf6UK8ZmuX+xWMcCV+N0JrhwPr
 ZSJqYDjKMhIBc+B8b0CGo2yuIen4nKzRt83AabW06Lrz6t9wdjAxrUGXnBexjFFv3/wJQzd4W
 Iv41U7brBXCw6e8bfKmd3Clauvefnd/y697MiLx8/V+GyvGFbBU34XCoD2ojjJCKrh1EsA/6k
 R3I8RIpA3Eg6U6soDPsvVgafdAUl5zkQ5sfHRtM+GNv3y+ZD4fjSf5/8StMyzS/9y2e4fhhwU
 le6sqfa36jAPT4/cJXZNNxIduDoMUf3YtTToeA0J+WvP9RE6fFyVKTYRbpquKgDCD2wZ7YqrP
 OIoM5YDJ+JS2nKQKMcBvhQG2tYj/B36k1lgNb2uwrZIZ/6fw4BMCOsRcalOS/ybQU1e/PlKcZ
 A8+0tNCsU55s8qD4W7U/nt50wonsiV8J0QdSuUHQxCQRA9BB8iJnSEGgzmNy4tJwz4V3Krajz
 tDDcw/PPr9W/UFr/hXep2LMA+quFiKkl+ogBr/HC2Yadg53ckFi4qz8iNTC5kDH0Rea9beYCI
 B2bOIJk9NEWmeHJ+FKv2W7pLXUae4gK5TaTDybHtUBRzHmM48cnNMLHMPUGBmUtBN/OA97ojs
 L49ST+xY6GRWNckghH5xblVcMXpdo9IU2gOc81AQb2tlW6dN/ZZxakChfl1rp+horE9qOscKL
 zq9mStVItkPUTS1LIHf4D5i+8U2sH9qvdUmaTOmkZAkkH9YTC8kaPfnrHk3QQ0nxKlCbOh8Nf
 tdeaMqR+65BiAqrOYd6WmP2KzEC3FLZTB1ib9LODQs657DNSsEFt/MiG8z2fCyw6V/Nixcd7X
 c67B+aeN6tb6Sb7spTIqLVkkr4F474J/TWHWup4983oJbXDFh4sVtVjaTJKYW73tWfFDjuGps
 Xb0HH00u2A5vCTMcMJCerWPU3G1+OEAqWHTvNjxQKIhky2i/NtMcWgTs6hv+TM19u6+FXF7R7
 RLiPEUn6C/aMwVWX+X8j8UZ4MMd1PaJnIigeU6QY1IzUtosVgMac+izQQJtuVNd2etYeeagUn
 TpErGd9j0ShIqXf8p+ijugW2FNPTKhufEEVZBqSP+7NKeQN4Ux7Wr6RTyOFd1OA39VxjBCzXI
 SpGfIwVqcvrwW6tJbgQJyS1jYh5E+qtEIOT6As4Eh0u1iayM8FXX61jHX8BKk7ySC6sTk8xps
 s9DptGPW1sDyKBPj5cLCRXZ8EphH+EP35KgqWlCB9CcuBPeMHihHHEdNxydANdtf5GeY2+o8n
 b4ldD2wP6hFXsbERAxCdI+SMyrw5LnyzagtJ/7IUKCigidfUrQLV7mS1gcxN1Y2LyM9ONCmOp
 52gmTeetKLfjRR0zGKoRSyBzMINUYYQ0bRHyjUvge8aFfi4iQdGe6B3Piv4yYz1wTrlvaZD/1
 qDn8J/qtu7jfeocA7imh8MmrM7uOgx60eet8/tUXzANEeDqjNCMOM1Ixa1Bkt30mjVdvYqg0K
 YrI1VjvqhL7Z8OkM8vwwJNvKzBakZGbnbWf04n9k/liHXX2rR/NkodLexQgMh3A/u3c0Q2/+o
 m07AY52jJhbIxqHQnYxnyfw/lhwMbhQ4MBrXppOx6Vzi5nws38bcAojK8vWHqlXUR2EfFx/mI
 9Rozi6J3kWBcDz+bGaKz8NTS+WBK1zPuN3K6cL7yidmFot89F6ciTY+AQ/3z6RacrhOKBPcfo
 IVNFE/kC+vpmn6sCdZbG6oYTqvNak0PyNWYsPqh7k80T5xw4NmoEa/yH66ShiciXYvQo76GW8
 kCHP0Ww4RxQfpiBUHdCszuA7Bzyn7QaHUMeuFAxly3kVql1ov8wPOY2mqmBQMnex5XGfko4uk
 orrmpo1LVmtnVTBXFLDf9QofcYccX+fngF+lEq6CQ0c6dhjaRolJS7UgEOByUd1Kz6BsHuaH2
 K//NSesWx0hOfAm5DfUtZ5CDf0hD8jUYc8TrcNhEM1XhIO1jKrMAo37GrmpWNEPNZsBKLMW5N
 +DPK4wcAtoLxPMnlcRq9HKZTI/2ly+17/MHemv4fkYDvYK5aVofuzLtmjwP41BVkI6VYCPrsB
 tCq5GteGEWC1jXTkg+B+oBUF1pgH2BmHqouVXFfIlvhmLEFn2SRgsEJb6rnKHpuAAV280Gg+5
 3guRnb6yz3V6WJM0maHTbso/bBW7bW00Zo9v8ZcdHZ5ZIQnyy2vj9BLCIQrpLtBQyoCJeXj5d
 Qp8YzoXiz9WJ+QwC/W2wsocce/7ii3pFsogc41ByfM1duVmqtPa/dTEOWw/HYJfBG92loZ685
 yTGFp/ggdINEDLsQovQPFfGZcOGJ6JPJwarJNCOx0t0nS2Fm4Gw==
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 97a224c39c49ff2269f375db47112458cab0b4cb..96102c9d0fb3b60e063c81ce07=
b730011bc4919f 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -949,7 +949,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index dba5d6ede579da42693d5270ede9660fb145238a..f36d42ef657bdf26d78ca642d7=
7a9b76e1c0c174 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


