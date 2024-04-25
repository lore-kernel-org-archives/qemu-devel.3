Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3668C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 12:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzydG-0003sC-P2; Thu, 25 Apr 2024 08:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rzydB-0003qS-J2; Thu, 25 Apr 2024 08:55:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rzyd7-00045C-CI; Thu, 25 Apr 2024 08:55:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PCgQgh018220; Thu, 25 Apr 2024 12:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=N8tHmz6S97i4LDzl+kMtgurXney/kJSUyC6iCgsh/vM=;
 b=ZLMnYL4vryDKOPT6DTiMztxideHv+eQOxEjtRsFr+QhPg+I1VRueLxVXp+yqic3XjfT2
 mDHfVAGM2PqgLCAW1c8ml32fqHYbPu84oyDaD4vvFX8X6tDWrShTHLANSWFGBL1W9fmV
 V/JAZEGOGfCO0Y6A3Vew0JFXWxwhm/Jst6XUHefAwqQWd3exxtMXZDXli1NYYyB7AOcP
 0RVAdv2OzmaoaIceoEGmuGB/AlEB2HI/CFCBKeBDPNA7kas+hi9lsFwkRxiqjz/JvEBT
 j2Q5ZWzKIM2Foyhtax1PDbEBS5p0/dp7XyZdxgoXqEQkgnPIqvqhBc1dvL7Nj6eUGOCR 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqdkr0ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 12:55:09 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PCoakU031605;
 Thu, 25 Apr 2024 12:55:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqdkr0ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 12:55:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43P9Ts7T028319; Thu, 25 Apr 2024 12:55:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2saf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 12:55:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43PCt5q633817158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Apr 2024 12:55:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9255D58052;
 Thu, 25 Apr 2024 12:55:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C69058050;
 Thu, 25 Apr 2024 12:55:04 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.77.70]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Apr 2024 12:55:04 +0000 (GMT)
Message-ID: <f1ac1e5f27239411f0e4a658507c331a106fd0a8.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] vfio/ccw: Make vfio_ccw_register_irq_notifier()
 return a bool
From: Eric Farman <farman@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 25 Apr 2024 08:55:04 -0400
In-Reply-To: <87il056783.fsf@pond.sub.org>
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-5-clg@redhat.com> <87il056783.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zaNWiN3YhrKL4iL2Y2w5QxzY2xOZmUyh
X-Proofpoint-ORIG-GUID: J1mJ3-iqUGdNZeJtcahkneCFFo3RVn-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250093
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEyOjU2ICswMjAwLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90
ZToKPiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+IHdyaXRlczoKPiAKPiA+IFNp
bmNlIHZmaW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmllcigpIHRha2VzIGFuICdFcnJvciAqKicK
PiA+IGFyZ3VtZW50LAo+ID4gYmVzdCBwcmFjdGljZXMgc3VnZ2VzdCB0byByZXR1cm4gYSBib29s
LiBTZWUgdGhlIHFhcGkvZXJyb3IuaCBSdWxlcwo+ID4gc2VjdGlvbi4KPiA+IAo+ID4gU2lnbmVk
LW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiDC
oGh3L3ZmaW8vY2N3LmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tCj4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vY2N3LmMgYi9ody92ZmlvL2Njdy5jCj4gPiBpbmRleAo+ID4gNjc2NDM4
OGJjNDdhOTcwMzI5ZmNlMjIzMzYyNmNjYjgxNzhlMDE2NS4uMWM2MzBmNmU5YWJlOTNhZTBjMmI1
NjE1ZAo+ID4gNDQwOTY2OWYwOTZjOGM5IDEwMDY0NAo+ID4gLS0tIGEvaHcvdmZpby9jY3cuYwo+
ID4gKysrIGIvaHcvdmZpby9jY3cuYwo+ID4gQEAgLTM3OSw3ICszNzksNyBAQCByZWFkX2VycjoK
PiA+IMKgwqDCoMKgIGNzc19pbmplY3RfaW9faW50ZXJydXB0KHNjaCk7Cj4gPiDCoH0KPiA+IMKg
Cj4gPiAtc3RhdGljIHZvaWQgdmZpb19jY3dfcmVnaXN0ZXJfaXJxX25vdGlmaWVyKFZGSU9DQ1dE
ZXZpY2UgKnZjZGV2LAo+ID4gK3N0YXRpYyBib29sIHZmaW9fY2N3X3JlZ2lzdGVyX2lycV9ub3Rp
ZmllcihWRklPQ0NXRGV2aWNlICp2Y2RldiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGludCBpcnEsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBF
cnJvciAqKmVycnApCj4gPiDCoHsKPiA+IEBAIC00MDUsMTMgKzQwNSwxMyBAQCBzdGF0aWMgdm9p
ZAo+ID4gdmZpb19jY3dfcmVnaXN0ZXJfaXJxX25vdGlmaWVyKFZGSU9DQ1dEZXZpY2UgKnZjZGV2
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IMKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJycCwgInZmaW86IFVuc3VwcG9ydGVkIGRldmlj
ZSBpcnEoJWQpIiwgaXJxKTsKPiA+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gPiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+ID4gwqDCoMKgwqAgfQo+ID4gwqAKPiA+IMKgwqDCoMKg
IGlmICh2ZGV2LT5udW1faXJxcyA8IGlycSArIDEpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqAgZXJy
b3Jfc2V0ZyhlcnJwLCAidmZpbzogSVJRICV1IG5vdCBhdmFpbGFibGUgKG51bWJlciBvZgo+ID4g
aXJxcyAldSkiLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJx
LCB2ZGV2LT5udW1faXJxcyk7Cj4gPiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiA+IMKgwqDCoMKgIH0KPiA+IMKgCj4gPiDCoMKgwqDC
oCBhcmdzeiA9IHNpemVvZigqaXJxX2luZm8pOwo+ID4gQEAgLTQyMSwxNCArNDIxLDE0IEBAIHN0
YXRpYyB2b2lkCj4gPiB2ZmlvX2Njd19yZWdpc3Rlcl9pcnFfbm90aWZpZXIoVkZJT0NDV0Rldmlj
ZSAqdmNkZXYsCj4gPiDCoMKgwqDCoCBpZiAoaW9jdGwodmRldi0+ZmQsIFZGSU9fREVWSUNFX0dF
VF9JUlFfSU5GTywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJxX2luZm8pIDwg
MCB8fCBpcnFfaW5mby0+Y291bnQgPCAxKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Nl
dGdfZXJybm8oZXJycCwgZXJybm8sICJ2ZmlvOiBFcnJvciBnZXR0aW5nIGlycQo+ID4gaW5mbyIp
Owo+ID4gLcKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
ZmFsc2U7Cj4gPiDCoMKgwqDCoCB9Cj4gPiDCoAo+ID4gwqDCoMKgwqAgaWYgKGV2ZW50X25vdGlm
aWVyX2luaXQobm90aWZpZXIsIDApKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGdf
ZXJybm8oZXJycCwgZXJybm8sCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAidmZpbzogVW5hYmxlIHRvIGluaXQgZXZlbnQgbm90aWZpZXIgZm9y
Cj4gPiBpcnEgKCVkKSIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpcnEpOwo+ID4gLcKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4gPiDCoMKgwqDCoCB9Cj4gPiDCoAo+ID4gwqDCoMKg
wqAgZmQgPSBldmVudF9ub3RpZmllcl9nZXRfZmQobm90aWZpZXIpOwo+ID4gQEAgLTQzOSw2ICs0
MzksOCBAQCBzdGF0aWMgdm9pZAo+ID4gdmZpb19jY3dfcmVnaXN0ZXJfaXJxX25vdGlmaWVyKFZG
SU9DQ1dEZXZpY2UgKnZjZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBxZW11X3NldF9mZF9oYW5k
bGVyKGZkLCBOVUxMLCBOVUxMLCB2Y2Rldik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGV2ZW50X25v
dGlmaWVyX2NsZWFudXAobm90aWZpZXIpOwo+ID4gwqDCoMKgwqAgfQo+ID4gKwo+ID4gK8KgwqDC
oCByZXR1cm4gdHJ1ZTsKPiA+IMKgfQo+ID4gwqAKPiA+IMKgc3RhdGljIHZvaWQgdmZpb19jY3df
dW5yZWdpc3Rlcl9pcnFfbm90aWZpZXIoVkZJT0NDV0RldmljZSAqdmNkZXYsCj4gPiBAQCAtNjAy
LDIwICs2MDQsMTggQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfcmVhbGl6ZShEZXZpY2VTdGF0ZQo+
ID4gKmRldiwgRXJyb3IgKiplcnJwKQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9yZWdp
b25fZXJyOwo+ID4gwqDCoMKgwqAgfQo+ID4gwqAKPiA+IC3CoMKgwqAgdmZpb19jY3dfcmVnaXN0
ZXJfaXJxX25vdGlmaWVyKHZjZGV2LCBWRklPX0NDV19JT19JUlFfSU5ERVgsCj4gPiAmZXJyKTsK
PiA+IC3CoMKgwqAgaWYgKGVycikgewo+ID4gK8KgwqDCoCBpZiAoIXZmaW9fY2N3X3JlZ2lzdGVy
X2lycV9ub3RpZmllcih2Y2RldiwKPiA+IFZGSU9fQ0NXX0lPX0lSUV9JTkRFWCwgJmVycikpIHsK
PiAKPiBQbGVhc2UgcGFzcyBlcnJwIGluc3RlYWQgb2YgJmVyci4KPiAKPiA+IMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXRfaW9fbm90aWZpZXJfZXJyOwo+ID4gwqDCoMKgwqAgfQo+ID4gwqAKPiA+
IMKgwqDCoMKgIGlmICh2Y2Rldi0+Y3J3X3JlZ2lvbikgewo+ID4gLcKgwqDCoMKgwqDCoMKgIHZm
aW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmllcih2Y2RldiwKPiA+IFZGSU9fQ0NXX0NSV19JUlFf
SU5ERVgsICZlcnIpOwo+ID4gLcKgwqDCoMKgwqDCoMKgIGlmIChlcnIpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoIXZmaW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmllcih2Y2RldiwKPiA+IFZG
SU9fQ0NXX0NSV19JUlFfSU5ERVgsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JmVycikpIHsKPiAKPiBMaWtld2lzZS4KPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIG91dF9pcnFfbm90aWZpZXJfZXJyOwo+ID4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoMKg
wqDCoCB9Cj4gPiDCoAo+ID4gLcKgwqDCoCB2ZmlvX2Njd19yZWdpc3Rlcl9pcnFfbm90aWZpZXIo
dmNkZXYsIFZGSU9fQ0NXX1JFUV9JUlFfSU5ERVgsCj4gPiAmZXJyKTsKPiA+IC3CoMKgwqAgaWYg
KGVycikgewo+ID4gK8KgwqDCoCBpZiAoIXZmaW9fY2N3X3JlZ2lzdGVyX2lycV9ub3RpZmllcih2
Y2RldiwKPiA+IFZGSU9fQ0NXX1JFUV9JUlFfSU5ERVgsICZlcnIpKSB7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgIC8qCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBSZXBvcnQgdGhpcyBlcnJvciwgYnV0
IGRvIG5vdCBtYWtlIGl0IGEgZmFpbGluZwo+ID4gY29uZGl0aW9uLgo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgICogTGFjayBvZiB0aGlzIElSUSBpbiB0aGUgaG9zdCBkb2VzIG5vdCBwcmV2ZW50IG5v
cm1hbAo+ID4gb3BlcmF0aW9uLgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnRfZXJyKGVycik7Cj4gCj4gTm90IHRoaXMgcGF0Y2gn
cyBwcm9ibGVtLCBidXQgaGVyZSBnb2VzIGFueXdheTogc2luY2UgdGhpcyBpc24ndCBhbgo+IGVy
cm9yLCB3ZSBzaG91bGRuJ3QgdXNlIGVycm9yX3JlcG9ydF9lcnIoKS7CoCBXb3VsZCB3YXJuX3Jl
cG9ydF9lcnIoKQo+IGJlCj4gYXBwcm9wcmlhdGU/wqAgaW5mb19yZXBvcnRfZXJyKCkgZG9lc24n
dCBleGlzdCwgYnV0IGl0IGNvdWxkLgo+IAo+IFByZWZlcmFibHkgd2l0aCBlcnJwIGluc3RlYWQg
b2YgJmVyciAodHdvIHRpbWVzKToKPiBSZXZpZXdlZC1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFy
bWJydUByZWRoYXQuY29tPgo+IAoKRG9uJ3QgcmVjYWxsIHdoeSBJIHVzZWQgZXJyb3JfcmVwb3J0
X2VycigpIGluc3RlYWQgb2Ygc29tZXRoaW5nIGVsc2UKKG9yIGNyZWF0aW5nIGluZm9fKSwgYnV0
IHByb2JhYmx5IGp1c3QgZmFtaWxpYXJpdHkuIFRoZXJlJ3Mgbm8gbmVlZCBmb3IKaXQgKG9yIHRo
ZSBlcXVpdmFsZW50IGNvZGUgaW4gLWFwKSB0byBiZSBlcnJvciwgYW5kIGNvdWxkIGJlIGFub3Ro
ZXIKY2xlYW51cC4KClJldmlld2VkLWJ5OiBFcmljIEZhcm1hbiA8ZmFybWFuQGxpbnV4LmlibS5j
b20+Cg==


