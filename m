Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C29FD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsY-0000yK-DU; Wed, 11 Mar 2026 00:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsS-0000wk-J6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsQ-00006o-Gk
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3KZKf303861
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w+MS5UPm+JQ0EsyLg+SkV/07FNFJcxRtrEXZ5eolDn4=; b=g/2OuGp565zLuGKV
 LMUcKvlQRLAf1A4dae0rotMtEP7OakbHKkM/stzOXUrtCmz/6jlOIo7S+dn2wMBN
 guVoxozEKaR+SbL1BPjW20ik2zVEsUdNZtliFDIa1uvrcLQ2z11A86BAhAAhdvqs
 Sp4KFtM3bocPtZth/FOEVGEYG5gY8ek9SiX9UI6RTMLSiKsZBLhZTH1Naw0T9mK/
 COQC6+P0096UFfvnICAXq8qZt0vbEIldExUcjB4ls2elLZKAY9HVoV6AAnz5fkhp
 gE/KaQfSh09ihX7IHSVKXQ2hZBOSj8lX8+n6VJWX0WMbv6VohOIXGhC1aT/BYdvo
 MflCdQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf3jm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:42 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-417120d5378so27424076fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202122; x=1773806922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+MS5UPm+JQ0EsyLg+SkV/07FNFJcxRtrEXZ5eolDn4=;
 b=ERmJY0PKVQ00Cc79eBjAh+OIZFCccmrCZ5SH+bBAUHJXhG/rhCz2C6XYeq/J2Weu/D
 g9U0kl2N8oNea+Zah6fDgChy2mBaL+CKSNIRu+omA2OGbjOa5IvoD5f28HMqepGQ2nI4
 wUJii87mJpXq0hqPaWOwP4E5ANxFjXR6ZXNZBj0NfA/2UVFmcXD+JB7V59aGxr+9OhZL
 Tj7tE9XzhvAkJA3BJ/I9VLEWf7VjIBgHke+yGTxu1CEB935LLZwAdcWJ1bJfP/R3Qo88
 EyHkBq4cOPuqQigJ/yAf3FyL5pp24bWM8nMAKuYPVoOiOAKUrssP7njuQVPw7mHtUetp
 0k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202122; x=1773806922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w+MS5UPm+JQ0EsyLg+SkV/07FNFJcxRtrEXZ5eolDn4=;
 b=mLWHJmhKvPD1/2/Or2CjfHS8A3eyQcG5edfCcIod12vd3aF+QaATXOCjSSKmrZNcKF
 f0PKwj7nKESWsYich74if52G/+SW1zXrIWAMTCV2NmXnMMX6Cf9DrkX40Og1W6vh8Wz9
 ooVD21wk8+xiblkquhVa3RLLPOuxrdJwz3n9HVNPBPjTRotdNamI5Gaggwv4M0UdJZvN
 dxsEl63WWLzeKJcXCbIN0LrjJ8BE+wEQL6d3+3hyX2ZBNn9xZIytChZCf5nr4tiYJ7ir
 YIvYuMulffkFl7Im8ETIAtFTqISw+FaHA4nFDnbXXduUVpgMnwXUsG5zdeOAcUWdNgKt
 r3JA==
X-Gm-Message-State: AOJu0YzP3I/mF1o18Z/Pq7EKMcdt7ot7C8QpWl5/ccYvqr9yadl2KaiN
 7iojC07XPKSluZzpBf0lD8hOGLow9TVpcBV7rOQNkaD7r+ucc3iPMOrng1E5Xu7NPdiAU1Fd35I
 xPO7dYTgh9hMaXFvTLbLFQItnMnXSISdw7VSmngdR/r5gzNyNvQnsAjLbIGydPNH5WA==
X-Gm-Gg: ATEYQzyzn7kDtJ4/17jfzZiFCJizCMtNhs/VulJccUCmfyZYx+8S7zZzZKqdiQn07yk
 xHk6mcXxFQyFKqTjBmcJmeuNgo+SXZoA2voMgsYsggB6ORApleX++gtD/9eBmikRAzizcli/KkQ
 dqLYCSRFqz31XlYuMCK4B9texDB6JUWDofZK1Brm5OZcJ9LLXXkkOBUWsOcWNI5yohk5cfh9fKa
 6nQUcCO+/8f/rpO/G8lM/H9HWxqQb61a2k/JB8fluiqKHD4CcvUqiZrEjwamZp7wDh8NHmHnrnB
 B0xdd0yfPvNWGra+l5X/MjLFIwxDATZJWN1TADlzGFBnYD9YaJJsf/2XTRKPmqjiHhz7BOzPy+h
 fqhatYJ9i+C075Q7QTzWC68fjP0yNNaZTx9WWTkDBxzPPrPJzcMaEly4VBR1keiqsn1V6XA==
X-Received: by 2002:a05:6870:d8d:b0:417:5828:ecd with SMTP id
 586e51a60fabf-4177c95d144mr817352fac.46.1773202121870; 
 Tue, 10 Mar 2026 21:08:41 -0700 (PDT)
X-Received: by 2002:a05:6870:d8d:b0:417:5828:ecd with SMTP id
 586e51a60fabf-4177c95d144mr817340fac.46.1773202121515; 
 Tue, 10 Mar 2026 21:08:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 26/32] target/hexagon: Define system, guest reg names
Date: Tue, 10 Mar 2026 21:07:52 -0700
Message-Id: <20260311040758.1068731-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: PmgkJK9NMG8uW5bt8WEAcRfo4gCm1NjU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX6fAwo6bcGvHh
 MMYj0cLYISXYixL0URaZHVDaxQj6TCI5nq3ctNVyIamM8AqAzHNHrnSOmSllNWoUZPsz971Z0/3
 yjeHMNzB/h1qp6vu604H2C4JsnAcC7n39jqI5N2vPQPIXggoqvDQH4F/yslnOkj6lAU0g/f3yAF
 /ICv45KgrTF/B5tc+lqSiOvtPrNO17+Ya2wPACgCySsDfEobiNli5h2kATtaMg0QJ6EvGrmccAe
 W5mlwRowR2JwVhE8HAyh1RRecpgVfAUBQR68w5CQ5wvJTL4NHkAkg3SxSVbCP1Guhg0MvyyKiqC
 XTPkzrc7yRwMGBMRT5lLloKZFK6zbX7LBOlZpWSwFldA2Mgz5NOYtwMeCZwQTl1Y6H+b4tGv7mk
 ZdJbR5bcUUZ5fsivkvyZGIdljTtUMUso9PFT0iqaulQ3BHC92LYpkV/FFUlKIE2g51JJdDWXI07
 uNfpEK6uPL38flNh1Ew==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b0eaca cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PmgkJK9NMG8uW5bt8WEAcRfo4gCm1NjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAyOSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhh
Z29uL2ludGVybmFsLmgKaW5kZXggNDMzODkxNGVmYjUuLjAwYjM3YWVhN2FmIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFs
LmgKQEAgLTMwLDYgKzMwLDEwIEBAIHZvaWQgaGV4YWdvbl9kZWJ1Z19xcmVnKENQVUhleGFnb25T
dGF0ZSAqZW52LCBpbnQgcmVnbnVtKTsKIHZvaWQgaGV4YWdvbl9kZWJ1ZyhDUFVIZXhhZ29uU3Rh
dGUgKmVudik7CiAKIGV4dGVybiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9yZWduYW1lc1tU
T1RBTF9QRVJfVEhSRUFEX1JFR1NdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4g
Y29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fc3JlZ25hbWVzW107CitleHRlcm4gY29uc3QgY2hh
ciAqIGNvbnN0IGhleGFnb25fZ3JlZ25hbWVzW107CisjZW5kaWYKIAogdm9pZCBHX05PUkVUVVJO
IGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgdWludDMy
X3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQv
aGV4YWdvbi9jcHUuYwppbmRleCBjZWMwNmRhZWQ3My4uYTE5Y2RmODRhOTIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC05Miw2
ICs5MiwzNSBAQCBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9yZWduYW1lc1tUT1RBTF9QRVJf
VEhSRUFEX1JFR1NdID0gewogICAiYzI0IiwgImMyNSIsICJjMjYiLCAiYzI3IiwgImMyOCIsICAi
YzI5IiwgImMzMCIsICJjMzEiLAogfTsKIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitjb25z
dCBjaGFyICogY29uc3QgaGV4YWdvbl9zcmVnbmFtZXNbXSA9IHsKKyAgICAic2dwMCIsICAgICAg
ICJzZ3AxIiwgICAgICAgInN0aWQiLCAgICAgICAiZWxyIiwgICAgICAgICJiYWR2YTAiLAorICAg
ICJiYWR2YTEiLCAgICAgInNzciIsICAgICAgICAiY2NyIiwgICAgICAgICJodGlkIiwgICAgICAg
ImJhZHZhIiwKKyAgICAiaW1hc2siLCAgICAgICJnZXZiIiwgICAgICAgInZ3Y3RybCIsICAgICAi
czEzIiwgICAgICAgICJzMTQiLAorICAgICJzMTUiLCAgICAgICAgImV2YiIsICAgICAgICAibW9k
ZWN0bCIsICAgICJzeXNjZmciLCAgICAgInNlZ21lbnQiLAorICAgICJpcGVuZGFkIiwgICAgInZp
ZCIsICAgICAgICAidmlkMSIsICAgICAgICJiZXN0d2FpdCIsICAgInMyNCIsCisgICAgInNjaGVk
Y2ZnIiwgICAiczI2IiwgICAgICAgICJjZmdiYXNlIiwgICAgImRpYWciLCAgICAgICAicmV2IiwK
KyAgICAicGN5Y2xlbG8iLCAgICJwY3ljbGVoaSIsICAgImlzZGJzdCIsICAgICAiaXNkYmNmZzAi
LCAgICJpc2RiY2ZnMSIsCisgICAgImxpdmVsb2NrIiwgICAiYnJrcHRwYzAiLCAgICJicmtwdGNm
ZzAiLCAgImJya3B0cGMxIiwgICAiYnJrcHRjZmcxIiwKKyAgICAiaXNkYm1ieGluIiwgICJpc2Ri
bWJ4b3V0IiwgImlzZGJlbiIsICAgICAiaXNkYmdwciIsICAgICJwbXVjbnQ0IiwKKyAgICAicG11
Y250NSIsICAgICJwbXVjbnQ2IiwgICAgInBtdWNudDciLCAgICAicG11Y250MCIsICAgICJwbXVj
bnQxIiwKKyAgICAicG11Y250MiIsICAgICJwbXVjbnQzIiwgICAgInBtdWV2dGNmZyIsICAicG11
c3RpZDAiLCAgICJwbXVldnRjZmcxIiwKKyAgICAicG11c3RpZDEiLCAgICJ0aW1lcmxvIiwgICAg
InRpbWVyaGkiLCAgICAicG11Y2ZnIiwgICAgICJzNTkiLAorICAgICJzNjAiLCAgICAgICAgInM2
MSIsICAgICAgICAiczYyIiwgICAgICAgICJzNjMiLAorfTsKKworR19TVEFUSUNfQVNTRVJUKE5V
TV9TUkVHUyA9PSBBUlJBWV9TSVpFKGhleGFnb25fc3JlZ25hbWVzKSk7CisKK2NvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX2dyZWduYW1lc1tdID0geworICAgICJnZWxyIiwgICAgICAgImdzciIs
ICAgICAgICJnb3NwIiwgICAgICAiZ2JhZHZhIiwgICAgImdjb21taXQxdCIsCisgICAgImdjb21t
aXQydCIsICAiZ2NvbW1pdDN0IiwgImdjb21taXQ0dCIsICJnY29tbWl0NXQiLCAiZ2NvbW1pdDZ0
IiwKKyAgICAiZ3BjeWNsZTF0IiwgICJncGN5Y2xlMnQiLCAiZ3BjeWNsZTN0IiwgImdwY3ljbGU0
dCIsICJncGN5Y2xlNXQiLAorICAgICJncGN5Y2xlNnQiLCAgImdwbXVjbnQ0IiwgICJncG11Y250
NSIsICAiZ3BtdWNudDYiLCAgImdwbXVjbnQ3IiwKKyAgICAiZ2NvbW1pdDd0IiwgICJnY29tbWl0
OHQiLCAiZ3BjeWNsZTd0IiwgImdwY3ljbGU4dCIsICJncGN5Y2xlbG8iLAorICAgICJncGN5Y2xl
aGkiLCAgImdwbXVjbnQwIiwgICJncG11Y250MSIsICAiZ3BtdWNudDIiLCAgImdwbXVjbnQzIiwK
KyAgICAiZzMwIiwgICAgICAgICJnMzEiLAorfTsKKyNlbmRpZgogLyoKICAqIE9uZSBvZiB0aGUg
bWFpbiBkZWJ1Z2dpbmcgdGVjaG5pcXVlcyBpcyB0byB1c2UgIi1kIGNwdSIgYW5kIGNvbXBhcmUg
YWdhaW5zdAogICogTExEQiBvdXRwdXQgd2hlbiBzaW5nbGUgc3RlcHBpbmcuICBIb3dldmVyLCB0
aGUgdGFyZ2V0IGFuZCBxZW11IHB1dCB0aGUKLS0gCjIuMzQuMQoK

