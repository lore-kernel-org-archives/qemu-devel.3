Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ED8CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQU25-0004X7-V2; Fri, 22 May 2026 13:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU22-0004Vg-NK
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:51:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU20-0007rK-Mi
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:51:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MG0fku3477008
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kMXpJ7jxIt3gHnppSLF/heM4Ho5OPJAxJVHJD3For8g=; b=VWwZRtswyM/nBAJN
 EoBM+SLF5T037w6Ji118Qw6X/LX744x1lSW/0FZf/tpmnLAr4qIH59NiYMnxxjyF
 IIHrK1IZD68oKpV8c1d5gGrDh/lSZ78IB1WBtoy+CPPwX7oirLqSxNoOwJIOZdPJ
 tP3eGEs+KUyec1n/qccXfn1nYWPnAgc51EegUOkbU4rjfBaTMF0X51UzH1XAOgOP
 06iF+Ry5r4S0fGHqIa+RacJLQUsEs1jqD7RFVQXMIblPyNElHp/tBun49Yr16h/I
 wq7NzuCYnNnBf0tx9jytpd0W4mYhNsTl02lPGjE6Zu1yOq2G71S2tIDegZhnvWnd
 gAHvmw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eat9r8dmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:51:30 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13312be8a31so3290948c88.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779472289; x=1780077089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kMXpJ7jxIt3gHnppSLF/heM4Ho5OPJAxJVHJD3For8g=;
 b=eq20J/sx/sTzxWixRIyW8dpTdUgoe8idiULhZfX3rB96vLZ9snRcjdInSkD9XBl0KI
 gWOYMjX/Sqq4vRsSJ0wzj6vG/ZSjZIUs3VhgIodRRHaSgV1Cl61All2GRK5WEhTWd8/1
 IhDccBcJtxmawhjkT+OR3vgn387Cy51PIGzzFxkLbNa9IiXe7WGnIsQZXJRO7ip6mumo
 bdFhEY2QFjXM8xsdXNxwgiInHSFxPgHtuePhFZaYREcZXUgAEjhCaux2Cm85pfdc0BCU
 YhpHmKtq+7Tij8Rchy+O262K1dML40rG/YPNnRh4BhF0/jTLNBV98uVlGPHEh899M4bz
 8gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472289; x=1780077089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMXpJ7jxIt3gHnppSLF/heM4Ho5OPJAxJVHJD3For8g=;
 b=fod6LFrvsApZswJouRJVAi/pU2YXNWTVYSpW2E5mk6cT976TOZEAj7GLkHywrJoeeV
 4bcs1yRZh487ncMesYgcV72L6LMwfip/f11P5yI3en/HOSNuKkxPU+1OoWipX/6ILgUK
 8YKKPPzKOss/mP+3rv2n6yeRzeb7X/s4rLPnw7uUssD5oc+PZwZVaJZpBUHVo6j4Folp
 zhRw+PONlJPb1Yq1CpCae/FaC9n+f6kjYDCffwIXEipW33KCwtxJf7VuuEk1o4y0dFOo
 H8EwWvIkOrqjUYRggfOm4au6/sLSvl3AFXtE+jbCepCZgXx+KLJtsGTqMcmWy/8/X0Mq
 5QIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MeW0IaqVL3mRCHqeUORVRDwA/uHycKiV1lKuKRjxocrc0/zI55Hc4Pb4XJ4/CqOcIx0oyH1Xu4KLM@nongnu.org
X-Gm-Message-State: AOJu0YwoZAnSJY0jBTOTgainV9Mlh5JfVUf5HgNgWDvPGSo0UUx2YBEP
 tbHAiybN9G6W0XFbxgqxVdIo4ea+1M6IN6Ig7mbyWWZXPBdlVn2jL9nIvnS8UbaRAxYqfQm68Cc
 V6Pz1XchdE9SSZrZNuSGmIIvYEiCDbxg33wCz2aVXJST35acqxyENFNaFZA==
X-Gm-Gg: Acq92OGPGwSoev4ntnr7o7hEKytCi1f+IUg36GpPM+ITAddTqkSvbkKvC9R4PCo5oXB
 iOGX76CwZO8XVq+OJColiJEPR1ssANhNUZcjG0Ygx1ZBngcbbvqU3M1ZtSOZZwVJ+8fWd/q9ORN
 VR+04P3ogPoMISy5PZXkSMFv04r3n9VTEI8XbCcbN/qNUdc8lxbgYQiEM0woeEcC8ripgaRwcA6
 sB2GEG4Il97Sooc3eB6pJLatsNXrPYD4jmTSWmP9MdmXOOxN1isKyoGMYuKxlet20xEVyLMHnTP
 9RpTyLA0+POmPfep5P63KZTXyYl5U1BiHK+z9PgVfaYFPG/Xvb45PVokyg1nhtcknTDJ5J1ipLt
 b5yzmDxx14KSYJCoM5/aUeHRh7pDEbHhUunhdhFNcVeX0C9UbTzn1g/i4US3ckUeU2bW/20ghBy
 fnl0zBrUgjDx+4Hg==
X-Received: by 2002:a05:7022:41a3:b0:12c:4928:e57f with SMTP id
 a92af1059eb24-1365fb3f877mr1939677c88.25.1779472289346; 
 Fri, 22 May 2026 10:51:29 -0700 (PDT)
X-Received: by 2002:a05:7022:41a3:b0:12c:4928:e57f with SMTP id
 a92af1059eb24-1365fb3f877mr1939647c88.25.1779472288724; 
 Fri, 22 May 2026 10:51:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a509602sm1524058c88.8.2026.05.22.10.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 10:51:28 -0700 (PDT)
Message-ID: <a44de4ea-7daf-473c-b29c-4ca11867fc3b@oss.qualcomm.com>
Date: Fri, 22 May 2026 10:51:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] ci: drop cirrus MacOS build
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521131739.540157-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dt/rzVg4 c=1 sm=1 tr=0 ts=6a1097a2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QT7MPOEWVwL0aNmAcgEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5kvK6vHas2sMYy-WhixRMokvcg1lvYJ4
X-Proofpoint-GUID: 5kvK6vHas2sMYy-WhixRMokvcg1lvYJ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3OCBTYWx0ZWRfX1sai2b/TtCeS
 N86VPehfo5tgNT+LRf2S/MRbzqZyOhVGi5eLfFVSAV3WMDKmo5Qk5uPARY2Qj2hnzJXBEWxjPcf
 4XFDhI9QHAK1ox0EyEjdxcONtLi4OM941rvVF8fCJYan+XgRhCl3HpGUMdZGRy0lTVKxQcgylM3
 wcNvbdZSJdcdGnUcIfZTgsA7XUzIXkT9J2QXOlNB0YFmidxVybpfqHezBMilkzm1617i4R2paIZ
 ali59HPVb9OolrJTL/+oF9rIATDi25J7RMRCJvDD51Hv64D2PWeMZdaOGu3/z3tvfvtgcO7CpEM
 ToMiYxeLR66tK0jNlQtplg/9xFQQq3Tv88xcPTyUtozClgHQ2t9ClM4iJnDM5LgAkAWZFdBdEUS
 YLbDzuCIHL7Dz5U0oX9+cMzOER2VnkvpAyUZPH0cdfhKMjnx9r5xjdCUOUX6ovgv3Seli4+lfNx
 /n63W5iTQf3WBx9VzFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220178
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

On 5/21/2026 6:17 AM, Alex Bennée wrote:
> CirrusCI is closing down soon so time to migrate.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/lcitool/refresh             |  1 -
>  .gitlab-ci.d/cirrus.yml           | 14 --------------
>  .gitlab-ci.d/cirrus/macos-14.vars | 16 ----------------
>  3 files changed, 31 deletions(-)
>  delete mode 100644 .gitlab-ci.d/cirrus/macos-14.vars
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

