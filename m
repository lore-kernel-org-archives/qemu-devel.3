Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C63EEEE265
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 05:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbXSG-0000NT-5W; Fri, 02 Jan 2026 00:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vbXSE-0000NC-G0
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 00:12:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vbXSC-0000N2-Ji
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 00:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767330718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LcyFKho138SsiiO8BN1LSqVjTxLnLBkpfoWMKdxc3Cc=;
 b=BkpkAEzQkE+GbE3KVjTCSyO71sLVWshmaYplvNctti2G6U5H/liJMnIdXos/9uZ9x2b6lv
 hK/J4jjkU8mPI/gGygldwHr10kPZvII9v4notvaGoC5u9lUTw92Xc9k+5HepYqQg2mgjP3
 sJi1wuWM3QDof1JvhBelwHdlmv9+pQM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-5ZkZKPXqOHqtZjmDf2M2Ig-1; Fri, 02 Jan 2026 00:11:56 -0500
X-MC-Unique: 5ZkZKPXqOHqtZjmDf2M2Ig-1
X-Mimecast-MFC-AGG-ID: 5ZkZKPXqOHqtZjmDf2M2Ig_1767330716
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so86730465e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jan 2026 21:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767330716; x=1767935516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LcyFKho138SsiiO8BN1LSqVjTxLnLBkpfoWMKdxc3Cc=;
 b=A8FMC5h3M2VJ7fakXqnGb9nvwqvNgMeDT000flkPXqazPgJak/01RSk7/ql29b4Rv/
 svG/hXwuvoQnZFjFZSd9rjDYijWmD1Bmeq1+FERMIfyZgkneDGTsyCjj3qDK+TzjGAWs
 dTjfZxFJjt+cBUOkd+l6gWNMWvzMGWrfPPXhvGXDmRVdkyPwFrQSi51I0bI9VETEONo+
 hY5lPJ0p+i9jYfvlK7zcLA9Q8eSXFkdKS4/C3C6hFJur68tLQR2t3P5augVRanZUnNAF
 yWjQmmaOzFuLKmYU5Jor79y4wcWTgoyj2njvlrIabLd2Wr2sJLVDsW0BSkhZ6oOzY5iV
 6Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767330716; x=1767935516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcyFKho138SsiiO8BN1LSqVjTxLnLBkpfoWMKdxc3Cc=;
 b=u5yjme4pRFe4IJFv9cXSn0+oTcGnwuYRMWiaRQvqK+vIBZUA8iHvYt0DB4CDxibVs3
 POHAHww9CBCKq1iLk6NX3/4jECTX1gl70Xr/a7qJDEVubpWn2gXHAZn0m5cBrq+EDU8l
 7SBQBNvxtufp6oC1HDn9GVDG+Jes1g9T+LZin9ViOMbe6yMO8WsybbOLjno+2j5m4zQk
 cuzTSREZ2hMkPpIXh3RteEvVQnyU+j8WGIWqOICUY7lQulI/CtDbxUpI0DHA26gfW1CQ
 sBUyhwhnLlrqfC8ZwMvzHyg/v6Y3HU2YAZoWIL//OpvSSVpB4EkeNI1nHVPSOcncR3HN
 6XOw==
X-Gm-Message-State: AOJu0YwSW4FueGX7zznqm13C/z1bAiWhdUSftKozDVmUqO8rNfdtzteV
 Q1XCuw0QilIL3YO7+AOCXi9cxRk5LjtEnIAlvmVh6kNG/GrBCDsLxsDlQwj3ktnmZzfc7wmcsIc
 X0XyoTRQ1ilNc1wBKqFYjzMpnzBq/VziCCzg9YiIXHkND6DhgYEq93F613fOsiTtWroUDR+D/n6
 bXTFRn/AxxuafVUXp9WkPFxh6CxhJFlqY=
X-Gm-Gg: AY/fxX4xZnL7SEQcHBoMV/l2O+jMHAlAXKm5MhQS66fmc6cV/CAvpCvTfitkBxA5BOi
 AItVC1rFYpt7VQknh5/MJ7tJES+g04AQ6IYYRyFE3u2HPWnncyC4TvjE2mvJCitmcwJZ+Tr0luV
 xVIMxF2UTW00o9YEL7v/zJRUmvIRzIV69CKe5xI+85fZy0m9Z3wOhBztQU1qsf9m7YBAdK177jV
 cqhFFCpWdkzKyyqY0v9stVNLUXtXsWfGUD97cNYi83x1JuXgoIz1GcbJ+LPGKVQnBlWVA==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr589436005e9.17.1767330715721; 
 Thu, 01 Jan 2026 21:11:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcXr5ITMBE6AXPmi3avuo29xn6edfcySEZamVAnlncS/M5GTMxd/coeobiZo/2Dex78jsPgvniASR6Xj4I7gU=
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr589435825e9.17.1767330715339; Thu, 01 Jan 2026
 21:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-6-pierrick.bouvier@linaro.org>
 <CABgObfY1wpqryyBbf3tpCwZGT0izto_hda+izOUGZ57jwQzXMg@mail.gmail.com>
 <523e0a47-9076-45cb-bdc7-8310cbde0566@linaro.org>
In-Reply-To: <523e0a47-9076-45cb-bdc7-8310cbde0566@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 2 Jan 2026 06:11:45 +0100
X-Gm-Features: AQt7F2pfHwSp3xrW3ggi0DwjwGSdarmPOpLAYtpFgIrtcxuPzoVhROUt9o14_e4
Message-ID: <CABgObfZqauCJHZOgaH01pCC7t-7pA70QihpALieXtEBRYe8RLQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] include: qemu/ctype.h -> qemu/qemu-ctype.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007d22fd064760bf2b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000007d22fd064760bf2b
Content-Type: text/plain; charset="UTF-8"

Il ven 2 gen 2026, 06:01 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

>
>
> Thinking about all this, a good solution could be to isolate
> <qemu-plugin.h> in a new subfolder (include/plugins). This way, we make
> sure plugins are properly isolated, and there won't be any conflict with
> existing ctype header, so this patch can be dropped.
>
> What do you think about this?
>

That's exactly how I thought it already worked. :)

Paolo


> > Paolo
> >
>
> Regards,
> Pierrick
>
>

--0000000000007d22fd064760bf2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 2 gen 2026, 06:01 Pierric=
k Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvi=
er@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
<br>
Thinking about all this, a good solution could be to isolate <br>
&lt;qemu-plugin.h&gt; in a new subfolder (include/plugins). This way, we ma=
ke <br>
sure plugins are properly isolated, and there won&#39;t be any conflict wit=
h <br>
existing ctype header, so this patch can be dropped.<br>
<br>
What do you think about this?<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">That&#39;s exactly how I thought it already wo=
rked. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Paolo<br>
&gt;<br>
<br>
Regards,<br>
Pierrick<br>
<br>
</blockquote></div></div></div>

--0000000000007d22fd064760bf2b--


