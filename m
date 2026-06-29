Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904F7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3e6-0003bG-EW; Mon, 29 Jun 2026 00:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3de-0002vB-Nj
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dc-0001Pm-Qb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NH4O1754328
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=; b=UIRZC64IkfSi8nZx
 WAdK+rO9l3vllWnpHvDHJCRZJzvrlkOjls+4xdQLJwk+UHYqQ2tJcmoqLgpVkbhh
 xZ9BWIDRlk49JN/e7gBTyCyr4D1+8J5JQQNzNsjQaB0dome9Fi/v9xyj/HEPKiGp
 bsV7iNJpQjyzwUDtVlpNIFhEXsc7oOh4o60bu8EPbZolgEFqXaPJpodmlKcV5OsZ
 Jc1kOlaHbQ75dhXczYdXMQmHVe7U8shpS75WZJe5Sw2m7AVl9NfPppcFf9N88Xc6
 w8LqwWwAkyjE5CKu3y1KTlCfD5tZyZ8bQXYUo2A4SUGVXpgkmNJEDMHSdnaX0X92
 ErJaMg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27334fc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:15 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139fe708181so1207064c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707414; x=1783312214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=SNYAEqTSa4VZ/G/QzCxB4r/xpjBzKBSOoNf99zFOwNrpAfa6H3RQedS/EBdThtDBMA
 NujOhRPNS93c/IESh3yUd60R9Q4e66C76Wb5fM0VGKaBN9fT/krxuqe18oGC/g6t7/u5
 +06ZQuNZb4DdB7SBmS7/5WLt77nX1O4S/iltIIiU62AHDLFo2rxAWVsm4pBJM06WcGB0
 thElgquHn5Z2XMyotThqd5gy1RZ3SSWlTc2J1o+MVWrgfmqsbBILMU/Qmxmd31xdBOWR
 Pv+BU6HnxtLZeb7q59Yn90wfjv9HwarRQOiKaIHzcnyJ9gDJAUfuB7g60mLwfpS6eocC
 /B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707414; x=1783312214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ECOxl3Fg5yOtnmQVv6BfaD55uXykPkSbZivFHhIDWY=;
 b=hm7RV45IR1EtXZmuZqUveLuoQVOmR+We2DXXibBBgaOxSoi7sDYgYfs6JE/kAnw8OC
 UU2hgPijrbZYUGREu8wk0AUyUIe44gj505cdeevO6Dmu+qNMwotRIh7btIGmkLQSXGnD
 5jQ9ckcVsVhFRKTHo+XL+kMIP3WifVrKoVC2VTlWVrKwgCguE/Qb06RL8hKI0bzcal9F
 aq1p3b/D1gNucv1Qp6ZXSseUTlAbzUXf8KBgKF0xKxj7TnaArTdOCYAIv1zihzLosQ8a
 OXhqrK49dUUrA4ljxn/K4MwRzEE+1QmthP7WrrwFIPwdFhTVtd5WqifURlIIlIGnigA7
 ki/g==
X-Gm-Message-State: AOJu0Yz+hTNY04G9dUfW7uwqwEr41JpgK4b63jg1r1q5M8xkwWyhWaz0
 SOHw1rTp3hmYlXW2bYRx+Pdoj7cq+gmWs+155diqcNAtXGtCWwPtYjpIbZ2/pJP21J4Vcbbv3Pk
 Vt7f/S1K4c4udqx0eSJ4xuodVB/e2JmZgkwqkqxew4mlOLB0TEoTbWTlWB/u3JXhBmQ==
X-Gm-Gg: AfdE7clndwvE4ShLar1RXqJQ/9IokblAEkoDhXzK8Ckc6SxsfkDTHMvZOlEpnbJX+Zd
 ndeoGAfJB4IITabOsUuS+cED18OYiief9iEu5ecm2szcAgI8RdYd8PH4DeVY1Z0wO9GiXpqbQ/K
 f66HRTfwcDuX0HDc+7fI6IfxvPlMZx/zu3Wg/MIozNF1tF5ufgq2G709wVEhgGsWlhTSYRXX9Jo
 bkARUY7OxHmaPx/1/e3/f+ljrymK1uscz4UaAYAWbnrpHLEqf7m6lj8XFtSuK70DtC6mRCOxpl2
 WSbP3L5tMPQ2YBmJbFNExKASzKQHvawC/ltiJIcjCMjVBuagfAu227oeHoYRZIkZvRY9p1306rj
 nzq8ZWnUkmYIPuYKvw5/rn77Ngg1IOiDECXX8/pvoYBLwM2RLX70NNgBLh60=
X-Received: by 2002:a05:7022:f694:b0:138:637:6227 with SMTP id
 a92af1059eb24-139dba0a865mr15071038c88.11.1782707414259; 
 Sun, 28 Jun 2026 21:30:14 -0700 (PDT)
X-Received: by 2002:a05:7022:f694:b0:138:637:6227 with SMTP id
 a92af1059eb24-139dba0a865mr15071008c88.11.1782707413738; 
 Sun, 28 Jun 2026 21:30:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 66/77] target/hexagon: Add TCG overrides for transfer insts
Date: Sun, 28 Jun 2026 20:58:19 -0700
Message-Id: <20260629035830.1520296-67-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a41f4d7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: HJLj8SG5MdlkV5LIeJxPwpYcD8hj5tnX
X-Proofpoint-ORIG-GUID: HJLj8SG5MdlkV5LIeJxPwpYcD8hj5tnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXyQAOgDw0wUmS
 pYS8yO190uErSO1mVM924rQq6RnwyukCDBNdLRigXd4KNE/DAkHKM3zYBoBfeoiaoaG1ZUpFrFL
 gIF3xQoIUkzE54NqrBUuySrFMovOvNJrHbkTQS6MPv1qqz9ljA3Q1EmA+1WRUyiAD5+hkt4NR3A
 ydCxGSHicrF/2vZs+uXBPuC+M34X1U42Dh+DW/s0K3IdnzFIH0kauE+hiJSHjy/CyElj+5CW3Vs
 Rscx/LMT3SBuXJc01/w1Tr/lukWKKK2NZR6i8toyWRSWw3dMu2M8Jm6Rx2aFG3Mmkybctf3TAPe
 PktugJE0IQkh+4YbGfIzq+inGvgRgyq7eBh/URi1DNPjy+vpKycm6rmds9tRG/uvt2B++e8+WKh
 hSWHLSUFzQPM0IJjsj59o3soA8n/zK2bv5wdttgh6IIXHZXm3GtKPENIl9QT/hw0OXIC3pxaUTK
 p0I74gvMJo/lPfT+pow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX3aOhywYN3ah8
 xDqoDCJMbDAGhhuK7FAsXESbxKsvO+LaN2PwdkkRfeovYISslnmutbkvkAh45owx9Qunofy0qja
 hv9wHLE6Q2wGtglgeFs87uaIicfl9vQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDY4YjIzODk1NDI4Li5h
ZjUwMzIyMTRjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw2ICs5NSwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

