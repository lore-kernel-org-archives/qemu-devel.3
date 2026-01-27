Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EAED2FEDE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 20:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkpUQ-00057n-Jq; Tue, 27 Jan 2026 15:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkpTr-0004yj-G3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkpTm-00037T-Ps
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769544961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WUT2lpupfRnNv+eTaeqRXs8i1zJYctB/AKC4nfeGD9U=;
 b=NFz12ndmaXhLkAAOMPkDFw9kD1vgpKOiVj+CI6+UwqXN+zjSbCIJ0yGViyH/+TbUSVMR0F
 GzlbHi9aH8hzVnfxnaVj5utkqh7/tS2Yf0Ws/loakNu8EYV9Z7/M2ZgcEyD9H1GnHXL95O
 7J0uwRHvLPMsUnsTts6gR49yZ60AnIM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-zoEecP3RMkCOhDAmVZRbZw-1; Tue, 27 Jan 2026 15:15:57 -0500
X-MC-Unique: zoEecP3RMkCOhDAmVZRbZw-1
X-Mimecast-MFC-AGG-ID: zoEecP3RMkCOhDAmVZRbZw_1769544956
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43065ad16a8so3652583f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 12:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769544956; cv=none;
 d=google.com; s=arc-20240605;
 b=LhpEZSVT30piSY1lhZ+Hn8LeJISjUQoi4A2qlvj+H+qPER5uDMMnQyVsnmDZoXzNli
 WxC+S/nq6M6d1lZrlGAgUOFHc+n5s8DMoXiLzYygtxlEhoWFmrSh+FxnZEy40dPF3qNl
 Mn+nSymk8iUOeRDrLTLmz5hKAHyGOnrQMiJjVMeR0M6aj6pY3Ckcd3K4vMO/t8AbEzbJ
 xVfZIcSB7PWpTqaj9XQsYNnLMbMXSEHdliN8Mm2uZevlpkTUwJekkAvoSprcBkLAyTOJ
 SOLYvXL2kYrQandppjNJNOmIPPN6MbTPGeLFzjgV4HB3nekqOWEKwP5KPdlLocxyt0S/
 szlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WUT2lpupfRnNv+eTaeqRXs8i1zJYctB/AKC4nfeGD9U=;
 fh=3KLjqEvM5FT2I6thDr/rJoFSAGNSId2rT4Qt37s6ei4=;
 b=CbPdzE8dFq1OCUskft3/t9jQ/r9vcCRguIPaOH3PmftQhoam8nUTHFlTlP1nhevGS7
 KoXaEc6uDzjMz6XufRJ9nPXwHCLwQLHvp1du0OBeRwOGvuN1WYdbrhuEDwXhYWjzeOHf
 OKPdmE1oKFCeyhRO09KJ8/qUJ/GT4sktNex7u+/dYuWSA2GgT64qI8TelH3MDffpZzfU
 sHrhoOS7iNigwRCP/2adjjzZaMtBlH0UOBacQSB/7/B9C4xnZRe/RCEtCD0rx7cpTv9T
 bJRaSJF7vVKZjOpCUMRxpA2y81btU0qVE6Kxq3lQ7kKBKGSyafB+eiDes9ppahXyF2Em
 pTvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769544956; x=1770149756; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WUT2lpupfRnNv+eTaeqRXs8i1zJYctB/AKC4nfeGD9U=;
 b=gqNME7t+eHzRLwNCzDsjb9dcfiAqB+NqvqhgpOJVsZADCpcGs0AwJEMm3tPu8069q8
 Z9piydozCxe8TXiuocXxwnIHZ9Aer/aswS/1yp9FE8yk0UM1Jcb8u6+4fMR9sh8G+vT8
 xMKMxQsSX+1ZOm45e0HXuOFfPj/6sX5the/dvh7uVG+P6SbMcPGGIKEySJiHctWiQITD
 qBxdShgE7tyk8XYFq6/2BHUNFS4Y2/0+t6XjA0b4T+TYAPS7uI5CU3Qpf7YmNPS8/xI8
 p+FVdSQc4zGv9GGT2S+XhpdAtJTEexFtXEQHim2us1HIK/tpDxVcy81xv2qlFiHLIr4y
 j+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769544956; x=1770149756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUT2lpupfRnNv+eTaeqRXs8i1zJYctB/AKC4nfeGD9U=;
 b=cUBihvBMEu4/Q1s1SCn8zXJ1X9pcYJOALBWXKiJF/WAiv84l3kmzci7ze28S2RhP3i
 cw7RDgRqiMH5+LuhY8fFAuwNLBL5UvV8G6IYvJyDUjNqYpZ8dPz7D/yk0D0l38xl0ESi
 KN2w/V+eoo5+dXmPRbXL99QPtHaef5tQ/RxWRJQK38/DsGOUCzDNlPb7FGCISQCyZcxz
 WcvbIdZz4EwiNE3F5IzkenvCSzK0xAYXjJOBbjkZqJhP2iVCAHV9fPJvNP9s/g93atXO
 6aTW7TS53j9gAebl9NwL3bOTFH1Vj+0bNStzHmzGicuqlQrRvAHxXci6/SnReJYswPHr
 VmDA==
X-Gm-Message-State: AOJu0Yyrh7Gu2ABPXXEi6ZH7bI35OXVu9HCBxqeujcwosOYDqv2XpNTn
 yCSDqRPAnHu/HyO/fa4wCthC89h8+WEiMOeYhJ7uvKyd+hBPUBu/W7jl3el2DNk2rrFFfF/4oCG
 2TDuX1LEmCqcTiYjKc1faY0cNFoCXuaELlHb8WHX3RwYDM7NymV3ZznkHMgWnt4/ush4teW00d1
 CQ59A+MZ68xtbo9cGIXPfen0EATKscDq2+9pMSmyE=
X-Gm-Gg: AZuq6aIvbV3iXxKo4U4LbcotuWYstYwjUYKnv5yfU2UiCj8TXhwwrCPh0soCDpygfzv
 K45CBbNoimpmqn9OhZ89ubqB4R0uHptH7Bcp/RQH8+2LPckNXRREnYCv+EZ0ZCoSk39giC7pjAy
 df4RkiajxpCrLnAinxpq0d0mdO/7IWGxtabi0fboSNH/EJZYzAivFZkKtgtBzUwSAnRFwPeyd8V
 A49VcPsTxAbbiL60tcWR7d/GWj1ZOnESQiRg2U/L+zTwm2g90C2S59C6PnubJtetRA33g==
X-Received: by 2002:a05:6000:3113:b0:435:a815:dd8d with SMTP id
 ffacd0b85a97d-435dd1d8511mr3545335f8f.55.1769544955918; 
 Tue, 27 Jan 2026 12:15:55 -0800 (PST)
X-Received: by 2002:a05:6000:3113:b0:435:a815:dd8d with SMTP id
 ffacd0b85a97d-435dd1d8511mr3545307f8f.55.1769544955566; Tue, 27 Jan 2026
 12:15:55 -0800 (PST)
MIME-Version: 1.0
References: <CACSvEXZAYPCCsC8hHSmo4w2cRhbzwb+=Nj6xfz=TAtMDodKjwQ@mail.gmail.com>
In-Reply-To: <CACSvEXZAYPCCsC8hHSmo4w2cRhbzwb+=Nj6xfz=TAtMDodKjwQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Jan 2026 21:15:42 +0100
X-Gm-Features: AZwV_Qh8RxB9N9twyIzh1c2WEa1hdIC949XQdL9aSI3UgZZESmHdnzYGRN7Bcjk
Message-ID: <CABgObfYwpM6QyDHAFGZkZXR6637JRNViSPJsArGnrvgrXBxMjw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add CMSDK APB Watchdog device
To: Mohd Kashif Khan <kashif04x@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007daf550649644a1b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000007daf550649644a1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No problem, it wasn't much time at all. I only did a very cursory read.

It happens=E2=80=94but please take this as a lesson for contributing to any
project, not just to QEMU.

Thanks,

Paolo

Il mar 27 gen 2026, 20:58 Mohd Kashif Khan <kashif04x@gmail.com> ha scritto=
:

> Dear Paolo,
> You are right, and I sincerely apologize.
> I made an error in judgment by relying on generative tools to draft this
> boilerplate and failing to rigorously verify the functional logic before
> submitting.
> I understand now why this was disrespectful to your time and to the
> project's standards. I did not intend to pass off generated code as a
> finished product without understanding it, but that is effectively what I
> did by not testing the functionality.
> I am sorry for wasting the community's time.
> Sincerely,
> Mohd Kashif Khan
>
>

--0000000000007daf550649644a1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">No problem, it wasn&#39;t much time at all. I only did a =
very cursory read.<div dir=3D"auto"><br></div><div dir=3D"auto">It happens=
=E2=80=94but please take this as a lesson for contributing to any project, =
not just to QEMU.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks=
,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">Il mar 27 gen 2026, 20:58 Mohd Kashif Khan &lt;<a href=3D"mailto=
:kashif04x@gmail.com">kashif04x@gmail.com</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=
=3D"font-size:0.875rem;padding:20px 0px 0px;font-family:&quot;Google Sans&q=
uot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif"><span style=3D"font-fam=
ily:Arial,Helvetica,sans-serif;font-size:small">Dear Paolo,</span></div><di=
v style=3D"margin:0px;min-width:0px;padding:0px 0px 20px;width:auto;font-fa=
mily:&quot;Google Sans&quot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif;=
font-size:medium"><div><div id=3D"m_-6226523153361006670gmail-:ob" style=3D=
"direction:ltr;margin:8px 0px 0px;padding:0px;font-size:0.875rem;overflow-x=
:hidden"><div id=3D"m_-6226523153361006670gmail-:oa" style=3D"direction:ltr=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;font-size-adjust:none;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:small;line-height:1.5;font-family:A=
rial,Helvetica,sans-serif;overflow:auto hidden"><div id=3D"m_-6226523153361=
006670gmail-avWBGd-74"><div dir=3D"auto"><div dir=3D"auto">You are right, a=
nd I sincerely apologize.</div><div dir=3D"auto">I made an error in judgmen=
t by relying on generative tools to draft this boilerplate and failing to r=
igorously verify the functional logic before submitting.=C2=A0</div><div di=
r=3D"auto">I understand now why this was disrespectful to your time and to =
the project&#39;s standards. I did not intend to pass off generated code as=
 a finished product without understanding it, but that is effectively what =
I did by not testing the functionality.</div><div dir=3D"auto">I am sorry f=
or wasting the community&#39;s time.</div><div dir=3D"auto">Sincerely,</div=
><div dir=3D"auto">Mohd Kashif Khan</div></div></div></div></div><div id=3D=
"m_-6226523153361006670gmail-avWBGd-75" style=3D"clear:both"></div></div></=
div><br></div>
</blockquote></div>

--0000000000007daf550649644a1b--


