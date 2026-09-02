Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168C3C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1p1j-0006qj-N4; Wed, 02 Sep 2026 13:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1p1i-0006qO-84
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1p1g-0003Lz-1R
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788371129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sEDgEkO43oPoMEVBO6LmDUw+ZLHrxrZgm+LQ6ZpI1rc=;
 b=W4g3XszNlb9hje30pTwB/b77cmaB7/fyJU4jglhqMewJmXGMI5gy9NVw8OvDelMrjUFH0B
 8m0a/2qi34Ph9Ft6K5rt6dl2i3RA7xKdmAYNgBAdf0CyMiQIfQXWP3ZfYdKuP1PeHTt5T4
 wLMtsUo2wgv44WefXyzESmQMjWkBkXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-_Is_k_BSM7OT3pVRmCtbUA-1; Wed, 02 Sep 2026 13:45:27 -0400
X-MC-Unique: _Is_k_BSM7OT3pVRmCtbUA-1
X-Mimecast-MFC-AGG-ID: _Is_k_BSM7OT3pVRmCtbUA_1788371127
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e05af072so1167593f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371126; cv=none;
 d=google.com; s=arc-20260327;
 b=alwJy07zmx0o+Sk+ya71gyo3xiCcuVxPjQ03J9OhMXuwdAAfMQOAqmQQAJuKVdk5DC
 IyzFFAjcemN20sKLs0Xn5v20A3fHxp5NtbDjlR8P3cnT/xKS0+v+bsevg41jdv2qM4AW
 67oleKoLrvrMzhEX+Wga6RXuWGue0DNL18ULwAZIYmWKM+7y4n2tfqsg7cVK3aqK5N5F
 nnOxEOWyEo5g15V5+PaSz5qQNDPxx2ZBn2qintYmvPspDhTKiyk+hQgwGXH+EWHkubzb
 iLEnZPir0UN3kM8SAli0Crjx6bfzqP3/n04h5GUS8g90ZbEERDkdiB/QxIGpWx7R7cVg
 nLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sEDgEkO43oPoMEVBO6LmDUw+ZLHrxrZgm+LQ6ZpI1rc=;
 fh=XV6tv6dqVmqQs66RCHsndKgxI5JNm5GVMdZKAPbM5SY=;
 b=YeD8DoGzIVo+TLSVIT8Lr2Lm+YPsP5jB/XG40bBeaemDFfbj90so/7sJm++qHOJXCV
 xwTTLh6HYmKgsuRRcu54Jwwqun7j2/Ch2IAI7yXdgrX3rpSHOQ4z38IQJPwoH9K0VzBm
 3ppOXfDFhiDNWWYZd459e3CQbE0i/5SnBGZGfNzZRQNd/0c14gQIZnpK8FNzJMsIoeEX
 A+46YO9DgzNmZ0P3JNoq5eJMiLYJ5SB6fYnsFtw6/8N3PdwzQaUw001VpwBsl7gWGUkB
 3LhdrphQiNsivPy/0dt8IlGPCoh3DUHLLXwCuf6LQ0vA96KxaUEx43hGFfBQNnf37Nx0
 uqVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788371126; x=1788975926; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sEDgEkO43oPoMEVBO6LmDUw+ZLHrxrZgm+LQ6ZpI1rc=;
 b=TRrrWSxA7w+WcEfX18yQqOYhDP5we1RW2pV8fPa/FqnFnLQVGmoUcO8hC459pxcjSx
 RfIBRSKGYMEiqnz6IZn7pyjWTESO2X2Ws/ay+OWUrrYbC9CZAeguJE/pqzhghIHdKIKI
 OX/g+Gubh/nzetcXukGbYaIDOvVLcgC87FKyhS3nNhqRVGzdONg8eJZEZvYHcaGGVIIt
 VgUPunsayLPvc3L8/55IuZiYWDXeRJs4lJybcS4urNjpBwTMprJKZYxSjJuGyJ0vexlj
 ki129DzAqN2Mj0AcM1YfOlJpcdQgbdKsDQ9MI8f5EEZGBsKntOFKTiw0Hho4TT3XmBQd
 pUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788371126; x=1788975926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sEDgEkO43oPoMEVBO6LmDUw+ZLHrxrZgm+LQ6ZpI1rc=;
 b=bJPgMYZ+wSRT7ohOKIcrc2tbagMBXB9Swkvxa/JZQBplZfq8SKG0Tn22qZ4mfid/Bw
 KNcoq6Vpc/Z5miRZ8qVougCSEsaCofxUz5m96xKeHqtT4rIhLChuby1WB8APJqBAV8Yr
 eToHIx+zzs3yJ2vJm/OQzzOdXmmbQ4W147AbLgzTqOiFj3frICacHu5+pkKO2R1QVw6M
 VhXGWl7XdTZMu6A8urRisIHVyt3KzQ7QcFELCPOJKmTynM9cAa2tH/zU9sf6Zb+09cQr
 8U20NN5youLydEGEH3Iqzkm+1/TQWIEOheX32kqY2TjBFK2WqqGwHEj3cCqMIN0JUDXg
 ENTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoMOWn0GfznTox1DD7VrrJVjLQFgzVsnnYgZMIiDPfGljVOSdEFoTjke4AIACHuKwWI9ZJLuuyb58b@nongnu.org
X-Gm-Message-State: AFuF++manV2jBuetII75TsmQANnTMQYGjZMWmZMByccALfGyRG9oWhNI
 po0WbvwlLRflDrjDU0sMVpKzyIXvkp5+q1FGBhwQWwNV5rb6fO9+F2aLGkNESEAP3D7IR7EKWHv
 Ki7Rair7lR4a9RnmSxC/UYTgzKg0qBqzbNv1ktqAKu8ujdmCs1r07BAJXCnE+OA6znkP0EwBIE9
 82hNHoGVEpmFMr+VkFVhh0NZ1F0MFOAgw=
X-Gm-Gg: AYBFou0fI5ytUIr5wF4D7wq7D+J0DE0lQS9vAuCAvuinRYDwqCaW0Tx6ml4dW26j51M
 zlpsyva/i8QSh1yOToaFIoWZWUcg/Hd7/s4lgT7xdMRTXf/qSVMnyIa6OWYXA1Vg9wGjfDpKh4X
 +ifM77ikgf5IXxU/zuHUmKI6+wDS+oR8G6nAd/sQKH13k53eZuwRXQm3kKEbLI0+Fm9BOnl7QGz
 qvlzQ/+MnedrvE76mRK5Jl2ZN314eF+flzph8U8WZJFH5Z/ALIDSUnqP9s=
X-Received: by 2002:a5d:5f54:0:b0:482:e658:bb8e with SMTP id
 ffacd0b85a97d-48488f0dba5mr12667062f8f.12.1788371126641; 
 Wed, 02 Sep 2026 10:45:26 -0700 (PDT)
X-Received: by 2002:a5d:5f54:0:b0:482:e658:bb8e with SMTP id
 ffacd0b85a97d-48488f0dba5mr12666987f8f.12.1788371126247; Wed, 02 Sep 2026
 10:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-3-pbonzini@redhat.com>
 <838ae336d98d20b4f6254206e0d273055baeb3bb.camel@wdc.com>
 <aphOREudUkX6XufL@redhat.com>
In-Reply-To: <aphOREudUkX6XufL@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Sep 2026 19:45:13 +0200
X-Gm-Features: AcwNN1UXmzbF5DK2znBji2R2ZIyCF3QEiM81cfXhFrPef6E8CyM8P0VqMZgy9Pw
Message-ID: <CABgObfZtVF4KZsD-dW4i3orYF7+jtLqMjcjersoqpLthtE18xg@mail.gmail.com>
Subject: Re: [PATCH 2/4] AGENTS.md: Let agents know what the participation
 rules are
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Maydell, Peter" <peter.maydell@linaro.org>, "Wolf, Kevin" <kwolf@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, "S. Tsirkin, Michael" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>
Content-Type: multipart/alternative; boundary="000000000000b4fc51065a839982"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000b4fc51065a839982
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 2 set 2026, 18:26 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > I must admit I don't have a good understanding of how these are parsed
> > by all the different models, but this seems like a good improvement
> > over what we have now.
>
> I think we broadly just have to assume the agents will "do the
> right thing" in the way a human would interpret the text.
>
> If there's a general theme, it is that the statements should be
> concise and explicit with as little "fluff" in the language as
> possible, to keep the length down and increase the likelihood
> it will be honoured by the agent.
>

I am no expert but it depends. Context size has increased a lot over the
past year, and if anything the agents are too eager to help you not be
banned by QEMU. ;) It's much easier to forbid something than to change what
it means to be helpful, and the latter takes more explanations.

Alex's previous, much more expansive, AGENTS.md proposal made
> use of linking to multiple files, so the agent only needed to
> load subsets which were relevant.
>

The "@" syntax as far as I could understand is just a shortcut and still
results in eager loading. For on-demand loading, instead...

This baseline AGENTS.md file is probably already getting a
> little on the long side, once we consider the followups that
> Alex had, to link off to other docs with guidance on QEMU's
> codebase and issue policies, etc.


... those are best published as "skills". These are a similar kind of
instructions, except only a YAML front matter is passed to the LLM and the
full text is loaded on demand.

I didn't include a sample skill in this version, but AGENTS.md does not
have to grow much beyond what it means to implement the policy and a lazy
reference to it.

Paolo

--000000000000b4fc51065a839982
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 2 set 2026, 18:26 Daniel =
P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat=
.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; I must admit I don&#39;t have a good understanding of how t=
hese are parsed<br>
&gt; by all the different models, but this seems like a good improvement<br=
>
&gt; over what we have now.<br>
<br>
I think we broadly just have to assume the agents will &quot;do the<br>
right thing&quot; in the way a human would interpret the text.<br>
<br>
If there&#39;s a general theme, it is that the statements should be<br>
concise and explicit with as little &quot;fluff&quot; in the language as<br=
>
possible, to keep the length down and increase the likelihood<br>
it will be honoured by the agent.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">I am no expert but it depends. Context siz=
e has increased a lot over the past year, and if anything the agents are to=
o eager to help you not be banned by QEMU. ;) It&#39;s much easier to forbi=
d something than to change what it means to be helpful, and the latter take=
s more explanations.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
Alex&#39;s previous, much more expansive, AGENTS.md proposal made<br>
use of linking to multiple files, so the agent only needed to<br>
load subsets which were relevant.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">The &quot;@&quot; syntax as far as I could=
 understand is just a shortcut and still results in eager loading. For on-d=
emand loading, instead...</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">This baseline AGENTS.md file is probably already =
getting a<br>
little on the long side, once we consider the followups that<br>
Alex had, to link off to other docs with guidance on QEMU&#39;s<br>
codebase and issue policies, etc.</blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">... those are best published as &quot;skills&q=
uot;. These are a similar kind of instructions, except only a YAML front ma=
tter is passed to the LLM and the full text is loaded on demand.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I didn&#39;t include a sample skil=
l in this version, but AGENTS.md does not have to grow much beyond what it =
means to implement the policy and a lazy reference to it.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Paolo</div></div>

--000000000000b4fc51065a839982--


