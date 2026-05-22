Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9154ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLEU-0001QA-He; Fri, 22 May 2026 04:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQLET-0001Pp-0j
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:27:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQLER-0004b9-FN
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:27:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M6l4LU151154; Fri, 22 May 2026 08:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IBx9kp
 DLrEu9Qvk3PXbwXXsAkjSR1uM38YhPni82hGI=; b=IQq2x9fET1/oaTf6r/yMrd
 4gDZR4eL5IJ/Xh6omN24oDz2HFaywc8p3IjDl0z5choOtcaqrs+/tu2O0BnGoAG4
 ulagBdUIQ0/K6HYqqnsh54Ox5h21p09H/GJIvM6rLCdIbn1TYxKqUu/79GuDpgNI
 MM5o2xEZThiG9RVNGsgRe7x4SnxfQ0dPudSc0aPOqNplY69LY/CcVmHVqOZrp+j2
 3ut9uPIRAHW7XX2fRoG7zGjslGeyDAyWIq7F2X3p2vTnvOXTsGd3Z6CZwR56ziUG
 H+yQXx6hXiFGsBy8SMyulvespV+lQdLK0NAe62oNQhE5xChijwxMxrfHskCZHMZQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawhpe2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 08:27:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M8OOUA015190;
 Fri, 22 May 2026 08:27:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkg3qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 08:27:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64M8ReE938994342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 08:27:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0470320043;
 Fri, 22 May 2026 08:27:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5460220040;
 Fri, 22 May 2026 08:27:38 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.216.126])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 08:27:38 +0000 (GMT)
Date: Fri, 22 May 2026 13:57:34 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Matthew Penney <matt@matthewpenney.net>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 1/1] tests/qtest: fix discarded const qualifier warning
Message-ID: <20260522135219.6cff4e3e-78-amachhiw@linux.ibm.com>
Mail-Followup-To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Matthew Penney <matt@matthewpenney.net>, Thomas Huth <thuth@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260518155344.5945-1-farosas@suse.de>
 <20260518155344.5945-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518155344.5945-2-farosas@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MCBTYWx0ZWRfX/mx4O8PhFonV
 +drgE2vG6hM+S1kz/IIc7oxCu/5BezJ9OYdZfLMQ6e0UVI0r8Th6RqquD2osYPJN9HOp5z9zghG
 JS/otd3ANvDHL35ZVWr1EhymucduUSfYcBiPg7IOPp9GWpEBJzOYT4zv3dlx4zR5jHj+yzbyyDW
 l4Tl/juTb/XPGn3KamMmp+XQ9GbpXm4QK0R7iVePL12FsBt0ZAd1V7G0ZrlcEGklPq15wotR0N7
 N2IrolFz2aGkVtWdeDe6YIiO950oLvd6Oq0ZOsO/gU+83Sd0zuUq4mkXJ+BDOqHnhnPamTDKLZ9
 tQqsh3PWVg7Lgt2gaZ/FD0KMbeAilEBeA3YECSnWnhy57aWrjiWWem95vjKjuUMrviZZBEHbF91
 b2fJTfySOHRRVkRdwT+mEfoHUuQLioqD3kUYocpCsrALbVRE6KdodXb2+Tcc9vKsccLMkQ2CY+q
 daQ38OnAT7CBfWAr1Yg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a10137e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UIrnvgbcAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_DXsSRFCzeZwW9W_6c0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=mx9YIZeJv_Xrg3msmcsP:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ipTuOE3opC5dfBuANqyRyoUVCSZK4P9a
X-Proofpoint-GUID: ipTuOE3opC5dfBuANqyRyoUVCSZK4P9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220080
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Matthew,

Thank you for addressing the const qualifier warning in qtest_verbose(). Your
fix correctly resolves the immediate compilation issue with modern compilers.

I had independently worked on this same issue and submitted a similar fix as
part of a patch series:

  https://lore.kernel.org/all/20260518172517.12466-3-amachhiw@linux.ibm.com/

While both our approaches fix the immediate strstr() warning by making 'found'
const, I noticed that getenv() still returns char * despite environment strings
being semantically read-only. This creates a subtle const-correctness gap that
stricter compilers (like GCC 16) may flag in the future.

I've prepared an improved v2 patch [2] that builds upon your merged fix by using
g_getenv() and g_strstr_len() to maintain const correctness throughout. This
approach:

- Uses g_getenv() which returns const gchar *, matching the read-only semantics
  of environment variables
- Employs g_strstr_len() for consistent use of GLib string functions, aligning
  with QEMU conventions
- Eliminates all const-correctness warnings with strict compilers The v2 patch
  supersedes my earlier attempt and is rebased on top of your merged commit
  (e68da5b7a2cd).

Thanks again for the quick fix!

[1] https://lore.kernel.org/all/20260518172517.12466-3-amachhiw@linux.ibm.com/
[2] https://lore.kernel.org/all/20260522082555.54918-1-amachhiw@linux.ibm.com/

Regards,
Amit

On 2026/05/18 12:53 PM, Fabiano Rosas wrote:
> From: Matthew Penney <matt@matthewpenney.net>
> 
> Modern compilers warn that the result of strstr() may discard
> const qualifiers when assigned to a non-const pointer.
> 
> Make 'found' a const char * to fix the warning.
> 
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/libqtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index bf9284b9a1..b1e06ea364 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
>  bool qtest_verbose(const char *domain)
>  {
>      const char *log = getenv("QTEST_LOG");
> -    char *found;
> +    const char *found;
>  
>      assert(domain);
>  
> -- 
> 2.51.0
> 
> 

