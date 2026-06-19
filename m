Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40CCCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBN-0001bJ-0V; Fri, 19 Jun 2026 18:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBL-0001aX-06
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBJ-0001VP-AO
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYi3D2934914
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=; b=NxRhyO5G8+07tuRN
 Kcxwxw4trvNw1LtLi3iwoAC/PV4D37DYrZTdERMyt6NdLtQKutoZyQPsCfx+TqBV
 ZX13R2O6Palcq4vVz4Uvhp8qI9sCP3lIGqR1ThNMhpkllkpa1OWt4k3T7hjvoYK6
 1EF7FXxJxWu9IIh4kK/vdEhq60Jod3a8GrHztjU9cHc77SKA3WxDrdzmqay3nPOi
 g7t98noqWZWtM6ZGCkOWM1ivM65NNsnFwJLIrRJCWbv80M8iubUgFwSEFRtatFXw
 cMGW+yw+qLgq4KjKy0UWCymQa2Ud4h9LcVF0uo/q8zKw6bQbk13ApX5SU3RMarLW
 y3QgaA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qsa2v5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so530227eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909963; x=1782514763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=BBhxgKRzHQ9Zv1V/SRWmXJy0bE/lgmdl8OEfLWLVo9VYY8h+USXA6ZlMRJhbiv9AEk
 jr4KYvf4YbnOPX1mBM67L/ISB29kDwtMy8/j+Y48mlYE9GxzdsO3zYClUC30JYF2UOYE
 5qYohbZE6PqIn3tZIYaOmLOOzc5YnMse1NgifKbiq94tb4OpwECnWxD6JII2geVAHiwd
 O8+Frxq5uMF5zCgNRrDILVHia2WN204ivhuOEQhj1C+vHEAgm2sH1vmzkLcJUKoStqRy
 5lb3fFXZ4kBaSb1WySlTBv0WjSS2unj6fdxHllyJ9X6pjCE7zfQHkJJfBZGmfaH6oPcs
 Ufhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909963; x=1782514763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=cGLKedYzuSD0gVO6mHrwbFMy33jdesdvCiQkRf7r2FhiLeHDiMk4UWKOiBMh5OJxv2
 1LGIWGAUtt0d7Ro6Y4+xE1/H57vhiTX7ZpngbGBZey0Qsmied06wukbyHT42TATUEumT
 xC4isJGehH4Cq8ihSa4YImpV2bTfTeX9w8kTQXX0ZbzrbMFkq/kUvm2H6z+tTre9TZW2
 XVRjdS1tETlegFiVC/wUWdS8guy+91iT4yYzpjjV7G+6cYV7fM6QBvAL7Ppi4Yb8y0cQ
 ExWg/6ozH7hb4FQTxHNq/i29HyXECWfbkt8R83OT9oQJNfTPHVV36FBAyqWk9UeVb8Sx
 IGyA==
X-Gm-Message-State: AOJu0YydKSxIRXFSknX3mjCZgRuIoqBnUPxmYxdMCoHA/DGhRUnXaMHt
 611hxk4ERFQAmx3SUPm1eSNH/0MNJqMxThymtfE65BG4EC9nAHgUpkPYkjdET6GIZMV2cgntzUT
 bxixsfmZCmdCbKX6+NrYfGirmn2kkRK2FbCkNNcToWwCDdbsorM0QQYA5wsnmCUZj0g==
X-Gm-Gg: AfdE7cnLlUi4M/Gvq6GC9YA4sp1Wy2DOUyh89+EVdLImX8ysSvlIhvkUWYDn3RI4nKH
 LIObH+ArTgdYnS0yOU5yB5bjMYB4yD323JYSvqZDpr4h6MYVQnRcpcA9g95QpUdfMvm6N5gUEAg
 eTmXqJuIuNcm+AkRgIsYFZ4IWRsW8/zsIlkUK1pME9m2STMU3Z+WoGr3QNeEhG+jbKA+2v7VUvR
 nzx75agShGuKxphO0TY3Rxsde6neJvli5nHduISHWZ3RdAbAeYClw4DddpPcMmqfDAffczfXOJM
 DUXlHdPhAGRqh6+soP+d3FJgn5ktlfeMDwJqRHgxJ00kCaGFwyUEx0uczl6N1rVTtTXouJ9NLys
 kGiAW05jWPevNmz7jgQZmITAbDXIUVbFhYBsX4OtlUhTDzAYasIhptm0LARg=
X-Received: by 2002:a05:7300:1905:b0:30b:f4e3:a2b0 with SMTP id
 5a478bee46e88-30c07156f4amr3411311eec.21.1781909963325; 
 Fri, 19 Jun 2026 15:59:23 -0700 (PDT)
X-Received: by 2002:a05:7300:1905:b0:30b:f4e3:a2b0 with SMTP id
 5a478bee46e88-30c07156f4amr3411295eec.21.1781909962805; 
 Fri, 19 Jun 2026 15:59:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/74] target/hexagon: Suppress unused-variable warnings for
 sysemu source regs
Date: Fri, 19 Jun 2026 15:58:03 -0700
Message-Id: <20260619225911.159473-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX97FvwIy3Mrek
 taG8g26VxlZH/EFINKu5CTojJV7dR4+lnU0r6vUogOGKWStLLnqof4FwVGkXnH+8m/eGubMlUcW
 enQll1Lkjha7JxmznQ+2Jxb7GYPn4fdkZvFeYtOT4fH3yQAplIR7ZWVmRMXNeszTDwBnzZ9VRcv
 DhVTcKFDaBRxREwy+UZW2+7hwAnO2OZxMZpY1KSFJHZKQocUe9vChi/mp130Lzy6ovnzvOXDjCc
 D09HKmGgWKZ8xkKnzjZkF0cqzqffnVBCjNaq2JVoUxDNZZZHhj8bFy8hubo+CCAJopSdfkizZnM
 sB/vf4budIHWaC1es4wuTImpFq5Nu0Hk6LzawRKIrgZsUwAreO7roXu2kFLTSLmryvC1Rj67vuh
 X7YLeIXSbz4Lxc2O1VLxjo4T1vIw0Nt1/nVVOxAKsiwGtM4ErK3FwTh/0AqRHv4JoJpVyISBN5E
 OMZJyRpaY+o8OC35ZmA==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35c9cb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: TsNaOJtf8pIuBcizOTPszIcD1ye1e1bk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXyD2PxEM2tFpo
 UYhpTPrtqPlFlfi4oS+G5G0oX726eHT+06K2IQpv6YqNExWieKGGwJaO6EZBVqlhR4+ux3jrHwp
 +3znkNw2qrqUpOvuqgwGbGJVtPDnUbU=
X-Proofpoint-GUID: TsNaOJtf8pIuBcizOTPszIcD1ye1e1bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

VGhlIGFuYWx5emVfcmVhZCgpIG1ldGhvZHMgb24gR3Vlc3RTb3VyY2UsIEd1ZXN0UGFpclNvdXJj
ZSwKU3lzdGVtU291cmNlLCBhbmQgU3lzdGVtUGFpclNvdXJjZSB3ZXJlIG5vLW9wcyBiZWNhdXNl
IHRoZXNlCnNvdXJjZSByZWdpc3RlcnMgZG8gbm90IG5lZWQgcmVhZC10cmFja2luZyBpbiB0aGUg
YW5hbHl6ZSBwaGFzZS4KSG93ZXZlciwgZ2VuX2FuYWx5emVfZnVuY3MucHkgdW5jb25kaXRpb25h
bGx5IGRlY2xhcmVzIHRoZQpyZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgKGUuZy4gR3NOKSB2aWEg
ZGVjbF9yZWdfbnVtKCkgZm9yIGFsbApyZWdpc3RlcnMgdGhhdCBhcmUgcmVhZCBvciB3cml0dGVu
LiAgV2hlbiBidWlsZGluZyB3aXRoCmhleGFnb24tc29mdG1tdSwgdGhlIGdlbmVyYXRlZCBhbmFs
eXplIGZ1bmN0aW9uIGJvZGllcyBhcmUKY29tcGlsZWQgKG91dHNpZGUgdGhlICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWSBndWFyZCksIGFuZCB0aGUKZGVjbGFyZWQtYnV0LXVucmVmZXJlbmNlZCBy
ZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgdHJpZ2dlcnMKLVdlcnJvcj11bnVzZWQtdmFyaWFibGUg
dW5kZXIgYm90aCBnY2MgYW5kIGNsYW5nLgoKT3ZlcnJpZGUgZGVjbF9yZWdfbnVtKCkgaW4gZWFj
aCBjbGFzcyB0byBkZWNsYXJlIHRoZSByZWdpc3RlciBudW1iZXIgd2l0aApHX0dOVUNfVU5VU0VE
LCBzdXBwcmVzc2luZyB0aGUgd2FybmluZy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkKaW5kZXggNzk0MzZlZTI5ZDcuLmRmOGQzYmE2NTg2IDEwMDc1NQot
LS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkKQEAgLTEwNjgsNiArMTA2OCwxMCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxm
LCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RTb3VyY2UoR3Vl
c3RSZWdpc3RlciwgU2luZ2xlLCBPbGRTb3VyY2UpOgorICAgIGRlZiBkZWNsX3JlZ19udW0oc2Vs
ZiwgZiwgcmVnbm8pOgorICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAg
ICBjb25zdCBpbnQge3NlbGYucmVnX251bX0gR19HTlVDX1VOVVNFRCA9IGluc24tPnJlZ25vW3ty
ZWdub31dOworICAgICAgICAiIiIpKQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJl
Z25vKToKICAgICAgICAgc2VsZi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKQEAgLTEwOTMsNiArMTA5NywxMCBAQCBkZWYgYW5hbHl6ZV93cml0
ZShzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RQYWly
U291cmNlKEd1ZXN0UmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRlY2xfcmVn
X251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAg
ICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0gaW5zbi0+
cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYs
IHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykKICAgICAg
ICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXApAQCAtMTExOCw2ICsxMTI2LDEwIEBAIGRlZiBhbmFs
eXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIpKQogCiBjbGFzcyBT
eXN0ZW1Tb3VyY2UoUmVnaXN0ZXIsIFNpbmdsZSwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9y
ZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAor
ICAgICAgICAgICAgY29uc3QgaW50IHtzZWxmLnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNu
LT5yZWdub1t7cmVnbm99XTsKKyAgICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwg
ZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAg
ICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCkBAIC0xMTQzLDYgKzExNTUsMTAgQEAgZGVmIGFu
YWx5emVfd3JpdGUoc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgICIiIikpCiAKIGNsYXNz
IFN5c3RlbVBhaXJTb3VyY2UoUmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRl
Y2xfcmVnX251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIi
IlwKKyAgICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0g
aW5zbi0+cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNl
bGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykK
ICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAotLSAKMi4zNC4xCgo=

