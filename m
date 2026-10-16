Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03742CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcWE-0004II-4m; Fri, 16 Oct 2026 03:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundayjiang@tencent.com>)
 id 1xHcWB-0004Hs-W3; Fri, 16 Oct 2026 03:38:20 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundayjiang@tencent.com>)
 id 1xHcW4-0003Gb-4s; Fri, 16 Oct 2026 03:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1792136279;
 bh=2Q6ZcMYCwe5prL8u8Ov5mLCrcVwUJLOk5TxMcNljTTY=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=dtwbqLg2rqB2ekleiryrZqFwAL/L4ptmAfS0nfRO+4z15PqhG5nHujkuv5+DTKwB9
 ShNB+Z9DZ8Km4GcSAsoQLDanG1UOKHS9AeyiBrwax48k9VZVPKL00xzP5JUnzIdZz2
 r0sKIIeY2MK7KhZSJlscEFp9cNkJn10UKcCl1GnE=
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqS7xMeAi0ZwzKfY/3NofcXC3eLIJCsAf3g=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: HMWROx1OaZMMu3mbejpgs3UNqKRokRmelKeS77RzzDQ=
X-Originating-IP: 14.116.236.54
X-QQ-STYLE: 
X-QQ-mid: lv5gz3a-0t1792136277t4a8a515c
From: "=?utf-8?B?c3VuZGF5amlhbmcoc3VuZGF5amlhbmcp?=" <sundayjiang@tencent.com>
To: "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Cc: "=?utf-8?B?cWVtdS1zdGFibGU=?=" <qemu-stable@nongnu.org>
Subject: [PATCH 0/2] usb-host: fix use-after-free issues
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_6AD1D455_C1DEC000_25F20D4C"
Content-Transfer-Encoding: 8Bit
Date: Fri, 16 Oct 2026 15:37:57 +0800
X-Priority: 3
Message-ID: <tencent_05C1CBE16E1B8D920F523A75@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 13369749436567538583
X-Address-Ticket: version=; type=; ticket_id=; id_list=; display_name=;
 session_id=; 
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 16 Oct 2026 15:37:57 +0800 (CST)
Feedback-ID: lv:tencent.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M3ZkD08p3wd5SqTDOhr20zUlWP5PBFNwf7qMcob7oW6BKSiDaB9ritrm
 yoyQ2R/d58UB42UqN5hOre9so4vVLi/ceJZ5YjNafYXC+bzmV7X+S0yPKvXqFUPUoEGL4jO
 lDYS3gb/BY48EK8xNNqHTiikgu2PFnWFY3Rpp5fO0LY7xUPWuZIekrjrXaZj8zTBYkP5iVP
 iyYlV9jR0lrOmJttVOCFERFOx8RVFBtIdJuR+dzRhxJyGJ11r/og7uoH0c73wp9FnmFI0p/
 Wrg/XWK5KxD6VlQ/HURdElXOI4mGRsMrWzqzWDywRJ4YMXPNtPzepn3WEtXqFL7QGu6iZy9
 OqnG5TfFFGUGuJPG2/jep1q/q8BCkfWsftVmJ6YTLVvxEF5/xhVYxVnUWJS9MiHX9jZcclb
 H+mPT1DoXrVKpa6Rv69d6YN1QM2bgc/vInVWbmTBRqfASFCHSi05o3cM2lscWdn4YafTiBA
 /TdCr5I0hZCh7Aap49S2WpwPFO9qT0Kdm2lyzPjbLemiYsziXvi74JO36tDSjd/vXFfLYfG
 hQIqQOIhx4H37cyY2DoJ5hufyumbjpDXWlh1TZsYEl9Eqc7octeKIvcdnOfZDiGe9Lbrjjx
 CAWaA4JDQEfzQcQ3YHi0DotpfRd69pWVJziGkuQ2bJNgeTINAySowghyBMlj1ogm9oI0TZ8
 qIXgBTjVjHy25HlnqrBluSKGCUSA+G6foY1xEZV9KJqRNAvs75BPY85kQERo1D8CMKxBC52
 5e68HbaOOG03ydoWHT3JCECMZbD+9fMRV94LQRv/Yj2Tl50A5BNk5USnRBBbuql28w8zBiC
 6W1Y1a6Q7qva7Po8ITSspKhMGmzSZoypFAl33VvwK2d8DEvEO1CTH1NW3oD+AUjv1v8A8rZ
 XVboGMkxhpuexinVJZpZeSNC4PIQ9HmMb6Z23cW2LJvfYYauAIs/G1iinZJfKqS/724Rrm2
 1Z9KU8eIe58gd//dBn+tJMZSkJyNhLv2PlxUG569TkcJbbWO7r1qbXEZ2nMwmifvbYWri4V
 E3WpADlvLmeiQ0aDOQECqRP+dEAGVrRllYKGZNmPI7v2+mwpVYjSCRqfaSyhAN+fMwCXMPq
 ig8uTIa9MyV55wsG2leRI6u0K6YAA+G7g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.243.244.52;
 envelope-from=sundayjiang@tencent.com; helo=smtpbguseast3.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.001, HTML_MESSAGE=0.001, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.

------=_NextPart_6AD1D455_C1DEC000_25F20D4C
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IHR3byBpbmRlcGVuZGVudCB1c2UtYWZ0ZXItZnJlZSBpc3N1ZXMgaW4gdGhlIGxpYnVz
YiB1c2ItaG9zdGJhY2tlbmQuDQoNCg0KVGhlIGZpcnN0IHBhdGNoIGZyZWVzIFVTQkhvc3RS
ZXF1ZXN0IG9iamVjdHMgd2hlbg0KbGlidXNiX3N1Ym1pdF90cmFuc2ZlcigpIGZhaWxzLCBw
cmV2ZW50aW5nIHN0YWxlIFVTQlBhY2tldCBwb2ludGVycw0KZnJvbSByZW1haW5pbmcgb24g
dGhlIHJlcXVlc3QgcXVldWUuDQoNCg0KVGhlIHNlY29uZCBwYXRjaCBkZWxldGVzIHRoZSBs
YXppbHkgYWxsb2NhdGVkIGJvdHRvbSBoYWx2ZXMgZHVyaW5nDQpkZXZpY2UgdW5yZWFsaXpl
LCBwcmV2ZW50aW5nIGNhbGxiYWNrcyBmcm9tIGFjY2Vzc2luZyBhIGZyZWVkDQpVU0JIb3N0
RGV2aWNlLg0KDQoNClRvbW1hc28gQ2FsaWZhbm8gdGVzdGVkIHRoZSBvcmlnaW5hbCBjb21i
aW5lZCBwYXRjaCBhbmQgcmVwb3J0ZWQgdGhhdA0KaXQgbG9va3MgY29ycmVjdC4gJm5ic3A7
VGhpcyBzZXJpZXMgc3BsaXRzIHRoZSB0d28gZml4ZXMgc28gdGhhdCBlYWNoIGNoYW5nZQ0K
aGFzIGl0cyBvd24gbG9naWNhbCBzY29wZSBhbmQgRml4ZXMgdGFnLg0KDQoNCkhhb3RpYW4g
SmlhbmcgKDIpOg0KJm5ic3A7IHVzYi1ob3N0OiBmcmVlIHJlcXVlc3Qgb24gbGlidXNiIHN1
Ym1pdCBmYWlsdXJlDQombmJzcDsgdXNiLWhvc3Q6IGRlbGV0ZSBib3R0b20gaGFsdmVzIGR1
cmluZyB1bnJlYWxpemUNCg0KDQombmJzcDtody91c2IvaG9zdC1saWJ1c2IuYyB8IDI5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQombmJzcDsxIGZpbGUgY2hhbmdlZCwgMjkg
aW5zZXJ0aW9ucygrKQ0KDQoNCi0tDQoyLjM0LjENCg0KDQoNCg0KDQrlj5Hoh6rmiJHnmoTk
vIHkuJrlvq7kv6E=

------=_NextPart_6AD1D455_C1DEC000_25F20D4C
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1zaXplOiAxNC42NjY3cHg7IGZvbnQtZmFtaWx5OiAtYXBwbGUt
c3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1BpbmdGYW5nIFNDJnF1b3Q7LCAm
cXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7IiBkYXRhLW1haWwtZnJvbT0id2VtYWlsLXBj
Ij48ZGl2IGlkPSJ3ZW1haWxfcGxhY2Vob2xkZXJfc3BhY2UiPjxkaXY+Rml4IHR3byBpbmRl
cGVuZGVudCB1c2UtYWZ0ZXItZnJlZSBpc3N1ZXMgaW4gdGhlIGxpYnVzYiB1c2ItaG9zdDxk
aXY+YmFja2VuZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBmaXJzdCBwYXRjaCBm
cmVlcyBVU0JIb3N0UmVxdWVzdCBvYmplY3RzIHdoZW48L2Rpdj48ZGl2PmxpYnVzYl9zdWJt
aXRfdHJhbnNmZXIoKSBmYWlscywgcHJldmVudGluZyBzdGFsZSBVU0JQYWNrZXQgcG9pbnRl
cnM8L2Rpdj48ZGl2PmZyb20gcmVtYWluaW5nIG9uIHRoZSByZXF1ZXN0IHF1ZXVlLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIHNlY29uZCBwYXRjaCBkZWxldGVzIHRoZSBsYXpp
bHkgYWxsb2NhdGVkIGJvdHRvbSBoYWx2ZXMgZHVyaW5nPC9kaXY+PGRpdj5kZXZpY2UgdW5y
ZWFsaXplLCBwcmV2ZW50aW5nIGNhbGxiYWNrcyBmcm9tIGFjY2Vzc2luZyBhIGZyZWVkPC9k
aXY+PGRpdj5VU0JIb3N0RGV2aWNlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VG9tbWFz
byBDYWxpZmFubyB0ZXN0ZWQgdGhlIG9yaWdpbmFsIGNvbWJpbmVkIHBhdGNoIGFuZCByZXBv
cnRlZCB0aGF0PC9kaXY+PGRpdj5pdCBsb29rcyBjb3JyZWN0LiAmbmJzcDtUaGlzIHNlcmll
cyBzcGxpdHMgdGhlIHR3byBmaXhlcyBzbyB0aGF0IGVhY2ggY2hhbmdlPC9kaXY+PGRpdj5o
YXMgaXRzIG93biBsb2dpY2FsIHNjb3BlIGFuZCBGaXhlcyB0YWcuPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5IYW90aWFuIEppYW5nICgyKTo8L2Rpdj48ZGl2PiZuYnNwOyB1c2ItaG9z
dDogZnJlZSByZXF1ZXN0IG9uIGxpYnVzYiBzdWJtaXQgZmFpbHVyZTwvZGl2PjxkaXY+Jm5i
c3A7IHVzYi1ob3N0OiBkZWxldGUgYm90dG9tIGhhbHZlcyBkdXJpbmcgdW5yZWFsaXplPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj4mbmJzcDtody91c2IvaG9zdC1saWJ1c2IuYyB8IDI5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrPC9kaXY+PGRpdj4mbmJzcDsxIGZpbGUg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LS08
L2Rpdj4yLjM0LjE8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJxcW1h
aWxfc2lnbiIgaWQ9IndlbWFpbHNpZ2NvbnRlbnQiIHNpZ25pZD0iNTAxIj48c3BhbiBpZD0i
ZGVmYXVsdF93ZW1haWxfc2lnX2xpbmVfd3JhcCI+PGhyIGNsYXNzPSJkZWZhdWx0X3dlbWFp
bF9zaWdfbGluZSIgd2lkdGg9IjEwMCIgc3R5bGU9Im1hcmdpbjogN3B4IDBweDsgYm9yZGVy
LXdpZHRoOiAwcHggMHB4IDFweDsgYm9yZGVyLXRvcC1jb2xvcjogaW5pdGlhbDsgYm9yZGVy
LXJpZ2h0LWNvbG9yOiBpbml0aWFsOyBib3JkZXItbGVmdC1jb2xvcjogaW5pdGlhbDsgYm9y
ZGVyLWltYWdlOiBpbml0aWFsOyBib3JkZXItYm90dG9tLXN0eWxlOiBzb2xpZDsgYm9yZGVy
LWJvdHRvbS1jb2xvcjogcmdiKDIzMCwgMjMyLCAyMzUpOyBoZWlnaHQ6IDBweDsgbGluZS1o
ZWlnaHQ6IHVuc2V0OyBmb250LXNpemU6IDBweDsgcGFkZGluZzogMHB4OyB3aWR0aDogNDBw
eCAhaW1wb3J0YW50OyIgYWxpZ249ImxlZnQiIGNvbnRlbnRlZGl0YWJsZT0iZmFsc2UiPjwv
c3Bhbj48ZGl2IGlkPSJ3ZW1haWxzaWdjb250ZW50X3ByZSI+PC9kaXY+PGEgc3R5bGU9ImNv
bG9yOiByZ2IoMzgsIDEyNiwgMjQwKTt0ZXh0LWRlY29yYXRpb246IG5vbmU7IG91dGxpbmU6
IG5vbmU7dGV4dC1kZWNvcmF0aW9uOm5vbmU7IG91dGxpbmU6bm9uZTsgY29sb3I6IzI2N0VG
MCIgY2xhc3M9ImN1cnNvci1wb2ludGVyIGRlZmF1bHQtc2lnIGlnbm9yZS1kYXJrIiBjb250
ZW50ZWRpdGFibGU9ImZhbHNlIiBocmVmPSJodHRwczovL3dvcmsud2VpeGluLnFxLmNvbS93
ZXdvcmtfYWRtaW4vdXNlci9oNS9xcW1haWxfdXNlcl9jYXJkL3ZjOTI1MzgwYWFjNGVmZGEw
Nj9mcm9tPW15cHJvZmlsZSIgdGFyZ2V0PSJfYmxhbmsiPuWPkeiHquaIkeeahOS8geS4muW+
ruS/oTwvYT48YnI+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGRpdj48
L2Rpdj48L2Rpdj4=

------=_NextPart_6AD1D455_C1DEC000_25F20D4C--


