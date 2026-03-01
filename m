Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0762EFD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU4-00047P-Dk; Sun, 01 Mar 2026 16:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU3-00046n-Gs
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU1-00042D-6u
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401062; x=1773005862; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sb1/DeNRRgi9/ZvGzGXbevRQ8uWYeL4x/uFoGUKbad9qqDUXqvt7KIJzgNItJIfp
 Ek1eR0PYcbqlyLwtOUPnXoanVgrIuOk+rsw1Yt0utB12JVBGUyj2Jti4QImrU4GkJ
 BSDjO5dq4Ndr+P+NJu+CJ9KLUSqL78Vb1S0qhQZvY49ZtkLdr5ynDRtEktTNuLyqL
 kBuEHEf8Zi6yNAoBBZncdq8EM6vmelg/0Gn7iLxOWvwjuNXsE/l5Uvg54MqARRNRt
 w+SmoDy7nUiFTWwx7dChc7MJ3iqDw24ImFO/T1TiC0FDAqshwukcjSdyN6jXTNhMA
 JIMR2Sdl6FgV/W27yQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MadzU-1vQEox3oio-00gcuQ; Sun, 01
 Mar 2026 22:37:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:23 +0100
Subject: [PATCH v11 03/21] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-3-14c8a70c36df@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=bZqP64D7rElL++ZH8EUI9LK8uvlG56Ai3ztis+On3P4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhHyjsTYNNx1UOekG52HnOKtrjKmdJnKtKu
 c6Go0yoHFCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WLoqEACTvK0ysUfFTaZ45OQ8wxzy4H0o+EOP8GiwEUdVrjFJaxMqA4k/QAkF597Ecv2Z5vC24h3
 cTlSWAUpHkhE/N96afxmi7FWzq0mASNJiQAS9uJYACpgwLmb8aK4R3fJpK/C+UITWQi8pDKUdeX
 1vhmyN0YZd1B6Va3YRuqQZqBkSp1zVJ9Eo1hmtNUASx5dlCauP7bJ2Eh7V0dnSXbLBuPWROpqO6
 yIjXa+8gJVeJl863OwZOR4ZoTepj1uNvtKCDr+0MFCQLuqyPu8APAcCEpH3dHoi+q36HYoBUHyQ
 PbWH6HQqdpECSmIPJI6yV60Ev+8jG8AZKOicKRR5Grf7CEy1q9JWkaH7cVVqe1nr3aXuoZy2REz
 oOqHAeLcL7RLDTnH+YnAYC138BbshcO2S7vs2OdJyVFPg3QtuuzzDqQ8mZbTGfvLMaNnBpueZ9+
 TO5kvqL6SI3uRHXKQuWtFhEmAVs4BtPgKu8ZuxVfZ4XKge6Gj7WWuXkkqlKUlNa1so4UJS4/f98
 HgNVvccVV+6fkoetXO2awDrmaRY6IgaBDG5fydgc1GAKQbqDZOq0dXf5J4QirB3yaCSLQ8y0Jqx
 7gEVE+PYOI51Hfs0gsVC6vUFEk6YE8Aesm+wU0tv7RzVJo+93jq5zyoH1kBWbWp/W49qvLH/w6k
 NLW3NhueVgvjz4A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:RQFqQu7F80UoOZMP896sdxYI98SSmefFbtO3rPZ1tr+VY9tmP0f
 29UJjIxqM1n64a1etMaFtgtLRcf2oQozXcj8Wu1Qai/s2hL1iXUZk0/1b64e+D0Rs8/2Kla
 dXF3eivsE8AzARqyFXsK19Lm6LtvIvpS0WDrdNkpi2N7U1UhQr9Uxt+KHEXxHLW7GbPaki1
 aAyqpWVvOwZPESGC6Py8A==
UI-OutboundReport: notjunk:1;M01:P0:hZUU1hT6PLU=;0tFjj5FBRRNtqi4bkPDG1lug94d
 DBXnbsa/lJtogb3PNHIxD0lMaGMAgYirbuiynvQNV3k2XYIswQKOUlg3FMvpiEf/beF81hLPE
 ZEHEqNcRMOUf+YQZBCtaPIyhlaz+HsiiX65E8uYLZ5LfjN/MjU1cyETco+xeQcbHIlKEWr3Zb
 UNUvv6GGMcmtLIf3af2Evbjl/Sxq/pDjk9RL+vwhjf04KRx2A+86IqIy/rKf/I1JneEk7G6bl
 YQgw/sEQ4do4+iq7XVsEi+c/pn/EY6YZs27619Ebki89iZlZjADBS/ihM5qn/YjRcq4NbK+Xc
 MTN1YPI4Pv003Ge7MjPuzfcEJTi4QKYQCNqmxpCSOyXDuw1zpEX2ksp4m1UiVUbIOwEBNWizf
 YMWERIyw5bM+dTDRnkDw19fJth0xt9rB8UljH9031TAKbvv4qmJzW/gmlGYUeqx2gRzhMzj2s
 62J3L5FcJfobFARIweLit+NBOhm5w71tc9F0A/1fF9avnuIhhLKd5PDhHWk9/YZYeElkEWi20
 zqmj9jtoVEt2Pqu3h36bvtw0EKChAIp1BAb4cKNHZRvHszOjppkV1vm2ylIgXzkYPG3oXo4zk
 lGFfIp4z0kRb1NUyMdgiUooDMFaN6DBU76lOvZNhty/mjxqRUnqD45q01E8hIZTLbPgEyqUIa
 hQjI+rsiywjA7gKSSPHV0ARxjctjNydZ+hS1n8okQI8hi0YLzMFShfVk5ltiNdHEWsOByMJld
 8JNhJQ/xyEzG7QYlJX4n6AXHa6ewElP0srn2bfleEYr5Vo1NsVwir424n/tq3pCu3tqNYg2x3
 6R7PKUDq5xFSNA6U+9448CJBVmYkixmlf38v6Afh5C2FlJwaUUL7x2k+RVEU//S8DgcaoZnj8
 bpEV18dyUf9mPlORhzVUAAQ9+zp2Jout1eiF6vG52X87CAawPHVtzGUOBOPrENc4dgz1oZcQC
 jXwMLoDhUZCUPplyCn7yg57YHKrfeiIAIVyRAV1VYE1/4MSUuve4u+li8mr5ofXtHJK1Sznz8
 JSi5bFXNbuQ0cUOUs5NR7F3SHfXjU9/HU8omSJ1U5El45lDEAGDuf0BAazIgsnyk2+e0jQS06
 8Wz8CDSo2hnScerqUt0ZTVo16pbxSWYA57rUHNwhiDk6juFSMvOIfQv7PpF4tG3/6QC1rKK6+
 C+F1WIvWVGoO+musmnsgij0xFKaFPHam+4/5F+fSALoNkxRy1AU/JPcG7RS5ZQTQPqBqQgGOH
 yZ+Eo5BmIfGoee+zgF8ZMlN3nYv28dozDgVuMW2eDWzExlNzAGjEc9NY071Zg9AKBdj85NS2p
 8tWxGZoecrspczwKR+zfAlQWvr9wh1XktjMRuxn1M76YwPtncNy9uB09mnDXmTW4TQ6aiUDK1
 2XwCSNlLhjPzGh2GeSviCjv741DMl4N3ad/+UUBoYcFbwCnwiO1bA7ywMb9Gsmmjx3xEziOmy
 Vnfp9OY0i93zfpNjPxv88yOl8cGrO4EnP0GDYJgnQ0nu1UjCpGSb5Fo4VWD7pPrYFV5QmAIdn
 8gZLXNWCCr/xXSRMBAglCqDCIEIZviOvJFX7ayXr5zo1lvfwsid337RJ0GTMOlG3GaUa6XpB8
 jBiVhgOJRw9JfVnl2atap3FpaPyPSdhoe9HHB3T3XmZZmPqffFZnvwGEckA8GAhQPWAL3lznj
 tvp+txvpzbaJ0VnjQD4BJciIFhF3wp6GTDxBgcL2gVXwktuoSPf6/9KaelxQLANFFwEGfZlkh
 hsR/AMl/U9bxxySZKtFLwmj+TOmNNiNVV8qU0jrFMxvrCaIrE8ITD8EHYG2wZREhxkNyK8tz8
 UtFDG5YzpB3zRT+YLBIcH6qxBYnE4cT4PpZuSV4ODKMobQV4VfJsOR6TFey+CL1AnMDOLdytJ
 MF/RFJpKCcZ/v5ijIVsg3g3YG1QBSwLlOZcMwz5CbdoYxu/JOvARTFs17DGvMyBujAg24ogqD
 +a96+4zpkTHvJhV1tTu+WAIGilUeUwUSL6pVfbJJxP81ynSQb3u/Jz7DYCQsaxfxIHDC5uGPL
 yAJ9to9Hxpnmoa2z6FbsCdEZn8aV5qu0hd9+U+omG7BK7Eq9Xzz76zd/5ZAxk55eSZ7sB9rAV
 xG/qBfrK0Y7qzxqArn35lot70/P9fT9okuu3QDjBMFjKdRydE/IzCI7m0fKrkne2h6DyIX4kd
 ksPyVeGJTkmOfSdxYk9txDKnvdmBPZijhBspkDZA8PrKFRZDFzzwi0VctrMS61fFY3PyPhfdW
 l8vuQDfFqThF7rnCSGM2pjQrNBlEKXamQiJ6uLCUdfIfp0gU+QxuQu3Yb9k0LXw3ybJS5KAuX
 lG4/MofWSxvXs+thsauN/sy0xBwdpL3zPY6/3ypZwcaylfbMQn/xygCD2TsCUitd5Cv9yilC1
 5pwMB0teybyggxthWhnLVjHnk8EgPih+cGvX6QFmkQK2GdDmphA+YSZ7PrmFaibZPcXyj5lGx
 QrLfg7XKJqBnBZf0inXYSq3ic4usQUrdeL4xcrt48aKbq3Y3+L3wVNAqR0IxYnldHhy5dM50L
 9D8BfExDGzJcKGEnbz+umio/Hu3LB6igfpAvaurrVH4Ycunbzz2cZbpRkE9TNSPrDAnpHvMzT
 ro3H2Tsa3wCpPqD7XHa6XYQi4M+mr57BrXUNX+RlrznVQV+qLVXJ4uZz6SwfYnrQAS1KzZ6Sb
 b0VwSIlGcfNXC0TNAp1hDqqICPns/swgJQA61ycwpOOGER23u4DTJh1OQ9blmyrw9dqGqM4ph
 8rxStbJ9nunsNNg4nEejX5kiq397P8XNsVIzVYvWezXv6BCHEpbsTHbgH/8ISsVx8p5+pnPC7
 I8wDHa1dEtUa7QKbvV96qFg7uj0aAIzFup4CaFYTXiG/FHk3TE8epVFd/NPan9TalmObZwscv
 Ke/jtj+W05qUSiMij9+AA6mxkTb0zwiVGyDxbpEzyKKeDKocpZLAprKTqosEvdhVEJkdq2XBj
 iaz6W/ggZTPi34GMUJBwIyvikwxQqKEeEzlwsZaKLswXrolMNTIdbLNYEV5YQxaFfpDDKcuFl
 tMvDQc4zLKrZO0LhTn3mJySxSLiOSRwsqcqMaiktTbI5knDCWpwQGRLv2nKyqzGjnF16gTm/5
 2sRYBh19+OC+aaFnAQYHYMIzcZwMiO3qyGCgxLyn3XhAr5he3GnFgvICd8z1Hog0+4fTjyak8
 KYL/D8V3e97VCbix2yO1nX0KCaQ1dfvjnMohXkp5Fm/ZqvIQ34mmWcK/32RDFrdC4iyapdRI1
 2ctikJd85YVjWndIYv0hz6yiTzauYnVITmnmw25SpMlFmLiQeeYIJziO/+go20IhAP+N0+DZs
 CBerPqT3CFbUtDy5gVzgMRS2AiRgGjFdvEmG9xTtcbpK7uvAxT1lGtp7Z+6jcacxCnWAlamFz
 2icu+UWk9SR5owVhmv+YYvdiMvZltxPaPIf2PRtqNeiY7ufFeN9tOzwhZhQF4CvxCuB81vmFr
 3Ut4rNM0E2tvyJakUu0MbYBYw34+oKxViYBsGqYdjKdB3/QZucb8QpF++66HB9AoKQaekalA0
 4b/bcxHKgqOEgarNIK0EKU5WN3tLRaPljylwW8UAJeJDQsy8CJtgQPbPOguhRD5qI7q+pYeeM
 mscHpihmDp/EWFdq4bX6aUEmrqinDpWh1yUcMYa09oX8JsmFY6zizKTdMAF/HQiZLPUmYaG6j
 Kmm+KghW+cGMoSsZkS8tIrK6kopnBpdWy1S3lV+XuormlnLEI9W+NtKUx37ZLjLvliCqsdV6X
 jRLnH9tfRmBqZBvqKBhI2xcgK9zK7dqhUqwjfXBIj2AMcsPix49JEz5b0SAxwJrMKEriC9wDT
 zQCTO55Dh3EiUSRP/d6f3cDLLAILSJnv1IaxF+OHFzYfTZuXWMBsdxo/50i/LysaeHZBlyA3f
 rNgt8K+2A4r30bxA62MidWK2N6CTPyIHfStyzNH7Ox7rYdViFJTKG/S/zJm1A78dqvjNpdSYH
 WNgEda0xhJHWPhYnDHtPD6eJXlheRkZCWygNhZwFoYe9Y9hfpNJ5zKZl3nOMf16Moa+LIbhWq
 /GJawKyl7PuvLq5qYEaqBFj7g6skLfRMrvbpsQl0ppZH4jcGFM6+fGtOLtU3JMiXN745BX9n+
 vHW3sShz8iFqTb0tlcfqO2NKza9y9G74IFmpMThG10pnKVjqhJVP/ewL4bo3xo4hzJVcPwnKB
 yabC8IL6CHDkx8J1k4LuJlbF2lQHLOeusDbN9WAhW9SAumPiLB6FYkTRNXghBc9NCM5do4vTt
 j3yQjc7JhKYHJYF3X6Fygg5KoX0HE/4F+XieJEOQ29/qK0VzQvmcj/hWTQziNKQqU20imrbpr
 LlFwLHb37IkOGbpUGZ16AKX9rWw9Xi5YPwq2V1SFETRwjRWO675e5d48mNTyNVOevi/YQJRqn
 8wgpw7PxfrUBstNZaJCGfss2szjKaZrEpkwDtepvNvKBY12xXd9NYFVQtzL6pUhJZQimxl9Uk
 rrjZj5odrpU0FKxhfHUZ8ZheOleZAgJicNLKX7DJ/1gEhjMUEA4t67S9RBeLbUVy6FiBLxrri
 C0AvH7ZpdjuYf68fSl3P65IhbzrZ9nr3uIvdsP2Pcv91VYQOtjpZqXO1yrGBgu03pw9R+bZ/c
 KAuFQJg01MCRvz1+QMursJa7WpDuseIaVRKls0h2hwa+ucHiC9/lREzXGx5IZdQPD6M0/X67m
 42RA2xLBZ51j1kAZsBkkq36o1b/Y5yXJLrfhsR4gPqNeUDDslOZRv9JUpb6clNzCcKlMbbVy7
 2pxLk73hbgLjfOHO9bP9gHfh9uVynomUOjMT1T+93A+HTONOP66Pr3lk9cA6WrwuTZX8pmae5
 MuDTeIK2EJ5fsFT+Fr2tqpNFrQMD3/kPTcGYh7zSXEh/bJXcqMegB6VwgcIhDsxCIAd0EYc9T
 NFucufkz6kEGxGl57UlOZqOyY9vMv9xPG+Dlms7S8OKDKSzXb+VAZjGILHXg2n6CrCIiCNUsW
 riDrcVmlGB26X9rNBO5+3w6CFm2NCdxuye6wBiNXbB0tVpID1cWkqUvHM8AmnShvh9ja1zYbU
 osZVYa4Ran5Nr0T2UCmr/jDQy0yVA3a13mETyBr1LAc62LRMbK9ryIqeGg4l9dEmlXOK/UhK/
 cUY3VbpYZBcKasxO0hf4o47vB6s3yF67KGC6GQww+aV2brBlFoxHIh2fqBUX2+O10E7RXDBlx
 rGrAdf9qHJq7YftAgLowzyp3vvB/7
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Use migrate_colo() to initialize the ram cache in the normal migration pat=
h.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c | 18 ++++++++++++++----
 migration/savevm.c    | 14 +-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a5b0465ed30cb812cb294ab901c7a37fe6157dc6..c2b9621190f8678ac6b32d6794=
d9bcb6ffa5e402 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -630,10 +630,6 @@ int migration_incoming_enable_colo(Error **errp)
         return -EINVAL;
     }
=20
-    if (ram_block_discard_disable(true)) {
-        error_setg(errp, "COLO: cannot disable RAM discard");
-        return -EBUSY;
-    }
     migration_colo_enabled =3D true;
     return 0;
 }
@@ -770,6 +766,20 @@ process_incoming_migration_co(void *opaque)
=20
     assert(mis->from_src_file);
=20
+    if (migrate_colo()) {
+        if (ram_block_discard_disable(true)) {
+            error_setg(&local_err, "COLO: cannot disable RAM discard");
+            goto fail;
+        }
+
+        ret =3D colo_init_ram_cache(&local_err);
+        if (ret) {
+            error_prepend(&local_err, "failed to init colo RAM cache: %d:=
 ",
+                          ret);
+            goto fail;
+        }
+    }
+
     mis->largest_page_size =3D qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3a16c467b25b8d93b7d40bd0db751158e0278b4f..b88851cdb7974314b8481646a1=
dd19642887f210 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2427,19 +2427,7 @@ static int loadvm_process_enable_colo(MigrationInco=
mingState *mis,
                                       Error **errp)
 {
     ERRP_GUARD();
-    int ret;
-
-    ret =3D migration_incoming_enable_colo(errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D colo_init_ram_cache(errp);
-    if (ret) {
-        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
-        migration_incoming_disable_colo();
-    }
-    return ret;
+    return migration_incoming_enable_colo(errp);
 }
=20
 static int loadvm_postcopy_handle_switchover_start(Error **errp)

=2D-=20
2.39.5


