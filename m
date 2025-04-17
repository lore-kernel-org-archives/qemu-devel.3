Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09971C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LEJ-0000jK-TL; Thu, 17 Apr 2025 05:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LEI-0000ie-Ef; Thu, 17 Apr 2025 05:08:18 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LEF-0001vi-G9; Thu, 17 Apr 2025 05:08:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b00e3c87713so420781a12.2; 
 Thu, 17 Apr 2025 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744880891; x=1745485691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RX6RdA2ZPdP1x/dP/QkgTF0/lqZSn71J8irkE5U7t9k=;
 b=QvXks7xCohD5kJFxy969OVwqpLYQK2vH/k3IfNaLC0hHWWZPGqZ/SJgjTZtTZgUXhZ
 MRBhQPwv0y6HR/wY0Vb6mOGdVNeQVK8z8O5d9fU9tc9/fD4jHqd4P33egOYEhc1l6c4h
 Xgjk8xMNVNDy1N9M7v6G0uUw/apfmgKnjch+NlhoCO3UClI4AsGXA16OA3y6He0nAcc8
 he6UADFw8fOA2PntKiUirF/8vHlDL8b3B4etzavrIlgG/w6TtPf30H+Z/L6CHDdNddaf
 ujVZ37cCUg2jmR7BNLW6/0JSWgbgN09/kV+SJAoIDAFbWIl9ADtjOupqLxrhKwzTIVHv
 O2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744880891; x=1745485691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RX6RdA2ZPdP1x/dP/QkgTF0/lqZSn71J8irkE5U7t9k=;
 b=tO9UU12urUiOn58wlnuYjd24tj6dmDseEKcrBHFxCSpXGu0LrzaP72rY5yVPvZuUxm
 jR6GW0jmJCjPteihF+mc5xsZghKvtHdKafqKKGb1iEzqT2SlMNvRIOxXUNPeHhGn886r
 rZENaVR6sryEMo7tNAD5Rfe+tcwglWeF/Gbg6MQCxiLgcyYlX8E3zXPXiMNhomjiILOV
 pXGthU1ALzuMKQHwCSy+lIVnAvoPaJffA2yTZjgso1Uqkd9NF+knD/dkSE0d2Wlxxu5q
 8jKZcFlFwMArNsIk94bHlxEv0WqR7Ye5yccRb1rut9Yd6AHICF+jA7KUD5fYLT3teUGd
 cwPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUpD/jTv2Fe969uBMCDSn49A+9p+Lm2Oc1XyRLL3LpUzvMP9qAdRvB5IFDIcSmRkzDE1SjaUArBPg4Ag==@nongnu.org,
 AJvYcCVk9CMSrx0FhXXSvBOnrNR1UTPoGiKMrTdD+xcmMmbawMS94q5o0PC5v/VSfQJEjijbXumNYzc5MfU=@nongnu.org,
 AJvYcCW57Tr68gT+UAg0taI8ZsPE5CjH81WUZ96ZxhdUsLBGrjVmONmxTyX3S0ByYcW1j7C4eJP0RyNBvNirbw==@nongnu.org,
 AJvYcCW6QmU0M+AQfN7PW0o9S3YpLT8X3G+BJk7gAee/geZh6rXXe1b0gnLR2au3qhIk166Bu//UUS9f03vGAg==@nongnu.org,
 AJvYcCXbY+t8y80BpT1TRzAA6zkQzgsdi3/g2REj40fe2lzRjXFFSuKPfJ7HT52OxJBWD8M46j+gD3zR6w==@nongnu.org
X-Gm-Message-State: AOJu0YyvKuRn55A/TTp2spb1Rt2y3JrBOLpnIvXp/Dd3gzV79aYmSGY7
 XlkFE1AhtRRhmpRd78OwjjoTZxY3/BuLeqbvX6Ai/umOKonlRyQ+f3hGAWy+LmT095ii55dGQOu
 xezc4xDfc2fyooA4zu8MKQaEfGTE=
X-Gm-Gg: ASbGncv2PL7kWO+HBpJDjYeYRPNNLICO5dMW9unhQXaQpSmnlftAPSCpuxtddOInArb
 NuJDZmQuHabo39T1l1wfE/rDxiXTXR+gGZrHQttrT2U/rTgK/DpmEMEnzJBhvD8FjpKL2vYKc/l
 rDLpeHggS/zKZwjZp6igrWD2uPIKRJA7sUc5W+8x68jmfbj9sjO77eqo9Cv385Z1M=
X-Google-Smtp-Source: AGHT+IErs/6yr7NvmcQpzRNkUCEqx5sl1VpdkRX4//FuoykcHO5spdFERVti8OBP7SHlu/UrylXSXdJOlZ0WZjUnhME=
X-Received: by 2002:a17:90b:254d:b0:2ff:6fc3:79c3 with SMTP id
 98e67ed59e1d1-30863f1b878mr7991510a91.9.1744880890768; Thu, 17 Apr 2025
 02:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
 <3b661309-904f-4670-b5c4-d537a4745c20@linaro.org>
In-Reply-To: <3b661309-904f-4670-b5c4-d537a4745c20@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:07:58 +0900
X-Gm-Features: ATxdqUGQszfJtE52WkySPK7Za_X9zCr63jfmUjXigIWcEzfc2LINVQp2bunB9YI
Message-ID: <CAEDrbUYOBF4QoTCR=JfaV2B33oHeKkL6cMxc-rSmzpZHyhi2LQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib
 function pointers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ab74ed0632f5bd1e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ab74ed0632f5bd1e
Content-Type: text/plain; charset="UTF-8"

Hi Daniel and Philippe,

>>> On emscripten, function pointer casts can cause function call failure.
>>> This commit fixes the function definition to match to the type of the
>>> function call using g_list_sort_with_data.
>>>
>>> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
>>> ---
>>>   hw/core/loader.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>> index 2e35f0aa90..93a8b45d28 100644
>>> --- a/hw/core/loader.c
>>> +++ b/hw/core/loader.c
>>> @@ -1410,7 +1410,7 @@ typedef struct RomSec {
>>>    * work, but this way saves a little work later by avoiding
>>>    * dealing with "gaps" of 0 length.
>>>    */
>>> -static gint sort_secs(gconstpointer a, gconstpointer b)
>>> +static gint sort_secs(gconstpointer a, gconstpointer b, gpointer d)
>>>   {
>>>       RomSec *ra = (RomSec *) a;
>>>       RomSec *rb = (RomSec *) b;
>>> @@ -1463,7 +1463,7 @@ RomGap rom_find_largest_gap_between(hwaddr base,
size_t size)
>>>       /* sentinel */
>>>       secs = add_romsec_to_list(secs, base + size, 1);
>>>
>>> -    secs = g_list_sort(secs, sort_secs);
>>> +    secs = g_list_sort_with_data(secs, sort_secs, NULL);
>>
>> I don't see what the problem is with the original code.
>
>IIUC the rationale is in patch #10 where Kohei poisons g_list_sort():
>
>   On emscripten, function pointer casts can cause function call
>   failure. g_list_sort and g_slist_sort performs this internally
>   so can't be used on Emscripten. Instead, g_list_sort_with_data
>   and g_slist_sort_with_data should be used.

Thank you for the feedback. As Philippe pointed out, the rationale is
explained in the patch #10. I'll make sure to include the explanation in
the commit message of this patch as well.

--000000000000ab74ed0632f5bd1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi Daniel and Philippe,<br><br>=
&gt;&gt;&gt; On emscripten, function pointer casts can cause function call =
failure.<br>&gt;&gt;&gt; This commit fixes the function definition to match=
 to the type of the<br>&gt;&gt;&gt; function call using g_list_sort_with_da=
ta.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Signed-off-by: Kohei Tokunaga &lt;<a hr=
ef=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;<br>=
&gt;&gt;&gt; ---<br>&gt;&gt;&gt; =C2=A0 hw/core/loader.c | 4 ++--<br>&gt;&g=
t;&gt; =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>&gt;&gt;&g=
t;<br>&gt;&gt;&gt; diff --git a/hw/core/loader.c b/hw/core/loader.c<br>&gt;=
&gt;&gt; index 2e35f0aa90..93a8b45d28 100644<br>&gt;&gt;&gt; --- a/hw/core/=
loader.c<br>&gt;&gt;&gt; +++ b/hw/core/loader.c<br>&gt;&gt;&gt; @@ -1410,7 =
+1410,7 @@ typedef struct RomSec {<br>&gt;&gt;&gt; =C2=A0 =C2=A0* work, but=
 this way saves a little work later by avoiding<br>&gt;&gt;&gt; =C2=A0 =C2=
=A0* dealing with &quot;gaps&quot; of 0 length.<br>&gt;&gt;&gt; =C2=A0 =C2=
=A0*/<br>&gt;&gt;&gt; -static gint sort_secs(gconstpointer a, gconstpointer=
 b)<br>&gt;&gt;&gt; +static gint sort_secs(gconstpointer a, gconstpointer b=
, gpointer d)<br>&gt;&gt;&gt; =C2=A0 {<br>&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0=
 RomSec *ra =3D (RomSec *) a;<br>&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 RomSec *=
rb =3D (RomSec *) b;<br>&gt;&gt;&gt; @@ -1463,7 +1463,7 @@ RomGap rom_find_=
largest_gap_between(hwaddr base, size_t size)<br>&gt;&gt;&gt; =C2=A0 =C2=A0=
 =C2=A0 /* sentinel */<br>&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 secs =3D add_ro=
msec_to_list(secs, base + size, 1);<br>&gt;&gt;&gt; =C2=A0 <br>&gt;&gt;&gt;=
 - =C2=A0 =C2=A0secs =3D g_list_sort(secs, sort_secs);<br>&gt;&gt;&gt; + =
=C2=A0 =C2=A0secs =3D g_list_sort_with_data(secs, sort_secs, NULL);<br>&gt;=
&gt;<br>&gt;&gt; I don&#39;t see what the problem is with the original code=
.<br>&gt;<br>&gt;IIUC the rationale is in patch #10 where Kohei poisons g_l=
ist_sort():<br>&gt;<br>&gt; =C2=A0 On emscripten, function pointer casts ca=
n cause function call<br>&gt; =C2=A0 failure. g_list_sort and g_slist_sort =
performs this internally<br>&gt; =C2=A0 so can&#39;t be used on Emscripten.=
 Instead, g_list_sort_with_data<br>&gt; =C2=A0 and g_slist_sort_with_data s=
hould be used.<br><br>Thank you for the feedback. As Philippe pointed out, =
the rationale is<br>explained in the patch #10. I&#39;ll make sure to inclu=
de the explanation in<br>the commit message of this patch as well.<br><br><=
/div>

--000000000000ab74ed0632f5bd1e--

