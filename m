Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE41AC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 19:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9gu-0003nT-2X; Thu, 08 Feb 2024 14:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rY9gs-0003nH-5R
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:04:06 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rY9gp-0007Wu-5v
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:04:05 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5611e54a92dso302748a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707419040; x=1708023840; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+yNJxtcDiWuh/CSH68/DxwAc5LA4FKKC3pmjG+yvaI=;
 b=lhPklEv+OGCh6XaP24uk2jU3gGTb1b0ifnNspf8dBUS9cQO34qBE8R22AOteH/d9Wk
 CEzJLFCAQNvElNaFIhVIRuw2cgrckM//8+vu2T7Kd7a5wytM8TNn812ORpvHbNuLwksM
 Fk/jnezHUmBmyGrR+5jl73C04B3zat+sgkD1SxpAvytCBMbL4UiR390LxOEH5dO9beAD
 zChdIRzro1SM3Qme0KXGpo/RQVf1JV0APre9ub6hQdV1rpcsUqmZloM9djHMsk6cSlsg
 wJJKthwUMt0CfodweJhl7FCSpouWl80G17SLxiJH3je32ZsaCOOrByFultq1bGG+CXii
 XNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707419040; x=1708023840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+yNJxtcDiWuh/CSH68/DxwAc5LA4FKKC3pmjG+yvaI=;
 b=Qdgr5LdfwSzNPHd5E4uViWB37KzKhTnhhyYdsaiMSl+qlwPQZ1pcvx1awpnF4IWdi3
 99yWlDx4GwR1/hD6x+uXckUCmvthmOFpqJKY7Anp2+WImLwEuAc1mY0dNdbWDO+kB1Hq
 RktxQbsSiXZ+UEi3AhLGT6GOqPRNr96ODn/fk9IApLrsxYwgYvqfGqCE5bLIeDgZWTjE
 at5/ygI93iXCLtXpp+6sDwCErC1/+3hWd/lXEOHZzn0Hwkk7s+fbIqCvGA6ocMpX/ea8
 s22vb3F5UqgV2W73u/5gypdaNuYtTizLwdM2nS1SIDoV+wWvy0PaIT+tPQyYqEwZNTow
 D0iQ==
X-Gm-Message-State: AOJu0YyFT9sQvC6M23yXUUg/RbRN9D7hLD1d2gUwfachtPOWd2EHKzZM
 ctHTO6eQHhcaD1uhm01slCcP8OofR1qPyRNs0CATssrLyj1K8k8mvU2ZdU9EJIlRt0fi84Iq9Th
 lJTITGrrhUx4NSrtbeqtbOT2LswpBm0EB++30fw==
X-Google-Smtp-Source: AGHT+IFsaRUg6J90o2zZdxMnnLt7RU0lG3p4G55Z3KAojbRhanSFeUMaFc3JUF70KuoJcGRxDo8/8aj32SCrUWIthuI=
X-Received: by 2002:a05:6402:5172:b0:55f:a7d6:fd6a with SMTP id
 d18-20020a056402517200b0055fa7d6fd6amr124288ede.5.1707419040611; Thu, 08 Feb
 2024 11:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-4-hao.xiang@bytedance.com> <ZcMGHeXkV-079vVX@x1n>
In-Reply-To: <ZcMGHeXkV-079vVX@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 8 Feb 2024 11:03:49 -0800
Message-ID: <CAAYibXifj50FiZ_0Le=FesKnTYpdVnD6qci1r0DFjY40H==gcw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/6] migration/multifd: Support for zero
 pages transmission in multifd format.
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 6, 2024 at 8:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 06, 2024 at 11:19:05PM +0000, Hao Xiang wrote:
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 25cbc6dc6b..a20d0ed10e 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -264,6 +264,7 @@ static void multifd_send_fill_packet(MultiFDSendPar=
ams *p)
> >      packet->flags =3D cpu_to_be32(p->flags);
> >      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
> >      packet->normal_pages =3D cpu_to_be32(p->normal_num);
> > +    packet->zero_pages =3D cpu_to_be32(p->zero_num);
>
> This doesn't look right..
>
> If to fill up the zero accounting only, we shouldn't be touching multifd
> packet at all since multifd zero page detection is not yet supported.
>
> We should only reference mig_stats.zero_pages.

p->zero_num will always be 0 because multifd zero page checking is not
yet enabled. The next commit will contain the code to calculate
p->zero_num for each packet. This is just a preparation for the next
commit that enables the feature. Main migration thread zero page goes
through a different format. We are using the same counter
mig_stats.zero_pages to track zero pages for both the legacy zero page
checking and multifd zero page checking. These two are mutually
exclusive so zero page will not be double counted.

Let me know if I am missing something.

>
> >      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
> >      packet->packet_num =3D cpu_to_be64(p->packet_num);
>
> --
> Peter Xu
>

