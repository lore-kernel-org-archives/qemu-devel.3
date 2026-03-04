Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D145EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 20:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsak-0007h0-G9; Wed, 04 Mar 2026 15:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsaj-0007gi-Hk
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:13:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxsah-0005dS-VL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 15:13:09 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624HHm1g2612022
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2026 20:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rrg+4hGwfvSaVOjSxu5uBKlU
 p4H01ONYPXhzC1zZLIg=; b=YJoydO/TTnz02nlRbryShe3g/CL37zECl97GqssU
 riGR9IDMJQznbOd3INta7RM99zqel1LCiJIrWhWgSrlhTjjLJvWfeNiBaYGCwqey
 gVCxw5zcfOiaseT0XtnTiJoJcj4dqvCbtgtFmZFQFwLLz807FFHmXwRUUNopfggk
 XI19S2yDN2yIaYanvBPnzQLudkWIiqCKLV1vUDafp8GFk8K2HK3rVMUL6l8HfUd4
 FKjJw8W51BACVPSRHvK8FPLFE7EsgH0j9A40n48ci2qQ5yg4MuRazBRqRWkrO9p6
 j0VDx9kShRtLADolslKYJBh41lDCMx06hAg8v1i1v9FtmA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0w8gxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 20:13:06 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7986c067508so114575557b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 12:13:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772655185; cv=none;
 d=google.com; s=arc-20240605;
 b=A0iaGNdmMDpF0U7qXC9uDXSygzM5HKxqqDGdan+iK3kQXRAkZ8/6KbSnfmoi929ZFS
 ye8u6Hs7YL+4nxBpPvsVEEl0sMQxCgg5sUx+oU8iRAnR7cbfO/zfSryepHzvWAjhDZf2
 ParBVlMzDtMjiiQxvnJ85Sl1wkTz/vpFKVstHZQ/hD/NRBc5BsVhWPsHQArYZ9jvFGCo
 jepVXQM/etrWVe0C6+6sz0psUCk5xiASvV29C3PNmAqSHFGpBUmzHlAEuRRQ7QN2HSaw
 EhAAKHkBaLXHNJt4ol648yiVRs9NjQQj1GTwOkdjgw/CSWviTrmHa7TWYJiqbCpG/nE6
 QSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rrg+4hGwfvSaVOjSxu5uBKlUp4H01ONYPXhzC1zZLIg=;
 fh=R/vQo+F3P7cskhbcTRvxnYob5SuTppuwB4Jiv8U8dMU=;
 b=G+k0/3UnchRCPIEk8DSCBNIlzX9sLxF18WLlI0UM35bqjzqgQNEcVUuUdkAYXiRQXC
 S4ZLaAR3nURcKZuP++7wKLIA4JmNHC6wiUcC81Zuf/x0E2IX6c8uvX57jNg0Vux2Hn0S
 na3/eJNQZIRMmE0ErullhZUn8Vw5PRlgOnZtWV7Mg7WSEBF29ZK+PK0cLLQ0w9ZTXZkK
 6YK4N/nt7Ihj3Kq8esCEGLv5KTdNGrVs6GuY6psCKvAmdCMxERWQREJvxf655PspW6SA
 Y3pwbmLDAOY5tX82soG1zhX+yQ68l6KcfDUfgNXPwMRM+2a8i1wjIM3815vPReaNba1A
 30hQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772655185; x=1773259985; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rrg+4hGwfvSaVOjSxu5uBKlUp4H01ONYPXhzC1zZLIg=;
 b=GQMzOG8UKVuJ8gLPVb6kKgabD20D0FInX4LoQOhaBEEwajZILvjYELcQgP6cUbAjjo
 BzOFygP3imKv7Tov2Z4G8k4t/Oi+sq9bpdv2tmsVY+z/s1BF7AZ/V9J43Nv5r5OtBf/E
 M8hcpjL6NiZFBAmzNLF5o7RQRo4ykt0rFRfyEAkGcmSQ4QhqbTh09dluuzbDrdqUo606
 ySZvulVjwH9SJDUWwGzUiKL6ts2XGwuuvYoVtd7qEqyxrLNtK1RrKLzUcJXywpn9oZe+
 7e3/ZlMyTiG6LiXdUiima3K5elEywt6m7VWg9ZfPAfo9BuifiGllG2uOnV1dZh0ZQY8m
 KxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772655185; x=1773259985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrg+4hGwfvSaVOjSxu5uBKlUp4H01ONYPXhzC1zZLIg=;
 b=ANYoiL85byti+7gTqa38IiKBJqQZLcZNiffDQFJeChFNJnAKFx7f6O8fU2/K7guWmz
 axILlwYBd5GkPOJVudEO319NnCqsglmlL4nERi3ULzZqUBB3VKq4NncDjBW7t9tqEBNF
 MHyKVXjBaje2qCS9Od3XQ6kVMD+dsrvwu3jm5RcyIIfaYBriZ1erkV3mY9KFyBH+5qLu
 xLUqMA2/KSGW4Nov/fsiAe6WB7PzQoo64EUnhD0GaK7RfAGOvswbL0hm0Z+I55NV/yNy
 q7D0fDZsR7fD9c9UbCvP3D7fBQxF36oyyO/ng2JlsycIHnnrl+p+AWZp2LzAKKvrnL0g
 +9ag==
X-Gm-Message-State: AOJu0YwTppLwBWSWiPmdNRRGQqAhraXsvXE5OAAwEmn4EzQ+1l2eE601
 fCMNDzVFe13GWtgJR/wlaVe6PHpATGqC/XPvmiwHKz0j2bQt1EqClpLZPA3WnuR6C0QZx4WWSey
 VPggk5xF8aBrbg8vOArVBJMM1CgSAR+1/dKSOrYepd1IBzi3amCTy3/2erayisfu0oJjvz0ZIn4
 7PvnBA8VoDtui3EhGmbnjmIcRz6nNrEd5QkSPD9fRf
X-Gm-Gg: ATEYQzzSCr8Gr91kfiCPe31N7uTpL5vvK+ugiRXSW3O0KRIOTTU94JWjUFfb7Z/8rXA
 M/3kNcFe+h21HOAn0ld4DWx3bNZbPxTyimrMXYEj/ouukmCg5uk9Dm22VFIh7XP+/s4VT3dgky1
 UBBoZoXfXpTh1gWIoEmF5Pr5u1/0vYdkNDdcNEwQzHjdiTJ2G1kc8WwFXtH/XD/QqEs8cYe7enj
 czbFSs=
X-Received: by 2002:a05:690c:38b:b0:796:4b03:7390 with SMTP id
 00721157ae682-798c6c01c6emr28388297b3.27.1772655185305; 
 Wed, 04 Mar 2026 12:13:05 -0800 (PST)
X-Received: by 2002:a05:690c:38b:b0:796:4b03:7390 with SMTP id
 00721157ae682-798c6c01c6emr28388017b3.27.1772655184854; Wed, 04 Mar 2026
 12:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20260304200901.1281731-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260304200901.1281731-1-brian.cain@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 14:12:48 -0600
X-Gm-Features: AaiRm53FmRP7Xtg0DnXj2tVYCUT_HY4q1f7VhXr5_ogz_9VQJ38AABDa1CftAu8
Message-ID: <CAEqNhNYUaWLL6H5AvaXOqvP1a15AazbLyidv3GnwmHWjiPGWJg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Update hexagon cross container to 22.1.0
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 berrange@redhat.com, alex.bennee@linaro.org
Content-Type: multipart/alternative; boundary="0000000000009a529c064c387215"
X-Proofpoint-GUID: FyjmjhvNCWTAwguTY9afHJE2VjRm1Lu6
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a89252 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8ii3TZy4TzlH2xjA9_YA:9 a=QEXdDO2ut3YA:10
 a=ZmtH7Rwo33MBwwFty38A:9 a=uXHbqDiU5CXHRetN:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2NSBTYWx0ZWRfX3hX4/HyAf/YL
 5OZgL3I4H3Hj0EaAIjTlAg9cOfnZrAI23WiahfJHOQzQG4MUfjDTz4P/GoE9rPUa7grfxlEk0I3
 97VT22Wy0AOsK3UHIPfypchLfpHpdDDC2oqlZuTyeYRR5PggrTG9M4F7Non6fPY1zP8GZajIXYI
 Xx7OBe5P7gCygRpQ20KnYg2ugr6o8yshFl34DNRZsQkxj+f26q6SPWkwC6MGMZo3m9gO29ulkfj
 m1yXSt4cdn4l/YObhMOJTUawZlehQb1r543uuVFemijEUQvhPTWe7oho0jczp7vvtqVXaDENqEj
 /T2T73+e91l1VtP1qiU0nxNKnVA1iV4ngEJTa9HJInTSn0lOmye8/NZTEV75lVtaAzuCmM3nOnP
 42FASsi7bjzcSCvRNRL/KUuXqCDVbMoLUnXH4u5fDoNGVHPAZ1wI16XXkUpHFzEgSrZIxNHtLHS
 lFNJ74XX7zSEb4AmwEw==
X-Proofpoint-ORIG-GUID: FyjmjhvNCWTAwguTY9afHJE2VjRm1Lu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040165
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

--0000000000009a529c064c387215
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 2:09=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Update hexagon cross container to 22.1.0
>
> *** Note *** that this patch should not land without
> "tests/tcg/multiarch/linux-test: use portable alternative for dirent64",
> a newer musl present in this toolchain exposes this test issue.
>
> Changes in v3:
>  * rebased, dropped debian changes (already landed on baseline)
>

Tsk - a bit careless here.  Should have said "Changes in v4" and the series
should have been labeled "PATCH v4".

Sorry!



>
> Changes in v3:
>  * change debian from 12->13
>
> Changes in v2:
> * none -> v2 was unintentionally chosen for the first rev of
> this patch.  :(
>
> v3:
> https://lore.kernel.org/qemu-devel/20260303210553.2044313-1-brian.cain@os=
s.qualcomm.com/
> v2
> <https://lore.kernel.org/qemu-devel/20260303210553.2044313-1-brian.cain@o=
ss.qualcomm.com/v2>:
>
> https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@os=
s.qualcomm.com/
> v1
> <https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@o=
ss.qualcomm.com/v1>:
> <none>
>
>
> Brian Cain (1):
>   tests/docker: Update hexagon cross toolchain to 22.1.0
>
>  tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>
>

--0000000000009a529c064c387215
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, 2026 at =
2:09=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.co=
m">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Update hexagon cross container to 22.1.0<br>
<br>
*** Note *** that this patch should not land without<br>
&quot;tests/tcg/multiarch/linux-test: use portable alternative for dirent64=
&quot;,<br>
a newer musl present in this toolchain exposes this test issue.<br>
<br>
Changes in v3:<br>
=C2=A0* rebased, dropped debian changes (already landed on baseline)<br></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace">Tsk - a bit careless here.=C2=A0 Should have said &quot;Cha=
nges in v4&quot; and the series should have been labeled &quot;PATCH v4&quo=
t;.</div><div class=3D"gmail_default" style=3D"font-family:monospace"><br><=
/div><div class=3D"gmail_default" style=3D"font-family:monospace">Sorry!</d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
Changes in v3:<br>
=C2=A0* change debian from 12-&gt;13<br>
<br>
Changes in v2:<br>
* none -&gt; v2 was unintentionally chosen for the first rev of<br>
this patch.=C2=A0 :(<br>
<br>
v3: <a href=3D"https://lore.kernel.org/qemu-devel/20260303210553.2044313-1-=
brian.cain@oss.qualcomm.com/v2" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/qemu-devel/20260303210553.2044313-1-brian.cain@oss.qualco=
mm.com/<br>
v2</a>: <a href=3D"https://lore.kernel.org/qemu-devel/20260303175444.154004=
9-1-brian.cain@oss.qualcomm.com/v1" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cain@oss.qu=
alcomm.com/<br>
v1</a>: &lt;none&gt;<br>
<br>
<br>
Brian Cain (1):<br>
=C2=A0 tests/docker: Update hexagon cross toolchain to 22.1.0<br>
<br>
=C2=A0tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---<=
br>
=C2=A01 file changed, 7 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--0000000000009a529c064c387215--

