Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAD0C47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 01:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVLcw-0005Dr-0T; Wed, 31 Jan 2024 20:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rVLct-0005Da-Gd
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 20:12:23 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rVLcq-0006hd-Hi
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 20:12:23 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a358ec50b7cso63899366b.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 17:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1706749924; x=1707354724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0+AC3tjnkjGbPu/GBqlmOT3ENxvAS372s8HBGrR1Po=;
 b=BeJGEuJMHxLykD/6bkdHuzQt0NHaZaljial+ouFj+SBdglbH0e/IhxrxKeqFlbsG4z
 eAZ9hBjTS/0EhQMX3+MwoH8mYvUALrlUOqMzE+ZKqheF2R7DIJUKMoi03DYpAYTlof9U
 t8lhe6USzeetXW43XqKUc0+wpfLZvil2HY9UXu0TsBWuLAuAox65ghOOvVEd2TvVtQfx
 9ZOwt/GBJOKZaZsOxI6SqCV5UOuDVyTIAngIA8BvfhVRz4Yo1PL/yZSscKwPDF+Gz9/k
 sSfIh3P3MerbCijHjJxvBuwluPq1CP4C0wt7Bz6d42mfZUDafm6iJkzEdA4yu0qyOTZT
 jTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706749924; x=1707354724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0+AC3tjnkjGbPu/GBqlmOT3ENxvAS372s8HBGrR1Po=;
 b=BTfoTMY+N4j0atJ8NmnMRK9lIg3a5DDWNmZUuPzmp3zloo+q5az29UNkYKzm+57D5Z
 bATlo0dkgVXWPeUXC7rKKlzLQvTSY3YofGIlV6KJowmhOByDhoJ5kjI9KvmJAzt0xxAe
 EpDJFHIMDZGKIZ1HvRjY9a7lXegQKHEhXLeU6VNHChYk/TRzxCcOsMLkgJgPTJz5df3K
 Knsvl3ZMH02pW1LRXBXFYz0HXCMdR+7siX7xuRLtVl5PS8Hnv7BqPSmIynTJAz7VhsCN
 qxTUTQdhAMCpVldw6mvvMzA2QgdJsbsXnaT5Mh6CgijbScTL7KUEEQHyFmOj9Q0y7r1f
 TIYg==
X-Gm-Message-State: AOJu0Yw8W5TdWvkUqAJykYPh4IDyJs/vLbFYZeLkA62lgsxg7g8xjYSY
 PK4k8o2/MfYZflmpS0PqPN7UuIhZDXJIsQ30x6bl/GPTLGg58F8I6S8ROGoFmE4pfdttwFNpvYm
 wzuqix7YS02EH7LSu+lHSy3RbsXzTX86GArwjgg==
X-Google-Smtp-Source: AGHT+IHEwUQgv3hhH5BF5wC+nTqOPR/EKL/MuE1Zatz9sCvpsSNQ774RhAiPD3+RZFVIZ2l2WAwy8MfHfNk7U0aP1R8=
X-Received: by 2002:a17:906:e28c:b0:a36:4d6c:f85c with SMTP id
 gg12-20020a170906e28c00b00a364d6cf85cmr3170966ejb.16.1706749923868; Wed, 31
 Jan 2024 17:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20240126221943.26628-1-farosas@suse.de>
 <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZbdVhLTLo5udNfeL@x1n> <87jznse211.fsf@suse.de> <ZboS9CPIuxIc9PTf@x1n>
 <8734udljwz.fsf@suse.de>
In-Reply-To: <8734udljwz.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 31 Jan 2024 17:11:52 -0800
Message-ID: <CAAYibXiUg5pkBhQA=QFZ7jgBXRFN81L3bQETFdEnSquyY95hHA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/5] migration/multifd: Prerequisite
 cleanups for ongoing work
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x636.google.com
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

On Wed, Jan 31, 2024 at 5:19=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Peter Xu <peterx@redhat.com> writes:
>
> > On Mon, Jan 29, 2024 at 09:51:06AM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >>
> >> > On Mon, Jan 29, 2024 at 01:41:01AM +0000, Liu, Yuan1 wrote:
> >> >> Because this change has an impact on the previous live migration
> >> >> With IAA Patch, does the submission of the next version needs
> >> >> to be submitted based on this change?
> >> >
> >> > I'd say hold off a little while until we're more certain on the plan=
ned
> >> > interface changes, to avoid you rebase your code back and forth; unl=
ess
> >> > you're pretty confident that this will be the right approach.
> >> >
> >> > I apologize on not having looked at any of the QAT/IAA compression /=
 zero
> >> > detection series posted on the list; I do plan to read them very soo=
n too
> >> > after Fabiano.  So I may not have a complete full picture here yet, =
please
> >> > bare with me.
> >> >
> >> > If this series is trying to provide a base ground for all the effort=
s,
> >> > it'll be great if we can thoroughly discuss here and settle an appro=
ach
> >> > soon that will satisfy everyone.
> >>
> >> Just a summary if it helps:
> >>
> >> For compression work (IAA/QPL, QAT) the discussion is around having a
> >> new "compression acceleration" option that enables the accelerators an=
d
> >> is complementary to the existing zlib compression method. We'd choose
> >> those automatically based on availability and we'd make HW accelerated
> >> compression produce a stream that is compatible with QEMU's zlib strea=
m
> >> so we could migrate between solutions.
> >>
> >> For zero page work and zero page acceleration (DSA), the question is h=
ow
> >> to fit zero page detection into multifd and whether we need a new hook
> >> multifd_ops->zero_page_detect() (or similar) to allow client code to
> >> provide it's own zero page detection methods. My worry here is that
> >> teaching multifd to recognize zero pages is one more coupling to the
> >> "pages" data type. Ideallly we'd find a way to include that operation =
as
> >> a prepare() responsibility and the client code would deal with it.
> >
> > Thanks Fabiano.

Hi Fabiano,

Your current refactoring assumes that compression ops and multifd
socket ops are mutually exclusive. Both of them need to implement the
entire MultiFDMethods interface. I think this works fine for now. Once
we introduce multifd zero page checking and we add a new interface for
that, we are adding a new method zero_page_detect() on the
MultiFDMethods interface. If we do that, zero_page_detect() needs to
be implemented in multifd_socket_ops and it also needs to be
implemented in zlib and zstd. On top of that, if we add an accelerator
to offload zero_page_detect(), that accelerator configuration can
co-exist with compression or socket. That makes things quite
complicated in my opinion.

Can we create an instance of MultiFDMethods at runtime and fill each
method depending on the configuration? If methods are not filled, we
fallback to fill it with the default implementation (like what
socket.c provides) For instance, if zstd is enabled and zero page
checking using CPU, the interface will be filled with all the
functions zstd currently implements and since zstd doesn't implement
zero_page_detect(), we will fallback to fill zero_page_detect() with
the default multifd zero page checking implementation.

> >
> > Since I'm preparing the old series to post for some fundamental cleanup=
s
> > around multifd, and when I'm looking around the code, I noticed that
> > _maybe_ it'll also be eaiser to apply such a series if we can cleanup m=
ore
> > things then move towards a clean base to add more accelerators.
> >
> > I agree many ideas in your this series, but I may address it slightly
> > different (e.g., I want to avoid send(), but you can consider that in t=
he
> > fixed-ram series instead), also it'll be after some other cleanup I pla=
n to
> > give a stab at which is not yet covered in this series.  I hope I can a=
dd
> > your "Co-developed-by" in some of the patches there.  If you haven't sp=
end
> > more time on new version of this series, please wait 1-2 days so I can =
post
> > my thoughts.
>
> Sure, go ahead.
>

