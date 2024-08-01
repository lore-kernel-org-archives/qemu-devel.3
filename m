Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D567C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZR7v-0001s7-7G; Thu, 01 Aug 2024 04:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZR7t-0001rE-4D
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:25:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZR7q-0000nO-KI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:25:32 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4713RkQI022418;
 Thu, 1 Aug 2024 08:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version; s=pp1; bh=EmwCwrwM8W1s9BPntm8b+KuwwO
 kTiPeye8rMMeQ68ac=; b=FvlTrDw1SshruQulgmTzZkJGAWOnDXfI4KvaaV5aQg
 HuFWuKRSUHgf1W5Wgh6gYyiHTwc/8ofxHqMss3qPBr9ZgfzgWmk6jIPkKfZg6NhX
 Qwbl8ZNGkdbamytjhKNVrwy8i1hT6vx2PpfcFrtOQ5eHYyUZPpcNSgSzKU3AI7jO
 CH17AFU417n4oiQJZqLNvjF2f51iV4UJ0XuL0LnIVftdRq2+Qj5AgxZ64kK5x4ov
 RRzTy1sEtsA1ZM/2OXOu9M0PJ7QeFVV/VNv5VZx5Fmnv6FD/UqsbpvGGtW7Hwg0f
 KgCPBnS5xhyjuPC4ze8Fm2Zffr+W7TOI4FjkBOFS1jAQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r1m68qbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:25:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47170T1u007462; Thu, 1 Aug 2024 08:23:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7ugx7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 08:23:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4718NLaO47644942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 08:23:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 950D02004E;
 Thu,  1 Aug 2024 08:23:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E56720040;
 Thu,  1 Aug 2024 08:23:21 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 08:23:21 +0000 (GMT)
Message-ID: <fd23f7fd27a9928fd0a07b2cbe72e1487bf063c1.camel@linux.ibm.com>
Subject: Re: [PATCH] bsd-user/main: Allow setting tb-size
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Date: Thu, 01 Aug 2024 10:23:20 +0200
In-Reply-To: <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
References: <20240731144532.5997-1-iii@linux.ibm.com>
 <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="=-eZugFKfRAHVhtUADjttt"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFm2HgyeSpJEMEv85-RkP0j10_ZzhLL5
X-Proofpoint-ORIG-GUID: uFm2HgyeSpJEMEv85-RkP0j10_ZzhLL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=679 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-eZugFKfRAHVhtUADjttt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-07-31 at 15:21 -0600, Warner Losh wrote:
> On Wed, Jul 31, 2024 at 8:=E2=80=8A45 AM Ilya Leoshkevich
> <iii@=E2=80=8Alinux.=E2=80=8Aibm.=E2=80=8Acom> wrote: While qemu-system c=
an set tb-size using
> -accel tcg,tb-size=3Dn, there is no similar knob for qemu-bsd-user. Add
> one in a way similar to how one-insn-per-tb is already
>=20
>=20
>=20
> On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> > While qemu-system can set tb-size using -accel tcg,tb-size=3Dn, there
> > is no similar knob for qemu-bsd-user. Add one in a way similar to
> > how
> > one-insn-per-tb is already handled.
> >=20
>=20
>=20
> Cool! Are you using bsd-user and need this for some reason? Or is
> this
> purely theoretical? Is there a larger context I can read about
> somewhere?

I needed this on Linux in order to debug an issue where I suspected
full TB invalidation may be an issue.
It turned out to be something completely different, but I found it
useful: setting it to, e.g., 4096 makes full TB invalidation very rare,
so if a problem is still reproducible, then the root causes is
something else.
Philippe suggested to implement this for BSD as well in order to keep
the interfaces in sync.

[...]


--=-eZugFKfRAHVhtUADjttt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head>
<style>
  #pfptBannerh50g9tm { all: revert !important; display: block !important;=20
    visibility: visible !important; opacity: 1 !important;=20
    background-color: #D0D8DC !important;=20
    max-width: none !important; max-height: none !important }
  .pfptPrimaryButtonh50g9tm:hover, .pfptPrimaryButtonh50g9tm:focus {
    background-color: #b4c1c7 !important; }
  .pfptPrimaryButtonh50g9tm:active {
    background-color: #90a4ae !important; }
</style>


<style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><!-- BaNnErBlUrFlE-BoDy-start -->
<!-- Preheader Text : BEGIN -->
<body><div>On Wed, 2024-07-31 at 15:21 -0600, Warner Losh wrote:</div><bloc=
kquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf so=
lid;padding-left:1ex"><div style=3D"display:none !important;display:none;vi=
sibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;he=
ight:0px;max-height:0px;opacity:0;overflow:hidden;">On Wed, Jul 31, 2024 at=
 8:=E2=80=8A45 AM Ilya Leoshkevich &lt;iii@=E2=80=8Alinux.=E2=80=8Aibm.=E2=
=80=8Acom&gt; wrote: While qemu-system can set tb-size using -accel tcg,tb-=
size=3Dn, there is no similar knob for qemu-bsd-user. Add one in a way simi=
lar to how one-insn-per-tb is already</div><div><!-- Preheader Text : END -=
-> <!-- Email Banner : BEGIN --></div><div style=3D"display:none !important=
;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;li=
ne-height:1px;height:0px;max-height:0px;opacity:0;overflow:hidden;"></div><=
div><!-- Email Banner : END --> <!-- BaNnErBlUrFlE-BoDy-end --></div><div d=
ir=3D"ltr">On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich &lt;<a =
href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.com</a>&gt; wrote:<div clas=
s=3D"gmail_quote"><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; bor=
der-left:2px #729fcf solid;padding-left:1ex"><div>While qemu-system can set=
 tb-size using -accel tcg,tb-size=3Dn, there<br>is no similar knob for qemu=
-bsd-user. Add one in a way similar to how<br>one-insn-per-tb is already ha=
ndled.<br></div><br></blockquote><div><br></div><div>Cool! Are you using bs=
d-user and need this for some reason? Or is this</div><div>purely theoretic=
al? Is there a larger context I can read about somewhere?<br></div></div></=
div></blockquote><div><br></div><div>I needed this on Linux in order to deb=
ug an issue where I suspected full TB invalidation may be an issue.</div><d=
iv>It turned out to be something completely different, but I found it usefu=
l: setting it to, e.g., 4096 makes full TB invalidation very rare, so if a =
problem is still reproducible, then the root causes is something else.</div=
><div>Philippe suggested to implement this for BSD as well in order to keep=
 the interfaces in sync.</div><div><br></div><div>[...]</div><div><br></div=
><div><span></span></div></body></html>

--=-eZugFKfRAHVhtUADjttt--


