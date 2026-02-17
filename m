Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B69E9A029
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 17:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsPM8-0001BV-9Q; Tue, 17 Feb 2026 12:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsPLz-0001AN-2r
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 12:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsPLw-0003d6-1C
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 12:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771351154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmCbXUisB+VCOP9RCyOlyN3cBE8FW4VLZ7m+nuMbalM=;
 b=SBHJw08bIvNXyuU9xPqOeZ3ROl6DAdt0/6pLrgi8oadaunXQEe3y8pCA8J10dPmu6SGlow
 jDojqY1hwvDg6QxSsT135b/z0OYkxqsmvQWufLyNSCvCYw/y2LiQ5JeIGs2fp/PmCIz/s9
 uR+fM8V86UNNewYqgT5UZlszR0sgTi0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Ut-HV6AFPqevn4lFpb7y1g-1; Tue, 17 Feb 2026 12:59:13 -0500
X-MC-Unique: Ut-HV6AFPqevn4lFpb7y1g-1
X-Mimecast-MFC-AGG-ID: Ut-HV6AFPqevn4lFpb7y1g_1771351153
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64ad4fd4257so6328484d50.3
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 09:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771351153; cv=none;
 d=google.com; s=arc-20240605;
 b=IO++L07ok2py1sHaNSVl5cLUEJZBjJLo6r9OuHaEqVNJad9wU9vBed4qXbsXP5fBCb
 Jeco8srsggfFfprKPTQxLhixS9xjcUR5V3y4dVHjAvJ5OGFbJpt2a4x2Wn8lUFq2b7l3
 Hfo/2i64HpeQSan1TH6rJRjbqQDMHZqGnnDRDOv+Y5LC6ffNfDm84c6BijmlBYfAtQGZ
 ulxZmTDWnprNVoCkjIGRojEWLWHt5A73gfmocFNc9A7VNezm2zTR5axu15YMXLW5c9Sj
 Ud+aMYR0E6bvDoTAe1FFrzeSR2EtPF08c9NgtIVds0v/nlhmaC1Mv3AR6F2+hakyvUrH
 2w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GmCbXUisB+VCOP9RCyOlyN3cBE8FW4VLZ7m+nuMbalM=;
 fh=p5lfs7Bo+kNY/wN1YQ5ZtuhnY5ZpLZUzrFUFWUKlNQw=;
 b=gTKQsjTIpZpU93cMm2jUomv5ox1OP7bw3LEVenOWHrXNEprRKznoAFtjrO68jdhD90
 eL/keM4WSC5H3m/A2dfwX+rpyt3jVPThM9oTKSesa8r+HiJ6X3Dbdm7G+PE8KAHx2dg0
 caGmKhGWN+/i5dIaBTzzp9S+j9Xas2cqChdQxu1rMNfEr3DeDvtZq5dByifhuzKVZRek
 b0iRzGuIyUTZWOvnk9le+b6aU25Oz1hgYlDg8UrYzaQN0aEEoJSZ/yoUXPyYlGyRRV4F
 cpucTuB7y7w72nuKP0pv92rW1DaimUm/8UbKFZF1hIuqR5PFQeKc0G37+WhG0cY+U8ex
 Ycrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771351153; x=1771955953; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmCbXUisB+VCOP9RCyOlyN3cBE8FW4VLZ7m+nuMbalM=;
 b=taJE+4qn7kHqFtkCgG3s+TmuIF0Q13n/x194azWDZFpV3Gv7HNZ5jAVYAMtAZYx7iM
 t2s++t2qOCncIFhUAXrHojox52WWquZPTv4kEjUjtdqq13Q+/T3OEqK3v3T1BqSOsxqA
 D12YaOpJQ8wxzUcecAa4IMV8C+vXUKPxt3JhSidBk1thmOlpoUlAbtibl/2coteUTEDR
 Ct6smP1Yd/H2RgerVoRJswq67Cg/PljgBvrSYveQThqXJ+WgwbLjS61/4MwTnLSXREws
 re2G0XZLIT3Hse5ZZ6HX6bCTGt0Xzl+cpRxKDFx5upxJlJSfmvqyX89N9CpvZgBGYfaL
 3Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771351153; x=1771955953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmCbXUisB+VCOP9RCyOlyN3cBE8FW4VLZ7m+nuMbalM=;
 b=sHG9TIaNFy69BiQ7AqI87cEI9CjsgCfK8u5bBVvAs7eiEz4WzxHXCD0b4eTrMbXGXr
 0EnmsJlQih/Y1B5FPL2j1VZnFDy+X2EvvQfBfwvHVZK+G6K8IgN0XazC88ChTUWckYfI
 /LykmX5IkidgsWT1tP8ZOxior/CoTpG0d+UnUktpPzxuWCQE2Y4A6MCTNV5OwVnamTxv
 M41XFGAWwr5SFkrKIrMemDUDfwxnL0edAVNsaoymksVHdRxphBv4A1I9G4x6UtQt7ITl
 ug+zg06VcJMEm9jtQSyGUkUQkOmexo1tg25TL4tBP/cdd3sTql1HRmniCZ2ZTXGWKr+N
 rvpg==
X-Gm-Message-State: AOJu0Yw/p0+oTFqTIpYIn0EyMCctqYDy8UyT1581a9BB5VDFfqhVMaKf
 bYwI/fQtz8c8zEMkCpCmDay0tJyOXq0JrOWfs12q9wfEogBCtljXSJszkdyMdoopbHwZ7U5qIjG
 d2Qo7ykg7N8mEk/xEkhePZFth9cape3LYcJj7ljsHkD8D0iLSdfwLiANsQqDktHAI6QNpdXptLY
 OsNXG4Q2QdQg5KxWuSqVjKFNr05coDvlw=
X-Gm-Gg: AZuq6aLD4eA7dKFNGcxLAcHcCmeQpMH8LlmpXuFgbSsRyRDNMCKRoVnu8zVnwkSClaf
 ygt7+Qg8tFzTK+N9L+ZfVq33aLBu27GWAMpBNSLKsQlbnCYXO/RW9BKxjKRAKGoRdr8SY7MfUm9
 cSikJz2YdM3KWHE8haB0SUTRk0AmWrPQIeW3JoPZDrnSTxn9LR4WiTGf8GCIUW9id9+uQ7w/q0S
 rzxwhRmee+4GIudulGGah3r9gduIuVYgP28KA==
X-Received: by 2002:a53:c407:0:b0:64a:dafd:2102 with SMTP id
 956f58d0204a3-64c14ac48famr8630436d50.19.1771351152578; 
 Tue, 17 Feb 2026 09:59:12 -0800 (PST)
X-Received: by 2002:a53:c407:0:b0:64a:dafd:2102 with SMTP id
 956f58d0204a3-64c14ac48famr8630427d50.19.1771351152133; Tue, 17 Feb 2026
 09:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20260216212952.420120-1-jsnow@redhat.com>
 <20260216212952.420120-16-jsnow@redhat.com>
 <b2cfb40c-95e2-4c1a-87c2-7266c7ddfe3d@redhat.com>
In-Reply-To: <b2cfb40c-95e2-4c1a-87c2-7266c7ddfe3d@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Feb 2026 12:59:01 -0500
X-Gm-Features: AaiRm51TA3TUr3HT7aEd1PkwgtHt4fpH_9whWpYfzMhORmcYyFpL2139CtIuMYY
Message-ID: <CAFn=p-Ye9nX5pA61NErV5fWWZRLbmZF7AXvMoD_N8BLP=3TMvg@mail.gmail.com>
Subject: Re: [PATCH v7 15/19] tests: replace check-venv with vm-venv target
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Yonggang Luo <luoyonggang@gmail.com>, 
 Warner Losh <imp@bsdimp.com>, Maksim Davydov <davydov-max@yandex-team.ru>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Michael Roth <michael.roth@amd.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 17, 2026 at 12:52=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 16/02/2026 22.29, John Snow wrote:
> > With the qemu.qmp and qemu.machine dependencies now installed by defaul=
t
> > at configure time and additional dependencies required by functional
> > testing installed on demand, we do not need the explicit "check-venv" t=
arget.
> >
> > ...However, to facilitate running VM tests without running configure, w=
e
> > move some of the former logic into tests/vm/Makefile.include to create =
a
> > new venv (vm-venv) on-demand when running VM tests from the source tree=
.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   tests/Makefile.include    | 22 ++--------------------
> >   tests/vm/Makefile.include | 18 ++++++++++++++----
> >   2 files changed, 16 insertions(+), 24 deletions(-)
>
> Maybe consider adding "vm-venv" to the .gitignore file now?

I wasn't sure. Leaving it un-ignored at least calls attention to it if
you want to delete it. Can you run "make clean" on a bare repo you
haven't run configure on? If so, I could have make clean delete that
venv and then also add it to the ignore files.

I could also just instantiate the venv in ~/.cache/qemu/vm-venv
alongside the other VM temporary files.... thoughts?

>
> Anyway,
> Tested-by: Thomas Huth <thuth@redhat.com>
>


