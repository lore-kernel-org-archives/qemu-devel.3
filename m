Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5D4C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 21:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uID30-0007oX-EH; Thu, 22 May 2025 17:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uID2p-0007gJ-C1
 for qemu-devel@nongnu.org; Thu, 22 May 2025 17:01:40 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uID2n-0008Tw-Qp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 17:01:39 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30e7bfef364so6467704a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747947696; x=1748552496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mcVMP7cF3+AZ6aEMNCRze6xv1pI3yV++usmfMaDhPo4=;
 b=cn2isPfMM/t/70k9IX2v+mOUuZH2q+c5MjHCE6L3iR1W5omKJGYlX5vNDMxZZhnc1s
 owPTWnNRD9Zw2tIYhdxWI529gFdif4PF6Rq2Sssa8pWUoywRQ08M9Qa3h/GEetjF+sNL
 DcJWhBeUc4IUdKBtltc0zaTIwLjbtuCgkJxaUxEs+LrEqYlUArlJ7wdr419iH2HWphHB
 ezbW68Q3UsRCwfRtuwj0WxMzC7OAxcICU4mVw8WRJ5iTTSxF99aF5y75aFvRovdvT9yl
 0e6jKJdfv8WXYoHW4a1KdoF6x09+38kI63PgfEZf2xCkV33o7brtwUtCWz/ELlWxVDOM
 dD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747947696; x=1748552496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mcVMP7cF3+AZ6aEMNCRze6xv1pI3yV++usmfMaDhPo4=;
 b=mwUAuTaLKah4y8a2ZlVvkyQsDv7iJbMm0h3jr4P+OFB7M1ai5k6+mIf/Vv7ej7xNjo
 o93BYDbD/mdIjnkU5INEsogIbmYZy1IW07U+QIGavk1AUO5MZfXtNNyHCDd/muJlPVc5
 3/vblBZ5YDIiJOKblSb9Uxp25yQz606O7sy3uuVNBDuRi6oI+k15VDLNmMmWKGL6rn0t
 VoKcLKs/Ie6J+Qf8s9IfaKod8xJGUJ7CyF1vMufaZMErM4Ug/RHqX4T+Xx5qhZwW7YT/
 z5Q+vrzJTeNQ0UzjXMYeTBNGaoQ7PxqjZAN6T3Y7e6pq0F+l5mFhGRIbUXyJ8/Jeo2oD
 +vHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARRpqDRBDlpMUioyXMSzgDfJYEVqtXZgqnghw8Ypq031KiFgoUssaKzHaLmrsv8IJIrtPeCOjIOTm@nongnu.org
X-Gm-Message-State: AOJu0YwFqldHRkpLXMu9lcUTThkGnzkqC8ZYO4MQsNobhJLD6008iCKA
 UPW9XIGh5enbYkAAKWpc5TAJiiVxv5fbOkTZGOVWsXgJxk1ruohZ2iECv2OAeU7jFgV2DeWQVyL
 vZQ/GS3ZteoskQMr4lMGvC8YKfUJmLMg=
X-Gm-Gg: ASbGncvmSabKw06sv1UBPqjyElqFi/67HzrWCko23y+06fjhUHAE6qQAa4y5V7bbvjc
 O8GB3sv3bKiufk0N+YsYgxX6b2T8RL+Wm+LSRXKMQafrg/2cfPIqiqznnDHAf6PS7fNkc9oK27Y
 1e1ynegTiPMZWHfhSFOKu7jhl/qIGJVkg=
X-Google-Smtp-Source: AGHT+IHj4UV0X6hYSvb17+4A41+oXlOTP7ZMZxrIwEpaSkuEnnqvpBFBpw+H/WsPchF26xtNttkstsItvuGDr0KnNfw=
X-Received: by 2002:a17:90a:d604:b0:30e:ee6:671a with SMTP id
 98e67ed59e1d1-30e7d50b022mr43135691a91.10.1747947696075; Thu, 22 May 2025
 14:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
 <20250522115935.34716-3-neither@nut.email>
 <bbbc7639-9ef0-4510-b481-0c3145b6ff11@linaro.org>
In-Reply-To: <bbbc7639-9ef0-4510-b481-0c3145b6ff11@linaro.org>
From: Rowan Hart <rowanbhart@gmail.com>
Date: Thu, 22 May 2025 14:01:26 -0700
X-Gm-Features: AX0GCFv6j_V1qiOvE8htC17x0Nv5RNbnJlrN_a254tLmRQcPcDNEep84RCb9TSY
Message-ID: <CAE5MsNaacPXefwk=tsUmmAoxUZ9UU3uc084rOT7TOarW7Y7FwQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>, Alexandre Iooss <erdnaxe@crans.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000082b7c80635bfc917"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x1033.google.com
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

--00000000000082b7c80635bfc917
Content-Type: text/plain; charset="UTF-8"

>
>
> > This definition strikes me as odd. What was your reason to assert
> > `current_cpu` here, but not in the other two functions? Also a bit
> > surprising is the declaration of `cpu` if you use it in just one place
> > (rather than just use `current_cpu` directly as for the assertion).
> >
> > And there is no reason in particular why the vCPU could not be a
> > function parameter of `qemu_plugin_translate_vaddr`, right? You don't
> > have the same restrictions as in `qemu_plugin_read_memory_hwaddr` or
> > `qemu_plugin_hwaddr_operation_result` where you actually touch memory?
> >
>
> That's a good point, adding a "unsigned int vcpu_index" to the signature
> should be enough to query current or any other vcpu easily.
>
This is a really nice idea, it might be nice to make a vcpu version of
read/write register too. For memory, I'd think going with the current
memory is probably fine, I don't see any configs with different memory per
vcpu?

>

--00000000000082b7c80635bfc917
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><br>
&gt; This definition strikes me as odd. What was your reason to assert<br>
&gt; `current_cpu` here, but not in the other two functions? Also a bit<br>
&gt; surprising is the declaration of `cpu` if you use it in just one place=
<br>
&gt; (rather than just use `current_cpu` directly as for the assertion).<br=
>
&gt; <br>
&gt; And there is no reason in particular why the vCPU could not be a<br>
&gt; function parameter of `qemu_plugin_translate_vaddr`, right? You don&#3=
9;t<br>
&gt; have the same restrictions as in `qemu_plugin_read_memory_hwaddr` or<b=
r>
&gt; `qemu_plugin_hwaddr_operation_result` where you actually touch memory?=
<br>
&gt;<br>
<br>
That&#39;s a good point, adding a &quot;unsigned int vcpu_index&quot; to th=
e signature <br>
should be enough to query current or any other vcpu easily.<br></blockquote=
></div></div><div dir=3D"auto">This is a really nice idea, it might be nice=
 to make a vcpu version of read/write register too. For memory, I&#39;d thi=
nk going with the current memory is probably fine, I don&#39;t see any conf=
igs with different memory per vcpu?</div><div dir=3D"auto"><div class=3D"gm=
ail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000082b7c80635bfc917--

