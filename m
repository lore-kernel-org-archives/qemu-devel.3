Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B11CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvov-0007dG-9B; Mon, 20 Oct 2025 15:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAvon-0007c5-RV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:45:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAvoj-0007fm-QX
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:45:21 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b456d2dc440so778383166b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760989515; x=1761594315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INq7wg2Y6WBzFJvz6a9Id+InKjDpVsX+YMJN5bL6ovw=;
 b=O+YjFAwLD6OcHCF5HBQPPk7/phN26p8whWzrrVZZ/vcwq3oJWUqlwhjDl9//eZ0ZkR
 ZF3urWir4M8auQQkSGED7F+HqOpiHsDLDahQSxnhSANrwuRenSdzGKjvfIhCNJ2T4vje
 ZCwVVHuAmzvD2b28BJh7XwWVh8Hc7tZYyma5RQMOKtNoCkGGBRKvpp9Zb87taI2ayJrv
 gMJ1Jm+8OuH5lmBZC9+7L8NiRm42j8BGWge+SmRA+C+v6Ue0hOg5XkOXTgsMKGwGjJDY
 WryHBh62kATxT5zRHHdzYFKTD+l/aeaR5kjj4mHEoT3xmhlfB6MvQ07sQyJWmto7Ca3y
 nn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760989515; x=1761594315;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INq7wg2Y6WBzFJvz6a9Id+InKjDpVsX+YMJN5bL6ovw=;
 b=e5dKjGhtIstgHA8pvBpPd8V0OYxtbLZEhyzuDPDPdM2diU25fn5fN0NjEpjZtH1OH+
 OgyqIFDedgIuhcJ0aNDjX1BFXCdio/RJqgWdRqtuTjJUFXXduL/lUqkTI7vK8/FtEXfx
 DNQQWz5nCmDvCNUdMg73XXRuyPF7JP28kMXU8xJXOyUrvK7JefpZp4SR+xJI1bdHYxB3
 gUTYIUaJCVnCLcfjTXIiH9sAr+U2LcYvEufmMl9TytcXr5iglbGpFmU0E6uGgZLtcgE9
 W+wQvjnrF7cnkBzsuVcEsodkWjifpYYxCxdtrCSGnj2+SlcVpNYKtnOPgW6p3U7PfrKv
 7uKA==
X-Gm-Message-State: AOJu0YyD0i6aUrg1BJStqOIeJRhFpgiAH6soYMZAIUtAVR2Ldh5/93OM
 bUqHe6SGPWe78a+fhWyYuyxgoMk3UOdbYvLnOAPCbDBO8eVgcIJMQCQn
X-Gm-Gg: ASbGncs/APaLDrQQ/qfRUVIoFLFB2a8A5O1nFAa/tZV+51P8B/OHHEC4ZUm1eTiuFpo
 C9mNVRSQRFLbTNXaBqKe/clldwLnsE5EnuwAH8fjX6JLGn2YLpM9FAf1fH/qBSxxPKHSAb/so/m
 jXEbRRALZSz1hdJv2gwxTyTygsU61Y/6SDUIlHrHbUy/tgu+HFFFI3aPV1whpIyNEOMSoRqe8ob
 zhFfA1Rvp+DTdLiZh3qd9mTF+ttHDu4XxdA+OaMM7Y5DD0IYch1poMWu7Jb5/35aADVO8Rx8aVb
 NCkLQAygq4W3qNijFObeX/jiV3t+sNvTHw5ui5S5qp5Vh5fPVETw7/KZKviepP5CtHKvnZWepuj
 7A+FWJkdAfgkW89bxfDOa91Hke1jZEJ6cE1UyeJ1YbShLmhGKLVi9+Ursjlf8R9X0wgKZ6ADa/T
 N9Q7hHTbcHaG+phqDt93DjjnUze20L5CRIR/h094HxZV3o4L1vjXINPrPWxng9nQ==
X-Google-Smtp-Source: AGHT+IHIsCUz++LiGJtnqxWAy3tcsENfgUwQoKY1nPz+w0nvLeNYHjCIOCfBtfBk2VQngwO2sLDUhQ==
X-Received: by 2002:a17:907:d13:b0:b3e:151b:849e with SMTP id
 a640c23a62f3a-b6472b5fb74mr1804105866b.10.1760989515108; 
 Mon, 20 Oct 2025 12:45:15 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-077-183-007-223.77.183.pool.telefonica.de. [77.183.7.223])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb52621csm878965266b.59.2025.10.20.12.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 12:45:14 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:27:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
CC: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
In-Reply-To: <877bwpu526.fsf@pond.sub.org>
References: <20251013112102.2396012-1-armbru@redhat.com>
 <1C757C57-9134-4C72-8034-DEC70FFD25FB@gmail.com>
 <877bwpu526.fsf@pond.sub.org>
Message-ID: <026FC9CD-543B-4A83-9D1A-0C6F59FF9065@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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



Am 20=2E Oktober 2025 12:32:33 UTC schrieb Markus Armbruster <armbru@redha=
t=2Ecom>:
>Bernhard Beschow <shentey@gmail=2Ecom> writes:
>
>> Am 13=2E Oktober 2025 11:21:02 UTC schrieb Markus Armbruster <armbru@re=
dhat=2Ecom>:
>>>Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixma=
n_shareable_free())
>>>Signed-off-by: Markus Armbruster <armbru@redhat=2Ecom>
>>>---
>>> ui/qemu-pixman=2Ec | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/ui/qemu-pixman=2Ec b/ui/qemu-pixman=2Ec
>>>index e46c6232cf=2E=2Eaea09755b9 100644
>>>--- a/ui/qemu-pixman=2Ec
>>>+++ b/ui/qemu-pixman=2Ec
>>>@@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable ha=
ndle,
>>>     Error *err =3D NULL;
>>>=20
>>>     qemu_win32_map_free(ptr, handle, &err);
>>>-    error_report_err(err);
>>>+    if (err) {
>>>+        error_report_err(err);
>>>+    }
>>> #else
>>>     qemu_memfd_free(ptr, size, handle);
>>> #endif
>>
>> Thanks for the quick fix, Markus! The patch is reviewed and I've been t=
esting it for a week=2E Who is going to merge it?
>
>I can do it=2E
>
>You provided
>
>    Tested-by: Bernhard Beschow
>    Reviewed-by: Bernhard Beschow
>
>without an e-mail address=2E  Intentional?

Oh, that wasn't intentional=2E

> If not, should I use <shentey@gmail=2Ecom>?

Yes, please=2E

Best regards,
Bernhard

