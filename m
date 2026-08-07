Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401FEC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsE6g-0003nl-NF; Fri, 07 Aug 2026 02:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsE6a-0003kg-3w
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:30:56 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsE6Y-0004Dg-HH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:30:55 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8143daf89c7so31132227b3.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 23:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786084253; cv=none;
 d=google.com; s=arc-20260327;
 b=dop8G9ciiAxyYSFDhQtF4rgminEXx+5ZULJkbDCOapcAMVBbOVKIHVn9z/HInwUEV5
 ku+m7CXyfOro080VJjFGFkpMOJAtRgA7/bSMNb+/5DUU9EovT1BZJVqCxkvLccxeWQPj
 EPWOAejx1vCOxIvLBEnfhv1x+BPf/8zgXnHKiPm2VR99umtyTqkplE6RTlVr+gjW/5iM
 wI6WrZ+x5LE9MXxe5doqY8nEb+XgnUV+W2SBvPrPxlyr7muF8Cvf2RiQDZgUt2yU8EpE
 RwYrI562KVCYPuezCLbqU3Ey6ePDKmbzIZnG+BD6dXq+fgpsZqojtzjOWwZMKRnN3aXl
 sjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GtejbtqFkicf0Rt3Pkx0BwzJ2y4pC3+eEBowmUC8/5Y=;
 fh=TzfskRGa/6C5EpqINbGNdUAjd9sbShQ0gR80QPWZhUo=;
 b=a+k31ypxwdXNAdSepoyJDD6MSmRdVYJO6qN2j1E3dZ7kyfRbqAn0oBoydeJfdGEjyr
 4UkRAhswlWhFxrUosygeet1ngyEzQxBgXPQB3bCkmJcw377U7TWe6Mc8qPamsWDwtXQo
 kaJKNpff3Wui8vkAHO1juBVmedYxPyzPTbdJNOyCm4E9ih3eDP3QoqYOrbXMQ0t8L5cI
 CFtN4o7jD72v47qgf8kGCvOiWrxez/ImnKPi3LaSmmjcxhgwclo06WOPYZrL20GxhZFV
 KR19MhUbgeZaB8OwmwvGjzq6xud6aTBokBLa3gOfLnpVzcmKWTV6CW4W5NDqFGNAJMJD
 F2qw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786084253; x=1786689053; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GtejbtqFkicf0Rt3Pkx0BwzJ2y4pC3+eEBowmUC8/5Y=;
 b=NlqENarxAYZXL7ySWXPrXc+CDtj6T2/tW5hyxxZf/MF6JXOcj3XMPhuZEA05wtv82K
 tOZgxtYpwWMPOvc8w3Qo1kHobBdIct3LKbKzJPOpUvZIvKEUXa85RgGZyRORG3I75UWq
 3srvbDuLoclKWgqxxub4tyB1YN/QaTvzLgjq9grYCwjRfQ53kSWTsICl3gQwAdcKVQ5G
 WmgRtwW/j5anBUdCXMdZFUtcaJYNHiYT5hR7N26wu3NCb+W381G36Qspf6VLrgNA2t8S
 peZTv6gF/TcB+qQ4mOJdJSRRUX+qVKUx219Bf7pqNuaE1ptwt/S+v5WFP2kI4zH3FKs7
 cUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786084253; x=1786689053;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GtejbtqFkicf0Rt3Pkx0BwzJ2y4pC3+eEBowmUC8/5Y=;
 b=DZL7OAnU+aoouIpfXm2ydbr8EWQ1mlcKyfIeM4MCwKx3lfIyrfBicEc5jDQGBMKxUx
 STlzuBRXkmBw5WwF8txgDFMuEVJWvb4s/pQS0M9I/+Zw8QMsyOn5UlRuAjPMRQOcKRMi
 BLHR0alkR/AkeUho/EaUl6TO/Z+HDzR9JgxHDJXFcUm5RysTYo/4QGLM9jq2ZFwwIWq/
 aEHu2O8eofEHrF/BhDzJVAGpS5gVQ2AWIpOdseYvEHRak6T2F8cuNNUCMh0GeKy/dCOy
 j4Ifv26kioTTPg6MoKoN5YTNK46CGCWzOTSbZyTOWnDGFuBrfrNaVTHnAZRql1/rp+sQ
 sRLg==
X-Gm-Message-State: AOJu0YyisD9br3jp39K/SY8KsBvr3mKdOGGqPVh9dSVB99CWeZAHZ31T
 PiG7qLm/1v1h5aGkhi/EojJEEgbp1IfjfBpQbYeDrukkISOhQTdq8/vaN6GG1YIOvtO7YKgnlkD
 CeWYwTq3mZlcc9aA9RaMEcjthsVjHTTCZcVhxd0S63w==
X-Gm-Gg: AR+sD11VTLW9Y3zAOyeexnbjgM/26n1qrtMUbE1NFe2ChSie2ChM2FqRCeWKwXR13Ha
 jodm3ztlNsYk/U/3RwCY2DMlxEeoqCGu+rViuqiqzzeuayugb5xYcnb5ZMqmihHuuhwX6jf4kWP
 Xj0uEtMd+tCd1qUg4kaQd6pEso6/JyKvrb0iza4PZ3Almy0nvnFYgcN1fh2FZG95o3Gw5Efw7RI
 PIeJag3K755B9t8KUpKgnDJEgU96M3bPGNo6BzWFK+1F1XP7Np31ALb0Z0HTv919vxhvTbbjzYw
 b94mz+aPFUkE3ti0SI8R3tWOmfc+ni/xX5rHsaVPE0mIuC7t4MChp06f2P5retq8ZTttfRCPnhe
 X+sh+BkRdli5Fq93mAovH5y9saJctha0=
X-Received: by 2002:a05:690c:6c8e:b0:7db:a109:f12f with SMTP id
 00721157ae682-82257626039mr40487027b3.1.1786084252991; Thu, 06 Aug 2026
 23:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260806145224.184019-1-scherer.simon89@gmail.com>
 <0d0c9cc9-2952-4823-94db-a0203847109c@linaro.org>
In-Reply-To: <0d0c9cc9-2952-4823-94db-a0203847109c@linaro.org>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Fri, 7 Aug 2026 08:30:42 +0200
X-Gm-Features: AUfX_mx7c7OtH6OyinZxUrPjWTjy4_RZUTEx9rf9sS9SHqUq_eK0-_thoRzRvqQ
Message-ID: <CAEQwQtL3TZSHnYX6tnzYO9CRAOhAJC4xCL1kCR24ZLtbnBHxeQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Clear OF, SF, and AF for fcomi/fucomi
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Good catch, sent as v2!

On Thu, Aug 6, 2026 at 6:28=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/6/26 07:52, Simon Scherer wrote:
> > +    /* OF, SF, and AF are unconditionally cleared to 0 */
> > +    eflags =3D cpu_cc_compute_all(env) &
> > +                 ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
>
> There are only 6 flags, and you have cleared all of them.
> Which means you don't need to compute any of them, just
>
> -     CC_SRC =3D eflags | fcomi_ccval[ret + 1];
> +     CC_SRC =3D fcomi_ccval[ret + 1];
>
>
> r~

