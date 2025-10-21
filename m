Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7300CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 17:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBG4I-0004tj-SN; Tue, 21 Oct 2025 13:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vBG4G-0004tI-UM
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:22:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vBG4E-0002H4-7o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:22:40 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo1289036466b.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761067354; x=1761672154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BIAnWqxBPiOsBZpGjR+FIM0yGbiTGnXsUbK5l6IyDY=;
 b=mjrQOKx5TIHtEyi1qsG5mZpQ9pVRzeXttotkS7lHTGreA1xMmGxoCg4ENRFScEi39I
 wSlKzI0FvNEJSrq4ZhSO70zDz3c0DaaR04WG6F1nnT8v07fkY75gucxuVqmNCb4dvFZ2
 To0MxQ4vZy+8LP3fmX0Ncs92K9tsYf8rWWoEAHuwPNnDkQxuKxfHkQcTp0ZEmyhFS5NK
 cy04ojmuqULao+eWNPoie6C9UKXrLgyDxWl1WU9Oq36fySOMsg/9gyFWG6FaoldekBML
 OBWyhr6oUHT7MCic2vWbMjdvzyhEv+8tJWVFHl4PVWmEmgV0T48ve5Ua2OpfVvHtFtPs
 lgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761067354; x=1761672154;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BIAnWqxBPiOsBZpGjR+FIM0yGbiTGnXsUbK5l6IyDY=;
 b=lkbXQDDU46fFvqrYuCv5cwKZeVIbH8cgEG/SgNulDTIXXXdOJ98VFFa4EvWTfYZtFt
 cRXUzYG7Y4XQre+mbCBmo3JNC0IIkXJu4AHvhJu9r85VmAXqFspctDyCmtQo/ulhfb/b
 rUfN55QEIcjeonyM2hl5C1YoP93egyqy/wtejdlX0tZQ/X6uFhoNl1uldHnG/qOA4Ypx
 T43nYXkinKTP3YV/cMi+JZPmuxibO8RQhsSoX48HxY8eCEb/HaEJimHulbjCnX4mdHLq
 hcFBdAql+BoMc+ELDdoA+ySKd5+mhQIdbUP58khI3XHYhVIxVl5FtjRLpRHHBuFVtvS4
 O89Q==
X-Gm-Message-State: AOJu0Yxx35kVH/YlwX1hmgPdTiHAs3Ok9tlHBygMOHd6USZLLHL7cmJW
 xcHUftG+Y0bu0aWy4BVvFvgpSDDfYBFFo+24KagW0cPrJP+eXm4e/ftG
X-Gm-Gg: ASbGncsBdoNwDWAOlW8uHt5eyw/ESkWRJxgxSRE8nt/8xqo4s87/4Raz33011aotyAp
 uqCJH4PqulAdEUJtbv3ol8bjL/D5X6gSEZO6gUoNd4JsHf7LMyQLO97Bq9SM/W6iGgde0V6VjLq
 HHulAjUajqOt9j34gJnRA8dvn0EfqUJ7kUc6GuayVWthajYFEtBTsRO+AibndTIU+9PK7N4DYiA
 Ai4ETotS6gMbVjL9m2vH7s7O/b5Y86dpn7BDcCmCBnpqsBYOT9QnIQk4lXztWA9umbPTGf2Gggv
 0VGN/De5wSDRax7r9MnqMmDKhBueowKgt9Iw1kAJjpK348emILlkME4HufyKiG5GjHtFwYG6L9w
 mxw1uW/8Fo6lVH8nLFhK81CotCIsN6tOogB3o0R15ElGriFB6EeLm1Vrsq/sep5Z+MIVTvmTNbi
 AhglvKUqkHF0H0QPHthw3qy87XPPD2xg+lffxpFYpn0m3FDzC69YjNPDqAXSJYtj1u
X-Google-Smtp-Source: AGHT+IHg6OC8LT3g5JyhsFwB53IH+y0N72oOpZfxFwprRWPDHEzadDB//bgBp+KKDSOz2f0uCB8B9g==
X-Received: by 2002:a17:907:6d25:b0:b41:abc9:6135 with SMTP id
 a640c23a62f3a-b647493fa65mr2144859666b.41.1761067353404; 
 Tue, 21 Oct 2025 10:22:33 -0700 (PDT)
Received: from ehlo.thunderbird.net (ip-109-41-115-231.web.vodafone.de.
 [109.41.115.231]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c48a928c3sm9960547a12.3.2025.10.21.10.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:22:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:22:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
CC: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
In-Reply-To: <87sefcoa6v.fsf@pond.sub.org>
References: <20251013112102.2396012-1-armbru@redhat.com>
 <1C757C57-9134-4C72-8034-DEC70FFD25FB@gmail.com>
 <877bwpu526.fsf@pond.sub.org>
 <026FC9CD-543B-4A83-9D1A-0C6F59FF9065@gmail.com>
 <87sefcoa6v.fsf@pond.sub.org>
Message-ID: <C026B931-1D9F-423E-96A6-4225B4365021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 21=2E Oktober 2025 09:50:32 UTC schrieb Markus Armbruster <armbru@redha=
t=2Ecom>:
>Bernhard Beschow <shentey@gmail=2Ecom> writes:
>
>> Am 20=2E Oktober 2025 12:32:33 UTC schrieb Markus Armbruster <armbru@re=
dhat=2Ecom>:
>>>Bernhard Beschow <shentey@gmail=2Ecom> writes:
>>>
>>>> Am 13=2E Oktober 2025 11:21:02 UTC schrieb Markus Armbruster <armbru@=
redhat=2Ecom>:
>>>>>Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>>Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pix=
man_shareable_free())
>>>>>Signed-off-by: Markus Armbruster <armbru@redhat=2Ecom>
>>>>>---
>>>>> ui/qemu-pixman=2Ec | 4 +++-
>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>>diff --git a/ui/qemu-pixman=2Ec b/ui/qemu-pixman=2Ec
>>>>>index e46c6232cf=2E=2Eaea09755b9 100644
>>>>>--- a/ui/qemu-pixman=2Ec
>>>>>+++ b/ui/qemu-pixman=2Ec
>>>>>@@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable =
handle,
>>>>>     Error *err =3D NULL;
>>>>>=20
>>>>>     qemu_win32_map_free(ptr, handle, &err);
>>>>>-    error_report_err(err);
>>>>>+    if (err) {
>>>>>+        error_report_err(err);
>>>>>+    }
>>>>> #else
>>>>>     qemu_memfd_free(ptr, size, handle);
>>>>> #endif
>>>>
>>>> Thanks for the quick fix, Markus! The patch is reviewed and I've been=
 testing it for a week=2E Who is going to merge it?
>>>
>>>I can do it=2E
>>>
>>>You provided
>>>
>>>    Tested-by: Bernhard Beschow
>>>    Reviewed-by: Bernhard Beschow
>>>
>>>without an e-mail address=2E  Intentional?
>>
>> Oh, that wasn't intentional=2E
>>
>>> If not, should I use <shentey@gmail=2Ecom>?
>>
>> Yes, please=2E
>
>Done, PR sent=2E  Thank you!

Nice=2E Thanks!

