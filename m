Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F1C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wHB-0004uR-JB; Mon, 31 Aug 2026 03:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wGy-0004sH-0A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:17:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wGw-0005va-Aq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:17:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52atj2764498
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eZXZmSXRtZgiP5txpGfsj6dsPlIlkGq3ciyxtanqGkQ=; b=dnhl7XRyzX/wkm0x
 KMINaDWvxOtGuJEGkXBB9hqou1Jei98aBXJVU9LZno87nBuJx2pcEjKDf9F3ISxZ
 yJv0ioBf+v7ud08yaftkpj2fLay/WBHHVZt2bnvqygGq6IbNsvEeH67+SWYEEJ1M
 q+81v3SVvVep7drDC76Ywv1CLCKitaVZlbWXRzpFzaGNLrfcx2kdQmfamKKdinKU
 Q8lub4lWqdlnlPriuFWYsWnHTuYHXUAZede0NXucdTPg01eVHumbly2j3OANvEdj
 DfsunDt1JpJ0MXM64ydp+eaUU+qKaauz8nfaxlCOJJmqNP8+0ZblvMzYegeUnm5x
 891C1A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgyn5tx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:17:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939187562a1so766131685a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788160657; x=1788765457; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eZXZmSXRtZgiP5txpGfsj6dsPlIlkGq3ciyxtanqGkQ=;
 b=aTOs4BNZrwPYL5/tJUGNYhXr0HhPDx27bBogsRk9B0CBSd/3JBcgYbagOlj6CDC+se
 mzI9lzqGq9ColTygjNl9QpjBzxqZBZYd91dsjg4BeGUShdES0anqsT5kxDE6FE1FNCUz
 Y7NJs0sUaUT3BjSjiKO+3LIqjhlOa4EHWDbp9MSqA1TLXJnlkDIn+Dq6dhVtoO37azHd
 1SH5v11gBAxggenSrSeeQuWiYE9fa/zlDJAvshUkMf1j7HwUu6r68/8+PAoPi44WEdjh
 S+XuA88nTrQrLvZ2o6F/+KWIIG+NRLsjkyQfKWKe1yoSN0daS0oemLhOm8yg+iwUdynW
 xOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788160657; x=1788765457;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZXZmSXRtZgiP5txpGfsj6dsPlIlkGq3ciyxtanqGkQ=;
 b=Bln87ZQuRfgkP83A3o6qqi4N/g0VGJ8Q66oT1r8RXTZq78qRNxpIqZIEb66T9YRWp5
 T1+tltQZKdEmJA2LSV2g9ekl5kuSjtJNlOVKcLza9T2XLMPuN7Y/3ZeyF2Q/3NnWkJH1
 lbMkPWzodleiA0P/QXuBf232K2NoX5MJnNsRTNjL888HO//FtHCPPJBM5Aut4nBVdyHg
 UgWkgQEOR8kTImmGE0YW/cS8Tw7jnbdvm91+5IwUhIeu0F0hvT+nUWRe8b643Xq13H15
 AeXq7WPryx95H0gMusAUZ+qxOA5knjEYNS/7H2UQWMe/1Fk9rbgOG+C1STzADJ+QUXGN
 jdpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr56PJN+AYvqGIDSR7DnzPomcHshH0luy2bxGZ6hGyh1xQbGOzolDj+CPFbIthfMWaf9rH+T/ql+ID1@nongnu.org
X-Gm-Message-State: AFuF++nFEV51o2nVNvh77k1xlsaAaHRGWNx57fiGaqAwpOrye7MHovvK
 NnaSWHS8YQrOMHHe7nEU6Q3ubhgDqXh6wvl5zyaGdyPt0ZVt9pBqdFszYtZKRqoxAYV0br1e0CR
 SXbOqKEafoPijsFc7lnmOo5nqr9TQMHPmNAQHBzVqvzgXAc2cXazMz2OAXw==
X-Gm-Gg: AR+sD10LkDeBVpJR4rwmazL9QDXx0FMEgl713AsMeEU+J7aHBLoF3g0TzBblZplOATG
 ebL48IqAQb17aKbufCdT03BzXCwM0n31/Y0GV8meAVVOL+RaYBqDrmdsYqLofcX1BQTKiCqsxjv
 nLoOOKOia0O5u8byPzrDxUrzUp10QWSi8FMu8laOOTyKKK3h776du2GxoUwuvbjsQb18v7iMJDw
 wXitOLhrP+cMuj+wx1q4VTxnhPgj5Di2aUWiniprYc2NWxgCXsiGl1K7e1I02tvOc8mFduRYMU4
 m6V4YXy6mOSZS7RECnBkRbt/Rqx42DE8MBIYuOd39s2OVy9yy2WRVBARy2wrlpX6xUQGreOuI2X
 hLidWQ4yiFcIHQranXkqa8WcBJyP6XMjE8w==
X-Received: by 2002:a05:620a:1b91:b0:936:ef9a:deea with SMTP id
 af79cd13be357-939138cb02bmr2981049085a.28.1788160656786; 
 Mon, 31 Aug 2026 00:17:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1b91:b0:936:ef9a:deea with SMTP id
 af79cd13be357-939138cb02bmr2981044785a.28.1788160656406; 
 Mon, 31 Aug 2026 00:17:36 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843f5c4f35sm314962f8f.14.2026.08.31.00.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 00:17:35 -0700 (PDT)
Message-ID: <4946ddc0-9675-4dc4-8657-700d689bc4b5@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/47] target/microblaze/cpu: filter microblaze cpu
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-44-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-44-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX4aGK3Y1d0eY5
 LA5P2x1+VeZXEpLB2AMqPBDN4+Afg29M0zK8olW4//f2osHPTWOIJ2wsvuNPJ5SP9iGCsyuIK0z
 7OGo7Hx5VWezYljxkPKmPRD5IJCPoQc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX/DPwi1sqsJHt
 w6ab5pT8otbOGvP3v1kYwzuLQLqBHrN1ZU1wSZswHxVLrB0pgNrFowMZmOvpO0/hwu1a5oencsW
 7wERU+0uYPfV+QNHGPY4efS94dzN0zw580j16AbKDmx0Y60ZZ/7In6dHgUMgtpnd0PKMggN5/+4
 cKxQOJtz6W9apKFVA1sSEaPPh8FFkvhU5JFM2kUV71sZdcjoEGffMV0qzTUKDe0aDQGlHuBN21d
 EKWd9merufDfoe7Efm2Pp+H9HYmdvCLvWkoNVEDiOdXQsI5bO5phMGTZKVbjG0qe9bCc5P6fDpu
 sXttbm+cAKxI/PvOVfqEhYHnwQkii3NgbSRteE1XKG88bgTQCoHNQTrGrdqxtNkWAOUX2k35xli
 QfJhsFHutn0qo0zzbeYWe6dVNWh3m0T8gT53QzFdn8t/aAWvENqFgBzPHnC538o42ktyU92WTsh
 cCo+a9iDbo4HsvOwzKw==
X-Proofpoint-ORIG-GUID: U8_0OtUn2WpybpkdQNLJEOchRYm36Xwv
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a952a91 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: U8_0OtUn2WpybpkdQNLJEOchRYm36Xwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> This ensures this cpu is not visible for other targets.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/microblaze/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

