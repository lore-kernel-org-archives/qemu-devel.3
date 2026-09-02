Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44630C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mA4-0007eq-B1; Wed, 02 Sep 2026 10:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1mA2-0007eM-TB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1mA0-00029T-Vm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788360115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aawYKcxjdLb/WPg58BDhI5H1T3e46wLOC6g4ZFefS8Y=;
 b=HLVw88pl5RNiBuy5uKP/lN5zQAexir2fa+clZLyaU1wDs13SBCO9mi/iPPzeciGLjidnMu
 WK0Ne2pEDiRiqkwMkOS/5NXneIFTCHTjEc5nLJXpjlhDn5URtD897x2oD9mnS3K8fFc1Xc
 9gDTd1DtSw6Q5xXOYiMajHaSE+G5+MY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-xixxw2xgO4OOMEewfPOppQ-1; Wed, 02 Sep 2026 10:41:54 -0400
X-MC-Unique: xixxw2xgO4OOMEewfPOppQ-1
X-Mimecast-MFC-AGG-ID: xixxw2xgO4OOMEewfPOppQ_1788360114
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-86c3a053d9bso13353717b3.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788360114; cv=none;
 d=google.com; s=arc-20260327;
 b=Mcq+NHYUCCZ6b4IjKL4cHBzQHCLN3XZYPJx92Q8r4vGyiQruneJOyp3ZiFkWydF41x
 Ax6tHtwqxFseQl6/i0tZAgbO+XLyxgx8ZhJlV4YBrR5q+4wo32bL+WdOB0d9NmxAe9J0
 uEQSxAkwsHFeQ7PSoVdOf86zR0jmVpYbV3ZqgFKoe5ejADeiNuWkX92M8jXnKYdKennk
 VxO8R+2OlIRV7oF38WG8F6hecwgPCiRUjz15hOy7kOviM+skCKgV2QIrbnenppJYiLpX
 IsdP5HOYiC2WoXWRmrF7g4GSEg8qs9D57dKxpw5K5WyEPNUhobLGQ5nopHdDDTv7WU1P
 7CfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aawYKcxjdLb/WPg58BDhI5H1T3e46wLOC6g4ZFefS8Y=;
 fh=DT9GOM/JeY2TlpGvdpmnfS4K8sQS0KMWHPtkLcKdbfM=;
 b=MTGXIfB3Sm7MTIYClxkO37PnX526pSEqMh0QrXPbj/gZ4Ry5vHXCMsbK+Givo/3vF8
 ksgk8Ot1G8M/nTomwR0PASZnpXmjrRNjXbP6VYqzbtfLTKpaXvdY6KvUIhDGomUyE4n7
 6W8yDy7tBguCrlLPkXr8cvOTeGIN96Ha1Vz8JanObuMwzENmkFeRNFCh0msyKjS4vWFT
 Km/BpG74kRRzQTBHQZqBHT/uLuURIG5QHFZUJpbrITvDPSIH0pq2yNRlCncS/9CAwEXk
 QLMhKVlXuqG9ZjYPBcfAmW4VYfE5Yyejfzgo5c5frZGFTRByv8A9HXlCp3NAKXFKKdWp
 45Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788360114; x=1788964914; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aawYKcxjdLb/WPg58BDhI5H1T3e46wLOC6g4ZFefS8Y=;
 b=S0PKr378LG/+NCnO86Yh9Od3O+rD1NkRMgjMpBZ24iDqStIDnIWm5dhgKRvAUizKoX
 W4ci0Fef9yPy2VGTXA4dAfbN4W48PygAutKIj1PzG+ELluIKmbbK/ZRmYYhwrGAcHoSj
 vWlBVmETUgo803O+txkCcyGhuz3U5mbeJYFhiRcR9Wl2dL7fxA9psVfQb7dELXKg0kcE
 eOf3tF+ZLJgjDmt2T0QbJwFBE+mdrixKKmhxCYbUsN8hTZ8xwUTcVeXnuzn1sQ2yO5Sb
 IztccPEiLYI1pOsRToMUxe0mZzdf9bsNf2mQTbddFtFGW2tAlS6ETPb7tA1M0VlkD9nZ
 SX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360114; x=1788964914;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aawYKcxjdLb/WPg58BDhI5H1T3e46wLOC6g4ZFefS8Y=;
 b=DhmqI8iudRpS7sirZJ6OEsjBQY2QcKzFKLJarFU71D42FZ4EdUkIC9HkVckc/tniNq
 HdXMOAkIu93fCmhn35tuMOCvWd8lWxXXUzp6Kb2rQC0DqJnSxijkprXwR0S1j9ghITvV
 xkw1+GmvjGjjzB1qCt7c1gHoAmS38I9xqfzE+XyFJJr4QkqT9TcxChOVBiV8J5myGROD
 tuZjdEHmukFnL4WMQ78eP1sQPYQJubZ/uiVjGAC+cZGD5SY+F1mOt6cEuim3Zxr8x26K
 kzUsD+Zkcgvj9qaDkceq8+d6sjTFgFtUX0rtN+rG0zp/5JgLMw68lNqAx9P0eordm+bu
 MSCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHgDV/H+BCEo/8kVmKPj+Wnc0Nb2V3gkMI8x9/3wIYNzRE850gNeZgkd9jMMLuKUsoeZdLJsh9XVyg@nongnu.org
X-Gm-Message-State: AFuF++nIkRpOir4EjYjPZpcWCqavXuL4pP7f9hDj6He/svGkroZQ1bYf
 WKNdqGBep1tZ4aCdPZaGYP7ZhQkOvXMMlbvPPHxPydBH8166MUzuektquEH9LlPWyxHbO5ySowc
 ii0Ij1/ic+bcKBbKMngv4Kzxt0QmGMeEWMH60wrgQn/cet3VxMrVQMFbuab1DRTiD3MNx3qkVj7
 i2d9TsKys9vhR/QB2kInC1R7++o1DNAVk=
X-Gm-Gg: AYBFou01/0Q8DA7mvnAAUfAh1rZuiRWO9E/yfiKQfCX8qQTx9UdEKN5Y1EmAKLGEdFf
 Czw2IJ4zlMJQ31IgG/GzrQ3YNZrRgTQ6mn8Wv9OcPMgzTW/3oPsikoizn76prC83bZ2Bxuj0hvv
 aZJoTop3W53OziIhM5Mh4EN9/ASd4XRwpvHmntJYSrA3PO+bhqywukpCQCz4YZ3v5jMzar+f9rV
 v4Nwr2gr6c3Gtig
X-Received: by 2002:a05:690e:bc7:b0:668:43a3:9db2 with SMTP id
 956f58d0204a3-66f9bbd90camr1738872d50.32.1788360108297; 
 Wed, 02 Sep 2026 07:41:48 -0700 (PDT)
X-Received: by 2002:a05:690e:bc7:b0:668:43a3:9db2 with SMTP id
 956f58d0204a3-66f9bbd90camr1738847d50.32.1788360107624; Wed, 02 Sep 2026
 07:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260901195334.463267-1-jsnow@redhat.com>
 <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
 <CAFn=p-Zix9rEXMQsCj=zanoOUXbS_dSTnWY3OaiLRSN4viTtjA@mail.gmail.com>
 <apfhDvrlNFQKJLI7@redhat.com> <87ik4o3psc.fsf@pond.sub.org>
 <f492e217-bc70-4090-8d37-167b6ae00efc@linux.ibm.com>
In-Reply-To: <f492e217-bc70-4090-8d37-167b6ae00efc@linux.ibm.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 2 Sep 2026 10:41:36 -0400
X-Gm-Features: AcwNN1XePEdF7zTFnIX9jOYI1d276S7_QpB3P7ph5L5fbN-tcKgGJlTvuP-XRzI
Message-ID: <CAFn=p-Ytu2ixJ-JTwmmEJOS2Ug=zSyc4v76i9-b46E+VysPZuQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f27cf4065a810808"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000f27cf4065a810808
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the false alarm, then! Glad to see you well!

On Wed, Sep 2, 2026, 10:24=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.com>=
 wrote:

>
>
> On 9/2/26 6:34 AM, Markus Armbruster wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> >> On Tue, Sep 01, 2026 at 06:11:03PM -0400, John Snow wrote:
> >>> On Tue, Sep 1, 2026 at 4:18=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> >>> <marcandre.lureau@gmail.com> wrote:
> >>>>
> >>>>
> >>>> Hi
> >>>>
> >>>> Le mar. 1 sept. 2026, 23:54, John Snow <jsnow@redhat.com> a =C3=A9cr=
it :
> >>>>>
> >>>>> I was unable to get in touch with Stefan and I am not currently sur=
e
> >>>>> if this module is maintained or not. To prevent an avalanche of
> >>>>> bounced emails, remove his contact information.
> >>>>
> >>>>
> >>>> Really? There must be something wrong. He is a very responsive and
> active maintainer.
> >>>
> >>> All of the emails I have are bouncing; I hope they turn up! I would
> >>> love to be proven hasty.
> >>
> >> When I replied to John's docs series last week it triggered a
> >> blizzard of non-delivery emails for Stefan's address:
> >>
> >>    Attempting to deliver following mail to recipient(s):
> >>      <stefanb@linux.ibm.com>
> >>    VMSDVM9.POK.IBM.COM unable to connect for 1 days to recipient host.
> >>    Delivery will be attempted for a total of 3 days.
> >>
> >> but I never got any more of those after that, and the 3 days passed,
> >> so I'm thinking they did indeed get delivered in the end.
> >>
> >> With regards,
> >> Daniel
> >
> > I got several "552 Over quota" bounces in the past few days.
> >
> Right. I was trying to get Thunderbird to use my retention policy for
> holding a certain number of emails per mailing list. No luck. It went
> back to what *it* wanted and I went away for a few days and ran over
> quota. Problem solved by unsubscribing.
>
> >
>
>

--000000000000f27cf4065a810808
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Sorry for the false alarm, then! Glad to see you wel=
l!<br><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, Sep 2, 2026, 10:24=E2=80=AFAM Stefan Berger &=
lt;<a href=3D"mailto:stefanb@linux.ibm.com">stefanb@linux.ibm.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 9/2/26 6:34 AM, Markus Armbruster wrote:<br>
&gt; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt;&gt; On Tue, Sep 01, 2026 at 06:11:03PM -0400, John Snow wrote:<br>
&gt;&gt;&gt; On Tue, Sep 1, 2026 at 4:18=E2=80=AFPM Marc-Andr=C3=A9 Lureau<=
br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:marcandre.lureau@gmail.com" target=3D"_b=
lank" rel=3D"noreferrer">marcandre.lureau@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Le mar. 1 sept. 2026, 23:54, John Snow &lt;<a href=3D"mail=
to:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com<=
/a>&gt; a =C3=A9crit :<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I was unable to get in touch with Stefan and I am not =
currently sure<br>
&gt;&gt;&gt;&gt;&gt; if this module is maintained or not. To prevent an ava=
lanche of<br>
&gt;&gt;&gt;&gt;&gt; bounced emails, remove his contact information.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Really? There must be something wrong. He is a very respon=
sive and active maintainer.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; All of the emails I have are bouncing; I hope they turn up! I =
would<br>
&gt;&gt;&gt; love to be proven hasty.<br>
&gt;&gt;<br>
&gt;&gt; When I replied to John&#39;s docs series last week it triggered a<=
br>
&gt;&gt; blizzard of non-delivery emails for Stefan&#39;s address:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 Attempting to deliver following mail to recipient(s):=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:stefanb@linux.ibm.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanb@linux.ibm.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 <a href=3D"http://VMSDVM9.POK.IBM.COM" rel=3D"norefer=
rer noreferrer" target=3D"_blank">VMSDVM9.POK.IBM.COM</a> unable to connect=
 for 1 days to recipient host.<br>
&gt;&gt;=C2=A0 =C2=A0 Delivery will be attempted for a total of 3 days.<br>
&gt;&gt;<br>
&gt;&gt; but I never got any more of those after that, and the 3 days passe=
d,<br>
&gt;&gt; so I&#39;m thinking they did indeed get delivered in the end.<br>
&gt;&gt;<br>
&gt;&gt; With regards,<br>
&gt;&gt; Daniel<br>
&gt; <br>
&gt; I got several &quot;552 Over quota&quot; bounces in the past few days.=
<br>
&gt; <br>
Right. I was trying to get Thunderbird to use my retention policy for <br>
holding a certain number of emails per mailing list. No luck. It went <br>
back to what *it* wanted and I went away for a few days and ran over <br>
quota. Problem solved by unsubscribing.<br>
<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000f27cf4065a810808--


