Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FFDC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkr09-0007BC-85; Thu, 14 Mar 2024 15:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rkr06-0007Aq-Ay; Thu, 14 Mar 2024 15:44:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rkr01-00014H-V0; Thu, 14 Mar 2024 15:44:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EIkf4Y007955; Thu, 14 Mar 2024 19:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yVS9DnEJGYPQ0SwbsblkjZkskuO0bI6x0TXdOJhxOi8=;
 b=MX/HeOwhYSOLQj/0+EeoF4fMmkoN0f2iRbLOjNoKfyDfgveKf9JSULymXCty7IX0r89a
 uYc1yTtR8KMRRHz6bLi1xVg8CYhBql/812cD2bn5iYB9+gWAfrEi4L+wyiYcRxiLpViW
 Nr/XVQhRrXWDKiqle0UvT2jViHXgvJ+uJLGLDUGPH7fMbtJSzk1XcPBjG7+lf7Bdh98/
 rJT7EeaeFckmXJiauXXYYj2b1wrFeY5JTopqbPHm9ZO06y6SDaAgwdF2f6wIBEiFpvpf
 s8IJ/7C9c6uw3TzRc52/Zt8hei7wf3hC5r2eJ/A/XtySq0erFqNeSMJdTN5k5bCMWtji 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv6pa0r2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 19:44:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EJiJaR011701;
 Thu, 14 Mar 2024 19:44:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv6pa0r2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 19:44:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EHl2ZK015570; Thu, 14 Mar 2024 19:44:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2g07aa7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 19:44:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42EJiFR842139978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 19:44:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E91E52004E;
 Thu, 14 Mar 2024 19:44:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E1BB20040;
 Thu, 14 Mar 2024 19:44:14 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.31.78]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2024 19:44:14 +0000 (GMT)
Message-ID: <226063093bf4dcb200c981dd5b655135d8a47feb.camel@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: improve cpu compatibility check error
 message
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 14 Mar 2024 20:44:14 +0100
In-Reply-To: <20240314190007.19568-1-cfontana@suse.de>
References: <20240314190007.19568-1-cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6r9yGZkYuceXgMzOepv8OieT4Leg-rAP
X-Proofpoint-ORIG-GUID: pmZ-q8UyFTZ1UG-qWqvDJg89WwFxNrFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Thu, 2024-03-14 at 20:00 +0100, Claudio Fontana wrote:
> some users were confused by this message showing under TCG:
>=20
> Selected CPU generation is too new. Maximum supported model
> in the configuration: 'xyz'
>=20
> Try to clarify that the maximum can depend on the accel by
> adding also the current accelerator to the message as such:
>=20
> Selected CPU generation is too new. Maximum supported model
> in the accelerator 'tcg' configuration: 'xyz'
>=20
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  target/s390x/cpu_models.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 1a1c096122..0d6d8fc727 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -508,14 +508,14 @@ static void check_compatibility(const S390CPUModel =
*max_model,
> =20
>      if (model->def->gen > max_model->def->gen) {
>          error_setg(errp, "Selected CPU generation is too new. Maximum "
> -                   "supported model in the configuration: \'%s\'",
> -                   max_model->def->name);
> +                   "supported model in the accelerator \'%s\' configurat=
ion: \'%s\'",
> +                   current_accel_name(), max_model->def->name);
>          return;
>      } else if (model->def->gen =3D=3D max_model->def->gen &&
>                 model->def->ec_ga > max_model->def->ec_ga) {
>          error_setg(errp, "Selected CPU GA level is too new. Maximum "
> -                   "supported model in the configuration: \'%s\'",
> -                   max_model->def->name);
> +                   "supported model in the accelerator \'%s\' configurat=
ion: \'%s\'",
> +                   current_accel_name(), max_model->def->name);
>          return;
>      }
> =20
> @@ -537,7 +537,8 @@ static void check_compatibility(const S390CPUModel *m=
ax_model,
>      error_setg(errp, " ");
>      s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat)=
;
>      error_prepend(errp, "Some features requested in the CPU model are no=
t "
> -                  "available in the configuration: ");
> +                  "available in the accelerator \'%s\' configuration: ",
> +                  current_accel_name());
>  }

I wonder if these might not be confusing in other circumstances, e.g. when
running with KVM and the Linux version lacks support for some feature.
I think something along the lines of:

error_...(errp, "... supported by the current configuration ...", ...);
error_append_hint(errp, "Consider using a different accelerator, a differen=
t QEMU version or, when using KVM, a different kernel");

would be better.

I'm not sure about line breaks in error message, I like the better grepabil=
ity
of unbroken lines but the coding style guide doesn't mention anything.
> =20
>  S390CPUModel *get_max_cpu_model(Error **errp)


