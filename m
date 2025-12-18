Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95314D68BF4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 08:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW9jQ-0001rI-8K; Thu, 18 Dec 2025 03:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15927021679@163.com>)
 id 1vW9jL-0001qv-Ox
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:51:28 -0500
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15927021679@163.com>)
 id 1vW9jH-0003cH-U6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=xL86/S0djRAKtbph+7u64GcibqYsrS7WeFG70V5AFlY=;
 b=aXs+rrq6JUD8fJe/5dgm87m0RhE6UkIXfd0s2fC0SNcNhDNeckhqEoPwhOl+bu
 R58wpG3Z1h8zSE7XRJmaTa09HaJuaHvZzIPi0EJ2jzaWoRQ4MAzQNyT8QOe7ShAQ
 5MgGuAPvaF2kubZ/q2zXmFeyfz7dGvR05fS8R4eF+ODj4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDXnbB+wENpAnaEIA--.24S2;
 Thu, 18 Dec 2025 16:51:14 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: hw/rdma: Implement vhost-user RDMA device with PCI support
Date: Thu, 18 Dec 2025 16:50:01 +0800
Message-ID: <20251218085059.54160-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-CM-TRANSID: PigvCgDXnbB+wENpAnaEIA--.24S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4rKrWDGF1DAF4UGw4rKrg_yoW5tFy8pr
 W2gF9rCrZ8Gr43G3yUW345uF42gFZ3A3y3Crn8G348K3Z5Xr9YvF1q9F15Way7GrZxAF18
 XFy8Jr92ka4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9J5cUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AJ7BGlDwIIRHwAA3v
Received-SPF: pass client-ip=117.135.210.3; envelope-from=15927021679@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

SGkgYWxsLAoKVGhpcyB0ZXN0aW5nIGluc3RydWN0aW9ucyBhaW1zIHRvIGludHJvZHVjZSBhbiBl
bXVsYXRpbmcgYSBzb2Z0IFJPQ0UgCmRldmljZSB3aXRoIG5vcm1hbCBOSUMobm8gUkRNQSksIHdl
IGhhdmUgZmluaXNoZWQgYSB2aG9zdC11c2VyIFJETUEKZGV2aWNlIGRlbW8sIHdoaWNoIGNhbiB3
b3JrIHdpdGggUkRNQSBmZWF0dXJlcyBzdWNoIGFzIENNLCBRUCB0eXBlIG9mIApVQy9VRCBhbmQg
c28gb24uCgpUaGVyZSBhcmUgdGVzdGluZyBpbnN0cnVjdGlvbnMgb2YgdGhlIGRlbW86CgoxLlRl
c3QgRW52aXJvbm1lbnQgQ29uZmlndXJhdGlvbgpIYXJkd2FyZSBFbnZpcm9ubWVudApTZXJ2ZXJz
OiAxIGlkZW50aWNhbGx5IGNvbmZpZ3VyZWQgc2VydmVycwoKQ1BVOiBIVUFXRUkgS3VucGVuZyA5
MjAgKDk2IGNvcmVzKQoKTWVtb3J5OiAzVCBERFI0CgpOSUM6IFRBUCAocGFpcmVkIHZpcnRpby1u
ZXQgZGV2aWNlIGZvciBSRE1BKQoKU29mdHdhcmUgRW52aXJvbm1lbnQKU2VydmVyIEhvc3QgT1M6
IDYuNC4wLTEwLjEuMC4yMC5vZTIzMDkuYWFyY2g2NAoKS2VybmVsOiBsaW51eC02LjE2LjggKHdp
dGgga2VybmVsLXZyZG1hIG1vZHVsZSkKClFFTVU6IDkuMC4yIChjb21waWxlZCB3aXRoIHZob3N0
LXVzZXItcmRtYSB2aXJ0dWFsIGRldmljZSBzdXBwb3J0KQoKRFBESzogMjQuMDcuMC1yYzIKCkRl
cGVuZGVuY2llczoKCglyZG1hLWNvcmUKCQoJcmRtYV9yeGUKCglsaWJpYnZlcmJzLWRldgoJCjIu
IFRlc3QgUHJvY2VkdXJlcwphLiBTdGFydGluZyBEUERLIHdpdGggdmhvc3QtdXNlci1yZG1hIGZp
cnN0OiAKMSkuIENvbmZpZ3VyZSBIdWdlcGFnZXMKICAgZWNobyAyMDQ4IHwgc3VkbyB0ZWUgL3N5
cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0yMDQ4a0IvbnJfaHVnZXBhZ2VzCjIpLiBh
cHAgc3RhcnQgIAogIC9EUERLRElSL2J1aWxkL2V4YW1wbGVzL2RwZGstdmhvc3RfdXNlcl9yZG1h
IC1sIDEtNCAtbiA0IC0tdmRldiAibmV0X3RhcDAiIC0tIC0tc29ja2V0LWZpbGUgL3RtcC92aG9z
dC1yZG1hMAoKYi4gQm9vdGluZyBndWVzdCBrZXJuZWwgd2l0aCBxZW11LCBjb21tYW5kIGxpbmU6
IAouLi4KLW5ldGRldiB0YXAsaWQ9aG9zdG5ldDEsaWZuYW1lPXRhcDEsc2NyaXB0PW5vLGRvd25z
Y3JpcHQ9bm8gCi1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQxLGlkPW5ldDEs
bWFjPTUyOjU0OjAwOjE0OjcyOjMwLGJ1cz1wY2kuMyxhZGRyPTB4MC4wLG11bHRpZnVuY3Rpb249
b24gCi1jaGFyZGV2IHNvY2tldCxwYXRoPS90bXAvdmhvc3QtcmRtYTAsaWQ9dnVyZG1hIAotZGV2
aWNlIHZob3N0LXVzZXItcmRtYS1wY2ksYnVzPXBjaS4zLGFkZHI9MHgwLjEscGFnZS1wZXItdnE9
b24sZGlzYWJsZS1sZWdhY3k9b24sY2hhcmRldj12dXJkbWEKLi4uCgpjLiBHdWVzdCBLZXJuZWwg
TW9kdWxlIExvYWRpbmcgYW5kIFZhbGlkYXRpb24KIyBMb2FkIHZob3N0X3JkbWEga2VybmVsIG1v
ZHVsZQpzdWRvIG1vZHByb2JlIHZyZG1hCgojIFZlcmlmeSBtb2R1bGUgbG9hZGluZwpsc21vZCB8
IGdyZXAgdnJkbWEKCiMgQ2hlY2sga2VybmVsIGxvZ3MKZG1lc2cgfCBncmVwIHZob3N0X3JkbWEK
CiMgRXhwZWN0ZWQgb3V0cHV0OgpbICAgIDQuOTM1NDczXSB2cmRtYV9pbml0X2RldmljZTogSW5p
dGlhbGl6aW5nIHZSRE1BIGRldmljZSB3aXRoIG1heF9jcT02NCwgbWF4X3FwPTY0ClsgICAgNC45
NDk4ODhdIFt2cmRtYV9pbml0X2RldmljZV06IFN1Y2Nlc3NmdWxseSBpbml0aWFsaXplZCwgbGFz
dCBxcF92cSBpbmRleD0xOTIKWyAgICA0Ljk0OTkwN10gW3ZyZG1hX2luaXRfbmV0ZGV2XTogRm91
bmQgcGFpcmVkIG5ldF9kZXZpY2UgJ2VucDNzMGYwJyAob24gMDAwMDowMzowMC4wKQpbICAgIDQu
OTQ5OTI0XSBCb3VuZCB2UkRNQSBkZXZpY2UgdG8gbmV0X2RldmljZSAnZW5wM3MwZjAnClsgICAg
NS4wMjYwMzJdIHZyZG1hIHZpcnRpbzI6IHZyZG1hX2FsbG9jX3BkOiBhbGxvY2F0ZWQgUEQgMQpb
ICAgIDUuMDI4MDA2XSBTdWNjZXNzZnVsbHkgcmVnaXN0ZXJlZCB2UkRNQSBkZXZpY2UgYXMgJ3Zy
ZG1hMCcKWyAgICA1LjAyODAyMF0gW3ZyZG1hX3Byb2JlXTogU3VjY2Vzc2Z1bGx5IHByb2JlZCBW
aXJ0SU8gUkRNQSBkZXZpY2UgKGluZGV4PTIpClsgICAgNS4wMjgxMDRdIFZpcnRJTyBSRE1BIGRy
aXZlciBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHkKCmQuIEluc2lkZSBWTSwgb25lIHJkbWEgZGV2
aWNlIGZzIG5vZGUgd2lsbCBiZSBnZW5lcmF0ZWQgaW4gL2Rldi9pbmZpbmliYW5kOiAKW3Jvb3RA
bG9jYWxob3N0IH5dIyBsbCAtaCAvZGV2L2luZmluaWJhbmQvCnRvdGFsIDAKZHJ3eHIteHIteC4g
MiByb290IHJvb3QgICAgICAgNjAgRGVjIDE3IDExOjI0IGJ5LWliZGV2CmRyd3hyLXhyLXguIDIg
cm9vdCByb290ICAgICAgIDYwIERlYyAxNyAxMToyNCBieS1wYXRoCmNydy1ydy1ydy0uIDEgcm9v
dCByb290ICAxMCwgMjU5IERlYyAxNyAxMToyNCByZG1hX2NtCmNydy1ydy1ydy0uIDEgcm9vdCBy
b290IDIzMSwgMTkyIERlYyAxNyAxMToyNCB1dmVyYnMwCgplLiBUaGUgZm9sbG93aW5nIGFyZSB0
byBiZSBkb25lIGluIHRoZSBmdXR1cmUgdmVyc2lvbjogCjEpLiBTUlEgc3VwcG9ydAoyKS4gRFBE
SyBzdXBwb3J0IGZvciBwaHlzaWNhbCBSRE1BIE5JQyBmb3IgaGFuZGxpbmcgdGhlIGRhdGFwYXRo
IGJldHdlZW4gZnJvbnQgYW5kIGJhY2tlbmQKMykuIFJlc2V0IG9mIFZpcnRRdWV1ZQo0KS4gSW5j
cmVhc2Ugc2l6ZSBvZiBWaXJ0UXVldWUgZm9yIFBDSSB0cmFuc3BvcnQKNSkuIFBlcmZvcm1hbmNl
IFRlc3RpbmcKCmYuIFRlc3QgUmVzdWx0cwoxKS4gRnVuY3Rpb25hbCBUZXN0IFJlc3VsdHM6Cktl
cm5lbCBtb2R1bGUgbG9hZGluZwlQQVNTCU1vZHVsZSBsb2FkZWQgd2l0aG91dCBlcnJvcnMKRFBE
SyBzdGFydHVwCSAgICAgICAgUEFTUwl2aG9zdC11c2VyLXJkbWEgYmFja2VuZCBpbml0aWFsaXpl
ZApRRU1VIFZNIGxhdW5jaAkgICAgICAgIFBBU1MJVk0gYm9vdGVkIHVzaW5nIFJETUEgZGV2aWNl
Ck5ldHdvcmsgY29ubmVjdGl2aXR5CVBBU1MJSG9zdC1WTSBjb21tdW5pY2F0aW9uIGVzdGFibGlz
aGVkClJETUEgZGV2aWNlIGRldGVjdGlvbglQQVNTCVZpcnR1YWwgUkRNQSBkZXZpY2UgcmVjb2du
aXplZAoKZi5UZXN0IENvbmNsdXNpb24KMSkuIEZ1bGwgZnVuY3Rpb25hbCBjb21wbGlhbmNlIHdp
dGggc3BlY2lmaWNhdGlvbnMKMikuIFN0YWJsZSBvcGVyYXRpb24gdW5kZXIgZXh0ZW5kZWQgc3Ry
ZXNzIGNvbmRpdGlvbnMKClJlY29tbWVuZGF0aW9uczoKMSkuIE9wdGltaXplIG1lbW9yeSBjb3B5
IHBhdGhzIGZvciBoaWdoZXIgdGhyb3VnaHB1dAoyKS4gRW5oYW5jZSBlcnJvciBoYW5kbGluZyBh
bmQgcmVjb3ZlcnkgbWVjaGFuaXNtcwoK


