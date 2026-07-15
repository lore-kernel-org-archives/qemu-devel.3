Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E73DC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjoRf-0008Ek-V5; Tue, 14 Jul 2026 21:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoRe-0008Ec-Ux
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:29:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoRd-0002VZ-5L
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:29:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F0IFpf2223603
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4aS+jO/AzG+I6Q4jNtfBFc/Wezt8/15RG1T+qLPG+aY=; b=Vb6j+QnnWDuLM85H
 +HD9nQLy+lkrCOJruL5gYmCSROy+lvYXvsWajuOTKuD1+sxieqU8R6eA3MxVcIQW
 kvq16V6e2FkOqc4juKLWw/6En9zNRwOpCwiY9+PhENLEOphdeMrohEGYi2lPBwup
 HiRqr2STYL/Yup0BxjHpZZNs88P3vTqolSvm1AO1jdPoaIj4x1bY7NFY/xbAGS90
 LOaTRVQAu3dsNPK8s4h0zPHlXBuB1J+Iw9PIBvXgLXqvUaQVFHxBlfUMtITBJryZ
 pXisPmOBDLU3P2a1tlB+5telLqxvESi/cEeGch5dNr+oXI9Q1Bq84jv65tIc9R/u
 v84ggw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnutf3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:29:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so4141490a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784078991; x=1784683791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4aS+jO/AzG+I6Q4jNtfBFc/Wezt8/15RG1T+qLPG+aY=;
 b=jB3oKBOzfDS4v+2WlcYjoDWdUdCjogq396H3sJhue8Ltjfr/yzS+BKzfa1jUV7y3rb
 jau/QU+bTGDsHjSAvU8tSwC32k5JEBHNwG1MpEK7q/dLZwIVqniK2aKymCxSz0TjArRF
 NjSF01ztKxIrT//4z4TciKOlSOjyTs55UGCb0DZSVlPcLPKZA7r3TGhJ9lyVVCVinwx4
 N3p5QatxrSSiyhhQHw834I9M7raBq++iI97ym9EZiKaArjZ3CHaZ+AmVaJy9ZDSri05N
 uwbx16kqKJc1D6GdDdtneAiJIXNGkiWBF8LjQ7vr1EL7RM2utnAUFKbhVvnY63wop5c5
 2v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784078991; x=1784683791;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4aS+jO/AzG+I6Q4jNtfBFc/Wezt8/15RG1T+qLPG+aY=;
 b=paGdUlgpNsB7enD6I6IatlK0HEllvI6ZNJlujnIyAOZJOSWD605qbSgwx0huZ3LcQh
 hP+A4ccU1dlMX2+dZ10VakaE2jD0X1Ss7VoddPm69Tn6yspsNGyhYINskHjb4N1W6OU9
 ifxWhkzX8X6DeMwd6KfJ02ChNfPUQZppL1FWeXNzKjaDl+JEUJbp/EUklT4n0BRhse2L
 9CW4Qn8zikwuyenVVgxmFjzc5CVn2sVQHYwqhW+nKtZhAtsLUGFYrWs+bn6WKXhRojNl
 eSSGf9eYyIU7wGBI2088zO/L3UsrPgfLMSNmTdcHsAwJeyN0W73Aa1nacgsqfVS/aePS
 Lmgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrcoa/2uZSIq5nXxvdKxpD5chM2SzOYjUBtTyJKSoXrTzZt858LrgYNHZ+aBS2dcQ7Wp6523shoQTWP@nongnu.org
X-Gm-Message-State: AOJu0YwhCzepg2UG6O7ngtBvaBhresfnqON98AvmzJ36SFZShkMDiXbW
 le5Li2+b5N3lXhSIls7sGzsn+nU5CTRgobVjyxm4z8c1Ed/l9Nc4Z83sxynOfjzywKIVtKWRBrn
 FkVIeybXAl1aWD0jljRzTenTSK1oOqwd/pfOKbG4M7qsBlzd0I/02LUfB/A==
X-Gm-Gg: AfdE7cliItgPpO1w4zs9mTf1ZceXA6bnF49Ln7Ilw6crHcnHQm2D7pIxHtx4q6o8ogx
 rEtJTNoQ8xdHy4grqx5MZGKZTXnx42TelRPD1ZBrP0PBmGcQmxz90GOgnel2KhB5/Nd2SvhqKO5
 pEdmX6IIOS9mAGZufOHT6xN5Izw2dHLT7CB+j0BEZTMcRGL8IP6BpF/4EfSRDHVEaUUxDzlVJV1
 dT/CxyEWTeGopoK6/+L0PFC9Bb/cAZecdmObVykHf/atWYH7t0ykNTB40hiIwGUwNWWRzrcfagB
 epiTVdH+DIZYtOfMQqAKMBoQ1D1F4ILMf4+zVptT3iHwBzyNzt1GPl2BGNkLObRAn/WjaTWFSJx
 897WU1xRIVaYlRK4LILeXmcYKZfFNROI4kdMkzmgp132Jer+xHqSNKR34TTD8d7jyEr63u/f57n
 vxQns=
X-Received: by 2002:a17:90b:3b4a:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-38e2a02f7a1mr767000a91.15.1784078991318; 
 Tue, 14 Jul 2026 18:29:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4a:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-38e2a02f7a1mr766981a91.15.1784078990784; 
 Tue, 14 Jul 2026 18:29:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313f3ea883asm12056816eec.29.2026.07.14.18.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 18:29:50 -0700 (PDT)
Message-ID: <573635c2-1d40-4814-850d-623b2392b37c@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/hexagon: connect l2vic device
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714155126.3509544-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m06OTbMLWPMWMJxcmWOg_KkR3eEzJqj-
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a56e28f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cts9yFcrR1THPImdpCgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfXzWmzE97UK2T9
 izZFAiIyz9jawzy0lOdSzEjfIhY75h6pzrXC2+G/80zvQNVyuAJ0W/92yuoyuOha9J38YFNkkrS
 0/hQUDbRspZj0N99PBwbKXOr7SyKDqKCetfqbwJovElLFrqmYkhUXjTnmJNgZ3rrbojdGgGgN7m
 67HJST/j5zVjvimq4IJNIG4Mz1MTyP6KE2ZLJAW19K+UZAZtPGwlH+agtqJN/YIrlI+/ueTpJYi
 TmK4uzDWFm5l6h+yi1FT/iwaIMBOTXrHwerG3xihMZzruLs67rs3GOX1z0dD0ILeHHCYEUhGhA1
 R3GTkFRFJ6BU5XaoVVD1loLtSEj4DsoHEbFrztu3FHv5E1VMi8mHu3ZECbRBJByo22sYC0svDw7
 pny3EpAJbqL6//FTLXvxB7YQgzRT4luLOc4a9a7/AhNOKfXgONIyPFSI81TiifbFnBzQjJda+J7
 uu5fD3MAxDg+zxSpKdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfX6Q1HHKm2wKNn
 Rys7xsTrMT6Ok2wZxU3jzoAYXPWprrBNFaYkIpGEfbsnNsGzKiyouXTewlUX2Xgmyx3SNpu3Bvx
 zvu2H4cFxe9zd6IYM0VlHk6HKOaRRwY=
X-Proofpoint-GUID: m06OTbMLWPMWMJxcmWOg_KkR3eEzJqj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150011
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/14/2026 8:51 AM, Brian Cain wrote:
> Instantiate the L2VIC device in both machine models, map its slow and
> MMIO regions, and link it to each CPU via the "l2vic" property.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h           |  1 +
>  include/hw/hexagon/hexagon_globalreg.h |  4 +++
>  hw/hexagon/hexagon_dsp.c               | 20 +++++++++++++
>  hw/hexagon/hexagon_globalreg.c         | 41 ++++++++++++++++++++++----
>  hw/hexagon/virt.c                      | 22 ++++++++++++++
>  5 files changed, 83 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

