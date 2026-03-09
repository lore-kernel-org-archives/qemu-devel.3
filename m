Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61090F4181E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vze50-0000PD-Oh; Mon, 09 Mar 2026 13:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vze4u-0000Fm-Fk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:07:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vze4r-000410-JD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:07:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-829ac8d56c5so2680511b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076051; cv=none;
 d=google.com; s=arc-20240605;
 b=O2eYuAqb8TSfpzSJPvpI2IqTboioADIkRUpCrqehRpLl8XR6xXY7NtrOoGVMOLw18Q
 qritUAnBUu8avbI5VsnRmSKP+C4gs7LjZV0CnmTjb1mwhx2M6KhL5kicNnSceFQ95igR
 Z27gxFQ33cM1iNw84lNItLt5kOOtkpq2PfpWn64L9dG6SYqzsCC37/6CwOf7Gtm/0yYt
 wAtEM+DhIgCDNp883kkNKHDnjyXfHs6hYToqlu+SqYJvms0XlmKtovdz1100MONfXrTp
 numY4b7h0/8qk1vr5Z0eScW4CreS5aX1aIf5LU9HjF6yxjqV/XV+oG04YumlOWnWW1C6
 3vlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c3PkIKfzARLPbsK6rjh6RT/1346Qjqd3vbaSm72RyoE=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=Qbp2AaHLoQ7aPFs2ir1ezvI3Ng+bhgQyGXF5Vp63DRD7+1UyBBsoCBJjmc50kpcVYF
 +9grmNO818TrKmtbt6Y8TUVzOivcSTVKruQ/3FsPnkelngciz/KBiFTYX9Ciy20Kb3na
 nQLDPYjJfv/XaSZ8TUmkrOgGqRkX2TRpUedc1P7l1eoKXtROPkNYHg50DaJnorM/4+BX
 y0odXTMXAfIKwGAYZJkltDCWzA9lmUeRxQlJpJXdq/cGcgn2RPNGfgCfPb661nexAmN+
 vW9xkKca6AaO4xOz/ksuLF336+uE8tFU/br5Sg7iJeYGfDB/bvkuNHdQgcCFvThVUU8Q
 ze7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773076051; x=1773680851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3PkIKfzARLPbsK6rjh6RT/1346Qjqd3vbaSm72RyoE=;
 b=ZBRLYAAJmcZn/OoIzduWM2evZJpJXe7hjxGIGxY2HlqUL/DSNVRq8Got0mW6tnJAXp
 9YKAfBOTcjEjJhTfa+SxKikr57bq4L8nuxKzWf4iZoY43UkGfU/UuxSoEaL0Vbt44lqK
 /ErN4lVuOAJnioSd/Gz69ac0sWMFGideD+yHQbrFlzC9s0F5uLSOXK+2wEU28DeIId4B
 2s7TbtaXBbDCr7fpiHGQSILOVxiEC6sIXw+LM70nk1TzI2yE/7JovbRqwWXG0xhIPWuq
 l+sy+7Jihum4hRJd36zPulB/nxzuQuIo1luNR1pZxj6q4wHwX8TBu5eZ6RbE0sWbURX2
 xLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076051; x=1773680851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3PkIKfzARLPbsK6rjh6RT/1346Qjqd3vbaSm72RyoE=;
 b=pNggSM4KPJSFIAqZFfZlnASzir9BPVBjcnndEYVgRSLAs7K+IRrycIo34A4ztLVarH
 kzT5U/TEVoNFyD5qCojSNidKKhMx7s82FLL4p/l7XXpkDSyr+qIPDFGgOoKGGuXHLOds
 G6rbcF6w/qMTjQ0EL2Tp5p5+EVMlJbSlkZkdfE1xfkdefh7ZB3Fx78kC4WkVAMuFcQ9W
 3OvFdAEJqwtqV+NXZlMLETTLl3kwRoAzlZqSdwqkQ9n5NEAVa3D7JqGn4P9CG+LTji8I
 x1Lr9XYavjuM+Mm8O+ldLILx0KjSdm7eQEWb9aDVkGzAyPaUV5iG8WuzdCeIwwX0HfAr
 LRvA==
X-Gm-Message-State: AOJu0YxPrlHxofoDSWpTglwf28TGhxZZ+tvlw522DBPXFNmTqmTwFJYk
 yUfzHLCj2asYy9xk77w4AaSo+r/eVySKHh4/3TjUWqUPfz9vm1uG84qWQHvU+X4EY1Ml5w/XsoD
 2AkjUcIcPVZp91Vcd7EGgEbB+eRAIfeE=
X-Gm-Gg: ATEYQzzzOq/MgB/zmjA1Pvs94ZtOYYGLyby0PzhqHqzm9p1nPKjA/CbLRtcFORy5hh0
 UkNp1cVHaM7BPKFktUlt0KUoV0mQufIaeBVxnoLotK31dfGbPgbMqFTEwhYxDHiQSQoBqDvxnLj
 FqrcBFSo4S+tbSbQdcDt3w3fdkkjqvTS/oedR0wdjGJrYzFuP8owgTRj2rpZM0hxlacfJrHOSSM
 rp/+G8C2Jd0LEr7PP8dIscuN/iutljBVAKoDO1/MxArdLLaIeFpxN/NFKDyD4JhR8/PeO6mi0fU
 Ud9hRkLB4m9ghahMISjTakhBjGE5yNxRxhM+gw==
X-Received: by 2002:a05:6a00:a502:20b0:829:af4a:5eb4 with SMTP id
 d2e1a72fcca58-829af4a610dmr6270861b3a.6.1773076051054; Mon, 09 Mar 2026
 10:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
 <20260309144822.877695-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260309144822.877695-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 9 Mar 2026 11:07:20 -0600
X-Gm-Features: AaiRm528K9xlbN5e8r5773ECbSd3QNB3xK2DxCk_xKl1JzaDu5OWqeluL3PdWgU
Message-ID: <CAATN3NoKtCQOY+uYJpyPoD4Aakyrh+ZNVjiLdPj+vumFRP=25g@mail.gmail.com>
Subject: Re: [PATCH v4 04/35] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="0000000000002ed5f2064c9a70ff"
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x435.google.com
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

--0000000000002ed5f2064c9a70ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:48=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000002ed5f2064c9a70ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2026 at 8:48=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mailt=
o:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hex_common.py | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br></blockquote><div><=
br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimp=
son@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div=
></div>

--0000000000002ed5f2064c9a70ff--

