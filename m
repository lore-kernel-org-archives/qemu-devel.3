Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A42CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzK-00080g-Mb; Thu, 11 Jun 2026 01:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzI-0007zJ-RP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzH-0000sY-2H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GBG83815511
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZqIR3vZ/lGQxDGirR81dOcdlf60RbF5IZkfFkhelc7U=; b=MMZck3MQpG/60Dpp
 NZ3yelZtXzOfE1wZwi7MLTql8ZZrD2bVtP79x4wzh5yK8+f02j0FGVf2T4mEpnZG
 haEG/PElHAaiKiSzGmlvzpHogLYjIBNZxSZlyesQRHzfG3502qszpdhzyr9Kc3Zd
 GOhZQ3hbrMNYCbtnx89OydstXch0mAonp60mEGQoBDCEXtTGzSz2rpy9n24tVQu/
 5HdZoXuwWkCrdhEzqpscxvsG/5OBskkNXKh/E+NWytW0KQx96u92nfMA3wTLxwfa
 HAS/GiRDfwEKkVK6rRjaapKo1jiRAEGY3cR1P+aXRpuMHHHNHJYWuCBQsKW0/roC
 evKFeQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1rrk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304c652be4eso425833eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155783; x=1781760583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqIR3vZ/lGQxDGirR81dOcdlf60RbF5IZkfFkhelc7U=;
 b=IGat3eqWCkLtzn76H+dnVvAba78fxrXQN3hi7g09NPhARvwPCXOJnqW38BmH3yjZeg
 itNjJgzcMj68jhnR33cSn/G9c7i/AXhgIKZ2LctRHi14YgxsGa06PFFnr9rL2ALD10sQ
 MnlRqiPg+YfQhDnfU23jiy/f9DDpYAXjE7OO0iEKZlw9gnbEQipi48+XaS5Do4kgah8A
 BOuNruvzPs/7jmyPkIABbvKw/6ztNK2Ne1RFz+KYppEXYA0e81zrwNgUffDsSqpYc1G/
 PXQ1q0Ur32adk2avTs+sfwArs/U20mXphw+CpdIFXlJkMZb7fouMW7l2iq5rq2WFUSbV
 w1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155783; x=1781760583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZqIR3vZ/lGQxDGirR81dOcdlf60RbF5IZkfFkhelc7U=;
 b=hF48BtXWioBbbEJDSrV/Hmcyu26BYnOlm02/Mhk7SfW3OPhEZEUvr7s4pGDGXhx+Ms
 Q96yaGTF8UjDBwtwQu7qfkK+LcDM6UbwWwEvn3j0QY431N6eCN7kULYOkwqzVIpA8dpB
 UPJOnbv/4U95WYopkBTcgd+b9VRlBiQ8CUPwil1ASvm0tvIMDJ3iyoKa1poXw5D0tW9V
 0mINb5uDGikjwd0Z0HGHF1+tkipPdOUzvfwbZIS/BcQKT4+8Lta11W8ssjJ/jhXCkM5g
 zR/jY5ZId7wvrnujprzYKOZIrixrWZZhbU2VnAT1XnPOH8aswEjKJKGJcXyLHuXOtdiO
 5tXw==
X-Gm-Message-State: AOJu0YxOtA5LKurrb/cA72Sig2BndJ/cwffocSZs631cn4Syrvfb5Qnc
 ogXG5xhMwHaG7EUO0L58M/q9fYsfsl7N+qP+05xg+TexhlvNQm+9AwsOMkfAvw1c29F5XmvxDnS
 46Y0sXL2akJFAATVWdEGC9ogPz/Y1AMm7rPubbM8NPm5PS73lOV3YZd5jUYbPJ00+Yw==
X-Gm-Gg: Acq92OG08Hh924ttjnBjq09tOoy4mn5/IHjvd+yWyAGkYOGKxFmW4lvOXrGqBRySKlp
 FjAYE6oEnncWhDolpQfbQ/eh8QCTzt5HGtw8Js22v07W8BbMe5Vb28knbB3nukYchmNHhTG4ZYP
 vdYCbQeekSodX10mwbW5uiZt4cHw5zrS1XSAGpxXgcPyn/6qCEP75YFJtXIWL+ZnRKEdhd7lqtu
 EVTkoer6MZifDQdqnZuykouefbyzbZ92AkGYiK+muqtmcaOLtGlLewdVhVsm9OeNUFm5P6JOUd+
 jNwjuib86nOumXBpj+bPEPWI787bAWLE7CUrDlfVlPKoDNKeEIe7DHiQQOdqgEuPB9WZ5Bwt7d6
 moFGRjvw86zDBw5T/rd5VtiZa/QPHNHqwtTPUqnEVJCVpOwE3IYGYvkzvAH5U41QEIxjfo6Gspz
 vD34X6
X-Received: by 2002:a05:7022:4393:b0:138:4021:b20a with SMTP id
 a92af1059eb24-13842e25a0emr763418c88.3.1781155782999; 
 Wed, 10 Jun 2026 22:29:42 -0700 (PDT)
X-Received: by 2002:a05:7022:4393:b0:138:4021:b20a with SMTP id
 a92af1059eb24-13842e25a0emr763394c88.3.1781155782399; 
 Wed, 10 Jun 2026 22:29:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add TCG overrides for int handler insts
Date: Wed, 10 Jun 2026 22:28:46 -0700
Message-Id: <20260611052857.3911981-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UtT12XPqsoYWtIU9OZX8J6HLfcwdC2vM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX75Dh9nrklnfV
 dUfNLjBC73jGvhmuPb63kwlsaovtEfjL6ilRaaTEPYVHP4whiIlJ4RJ7eW0JbGXGeT41NYQ+ieU
 CxrGDd202YwnRdjIcM8TA2Cd3gnn2Vc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX43TSTe25rnmx
 bHda4K73WBDHqsOA48MHYR9Kw8qnskA+ZADEiF1GFUaY5xYxwuf3eXpiGZB9v4IvhfPAGfUwSDb
 +52lueWcasENgjllrv+nF4KCwZEGHv8V1djO7GoU7dWVDkGfMLyTY8ij9SKVcbLz+PRvA7iPhR6
 zdHvnLHGDwHBoKjwzQff59k+YdzmxM/3y/dPK2lWFbL+Ur981y+l1CiIFXGn3iOnekY33aBGF5G
 hTGi/kTFcK3H/TwLcmmT3nrSTYMbYtX8oJ2zD+sSXQhKDdxVSr49vSM7WN6Yx5I7xD8b3sevJe1
 SqOMP/CqaQiHRKmcqy3j8K/s9dXQQ8rAq/p9OmO5KncsWy7EpFyxT9axVZawtnje4bdO7XuSDP7
 ewbNTGqAWsbTDj+McZJxTcUyUqxWGvJzHQ+E6MYcXNJBe9vhP/KQHcuga3JSr9A1vX1pjoM/HpD
 qFUs0HOIODjL/kwUi0Q==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a47c7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UtT12XPqsoYWtIU9OZX8J6HLfcwdC2vM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Ige2MsfXN3aSB7YyxzfWlhZCwgaWFzc2lnbntyLHd9LCB7cyxnfWV0aW1hc2sKaW5zdHJ1
Y3Rpb25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICB8ICA4ICsrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19zeXMuaAppbmRleCBmNzhjOTYzNWMzZi4uNGNiYmRkMWY3MGIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMu
aApAQCAtNyw2ICs3LDMxIEBACiAjaWZuZGVmIEhFWEFHT05fR0VOX1RDR19TWVNfSAogI2RlZmlu
ZSBIRVhBR09OX0dFTl9UQ0dfU1lTX0gKIAorLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rpb25zICov
CisjZGVmaW5lIGZHRU5fVENHX1kyX3N3aShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3N3
aSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfY3N3aShTSE9SVENPREUpIFwK
KyAgICBnZW5faGVscGVyX2Nzd2kodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1ky
X2NpYWQoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9jaWFkKHRjZ19lbnYsIFJzVikKKwor
I2RlZmluZSBmR0VOX1RDR19ZNF9zaWFkKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2lh
ZCh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWFzc2lnbncoU0hPUlRDT0RF
KSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWdudyh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdF
Tl9UQ0dfWTJfaWFzc2lnbnIoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWducihS
ZFYsIHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9nZXRpbWFzayhTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX2dldGltYXNrKFJkViwgdGNnX2VudiwgUnNWKQorCisjZGVm
aW5lIGZHRU5fVENHX1kyX3NldGltYXNrKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2V0
aW1hc2sodGNnX2VudiwgUHRWLCBSc1YpCisKICNkZWZpbmUgZkdFTl9UQ0dfWTJfc2V0cHJpbyhT
SE9SVENPREUpIFwKICAgICBnZW5faGVscGVyX3NldHByaW8odGNnX2VudiwgUHRWLCBSc1YpCiAK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggNTQwNTM0MmY3OTguLjk1NTI4NzEzM2U0IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTA5LDYg
KzEwOSwxNCBAQCBERUZfSEVMUEVSXzIocHJvYmVfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBpbnQp
CiBERUZfSEVMUEVSXzIocHJvYmVfcGt0X3NjYWxhcl9odnhfc3RvcmVzLCB2b2lkLCBlbnYsIGlu
dCkKIAogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitERUZfSEVMUEVSXzIoc3dpLCB2
b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihjc3dpLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9I
RUxQRVJfMihjaWFkLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzaWFkLCB2b2lkLCBl
bnYsIGkzMikKK0RFRl9IRUxQRVJfMihpYXNzaWdudywgdm9pZCwgZW52LCBpMzIpCitERUZfSEVM
UEVSXzIoaWFzc2lnbnIsIGkzMiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoZ2V0aW1hc2ssIGkz
MiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzMoc2V0aW1hc2ssIHZvaWQsIGVudiwgaTMyLCBpMzIp
CiBERUZfSEVMUEVSXzIoc3JlZ19yZWFkLCBpMzIsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHNy
ZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKGdyZWdfcmVhZCwgaTMy
LCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggZWQ0MzI1OGNkOTEuLmVlMjgyZTY2ZTg2IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYwpAQCAtMTM4OSw2ICsxMzg5LDQ2IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEy
OHFtKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50MzJfdCB1aVYpCiB9CiAKICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQordm9pZCBIRUxQRVIoY2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBI
RUxQRVIoc2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCit7CisgICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihjc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
bWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUihp
YXNzaWdudykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKK3sKKyAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKK30KKwordWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3QgdGlkKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHNldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkLCB1
aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB2b2lk
IEhFTFBFUihzcmVnX3dyaXRlX21hc2tlZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZywgdWludDMyX3QgdmFsKQogewogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoy
LjM0LjEKCg==

