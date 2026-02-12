Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A99EEDF052
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRMw-00020y-5z; Thu, 12 Feb 2026 02:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqRMt-00020T-QH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:44:07 -0500
Received: from smtppost.atos.net ([193.56.114.177] helo=smarthost4.atos.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqRMr-0005Fw-3x
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770882245; x=1802418245;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=s3rTPHBPJNdZpesE6SpmN08sfwQIa3T7hMDE9/8Sk3U=;
 b=dsJnrxE0grEMHO/u3sIaIe98KftW/c/CyE3bOwTL5TUbXl8DKU2cKATh
 NqLiwIx7X1j3jdo/7llA34gxGaHMaqkAqWIRe1DySsWeAWW54AnMYlOsQ
 bK1NE+OLbIfDr6EQXIRX2cp+fprDKD5mkKZPQp35b5Y6W4sgBQiE/GaZn
 hfpc3a7AUlRYydH+94I6AWhxTZTnKZDKRUvN1T7ed9rWnDMrpppbyY82O
 is6YpFYTqRCXZGPW6BabhdTlTV3UoEVRyivR5J49x93L4dM40e/t8Ira6
 n/GPl2XaRSifnMzkOtzz+GxJcXz/pubnUBTm8geWucOEO/YbZzY+PHEEn Q==;
X-CSE-ConnectionGUID: i4cK12JUTyaVzge8q80Xpg==
X-CSE-MsgGUID: 3kpPCJu2T1yTxK9KErN4cg==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; d="scan'208";a="825722408"
X-MGA-submission: =?us-ascii?q?MDH7N1a44JDa6CvSJ+huGrZr7Sf8EEGFbmWR+f?=
 =?us-ascii?q?VfvT+zMwbGlJbCAxMjPg8W0vcrqdizdcUkLDWNfkCnoIt9/Z3m+L1v6X?=
 =?us-ascii?q?+ducFUJ1aHRSogaiIyQ1I63+yqbjU5TiArgfJMzFSGdiFLraXo/AP3ma?=
 =?us-ascii?q?A5?=
Received: from smtp1.atos-infogerance.fr ([193.56.241.17])
 by smarthost4.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Feb 2026 08:44:00 +0100
Received: from smtp-hub.atos-infogerance.fr (smtp-hub.atos-infogerance.fr
 [193.56.47.18])
 by smtp1.atos-infogerance.fr (8.15.2/8.15.2) with ESMTPS id 61C7hx5Y026715
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 12 Feb 2026 08:43:59 +0100
Received: from rocky.hd2c.dom ([129.181.244.14])
 by smtp-hub.atos-infogerance.fr (envelope-from
 clement.mathieu--drif@eviden.com) (8.15.2/8.15.2) with ESMTP id
 61C7hxJY038576; Thu, 12 Feb 2026 08:43:59 +0100
Received: from openbmc (unknown [10.22.85.22])
 by rocky.hd2c.dom (Postfix) with ESMTP id 3A908256CA5;
 Thu, 12 Feb 2026 08:43:59 +0100 (CET)
Received: from [127.0.0.1] (host.containers.internal [10.88.0.1])
 by openbmc (Postfix) with ESMTP id 745E98104811;
 Thu, 12 Feb 2026 07:43:58 +0000 (UTC)
Message-ID: <669e9b9b6fe10f797d8d9571c7327c8a5617ae3f.camel@eviden.com>
Subject: Re: [RFC PATCH 04/14] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, xudong.hao@intel.com
Date: Thu, 12 Feb 2026 08:43:37 +0100
In-Reply-To: <20260205031133.74357-5-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Received-SPF: pass client-ip=193.56.114.177;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.atos.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Ck9uIFdlZCwgMjAyNi0wMi0wNCBhdCAyMjoxMSAtMDUwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6
Cj4gV2hlbiBwYXNpZCBpcyBlbmFibGVkLCBhbnkgaHdwdCBhdHRhY2hlZCB0byBub24tUEFTSUQg
b3IgUEFTSUQgc2hvdWxkIGJlICAKPiBJT01NVV9IV1BUX0FMTE9DX1BBU0lEIGZsYWdnZWQsIG9y
IGVsc2UgYXR0YWNobWVudCBmYWlscy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVs
LmNvbSk+ICAKPiAtLS0gIAo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHwgMTAgKysr
KysrLS0tLSAgCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIAo+IGluZGV4IDY3ZDU0ODQ5ZjIuLmQ2MWNmZWMxZTYg
MTAwNjQ0ICAKPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIAo+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgCj4gQEAgLTY5LDExICs2OSwxMyBAQCBWVERIb3N0
SU9NTVVEZXZpY2UgKnZ0ZF9maW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNzU3BhY2UgKmFzKSAg
Cj4gwqDCoMKgwqAgcmV0dXJuIE5VTEw7ICAKPiDCoH0gIAo+IMKgICAKPiAtc3RhdGljIGJvb2wg
dnRkX2NyZWF0ZV9mc19od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsICAKPiArc3Rh
dGljIGJvb2wgdnRkX2NyZWF0ZV9mc19od3B0KFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Qs
ICAKCkRvZXMgdGhpcyBjaGFuZ2UgYnJlYWsgbmFtaW5nIGNvbnNpc3RlbmN5PwoKT3RoZXIgZnVu
Y3Rpb25zIHVzZSB1c2UgaWRldiBmb3IgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCBzdHJ1Y3R1cmVz
Cgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFZURFBBU0lERW50cnkgKnBlLCB1aW50MzJfdCAqZnNfaHdwdF9pZCwgIAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEVycm9yICoqZXJycCkgIAo+IMKgeyAgCj4gK8KgwqDCoCBIb3N0SU9NTVVEZXZpY2VJT01N
VUZEICppZGV2ID0gSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2dGRfaGlvZC0+aGlvZCk7ICAK
PiDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfaHdwdF92dGRfczEgdnRkID0ge307ICAKPiArwqDCoMKg
IHVpbnQzMl90IGZsYWdzID0gdnRkX2hpb2QtPmlvbW11X3N0YXRlLT5wYXNpZCA/IElPTU1VX0hX
UFRfQUxMT0NfUEFTSUQgOiAwOyAgCj4gwqAgIAo+IMKgwqDCoMKgIHZ0ZC5mbGFncyA9IChWVERf
U01fUEFTSURfRU5UUllfU1JFKHBlKSA/IElPTU1VX1ZURF9TMV9TUkUgOiAwKSB8ICAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoVlREX1NNX1BBU0lEX0VOVFJZX1dQRShwZSkg
PyBJT01NVV9WVERfUzFfV1BFIDogMCkgfCAgCj4gQEAgLTgyLDggKzg0LDggQEAgc3RhdGljIGJv
b2wgdnRkX2NyZWF0ZV9mc19od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsICAKPiDC
oMKgwqDCoCB2dGQucGd0YmxfYWRkciA9ICh1aW50NjRfdCl2dGRfcGVfZ2V0X2ZzcHRfYmFzZShw
ZSk7ICAKPiDCoCAgCj4gwqDCoMKgwqAgcmV0dXJuIGlvbW11ZmRfYmFja2VuZF9hbGxvY19od3B0
KGlkZXYtPmlvbW11ZmQsIGlkZXYtPmRldmlkLCBpZGV2LT5od3B0X2lkLCAgCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDAsIElPTU1VX0hXUFRfREFUQV9WVERfUzEsIHNpemVvZih2dGQpLCAgCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZ2dGQsIGZzX2h3cHRfaWQsIGVycnApOyAgCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZsYWdzLCBJT01NVV9IV1BUX0RBVEFfVlREX1MxLCAgCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemVvZih2dGQpLCAmdnRkLCBmc19od3B0X2lkLCBlcnJwKTsgIAo+IMKgfSAgCj4gwqAg
IAo+IMKgc3RhdGljIHZvaWQgdnRkX2Rlc3Ryb3lfb2xkX2ZzX2h3cHQoSG9zdElPTU1VRGV2aWNl
SU9NTVVGRCAqaWRldiwgIAo+IEBAIC0xMTYsNyArMTE4LDcgQEAgc3RhdGljIGJvb2wgdnRkX2Rl
dmljZV9hdHRhY2hfaW9tbXVmZChWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLCAgCj4gwqDC
oMKgwqAgfSAgCj4gwqAgIAo+IMKgwqDCoMKgIGlmICh2dGRfcGVfcGd0dF9pc19mc3QocGUpKSB7
ICAKPiAtwqDCoMKgwqDCoMKgwqAgaWYgKCF2dGRfY3JlYXRlX2ZzX2h3cHQoaWRldiwgcGUsICZo
d3B0X2lkLCBlcnJwKSkgeyAgCj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdnRkX2NyZWF0ZV9mc19o
d3B0KHZ0ZF9oaW9kLCBwZSwgJmh3cHRfaWQsIGVycnApKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGZhbHNlOyAgCj4gwqDCoMKgwqDCoMKgwqDCoCB9ICAKPiDCoMKgwqDC
oCB9Cg==


