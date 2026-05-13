Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA0CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDcq-0002EH-9P; Wed, 13 May 2026 13:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wNDcg-0002AI-LR
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:43:55 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wNDcZ-0007X4-RM
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:43:49 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6802f9c5debso5435942a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778694226; cv=none;
 d=google.com; s=arc-20240605;
 b=J8iwHBsB7I62adr7pieQai2HIu826mVnoW1Nj3ZXNzEgeC8RcDrxo5/MYUYIsHD49h
 bnEVKEYLGYydORes1o1gwCDr1AbyaQ6qYMwAU7FuGnkU9oEzMTROBq1J4x9b5kU6bvOH
 +n1W5b5/5H/KQYhsykw95kI/k8Ijq9HxSY2AU5lG/gG6q9yYKGbQ5CacE/ruh5I6byt5
 GEoLQeZ7H7se9qjAWuewwYgfYKEIRwl9AinARCyRnmcgeKmCW0PvZVL/2u6TcdzhrC3X
 Yk2sexwwF/aEMe6b0L8u0fg183I5Aq8FWLRFJcqKu5La/FSr1a4M4s5Yv3SrPGhhYyav
 d5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B1FpkrrPgxFrCF3t5beaO9F2Hk7d0EcP4n4q6RL+BKo=;
 fh=iwTYp09HVB7s9/TTdQBdNKpsO5lfieBH2p3dit72AlM=;
 b=GtU0mnydln0ks42150Jsk+2VVLOxfAZZ19CTDlZm8kPfhOj6YFji6D/Vj4LVQ9lxRy
 R3rOay0lFHpr5zFAQ1K0EKlOiejh55alE2Zz7e1q2yQ76651YPPeTioStm9DxPkqzyvV
 GwXZPgzbyr/R2SPpMneNP9dHiI5AXm2g05d1yI6s2FYgUZ7Yh3JUiHUf9da+X7mkAs/Z
 8/dMj7BMQ4oO+ZCTd7lM0BbUAclX/QJsjau4TZn4BikVKcChkLWlC6ky1JYbFtmBd7O/
 //bRhmgaYqDCtrq/5xh/3icqfP7lCF4gcSfU/HxOCUFXslploKyf5zhsZe1WToAjpVh5
 NUZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778694226; x=1779299026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1FpkrrPgxFrCF3t5beaO9F2Hk7d0EcP4n4q6RL+BKo=;
 b=W2CheazA91Fh+HYPBoZdnnDpJCrQU9td+FPAfNDiHWlDmjdI+NpLjaVLj/1c8MHBNE
 T+Fl876Z0a4OWt4YmrnZ+5Agb8MsYttCNPgY6viIldRw3mTWX/iJGB0AYAXzHMqmEwOC
 FZfaKbUrES5/ZuKLyEAqPWlZkPJymcP+/2NG4CW3uj3uFFAWVM3eIc/NAERGu3BeTLjP
 sWJpYOgRzyFvxPCno1wrY4+h7XrNmn4uAcSKhEv+wgzpYF0Wa9yVgYQtrOU1eSVLHD3w
 4AB1lA6uFO9dWfp7CU85GAwUeauMgb5PpY0lBWE/gFSwGshTL6egB2qk/AX6rzKmRV91
 Ydzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694226; x=1779299026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1FpkrrPgxFrCF3t5beaO9F2Hk7d0EcP4n4q6RL+BKo=;
 b=DYOd3uA0wcUo8Uy2Og9RHGDXQq1RErTtaPCeg4GsXtNAv+fLkxE5D2+BpLQlEKJhkh
 3MR03gc3ty5FwrXd7BMw7WOD02zaNSe61kTSfUJ0arUMLb4hfPxpyIPuY80c9aiGp9Ve
 zibNB+OqNK5/x01zi8Dv2mGvex4VvQCpKTpfabRjOVvDCMQShcOSDpUG0YN2RM2ycr14
 t+aiJgi7cpjsuSZDOiUVsSufpKZfF+9VdoXlXwsg3Y4vHdDMutHBpZ0z/B8knEkoij5l
 E1FE6evQqfi0/mEWmKzgJDWpOSezmiL+KBBC/oYTttwS3mphZ+pyDSA1s9ronezFxp72
 zRWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+17bk0lBC/pHKB6NYW8DHgHwQiZfNTaf+YQYltTTt3D+h0KT1n67V0z5v9HhUd0d5W5ksYeAl+qRFT@nongnu.org
X-Gm-Message-State: AOJu0YxQX/Q+07rPQNfPbmRnTXye6QERRY4dz4qQ+NDZU9+8zdDXjSYh
 /Mhao/V7iIJh5EcvCYFY28jLoPIZydQBz8l+EHEN7Pp0wMT/aNr5XK3hp+9RPaqNqtnanYwiJzb
 wWaiW3Cihe9xU1IdBmSetakzh13N3Wjo=
X-Gm-Gg: Acq92OF0JgqqngEpbLUBY4dKS4hFlwWBvN001boOaTq1bU37ss5ExsWPmixJOnd46f7
 enGVyjK5cOYEa3F65UaMyiNthDQLUAGKcM22wOSls7Fgp2vrPUWMns33LJyfaumK1aNc1dqC6FO
 S5rF6lqkTlPGyHaDTagd7Lh1zkAfKSm/PT9sIU4irclEAVFE3Vkghb6hgU5PCwyTURWKdSN4HA+
 SY0EZL6Ye6FbDkh5c/4axap678WcieeEboGfM117fM5P7WE4fObdKdZgWNUnvT68B1xLZcpCoZq
 /VgGdGAvMox/EOO1a+NDu9HGhk9lOEUuh7DVeKPucw==
X-Received: by 2002:a17:907:6b0e:b0:bcb:a95d:f745 with SMTP id
 a640c23a62f3a-bd3bfa81483mr332123166b.16.1778694225518; Wed, 13 May 2026
 10:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260501144558.24491-1-harshpb@linux.ibm.com>
 <87cxyzp5pq.fsf@pond.sub.org>
In-Reply-To: <87cxyzp5pq.fsf@pond.sub.org>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Wed, 13 May 2026 23:13:30 +0530
X-Gm-Features: AVHnY4LB5uldDtKjBTZgHUcrUH9d_g1jhgH9acr04-JHJZxk8pUToNrnPYKWQMg
Message-ID: <CAEuJdmqJRbfyRGNejZUZYDqz9SeJVi8tEVJhc6iWEy8TR7ANAw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
To: Markus Armbruster <armbru@redhat.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, rathc@linux.ibm.com, milesg@linux.ibm.com,
 Aditya Gupta <adityag@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000079e35a0651b6857f"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000079e35a0651b6857f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May, 2026, 11:12=E2=80=AFpm Markus Armbruster, <armbru@redhat.co=
m> wrote:

> Harsh Prateek Bora <harshpb@linux.ibm.com> writes:
>
> > Also remove the redundant entry for pseries.
> >
> > Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> I'll take this through my tree.  Thanks!
>

Sure, thanks Markus!


>
>

--00000000000079e35a0651b6857f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 13 May, 2026, 11:12=E2=
=80=AFpm Markus Armbruster, &lt;<a href=3D"mailto:armbru@redhat.com">armbru=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Harsh Pr=
ateek Bora &lt;<a href=3D"mailto:harshpb@linux.ibm.com" target=3D"_blank" r=
el=3D"noreferrer">harshpb@linux.ibm.com</a>&gt; writes:<br>
<br>
&gt; Also remove the redundant entry for pseries.<br>
&gt;<br>
&gt; Signed-off-by: Harsh Prateek Bora &lt;<a href=3D"mailto:harshpb@linux.=
ibm.com" target=3D"_blank" rel=3D"noreferrer">harshpb@linux.ibm.com</a>&gt;=
<br>
<br>
I&#39;ll take this through my tree.=C2=A0 Thanks!<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Sure, thanks Markus!</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
</blockquote></div></div></div>

--00000000000079e35a0651b6857f--

