Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBFECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIN8-0000iP-6S; Wed, 27 May 2026 13:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSIMt-0000hU-Eb
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSIMo-0007Ay-Fd
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779904108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzWy7FrEs+nek5Qda7xx6YZKa4XTM0REXR2uTD8JZVQ=;
 b=eke/c6kJ04N8L/pMva9AVMb3hzzPpAigPRWNnFDG9Z57jROlU3kQcabJ3u5yOtzumVqVh8
 HGMytATQVe5HO00MYnY5TySH2KJEEZvkWDkki1vhcSb0kAfEwrJKdp6NheZmOon3DPZH/R
 8t1XOo952ZMLF2R3GrUI063bbi0XUWU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-PD48wdNxOC6ZKbzJDAxZFg-1; Wed, 27 May 2026 13:48:26 -0400
X-MC-Unique: PD48wdNxOC6ZKbzJDAxZFg-1
X-Mimecast-MFC-AGG-ID: PD48wdNxOC6ZKbzJDAxZFg_1779904105
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e55c44ac1so9444901f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 10:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779904105; cv=none;
 d=google.com; s=arc-20240605;
 b=YoxdMZLECTAHl/3wI5cqnchNwj8Fc8QnUQ3BIBEERK2TkhHrAObiVDN+ONTqcL4aHR
 BN5D8uRBawA9LN9xr9fsAHjeT83AMU0Hr/yCrbgvfiyvu4oavBH3KY3O7oeXOaHP29by
 lMQiX7P3GNGiGqAQx7UNeRcA/6XFbUO13QdT+gsbdMjF8uxHB1gqPT4kcBXaKFbt3r4a
 6KXQs+Eg3A6FSbf1D6qvS0BbTOAOnedSv7z/bMSEb0kBjAMOGsLwjvyM2VxNSoZltE60
 6h1gNBW4mYK5tBhknI7+lPveXzfHREZVGz/kikoYocCtl6TmDgAQemWGZIqiNTDN90ir
 XFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qzWy7FrEs+nek5Qda7xx6YZKa4XTM0REXR2uTD8JZVQ=;
 fh=CxAjFg9lMFkb5t5gs8rv71Q61XaNSTrRqq4eCH5SInk=;
 b=EBB18pwp+78Llan1nrIm5VBJOzIiX2WuBV1Cx7FWHvzuOdn72hZuKgUYdqH5JGOFb5
 5t0lok62P6AHDBr2PSINz2p0p2RcDuvCjeEO5H8YHDxI1So3HhXokhzKYOj5vBlyTb6H
 5pk5Fa1XDwwJnufphhQ6v7yLKqgFgvhAJO6uTI3aJWM6ltwctpyzNW0+QUt2VZagiiIA
 SOQn7mr3bhJaKSxjNgRtaRsPNwp8jd1dBPfniVqxSseVCctniq9LeZqjtjfefJpLOoN4
 be99wz9KyMw/bEcpzKOfYhLZc/ke9EU8M81R4ydW3ac1yovED4DDyLK98D/4fcgbL/fP
 HECw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779904105; x=1780508905; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzWy7FrEs+nek5Qda7xx6YZKa4XTM0REXR2uTD8JZVQ=;
 b=FN2uVtgPttdl9mqAFipnVnaZddnkHDQuPt4gHVykE+YvCh0PEwLnMcbmwRv0fsyNMx
 FrdA1yv0zE+eAdlVD3DCYmPSk8WJVbJCuZPQEOF0E/wdYwU4jXC+bhnU3RTwI96nEy7B
 I/57fW3jwXVMX8vPHgvbQf7kxiw3wZ1Gun8cMEeoAN0Q963EhNOK1PJSX2DsZs94tWUz
 JDWYtjss0pir2F8TIiMx4Kw0lEKHvZJsqueWJkbjM9ogqhPjIZ9DWMWVVUYQwSA2IKbd
 OYAVWY1Srhdc+HfPAUBUEVTnTv/5j3YMJ7baEj8sKmqreML/lYzAyZ4/QW80DOVh6q+u
 cVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779904105; x=1780508905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qzWy7FrEs+nek5Qda7xx6YZKa4XTM0REXR2uTD8JZVQ=;
 b=KLtUEzXi4iFJ2ZP04tlOoStaWQf1gmNa0aIKpVKi8D6yTKGT4RJP/rIdgs2qn8LrNP
 XKmmv61fKe87zug8CnIpCPEAYvfyhxLL/j/1s/7N/kDoK7PSSHzxfdt5ebV/1MrNU+DF
 lPTNeoZKUAZ3bZZZ4Z13LkmTrwxZh040bFmZKfGQg6KgTP2GtVQAhH7u84dH/qr6QzRM
 bCc+f8D8DgJAe18n7EHzi6/raFYYjKmBpKNzoi8Bl6RKxV2OnSb9ahe5zgORSrjw+IlG
 bCFD/0U6PK/Y//WJwd3yh6RT13qZtqtTePuliYGLN3wC8SYPxbmkUAVeYYqo3m50XBvz
 jEcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6hw4EUDp0pyRENVNu1UBJ4oGgqcMX6LRL6rHOcIH5yoGZZlPFZgYDN1jgjoBuhVEWl1k71iQgqbNU@nongnu.org
X-Gm-Message-State: AOJu0YyAjRR4KvgeD3MZA/Ox+/Is9YHuTHIQbQ5/kLrwu1BAUgLIJOCZ
 sPr9VZNaLhDzA95xW13sKStVT0vKClH0NL9nUzcJ1zUXnc568Bqk6i6cn4hqP0lwQ/wyONgpHVB
 oThXmm9RN3NRg4HEKYydKjUz87JXFsKKtmHJehfc0+js6QBreE7xw64xi92+iDG6dZVZU+Wo4to
 zYcoQEb9xrIfufyjM2DlklTnkobHQNilY=
X-Gm-Gg: Acq92OG+NK/jjEczKNevr+mOw6YwLhZUa39VpAqAfgnie5N9tF1zKerdf8rB+4c/Ro9
 7Cjr9pPHVjBXjk00qYw5+ykjNjDRNu0iWgWjfxkaAewAC/Z6T4kbE4GsrP/8EPzojHRcnePVNB6
 jayMXzrRX+eOkQxzuvRHxDuE/KRaCSL9krjd0d39VOy8plmoWgv9XWoVb98SD64EyJS/1SPqo3s
 /noDfY2X2NHCufRE6JuS/j4YiAIpaW3B5tvsM7DdhwIlHqMSA7jmJaGDRK/KDmjr/LHrooqPxyo
 MQIqqMmS6YJ63ahKqA==
X-Received: by 2002:a05:600c:1c0b:b0:490:44eb:c1dc with SMTP id
 5b1f17b1804b1-49044ebc2e0mr429596745e9.20.1779904105450; 
 Wed, 27 May 2026 10:48:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0b:b0:490:44eb:c1dc with SMTP id
 5b1f17b1804b1-49044ebc2e0mr429596395e9.20.1779904105004; Wed, 27 May 2026
 10:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <8416cfdf-b9a6-427c-8118-fd2ed7661f2e@redhat.com>
 <20260527124115-mutt-send-email-mst@kernel.org>
 <CANCZdfqSEzhjE5Ts+B3hL3GSmT0vw_Q=t_-4BkYugOUNR4_+XA@mail.gmail.com>
In-Reply-To: <CANCZdfqSEzhjE5Ts+B3hL3GSmT0vw_Q=t_-4BkYugOUNR4_+XA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 May 2026 19:48:04 +0200
X-Gm-Features: AVHnY4Knraa2fW6RoxPUP7ZM1A9RWksDFUs3qWF1-AMl8ZlzUp9pd9z4ZnNiOGA
Message-ID: <CABgObfba1qdJKzE_=XJLv_9qP8hqmTVV=KW9M1bg+F-Vfs4Gmw@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Warner Losh <imp@bsdimp.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 6:57=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
> On Wed, May 27, 2026 at 10:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
>> On Wed, May 27, 2026 at 06:05:47PM +0200, Paolo Bonzini wrote:
>> > On 5/27/26 16:14, Warner Losh wrote:
>> > > Why invent something new here when Assisted-by: is used elsewhere
>> > > and is likely more familiar to other users.
>> >
>> > Because Assisted-by was invented by AI companies to get free advertise=
ment.
>>
>> Jonathan Corbet is in the pocket of AI companies? Or Sasha Levin?
>> https://lore.kernel.org/lkml/20251223122110.2496946-1-sashal@kernel.org/
>> https://lore.kernel.org/lkml/877bqtlzug.fsf@trenco.lwn.net/
>
> Yea. Assisted-by was not invented by AI companies. That's just rubbish.

I stand corrected - the *format* of the tag with the model name was
invented by AI companies, for example Anthropic who embedded it in
Claude Code. Likewise for the robot emoji at the end of GitHub PRs.

It does not matter whether it's Co-authored-by, Generated-by,
Assisted-by.  It's the new "Sent from my iPhone" and neither provides
useful information to me as a reviewer, even if it ends up in a Linux
documentation file.

If the submitter uses a "bad model" and is not able to correct that,
it's a submitter problem. I'll watch out for the submitter even after
they switch to a "good model", because they're not applying critical
thinking to the AI's output. On the contrary, if the submitter uses a
"good model" for scaffolding and does awesome work on top, I don't
think I should penalize the submitter.

> See https://github.com/anthropics/claude-code/issues/36105 for the open
> issue with Claude.

Good luck with that - Anthropic uses Co-authored-by so that the
authors show up on GitHub as "foo and claude"[1]. It's a *blatant*
marketing ploy, just like "Co-authored-by: Coke
<nobody@coca-cola.com>" would be.

For what it's worth, Claude agrees. When asked to "commit, but remove
the tag as I don't want to give out free ad space" it says this:
"There is one legitimate non-advertising function, and it's worth
naming precisely so we don't overcorrect: disclosure where a project's
policy requires it. Some projects now want to know whether code was
AI-assisted =E2=80=94 for DCO/sign-off validity, copyright-provenance reaso=
ns,
license concerns. That's a real maintainer interest. But notice it
doesn't rescue either default:  1. The interest is in the fact of AI
assistance, not which model. The model name and version add nothing to
that. 2. Disclosure should track the project's policy and be the
submitter's conscious act =E2=80=94 a line in the cover letter, written
deliberately =E2=80=94 not a trailer the tool injects regardless of whether
the project cares. A non-adaptive default isn't disclosure, it's a
watermark".

Thanks,

Paolo

[1] see https://github.com/wiktor-k/ssh-agent-lib/pull/98/changes/a38760b6b=
4
for an example

>> > Not using it is also a good way to sieve people who didn't bother to r=
ead
>> > the policy, now that I think about it.
>>
>> In my experience, AI tools add "Co-developed-by:" tags by default. One
>> has to read the policy to add Assisted-by.
>
> Co-authored-by: you mean? That's what claude adds for me. I had to take
> extra effort to add the new Assisted-by: to my patch review.
>
> Warner


