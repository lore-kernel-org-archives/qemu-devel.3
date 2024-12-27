Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82A4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 00:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQxwP-000810-CJ; Thu, 26 Dec 2024 19:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tQxwJ-00080S-OP
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 19:10:53 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tQxwF-0005so-Ll
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 19:10:49 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53e64f3c7d0so43356e87.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 16:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735258243; x=1735863043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kiav1LOLgUI1s57efjcsKJrgv00INHU1sewLAsIjnvs=;
 b=GY5d+tiqFahgmaJzVYKo/9spmCUEuyJh1RuL8vfEdkr9dFy9/hh+oA0Cb2FTqmVtqE
 5tiwjnghzPBEjcTjz15q5nSuB638xqC/PebkaP2ZbJMkWEDDtq7KEorJSYX6bKNha9EX
 r7OMG/fg8aXhz6aFCwm8DnmVqY8v54n2/htluhvdkyNcmNWGUpeO1uMlXWTJe3vXPWvZ
 9UzGGQM6dx6DcOT11faosHu0AK3GzxDT6cVTQsDvFG1Id/DcD6Rf5iua95PXYPQiZS/q
 CyJrnRn9FCXrsTLTJQa9H8Q5C4joY1tPKC3ZBtCb/GutV0DODNsNDl2GjeOEjvfRLHF9
 kHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735258243; x=1735863043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kiav1LOLgUI1s57efjcsKJrgv00INHU1sewLAsIjnvs=;
 b=CEUDFSmkkqci7KGOtEv1QO1m5CzqQMVQeBMbKtGQKngSrSn7iE6o7ieSCpr1624CZQ
 Qe1J7x1fN6pNAFuv+Zzwww7oP5thtB0ZmOIEmLRC+H75qd1B1tIz/F24F4OYAC03V2tl
 CSOrTP9QS+h4LmKeyrAxqmfAN865AhxqfqtzVc0nXHfNDen56gfWWJ1d8aZCuV56op+R
 VTep73O1bxmO4CEI4A3n5/myqYwfL1yudiW9IhJMQZln5VcEzjxu+k/8v4NLKxFMamLM
 EbxuAvVRQhvHww37cmHVUUL7MmVKXJikTEWNpFhWc9jHvgjqEmsCC1Yhq3izMyJlwMfc
 KQ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNP1YTAr5mjw4LwzsxvDCZF4QEQLFMUE9kWUk3T1eaFcH/5i2mQ5GAfjM5HLa3OOv8/b4iItd9p0Vo@nongnu.org
X-Gm-Message-State: AOJu0Yy0xmVDIZ6cQTMv5EVs8Puv4fRQVwFI9A6GR2DkVLm65J9InmR5
 w44rO7W2qykoV8cIp0Pb7k/9KAh77LYu1LpM1RTQN3xrogkNAzH3FpOcReAWnyAwAYUztAV6FfP
 kKzvR+S6fTR+J/xo3oq0UDVpji8oGY48Pm8Yo
X-Gm-Gg: ASbGncuYdVzkdsHT3y4lVlFtibvlWwqLT6xV0m+zhQlVMJKrmXUY6XuKvCiQuUP/07H
 DwB0DlPqDjR+P+zy564UbDxEH8H9zzCrAsIRQDvSVdPhktS3iXShcjs8=
X-Google-Smtp-Source: AGHT+IF7XijT91vVSHy7br0tl+wk2BB+fCV33r+iK8J5LFP88iTSsw1rBNtf0T2QS/J1qW6jJYut5v1E9dzg+pcU+mw=
X-Received: by 2002:a05:6512:3d25:b0:53d:f0a2:1fe3 with SMTP id
 2adb3069b0e04-54229455f32mr648484e87.2.1735258243322; Thu, 26 Dec 2024
 16:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20241226130311.1349-1-tsogomonian@astralinux.ru>
 <CAO=notxZWVBShpD_Y-GJZvXSY6v7tURt0yJ+aQFDm7LpdD8ikg@mail.gmail.com>
In-Reply-To: <CAO=notxZWVBShpD_Y-GJZvXSY6v7tURt0yJ+aQFDm7LpdD8ikg@mail.gmail.com>
From: Hao Wu <wuhaotsh@google.com>
Date: Fri, 27 Dec 2024 08:10:31 +0800
X-Gm-Features: AbW1kvZ1aDz9P0EVUU9HCSHM0u7JLrUWnbs8m2dkKERcoIXIodlf3W-OYp3Ns7I
Message-ID: <CAGcCb11XxgJ9Of-XvgHYBmxrz5yCjktZWe6d8jwbV0NOjkHm=Q@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: cast rpm to uint64_t
To: Patrick Leis <venture@google.com>
Cc: Tigran Sogomonian <tsogomonian@astralinux.ru>, kfting@nuvoton.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: multipart/alternative; boundary="000000000000305c75062a354b84"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000305c75062a354b84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 3:02=E2=80=AFAM Patrick Leis <venture@google.com> w=
rote:

>
>
> On Thu, Dec 26, 2024 at 6:00=E2=80=AFAM Tigran Sogomonian <
> tsogomonian@astralinux.ru> wrote:
>
>> The value of an arithmetic expression
>> 'rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION' is a subject
>> to overflow because its operands are not cast to
>> a larger data type before performing arithmetic. Thus, need
>> to cast rpm to uint64_t.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
>>
> Reviewed-by: Patrick Leis <venture@google.com>
>
Reviewed-by: Hao Wu <wuhaotsh@google.com>

> ---
>>  hw/misc/npcm7xx_mft.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
>> index 9fcc69fe5c..e565cac05d 100644
>> --- a/hw/misc/npcm7xx_mft.c
>> +++ b/hw/misc/npcm7xx_mft.c
>> @@ -172,8 +172,9 @@ static NPCM7xxMFTCaptureState npcm7xx_mft_compute_cn=
t(
>>           * RPM =3D revolution/min. The time for one revlution (in ns) i=
s
>>           * MINUTE_TO_NANOSECOND / RPM.
>>           */
>> -        count =3D clock_ns_to_ticks(clock, (60 * NANOSECONDS_PER_SECOND=
) /
>> -            (rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION));
>> +        count =3D clock_ns_to_ticks(clock,
>> +            (uint64_t)(60 * NANOSECONDS_PER_SECOND) /
>> +            ((uint64_t)rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION));
>>      }
>>
>>      if (count > NPCM7XX_MFT_MAX_CNT) {
>> --
>> 2.30.2
>>
>>
>>

--000000000000305c75062a354b84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 27,=
 2024 at 3:02=E2=80=AFAM Patrick Leis &lt;<a href=3D"mailto:venture@google.=
com">venture@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 26=
, 2024 at 6:00=E2=80=AFAM Tigran Sogomonian &lt;<a href=3D"mailto:tsogomoni=
an@astralinux.ru" target=3D"_blank">tsogomonian@astralinux.ru</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The value of a=
n arithmetic expression<br>
&#39;rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION&#39; is a subject<br>
to overflow because its operands are not cast to<br>
a larger data type before performing arithmetic. Thus, need<br>
to cast rpm to uint64_t.<br>
<br>
Found by Linux Verification Center (<a href=3D"http://linuxtesting.org" rel=
=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>) with SVACE.<br>
<br>
Signed-off-by: Tigran Sogomonian &lt;<a href=3D"mailto:tsogomonian@astralin=
ux.ru" target=3D"_blank">tsogomonian@astralinux.ru</a>&gt;<br></blockquote>=
<div>Reviewed-by: Patrick Leis &lt;<a href=3D"mailto:venture@google.com" ta=
rget=3D"_blank">venture@google.com</a>&gt;=C2=A0</div></div></div></blockqu=
ote><div>Reviewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuh=
aotsh@google.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
---<br>
=C2=A0hw/misc/npcm7xx_mft.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c<br>
index 9fcc69fe5c..e565cac05d 100644<br>
--- a/hw/misc/npcm7xx_mft.c<br>
+++ b/hw/misc/npcm7xx_mft.c<br>
@@ -172,8 +172,9 @@ static NPCM7xxMFTCaptureState npcm7xx_mft_compute_cnt(<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * RPM =3D revolution/min. The time for o=
ne revlution (in ns) is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * MINUTE_TO_NANOSECOND / RPM.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D clock_ns_to_ticks(clock, (60 * NANOS=
ECONDS_PER_SECOND) /<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rpm * NPCM7XX_MFT_PULSE_PER_REV=
OLUTION));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D clock_ns_to_ticks(clock,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t)(60 * NANOSECONDS_PER_=
SECOND) /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint64_t)rpm * NPCM7XX_MFT_PUL=
SE_PER_REVOLUTION));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (count &gt; NPCM7XX_MFT_MAX_CNT) {<br>
-- <br>
2.30.2<br>
<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000305c75062a354b84--

