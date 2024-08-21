Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC8C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 16:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgoc2-0005JG-7M; Wed, 21 Aug 2024 12:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carisett@akamai.com>)
 id 1sgobz-0005IJ-VS; Wed, 21 Aug 2024 12:55:08 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carisett@akamai.com>)
 id 1sgobx-0000dv-8m; Wed, 21 Aug 2024 12:55:07 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDB9SI023374;
 Wed, 21 Aug 2024 17:55:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=jan2016.eng; bh=ETR7TXQf1nvMGtYkfFtEub
 IZTiXzdtsh6YuzsrL5PVU=; b=lEMHlwPjo2IOrwFU1BcyMYt3CuYIHHKCh1NT+b
 4l2YGSiGaVz+Cf2OzcyKMqOEtiw65ecTDoN0Jd5pHB73W5L7iKJNArthM6x/potl
 zIIsLVC4FipfCy9rsP9swOjA+2QMioSPaNUJNe/+Z9LUmEbips1lbvecPupmkrUk
 52IvKDZIhTQIPFHWHfzhYEz+0YMQ7P0aJN+T/BSPnY6ijaJUjfbp7W+s4enb8iuO
 p7I6Xzi1mDlNv+lTD5MIAhBsKYTh5UfH00OUTiCNgCd+2SQLLm3vNvUNbxBPxqXM
 4a6MtZpXUi+6hkkNeBZDEySdE6L49u9FuqfzpN+8IDW1lz5w==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4149peyh3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Aug 2024 17:55:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 47LGgxmb014457; Wed, 21 Aug 2024 12:55:01 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.202])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4138s02mjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Aug 2024 12:55:01 -0400
Received: from ustx2ex-dag4mb8.msg.corp.akamai.com (172.27.50.207) by
 ustx2ex-dag4mb3.msg.corp.akamai.com (172.27.50.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 09:55:00 -0700
Received: from ustx2ex-dag4mb8.msg.corp.akamai.com ([172.27.50.207]) by
 ustx2ex-dag4mb8.msg.corp.akamai.com ([172.27.50.207]) with mapi id
 15.02.1544.011; Wed, 21 Aug 2024 09:55:00 -0700
From: "Arisetty, Chakri" <carisett@akamai.com>
To: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
CC: "\"Peter Xu <peterx@redhat.com>\"@imap1.dmz-prg2.suse.org"
 <"Peter Xu <peterx@redhat.com>"@imap1.dmz-prg2.suse.org>, "\"Kevin Wolf
 <kwolf@redhat.com>\"@imap1.dmz-prg2.suse.org"
 <"Kevin Wolf <kwolf@redhat.com>"@imap1.dmz-prg2.suse.org>, "\"Eric  Blake
 <eblake@redhat.com>\"@imap1.dmz-prg2.suse.org"
 <"Eric  Blake <eblake@redhat.com>"@imap1.dmz-prg2.suse.org>,
 "Blew III, Will" <wblewiii@akamai.com>,
 "Massry, Abraham" <amassry@akamai.com>, "Tottenham,
 Max" <mtottenh@akamai.com>, "Greve, Mark" <mgreve@akamai.com>
Subject: Re: Issue with QEMU Live Migration
Thread-Topic: Issue with QEMU Live Migration
Thread-Index: AQHa886FsqX6lMAdoUyRdLRWIRR0PbIyMZ0A//+8fIA=
Date: Wed, 21 Aug 2024 16:55:00 +0000
Message-ID: <ACB0E3E9-BA69-4EC7-A4EB-3AF2F21D4C8A@akamai.com>
References: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
 <874j7e0yjt.fsf@suse.de>
In-Reply-To: <874j7e0yjt.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.118.139]
Content-Type: multipart/mixed;
 boundary="_002_ACB0E3E9BA694EC7A4EB3AF2F21D4C8Aakamaicom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210123
X-Proofpoint-GUID: Yb2TZpY7SSwnyv_FslDRrunC2KiQ5-DS
X-Proofpoint-ORIG-GUID: Yb2TZpY7SSwnyv_FslDRrunC2KiQ5-DS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210123
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=carisett@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_002_ACB0E3E9BA694EC7A4EB3AF2F21D4C8Aakamaicom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B4F3874F5573F47B967314F33FA7397@akamai.com>
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rIHlvdSBmb3IgZ2V0dGluZyBiYWNrIHRvIG1lLg0KDQpZZXMsIEkgaGF2ZSBv
cGVuZWQgdGhlIHRpY2tldCBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRs
YWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzI0ODJfXzshIUdqdlR6X3ZrIVNDZy1h
NUxpdUFHbFd5UTZPcGQ5dXJOQVc0X1otdFV0elBaQVJXQjFkM1VsZ193czg3eUwzaUpjeHVaUGt0
TGVITk50UHp0SlRKWk5KZEUkIDxodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9n
aXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzI0ODJfXzshIUdqdlR6X3ZrIVND
Zy1hNUxpdUFHbFd5UTZPcGQ5dXJOQVc0X1otdFV0elBaQVJXQjFkM1VsZ193czg3eUwzaUpjeHVa
UGt0TGVITk50UHp0SlRKWk5KZEUkPg0KDQo+IFNvIHRoZSBjb3JlIG9mIHRoZSBpc3N1ZSBoZXJl
IGlzIHRoYXQgdGhlIGJsb2NrIGpvYiBpcyB0cmFuc2l0aW9uaW5nIHRvDQo+IHJlYWR5IHdoaWxl
IHRoZSBtaWdyYXRpb24gaXMgc3RpbGwgb25nb2luZyBzbyB0aGVyZSdzIHN0aWxsIGRpcnR5aW5n
DQo+IGhhcHBlbmluZy4NCg0KWWVzLCB0aGlzIGlzIHRoZSBwcm9ibGVtIEkgaGF2ZS4gUkFNIG1p
Z3JhdGlvbiBzdGF0ZSBpcyBhbHJlYWR5IG1vdmVkIHRvIHByZS1zd2l0Y2hvdmVyIGFuZCBtaXJy
b3IgYmxvY2sgam9iIGlzIG1vdmVkIHRvICJSRUFEWSIgc3RhdGUgYXNzdW1pbmcgdGhhdCB0aGVy
ZSBhcmUgbm8gbW9yZSBkaXJ0eSBibG9ja3MuDQpCdXQgdGhlcmUgYXJlIHN0aWxsIGRpcnR5IGJs
b2NrcyBhbmQgdGhlc2UgZGlydHkgYmxvY2sgYmxvY2tzIGFyZSBiZWluZyB0cmFuc2ZlcnJlZCB0
byBkZXN0aW5hdGlvbiBob3N0Lg0KDQpJJ3ZlIGNyZWF0ZWQgYSBzbWFsbCBwYXRjaChhdHRhY2hl
ZCkgaW4gbWlycm9yLmMgdG8gcHV0IHRoZSBtaXJyb3Igam9iIGJhY2sgaW50byB0aGUgIlJVTk5J
TkciIHN0YXRlIGlmIHRoZXJlIGFyZSBhbnkgZGlydHkgcGFnZXMuDQpCdXQgSSBzdGlsbCB3b3Vs
ZCBsaWtlIHRvIHByZXZlbnQgUkFNIG1pZ3JhdGlvbiBzdGF0ZSB0byBiZSBtb3ZlZCB0byBwcmUt
c3dpdGNob3ZlciB3aGVuIHRoZXJlIGFyZSBkaXJ0eSBibG9ja3MuDQoNCj4gZG9jcy9pbnRlcm9w
L2xpdmUtYmxvY2stb3BlcmF0aW9ucy5yc3Q/IFNlY3Rpb24gIlFNUCBpbnZvY2F0aW9uIGZvciBs
aXZlDQo+IHN0b3JhZ2UgbWlncmF0aW9uIHdpdGggYGBkcml2ZS1taXJyb3JgYCArIE5CRCIsIHBv
aW50IDQgc2F5cyB0aGF0IGENCj4gYmxvY2stam9iLWNhbmNlbCBzaG91bGQgYmUgaXNzdWVzIGFm
dGVyIEJMT0NLX0pPQl9SRUFEWSBpcw0KPiByZWFjaGVkLiBBbHRob3VnaCB0aGVyZSBpcyBtZW50
aW9uIG9mIHdoZW4gdGhlIG1pZ3JhdGlvbiBzaG91bGQgYmUNCj4gcGVyZm9ybWVkLg0KDQpUaGFu
a3MgZm9yIHRoZSBwb2ludGVyLCBJJ3ZlIGxvb2tlZCBhdCB0aGlzIHBhcnQgKGJsb2NrLWpvYi1j
YW5jZWwpLiBUaGUgcHJvYmxlbSBpcyB0aGF0IFFFTVUgb24gdGhlIHNvdXJjZSBob3N0IGlzIHN0
aWxsIHRyYW5zZmVycmluZyB0aGUgZGlydHkgYmxvY2tzLg0KVGhhdCBpcyB0aGUgcmVhc29uIEkg
YW0gdHJ5aW5nIHRvIGF2b2lkIG1vdmluZyBSQU0gbWlncmF0aW9uIHN0YXRlIHRvIHByZS1zd2l0
Y2hvdmVyIHdoZW4gdGhlcmUgYXJlIGFueSBkaXJ0eSBwYWdlcy4NCg0KaXMgdGhlcmUgYSB3YXkg
aW4gUUVNVSB0byBrbm93IGlmIHRoZSBkaXNrIHRyYW5zZmVyIGlzIGNvbXBsZXRlZCBhbmQgc3Rv
cCBkaXJ0eSBwYWdlcyBiZWluZyB0cmFuc2ZlcnJlZD8NCg0KVGhhbmtzDQpDaGFrcmkNCg0KDQrv
u79PbiA4LzIxLzI0LCA2OjU2IEFNLCAiRmFiaWFubyBSb3NhcyIgPGZhcm9zYXNAc3VzZS5kZSA8
bWFpbHRvOmZhcm9zYXNAc3VzZS5kZT4+IHdyb3RlOg0KDQoNCiEtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KVGhpcyBN
ZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQpUaGlzIG1lc3NhZ2UgY2FtZSBmcm9t
IG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uDQp8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCg0KDQoiQXJpc2V0dHks
IENoYWtyaSIgPGNhcmlzZXR0QGFrYW1haS5jb20gPG1haWx0bzpjYXJpc2V0dEBha2FtYWkuY29t
Pj4gd3JpdGVzOg0KDQoNCj4gSGVsbG8sDQo+DQo+IEnigJltIGhhdmluZyB0cm91YmxlIHdpdGgg
bGl2ZSBtaWdyYXRpb24gYW5kIEnigJltIHVzaW5nIFFFTVUgNy4yLjAgb24gRGViaWFuIDExLg0K
Pg0KPiBNaWdyYXRpb24gc3RhdGUgc3dpdGNoZXMgdG8gcHJlLXN3aXRjaG92ZXIgc3RhdGUgZHVy
aW5nIHRoZSBSQU0gbWlncmF0aW9uLg0KPg0KPiBNeSBhc3N1bXB0aW9uIGlzIHRoYXQgZGlza3Mg
YXJlIGFscmVhZHkgbWlncmF0ZWQgYW5kIHRoZXJlIGFyZSBubyBmdXJ0aGVyIGRpcnR5IHBhZ2Vz
IHRvIGJlIHRyYW5zZmVycmVkIGZyb20gc291cmNlIGhvc3QgdG8gZGVzdGluYXRpb24gaG9zdC4g
VGhlcmVmb3JlLCBOQkQgY2xpZW50IG9uIHRoZSBzb3VyY2UgaG9zdCBjbG9zZXMgdGhlIGNvbm5l
Y3Rpb24gdG8gdGhlIE5CRCBzZXJ2ZXIgb24gdGhlIGRlc3RpbmF0aW9uIGhvc3QuIEJ1dCB3ZSBv
YnNlcnZlIHRoYXQgdGhlcmUgYXJlIHN0aWxsIHNvbWUgZGlydHkgcGFnZXMgYmVpbmcgdHJhbnNm
ZXJyZWQuDQo+IENsb3NpbmcgcHJlbWF0dXJlbHkgTkJEIGNvbm5lY3Rpb24gcmVzdWx0cyBpbiBC
TE9DSyBKT0IgZXJyb3IuDQo+IEluIHRoZSBSQU0gbWlncmF0aW9uIGNvZGUgKG1pZ3JhdGlvbi9t
aWdyYXRpb24uYyksIEnigJlkIGxpa2UgdG8gY2hlY2sgZm9yIGJsb2NrIG1pcnJvciBqb2LigJlz
IHN0YXR1cyBiZWZvcmUgUkFNIG1pZ3JhdGlvbiBzdGF0ZSBpcyBtb3ZlZCB0byBwcmUtc3dpdGNo
b3Zlci4gSeKAmW0gdW5hYmxlIHRvIGZpbmQgYW55IGJsb2NrIGpvYiByZWxhdGVkIGNvZGUgaW4g
UkFNIG1pZ3JhdGlvbiBjb2RlLg0KPg0KPiBDb3VsZCBzb21lb25lIGhlbHAgbWUgZmlndXJpbmcg
b3V0IHdoYXQgbWlnaHQgYmUgZ29pbmcgd3Jvbmcgb3Igc3VnZ2VzdCBhbnkgdHJvdWJsZXNob290
aW5nIHN0ZXBzIG9yIGFkdmljZSB0byBnZXQgYXJvdW5kIHRoZSBpc3N1ZT8NCj4NCj4gVGhhbmtz
DQo+IENoYWtyaQ0KDQoNCkhpLCBJIGJlbGlldmUgaXQgd2FzIHlvdSB3aG8gb3BlbmVkIHRoaXMg
YnVnIGFzIHdlbGw/IA0KDQoNCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMjQ4Ml9fOyEhR2p2VHpfdmshU0Nn
LWE1TGl1QUdsV3lRNk9wZDl1ck5BVzRfWi10VXR6UFpBUldCMWQzVWxnX3dzODd5TDNpSmN4dVpQ
a3RMZUhOTnRQenRKVEpaTkpkRSQgPGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMjQ4Ml9fOyEhR2p2VHpfdmsh
U0NnLWE1TGl1QUdsV3lRNk9wZDl1ck5BVzRfWi10VXR6UFpBUldCMWQzVWxnX3dzODd5TDNpSmN4
dVpQa3RMZUhOTnRQenRKVEpaTkpkRSQ+IA0KDQoNClNvIHRoZSBjb3JlIG9mIHRoZSBpc3N1ZSBo
ZXJlIGlzIHRoYXQgdGhlIGJsb2NrIGpvYiBpcyB0cmFuc2l0aW9uaW5nIHRvDQpyZWFkeSB3aGls
ZSB0aGUgbWlncmF0aW9uIGlzIHN0aWxsIG9uZ29pbmcgc28gdGhlcmUncyBzdGlsbCBkaXJ0eWlu
Zw0KaGFwcGVuaW5nLg0KDQoNCkhhdmUgeW91IGxvb2tlZCBhdCB0aGUgZG9jdW1lbnRhdGlvbiBh
dA0KZG9jcy9pbnRlcm9wL2xpdmUtYmxvY2stb3BlcmF0aW9ucy5yc3Q/IFNlY3Rpb24gIlFNUCBp
bnZvY2F0aW9uIGZvciBsaXZlDQpzdG9yYWdlIG1pZ3JhdGlvbiB3aXRoIGBgZHJpdmUtbWlycm9y
YGAgKyBOQkQiLCBwb2ludCA0IHNheXMgdGhhdCBhDQpibG9jay1qb2ItY2FuY2VsIHNob3VsZCBi
ZSBpc3N1ZXMgYWZ0ZXIgQkxPQ0tfSk9CX1JFQURZIGlzDQpyZWFjaGVkLiBBbHRob3VnaCB0aGVy
ZSBpcyBtZW50aW9uIG9mIHdoZW4gdGhlIG1pZ3JhdGlvbiBzaG91bGQgYmUNCnBlcmZvcm1lZC4N
Cg0KDQoNCg==

--_002_ACB0E3E9BA694EC7A4EB3AF2F21D4C8Aakamaicom_
Content-Type: application/octet-stream; name="qemu-block-job-running.patch"
Content-Description: qemu-block-job-running.patch
Content-Disposition: attachment; filename="qemu-block-job-running.patch";
	size=2051; creation-date="Wed, 21 Aug 2024 16:55:00 GMT";
	modification-date="Wed, 21 Aug 2024 16:55:00 GMT"
Content-ID: <B0BC3DA0BE676A4692C28E9680818DE9@akamai.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL21pcnJvci5jIGIvYmxvY2svbWlycm9yLmMKaW5kZXggMjUxYWRj
NWFlLi4zNDU3YWZlMWQgMTAwNjQ0Ci0tLSBhL2Jsb2NrL21pcnJvci5jCisrKyBiL2Jsb2NrL21p
cnJvci5jCkBAIC0xMDg5LDYgKzEwODksMTAgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gbWly
cm9yX3J1bihKb2IgKmpvYiwgRXJyb3IgKiplcnJwKQogICAgICAgICAgICAgYnJlYWs7CiAgICAg
ICAgIH0KIAorCWlmIChjbnQgIT0gMCAmJiBqb2JfaXNfcmVhZHkoJnMtPmNvbW1vbi5qb2IpKSB7
CisgICAgICAgICAgICBqb2JfdHJhbnNpdGlvbl90b19ydW5uaW5nKCZzLT5jb21tb24uam9iKTsK
KyAgICAgICAgfQorCiAgICAgICAgIGlmIChqb2JfaXNfcmVhZHkoJnMtPmNvbW1vbi5qb2IpICYm
ICFzaG91bGRfY29tcGxldGUpIHsKICAgICAgICAgICAgIGRlbGF5X25zID0gKHMtPmluX2ZsaWdo
dCA9PSAwICYmCiAgICAgICAgICAgICAgICAgICAgICAgICBjbnQgPT0gMCA/IEJMT0NLX0pPQl9T
TElDRV9USU1FIDogMCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvam9iLmggYi9pbmNsdWRl
L3FlbXUvam9iLmgKaW5kZXggZTUwMjc4N2RkLi44N2RiZWYwZDIgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvcWVtdS9qb2IuaAorKysgYi9pbmNsdWRlL3FlbXUvam9iLmgKQEAgLTY0MSw2ICs2NDEsMTIg
QEAgaW50IGpvYl9hcHBseV92ZXJiX2xvY2tlZChKb2IgKmpvYiwgSm9iVmVyYiB2ZXJiLCBFcnJv
ciAqKmVycnApOwogICovCiB2b2lkIGpvYl9lYXJseV9mYWlsKEpvYiAqam9iKTsKIAorLyoqCisg
KiBNb3ZlcyB0aGUgQGpvYiBmcm9tIFJVTk5JTkcgdG8gUkVBRFkuCisgKiBDYWxsZWQgd2l0aCBq
b2JfbXV0ZXggKm5vdCogaGVsZC4KKyAqLwordm9pZCBqb2JfdHJhbnNpdGlvbl90b19ydW5uaW5n
KEpvYiAqam9iKTsKKwogLyoqCiAgKiBNb3ZlcyB0aGUgQGpvYiBmcm9tIFJVTk5JTkcgdG8gUkVB
RFkuCiAgKiBDYWxsZWQgd2l0aCBqb2JfbXV0ZXggKm5vdCogaGVsZC4KZGlmZiAtLWdpdCBhL2pv
Yi5jIGIvam9iLmMKaW5kZXggNzJkNTdmMDkzLi4yOThkOTA4MTcgMTAwNjQ0Ci0tLSBhL2pvYi5j
CisrKyBiL2pvYi5jCkBAIC02Miw3ICs2Miw3IEBAIGJvb2wgSm9iU1RUW0pPQl9TVEFUVVNfX01B
WF1bSk9CX1NUQVRVU19fTUFYXSA9IHsKICAgICAvKiBDOiAqLyBbSk9CX1NUQVRVU19DUkVBVEVE
XSAgID0gezAsIDAsIDEsIDAsIDAsIDAsIDAsIDAsIDEsIDAsIDF9LAogICAgIC8qIFI6ICovIFtK
T0JfU1RBVFVTX1JVTk5JTkddICAgPSB7MCwgMCwgMCwgMSwgMSwgMCwgMSwgMCwgMSwgMCwgMH0s
CiAgICAgLyogUDogKi8gW0pPQl9TVEFUVVNfUEFVU0VEXSAgICA9IHswLCAwLCAxLCAwLCAwLCAw
LCAwLCAwLCAwLCAwLCAwfSwKLSAgICAvKiBZOiAqLyBbSk9CX1NUQVRVU19SRUFEWV0gICAgID0g
ezAsIDAsIDAsIDAsIDAsIDEsIDEsIDAsIDEsIDAsIDB9LAorICAgIC8qIFk6ICovIFtKT0JfU1RB
VFVTX1JFQURZXSAgICAgPSB7MCwgMCwgMSwgMCwgMCwgMSwgMSwgMCwgMSwgMCwgMH0sCiAgICAg
LyogUzogKi8gW0pPQl9TVEFUVVNfU1RBTkRCWV0gICA9IHswLCAwLCAwLCAwLCAxLCAwLCAwLCAw
LCAwLCAwLCAwfSwKICAgICAvKiBXOiAqLyBbSk9CX1NUQVRVU19XQUlUSU5HXSAgID0gezAsIDAs
IDAsIDAsIDAsIDAsIDAsIDEsIDEsIDAsIDB9LAogICAgIC8qIEQ6ICovIFtKT0JfU1RBVFVTX1BF
TkRJTkddICAgPSB7MCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwgMSwgMSwgMH0sCkBAIC0xMDM1LDYg
KzEwMzUsMTIgQEAgc3RhdGljIGludCBqb2JfdHJhbnNpdGlvbl90b19wZW5kaW5nX2xvY2tlZChK
b2IgKmpvYikKICAgICByZXR1cm4gMDsKIH0KIAordm9pZCBqb2JfdHJhbnNpdGlvbl90b19ydW5u
aW5nKEpvYiAqam9iKQoreworICAgIEpPQl9MT0NLX0dVQVJEKCk7CisgICAgam9iX3N0YXRlX3Ry
YW5zaXRpb25fbG9ja2VkKGpvYiwgSk9CX1NUQVRVU19SVU5OSU5HKTsKK30KKwogdm9pZCBqb2Jf
dHJhbnNpdGlvbl90b19yZWFkeShKb2IgKmpvYikKIHsKICAgICBKT0JfTE9DS19HVUFSRCgpOwo=

--_002_ACB0E3E9BA694EC7A4EB3AF2F21D4C8Aakamaicom_--

