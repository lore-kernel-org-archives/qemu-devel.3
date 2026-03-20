Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3981099B32
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eI2-0005ic-Bx; Fri, 20 Mar 2026 14:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3eI1-0005hm-6V
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:09:41 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3eHz-0002pC-P9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:09:40 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-89a1d7cc7f0so19578136d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030179; cv=none;
 d=google.com; s=arc-20240605;
 b=WerQ3bcvGhapflrIHiVRKpt/KqGJ8gteaXEJ0qVS/oh2LZM5ECiopv3Yee+aUWAQMZ
 6gzKR5UdJbkptoicfcM3LSkgyGSc0I3TDSOb6dTVPL1kUz/+btOr3kXfIlypa0am+C7V
 FoOsPR5vLcQD6eyUTgF8DD5NMq63STWVamfXn1dbWTMaK067NG2/eGP8k2ZkRpS7h0Bc
 jMWahVcuTUf5r3OK6E9H4Qv1n7nAXyF8APFHGGGr+1naWGnWa70TXo9Mw0CCutqR+S6K
 Kjf3laPljnDJYpNTWDX6N3ojyrQwUZbsGqqIzoCaBcNlYr6AEcxLpfvK/9G1tWvPNp1E
 a/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D4eZ5L3WbfJ277KwoaFP5N2zW6pKYLcK7fIYk5NQGYU=;
 fh=c0erNo+sJ29Z5IwzOrma4WhJmO9gKlXEZkjXKP7KWY8=;
 b=MwUqhK1uLAlx44ZrUJiz2FQUwVt+JvWmh0rbbSVigaR/ydeYwBK3d5JHFuoSqhwoo/
 ZG5RtYxV6gtmD9RG++b6vk58M+9opE2dELE2wMrDzgL5e6y878gmnCB4q0JH7Yoc8UiW
 t1umcR7UKAhqVNMNrrhVQV/AbDwUNp0BQ+E2wPc/xGcTceiedy+CMx7MQdJ1G2bUW1Me
 SfTG69pRfa5ahh6Qc/30/AFk4aYVjsXl37MWsF83uDWkeDEk2KyONpqA36IK4GAf1A4E
 c72bOMWoHrpWoWxh6QbLFlCPNacCZZ3ldoEHdw/MPKhhVY+Slmn/VPxKJeE5+0dN3BGp
 g6Ng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030179; x=1774634979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4eZ5L3WbfJ277KwoaFP5N2zW6pKYLcK7fIYk5NQGYU=;
 b=aIxesykOGvKPjh9qECchls66hfcxYIrVbVlsX36PdJeGEkT+PmWIjpA9Gi7fW7wQiY
 mkOWcLAbKR9rOz17SwDVfOKX8zf7q6ezEbFe7nhZcbfwmd5ah+ZZwDyZTmNQ2SZQ/8s4
 ySDRn5iqbsSWV4+9F2aTN02Aij6wzirq4Pm/hRDze66knYbhUpRg6FhSmDW0uqolnM8f
 +TzBwvYDfUg8a/zKcMIytmMPLIWX0AyfuBdBcXNPNTLh2IdOsJLKsnUO8fZlOwol+niR
 iK12MPPdRoiNaxWLenTTOTyCO5GrPh3XmiHgZYFcwyPmWTAxXuon9T6Ow197GUsL2WeN
 Z4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030179; x=1774634979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4eZ5L3WbfJ277KwoaFP5N2zW6pKYLcK7fIYk5NQGYU=;
 b=OWlrMyHd8TlcbCFw+09+hHb5YRuV1zOUEGV63dZUzxDROcgPjjwFFK3tbLMFWLrWvM
 9INrXM7WYoNnovB6JQTtwy6dlkb4NysJTLyVwuJJvW4wDVoiLUd6xmBF+Ad7SzAeqYVE
 DFEi402LsV7ogmAvpwwFCQG6bu9TmNHjiweIdBdwqsC395aPs2CC7JBfV1nx4h1FcQYf
 AfwuiVEIgG8CEOPoDGmy4QEdMMzpeiHI8uu2vUN30jT89Y5Z5IUanMnMIWzRKpp2WoyJ
 JOQ5d2AsjGfBSIxBuV49J7HUPLRIftDW6q85sfbv7obLgjrW14VyqbigS61JFy9zemp5
 jJXQ==
X-Gm-Message-State: AOJu0YytiSGPwvjUnj6mXOltK7Wq2CHSXRdTaKUbOcas8Tbk53wD0Z2s
 7O3h3CbhMlxQPqwH40T+Z64nRC6C1wmAiyQSwY4s+9G02C8DUOZJ+7pxDA2HltZPvIP7HJ4Mx83
 0OVULiwxqmfIqnrECMRky5ouXQ93meD8=
X-Gm-Gg: ATEYQzx2mthDu50hTcF6K6LPhKUk0vQLe6rgJg7ONAek2mT/85r/RKJqNNQjFZ4x8Qw
 rTbHcU6ljkMTFb7Qde1XdwlbUpBesrxkxg44REyjSljAWEQI7NJUH/9MSoFO9N8n5f3NVTZvfXF
 j5mqcbvgYzIQ/uUgs54383jw7yONXsKfCi6dg967ZlxQXbIogjuW2OgaZ9AWJJYjtxzSPv4LdkT
 Nc/yY0K8vZcth5J+TZR9aQg9dU4qZukyYORy/xwn9gPN1XAXC4LzGkgLWWneEnk9r+ziPjQea0X
 Ptb4SFOminjvU0Su/7EEBoW4XWTmeZObxDoWTaxase0a81MrRoVXmzQ7Hk04D95WupU=
X-Received: by 2002:a05:6214:2424:b0:89a:9b1:a224 with SMTP id
 6a1803df08f44-89c85a959c2mr62006706d6.34.1774030178468; Fri, 20 Mar 2026
 11:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260320165021.39521-1-philmd@linaro.org>
 <20260320165021.39521-5-philmd@linaro.org>
In-Reply-To: <20260320165021.39521-5-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 20 Mar 2026 11:09:27 -0700
X-Gm-Features: AaiRm53xemc8dbXuOlUNUHOZEDvK-RNQA2KrmOwf5kFuVzFEha85VHWQB8T1_h8
Message-ID: <CAMo8BfJ3me9ZaxzP+1ixgy+0-fjP5_4zwjsUYW=HC2YJ=B6__g@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v2 4/7] target/xtensa: Display [ID]TLB header
 within dump_tlb()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Mar 20, 2026 at 9:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Move common code from caller to callee.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/mmu_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

