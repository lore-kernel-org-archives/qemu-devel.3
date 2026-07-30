Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B43C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZb-0005e2-6v; Wed, 29 Jul 2026 21:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZZ-0005d3-Aa
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZW-0005Z2-Rb
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1NElj3533147
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=eqNTfr6n0gU
 z6sPAh6ZkRrrQfScmELa2HH+1AsDgaOU=; b=lGKBdPxtI5jveVdsuEmmsN8/FuI
 TGJFFqplGyw9rn5UCw64C4fa8ha7EmdPVDemMzEoABCPC5VBDCYvd7UGJsg+kxPd
 UkMECeZjYSDwSgJmZebfNNVPUvU+rwUnmLsXtxe3P3QjHdGMTdLtGzx7URDlIfRg
 A7iaGMzfbOMbMVTMFNX7raAzwoONHd4Z46opZE4ylJV1BonvmRBgAdi+EEU+5sRP
 +ICUkIW7HAWyOzpLx9hBETaLc9YP8b2chIyRCiqFZlI8dR5+I6yb6Z/YsW3+svxN
 OYXmGkk/JHHnwg02Jstpepf/MS97EpNJdQakxBqN2Vwq4MjfoEETi2GcPoA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvwe00gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so2472559a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374906; x=1785979706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eqNTfr6n0gUz6sPAh6ZkRrrQfScmELa2HH+1AsDgaOU=;
 b=Bog7IgxKtjfFGXke88cq01DrwCMOeZRKYOPnXmRlLPtLAILcy8z7O/qHPda5wu+Bgx
 U4GlG2r58P0SFwT7LfpzNhMSD0/acDeqXYjcgu33fWfJwZcPS5+Vqp3M0s4Xdap2mike
 j27aB5+/CiLwYf1N66bZ1mFuUVzzs+qNu716zXY6uMmsD5Uw0sqGIPD52SgNSC4WH+Xw
 Tm77ILa0Vs1mwr0Co9MboTWuSvCaMSUxjGWIViIw5keag0cFFUSGsWw/JpoaCw6stJV4
 BQMBBAekxpHV30WtNc/dZaH64Z+TnS9pAklerbPJrjGVzg3Pza9AIvwv82I1koRI4poS
 hryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374906; x=1785979706;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eqNTfr6n0gUz6sPAh6ZkRrrQfScmELa2HH+1AsDgaOU=;
 b=knIqz4FCce8747Ojp3WHaWIznPblcYjTuC7rDg/kGK9GcUTUepMBCy5MobM5spyB8h
 8RI5dzEK7D+NA6AI+otOYUUQ2Fhv0hspwbTNGoxNciWKZrM7LU1XY2JuQa+JjT6y4LDI
 dQyL1xNRnUWcRLQKm953DKQERIRDCqUQfv7RFrgPivP3Z7dZfGLcSo6atMb1Oh06DWSD
 UXtwQOOdZaKin/0uD50CnNwm2cU8j8DzX61u4PP5Qn0O/q3IQqkiGmNAk5ku2M/61EW/
 I6kcl1pj1gFqtQ/PnUvvwQQg1Onw2ee/VGgQVCZjQB+ERs0rMXv6pJHxi7Y44sTKD7is
 ueIw==
X-Gm-Message-State: AOJu0Yw+1GJXnMeE69CWnl2Hmkyx86D4w4P7d26hrd3Y3E9EBzLEwwKV
 ImJ/HYafBfeT/43PzF8BwXzuzrxYJsCn+SS5wWNBa2+2ImybBi36+QOPq0smr9bZvgNPbYRICps
 9PcoGFKIz7d5Rr5QqI5ngSZcKPhb+CI1zrxf+PYyKPoJUfb7aqItLcxblyOUYAvuSfg==
X-Gm-Gg: AR+sD10FxAK9unmiLhTQj/kjLPwJlBS83q0MgOp5pNsI0g0X80Csv7YSw0GNr5X2eyD
 TlcAtkmHFg9PInkBVfhdRrP+KZlK8n80UHKRUN/uDahW0hAwXlWDZmM7m1v9dwYhbBLLTKTNHxx
 s/OwTbtrm8xEZDsp7xzxt3c2Fes6Q+qTi8WZqZrsGfoMZn8gezFLFtJCA1Ilipo/rpQ9kkMViBV
 v7y4Rk2dna7ZQy4aFqVPTFOkcGkGW36+wH5ueXhEGXnqgj8NpE3MBSsv0/y0nDi4LI+E0ikhHOP
 wWxxs/c/f7HmMHYhRUnSPxAvOaOB0+hyebG1u9/Ty5TZz56TOvphd3anXNMRLMB7dypNasFFGOH
 vPwTY5M04D/nNr/Bjmwn8K0E/gG9li9izh6TDDKm/QFulgTHI
X-Received: by 2002:a17:90b:2645:b0:38e:e0b:320d with SMTP id
 98e67ed59e1d1-38f9c09985cmr523873a91.41.1785374905967; 
 Wed, 29 Jul 2026 18:28:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:38e:e0b:320d with SMTP id
 98e67ed59e1d1-38f9c09985cmr523850a91.41.1785374905512; 
 Wed, 29 Jul 2026 18:28:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 00/18] Add hexagon l2vic, qtimer devices
Date: Wed, 29 Jul 2026 18:28:05 -0700
Message-Id: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX5cEocS15XdCd
 zhS1HA/Q4IYuDmkaEZGzSfaCm85pvknU3yjDQcvSVAH/IiDdD0mmzA0t3GBxeOhpp/OL+NNvqym
 dguS0Iy3yUCXIhXxPvLqQs5ZCsErcG+kJLOttG6VcNA/Q24t/vf6wFsfOjGMsiy88OE6mdLCKd2
 9FtW0GZ7CZlFjCGdT4IH394hrRvSyxIKgGqZTgG+OzRFHnYVvxKZSUnxB+KJ3wv2+xb1wPUKABz
 ZNBYmPMtH7jJ+yTO+0Hfnow0V930MNTKhTyRTq2WwCobpVzQcuOoVs0vT4+xgkEhlaF3LtUOhnI
 VWOv2RwBwfFBvQjqimkHIBDmIWpXBaBrN2C4xKr0u48ZaSxWjaOsLd2PE+l7++zQI1AyJDlEzK5
 topZ2PduPjIJG9sNIlL5FPRrWsKoxoshqXY2gv9xCpn0pZZfrF2xv9MRXGONKJnr0chqei38JpO
 S4qdwno0RAtM44ouJ6w==
X-Authority-Analysis: v=2.4 cv=AcmB2XXG c=1 sm=1 tr=0 ts=6a6aa8bb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=X2-TYd9zp88hgjPYijYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: MNm3gAu4L01BaGDQfAl0Xi9SBTLSip1_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNiBTYWx0ZWRfX/KKX9xdj12dC
 X1cYDqoWDjLcWK4qDOB8nf1SfDiReHO5LtLdwKjckU1dEfYXK98ULXf9ia9YNqg2O0cvqvKhyq1
 lKjSQ9QsAz3hXQB+6ZGBILZ7EFGXd3U=
X-Proofpoint-GUID: MNm3gAu4L01BaGDQfAl0Xi9SBTLSip1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300006
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

VGhlIHByZXZpb3VzbHkgaW5kZXBlbmRlbnQgdGhyZWFkcyBmb3IgbDJ2aWMgYW5kIHF0aW1lciBh
cmUgbm93IGNvbWJpbmVkLAp3aGljaCBzZWVtcyB0byBtYWtlIHRoZSBtb3N0IHNlbnNlIGJlY2F1
c2UgcXRpbWVyIHRlc3RpbmcgZWZmZWN0aXZlbHkKZGVwZW5kcyBvbiBsMnZpYy4KCiogc3BsaXQg
dGhlIGhleC1zdWJzeXMgcmVmYWN0b3IgaW50byA1IHBhdGNoZXMsIG9uZSBwZXIgZmllbGQgbW92
ZWQuCiogYWRkIHZpcnRpb19tbWlvW1ZJUlRJT19ERVZfQ09VTlRdIHRvIEhleGFnb25WaXJ0TWFj
aGluZVN0YXRlIGFuZCByZWNvcmQKZWFjaCB0cmFuc3BvcnQKCmwydmljIGNoYW5nZXMgaW4gdjQ6
CiogSU5UX1NUQVRVU24gYW5kIFNPRlRfSU5UbiBnZXQgTDJWSUNfT1BfTk9ORTsgU09GVF9JTlRu
IG5vIGxvbmdlcgogIHdyaXRlcyBpbnRfZW5hYmxlIGFzIGEgc2lkZSBlZmZlY3QuCiogU09GVF9J
TlRuIG5vdyB3YWxrcyBldmVyeSBzZXQgYml0IGluc3RlYWQgb2Ygb25seSB0aGUgbG93ZXN0IG9u
ZS4KKiBnZXRfdmlkX2dyb3VwKCkgcmVqZWN0cyBhbiBvdXQtb2YtcmFuZ2UgdmlkIHdpdGggTE9H
X0dVRVNUX0VSUk9SLgoqIGZhc3RsMnZpYyByZWdpb24gZ2FpbnMgYSByZWFkIGhhbmRsZXIgcmV0
dXJuaW5nIDAgKHdhcyB3cml0ZS1vbmx5KS4KKiBDb21tZW50cyByZXdyaXR0ZW4gdG8gZGVzY3Jp
YmUgdGhlIElOVF9HUlBuIGludGVybGVhdmUgYW5kIFZJRCBwYWNraW5nLgoKcXRpbWVyIGNoYW5n
ZXMgaW4gdjQ6CiogaGV4X3RpbWVyX3JlYXJtKCkgdXNlcyBtdWxkaXY2NF9yb3VuZF91cCgpIGlu
c3RlYWQgb2YgbXVsZGl2NjQoKSsxIG5zLgoqIEFDIENOVEZSUSB3cml0ZSBvZiAwIGlzIHJlamVj
dGVkIHdpdGggTE9HX0dVRVNUX0VSUk9SLgoqIHJlYWxpemUoKSB2YWxpZGF0ZXMgZnJlcV9oeiAh
PSAwIGFuZCBmcmFtZV9zdHJpZGUgYSBub256ZXJvIHBvd2VyIG9mIDIuCiogRnJhbWUgZGVjb2Rl
IGRyb3BzIHRoZSByZWR1bmRhbnQgb2Zmc2V0IG1hc2sgbm93IHRoYXQgc3RyaWRlIGlzCmd1YXJh
bnRlZWQgdG8gYmUgYSBwb3dlciBvZiB0d28uCiogUmVzZXQgY2xlYXJzIGNudHBsMGFjciBhbmQg
ZGVhc3NlcnRzIHRoZSBmcmFtZSBJUlEuCiogdm1zdGF0ZSBhZGRzIGZyZXFfaHogYW5kIHNlY3Vy
ZS4KCndpcmluZyBjaGFuZ2VzIGluIHY0OgoqIGhleF9zdWJzeXNfYWRkX2NwdSgpIHNwbGl0cyBD
UFUgcGFyZW50aW5nL2xpbmsgd2lyaW5nIGZyb20gcmVhbGl6ZTsKbWFjaGluZXMgbm93IHJlYWxp
emUgdGhlIGNsdXN0ZXIgYmVmb3JlIHRoZSBDUFVzLgoqIHF0aW1lciBBQyByZWdpb24gd2FzIHVu
aW50ZW50aW9uYWxseSB1bm1hcHBlZCwgbm93IG1hcHBlZCBhdCBtX2NmZy0+Y3NyX2Jhc2UuCgp0
ZXN0IGNoYW5nZXMgaW4gdjQ6CiogbDJ2aWMtdGVzdDogYWRkcyBWSURfR1JQXzAuLjMgcmVhZGJh
Y2sgYW5kIGFuIGwydmljX3NldF92aWRfZ3JvdXAoKQpoZWxwZXI7IFZJRCBzdGVlcmluZyBub3cg
Y2hlY2tlZCBwZXIgb3V0cHV0IGxpbmUgcmF0aGVyIHRoYW4gYnkKd3JpdGluZyBJTlRfR1JQbl8x
Li4zIGRpcmVjdGx5LgoqIGwydmljLXRlc3Q6IG11bHRpcGxlLXBlbmRpbmcgY2FzZSBkcmFpbnMg
aW4gYSBsb29wIGluc3RlYWQgb2YgYSBzaW5nbGUKY2xlYXIsIGFuZCByZXN0b3JlcyBJTlRfR1JQ
bl8wL0lOVF9UWVBFbiBiZXR3ZWVuIGJsb2Nrcy4KKiBxY3QtcXRpbWVyLXRlc3Q6IGFkZHMgdGVz
dF9xdGltZXJfYWNfcmVnaW9uKCkgY292ZXJpbmcgQ05URlJRIChpbmNsLgp0aGUgaWdub3JlZCAw
IHdyaXRlKSwgQ05UU1IsIENOVFRJRF8wIGFuZCBDTlRBQ1IgZnJhbWUgMC4KCkxhY2tpbmcgUi1i
OgogLSBody9oZXhhZ29uOiBhZGQgaGV4LXN1YnN5cwogLSBody9oZXhhZ29uOiBtb3ZlIFZUQ00g
dG8gdGhlIGNvbW1vbiBtYWNoaW5lIHN0YXRlCiAtIGh3L2hleGFnb246IG1vdmUgZ2xvYmFsIHJl
Z2lzdGVycyB0byBoZXgtc3Vic3lzCiAtIGh3L2hleGFnb246IG1vdmUgdGhlIFRMQiB0byBoZXgt
c3Vic3lzCiAtIGh3L2hleGFnb246IGdyb3VwIHRoZSBDUFVzIGluIGEgY2x1c3RlcgogLSBody9o
ZXhhZ29uL3ZpcnQ6IGFkZCBsMnZpYyBpbnRlcnJ1cHQtY29udHJvbGxlciBhbmQgdmlydGlvLW1t
aW8gRkRUIG5vZGVzCiAtIGh3L3RpbWVyOiBBZGQgUUNUIFFUaW1lciBkZXZpY2UgbW9kZWwKIC0g
aHcvaGV4YWdvbjogY29ubmVjdCBxdGltZXIgZGV2aWNlCiAtIHRlc3RzL3F0ZXN0OiBhZGQgcWN0
LXF0aW1lciBxdGVzdAogLSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGVuYWJsZSBtb3JlIGFy
Y2hfdGVzdHMgY2FzZXMKCgpsMnZpYyB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI2MDcyNDE4MzY0OC4xOTA1MzEtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20v
CmwydmljIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNzE1MTg1
NzAxLjEyODcxNzYtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCmwydmljIHYxOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNzE0MTU1MTI2LjM1MDk1NDQtMS1i
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCnF0aW1lciB2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC8yMDI2MDcxODAxMzI0MS4xNTUwMTI0LTEtYnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoMTcpOgogIGh3L2hleGFnb246IGFkZCBoZXgtc3Vi
c3lzCiAgaHcvaGV4YWdvbjogbW92ZSBWVENNIHRvIHRoZSBjb21tb24gbWFjaGluZSBzdGF0ZQog
IGh3L2hleGFnb246IG1vdmUgZ2xvYmFsIHJlZ2lzdGVycyB0byBoZXgtc3Vic3lzCiAgaHcvaGV4
YWdvbjogbW92ZSB0aGUgVExCIHRvIGhleC1zdWJzeXMKICBody9oZXhhZ29uOiBncm91cCB0aGUg
Q1BVcyBpbiBhIGNsdXN0ZXIKICBiaXRvcHMuaDogQWRkIGZpbmRfZmlyc3RfYml0MzIoKQogIGh3
L2hleGFnb246IGV4dHJhY3QgZ2V0X3JlZ192YWx1ZS9zZXRfcmVnX3ZhbHVlIHN0dWJzIGluIGds
b2JhbHJlZwogIGh3L2hleGFnb246IGNvbm5lY3QgbDJ2aWMgZGV2aWNlCiAgaHcvaGV4YWdvbi92
aXJ0OiBpbnN0YW50aWF0ZSB2aXJ0aW8tbW1pbyB0cmFuc3BvcnRzCiAgaHcvaGV4YWdvbi92aXJ0
OiBhZGQgbDJ2aWMgaW50ZXJydXB0LWNvbnRyb2xsZXIgYW5kIHZpcnRpby1tbWlvIEZEVAogICAg
bm9kZXMKICBody9oZXhhZ29uL3ZpcnQ6IGNvbm5lY3QgcGwwMTEgVUFSVCBpbnRlcnJ1cHQKICB0
ZXN0cy9xdGVzdDogYWRkIEwyVklDIHF0ZXN0CiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiBh
ZGQgYXJjaF90ZXN0cyBmdW5jdGlvbmFsIHRlc3QKICBody90aW1lcjogQWRkIFFDVCBRVGltZXIg
ZGV2aWNlIG1vZGVsCiAgaHcvaGV4YWdvbjogY29ubmVjdCBxdGltZXIgZGV2aWNlCiAgdGVzdHMv
cXRlc3Q6IGFkZCBxY3QtcXRpbWVyIHF0ZXN0CiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiBl
bmFibGUgbW9yZSBhcmNoX3Rlc3RzIGNhc2VzCgpTaWQgTWFubmluZyAoMSk6CiAgaHcvaW50Yzog
QWRkIGwydmljIGludGVycnVwdCBjb250cm9sbGVyCgogTUFJTlRBSU5FUlMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgNyArCiBkb2NzL2RldmVsL2hleGFnb24tbDJ2aWMucnN0
ICAgICAgICAgICAgICAgIHwgIDU1ICsrCiBkb2NzL2RldmVsL2luZGV4LWludGVybmFscy5yc3Qg
ICAgICAgICAgICAgIHwgICAxICsKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmggICAg
ICAgICAgICAgfCAgMzIgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAg
ICAgICB8ICAgNiArCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCAgICAg
IHwgICA4ICsKIGluY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmggICAgICAgICAgICAgICAgICAgfCAg
IDQgKy0KIGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2aWMuaCAgICAgICAgICAgICAgICAgfCAgNjEg
KysKIGluY2x1ZGUvaHcvdGltZXIvcWN0LXF0aW1lci5oICAgICAgICAgICAgICAgfCAgNDMgKysK
IGluY2x1ZGUvcWVtdS9iaXRvcHMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgMzAgKy0KIHRh
cmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKwogaHcvaGV4
YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAgICB8IDE3NiArKysrKwogaHcvaGV4
YWdvbi9oZXhhZ29uX2RzcC5jICAgICAgICAgICAgICAgICAgICB8ICA0NSArLQogaHcvaGV4YWdv
bi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgICAgICB8ICA2NSArLQogaHcvaGV4YWdvbi92
aXJ0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEzMCArKy0tCiBody9pbnRjL2hleC1s
MnZpYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTU2ICsrKysrKysrKysrKysrKysKIGh3
L3RpbWVyL3FjdC1xdGltZXIuYyAgICAgICAgICAgICAgICAgICAgICAgfCA2ODEgKysrKysrKysr
KysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICB8ICAx
NiArLQogdGVzdHMvcXRlc3QvbDJ2aWMtdGVzdC5jICAgICAgICAgICAgICAgICAgICB8IDI0OSAr
KysrKysrCiB0ZXN0cy9xdGVzdC9xY3QtcXRpbWVyLXRlc3QuYyAgICAgICAgICAgICAgIHwgMjY5
ICsrKysrKysrCiBody9oZXhhZ29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAzICsKIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
KwogaHcvaW50Yy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBo
dy9pbnRjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGh3L2lu
dGMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogaHcvdGltZXIv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBody90aW1lci9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGh3L3RpbWVyL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8ICAzOCArKwogdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogMzEgZmlsZXMgY2hhbmdlZCwgMjQxMSBpbnNl
cnRpb25zKCspLCA5MCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL2RldmVs
L2hleGFnb24tbDJ2aWMucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9oZXhhZ29u
L2hleC1zdWJzeXMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2
aWMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvdGltZXIvcWN0LXF0aW1lci5oCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9pbnRjL2hleC1sMnZpYy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdGltZXIvcWN0
LXF0aW1lci5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvbDJ2aWMtdGVzdC5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvcWN0LXF0aW1lci10ZXN0LmMKCi0tIAoyLjM0
LjEKCg==

