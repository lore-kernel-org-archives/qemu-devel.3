Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAD6C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 17:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlAuG-0007F8-7m; Fri, 15 Mar 2024 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rlAu2-00071v-2t; Fri, 15 Mar 2024 12:59:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rlAtz-0001dW-6Q; Fri, 15 Mar 2024 12:59:29 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FGSRoa019066; Fri, 15 Mar 2024 16:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xo2ZLJGnIwGkE4Afh5Yiz3LPYz5Xj+8fb1hS4uNVlAA=;
 b=dPU1x8p+5MWEB8ekOAORjRwJPon5eux2ELGNVs4RtLvPFTKeFRA/fC6fKy4TUljzuNlx
 kpkAjextjP/rEMVGaaRsW2hJ/DC2mr/ZekItfWiKZPWZuKGoULGyazSrWABpcAiFTMHe
 JMzv/VA+1sFUTgDr31jJofG2V78/W2ZXXP/4+AKtiKPM4AiJmdKSiolWELy1jxhKIUFf
 Hh0heUzmIxRRIl9sHhZ4uOOhzfx/sbg1bUSNjVDu0wLof2WPneP7f2iEGR8RYpXY4dxp
 wRtMWIYrwezcS5D/knKtV9jG1O6s70pX6qFCwF5qaKu1lbF5sPhgzivRfb9IbKtIsqS5 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvsvm0cvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 16:59:23 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FGwhIe026827;
 Fri, 15 Mar 2024 16:59:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvsvm0cv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 16:59:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FGXnTu032216; Fri, 15 Mar 2024 16:59:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wvsyar4c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 16:59:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42FGxHrl33423686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 16:59:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B356F2005A;
 Fri, 15 Mar 2024 16:59:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 612122004E;
 Fri, 15 Mar 2024 16:59:17 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.81.174]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Mar 2024 16:59:17 +0000 (GMT)
Message-ID: <6ce770d49082d4a2b42bcf71200521ca58dc4ed5.camel@linux.ibm.com>
Subject: Re: [PATCH v2] target/s390x: improve cpu compatibility check error
 message
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Date: Fri, 15 Mar 2024 17:59:17 +0100
In-Reply-To: <20240314213746.27163-1-cfontana@suse.de>
References: <20240314213746.27163-1-cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 750Osaiqwpw2vDNvD9BXc7t9y3JBlqHG
X-Proofpoint-ORIG-GUID: Xs-n294F-Gzi3D6cEXAE4G1ZUFpw-07Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_04,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403150138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2024-03-14 at 22:37 +0100, Claudio Fontana wrote:
> some users were confused by this message showing under TCG:
>=20
> Selected CPU generation is too new. Maximum supported model
> in the configuration: 'xyz'
>=20
> Clarify that the maximum can depend on the accel, and add a
> hint to try a different one.
>=20
> Also add a hint for features mismatch to suggest trying
> different accel, QEMU and kernel versions.
>=20
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> ---
>  target/s390x/cpu_models.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 1a1c096122..8ed3bb6a27 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -500,6 +500,16 @@ static void error_prepend_missing_feat(const char *n=
ame, void *opaque)
>      error_prepend((Error **) opaque, "%s ", name);
>  }
> =20
> +static void check_compat_model_failed(Error **errp,
> +                                      const S390CPUModel *max_model,
> +                                      const char *msg)
> +{
> +    error_setg(errp, "%s. Maximum supported model in the current configu=
ration: \'%s\'",
> +               msg, max_model->def->name);
> +    error_append_hint(errp, "Consider a different accelerator, try \"-ac=
cel help\"\n");
> +    return;
> +}
> +
>  static void check_compatibility(const S390CPUModel *max_model,
>                                  const S390CPUModel *model, Error **errp)
>  {
> @@ -507,15 +517,11 @@ static void check_compatibility(const S390CPUModel =
*max_model,
>      S390FeatBitmap missing;
> =20
>      if (model->def->gen > max_model->def->gen) {
> -        error_setg(errp, "Selected CPU generation is too new. Maximum "
> -                   "supported model in the configuration: \'%s\'",
> -                   max_model->def->name);
> +        check_compat_model_failed(errp, max_model, "Selected CPU generat=
ion is too new");
>          return;
>      } else if (model->def->gen =3D=3D max_model->def->gen &&
>                 model->def->ec_ga > max_model->def->ec_ga) {
> -        error_setg(errp, "Selected CPU GA level is too new. Maximum "
> -                   "supported model in the configuration: \'%s\'",
> -                   max_model->def->name);
> +        check_compat_model_failed(errp, max_model, "Selected CPU GA leve=
l is too new");
>          return;
>      }
> =20
> @@ -537,7 +543,9 @@ static void check_compatibility(const S390CPUModel *m=
ax_model,
>      error_setg(errp, " ");
>      s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat)=
;
>      error_prepend(errp, "Some features requested in the CPU model are no=
t "
> -                  "available in the configuration: ");
> +                  "available in the current configuration: ");
> +    error_append_hint(errp,
> +                      "Consider a different accelerator, QEMU, or kernel=
 version\n");

If I'm reading the regex right, this ^, a string literal on a separate line=
, is excluded
from the line length check.

>  }
> =20
>  S390CPUModel *get_max_cpu_model(Error **errp)


